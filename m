Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F7B2676C9
	for <iommu@lists.linux.dev>; Wed,  9 Apr 2025 14:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744209366; cv=none; b=u46F9whoqvpR8Nmz9rzgx26WWmUozPileIG3sz9mKbDzjkuBTho65ptdmW6njMyNKruptRmQ9ZDOhP3XMe8kl5l9AeZhPfZFihE8KlbHqFFwcIJUXPe8PnlckmvJGNcjiILD1feHtcA6b5SHag4uRCBQT9Xq6YvGrKHQuRJh894=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744209366; c=relaxed/simple;
	bh=Z7jl/cJkkSuQEWrPD/yiLvsUSr9DY9sVOXF49fuucUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=EU8lz9yJ12BMwOjwLgQNne7ynCpL1z0RiawDh5IlfU9sqGzijFWl0hoty+n/VyadwupFaLFFfsS5Kz7mTuktvCX8HgtuEmVRR55TkqmlUem9hovvQIGgW6n7eEnvUeEow9vk1VcZLJrWmM7b4jwAwQAk3hx+5vHmeowiM1UZHMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=hTGldjfk; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hTGldjfk"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250409143600euoutp02a6e7528dcfbeb6bae194a224687ee130~0rSwS88VG1324613246euoutp029
	for <iommu@lists.linux.dev>; Wed,  9 Apr 2025 14:36:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250409143600euoutp02a6e7528dcfbeb6bae194a224687ee130~0rSwS88VG1324613246euoutp029
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1744209360;
	bh=2IKtiWRx02ZXHZ0CRhjiLbtErxPLzauM8PsrH+VFftk=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=hTGldjfk5mrLihx5m/2LORQJbu+6CriG1bZqETqzEJZxmyYX4KAIAXjCAgiworr+m
	 NYONqPcyMdCMsyLj+PJuO+XJgr4xPxFh/qd5W0rhv058ycXyr2wc113RfC8/c4QzoG
	 XPpmqCQu2a4YLDejBQ6tNDyYWMaN82xH/3QPgHQE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20250409143600eucas1p24b6d6fd922558991db7a1ca2881c1af6~0rSwCupNS1973519735eucas1p2W;
	Wed,  9 Apr 2025 14:36:00 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 11.73.20821.0D586F76; Wed,  9
	Apr 2025 15:36:00 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250409143559eucas1p15613a03cfa20790ac031847e44ab2f52~0rSvklHex0357003570eucas1p1s;
	Wed,  9 Apr 2025 14:35:59 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250409143559eusmtrp19396ee52c593ac06a111f873eac1598c~0rSvkAeFV0821508215eusmtrp1Q;
	Wed,  9 Apr 2025 14:35:59 +0000 (GMT)
X-AuditID: cbfec7f2-b09c370000005155-df-67f685d0a566
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 34.00.19654.FC586F76; Wed,  9
	Apr 2025 15:35:59 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250409143558eusmtip21cb97f228ac947467544aa07595c6d01~0rSujc8I12703727037eusmtip2X;
	Wed,  9 Apr 2025 14:35:58 +0000 (GMT)
Message-ID: <59af67fa-ca0d-48f6-8b78-b1c694af9dfd@samsung.com>
Date: Wed, 9 Apr 2025 16:35:57 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] [RESEND 3] dma/contiguous: avoid warning about
 unused size_bytes
