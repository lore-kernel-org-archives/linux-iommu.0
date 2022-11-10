Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078901A601
	for <iommu@lists.linux.dev>; Thu, 10 Nov 2022 17:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1668100235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3XBNZVfwHOyxrKzEqgSDBaV/kDGeCsLaREPRXxkN8EM=;
	b=NkZJTQsuFZw+7N6PvaN5wTx0ag+rWgUjKGkZjCxER0FBFfEvcczdu/3q3gxgT6Cf7ljAHp
	+7Lxfwscpb3dCFEpBJH5xgW5zCZtaWAbrsM9/jSCM3bI7PdU90ZbwUrglnI3atzshZL5K7
	fvVQ4D7eEXUEbm/9My4hkrE7ywikF6w=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-413-Tu8wZQ6aOlyoXgfm_mEKHA-1; Thu, 10 Nov 2022 12:10:27 -0500
X-MC-Unique: Tu8wZQ6aOlyoXgfm_mEKHA-1
Received: by mail-il1-f197.google.com with SMTP id h20-20020a056e021d9400b00300581edaa5so1993940ila.12
        for <iommu@lists.linux.dev>; Thu, 10 Nov 2022 09:10:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3XBNZVfwHOyxrKzEqgSDBaV/kDGeCsLaREPRXxkN8EM=;
        b=J73t4OsrX4z9qb9WVOetzm8GqZOx3L29UbLoIWlVwh4WlwB3z7BCBGwiX0Y6mgKLeV
         PQWiSvNiaLG8rus1Ojub05sz+L8FrnakapWI9X6UvoLNWvtI/Tc0Jc6f65PKnbkj5FX+
         /OhIdTAf1sW1eV8vqJGjgSkqz8SRjRpMKoG8KOaGTntQOpjodaexoI+NiACgcessPzo8
         IEAujVWVyCCqdVVTKVtjG0/fmpPH6vL0K3o8H8BweKM0YZIfa2AULrZfzFi+TiC0Y3M8
         ukBCwJQ5wLvmbxMTMsrZo0fMVKvbd5YlM2cJIAQh1pF9CFlY/f9YWo4qDFG9paZLVnBY
         Zwig==
X-Gm-Message-State: ACrzQf1FfWYOKVwNLcYbYQIH2crQDPBWskfO+WG+W71K0RJYnGKc5iZY
	zXpt/Jekn+Jdjc8E6xJtQKl2Libyc1SizhQTSAQqLYBxSS3Ip0D959doWg30fPEVoZIk/Ne9iCl
	LKmECzUtmEGMJ6GA=
X-Received: by 2002:a05:6638:4413:b0:374:fbbe:2da6 with SMTP id bp19-20020a056638441300b00374fbbe2da6mr3149431jab.163.1668100226568;
        Thu, 10 Nov 2022 09:10:26 -0800 (PST)
X-Google-Smtp-Source: AMsMyM5st2ROvi8y5IPXYSHhk18Mv2oS6m3aLQCRNeAm9L0KyqI2dN1lMnwqPxWnGmIZODwHu3sF6g==
X-Received: by 2002:a05:6638:4413:b0:374:fbbe:2da6 with SMTP id bp19-20020a056638441300b00374fbbe2da6mr3149377jab.163.1668100226283;
        Thu, 10 Nov 2022 09:10:26 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id m1-20020a924a01000000b002f9652849f6sm30029ilf.67.2022.11.10.09.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 09:10:25 -0800 (PST)
Date: Thu, 10 Nov 2022 10:10:23 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, David Airlie <airlied@gmail.com>, Tony Krowiak
 <akrowiak@linux.ibm.com>, "Christian Borntraeger"
 <borntraeger@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Daniel
 Vetter <daniel@ffwll.ch>, Diana Craciun <diana.craciun@oss.nxp.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Eric
 Auger" <eric.auger@redhat.com>, Eric Farman <farman@linux.ibm.com>, "Harald
 Freudenberger" <freude@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, "intel-gfx@lists.freedesktop.org"
 <intel-gfx@lists.freedesktop.org>, "intel-gvt-dev@lists.freedesktop.org"
 <intel-gvt-dev@lists.freedesktop.org>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Jani Nikula <jani.nikula@linux.intel.com>, "Jason
 Herne" <jjherne@linux.ibm.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-s390@vger.kernel.org"
 <linux-s390@vger.kernel.org>, Longfang Liu <liulongfang@huawei.com>,
 "Matthew Rosato" <mjrosato@linux.ibm.com>, Peter Oberparleiter
 <oberpar@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Robin Murphy
 <robin.murphy@arm.com>, "Vivi, Rodrigo" <rodrigo.vivi@intel.com>, "Shameer
 Kolothum" <shameerali.kolothum.thodi@huawei.com>, Sven Schnelle
 <svens@linux.ibm.com>, Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 Vineeth Vijayan <vneethv@linux.ibm.com>, Will Deacon <will@kernel.org>,
 Yishai Hadas <yishaih@nvidia.com>, Zhenyu Wang <zhenyuw@linux.intel.com>,
 "Wang, Zhi A" <zhi.a.wang@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 10/11] vfio: Make vfio_container optionally compiled
Message-ID: <20221110101023.28e7a790.alex.williamson@redhat.com>
In-Reply-To: <BN9PR11MB5276494548F01A42694E366A8C019@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v2-65016290f146+33e-vfio_iommufd_jgg@nvidia.com>
	<10-v2-65016290f146+33e-vfio_iommufd_jgg@nvidia.com>
	<20221108152831.1a2ed3df.alex.williamson@redhat.com>
	<Y2r6YnhuR3SxslL6@nvidia.com>
	<20221109101809.2ff08303.alex.williamson@redhat.com>
	<Y2wFFy0cxIIlCeTu@nvidia.com>
	<BN9PR11MB5276494548F01A42694E366A8C019@BN9PR11MB5276.namprd11.prod.outlook.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
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

On Thu, 10 Nov 2022 06:57:57 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Thursday, November 10, 2022 3:53 AM
> > 
> > On Wed, Nov 09, 2022 at 10:18:09AM -0700, Alex Williamson wrote:
> >   
> > > DPDK supports no-iommu mode.  
> > 
> > Er? Huh? How? I thought no-iommu was for applications that didn't do
> > DMA? How is DPDK getting packets in/out without DMA? I guess it snoops
> > in /proc/ or something to learn PFNs of mlock'd memory? <shudder>  
> 
> iirc dpdk started with UIO plus various tricks (root privilege, hugepage, etc.)
> to lock and learn PFN's from pagemap. Then when migrating it to vfio the
> no-iommu option was introduced to provide UIO compatibility.

IIRC, we essentially introduced no-iommu mode vfio because DPDK started
pushing for extending interrupt support in uio-pci-generic.  The UIO
driver is also only meant for devices that don't do DMA, but obviously
DPDK didn't care about that.  Rather than extend UIO, we offered this
no-iommu mode in vfio since we already had more extensive MSI support,
were better able to impose restrictions on access to the device, and
using the same device access makes the transition to proper IOMMU
backed configurations more seamless.  Thanks,

Alex

