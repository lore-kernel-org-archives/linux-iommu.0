Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3B343B3EE
	for <iommu@lists.linux.dev>; Mon,  7 Sep 2026 19:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788808997; cv=none; b=rg9uMSZJ8S2I9HXG3GTI4qbkcurRYyMPNGWGlUShoxW/kqHnPX9apyJdZYXGlPZz/QL5I03GWct9xHj1Tqf9404aPrgwLm42VNyRfchgtxc4VL35nMVFlQLn/ss9q0cX00SKG3dV0sFZykzkdJvzNXveklLW+PrIenyXZDqppt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788808997; c=relaxed/simple;
	bh=S4T0FZSMdTfAppociCja5WyOZZaS02u5NUotJcfaPeI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tuutz3lRRHGrsPJ99nxqrIhWmZJ5t9Uc8Yysc7bXhKBrmiWrh1CHbuz9+jWN1iE4OLm/2RHwfHIsHHmw7cDxsUKHqmBeYym/jc+yxLt4rAzGnyUh6j369+DzMGBa2yb+PIV/bL+SuzMpWXyli/nOd42oJu8/BsjdScZeZbh2bHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tju.edu.cn; spf=pass smtp.mailfrom=tju.edu.cn; dkim=pass (1024-bit key) header.d=tju.edu.cn header.i=@tju.edu.cn header.b=WQAlRuNW; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tju.edu.cn header.i=@tju.edu.cn header.b="WQAlRuNW"
Received: from tju.edu.cn (gy-adaptive-ssl-proxy-2-entmail-virt205.gy.ntes [183.242.150.9])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4cdbe2250;
	Tue, 8 Sep 2026 03:23:08 +0800 (GMT+08:00)
From: Yibo Tan <lhfff@tju.edu.cn>
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] iommu/vsi: Fix use-after-free during module unload
Date: Tue,  8 Sep 2026 03:22:56 +0800
Message-Id: <20260907192256.701438-1-lhfff@tju.edu.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <aa503065-cd97-47cd-894c-bd660e59f5f9@collabora.com>
References: <aa503065-cd97-47cd-894c-bd660e59f5f9@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa07d5304c003a1kunm198d70b3ed69c
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCS05PVhlCSh1JSkpJSBlPHlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKQ0hVSU9JVUpOS1VCWVdZFhoPEhUdFFlBWU9LSFVCQklOS1
	VKS0tVSkJLQlkG
DKIM-Signature: a=rsa-sha256;
	b=WQAlRuNWMjG0VhTe2utlMWMVQTbEP6YxCZE2IxYt/knoznc09nqd8nNFk1b7ZRSEqVXJ9YW06inS6X2+rsAgQzO+mMfkuaGr0p8Ifam6KBJDF0tc5PPsVCEZzhQvqlwYB+cdx1bEYVt+WqJk7beSkuJRsAdR64obQZ7nWXbRaYk=; c=relaxed/relaxed; s=default; d=tju.edu.cn; v=1;
	bh=S4T0FZSMdTfAppociCja5WyOZZaS02u5NUotJcfaPeI=;
	h=date:mime-version:subject:message-id:from;

Thanks for the review.

I agree that devm_free_irq() is unnecessary and have removed it. The
same KASAN A/B test still passes: the unmodified driver reports two
use-after-free accesses, while the revised driver removes the IOMMU
registration and completes the later device registration without KASAN
or other diagnostics.

For v2, I propose keeping the bug fix local so it remains small,
independently testable and suitable for stable backporting. The remove
callback revokes the non-managed IOMMU and sysfs registrations and
balances the clock preparation, while leaving the managed IRQ to
devres.

Reusable managed helpers for the IOMMU registrations and clock
preparation could then be developed and reviewed as a separate series,
without making this UAF fix depend on a cross-subsystem API change.

Regards,
Yibo