To: Arnd Bergmann <arnd@kernel.org>, Michal Nazarewicz <mina86@mina86.com>,
	Arnd Bergmann <arnd@arndb.de>, Kyungmin Park <kyungmin.park@samsung.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20250409122441.2875424-1-arnd@kernel.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SeVBMcRyf33tvd9+u2bw29BuZYtFMjhQNT9hxjZ5jnDOMa1h6s1a1ZV85
	MkMahUh3dhdtxGzaina37ZBpds20miViJCvliIiMJaSIXs/Rf5/je/w+3/nhqKSGNxpXqmJp
	tUoeKeWLMGvd94ap95K+KoLM30RkauIZhPyZWScgrRYTj+ztJskb78oF5J3E9wLyQfU5Ppnv
	OMojbR/befOFVHFeMaD6ejMBZSo6wadammr4VF79GuqNWQuo0h+dCHXaUgSozybf1cJNornh
	dKRyL62eJtsu2tV99qEgRj9sv1lTzEsAOmEKEOKQCIGPk96jKUCES4hCAM1vUxGOdAOYpq/C
	OPJ5wCmsHXDwwZbiRimnGwDM0rsBR9wAFtyvQ9m5YkIGdaVujMUYMQE2Z7T+0T1hvbZ9UB9J
	+ME2l0bAYi9iK+zu6RWwg0YQuQBqW2t4LEEJJ4CvU+/y2CqU8Iaudj3CYj4RDFO6UvgsFhKz
	YHmVFuNq/GBF17nBRJBIE8JOaz/CRV0MjzW6AIe9YKfDIuDwGOjMOoVxDccAzO9rQziSDmBC
	x9+OObCloZfPXgAlAuDV6mmcvAAak1tQ7jAesLnLk3uEB8y0nvkji+HxZAlX7Q91jtJ/a233
	7qPpQKobchjdkJi6IXF0//fmA6wIeNNxTJSCZoJV9L5ARh7FxKkUgTujo0xg4IM5+x2fKsH5
	TnegHSA4sAOIo9IR4nTVV4VEHC4/EE+ro7ep4yJpxg58cEzqLb5Ym6SQEAp5LB1B0zG0+q+L
	4MLRCcjBn+tqWkNKfPT+RxxNqyZsSVy+A11eqZm3YXZZxMs3H7KLMky6wkOXOzyMQcMjrNfO
	komPX0W/ertmIa+++vDreN+K8ocPDKH2HVVHbBt62q7P8fi03qa13QnTNM6VXbh0JSZIZAvK
	JsOszAJlTs/hDt9I+5JlZe6wnJvhM7OYRrMyoAPdVE0fl42rUyxMq5++yDWj8PbYZytrm8Ir
	vty60ieT7D5ZUDkVN/ioGmLojAZLqCvUnnPdT7nWy7gx9nxOi6F59ijPgKfPJxdYDREv9hv3
	9W85fXJzyaP5v/bE5m5cwW9/qY+OmpK91SQUPJt3Nd5ZZpwYUmJJ/vJEIxvvXBpYLsWYXfLg
	Saiakf8G88GIBc8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsVy+t/xe7rnW7+lG7xvVLHobZrOZPF30jF2
	i21bNrFa/PpiYbH39VZ2i7NNb9gtLu+aw2ax4HgLq8XBD09YHTg91sxbw+jx+9ckRo9NqzrZ
	PO5c28PmMe9koMeLzTMZPdb9ecXk0bdlFaPH501yAZxRejZF+aUlqQoZ+cUltkrRhhZGeoaW
	FnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehlfZl9lL5jPXbF5xhrWBsZZnF2MHBwSAiYS
	ay4qdTFycQgJLGWU2HdlFWsXIydQXEbi5LQGKFtY4s+1LjaIoveMEn/OnQBL8ArYScxa95EF
	xGYRUJG4MfEeM0RcUOLkzCdgcVEBeYn7t2awg9jCArESX378YgcZJCIwjVHiRudyVhCHWeAs
	o8SxlglQK7YzShw+f4sJpIVZQFzi1pP5YDabgKFE11uQOzg5OAXMJbbunMkCUWMm0bW1ixHC
	lpfY/nYO8wRGoVlILpmFZNQsJC2zkLQsYGRZxSiSWlqcm55bbKRXnJhbXJqXrpecn7uJERix
	24793LKDceWrj3qHGJk4GA8xSnAwK4nwTsj7li7Em5JYWZValB9fVJqTWnyI0RQYHBOZpUST
	84EpI68k3tDMwNTQxMzSwNTSzFhJnJftyvk0IYH0xJLU7NTUgtQimD4mDk6pBqZgpoL9E622
	fT2/vFmmdwnP3/Ouiw6L9JtkS7fbz4q4fy7pwQXJjNSOA9otZwLq79ZlzO1WYekKcjG6ZNNY
	u/656vOVDA/veWy6+Pis2+FzM//NargWXRXBEDm3u6F4imTOD54gCyX9hSemlxUfLjvhn/ZS
	qn6HwS8TgUkyD93L3TdV7ja7F31s9WY+BkaGn7cLZul2/HSRDqs+s6np0KlvOw6uajl17gir
	5Ym9WW3pKmoO2ZPvNfg6rvv0e7LafAm/zqwy4a+PmVfnHLjNV1s0wd58VUfb8+7kh2cn/tpe
	4jzNv2ti5/mXIVPEHrIa32Uv1zJbU2WRZHBe0jKB48bq+XvZPWx3fE+//GvajWYlluKMREMt
	5qLiRAAGC6JwYQMAAA==
X-CMS-MailID: 20250409143559eucas1p15613a03cfa20790ac031847e44ab2f52
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250409122452eucas1p2fd6f06f30de0c6b37b510a10081b724a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250409122452eucas1p2fd6f06f30de0c6b37b510a10081b724a
References: <20250409122131.2766719-1-arnd@kernel.org>
	<CGME20250409122452eucas1p2fd6f06f30de0c6b37b510a10081b724a@eucas1p2.samsung.com>
	<20250409122441.2875424-1-arnd@kernel.org>

On 09.04.2025 14:24, Arnd Bergmann wrote:
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
> v3: use a macro instead of constant
> v2: fix spelling mistake.
> ---
>   kernel/dma/contiguous.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index 055da410ac71..88888f4c1c73 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -64,8 +64,7 @@ struct cma *dma_contiguous_default_area;
>    * Users, who want to set the size of global CMA area for their system
>    * should use cma= kernel parameter.
>    */
> -static const phys_addr_t size_bytes __initconst =
> -	(phys_addr_t)CMA_SIZE_MBYTES * SZ_1M;
> +#define size_bytes (CMA_SIZE_MBYTES * SZ_1M)
>   static phys_addr_t  size_cmdline __initdata = -1;
>   static phys_addr_t base_cmdline __initdata;
>   static phys_addr_t limit_cmdline __initdata;

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

