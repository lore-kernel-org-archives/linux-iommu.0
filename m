Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794498238;
	b=TGVopJ833gZ5sZjmUq6Oos47tS26Ws4BvcJsdvM3Diic/nIHwbw+KOjLh8gc32LTMIjB
	 G4BznMaoGXkm0PdkFLFhXFa+NLfRtVc9tcTKDlDydVavDUGjzKFkPr57nTkRNgTGIAmNG
	 03lxLO6TpB2lXGUYhaFwqfAzsXOgqh+h0Q1VGmK5L93Xz8MS33+afP7Po9JoXt3AU0n7G
	 Tk3HcLG8/mP70hXnnvyX+n86fFpfM/zqr9DCQHJnu7CI4e8tKjYzEK+XI1Ni6hDfriA6P
	 7qaz1KNryB/1dnrCKycDz+JU+CVzCxAWZmhlIQJNe8x+bRuvoI2dQZk95cdb4PRmVJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794498238;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:From:In-Reply-To:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Language:
	 Content-Type:Content-Transfer-Encoding;
	bh=u3oSPp0s0TNWLPGdlKU4E7LGbHQev6fgdUE8CLBuuZQ=;
	b=cR7/6NXPzWsRilJRMxI21q9a2ieiNMYrWdbRpICrgq8Q6nBn4K3XZgyLPFWvWUDhS0rg
	 qhU+JyJpy34uneahOORT86pFHV6yhKvdKgf1sr8vqQhPkYRehI/QWyvt9AqlxGUj7tD3d
	 +cQ9XOY1isFe/f0IgnFg1dZXLmWH1xxq+q43VcFRd9oV/WiXIOKyr84TFxjnLUTMcB9RY
	 UoJksCnnR8bIiA0mkCenCGPlD5leE+H0HDvk/YAFt8wcNF6SgAQBS4+350xgiV58WGWEQ
	 U/MTJhWSvJoejjWO1k+fIX6z76jQpvgT7MuZJ+ZyQf3xi+VQNc49uO2Qdi4ai/QVI2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RKNtdemw;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD95606A321
	for <iommu@lists.linux.dev>; Thu, 12 Nov 2026 15:43:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCD95606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RKNtdemw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794498236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u3oSPp0s0TNWLPGdlKU4E7LGbHQev6fgdUE8CLBuuZQ=;
	b=RKNtdemwyJYeJUcMYvH/+lTTfBJQU18LMMp6o5KTXGyAG7mllHgxR+BE0Rkydsd7Vh9wqE
	xxVkJQl8RJQn3f7OxyJ/XQPoJAhSkAQSw22YLB1M4VGr6obQ1RAfOplIoqbeHjnXImNwFb
	jjYPpLayYUgNPUOqr/iC/yWgY5ppRII=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-YS1DmLSDNIiq3lNEVj3Qtw-1; Thu, 12 Nov 2026 10:43:55 -0500
X-MC-Unique: YS1DmLSDNIiq3lNEVj3Qtw-1
X-Mimecast-MFC-AGG-ID: YS1DmLSDNIiq3lNEVj3Qtw_1794498234
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c293e604f0eso421452066b.3
        for <iommu@lists.linux.dev>; Thu, 12 Nov 2026 07:43:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794498234; x=1795103034;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u3oSPp0s0TNWLPGdlKU4E7LGbHQev6fgdUE8CLBuuZQ=;
        b=WLdmLn5Xqvb1C1Hcd3Tc7B7IWboVqfKvJkSEJ6Za7IgTiqMeP2rxLNzcQk9lDAaQPf
         aFH5lIHU94srif4H7jj+M82FwZ7q/BrrqCOFzmGaVylYkTJggWKT9ezk9ji4IQiI8vRJ
         w8RtlkvWRibTbrACknf+vCt98SDGKll7LluLTy0bRINWTWAqYC7nyuVEkdREbboS4HMV
         YxxTn5puy/mjlwOid1sizwsf2owbg3CNlVCyTFf17b6k6WlxJKfF+HZjom0tzMTDJUs4
         9EYkBb6saP/0pdwT6ahJtmzfkAiWlKmYupmOgOim/byzoMGZ3F8E3dhvyxk4OuNaS2IL
         bUXA==
X-Forwarded-Encrypted: i=1; AL+hErGeik2FlAeqS4to3sDwtJDnJehlhQJ8G+w/Wlb/2EaZwTQNNEQ9mvf+79kPjw6WlOF3WQa9Rw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+CtqRe+lpeILY0wvvqx3+ATnF8stcfIYiv8TrWP3fA22nSJdNj
	gmPMSIrRh8qPeNim67LvhGpy2S6vlw2sqScy0gN393C45A0SITM9CWoR5uBY9TJ6iLnU7A+K7tg
	t3Dv/IKaoU12ng+zI7mSaANlcIQPFo/ySA4Hb7ZCkkiuD2uGcD28upZwa
