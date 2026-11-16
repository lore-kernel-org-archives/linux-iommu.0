Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794847975;
	b=cX/JUTis9ZIrR7dl1GUbK1nhYJeukGmUHShlBld1lfm6DhRK5Dg7QG7bTXvu5IMcTKtO
	 mmL7T2JlZGgbS3kXkGG8EOcchUMCkyfWkDcAYcC7sX7sL4Oops7S1LoNK0Bsl6/NWYmSP
	 zXd2Yehu55+EdLxeb21JX7hPNOn7O9bRUBvXy0T5XsAOFGcGGfJyYJwnQUmEUkPX7vbO0
	 egoELVITFyZLHuYEqGZJtRKKbBba4ipUFkVJU4GAIzcsTEWGLIueunoOkOiSqb6p85iFU
	 lyYhbGKvgBAQ0J6Nr6TtBbwJPX3rWlf0BycfY7k3GWdvU06VfscmZPX0Aeeu67yNhWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794847975;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 Content-Language:From:In-Reply-To:Content-Transfer-Encoding:
	 X-CMS-MailID:X-Msg-Generator:Content-Type:X-RootMTR:X-EPHeader:
	 X-CMS-RootMailID:References;
	bh=Smc0gMBRwPu08NMTSnxmcCTbW8wrWmeKfSk73vRDWjU=;
	b=xn7ko8SWMDJWozBaCyrcSfpNw2gysnfKI2apsX1+hPw9tE6bHYLoe7Jq7wanL0j8sGmj
	 DEXt76eLjRR4CvbEWf9M/pXC1VaA/JV5pmDNaTcKewsmyoa8SGVDBzIYQ1El5rYG8Hych
	 sjKihYIZ0hNqMo5zoVyui1LnIVEjMVbe9AffAODH4Qk0SHMiXYPfaYyZpU3gUbp3R4HXX
	 Xjm1Vx2QgU4xaQSJD8xHYVkV2Usne6FG6WOPPpithYv+eYtgJBuZWQVomKrNNC6irlomS
	 F11YlJP27L7QzGL6oQcciXsaptnKLXG7ADTTZbxPkeUegXkAgC+38hw9ztL0y25YvQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=XulqDGxu;
	arc=none smtp.remote-ip=210.118.77.12
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C607606A330
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 16:52:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C607606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=XulqDGxu
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20261116165252euoutp02d628858f80d360da9bdc4bf6817b1b26~olLi5Piwh0321203212euoutp02k
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 16:52:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20261116165252euoutp02d628858f80d360da9bdc4bf6817b1b26~olLi5Piwh0321203212euoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1794847972;
	bh=Smc0gMBRwPu08NMTSnxmcCTbW8wrWmeKfSk73vRDWjU=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=XulqDGxuJ5KdChiLrv/R3OsIYQ11Q3DaeAgdtQ2j3//enayW4UMp5wiPRnftMHCkU
	 r/T6isrgbt1wF+xUlef0jmdVJjCY0vXCq8iCVytv43K0E/FeNG91LxJUt96ejHs24l
	 Us/56K542yJNPCsfAEwWO09Zz0d/Izg5pv+I/Fp4=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261116165251eucas1p1db6298f4a9abc1e6bb1f1abcaad02087~olLiStq8r1473314733eucas1p1t;
	Mon, 16 Nov 2026 16:52:51 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261116165251eusmtip1bbdebdad9852ade456a13312d672efd1~olLh0XAfs1449614496eusmtip1o;
	Mon, 16 Nov 2026 16:52:51 +0000 (GMT)
Message-ID: <9c6decdd-c3d1-42f7-aa37-089291c73085@samsung.com>
Date: Mon, 16 Nov 2026 17:52:51 +0100
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] dma-mapping: fix stale path to dma_map_benchmark in
 Kconfig
To: Zenghui Yu <zenghui.yu@linux.dev>, iommu@lists.linux.dev
Cc: robin.murphy@arm.com, baohua@kernel.org, xiaqinxin@huawei.com
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20261116161152.43462-1-zenghui.yu@linux.dev>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20261116165251eucas1p1db6298f4a9abc1e6bb1f1abcaad02087
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261116161206eucas1p2dfa2fe81737f4a6ab026837cb8c32b05
X-EPHeader: CA
X-CMS-RootMailID: 20261116161206eucas1p2dfa2fe81737f4a6ab026837cb8c32b05
References: <CGME20261116161206eucas1p2dfa2fe81737f4a6ab026837cb8c32b05@eucas1p2.samsung.com>
	<20261116161152.43462-1-zenghui.yu@linux.dev>

On 16.11.2026 17:11, Zenghui Yu wrote:
> The dma_map_benchmark test was moved from tools/testing/selftests/dma/ to
> tools/dma/ in commit f74ee32963f1 ("tools/dma: move dma_map_benchmark from
> selftests to tools/dma"), but the DMA_MAP_BENCHMARK help text still refers
> to the old path. Update it.
>
> Signed-off-by: Zenghui Yu <zenghui.yu@linux.dev>

Applied to dma-mapping-for-next, thanks!

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

