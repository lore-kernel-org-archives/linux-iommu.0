Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F1445C6EB;
	Mon, 24 Aug 2026 16:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787589147; cv=none; b=gCn39pOdeDulmoAuVnkt7P8w8WO920q7kbBV/r+1Xz8YDd/W4K0u0q3s3W3VcBSsr4zp+cT1a+EFMoLgDL2N2hOlqMg3LjtUPnQLdAZyHLX5XITqDusH6tx7cVolGaZtit4myg9Wgz2i29hLuttBA9yc/Ud+olHr9+5hqY4b02g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787589147; c=relaxed/simple;
	bh=tmVJnM8+0WqjT9ypuV7jDrEJkQVA3+ITw4n1AM+P43I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qsE36rtFm6i36OWI4QNMlF4LQjcpBTI3aIOJcJUFpKS7M+MykTA+JpYiUyiXR79ZNz8AiXzh0gKwGBtL28FtTOttjG8+/uMsatPWDoZ0OcV4AJe90jFD9Eamyq0BhpW/bm73ZwfiwXqKprSS5KQj2wOs6MsNLi6UMdb4j1S78Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Yt9ReXi+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Yt9ReXi+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=I2GLkaWfUPmegFPxXgQ548ekGVdoYEwro087l+1Nqkk=; b=Yt9ReXi+RwRKSrIuVc5G1aF8NA
	vxFI6hsHltULBCQGJyDBSC87k9JtrZdFoEmkvUmPTUzO1V8mKVcrmXtfywm4bjFgtST9uSAQXepi1
	AuS9BL4dFPsGsT66YpOAkBUtFjGK+P3/KcpcDalk47dP7MWT0aBMffcnV5SwrjNOGTxz6JhPGhVeG
	CH6aNQnkfVOIdRPEKKzohvuuJ47N1jYVhlDIMyfRsku+/RvhQQK8jtMpXCvOTbqCd5PeMFL2omUa2
	/8EbtaxR0f/+9KmBdrIJ2znLwN209PMdmDQritDVRJvHEjcbzsrueEBRak3fJRuuW2z/NjMOPfhJf
	GaHc+kYQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyXau-0000000H3Ff-148G;
	Mon, 24 Aug 2026 16:32:20 +0000
Message-ID: <e6125911-c6af-4f19-914c-5ab2f621256d@infradead.org>
Date: Mon, 24 Aug 2026 09:32:18 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] net: Divert socket allocations to SWIOTLB for
 nocopy TX
To: Luigi Rizzo <lrizzo@google.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Willem de Bruijn <willemb@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Luigi Rizzo <rizzo.unipi@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dragos Tatulea <dtatulea@nvidia.com>, "Rafael J . Wysocki"
 <rafael@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, netdev@vger.kernel.org,
 linux-mm@kvack.org, iommu@lists.linux.dev, driver-core@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260615234220.3946885-1-lrizzo@google.com>
 <20260824152932.1583506-1-lrizzo@google.com>
 <20260824152932.1583506-5-lrizzo@google.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260824152932.1583506-5-lrizzo@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/24/26 8:29 AM, Luigi Rizzo wrote:
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index d4a07a7c570e1..7b818a796ff96 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -63,6 +63,11 @@
>   */
>  #define IO_TLB_MIN_SLABS ((1<<20) >> IO_TLB_SHIFT)
>  
> +/* enable nocopy tx swiotlb and set the percentage of buffers allowed for it. */
> +unsigned int nocopy_tx_percent;
> +module_param(nocopy_tx_percent, uint, 0644);
> +MODULE_PARM_DESC(nocopy_tx_percent, "percentage of swiotlb buffer allowed for nocopy tx");

Please add this module param to the existing swiotlb param documentation
in Documentation/admin-guide/kernel-parameters.txt.

-- 
~Randy

