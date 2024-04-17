Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDC5171A1
	for <iommu@lists.linux.dev>; Wed, 17 Apr 2024 20:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713385563; cv=none; b=tIGt5rJIbNvriZymjt1JRoC9Zh+aZvAMpRPqMxEy1dDGjPsLzLOLGEFS9k618YoPAOlF9WwbVPSGRUI6mXAGQz1qVZONA78jRcGccxIwGmNyhq4socq9jSIzYiEYYbYvPc3lUiF2uFKD41FJWHq2k5cJCneA90xyGjp67egM/Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713385563; c=relaxed/simple;
	bh=2KikKPzkqw71vNzwdRtF2jiHPqJh9CeOEh3chAxMIFs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hK2oKKhdWFoAsocWia1yTA1rpjqyJTZG5P9p3CMOQ0xRsMvIKRLfsgapSIRU8EoOZ2Gl4aXrT63aLZUR8ONqSC363BeG8tS5jiwcFzFSwgyJGBwS68BIe0NZ91JUfNZu8bwAt0PrsE01k0D3f9NhUl7MUMrWj3aKFuvVxdWPOXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fivLOST2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fivLOST2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713385559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WiKUBm0ytbUIguNDpdb7mMVxPu4fvsZximBw218isO0=;
	b=fivLOST2vGo6MnOXg3i1FQAXqaozuqltZSt6C3ByiIduIQXXngAHeU1pW+tVU/IstiOvRq
	Rej2tkn1SlzoplVGbO6Yyky22xKGIEmGUxU5+nV9Vx6Q9BkF8bYpLTAkW8mWHSkVww3iyZ
	zt/70QEhjWyyLhPiAI41dkjOSUIsQCw=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-s0Dozo51NmCStZk4sled0w-1; Wed, 17 Apr 2024 16:25:57 -0400
X-MC-Unique: s0Dozo51NmCStZk4sled0w-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6ea0d84ca94so122163a34.0
        for <iommu@lists.linux.dev>; Wed, 17 Apr 2024 13:25:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713385557; x=1713990357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4IOnfC4A0RohZ6kwMqfDoY6+tZsEAo9YyC45xU6vlkc=;
        b=oL3R0bBoCMfpZqTvkbmbelWd2rv7SGhLoqabcdQ8vBWKKlkPhpqW/uHJdH+aQiwSSN
         NuxxhsJpXFUiyxC4lRj7QbtwRWm67nqeDK0SDrDStksBp1fJiHGzgeXoglwBX2PylCaT
         6MCx0FxpWELe+MNd2TIqCY1WVgTus3zAZ8NHCzW2TljUfh91LXR/0ZVcTGHeMfky07d4
         iH805Z5V8ada2FWkYRm1XbCyPDUCkEcqzPULHsBaQnkARuc/y5rkvuHAUQ98ly5k2QE/
         F1dabXUhAR3FDpFIRx54A54AwstWEMefhFYxoaSaFqbF4Txt00ydGOqRsgAQMwankW9H
         F0/A==
X-Forwarded-Encrypted: i=1; AJvYcCWU8yrRjCRjU5rX4UgRxYK3FHBToyIue72yHXoI7JE5DAktMTMvDDe92ejMKC5zHZZjFoZNa69M+mJqk4htI9kULGM+3R4=
X-Gm-Message-State: AOJu0YxkXMsnE3Qk3VBxTkPopVkST59KcUw9LgaOKA9rJChhcLPRr6Pi
	dqFB1ZHSUsJZvqhZP0Igh2neOnQ03lbMbihGiejz6RBLgC+Pdeewg5YRNJJD1JT8BZXM1CKdOEg
	36u6O8AKv5wWS14mJCaKVqs3LHJ0q7l3VIuU3fjdzxl9u+utsCOQx
X-Received: by 2002:a9d:69c7:0:b0:6eb:7685:f230 with SMTP id v7-20020a9d69c7000000b006eb7685f230mr605422oto.28.1713385556790;
        Wed, 17 Apr 2024 13:25:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAA5+8BHEzfd8XxwBjBN2DsH0fwZ0zsVuy97fzw0ylgtBKgn+V148PXZFfakl/bTMjiYFHUw==
X-Received: by 2002:a9d:69c7:0:b0:6eb:7685:f230 with SMTP id v7-20020a9d69c7000000b006eb7685f230mr605407oto.28.1713385556512;
        Wed, 17 Apr 2024 13:25:56 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id m6-20020a9d7ac6000000b006eb7e6d2f3dsm30683otn.37.2024.04.17.13.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 13:25:55 -0700 (PDT)
