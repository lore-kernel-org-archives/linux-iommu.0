Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6B15CBD
	for <iommu@lists.linux.dev>; Tue, 12 Dec 2023 03:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F7/Fz0TB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702352390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SYJnIxx9HNtjukWsV4aCNXJVjuhHUs4t6AEcodIHtHc=;
	b=F7/Fz0TBnEsdjg3tjVpAL7gcDDF8TQkSfBfaQEaaxu0k3rpSFsh+8N38JX19v7ZRzMmsXz
	uwq3YJek4VNwROpo2CuckCNoFTDcjSUX5IoWLlouXlB86jDZAV4Y8nH/j7AV//Mx+We69y
	stsW0arrZxxIbcr4I3XgT4RWjhNqNq0=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-AI78tjapPoqfWK8k1RUh8A-1; Mon, 11 Dec 2023 22:39:48 -0500
X-MC-Unique: AI78tjapPoqfWK8k1RUh8A-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7b71da9f8b9so557245439f.2
        for <iommu@lists.linux.dev>; Mon, 11 Dec 2023 19:39:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702352388; x=1702957188;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SYJnIxx9HNtjukWsV4aCNXJVjuhHUs4t6AEcodIHtHc=;
        b=H749uvO6vwWmP1z02QzMOSHOIZFFJkmWm5iW8icHDa2cc8ohTWvH0V2RSO994KfryK
         0GL+qx3rVQ6WBUYKadE3emoVWBVExXPNy3KdoohDaIzNbke7ttoREh7wnyVdk0cI2d8l
         6w6XhRnZ/Ta1VzzJbEyRqCVw/V3vdSFoeVdEEx68JGoQXJGaV3coG8Axkfah5bawbnzw
         uZon6ZPzRzhSztEdqSloGs8EBmJ+6tCNQsTov+300OoJmhqwkrI5ilJUNRjlZV6N6bme
         xQBmiisTSo5GC7Pvt7BmPT3S1AyZTrxr7T4hH3fEzefEnNa/i6LVqaotvv2CHkJWYsdj
         luYg==
X-Gm-Message-State: AOJu0YyVoLIoLdeVEA6ml9yx/UBGRayCo2yH+ulFqs+UJYsLM5QfaAKb
	u15VNjeqJ1WzTvaqDxcnP1BjAiCwZKivIIJQ0Ml9qti7Z0u7zFwg22McsdF2xADWFlGN+syy6gD
	+/ZZwbMO363JN7BU=
X-Received: by 2002:a6b:dd19:0:b0:7b7:1db4:be12 with SMTP id f25-20020a6bdd19000000b007b71db4be12mr6454352ioc.27.1702352388273;
        Mon, 11 Dec 2023 19:39:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZ71ahGWruZR9wQXJoOb1wDE8WklJ6ZoG4h11zsbQ+dgua70VtFkqtegvadsapT7fi8mxQuQ==
X-Received: by 2002:a6b:dd19:0:b0:7b7:1db4:be12 with SMTP id f25-20020a6bdd19000000b007b71db4be12mr6454342ioc.27.1702352388042;
        Mon, 11 Dec 2023 19:39:48 -0800 (PST)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id fw16-20020a0566381d9000b0043978165d54sm2242042jab.104.2023.12.11.19.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 19:39:47 -0800 (PST)
Date: Mon, 11 Dec 2023 20:39:46 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
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
 <linux-kselftest@vger.kernel.org>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Zeng, Xin" <xin.zeng@intel.com>, "Zhao, Yan
 Y" <yan.y.zhao@intel.com>
Subject: Re: [PATCH 3/3] vfio: Report PASID capability via
 VFIO_DEVICE_FEATURE ioctl
Message-ID: <20231211203946.35552183.alex.williamson@redhat.com>
In-Reply-To: <SJ0PR11MB674458A8B7319F30A67FE55F928EA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231127063909.129153-1-yi.l.liu@intel.com>
	<20231127063909.129153-4-yi.l.liu@intel.com>
	<20231211110345.1b4526c6.alex.williamson@redhat.com>
	<SJ0PR11MB674458A8B7319F30A67FE55F928EA@SJ0PR11MB6744.namprd11.prod.outlook.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Dec 2023 02:43:20 +0000
"Duan, Zhenzhong" <zhenzhong.duan@intel.com> wrote:

> >-----Original Message-----
> >From: Alex Williamson <alex.williamson@redhat.com>
> >Sent: Tuesday, December 12, 2023 2:04 AM
> >Subject: Re: [PATCH 3/3] vfio: Report PASID capability via
> >VFIO_DEVICE_FEATURE ioctl
> >
> >On Sun, 26 Nov 2023 22:39:09 -0800
> >Yi Liu <yi.l.liu@intel.com> wrote:
> >  
> >> This reports the PASID capability data to userspace via  
> >VFIO_DEVICE_FEATURE,  
> >> hence userspace could probe PASID capability by it. This is a bit different
> >> with other capabilities which are reported to userspace when the user  
> >reads  
> >> the device's PCI configuration space. There are two reasons for this.
> >>
> >>  - First, Qemu by default exposes all available PCI capabilities in vfio-pci
> >>    config space to the guest as read-only, so adding PASID capability in the
> >>    vfio-pci config space will make it exposed to the guest automatically  
> >while  
> >>    an old Qemu doesn't really support it.  
> >
> >Shouldn't we also be working on hiding the PASID capability in QEMU
> >ASAP?  This feature only allows QEMU to know PASID control is actually
> >available, not the guest.  Maybe we're hoping this is really only used
> >by VFs where there's no capability currently exposed to the guest?  
> 
> PASID capability is not exposed to QEMU through config space,
> VFIO_DEVICE_FEATURE ioctl is the only interface to expose PASID
> cap to QEMU for both PF and VF.
> 
> /*
>  * Lengths of PCIe/PCI-X Extended Config Capabilities
>  *   0: Removed or masked from the user visible capability list
>  *   FF: Variable length
>  */
> static const u16 pci_ext_cap_length[PCI_EXT_CAP_ID_MAX + 1] = {
> ...
>         [PCI_EXT_CAP_ID_PASID]  =       0,      /* not yet */
> }

Ah, thanks.  The comment made me think is was already exposed and I
didn't double check.  So we really just want to convey the information
of the PASID capability outside of config space because if we pass the
capability itself existing userspace will blindly expose a read-only
version to the guest.  That could be better explained in the commit log
and comments.

So how do we keep up with PCIe spec updates relative to the PASID
capability with this proposal?  Would it make more sense to report the
raw capability register and capability version rather that a translated
copy thereof?  Perhaps just masking the fields we're currently prepared
to expose.  Thanks,

Alex

