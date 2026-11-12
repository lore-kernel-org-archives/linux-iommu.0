Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794477221;
	b=xvTAkHd2gPfxIr5OtsvmTPOf301fRFYCbyQerIoF/6cHyxXsILpendSCcFKTDGKOdt0z
	 JgeE2CMwPjJZq7lEjrHEQRhwNQvZpZ9d2wyd1jinNHGZu6vz0up06uU6s3/YGzLYlxc9r
	 fydpG+Fq3vmXLwLKSr0VoWOjKjjGx1rbTcCt1qDLotIS4YWeCrVXS6CBfEXrrOJBN4ggz
	 Lak/n7kGIpNpMy3RW8H7/tQJ4+KUZOxRHkr7L0Y+HPuzgg+tbNNSK5RnVg6ljknqGwB/l
	 1QTvamnXrA5EBAU1HDrZs7CKWz6SLdPI742omp0vZCEJyNyt0tuCeGAe2ELwdxC1eHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794477221;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:From:In-Reply-To:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Language:
	 Content-Type:Content-Transfer-Encoding;
	bh=k03Ntp2ry5pgO/TcJOAttfz0cIyCVzxqYcnTvskPTaI=;
	b=sUne8Of4NdWnvZiPRX0lQxBaL17fL5PrGQsuGkI8NNMEhpxNSKCUXZmCNcs41jw4U3p3
	 HuY70hr5bXLwRoQigPqLs/iBRvKfGdXEXN21yzvLTRZwbgKMl+9QShx4Tm3vu4of6HkEX
	 0XeS5h6YDkYSU+TaY1BKJbUMmA8jaISxLS73gcvL988r4T5cxPk3aOPUH7Iz4gW+wwWFB
	 8W1IYUYwH9OBGHXAMrmb0GN0F410dG/o86xcsSWnYfgJom8hcXYdC1FrXRoNIBgqwJ0nI
	 vHEwjN2j5s1EpBnFa3a9AD2d5ImH1oDkGkvn6ajFPBSIGS5MHOtB4occM9rhNd8Agqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=e8TEnGOQ;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FA8606A31C
	for <iommu@lists.linux.dev>; Thu, 12 Nov 2026 09:53:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85FA8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=e8TEnGOQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794477219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k03Ntp2ry5pgO/TcJOAttfz0cIyCVzxqYcnTvskPTaI=;
	b=e8TEnGOQEmhVgJAIPOFGTYYc+FG8FmaGO2H4AiiY+FlbuYlL0L0R+XJYSh9ajncJnnyVk9
	+s1S+MApXZq3B00nEUGgJnnpb2t42WXtoU3Qb9jNmzXPVFqe3fzGsLwx6w9jzvczpJTL2+
	CtbgA4OPv80XkRFX1hrFRUuQZBPikm0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-06q-xlPuPemXShKJcVP6pQ-1; Thu, 12 Nov 2026 04:53:37 -0500
X-MC-Unique: 06q-xlPuPemXShKJcVP6pQ-1
X-Mimecast-MFC-AGG-ID: 06q-xlPuPemXShKJcVP6pQ_1794477216
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4b64722b5e6so44985765e9.2
        for <iommu@lists.linux.dev>; Thu, 12 Nov 2026 01:53:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794477216; x=1795082016;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k03Ntp2ry5pgO/TcJOAttfz0cIyCVzxqYcnTvskPTaI=;
        b=awkDANDL7YXY54cXsJzDlsd3M1DMKN0hvzIonBD9sD/ay6j0+SAyvKO/63N9rnns9J
         WpbZaSbV9qvb7HBJ0IRrLexz7Y2DHGOcJ1DF5mvxc2wuVoDpaCVJxTZarP4xPMV7iFCE
         ZrxWrg3DRnM54Y8OAOyuPAI/tBmi6kpisWISyI6Euo6aBmFo9taZQt2Lf4++CdzxUHGc
         HnpzhZ1YplEQejE9fsRebwbIVzOxJ0+JjC3Mp49FGcbsJ1Bqk9U7AKhK5OO4/DzUMb7S
         CzfDaNKasLJJjkElPsYRtldtXXHvmexkYAh7AC8ZvdR7wO8abpiJV5jOZw9HdyROiTxM
         D+Jg==