Date: Wed, 17 Apr 2024 14:25:52 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "joro@8bytes.org" <joro@8bytes.org>, "robin.murphy@arm.com"
 <robin.murphy@arm.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "kvm@vger.kernel.org"
 <kvm@vger.kernel.org>, "chao.p.peng@linux.intel.com"
 <chao.p.peng@linux.intel.com>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "Pan, Jacob jun" <jacob.jun.pan@intel.com>
Subject: Re: [PATCH v2 4/4] vfio: Report PASID capability via
 VFIO_DEVICE_FEATURE ioctl
Message-ID: <20240417142552.44382198.alex.williamson@redhat.com>
In-Reply-To: <BN9PR11MB5276D245515E81844B5EC1068C0F2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240412082121.33382-1-yi.l.liu@intel.com>
	<20240412082121.33382-5-yi.l.liu@intel.com>
	<20240416115722.78d4509f.alex.williamson@redhat.com>
	<BN9PR11MB5276D245515E81844B5EC1068C0F2@BN9PR11MB5276.namprd11.prod.outlook.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 17 Apr 2024 07:09:52 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Alex Williamson <alex.williamson@redhat.com>
> > Sent: Wednesday, April 17, 2024 1:57 AM
> >=20
> > On Fri, 12 Apr 2024 01:21:21 -0700
> > Yi Liu <yi.l.liu@intel.com> wrote:
> >  =20
> > > + */
> > > +struct vfio_device_feature_pasid {
> > > +=09__u16 capabilities;
> > > +#define VFIO_DEVICE_PASID_CAP_EXEC=09(1 << 0)
> > > +#define VFIO_DEVICE_PASID_CAP_PRIV=09(1 << 1)
> > > +=09__u8 width;
> > > +=09__u8 __reserved;
> > > +}; =20
> >=20
> > Building on Kevin's comment on the cover letter, if we could describe
> > an offset for emulating a PASID capability, this seems like the place
> > we'd do it.  I think we're not doing that because we'd like an in-band
> > mechanism for a device to report unused config space, such as a DVSEC
> > capability, so that it can be implemented on a physical device.  As
> > noted in the commit log here, we'd also prefer not to bloat the kernel
> > with more device quirks.
> >=20
> > In an ideal world we might be able to jump start support of that DVSEC
> > option by emulating the DVSEC capability on top of the PASID capability
> > for PFs, but unfortunately the PASID capability is 8 bytes while the
> > DVSEC capability is at least 12 bytes, so we can't implement that
> > generically either. =20
>=20
> Yeah, that's a problem.
>=20
> >=20
> > I don't know there's any good solution here or whether there's actually
> > any value to the PASID capability on a PF, but do we need to consider
> > leaving a field+flag here to describe the offset for that scenario? =20
>=20
> Yes, I prefer to this way.
>=20
> > Would we then allow variant drivers to take advantage of it?  Does this
> > then turn into the quirk that we're trying to avoid in the kernel
> > rather than userspace and is that a problem?  Thanks,
> >  =20
>=20
> We don't want to proactively pursue quirks in the kernel.
>=20
> But if a variant driver exists for other reasons, I don't see why it=20
> should be prohibited from deciding an offset to ease the
> userspace. =F0=9F=98=8A

At that point we've turned the corner into an arbitrary policy decision
that I can't defend.  A "worthy" variant driver can implement something
through a side channel vfio API, but implementing that side channel
itself is not enough to justify a variant driver?  It doesn't make
sense.

Further, if we have a variant driver, why do we need a side channel for
the purpose of describing available config space when we expect devices
themselves to eventually describe the same through a DVSEC capability?
The purpose of enabling variant drivers is to enhance the functionality
of the device.  Adding an emulated DVSEC capability seems like a valid
enhancement to justify a variant driver to me.

So the more I think about it, it would be easy to add something here
that hints a location for an emulated PASID capability in the VMM, but
it would also be counterproductive to an end goal of having a DVSEC
capability that describes unused config space.  The very narrow scope
where that side-band channel would be useful is an unknown PF device
which doesn't implement a DVSEC capability and without intervention
simply behaves as it always has, without PASID support.

A vendor desiring such support can a) implement DVSEC in the hardware,
b) implement a variant driver emulating a DVSEC capability, or c)
directly modify the VMM to tell it where to place the PASID capability.
I also don't think we should exclude the possibility that b) could turn
into a shared variant driver that knows about multiple devices and has
a table of free config space for each.  Option c) is only the last
resort if there's not already 12 bytes of contiguous, aligned free
space to place a DVSEC capability.  That seems unlikely.

At some point we need to define the format and use of this DVSEC.  Do
we allow (not require) one at every gap in config space that's at least
12-bytes long and adjust the DVSEC Length to describe longer gaps, or do
we use a single DVSEC to describe a table of ranges throughout extended
(maybe even conventional) config space?  The former seems easier,
especially if we expect a device has a large block of free space,
enough for multiple emulated capabilities and described by a single
DVSEC.  Thanks,

Alex

