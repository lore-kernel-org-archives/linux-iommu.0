Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A021DE891
	for <iommu@lists.linux.dev>; Wed,  9 Apr 2025 15:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744212603; cv=none; b=AUz58PPTz4yL9BP+9uifIACKRaw+1AzIY9Km+maRb9zi/483Nnb/vJ+SHxPQdaxn0kwycO9vz58rjTC+6RQ+GcKoF45UY4ExQJpHPUZ7J5E5+5fC2olWVeV33V7zK/Zuk95BKmTZ9HjeQhxR4MbDJ+JmN8ME4dWpzngheIq8k+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744212603; c=relaxed/simple;
	bh=7ammzMgtsA5awXQq4UPk8mbvXIdjRXw5ww7TtoQg/L4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=l/6X/CxcsBj1KfqCiBSbYAYKoYJPsep9hKwogniF5+f2/XLjsSbcaTbBBOCpzCXuSgWfNnKppdcOM9+Pu3Wo3nR9zDlgD5MktLta4kz1lOEURmC2ZKaPiU+gaW2esqj7NqqPsWx5LgxYa3GR1bawHred4dvpzjOmKD3bDUJCRpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=vSfbzYsw; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="vSfbzYsw"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250409152958euoutp0267832788c34bcacbef00fc4da76b4a83~0sB35wBs30319103191euoutp02c
	for <iommu@lists.linux.dev>; Wed,  9 Apr 2025 15:29:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250409152958euoutp0267832788c34bcacbef00fc4da76b4a83~0sB35wBs30319103191euoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1744212598;
	bh=ul03oSv4pyZS+HSpbQ9I5MY9es9yGM9SGJkg+qohyNs=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=vSfbzYswfp8l1tx9lhcgpbjc+7l6PpAOUa79990tWvNoiDDzxaoWY9KDg4sGQQi1q
	 ycYpaHTZx7+MPwdK1JXs+/HHGaP5r9uYglUMQzm7DCaic1gSVtKkBprYG+O59PCpaA
	 sWV020oNcyliWRtOq1ATaDY1mySnKbmN5NHLy6H0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20250409152958eucas1p2a824e7ff30453a67b524a18556764d17~0sB3s3A7q0925809258eucas1p2Z;
	Wed,  9 Apr 2025 15:29:58 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id AB.07.20409.67296F76; Wed,  9
	Apr 2025 16:29:58 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250409152957eucas1p27f59b1452aa3e9b3aa0b2cc98c5a99fc~0sB3WYg7e0956309563eucas1p2D;
	Wed,  9 Apr 2025 15:29:57 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250409152957eusmtrp1f75476af527f9f945de78d01ff4c9049~0sB3V01k11007810078eusmtrp1-;
	Wed,  9 Apr 2025 15:29:57 +0000 (GMT)
X-AuditID: cbfec7f4-c0df970000004fb9-4b-67f69276a3fb
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id D1.77.19654.57296F76; Wed,  9
	Apr 2025 16:29:57 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250409152956eusmtip1c210070b9e71c88426ba2634c970e62c~0sB2Wubt70379603796eusmtip1R;
	Wed,  9 Apr 2025 15:29:56 +0000 (GMT)
Message-ID: <208140cb-dc22-4e7d-9f1f-7d5ed30d16dc@samsung.com>
Date: Wed, 9 Apr 2025 17:29:55 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [v4] dma/contiguous: avoid warning about unused
 size_bytes