X-Forwarded-Encrypted: i=1; AL+hErHMUhwA5ahWPov701y8k4ZLC6cdVLuC6zb7upDl99z4fRAMZWLB7Wp0iH6PyEcmA6iFxJuVlg==@lists.linux.dev
X-Gm-Message-State: APuU4Z9dkAzkDwDD5gcb/MunBSilaYMRlfPVK8sKwxy45yUE218Yftiw
	K40u6kTB665PKga/KSjKlDh94Zirg1kJ6yXJ9fjn9nuCQbgYEtKlXsoxY8xTFz3qpt+phNWEqMF
	tRgnJ6GY5xK2WlNyFXYTcGV1xbrxHJQrYD4NduEQI2Sq1IEMfhvyGo+xq
X-Gm-Gg: AYBFou0Y+2RgDYeZTdCwHOVLpeigcSE5UKD+iwIqMuK707KhD6/Q6YpYJCuhiiMZXUx
	qmdgV34AbzuOOacA3Nm7PjX3tATqzhbxMLZqBqDOn/KsCGoG/zYDZQWfG/tE7xHJz7R0fW3l1TX
	H3O0uRfp+l0WFlNpOumsleQXmR/Q0iMcrWrELfBjtp5VIMvh7QCq2RyJBopqpbOtPJm908qVN8z
	Ay1ukP9mZ++46fhJXbkoPfYlwakJqueDc6S4gYgJfkN2JkDIbANlFXOKMdpyHWOQ9hhwK1aLLy/
	P7OzAX8oHnBVhskLQo4K/OSmWYXrsskBQbgwEFZdViErUhFV4BoZuiRIzXbnzlbMyVwBuvRNpny
	4kCTDq1MZt7fdyoi+LXRZu1p2rlbpyRrIBrjYDo6TtTIzuJdqZUHre8bBCQyTbx8S2Q2/ip4EWG
	igeW2L7mCJjKfm2VHYOxuI+5Kf/wgVNMe0RabJm8Zj2lUt
X-Received: by 2002:a05:600c:e554:b0:4bb:534b:ada4 with SMTP id 5b1f17b1804b1-4bb534badf0mr2171825e9.33.1794477216201;
        Thu, 12 Nov 2026 01:53:36 -0800 (PST)
X-Received: by 2002:a05:600c:e554:b0:4bb:534b:ada4 with SMTP id 5b1f17b1804b1-4bb534badf0mr2171565e9.33.1794477215780;
        Thu, 12 Nov 2026 01:53:35 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e29d24dsm58717545e9.11.2026.11.12.01.53.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 01:53:35 -0800 (PST)
Message-ID: <c83426a5-d21c-4f0d-b13e-099b6f96df6f@redhat.com>
Date: Thu, 12 Nov 2026 10:53:34 +0100
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] dma-contiguous: pass the NUMA node to
 dma_alloc_contiguous()
To: Jakub Kicinski <kuba@kernel.org>, robin.murphy@arm.com,
 m.szyprowski@samsung.com
Cc: netdev@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 will@kernel.org, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
References: <20261106184433.761422-1-kuba@kernel.org>
 <20261106184433.761422-5-kuba@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261106184433.761422-5-kuba@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AxkYoAE3IMjd2MrFh5liCZ0mEIlgfgAvdQSd_lUx4FM_1794477216
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/6/26 19:44, Jakub Kicinski wrote:
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -642,6 +642,13 @@ EXPORT_SYMBOL_GPL(dma_get_required_mask);
>    * Same as dma_alloc_attrs() but places the memory on @node rather than on the
>    * node of @dev. Like with kmalloc_node() the node is only a preference,
>    * the page allocator may fall back to other nodes if @node is out of memory.
> + * The contiguous memory allocator (CMA) does not: only the CMA area of @node
> + * and the global CMA area are tried. The allocation may fail even though the
> + * CMA area of another node, e.g. that of @dev, still has free space.
> + *
> + * Allocations served from per-device or global coherent pools, per-device CMA
> + * areas, restricted or atomic pools, arch_dma_alloc() or dma_map_ops
> + * implementations do not take @node into account.
I'm possibly over-thinking here, but AFAICS there are a bunch of dma_map_ops that
are using dev_to_node():

dma_iommu_alloc_coherent() in arch/powerpc/kernel/dma-iommu.c
vio_dma_iommu_alloc_coherent() in arch/powerpc/platforms/pseries/vio.c
gart_alloc_coherent() in arch/x86/kernel/amd_gart_64.c

With this series they will stop using the driver provided numa node.
Probably not a blocker but possibly worth to call out?

/P

