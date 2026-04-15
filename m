Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6C537F8BA
	for <iommu@lists.linux.dev>; Wed, 15 Apr 2026 20:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776284847; cv=none; b=rWHsIACBnfyGkLR88CMjY6f0cbzj453LkR0pWBlYjiZGTF0tSNv4nkX1ZA7+8ioJMFkUrp1iPtALVgbDbEefE5c9/+Ft+ML7cqx66WNyrxOmiSYY7G45/XiILU9A7kxsf8BGenK5Bqgy/MjZuI/pXv5cS7HcBJTF+J9knKkgWEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776284847; c=relaxed/simple;
	bh=gXNKDD/9l+XMXY4TlG7+/L11ZTkDuyL6i7fItICrGuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G1rhawsRbJu2ZXgYDmSKu6zzqAP9CEH3Dgegt065YlE/0Xif0SB0fjGiaw9PIsWuw7hhpjFEAkS09aAXnQtwJ5Gj+sdxPG9bzEytlJ0ImxsOaSHD25abkFseveKwjHSCFoCkNPpX/QSlFn67kYGZDNUzBXsC8fyqzbbH/Ua7aT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iUC7rw6g; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iUC7rw6g"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488940ccfa6so22745e9.1
        for <iommu@lists.linux.dev>; Wed, 15 Apr 2026 13:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776284843; x=1776889643; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vz/HCtyBbjnMYxlwWsgYDSUCkKsR7lUB1SfJ7pP/3Uo=;
        b=iUC7rw6gwfMp2uxWnCEOxF64FRl2QsoQ0zuC0zpwg6OMKlu7Qnvl7SfVcu0EB3pe6k
         xLzLQvtlCYrNeUaSLFxSMqK2k8+uK5BD/9f/cR5y/daZ7PvHA78Bla+j85iia9gXmOBt
         Sdj6wM5aOkgKLtaVR7LynavjrlEvZpPHO0TPMXOzsOvdlsFjX1wJmmWLGeQwkBREJtPX
         jcQSpH5JVXRDUhRUOuhIsLe//RS+tIku6op2WGlO0XEmgsIqnnzIdV361p0hstwA9jzX
         HdKrCQGVTavAJwF1qjex87k83jb/2peieTii03CPhiZAX28OQQ4W8/OafaSfir4QGsWw
         ItHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776284843; x=1776889643;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vz/HCtyBbjnMYxlwWsgYDSUCkKsR7lUB1SfJ7pP/3Uo=;
        b=kmkLB45NvJBLV7/ZSO96Y5fXtGS5M+i4Y7ODlbVk+od2amUnwpp9etdMGgbUE6+r7L
         4fWNQjpIKMV1/kA/6QKHcfC/zampWMJNFyP36unLXZ6IgRRWuXG0dtHecwJApUIa+t8U
         7AwHYS4Ru+v8EDTstKsIlFvDVNAZbTsZ5P5o1xffcczXplW/O+0O7Rc+tVZiajJamjGh
         qk6+QxYUVD67ZVf8Eql2TJW7UXOG8w/ONCfzirfRmN1bszdzgRh82hxhMI261ECqSAkU
         O3UvYAhoF+T/eyLdketPub/zRYuxhfqlUW+7gKc2vXmayYtqj4pd497XqOCjhT4ugbP9
         3QyQ==
X-Gm-Message-State: AOJu0YzgUOGoIkugbQwBXbojy+npZeAZzKywaF8+2L/TFH1fwKc7TxVx
	Zg0NltNYIXD1mDYF3Mk9lpG8EZ9jo8R4KALuQaN/i/tixSgTx3jquYNSGTr5g1wnnVc+Le+DVxt
	Dkka3Og==