To: Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Robin Murphy <robin.murphy@arm.com>,
	Michal Nazarewicz <mina86@mina86.com>, Kyungmin Park
	<kyungmin.park@samsung.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20250409151557.3890443-1-arnd@kernel.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRmVeSWpSXmKPExsWy7djP87plk76lG3zdzmnxd9IxdottWzax
	Wvz6YmFxtukNu8XlXXPYLBYcb2G1OPjhCasDu8eaeWsYPX7/msTosWlVJ5vHi80zGT3W/XnF
	5NG3ZRWjx+dNcgHsUVw2Kak5mWWpRfp2CVwZb27tYS44w10x7/Jm1gbG/ZxdjJwcEgImEo8+
	nGHsYuTiEBJYwSix6theNgjnC6PE/NkvmCGcz4wSu39cYIJpmTfvLytEYjmjxI8NX1kgnI+M
	EvdW9bKAVPEK2El8aLsE1sEioCLRt/4RG0RcUOLkzCdgNaIC8hL3b81g72Lk4BAWCJR4e40D
	JCwioCxx/dscsJuYBS4zSkx5NQFsDrOAuMStJ/PBbDYBQ4mut11gMzkFzCU+HHrLAlEjL7H9
	7RywsyUEPnBIHO3eyA5xtovE4f0XoGxhiVfHt0DZMhKnJ/ewQDS0M0os+H2fCcKZwCjR8PwW
	I0SVtcSdc7/YQE5lFtCUWL9LHyLsKPF11l5WkLCEAJ/EjbeCEEfwSUzaNp0ZIswr0dEmBFGt
	JjHr+Dq4tQcvXGKewKg0CylYZiF5cxaSd2Yh7F3AyLKKUTy1tDg3PbXYKC+1XK84Mbe4NC9d
	Lzk/dxMjMDGd/nf8yw7G5a8+6h1iZOJgPMQowcGsJMI7Ie9buhBvSmJlVWpRfnxRaU5q8SFG
	aQ4WJXHeRftb04UE0hNLUrNTUwtSi2CyTBycUg1MM9ed+twcYmK+yk/Vf8WCT3IzHzgHmB9Q
	18h3C76udpbnrNOW1WIhvlv/bD++SrPvR/jctWqfP5maTPGqn52Z3lTgobrMc0GXjEfD7VCH
	rBsqOtcu8GzP3CJ54fkxHx899lP/U1KsJ5f5aPDdtso2PPHxrVVUqWGB6Nflk9YkZ2/Y3mGy
	m/noy2lhnv2v70QHbD8347zks+rSGYaRM1S8jcN8V7/xl3RymsYoKtHD0PGYPyhzvYVB260v
	igXzdvk5xL6Qf3Kq7JheYLPn/c6Y2dye4u3OAlcf5Hr1JXUe0f5Zzzpvrymjethb0wMcXGsj
	0mTlv146+ir97JtL9/JlGsovLWKoS7WZKDtvqZoSS3FGoqEWc1FxIgA1lrgzuwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsVy+t/xu7qlk76lG7SsN7b4O+kYu8W2LZtY
	LX59sbA42/SG3eLyrjlsFguOt7BaHPzwhNWB3WPNvDWMHr9/TWL02LSqk83jxeaZjB7r/rxi
	8ujbsorR4/MmuQD2KD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSc
	zLLUIn27BL2MN7f2MBec4a6Yd3kzawPjfs4uRk4OCQETiXnz/rJ2MXJxCAksZZTYPnk+C0RC
	RuLktAZWCFtY4s+1LjaIoveMEme2zWEGSfAK2El8aLvEBGKzCKhI9K1/xAYRF5Q4OfMJ2CBR
	AXmJ+7dmsHcxcnAICwRKvL3GARIWEVCWuP5tDiPITGaBy4wSjRNeMkMs6GKU6H27HWwzs4C4
	xK0n88EWsAkYSnS97QJbwClgLvHh0FsWiBozia6tXYwQtrzE9rdzmCcwCs1CcscsJKNmIWmZ
	haRlASPLKkaR1NLi3PTcYiO94sTc4tK8dL3k/NxNjMBI3Hbs55YdjCtffdQ7xMjEwXiIUYKD
	WUmEd0Let3Qh3pTEyqrUovz4otKc1OJDjKbAwJjILCWanA9MBXkl8YZmBqaGJmaWBqaWZsZK
	4rxsV86nCQmkJ5akZqemFqQWwfQxcXBKNTAp56u1PnToOCs85ZVf7d1374QYVaqOfxfy/mu4
	6L327qaFh2KYHk/zmlAuXnLq9lW5lN3M2U2Tudo4HS44X7r6ec7ZC2YahdwsDva+E3bl/Z7q
	92TR3/Ly7NlGM6ecFLu+YF0uz4ZX+XXOFxIyp/ckZsqZHlTd8Kd7/53vfhkSxzXmc10Ry6m+
	kyB+/MxTqXDd9JQw0ST7209+pgk+V53z+t0z9k0szGmrn841YEy2U/km1XvEoLc66fq77+/v
	xvY+uljWdH3luYK1mywSa5VaHrqf/ezZ+5bX9dPqzlLRbX7VH6NurOHxb623v5q7eaXB+UmN
	6xcZTVm27t6q+uu3W7O/WYZOMX+yZHGdyPVFSizFGYmGWsxFxYkA4b1y+k0DAAA=
X-CMS-MailID: 20250409152957eucas1p27f59b1452aa3e9b3aa0b2cc98c5a99fc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250409151611eucas1p299f54f1a61fb8412e515129c82021cd5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250409151611eucas1p299f54f1a61fb8412e515129c82021cd5
References: <CGME20250409151611eucas1p299f54f1a61fb8412e515129c82021cd5@eucas1p2.samsung.com>
	<20250409151557.3890443-1-arnd@kernel.org>

On 09.04.2025 17:15, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> When building with W=1, this variable is unused for configs with
> CONFIG_CMA_SIZE_SEL_PERCENTAGE=y:
>
> kernel/dma/contiguous.c:67:26: error: 'size_bytes' defined but not used [-Werror=unused-const-variable=]
>
> Change this to a macro to avoid the warning.
>
> Fixes: c64be2bb1c6e ("drivers: add Contiguous Memory Allocator")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>


Thanks, applied to dma-mapping-fixes branch.


> ---
> v4: fix type mistake from v3
> v3: use a macro instead of constant
> v2: fix spelling mistake.
> ---
>   kernel/dma/contiguous.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index 055da410ac71..8df0dfaaca18 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -64,8 +64,7 @@ struct cma *dma_contiguous_default_area;
>    * Users, who want to set the size of global CMA area for their system
>    * should use cma= kernel parameter.
>    */
> -static const phys_addr_t size_bytes __initconst =
> -	(phys_addr_t)CMA_SIZE_MBYTES * SZ_1M;
> +#define size_bytes ((phys_addr_t)CMA_SIZE_MBYTES * SZ_1M)
>   static phys_addr_t  size_cmdline __initdata = -1;
>   static phys_addr_t base_cmdline __initdata;
>   static phys_addr_t limit_cmdline __initdata;

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

