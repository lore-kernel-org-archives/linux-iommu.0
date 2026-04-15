Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A613B3BFE
	for <iommu@lists.linux.dev>; Wed, 15 Apr 2026 13:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776261209; cv=none; b=fShcIHaUq4kU4OhiJT1Jbeuh/hjF85zN/82qt5WFKgttuvtGmD7JKKUsLnMns/LCXkNm4O7VmFxpK6Atbj81hGNqAkov2OLfAPv256jEBVtNcYs2eiELtocvle9mGwEQ7FrhhxI2hF//xxBXhuC/LIKl4SfiIeNnPE8iY4ZQusk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776261209; c=relaxed/simple;
	bh=NjZRi6F3kjPLu2FB2YM0Y5WGi5mzKqvcdzvdrqVjHjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q2i1RgTn3NyQ9wp+idrJb9gnnv/T2yeGMZR7zVAgV7mFX2T+XW1SG9yDJuUnIhdiZOPR4ZNaa+gxHIFYqLysrzPKOv1KYfVZ2KlaU369Qf3a8HvXxbOrTLnhc9bxU2WJ9PzetAxtvG43f1zaICZDhFaHASc+IsiHIPRXS9kLsc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=QjTwsWea; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="QjTwsWea"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8d00cf835b7so823025785a.1
        for <iommu@lists.linux.dev>; Wed, 15 Apr 2026 06:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1776261207; x=1776866007; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1ky21GsOcS92v/0GOErqE5gWkmJLAC8Aqv1PqW+bexE=;
        b=QjTwsWeaBzZDuMsV1TBjDWFA7p4K2QScN7jCWsTkgpC90jQ0muCa/1L92+Lu2R1XdF
         UW61hPAQiB9t8uaxFBCjHuEKPao+0zjBs5vJILFNijl93hVBq/ocLP5iKpvqSdKrQlsN
         jdE2SLiRY+LVDYRi0D07f4h/Pr7vcdPOyo/wDCniALqAzzAe/sdq33Kkz+VFoysdOOXB
         94beIVR45YU1XYX859fR+hglNb4atynU+gA1nPpL1b6TijTHGyx1g9TQvrr6MpIIFKDZ
         L+SioaxD0tcgyQV+w1164VtJZdmCYbuvB6pPVQ7ezGCfffZUXoMi9nxSTs/CMasVP19t
         mY1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776261207; x=1776866007;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ky21GsOcS92v/0GOErqE5gWkmJLAC8Aqv1PqW+bexE=;
        b=fyslDG2e3Y1+qH4T7p/0jmQ74i+9A06x6sP1EmNBVm5iFh34RqBPBOUax0kO3bolwo
         u3pV2YrzhNsi2KGOwsCP61Lbcb7dJsCpf2nfBwUpsSqJpRcDxdMPB7TxNfX4eQME8vVR
         oMOb0X8mDQRtjg1N6Vr0B8dkaok26t2MlZ8/jIksvYViKqMqeHb7c87KrT5jhcejIjaG
         kSfqq4/MvpSksiWaCFhPPCZsG6kFI2OXioBQ5ARb93nMcqO9L5PJ/ykdGTHpmp6YF3Ut
         7aWjKgUrNvcjDgzKN3Ox6s1UKO2YhPBYAT98rXEfr5mjuIiMeLNxKv7F5+ivwo4zpnsj
         fKCw==
X-Forwarded-Encrypted: i=1; AFNElJ8Ax+G7n0NotayFekW65GTUYaY/pYkSt+btCO1B5OaT4BgYiuraIGcTkRwfQgB8l+u1V5mPeg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyme/PPRupqoNlu/+NQPnftApTAnnGqeJMuZcqQdm2zF8bMFAMo
	VCpKmOayBYiZVqXD94sneSbJ8VufnAP2ifjtfFLFD9/oNPH1+2LVGCRI/IYaKjW+7fw=