X-Gm-Gg: AeBDiev3vceJIKmrz4cHEMH9BYPWqlsS0mhnM5lgIktPhn4c192aC10rpUXhiUqiaNO
	npxnqs6ceOGs45pVnlf2iQdr55/2/xeDxG2JE+93Ty+djZ1CSwb2/7o0VoB2vT49ebRzxuZSNHT
	HFRklaUlyH3WxmKr2qCa5PyH8iN+J0L6IGmY7LttNK3oPwQhpqCGWCUn1J/rE0JPbCxSVFYRjjn
	5hEbmUAnHr+r3HhGzx3XQwG9FLjcdxKNkIKqRsAJhGDmuHTS+ZG6qIvtn1ywpdQLkx1CLyFvuXW
	Xj2SyAExftHWv00ZOskN/Tm6DECtjyCo9PE3YVDU1Ssza2q/M+Wz9KpTdQxC8nohd4IPqniGrLD
	dpbWxRjXogrNMaltLB6mm51zY2SMug4A0TXFAtNlmh2K2hTf4JoL4VN1+mpcOTRNLNM7ZWo0YS0
	b8jZdGFTaQHV/SwlrkplAltM9qy4VGMhKxHclj9diUWLAoAn0U0SiyyWQCaL7BjPAbhDM/ImTHe
	Gfb6w==
X-Received: by 2002:a05:600c:41d5:b0:485:2ab4:c1f9 with SMTP id 5b1f17b1804b1-488f4a5c15dmr142245e9.4.1776284842541;
        Wed, 15 Apr 2026 13:27:22 -0700 (PDT)
Received: from google.com (8.181.38.34.bc.googleusercontent.com. [34.38.181.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ee03898bsm150581075e9.11.2026.04.15.13.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 13:27:21 -0700 (PDT)
Date: Wed, 15 Apr 2026 20:27:18 +0000
From: Mostafa Saleh <smostafa@google.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org,
	maz@kernel.org, suzuki.poulose@arm.com, catalin.marinas@arm.com,
	jiri@resnulli.us, jgg@ziepe.ca
Subject: Re: [RFC PATCH v2 2/5] dma-mapping: Use the correct phys_to_dma()
 for DMA_RESTRICTED_POOL
Message-ID: <ad_0pqI0uWZH7D8k@google.com>
References: <20260330145043.1586623-1-smostafa@google.com>
 <20260330145043.1586623-3-smostafa@google.com>
 <yq5abjfnbdej.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yq5abjfnbdej.fsf@kernel.org>

On Mon, Apr 13, 2026 at 11:38:36AM +0530, Aneesh Kumar K.V wrote:
> Mostafa Saleh <smostafa@google.com> writes:
> 
> > As restricted dma pools are always decrypted, in swiotlb.c it uses
> > phys_to_dma_unencrypted() for address conversion.
> >
> > However, in DMA-direct, calls to phys_to_dma_direct() with
> > force_dma_unencrypted() returning false, will fallback to
> > phys_to_dma() which is inconsistent for memory allocated from
> > restricted dma pools.
> >
> > Fixes: f4111e39a52a ("swiotlb: Add restricted DMA alloc/free support")
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >  kernel/dma/direct.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> > index 27d804f0473f..1a402bb956d9 100644
> > --- a/kernel/dma/direct.c
> > +++ b/kernel/dma/direct.c
> > @@ -26,7 +26,7 @@ u64 zone_dma_limit __ro_after_init = DMA_BIT_MASK(24);
> >  static inline dma_addr_t phys_to_dma_direct(struct device *dev,
> >  		phys_addr_t phys)
> >  {
> > -	if (force_dma_unencrypted(dev))
> > +	if (force_dma_unencrypted(dev) || is_swiotlb_for_alloc(dev))
> >  		return phys_to_dma_unencrypted(dev, phys);
> >
> 
> So what kind of device is this? Is it a trusted device that needs to use
> swiotlb in unencrypted form?(is that a valid use case?) Can we add additional comment
> explaining the type of device for which we are allocating the DMA
> buffer?

That’s used for devices that use restricted-dma pools which are
currently always decrypted, typically virtio devices that are emulated
by the untrusted host.

Thanks,
Mostafa

> 
> >  	return phys_to_dma(dev, phys);
> >  }
> > -- 
> > 2.53.0.1185.g05d4b7b318-goog
> 
> -aneesh
