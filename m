Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733911BD9DD
	for <iommu@lists.linux.dev>; Wed, 30 Oct 2024 17:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730310709; cv=none; b=kYxWXHKddgd4HS8vBZdRwoydePSr9/67Gdt/fybvcnoKXT5tf/RHTG2n/k5ueK26jDxW2twHoS8387HLg5Ba6NGB7iYdnsg5+fWzGq+1l12uH8Uau2AdaS1qHkq3ulLZmRBvmJpzTcoAArZbYXZlTJBqw+1hF7vXwKs9JMkqnyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730310709; c=relaxed/simple;
	bh=saNbIlVdEqqC4ltXv5t9RhVhmw5DouSxU+nGMp/pe7I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WvL+6UhZjUG9QpxTs2j3Qnh1Vt2JJHCdXfYfCfe7woJXfXBcKQag4jgFWM2XIanXYc9szyeg3HimMUsSFj1riRKrfyKVfp/ip7GQjcbkw83MOZF/9CmkuhDcGfL/xJbtXrjEcGEtHSomCyrhmOEVLbzvpDet41wlGuTbSFaX1fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q73w2MwX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q73w2MwX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730310706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PRI+nVH977o2CNG85WRi8m4LfzwUnyZlbbFLyGSJ+sc=;
	b=Q73w2MwXlsHWia6HaO4fxRgw9KVMddYpYQ6DLyxRSBlCqXFWWmgU4Fn7VLIpFGpBDcjJeq
	3xjNkFss/ya5U5nD+N+bEjPhHQts32j2EYp3ifFTadCF/aQrDRilYnLzy3WiABuGB2SZnm
	/+uJTF8cZ3H1wjkYW3JbY1accoz6Qdc=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-GW9pe2rqNmKBe6aYzJhK1Q-1; Wed, 30 Oct 2024 13:51:45 -0400
X-MC-Unique: GW9pe2rqNmKBe6aYzJhK1Q-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83ab75ce25bso816339f.1
        for <iommu@lists.linux.dev>; Wed, 30 Oct 2024 10:51:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730310705; x=1730915505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BlMqPGC69f2ZEKA06LeNQcKifqh1+b0YfPHQw2uDodk=;
        b=Hvog2/PBvAdW0HXO2cEZv4VAMv06GejCrPFTYwvnN2w5dlrrH5DM1DjYpC/xVZzUGG
         4vxpOAkAiy4RWYolGgVFlnjY6R23j1V6CemRA3zyvoBt75VLL8XpumAadgMb7dRmWm1G
         BnLmxCPpDI+OY0fj+nwZcC2FUpFsKPYvskADUwqV1fBrxNX//fMt2GN5+nvHXwKqgpSC
         YYj/Mb2tUMjyOAJtSY2/JHzcgpn3SNEYjQxP0rELmzy1w55Z9x583MyEbLN6q/qrbyup
         lLeyZkhd/GsEkoJs/yNsKyn7h9uH1xbagcZQ3VKnht1rOnjjnIgIDuw4GSnIHFa6ztxo
         YaCg==
X-Forwarded-Encrypted: i=1; AJvYcCWHCSsFYm8DYGhUQ8FZJ7nJXNIOQYY9WhSTtc91Eh/FqKlzbyxG4a53l0X4TI83do/dO1jWzA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxDAsbTMQ+hOIwBtnfvPSufIwG2dej7yf5Whx2p3BKQmOl7AjkH
	S8xJKiFhr3t0Vcm/ELNam9d6JKk1HENEhQw7jqDGOxrFNq6AoTAkGW/EN9ltC0sHhcF9IJZ06YB
	og2tOPKHp0HsNKp2zvYn/V7kxsTK+Eh21eubota8C5kusfS3eZvpt
X-Received: by 2002:a05:6e02:20e4:b0:3a1:a179:bb40 with SMTP id e9e14a558f8ab-3a4ed30cd2emr40337015ab.3.1730310704729;
        Wed, 30 Oct 2024 10:51:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEo36jEi2FfwuOtKXpUTZdSh49MOAvafNJJvwYdaWjXfrDGx6qbO4/TWGSuq+5pB5erbrb8yQ==
X-Received: by 2002:a05:6e02:20e4:b0:3a1:a179:bb40 with SMTP id e9e14a558f8ab-3a4ed30cd2emr40336785ab.3.1730310704251;
        Wed, 30 Oct 2024 10:51:44 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a5e7c159c5sm1866885ab.74.2024.10.30.10.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 10:51:43 -0700 (PDT)
Date: Wed, 30 Oct 2024 11:51:42 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "joro@8bytes.org" <joro@8bytes.org>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "chao.p.peng@linux.intel.com"
 <chao.p.peng@linux.intel.com>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "vasant.hegde@amd.com" <vasant.hegde@amd.com>
Subject: Re: [PATCH v3 3/4] vfio: Add
 VFIO_DEVICE_PASID_[AT|DE]TACH_IOMMUFD_PT
