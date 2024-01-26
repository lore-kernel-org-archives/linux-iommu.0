Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A9110A3F
	for <iommu@lists.linux.dev>; Fri, 26 Jan 2024 12:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706271477; cv=none; b=FGHOjoRCjef6ccFt2eeqGcgUbzJaPfXYbHEMLCkUnmZllVUeuVgtNNXZWbdMlCSQ1gDlygLENvhFzGuJA/fn0uj5hfng4UK7plrKZux4wyPFuS/y4G08eRoY+KSmXqok7cGcTpFtLHyqAgA2d1vNbLQR7qyqcghyYDIf+PcG7xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706271477; c=relaxed/simple;
	bh=F8EjxjnPS4zV2e5qOWUEoSipLdshEB4A/v3TmmiAknA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oudV9WaddsNreG/WS3PoqbVyCXK9ZPLMcdiZCrH/t+VQjK5YpPLlFyUspHvDzM/tj403zIvYd3Ua7b2MuzRQhzG68uiBD8silxec/Ehs1nrLbTbcf0t08Ma9Dt+f+3Xe5gxiMXFVdInIMvgbkwmHC+g0eAIVJ8TseCDbc8Dxu2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RxE2O6k4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RxE2O6k4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706271474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z8dwLT6WlXLRPPNLtobDZ6VNc6Gc93BMv8mxLS9INIM=;
	b=RxE2O6k4RH1uJNmM8q2SkRcLisejsTWfjMU8bdQjER5+t/hpX/ScflD403Cpe3Roz+f+XR
	G8I16uNXPgFuS/3hd0EOOEeUtiYMZy80r5dbk/nkprPen0Ng4iX6q3zuPXt1ILEEP+28R6
	AZnx9rZRPR5CJGmPeXf96/Co7PBt6WQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-QOohnhzLPaCmurmnhKu4Jg-1; Fri, 26 Jan 2024 07:17:53 -0500
X-MC-Unique: QOohnhzLPaCmurmnhKu4Jg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3392c5e6dcdso712930f8f.0
        for <iommu@lists.linux.dev>; Fri, 26 Jan 2024 04:17:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706271472; x=1706876272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z8dwLT6WlXLRPPNLtobDZ6VNc6Gc93BMv8mxLS9INIM=;
        b=hIs+c68xerOirbVdRL/wJqk/nelGhvcs3ObAL88tBvwCZWSXYPpEntMizEC4mUG/mu
         nsh6SeNxjt58H/gmpetPsaoBrFWWAOfcT3uKv/s0ieyxF35wEE+QHfOVWZxpQD0fDOe5
         oh2lhcM0RJcqJo5ekaTAcaQeEvq3m3tIcgt7o1W1XdfMwACecXh5Ag151OWHlbyF1i4q
         x2b8ZwY5cqULqNxvOUFvCYWzPTANHSNA0IjssEzOrjn4wIOu7iuNrNu+bEqPBa+RR3qv
         f/lCGsCRdXAFvvL2hdAplDlvuPifgMCE28X1wR6zGRp/fu8+Qi8EqB4dcMW5tYJbJyhN
         u2pA==
X-Gm-Message-State: AOJu0YziUwL6FA5cIp7q/LU3TyFODT6T4TX+RHs4dxg1zCFw+OPkTf1m
	zf98v2G8kJFbJKjhxTnszp3N65zfrh2GM3hJmLFjXgI5ptNLHZO4DeSUHqkBHWXO255AhE8Pwro
	qTK1twDa08n877/jhkcAcZ5im6jo88O4JmaL6eJWijmpCKJrKf5MC
X-Received: by 2002:a1c:721a:0:b0:40e:a555:803d with SMTP id n26-20020a1c721a000000b0040ea555803dmr514857wmc.74.1706271472193;
        Fri, 26 Jan 2024 04:17:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFF2FSKfk2eubyA/YDmlRnLNe4TS423LZSOORmsTwhvNNKjZBdE3pllGVo1tWTXXPWx/M1AJQ==
X-Received: by 2002:a1c:721a:0:b0:40e:a555:803d with SMTP id n26-20020a1c721a000000b0040ea555803dmr514841wmc.74.1706271471723;
        Fri, 26 Jan 2024 04:17:51 -0800 (PST)
