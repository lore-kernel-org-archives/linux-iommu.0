Received: from sg-1-12.ptr.blmpb.com (sg-1-12.ptr.blmpb.com [118.26.132.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381E92DF3FD
	for <iommu@lists.linux.dev>; Wed, 20 Aug 2025 09:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755681838; cv=none; b=GIwBCfO6AkBqQ6lJVET/+rGXbxnC7OEct4UQqRbItZf81RNs+oIcjyKBhXLR1M3OwOgZ+6cEkIPnVA4YdpzuVc6j7zejme2RzA6jEtAchuKwHBGqiHGGeQ+VCfvHE84Nt7qrEKlqy4ylxP/mYMGfV6ZKC36UDniHIjvC03sv2BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755681838; c=relaxed/simple;
	bh=BgVYMUDchAWudzWUKpedFO6xiS7BV3++GzlHR+tYfHc=;
	h=In-Reply-To:To:Cc:Mime-Version:From:References:Subject:
	 Content-Type:Date:Message-Id; b=oKlyuBWXfaryZQGQZJbyqMs0BWPq+ri8g2wzJL+scZ46AGJMZR9ARabF0NLKWVZrc+oH6X11Ww+rUYQ3Ad/H0UeTQajElXKRZuq8cci5DC8JHtPhe/V7ShauP/EtCr7foHHpvnF1dQPlr8iENeT7HIDoDrL/ZW2e7/bn/lqWiYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com; spf=pass smtp.mailfrom=lanxincomputing.com; dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b=z3mXtNiU; arc=none smtp.client-ip=118.26.132.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b="z3mXtNiU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1755681700;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=26u28Ud/7i5hcKzRJDyQdYOfPIqHtE24mfxQ8LptvT8=;
 b=z3mXtNiUkxhHMDXpKd4Pg82xb9xvoc9gx/rM6ReuznEKIkf/7rgN03rLn2kFVs8JmIuMf+
 qm/2KlX7m5DanWNPsMx+ZXF0Q/uWziYp3xDY9BRvVyO7MaVd5VkBo1EC3bAIg98Z3sHens
 45+Y2HyGw+BsKpY9QpY0r3psl+2y9/mK02DsLND1MnEiXmWY89BIA126QJOuEcz1ZXB/up
 sE1F7Owxvr5fIfR0o2hrUD1WW6Th4IRPMVFoeQOU0JtBWsOfNMJWwwK9/fGwfdlongCQEn
 gHMoBdvuMNQvLYhOMV0N/gYdDghQxGgppXMHa1gvf0oXJDl51ALBhIM5Rwq5lQ==
In-Reply-To: <568d8b25-8cb5-48f8-850e-0298e3fc456a@web.de>
X-Mailer: git-send-email 2.34.1
To: <markus.elfring@web.de>
Cc: <alex@ghiti.fr>, <aou@eecs.berkeley.edu>, 
	<huangxianliang@lanxincomputing.com>, <iommu@lists.linux.dev>, 
	<joro@8bytes.org>, <linux-kernel@vger.kernel.org>, 
	<linux-riscv@lists.infradead.org>, <palmer@dabbelt.com>, 
	<paul.walmsley@sifive.com>, <robin.murphy@arm.com>, 
	<tjeznach@rivosinc.com>, <will@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
From: "XianLiang Huang" <huangxianliang@lanxincomputing.com>
References: <568d8b25-8cb5-48f8-850e-0298e3fc456a@web.de>
Subject: Re: [PATCH v4] iommu/riscv: prevent NULL deref in iova_to_phys
X-Lms-Return-Path: <lba+268a5939e+5133b2+lists.linux.dev+huangxianliang@lanxincomputing.com>
Content-Transfer-Encoding: quoted-printable
X-Original-From: XianLiang Huang <huangxianliang@lanxincomputing.com>
Content-Type: text/plain; charset=UTF-8
Date: Wed, 20 Aug 2025 17:21:28 +0800
Message-Id: <20250820092128.8069-1-huangxianliang@lanxincomputing.com>
Received: from LeonHXL.localdomain ([116.237.111.137]) by smtp.feishu.cn with ESMTPS; Wed, 20 Aug 2025 17:21:34 +0800

https://lore.kernel.org/lkml/feb46658-5a3a-4403-b407-500566280eb3@web.de/

I updated the patch in v3, and updated change description accordingly:

In v1
> -	if (_io_pte_none(*ptr) || !_io_pte_present(*ptr))
> +	if (!ptr || _io_pte_none(*ptr) || !_io_pte_present(*ptr))

In v3
> -	if (_io_pte_none(*ptr) || !_io_pte_present(*ptr))
> +	if (!ptr)

but put your proposal at the patch Subject...
  v1: check pte null pointer before use
  v3: prevent NULL deref in iova_to_phys

> =E2=80=A6> ---
> > Changes
> > v4:
> > - Change the summary as Markus recommends
> >=20
> > v3:
sorry for making this messy.

Regards,
Xianliang
