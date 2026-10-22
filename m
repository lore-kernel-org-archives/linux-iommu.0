Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792697730;
	b=EoJROqtk/0nsCeSW4ZKYrkfCXI8mRmhrXZL3WritwZ4N1q1g9F/oj39EPD+TPKFyDTox
	 xplHAsXZDJGwziP0wEKZFya91LMqAzNg1CQHZzj9XQNu7q/tVOY64Tfhb6qtGXr67A3vB
	 +mn7bEWLV/mnW+P5Ypr2TYpcuBqZCbRLbEcLm2eXBZ5QySGbAptxIASxnudBSHzfimR8c
	 I/Ovy3y7gTTa6DDH+fFuNBKGOTLFGK+8mPsj5whVuL9fDMzYUb4JzyayNfMp5FH//bvIq
	 ifWYaxklg/KM8jsyjv7xhg+HHZW9hEC1/4weadQE8QGWmlFDovVrGE/7pcT2DPZ+0VA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792697730;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=56b7HTZvlpKC4tZk577CJ8+w/mtcoo97dNOMSZZwtIA=;
	b=xHm9f4126cujwuaRxgGxvOCoMYU7IYEw+H/Hw8SK9/XDlpTl45v+MomCRailx2gBUtZk
	 yYzV5ja43YReHbNzTO/pdNsGGZBhZJdguv2X/KTLnSnR6+uDey6ykFAGQVnXT2SfWdllk
	 fNwSFRKVdQGMb8dr/6YXIygQnr0Qo1Ja9RQvXKvFgeR+mRBfuEdi3JjHa2kqYdvv/c/Jz
	 Lh6ZsZZCTEgwP0h3f/jJndAGVBRcO9YlIXw+eZ21cjnt/YlAWCn9VbFEwzc2PtjebZ333
	 XkOJnsLkoUZZhqviMjEf/JVp3NOkP8L5MvdHmwbnnWMjpywQnOVnkqs95XBnPVR7dNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Cz9eKZue;
	arc=none smtp.remote-ip=209.85.219.42
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABAE606A31B
	for <iommu@lists.linux.dev>; Thu, 22 Oct 2026 19:35:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9ABAE606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Cz9eKZue
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-917b78dfe30so3573526d6.0
        for <iommu@lists.linux.dev>; Thu, 22 Oct 2026 12:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1792697728; x=1793302528; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=56b7HTZvlpKC4tZk577CJ8+w/mtcoo97dNOMSZZwtIA=;
        b=Cz9eKZue9B64Pl+y3cFAG89LRwjdB4ziKUsBn8MIdw73p8ujua4r20dYv1Zbsc1tKc
         jSdGy4e834NXzszkCL4EaJ4vnzIRIC3NlhIvbbxZjSOD4dZddYUOls6nb+kUwUGNxwFR
         pzFsOFmXkCedrXbBY0mit7/Ro0CPfoaecLXrgri09ZyG/MrKXUyfcc8l0T2jcaVyr3s2
         LHwRoCm+RUehcd3PJR4RBuHXzv0AO2CUOuR0Z2V6Jtmgti5psAxqiiwGPW24ht4zMqMq
         uxTyYYJhzfr+PYzzQOo4hMtoCsmzl27k03eTTlLYGtqAHfX5u20qbRYI7bT/cl9MzNlD
         xp3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792697728; x=1793302528;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=56b7HTZvlpKC4tZk577CJ8+w/mtcoo97dNOMSZZwtIA=;
        b=tramhj8oziySa7O9dfo144tSUJt8TNgEGRWWewrC53bStQoV7XicsKuy5LjjSQLzrd
         yOh7Nhrrjk9nNIpn/6ZxbqGjEshuN0lwkFTffwkZVPhVa7bDzScx5PTD6jV51IWQAZEh
         GlUfrQmdJrfZCiq/OLPucv9nTGagBqJVsdLKe28l67ChGKkGNq4XcwtPDmrSF5aGafN3
         /jurCuXKSaVCFn2+g2zzsvbr/S1ZJ19mTK9n5vDmfn/NbO2qiCPdTdiE2CkYGRgoG5GF
         PELZpg5ybSb1DkNCvTN4wAKWIen+n97ixqjnkEW6C7rYTtNu8Tmj8BNJBGpUQYJ/w9Fj
         93yQ==