X-Gm-Gg: AeBDiesfqWsHcOaKVVOSb/nK6ZLD39lshClTJ+0+dH7jNCAggyytuTFBZaWg8gZKH6A
	jKA+55IgQMQSj27aAORf3AkRujm8SeaNTw43FlZjrWYLVAiw8sWVgBTCuD6lr/owio+l0+IYDE1
	BBde+daZ882Ii6lAHT/WkI7nPtyciYAAS2fU174ZdN9PsuqF+btQSEt2ZADvKeEheHlk4Wc0jJa
	dUOcHZ7APCdDVEK4ea7690klsv2ZQraKg0HC/GvCKvFCbaIok01qNUq+u8Cmv2MotTY75K7Eg8s
	Hz/tpJl5Hkl691P+X6oXgMasCbxT7Etej6YEpOn61PTcWzDtpDPTaAeLmsUPAESR+PP8rh0nxPz
	TpgIt0uvJRv3EULxYqFDKOsMLfIKRQazoUWxdFhQxA8apC9/11guBkT4/QHBFzfa6IPrCHgFy/f
	xh2cfwMcuybjEI0p7t1P/oTkT5MXmp3NMFy/yZS8FUTOXdczV1e4frBK3G5pl9rSKkgIVV9ih7I
	3D1mwj5qvZ9Icf6
X-Received: by 2002:a05:620a:40c9:b0:8cd:94a5:2f32 with SMTP id af79cd13be357-8ddcd8f429dmr3139685385a.27.1776261206957;
        Wed, 15 Apr 2026 06:53:26 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e4f243a4d4sm117991085a.30.2026.04.15.06.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 06:53:26 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wD0gH-00000000HDH-2vuh;
	Wed, 15 Apr 2026 10:53:25 -0300
Date: Wed, 15 Apr 2026 10:53:25 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	m.szyprowski@samsung.com, will@kernel.org, maz@kernel.org,
	suzuki.poulose@arm.com, catalin.marinas@arm.com, jiri@resnulli.us
Subject: Re: [RFC PATCH v3 5/5] dma-mapping: Fix memory decryption issues
Message-ID: <20260415135325.GH2577880@ziepe.ca>
References: <20260408194750.2280873-1-smostafa@google.com>
 <20260408194750.2280873-6-smostafa@google.com>
 <yq5a5x5vba49.fsf@kernel.org>
 <20260413124248.GJ3694781@ziepe.ca>
 <yq5aldeo9yxm.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yq5aldeo9yxm.fsf@kernel.org>

On Wed, Apr 15, 2026 at 06:13:17PM +0530, Aneesh Kumar K.V wrote:
> Jason Gunthorpe <jgg@ziepe.ca> writes:
> 
> > On Mon, Apr 13, 2026 at 12:49:34PM +0530, Aneesh Kumar K.V wrote:
> >> > 2) Using phys_to_dma_unencrypted() is not enlighted about already
> >> > decrypted memory and will use the wrong functions for that.
> >> 
> >> Can you split this into a separate patch? I’m finding it difficult to
> >> understand what the issue is here. Adding the unencrypted flag multiple
> >> times to an address is not a problem in itself. Even so, I still do not
> >> follow when we would end up doing that.
> >
> > I think my comments show how to address it right..
> >
> >> phys_to_dma_direct should depend on the device state.
> >
> > No, it depends on what state the CPU address is, which in some flows
> > would have depended on the device state, but by the time you get to
> > generating a dma_addr_t it should be based 100% on the current state
> > of the phys_addr and nothing else.
> >
> > Assuming that a T=0 device must be presented unencrypted memory is an
> > easy hack but it doesn't work when we get to T=1 devices that can
> > handle both encryped and decrypted memory. Then we need to track it
> > explicitly.
> >
> > The only places we we should check the device state for T=0 is at the
> > very top when we decide if we force it to swiotlb and inside swiotlb
> > when we decide if the allocation should be decrypted. Everything else
> > should flow from tracking the phy's state, and be tied into the new
> > DMA ATTR UNENCRYPTED.
> >
> 
> For things like
> 
> #define dma_map_single(d, a, s, r) dma_map_single_attrs(d, a, s, r, 0)
> 
> Where do you suggest DMA_ATTR_CC_DECRYPTED be set?

dma_map_single() assumes that a is encrypted.

If the caller passes an a that it decrypted then it must pass
DMA_ATTR_CC_DECRYPTED.

It is NOT directly derived from force_dma_unencrypted().

If attr says encrypted and force_dma_unencrypted(), then we have to do
swiotlb, we get a new address and we track the decrypted state of the
new address along with it.

Lower levels always receive an address and a 'is decrypted' flag to
make their decisions.

The place we check force_dma_unencrypted() is while branching to
swiotlb.

swiotlb might re-use DMA_ATTR_CC_DECRYPTED, or it might use the
dma_page idea, but logically the address and a matching flag flow
together through the call chains.

Jason
