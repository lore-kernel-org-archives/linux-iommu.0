Received: from sg-1-19.ptr.blmpb.com (sg-1-19.ptr.blmpb.com [118.26.132.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06E1EAF9
	for <iommu@lists.linux.dev>; Wed,  6 Aug 2025 10:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754475236; cv=none; b=l1+wFLVLYXrY5GNxlzGEpMC+isu0oZ085iRpEQktQAk7K6pXfO1OrAfQ4dnwgRmgkMaXUmEMMUDPWmyVi4DfDyidaryzUK2UZU1IYi30J1EoqJqvG0ahfVW2smsUKDfx2/wA5p9JHevOeOEOVpFz+I5llGIhWkxkNUdAufCyDI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754475236; c=relaxed/simple;
	bh=N6l+1yHhMqXCPPSV577+GHyz1ZJez474BAHAo4bn/W0=;
	h=Subject:From:Date:Message-Id:In-Reply-To:References:To:
	 Mime-Version:Content-Type:Cc; b=XV65fkR79EgcHK3I1KlqZ8i1kH9fg+flN2YgC8Jgw4Q0UXFqsbzDUWxs0qNlmuGLlWZBBVcKUF+etOY9XNnbHSesFQAoLPc+tAKtvYi4q7BcRuIJ97HcxpDSjCqoBQ3FbfFytBS6RMJk/g345FCykWRQGFQrDjx5DLXvjfDFcJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com; spf=pass smtp.mailfrom=lanxincomputing.com; dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b=PBnTemmG; arc=none smtp.client-ip=118.26.132.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b="PBnTemmG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1754475226;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=N6l+1yHhMqXCPPSV577+GHyz1ZJez474BAHAo4bn/W0=;
 b=PBnTemmGDtL8WKUAg4buc23CSkgO2ucFQD5y3zZ2aM+7kiOoyfsiKt5TuyfEfbmRsH9r3V
 M4/rV30WLymf1TX1b1z7A/kB9vN+hCX4e1w4+EJo2Rsp1c5udE7h6KWW9xkw84QbIUOwre
 YDY5g13myROwr+OLymIqYWp7YG0iLzEJql/ckASP+hmQyMcj8z0EDUyPSSbrEveYrZm0cV
 ouovMlgCksGzDUsVpG9E0WmoKfHxHiQB2AmMx+VrnZozTPkUDO2omfcjBOSNtcKqyGxAE4
 7OGhdRAzmioLO9NhRNqe9Iqtsb/T/J7AFAC1bmiBRDDi8m32m/1OegA0DudRwA==
Content-Transfer-Encoding: 7bit
Subject: Re: Re: [PATCH] iommu/riscv: check pte null pointer before use
From: "XianLiang Huang" <huangxianliang@lanxincomputing.com>
Date: Wed,  6 Aug 2025 18:13:37 +0800
Message-Id: <20250806101337.3350-1-huangxianliang@lanxincomputing.com>
In-Reply-To: <1f419739-4233-474d-b00a-4e1237352691@web.de>
References: <1f419739-4233-474d-b00a-4e1237352691@web.de>
To: <markus.elfring@web.de>
X-Mailer: git-send-email 2.34.1
Received: from LeonHXL.localdomain ([116.237.111.137]) by smtp.feishu.cn with ESMTPS; Wed, 06 Aug 2025 18:13:44 +0800
X-Lms-Return-Path: <lba+268932ad8+ca2970+lists.linux.dev+huangxianliang@lanxincomputing.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Original-From: XianLiang Huang <huangxianliang@lanxincomputing.com>
Content-Type: text/plain; charset=UTF-8
Cc: <alex@ghiti.fr>, <aou@eecs.berkeley.edu>, 
	<huangxianliang@lanxincomputing.com>, <iommu@lists.linux.dev>, 
	<joro@8bytes.org>, <linux-kernel@vger.kernel.org>, 
	<linux-riscv@lists.infradead.org>, <palmer@dabbelt.com>, 
	<paul.walmsley@sifive.com>, <robin.murphy@arm.com>, 
	<tjeznach@rivosinc.com>, <will@kernel.org>

Sure, will change to "Check the pointer before..." in a new version, thanks.

Regards,
XianLiang
