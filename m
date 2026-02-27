Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EBE3D1CC5
	for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 09:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772183707; cv=none; b=FUgLb3w7dQTxvlbsBqy12dZ4SjTs9ugi6woD9r4d3fs+UBkjesC8Y/sXZLl+oz/M0VDn2ALMDeE1ZU71QbrBJfAw0DUFuPdAEp3rz4TS61G6insyY6b1vt8GTl6quupvhxZVXC65lWVnorJM8gOYULmheSLAr5fQwwB5zdSiDpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772183707; c=relaxed/simple;
	bh=SN/V8YGuTcxY85kDU89KkD1e6w8cvJs3/3Dd7L0T5yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K06Iw/OpZviEdnWnFovHFaHDiix+1L7MyV54aVnlfIU1rT6zxBNAATKc9etLxdrZt9QHjNBgAX5h0ud5rP6NEVGKh7KDmy5RylqG7VF4yV5d8tycPaRPjO28K4x6FCTAfWWxj0ICGZXwo9srWwXZZ0vZBLsX4m3kfECZvZnQdJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R9CTuJ9i; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RiQp8TFt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R9CTuJ9i";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RiQp8TFt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772183702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SN/V8YGuTcxY85kDU89KkD1e6w8cvJs3/3Dd7L0T5yk=;
	b=R9CTuJ9i7ITbFT/y855/nbacwtvwU6vOVh3VBc3zUvgPd1s+rJgGzoMZgzVctn2eSJVOpN
	zUMKiTRH1UxNCbWlGGN9h1S46bNzAlmkjdnT9QkHfVREsu4vxCX/9Jhn4/ri4pUG+Nnp4N
	nGVJdsOXmQhr5nN8O9AJ2jggs2e08Xc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-rKGV_NzDPCGx0_UsLJZGtA-1; Fri, 27 Feb 2026 04:15:00 -0500
X-MC-Unique: rKGV_NzDPCGx0_UsLJZGtA-1
X-Mimecast-MFC-AGG-ID: rKGV_NzDPCGx0_UsLJZGtA_1772183699
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-439972a5edbso1457032f8f.0
        for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 01:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772183699; x=1772788499; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SN/V8YGuTcxY85kDU89KkD1e6w8cvJs3/3Dd7L0T5yk=;
        b=RiQp8TFtdx3GP6mpjxjEHuSukuymSL0aIhyG/kHRuJMitWkl3y9cTLlwiwyyXlvd8S
         Ugi4p19NoocjFpIv5stgoDFsQ0mSNUG8HSSJ4cwuB53LKlWul3+Ep54k066aEiY/8HrV
         GR1AYPUYyfa7XfQS8TaNIBTkcs/L06bHeRAi58aiylSPGhVNmzWzUivcRXtSt0NTes1z
         jWmnoEvtNw0BfeyNB3uYT4KbBBh7cBNUl5RR3yVh4Y1jvSVqhLt7DTVx90U3gMhAr/9Z
         mEF4LRfTV0Mtf+GH55y+sj5q9jLCAcYqR1CvXLrm0O+X3U3z7/bHD/Y/gC0H/d/XhSyD
         Nb3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772183699; x=1772788499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SN/V8YGuTcxY85kDU89KkD1e6w8cvJs3/3Dd7L0T5yk=;
        b=euUp48GBjPqiEC+q++K3ph1zEMMMO37o3KHb2y7B+NZhjZ57NKA5vkkgurcqRTKynj
         OXWh/pn7r6S4yUmQ/ZYLoAfvBy0ITAhHFqzpA0zE+LlCuCVY5N5A3hJ5Ym6fqyvHUidM
         rg/PwmnIeP3INohiqRtHcBG/Hm7M4dsWibskgrGig5cvPlZ7ZK8eqQ7DcGFJHMKtdyaq
         4/1L2fecSWav6a/GBgpWtzNwBXNINTRgrwal1CRTpVmoibl3KTpoaMFYb7Vd+4Blew+b
         +Kg2r4g5ykyM8xFlnMNbs95disOX816EnFYofYzkAsPf5YY3Ggjqs9aFwbNWR8i9RDGp
         wEKw==
X-Forwarded-Encrypted: i=1; AJvYcCXPpi5oTCqEYKl4k2L00heYqLCEBCZrO/Tky+u9PwI9blmnx+5MXeIi7uikhXe4YChk/k9V7Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywz69c3S2ORBcNHDPB8E5JL/R2EMBpXgmAupYtHadXNJGuyFtNv
	8hlEjhXgcwL9yLGhyqVfg8oADhPnnUufsorQqrtBEl5VcU8cE/L4hb0DX0ZN5OX/W9eg2Gq8v6f
	nr2MxLJ5EkSeKyDV0l7cTY418fbxajiO4Sintqqi6q9Sgj6F6Nm0liWtZ
X-Gm-Gg: ATEYQzx0bo1BzczXNHkyYFrQwPgbwpATkIbeQwGSyi/C/SKxctajzcBSLdAmxBGm0aE
	cALocE9p4fE1mo4CFS6ikbQZwg0uLwJ8jB9P1rSHum+0fmvCD2H+VfGyIcItnqxh/PaBfSA+YrR
	xfxyuUbMBnf34CzwJD3wT+1ndPNxoRFWSw7whe/6Mswf+TN2HDsVlvAMDRWr6g7tVx6fPah65eE
	4eLUdfto5ZC+bFADIOcx0sCZzsfv9IeQzCvJzWBCZrto9O9ZFGKwiyRTgH4QfnRLc2U+GkzA+la
	Sdg9QbYlWEdYXSFiTLMbK8+ybvsibpYEoIVTj3FkgndriUP4P0A0Jq8mT0S6dIDtQTlSIUfOpg=
	=
