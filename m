Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9BF44DB76
	for <iommu@lists.linux.dev>; Tue, 20 Jan 2026 15:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768921895; cv=none; b=ai1PAsK19WDistTeRtdp0qOWIQ3VwPgbPU9Qo/Qlc537o7dY+sCE6TzbTmVCO86KTpCpn+x9/ewOmtgY8cO+MbyulQuVU1PqkOaJclOmR/9YJ6E7+9rrBjZzWMiyRUJgJMgiGJRAhHp/ZDQh1VY7yd0LTIEYc5k+MxTlPus3VvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768921895; c=relaxed/simple;
	bh=z1JAlWdxRfNL4N3zWMO4F4IvA2PNLQmDwYlXJCnUewE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sb87rC4PyIoSc08uLzoV18/gaJOgh9nKXNYdskl6FqVlKeQUmXgtli6C+38hJkcqbU2A3D9YHy7Tijxb5GKUKDgN4Ke0XSFvP1GlfXqO/RjdxtPvbd4GqUNknhXDRpjaUUgTIvPxJjH4hPRSS+RzNGmziZ8jxD+wcYNKN+WnmLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=SwKFPMek; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="SwKFPMek"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-50150bc7731so82764261cf.1
        for <iommu@lists.linux.dev>; Tue, 20 Jan 2026 07:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1768921892; x=1769526692; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NlmbI9zXVktAgfsh6c8tsGYEK/T/Ft6rYTRkQgOh0mQ=;
        b=SwKFPMek1L17UCRbosSy2voASgUDujTJQ2IFZSScHuV+LYBpe+D79UmTLY7/OgK7cr
         3+G4DSOrJ4W8Xarcf8bhfgC0m4bUg6FCnQ2w8r34dRJecLCtrp+eTNHqkQ+SvW+cWVcj
         CHj7We7XPk4uRQ4YKBFpodRRauFnwHwPTmH3DsxyZZ5US/Zer3VYyEbQpV3dwD6Fmhcm
         rrDEoXtYcNqIXGOLgtT9akRJl8cwpJaVDQu+C2FtZr08MOiDHW+AQHX2Mn8YncIQ9PbC
         8aUaGwm8/KIYQ7BnBqn1iqFMnUx0Pq985rgjQH7ZA44+Jgl2psJQhh6yaeQPm0m9cQw7
         w58g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768921892; x=1769526692;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NlmbI9zXVktAgfsh6c8tsGYEK/T/Ft6rYTRkQgOh0mQ=;
        b=PzGL4ZuWaLXwQ4+FBcSWzsHzW29oK4W5xcHOR2Xrv5FtSu7UON4oxA38hbTs53S2/T
         ILyiMESWrdeUZJHSzmON8gipMyfa7QcRuIQtN2KyTNJfm7syEGdq8jvce/XtONuP/Bpj
         DaSK6jVn06uCAWED4921TnfomeJ3SYoWajiDSgomhnDuieXnyUtuKGdoAZ3v/3hOMFN+
         WTo4A+6SK+aI5Mhs5slJRYzamdFV9AJ2hdZ2HR/Rp0kjxKUi2TzBoWMIf4rletWlSCXn
         AvcHOPv0+zRhfGuaclJuTgQ5ymh42PnKRCZHwX/AY31VFTbQNjt//gscA6Er+MtewsRW
         L/AQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9QlwAj0Dp+APWD83qZC0DD6AXP9WdYVctt6kyvphEPxJlcya8WjABygCPF3thFS4PeKmIfw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw7cJeFHLGpHh9BM7KIjUxMx1+l6nQQPVxZYrCpC5kEMBHlyjWf
	26thQpKl43RFdMUVGO0rMxO5H3jwEru+wt0+brcK5xuR9MktxAErwv+DRliaHlEBXH4=