Received: from localhost ([2a01:e0a:b25:f902::ff])
        by smtp.gmail.com with ESMTPSA id t15-20020a05600c198f00b0040e395cd20bsm5650793wmq.7.2024.01.26.04.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 04:17:51 -0800 (PST)
Date: Fri, 26 Jan 2024 13:17:50 +0100
From: Maxime Ripard <mripard@redhat.com>
To: Lucas Stach <dev@lynxeye.de>
Cc: Milan Zamazal <mzamazal@redhat.com>, Christoph Hellwig <hch@lst.de>, 
	iommu@lists.linux.dev, Will Deacon <will@kernel.org>, catalin.marinas@arm.com, 
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Andrey Konovalov <andrey.konovalov.ynk@gmail.com>, 
	Pavel Machek <pavel@ucw.cz>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	kieran.bingham@ideasonboard.com, Hans de Goede <hdegoede@redhat.com>
Subject: Re: Re: Uncached buffers from CMA DMA heap on some Arm devices?
Message-ID: <rhfec3v57xeoliukqxaives3uerb6phbxphgcua6mvxkdnzrzr@xm5zvoevxf4v>
References: <87bk9ahex7.fsf@redhat.com>
 <d2ff8df896d8a167e9abf447ae184ce2f5823852.camel@lynxeye.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sy76qndjoguffu3e"
Content-Disposition: inline
In-Reply-To: <d2ff8df896d8a167e9abf447ae184ce2f5823852.camel@lynxeye.de>


--sy76qndjoguffu3e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

On Thu, Jan 25, 2024 at 12:41:01PM +0100, Lucas Stach wrote:
> Am Mittwoch, dem 24.01.2024 um 19:27 +0100 schrieb Milan Zamazal:
> > Hello,
> >=20
> > in the libcamera project, we experience a major performance problem rel=
ated to
> > DMA buffers while working on camera image processing using CPU.  This h=
appens
> > only with some Arm boards, we have observed it on Debix Model A (NXP i.=
MX 8M
> > Plus) and PinePhone.  We use /dev/dma_heap/linux,cma (or reserved) DMA =
buffer
> > heap on Arm.
> >=20
> > Reading V4L2 camera data from buffers is very slow.  When we memcpy the=
 data
> > from the buffer to a malloc'ed memory before working with it (reading e=
ach byte
> > multiple times, without any big non-sequential jumps across the data), =
we get
> > more than 10 times speed up.  It looks like the input buffer is uncache=
d.
> >=20
> That's right and a reality you have to deal with on those small ARM
> systems. The ARM architecture allows for systems that don't enforce
> hardware coherency across the whole SoC and many of the small/cheap SoC
> variants make use of this architectural feature.
>=20
> What this means is that the CPU caches aren't coherent when it comes to
> DMA from other masters like the video capture units. There are two ways
> to enforce DMA coherency on such systems:
> 1. map the DMA buffers uncached on the CPU
> 2. require explicit cache maintenance when touching DMA buffers with
> the CPU
>=20
> Option 1 is what you see is happening in your setup, as it is simple,
> straight-forward and doesn't require any synchronization points.
>=20
> Option 2 could be implemented by allocating cached DMA buffers in the
> V4L2 device and then executing the necessary cache synchronization in
> qbuf/dqbuf when ownership of the DMA buffer changes between CPU and DMA
> master. However this isn't guaranteed to be any faster, as the cache
> synchronization itself is a pretty heavy-weight operation when you are
> dealing with buffer that are potentially multi-megabytes in size.

My understanding was that the CMA DMA Heap is already allocating
cacheable buffers, with the expectation that you need to call the
dma-buf cache management ioctl. Is it not?

Maxime

--sy76qndjoguffu3e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZbOi7gAKCRDj7w1vZxhR
xc9mAP0Qkiv/Ib8RfwfMNVR56WrzK7iNyty8ScLm3fbR6rMP0QD/eN+6TVbJ7vsy
gP+VmAnGWSPmafvZPyDTuYmVAgH+hAs=
=X2gp
-----END PGP SIGNATURE-----

--sy76qndjoguffu3e--