X-Forwarded-Encrypted: i=1; AKwUvByYCnyWkIgnU27GqdMakUpPX+efGR+MSafkM3IF4Ez5oEKlXbGOZNmZxaQ3jxCtw3O3CSzRRw==@lists.linux.dev
X-Gm-Message-State: AFq9FYLd2XMlk98i1K6pK72uOy1sP16dqs6tmZoajiKhmbyX4stRBT9Z
	EBYmltGwTakhGSkIMms7PTmyXfPenWsMYo3cLOhXMR9AHEsHqsrB/JfCE2xtBjcDNnI=
X-Gm-Gg: AYBFou0uJ7Bg/AUgD8yL4yPPfTdIRApW5hp+vGIsDyYHo3E0ZbZht0ajebUvp2p9tFt
	K2zz9HxlGlb4TIS8gFRyewWKke6nPxnUo0Y5l1ZBMY2lo72YfTn6kys2mbp8+Xa8r8TEQLvbL51
	OZu3dfSSXAh1qmo5aRdx8n2kMk0tgHwpIK26Rh032eW9mM7byKZRt4PToQRvB0+I9PZKiS2FGBd
	W7ZZOjvz0duQTFX0qSCOejmTd1rKDz7Jtkz7e+K6g0OqwALoraDbXFyHIOOZsargdMKbDr8nNYb
	d5yz1ZnlSxv4is7ijrRHJovoXzpWYryGG7EwIn/zg7YoaT8fkERwdWp59LlUyj8a+ByeLhdom32
	UdXsl0bAEe+SipOEftzqJuLGVsEklwRFcR2jRRfGnmLB83Rkgu/eFszlC0MdL47vY76mehCBZOS
	uqjJkGCdD22ABau4min/U6RPtim0WZ9K3P9efKjRV/8zd0OdHM1C0OYUVcezcADUSOKAvOu2/Iu
	nevpdHM7yGjsskC9w5EgRtaLhwKT2Z4iFeHg7jrOp/9+PJG7FezsPd2TW2jmSmB/OKpgG2Ygol6
	zswJFCXyPbvzL6ACEkw0OP1pNTAOMu34c9vVKQ==
X-Received: by 2002:a05:620a:2794:b0:93e:c6fc:7f50 with SMTP id af79cd13be357-93f6f79dc27mr75461785a.5.1792697728579;
        Thu, 22 Oct 2026 12:35:28 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c39766a93sm366276d6.43.2026.10.22.12.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 12:35:28 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xJyZT-0000000FmQW-2RHj;
	Thu, 22 Oct 2026 16:35:27 -0300
Date: Thu, 22 Oct 2026 16:35:27 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Cc: alex@shazbot.org, iommu@lists.linux.dev, joro@8bytes.org,
	kevin.tian@intel.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org
Subject: Re: [PATCH v3 1/2] iommu: Add iommu_get_pci_resv_windows() helper
Message-ID: <20261022193527.GG3381610@ziepe.ca>
References: <20260921115513.GK11599@ziepe.ca>
 <20261004162213.3787623-1-guanghuifeng@linux.alibaba.com>
 <20261004162213.3787623-2-guanghuifeng@linux.alibaba.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261004162213.3787623-2-guanghuifeng@linux.alibaba.com>

On Mon, Oct 05, 2026 at 12:22:12AM +0800, Guanghui Feng wrote:

> +int iommu_get_pci_resv_windows(struct pci_dev *dev, struct list_head *head)
> +{
> +	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
> +	struct iommu_resv_region *region, *next;
> +	struct resource_entry *window;
> +	LIST_HEAD(resv_windows);
> +	int ret;
> +
> +	if (!bridge)
> +		return -ENODEV;
> +
> +	resource_list_for_each_entry(window, &bridge->windows) {
> +		struct iommu_resv_region tmp = {
> +			.type = IOMMU_RESV_RESERVED,
> +		};

I didn't try to look, but if you are going to add a function to the
iommu core then dma-iommu.c should also use it so we are sharing the
same algorithm.

Maybe a callback function would work better to that end than returning
a linked list?

Jason