Message-ID: <20241030115142.47272017.alex.williamson@redhat.com>
In-Reply-To: <7d8b2457-8dc4-43d1-9a12-19e2a71a0821@intel.com>
References: <20240912131729.14951-1-yi.l.liu@intel.com>
	<20240912131729.14951-4-yi.l.liu@intel.com>
	<BN9PR11MB5276D2D0EEAC2904EDB60B048C762@BN9PR11MB5276.namprd11.prod.outlook.com>
	<20241001121126.GC1365916@nvidia.com>
	<a435de20-2c25-46f5-a883-f10d425ef37e@intel.com>
	<20241014094911.46fba20e.alex.williamson@redhat.com>
	<2e5733a2-560e-4e8f-b547-ed75618afca5@intel.com>
	<20241015102215.05cd16c7.alex.williamson@redhat.com>
	<e76e4dec-f4d7-4a69-a670-88a2f4e10dd7@intel.com>
	<20241016101134.0e13f7d7.alex.williamson@redhat.com>
	<7f95f2cc-6691-4f40-bc50-e4430ebdbf1e@intel.com>
	<7d8b2457-8dc4-43d1-9a12-19e2a71a0821@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
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

On Wed, 30 Oct 2024 20:54:09 +0800
Yi Liu <yi.l.liu@intel.com> wrote:

> Hi Alex,
>=20
> On 2024/10/18 13:40, Yi Liu wrote:
> >>>> I think we need to monotonically increase the structure size,
> >>>> but maybe something more like below, using flags.=C2=A0 The expectat=
ion
> >>>> would be that if we add another flag that extends the structure, we'=
d
> >>>> test that flag after PASID and clobber xend to a new value further i=
nto
> >>>> the new structure.=C2=A0 We'd also add that flag to the flags mask, =
but we'd
> >>>> share the copy code. =20
> >>>
> >>> agree, this share code might be needed for other path as well. Some m=
acros
> >>> I guess.
> >>> =20
> >>>>
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0if (attach.argsz < minsz)
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
> >>>>
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0if (attach.flags & (~VFIO_DEVICE_ATTACH_PASI=
D))
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
> >>>>
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0if (attach.flags & VFIO_DEVICE_ATTACH_PASID)
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xend =3D offsetofend(stru=
ct vfio_device_attach_iommufd_pt, pasid);
> >>>>
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0if (xend) {
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (attach.argsz < xend)
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eturn -EINVAL; =20
>=20
> Need to check the future usage of 'xend'. In understanding, 'xend' should
> always be offsetofend(struct, the_last_field). A userspace that uses @pas=
id=20
> field would set argsz >=3D offsetofend(struct, pasid), most likely it wou=
ld
> just set argsz=3D=3Doffsetofend(struct, pasid). If so, such userspace wou=
ld be
> failed when running on a kernel that has added new fields behind @pasid.

No, xend denotes the end of the structure we need to satisfy the flags
that are requested by the user.
=20
> Say two decades later, we add a new field (say @xyz) to this user struct,
> the 'xend' would be updated to be offsetofend(struct, xyz). This 'xend'
> would be larger than the argsz provided by the aforementioned userspace.
> Hence it would be failed in the above check.

New field xyz would require a new flag, VFIO_DEVICE_XYZ and we'd extend
the above code as:

=09if (attach.argsz < minsz)
=09=09return -EINVAL;

=09if (attach.flags & (~(VFIO_DEVICE_ATTACH_PASID |
=09=09=09      VFIO_DEVICE_XYZ)))
=09=09return -EINVAL;

=09if (attach.flags & VFIO_DEVICE_ATTACH_PASID)
=09=09xend =3D offsetofend(struct vfio_device_attach_iommufd_pt, pasid);

=09if (attach.flags & VFIO_DEVICE_XYZ)
=09=09xend =3D offsetofend(struct vfio_device_attach_iommufd_pt, xyz);

=09if (xend) {
=09=09if (attach.argsz < xend)
=09=09=09return -EINVAL; =20

New userspace can provide argsz =3D offsetofend(, xyz), just as it could
provide argsz =3D PAGE_SIZE now if it really wanted, but argsz > minsz is
only required if the user sets any of these new flags.  Therefore old
userspace on new kernel continues to work.

> To make it work, I'm
> considering to make some changes to the code. When argsz < xend, we only
> copy extra data with size=3D=3Dargsz-minsz. Just as the below.
>=20
> =09if (xend) {
> =09=09unsigned long size;
>=20
> =09=09if (attach.argsz < xend)

This is an -EINVAL condition, xend tracks the flags the user has set.
The user must provide a sufficient buffer for the flags they've set.

> =09=09=09size =3D attach.argsz - minsz;
> =09=09else
> =09=09=09size =3D xend - minsz;

This is the only correct copy size.

>=20
> =09=09if (copy_from_user((void *)&attach + minsz,
> =09=09=09=09  (void __user *)arg + minsz, size))
> =09=09=09return -EFAULT;
> =09}
>=20
> However, it seems to have another problem. If the userspace that uses
> @pasid set the argsz=3D=3Doffsetofend(struct, pasid) - 1, such userspace =
is
> not supposed to work and should be failed by kernel. is it? However, my
> above code cannot fail it. :(
>=20
> Any suggestion about it?

If a user sets the ATTACH_PASID flag and argsz is less than
offsetofend(struct, pasid), we need to return -EINVAL as indicated
above.  Thanks,

Alex

>=20
> >>>>
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (copy_from_user((void =
*)&attach + minsz,
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (void __user *)arg + minsz=
, xend - minsz))
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eturn -EFAULT;
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0} =20
> >>> =20
>=20