X-Gm-Gg: AY/fxX4ezNOEIif8XKfYGRs1kMxxkIcuPUiMLTFPktSoGadF1FXis4gLH3Z2NKVQkX6
	It+WdlLFtUhg/YptUfjoYNLTu1bIlcGQ7q2/T4NfW6azf9BqXC4a8dwDgKtqqQHO9d3Su4985zM
	139NIylYtunVBLdgB1wCbqY9kYeITQR0T7JJgYnQCG3G44gRNMS+oYn5VM+JavrWa7U9EJdcmxW
	AxwzRIc6lgUV3jWLDm0XDmhUb90p/1m+9te+IdBERdl4pioagGoAp/NxHZUutkeN3v59lKbQO2I
	wKveFolYTJ2nw+I8nMNNwcxnrLPXzWaOT64UTTdKWE9DCnjjnQVD1lCZv5RPXM/fjxySIkWXwkJ
	bdfwTFBa9UE2tXvQhS/sMVIu7owN1A0sQgKLtSQWiV37fKny/LZYUwP4C8jYN2jnVHGSOGJoKpc
	s8PeDL6Jd0kgGq/6wer9E6fwEMt/+7ziTON6P0mYdoTHR+n1BmbQPEbkMI3H79VJHnP0A=
X-Received: by 2002:a05:622a:287:b0:4f1:e928:3fda with SMTP id d75a77b69052e-502a1e07c0emr192323241cf.26.1768921888830;
        Tue, 20 Jan 2026 07:11:28 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e6ad0eesm104011586d6.32.2026.01.20.07.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 07:11:28 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1viDOB-00000005XsW-2bF7;
	Tue, 20 Jan 2026 11:11:27 -0400
Date: Tue, 20 Jan 2026 11:11:27 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-coco@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
	robin.murphy@arm.com, steven.price@arm.com,
	Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 1/2] dma-direct: Validate DMA mask against canonical DMA
 addresses
Message-ID: <20260120151127.GP961572@ziepe.ca>
References: <20260120064255.179425-1-aneesh.kumar@kernel.org>
 <2a0b6d1b-875a-4075-8fc9-a8534afc9168@arm.com>
 <yq5atswgjrkp.fsf@kernel.org>
 <0da8b73c-5bec-44c3-9902-221a11142c34@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0da8b73c-5bec-44c3-9902-221a11142c34@arm.com>

On Tue, Jan 20, 2026 at 02:39:14PM +0000, Suzuki K Poulose wrote:
> > > > diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> > > > index 8e04f72baaa3..a5639e9415f5 100644
> > > > --- a/kernel/dma/direct.c
> > > > +++ b/kernel/dma/direct.c
> > > > @@ -580,12 +580,12 @@ int dma_direct_supported(struct device *dev, u64 mask)
> > > >    	/*
> > > >    	 * This check needs to be against the actual bit mask value, so use
> > > > -	 * phys_to_dma_unencrypted() here so that the SME encryption mask isn't
> > > > +	 * __phys_to_dma() here so that the arch specific encryption mask isn't
> > > >    	 * part of the check.
> > > >    	 */
> > > >    	if (IS_ENABLED(CONFIG_ZONE_DMA))
> > > >    		min_mask = min_t(u64, min_mask, zone_dma_limit);
> > > > -	return mask >= phys_to_dma_unencrypted(dev, min_mask);
> > > > +	return mask >= __phys_to_dma(dev, min_mask);
> > > 
> > > This is wrong, isn't it ? For e.g., for CCA, even though the "Flag" is
> > > added to the PA, it is really part of the actual "PA" and thus must be
> > > checked against the full PA ?
> > > 
> > 
> > That is true only when the device is operating in untrusted mode?. For a
> > trusted device that mask is valid mask right?
> 
> Irrespective of the mode in which the device is operating, the DMA
> address must include the fully qualified "{I}PA" address, right ?
> i.e., "the Unencrypted" bit is only a software construct and the full
> PA must be used, irrespective of the mode of the device.

But you could make an argument that a trusted device won't DMA to
shared memory, ie it would SWIOTLB to private memory if that is
required.

Otherwise these two limitations will exclude huge numbers of real
devices from working with ARM CCA at all.

Jason