X-Received: by 2002:a05:6000:26cb:b0:432:c0e8:4a33 with SMTP id ffacd0b85a97d-4399de14d4cmr3501756f8f.22.1772183698405;
        Fri, 27 Feb 2026 01:14:58 -0800 (PST)
X-Received: by 2002:a05:6000:26cb:b0:432:c0e8:4a33 with SMTP id ffacd0b85a97d-4399de14d4cmr3501597f8f.22.1772183697160;
        Fri, 27 Feb 2026 01:14:57 -0800 (PST)
Received: from localhost ([2a01:e0a:b25:f902::ff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c76b20bsm5748279f8f.35.2026.02.27.01.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 01:14:56 -0800 (PST)
Date: Fri, 27 Feb 2026 10:14:56 +0100
From: Maxime Ripard <mripard@redhat.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Albert Esteve <aesteve@redhat.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
	Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, 
	"T.J. Mercier" <tjmercier@google.com>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev, 
	echanude@redhat.com
Subject: Re: [PATCH] dma-buf: heaps: Add Coherent heap to dmabuf heaps
Message-ID: <20260227-gleaming-saffron-binturong-580b3f@houat>
References: <20260224-b4-dmabuf-heap-coherent-rmem-v1-1-dffef43298ac@redhat.com>
 <d05a81ff-c6af-4621-9593-d06f80220e34@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="hjogu5z26zgaiwsw"
Content-Disposition: inline
In-Reply-To: <d05a81ff-c6af-4621-9593-d06f80220e34@arm.com>


--hjogu5z26zgaiwsw
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] dma-buf: heaps: Add Coherent heap to dmabuf heaps
MIME-Version: 1.0

Hi Robin,

On Thu, Feb 26, 2026 at 03:22:05PM +0000, Robin Murphy wrote:
> On 24/02/2026 7:57 am, Albert Esteve wrote:
> > Add a dma-buf heap for DT coherent reserved-memory
> > (i.e., 'shared-dma-pool' without 'reusable' property),
> > exposing one heap per region for userspace buffers.
>=20
> Despite the "shared" naming of the compatible, these kinds of reservations
> are often for highly device-specific purposes, and sometimes may not even=
 be
> accessible to other devices at all, so it's far from clear that there's a
> generic use-case for connecting them to dma-buf. Certainly it doesn't seem
> like a good idea to unconditionally create heaps for *everyting*, and give
> userspace free reign to mess with things it doesn't necessarily understand
> (especially where usage-specific restrictions implied by "no-map" are
> involved) and which may break drivers.

So, let's take a step back. We want to enable cgroup memory accounting
for any buffer allocation done through an ioctl, so DRM dumb buffers,
BOs, v4l2 buffers, dma-buf heap allocations, etc.

system memory would be tracked by the memcg cgroup memory, dedicated
memory pool through dmem, and CMA is kind of up in the air at the
moment, but probably both.

That means that when calling dma_alloc_attrs (or one of its variants),
you would not know which cgroup controller it's going to account into,
and thus enforcing limits becomes difficult.

So the plan discussed last year with the DRM (and then v4l2) maintainers
was to get away from using dma_alloc_attrs entirely and rely on the
heaps instead. Heap drivers would always allocate from the same cgroup
controller, so it's easier that way.

So, in order to get there, we need to create a heap instance for every
possible dma_alloc_attrs backend.

We have that for CMA and GFP already, but we're missing coherent (and
maybe more?).

> Most drivers that accomodate a memory-region expect to manage it themselv=
es,
> so I would think it should be up to the drivers to opt into delegating
> "their" pool to userspace by registering it as a heap. Or at very worst, =
at
> least some additional DT compatible or property to indicate that it really
> is safe and desirable to use a given pool in a truly shared manner.

I'm not sure a DT property is going to work there, because then we're
going to have drivers bypassing cgroup accounting forever. That being
said, I think we can work with the opt-in option you were mentioning.
That way, we could do it at the DRM/v4l2 framework level and roll it out
for all those drivers, without affecting the other framework and drivers
that could use it.

> Otherwise, If we just present some heaps named "memory@xyz" to userspace
> (arch/arm64/boot/dts/ti/k3-j784s4-j742s2-ti-ipc-firmware-common.dtsi is a
> fun example), do we really expect it to maintain exhaustive
> platform-specific knowledge of which actual device(s) they belong to and
> what they're for?

That ship has kind of sailed already. I'm not pleased about it either,
but it was the outcome of the discussion last time.

> And if it does try to just mess around and allocate and map stuff, how
> does the dma-buf layer also have all of that usage-specific detail to
> know what memory attributes are safe to map with etc.?

Sorry, I'm not quite sure what you mean by that. Did you mean how we
have to care about caching for example, or something else?

Maxime

--hjogu5z26zgaiwsw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaaFgiwAKCRAnX84Zoj2+
dqyJAYC1uBydtbMfbpOFtGCNJsHB17IA4OH5sJIk3fS2LDU/EQuKyKw7R/VeibN4
q57PX2IBf2dgDshYL8OBvoLDgsJkfFUj0iSSKlBoDlKgHznvB/qC6QhahQoiJcKe
NX2SEVA1rQ==
=liUf
-----END PGP SIGNATURE-----

--hjogu5z26zgaiwsw--

