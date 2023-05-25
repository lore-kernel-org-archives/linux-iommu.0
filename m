Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FCD1F95C
	for <iommu@lists.linux.dev>; Thu, 25 May 2023 18:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1685038013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SzSfpsq2356XHkb2QDUQBhgOm68dhuABZh5i5F//rUY=;
	b=LOzDP3FplhFsgEX4A5sWqMFLa1RKuGNu0Z71tFZ8hgfl1BI0L5nX6a2JrUcaDjlscy8b1j
	+JizNliuHLfXseRloxLCgNl9FT2KJI6XhwAzoeJ7NwszmsyRvW5608RMkL2PNjCjD0s918
	Ck9AaGsH5mkoS/aJF0W9RmBlMfzHYjg=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-BLRwEugMMRaIB3V7mtVmgg-1; Thu, 25 May 2023 14:06:52 -0400
X-MC-Unique: BLRwEugMMRaIB3V7mtVmgg-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-33832eab83cso44554755ab.1
        for <iommu@lists.linux.dev>; Thu, 25 May 2023 11:06:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685038011; x=1687630011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/STt3uYUF/eA3pcGXeIfU31ic0BPqfIYsBRnvLLrcA8=;
        b=UtNILZ86e6ndWz9Hsz3s1HdUzNQqVIxaAobK4jLdXhg9FSmgXASPlBuJBNcWMbNaCn
         n47r0LnXMdttFGxYvbRiZ2FERqqiTtzBQRc7eoEjUOz/cBFmanZP4inK1f+XPAlddyHv
         IhWKUZidp/MfSGsxM0it+3aCJOcrMV/JazptcMohFGS0dFMjTjl1SDudAg24G2SCnWAm
         tsgIu6wE65VtwQjio95cceJYd6WK870cHhO8LSN30jYLAwTG6I/P5Yce7eD5hyd7lIlC
         Ek8XPd2jmkmAqIlKGe19YyvJaMZ4GcB0ZYoRK5QhIe1Q+ID3t7iksEoT/xLDPXe1eqLS
         dagQ==
X-Gm-Message-State: AC+VfDzMKjGSL7sYrNtvmCBUUCQBdRRJVCdw6W/uPQkozfpMuwyyPpq5
	qArBUr92ai2w8TWt8RiODTl++tHem9NuhMHFw8SaRySj448zk12umNz+CcFQTSrUJildff59MtV
	VaBlvh+92TJcrRUk=
X-Received: by 2002:a92:cc92:0:b0:332:dd0a:c6df with SMTP id x18-20020a92cc92000000b00332dd0ac6dfmr15399947ilo.22.1685038011243;
        Thu, 25 May 2023 11:06:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5f0lXAJzyZMLgAAku3HttSAaB/9PyTut5L0+yIVgNcAGnDpm9J3odo9mu57GJnqdXcMVWWew==
X-Received: by 2002:a92:cc92:0:b0:332:dd0a:c6df with SMTP id x18-20020a92cc92000000b00332dd0ac6dfmr15399922ilo.22.1685038011006;
        Thu, 25 May 2023 11:06:51 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id v18-20020a056638359200b004145ebbf193sm559419jal.51.2023.05.25.11.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 11:06:50 -0700 (PDT)
Date: Thu, 25 May 2023 12:06:48 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "robin.murphy@arm.com"
 <robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
 "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
 "yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "lulu@redhat.com"
 <lulu@redhat.com>, "suravee.suthikulpanit@amd.com"
 <suravee.suthikulpanit@amd.com>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
 <linux-kselftest@vger.kernel.org>, "Duan, Zhenzhong"
 <zhenzhong.duan@intel.com>
Subject: Re: [PATCH v3 00/10] Add Intel VT-d nested translation
Message-ID: <20230525120648.70d954fb.alex.williamson@redhat.com>
In-Reply-To: <BN9PR11MB52765FA8255FB8F8A1A6F11B8C419@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230511145110.27707-1-yi.l.liu@intel.com>
	<BN9PR11MB52765FA8255FB8F8A1A6F11B8C419@BN9PR11MB5276.namprd11.prod.outlook.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
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

On Wed, 24 May 2023 08:59:43 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Liu, Yi L <yi.l.liu@intel.com>
> > Sent: Thursday, May 11, 2023 10:51 PM
> >=20
> > The first Intel platform supporting nested translation is Sapphire
> > Rapids which, unfortunately, has a hardware errata [2] requiring specia=
l
> > treatment. This errata happens when a stage-1 page table page (either
> > level) is located in a stage-2 read-only region. In that case the IOMMU
> > hardware may ignore the stage-2 RO permission and still set the A/D bit
> > in stage-1 page table entries during page table walking.
> >=20
> > A flag IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17 is introduced to
> > report
> > this errata to userspace. With that restriction the user should either
> > disable nested translation to favor RO stage-2 mappings or ensure no
> > RO stage-2 mapping to enable nested translation.
> >=20
> > Intel-iommu driver is armed with necessary checks to prevent such mix
> > in patch10 of this series.
> >=20
> > Qemu currently does add RO mappings though. The vfio agent in Qemu
> > simply maps all valid regions in the GPA address space which certainly
> > includes RO regions e.g. vbios.
> >=20
> > In reality we don't know a usage relying on DMA reads from the BIOS
> > region. Hence finding a way to allow user opt-out RO mappings in
> > Qemu might be an acceptable tradeoff. But how to achieve it cleanly
> > needs more discussion in Qemu community. For now we just hacked Qemu
> > to test.
> >  =20
>=20
> Hi, Alex,
>=20
> Want to touch base on your thoughts about this errata before we
> actually go to discuss how to handle it in Qemu.
>=20
> Overall it affects all Sapphire Rapids platforms. Fully disabling nested
> translation in the kernel just for this rare vulnerability sounds an over=
kill.
>=20
> So we decide to enforce the exclusive check (RO in stage-2 vs. nesting)
> in the kernel and expose the restriction to userspace so the VMM can
> choose which one to enable based on its own requirement.
>=20
> At least this looks a reasonable tradeoff to some proprietary VMMs
> which never adds RO mappings in stage-2 today.
>=20
> But we do want to get Qemu support nested translation on those
> platform as the widely-used reference VMM!
>=20
> Do you see any major oversight before pursuing such change in Qemu
> e.g. having a way for the user to opt-out adding RO mappings in stage-2? =
=F0=9F=98=8A

I don't feel like I have enough info to know what common scenarios are
going to make use of 2-stage and nested configurations and how likely a
user is to need such an opt-out.  If it's likely that a user is going
to encounter this configuration, an opt-out is at best a workaround.
It's a significant support issue if a user needs to generate a failure
in QEMU, notice and decipher any log messages that failure may have
generated, and take action to introduce specific changes in their VM
configuration to support a usage restriction.

For QEMU I might lean more towards an effort to better filter the
mappings we create to avoid these read-only ranges that likely don't
require DMA mappings anyway.

How much does this affect arbitrary userspace vfio drivers?  For
example are there scenarios where running in a VM with a vIOMMU
introduces nested support that's unknown to the user which now prevents
this usage?  An example might be running an L2 guest with a version of
QEMU that does create read-only mappings.  If necessary, how would lack
of read-only mapping support be conveyed to those nested use cases?
Thanks,

Alex

