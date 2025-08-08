Received: from sg-3-14.ptr.tlmpb.com (sg-3-14.ptr.tlmpb.com [101.45.255.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0847367
	for <iommu@lists.linux.dev>; Fri,  8 Aug 2025 02:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.45.255.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754620960; cv=none; b=npv/4wdivyqWOMi3Jbcd5+4ense0XTBEkb5Vyglyh4GW/55QvjEQNKXP3j+BmBqOeOA+RnBlCIbBrHDRl0lA14qOeGEHI+jZdJkwKK/IYbMBoiVbChAH4xzLuXjm8WgImRghIIN28nxrmI9QbGbM41ZPHAzKwXykOfE5S10HcAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754620960; c=relaxed/simple;
	bh=07ONC8WlXPk8jptQtuzE5Qmo9lm76KsnOsxW1x29sbg=;
	h=Message-Id:References:Content-Type:To:Subject:From:Date:Cc:
	 Mime-Version:In-Reply-To; b=lIVbkQN3y+pBDpgRf4EWhD4lfxU+5ZbKKraxy9BlfmeBVlaniogVKX4GDh5UXokGjCtNdDoYger8J0LWr0OuwTeD7ji+H3QO+jl54dWKrGAlqHDI9w5x89nte1Rjas2mxYtorEuJvN/e1HEsUppIFTbkYgLfTG7e1Csdm3dwLa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com; spf=pass smtp.mailfrom=lanxincomputing.com; dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b=fghKz6D5; arc=none smtp.client-ip=101.45.255.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b="fghKz6D5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1754620938;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=07ONC8WlXPk8jptQtuzE5Qmo9lm76KsnOsxW1x29sbg=;
 b=fghKz6D5f8uxOEZnZUWsXleorTqETF/thXjUiMvIqIpLC3l9kB64+slU7AWGMFx8iHOTn0
 zJ2nZC9oj6hpujGu3NRulUJhUclyHy3BD4DvdpiGPPKAkyck67vA4+34AXZECVzhTDOXi9
 mBsoxoiOycQdGeYFObju+bq8FuC8XE6Oje99k+3yeTNsojrGK4K6LwxKC4yGZfN9ETMnZB
 ySuZbtIdHjXJYi27nhe3Xi+Kx+OInPTkitBDFQEiG1iSMR+K2TTInpJnHy4r8MQxnMiCx4
 XVWw6hIIGCuxvFISJd6dFFxKpf9zkomizt5rjqbk7xQHplMonMpIUPWlNuAuAA==
Message-Id: <20250808024203.16672-1-huangxianliang@lanxincomputing.com>
References: <effb29be-6d14-47e5-ab71-454119467750@web.de>
X-Lms-Return-Path: <lba+268956408+05b8b1+lists.linux.dev+huangxianliang@lanxincomputing.com>
Content-Type: text/plain; charset=UTF-8
To: <markus.elfring@web.de>
Subject: Re: Re: [PATCH v?] iommu/riscv: check pte null pointer before use
Content-Transfer-Encoding: 7bit
X-Mailer: git-send-email 2.34.1
From: "XianLiang Huang" <huangxianliang@lanxincomputing.com>
Date: Fri,  8 Aug 2025 10:42:03 +0800
X-Original-From: XianLiang Huang <huangxianliang@lanxincomputing.com>
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
In-Reply-To: <effb29be-6d14-47e5-ab71-454119467750@web.de>
Received: from LeonHXL.localdomain ([116.237.111.137]) by smtp.feishu.cn with ESMTPS; Fri, 08 Aug 2025 10:42:15 +0800

Sure, 'prevent' is much appropriate than 'check' here...

Prevent null pointer dereference in riscv_iommu_iova_to_phys(). Now, when
it's called with an unmapped iova, the kernel will not crash here.
