Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279D413B59A
	for <iommu@lists.linux.dev>; Sun,  8 Dec 2024 13:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733666175; cv=none; b=Wm8iLddIlUJZQfh4jsl3IJW+Cgc3Thn3RGT7ackZH1BR4cVJJp6SZIy0gb4IBZALmdhSJJjRcxcW2NUjAWIT3mOHC3VILApBTLnof6Ivn1MUVhOVXCmioRnOe+pVg9Mgjsq4aduvgaOt+DZ9RaM2U9gDAa2TPGzRtngwNiygbDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733666175; c=relaxed/simple;
	bh=FBDWUj0OGGwVtelrV5MSIm2IZ8rpdHIv+zi5tYtb2mM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JIUPMI8Pm3dMeK0xH03W/DeawIBi2PV4XD3Nj48RMpiWxY/tyIrGNlhNT30CJ/E6zAbj4vwRQMNDj+MOP5u1wwfy+c/XaQUKyvwO4Mz9Ee6fySPocpuFCn2NDDtcCbN+HdnR3osxGPYuuGakom/DcOK/wrRMxNX+ZEXdhioI2vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=Aurap/aV; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="Aurap/aV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=FBDWU
	j0OGGwVtelrV5MSIm2IZ8rpdHIv+zi5tYtb2mM=; b=Aurap/aVLCWunKEb7mBP8
	pp857jSAL3GYtJlsKSJWQWn6iADiVzmYlfqJTdT2BFyGBsyBPdP7nQ0OAG0MZMUp
	00bK2SOvoXeWmx9lIaW8Mh7QbOflYnaC0STtrDBnidkMKyhh52jsc07oVWsCFqZp
	PH9t2a5wV2FX5YziHmYph8=
Received: from nilq-virtual-machine.. (unknown [60.24.211.0])
	by gzsmtp1 (Coremail) with SMTP id pSkvCgDnz7ykoVVnXP4ICQ--.13915S2;
	Sun, 08 Dec 2024 21:39:49 +0800 (CST)
From: niliqiang <ni_liqiang@126.com>
To: will@kernel.org,
	robin.murphy@arm.com,
	joro@8bytes.org
Cc: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	li.zhichao@zte.com.cn,
	ma.weichao@zte.com.cn,
	ni.liqiang@zte.com.cn,
	ni_liqiang@126.com
Subject: Re: [PATCH] drivers/iommu: Protect STE base address in multi-core and  multi-process concurrent scenarios
Date: Sun,  8 Dec 2024 21:39:47 +0800
Message-Id: <20241208133947.20871-1-ni_liqiang@126.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241111142800.63760-1-ni_liqiang@126.com>
References: <20241111142800.63760-1-ni_liqiang@126.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:pSkvCgDnz7ykoVVnXP4ICQ--.13915S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU1GQDUUUUU
X-CM-SenderInfo: xqlbzxxtld0wa6rslhhfrp/1tbiYBOu5WdUy9sPRgACsQ

I found that the email sent by git send-email command was partially
successful, so please allow me to reply to the previous patch.

I look forward to the reply from experts. Thank you.