X-Gm-Gg: AYBFou1UbHPciXaR57ncoJKaRkTdiO++ooADk3VpNfRSaBYX6wg2RjcOE5jjG3wPlOA
	gXYDSatE8g6mwTntr7yeCLxG1UDoN3K3Osnn2ng2oadSQtFBNoSWbFKgHg0g3pBVTUKudr7/ID1
	u745mc5C9JNQKsPh00WUAlaKhlNN0sbL+ir7WOl+Cdw+rSuAOh2vmsnkMcDCs9aDzEzFgCbkfxH
	xMHpcL0L79QMW6B7jN3nufXq/Qdoqkwl5LmlhsP28BjykhhHpGiJDhtTWtKncC2PIZwO0dW79II
	SMlqfaxN9M0yWHIxLZzejz6kMfgz2cC/i0laviP3MQffuzVnqQtSWcFpBPaLSu6M/YO/FIeaSCg
	dQ2FGEp9nDh/a6LdXpivO5VYd+xKYJeDfxL7KX4N5lO2e2MlEL+KAUiysfOqY/Pa2Oh8xqvbsaq
	SoVHNMfbISDOQ97ymL6xtEz0pkWJw2kHbH7AZv5+Rrf1f2
X-Received: by 2002:a17:907:3e9e:b0:c42:102f:15e8 with SMTP id a640c23a62f3a-c5066af2caamr478213866b.14.1794498234093;
        Thu, 12 Nov 2026 07:43:54 -0800 (PST)
X-Received: by 2002:a17:907:3e9e:b0:c42:102f:15e8 with SMTP id a640c23a62f3a-c5066af2caamr478211566b.14.1794498233631;
        Thu, 12 Nov 2026 07:43:53 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a3a651csm375554966b.4.2026.11.12.07.43.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 07:43:53 -0800 (PST)
Message-ID: <c014414f-fdd2-4a79-b133-44671c0e4475@redhat.com>
Date: Thu, 12 Nov 2026 16:43:51 +0100
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
To: Robin Murphy <robin.murphy@arm.com>, Jakub Kicinski <kuba@kernel.org>,
 m.szyprowski@samsung.com
Cc: netdev@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 will@kernel.org, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
References: <20261106184433.761422-1-kuba@kernel.org>
 <20261106184433.761422-5-kuba@kernel.org>
 <c83426a5-d21c-4f0d-b13e-099b6f96df6f@redhat.com>
 <d00d3435-fcce-4c0f-8ed5-a672b5b85dfb@arm.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <d00d3435-fcce-4c0f-8ed5-a672b5b85dfb@arm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ANDSAtKblBewRiebwaWHOQqc6IiPFZxPmBHVI-LYP5k_1794498234
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/12/26 14:28, Robin Murphy wrote:
> On 2026-11-12 9:53 am, Paolo Abeni wrote:
>> On 11/6/26 19:44, Jakub Kicinski wrote:
>>> --- a/kernel/dma/mapping.c
>>> +++ b/kernel/dma/mapping.c
>>> @@ -642,6 +642,13 @@ EXPORT_SYMBOL_GPL(dma_get_required_mask);
>>>    * Same as dma_alloc_attrs() but places the memory on @node rather than on the
>>>    * node of @dev. Like with kmalloc_node() the node is only a preference,
>>>    * the page allocator may fall back to other nodes if @node is out of memory.
>>> + * The contiguous memory allocator (CMA) does not: only the CMA area of @node
>>> + * and the global CMA area are tried. The allocation may fail even though the
>>> + * CMA area of another node, e.g. that of @dev, still has free space.
>>> + *
>>> + * Allocations served from per-device or global coherent pools, per- device CMA
>>> + * areas, restricted or atomic pools, arch_dma_alloc() or dma_map_ops
>>> + * implementations do not take @node into account.
>> I'm possibly over-thinking here, but AFAICS there are a bunch of dma_map_ops that
>> are using dev_to_node():
>>
>> dma_iommu_alloc_coherent() in arch/powerpc/kernel/dma-iommu.c
>> vio_dma_iommu_alloc_coherent() in arch/powerpc/platforms/pseries/vio.c
>> gart_alloc_coherent() in arch/x86/kernel/amd_gart_64.c
>>
>> With this series they will stop using the driver provided numa node.
>> Probably not a blocker but possibly worth to call out?
> 
> Nothing "stops" - this series adds a *new* interface by which drivers can now indicate a specific preferred node, but DMA API backends are still free to ignore the caller-provided hint and continue doing whatever they want. This is already called out all over the series in commit messages, documentation and comments including the one above.
I mean: the series also replaces the old hacks with the new APIs usage
in a few drivers, and in the above cases there could be actual regressions.

But I guess we could handle them if and when they will surface.

/P

