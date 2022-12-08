Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB01CA460
	for <iommu@lists.linux.dev>; Thu,  8 Dec 2022 21:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1670536112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JlSLHZU0UyP1zXnoWLl9wrALkHazYkzcA1gB5b/QBD4=;
	b=JJZBu7TUwJ+HZaiFG+1XLWR2bW3ByIG3O5QWDZahSDO/JqXaue/ngXmPqKgbTV7ICkEklc
	PN9OTHsRr7a5Nx080a0eDTYmD4yOtEmTx99m1Jh2kEZ3e9vePYPYiGTa9JttuuF8VNPtnu
	zCjlOfZZqd91vDsPfi9XdJMcfIVC/sY=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-622-EMxaN324OPWnXTLPqvywZg-1; Thu, 08 Dec 2022 16:48:29 -0500
X-MC-Unique: EMxaN324OPWnXTLPqvywZg-1
Received: by mail-il1-f200.google.com with SMTP id h10-20020a056e021b8a00b00302671bb5fdso2428159ili.21
        for <iommu@lists.linux.dev>; Thu, 08 Dec 2022 13:48:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JlSLHZU0UyP1zXnoWLl9wrALkHazYkzcA1gB5b/QBD4=;
        b=srd/IiZRlKrCiqOCThOduL3DJ0RgKckRKawfHuhbrVAO6yept2xgrdUVPwps9fOpy+
         0zMjzer3IrgvzG6Ew9qPTmQR1RqKnVYoYlhOjHjeTTLBimb5MlFl7BZ3oz4N89y1P8mI
         5pCiSM1BSpwT7tfrCbT4ctMT/bNlIncZUcoFK+faeJJ4f2Ft1ksEUSq7/tW/USbWvskl
         XFhX4Dnt2Ycvw6+cZLchfrBTe0RegPr2JFVK+gsfPK28YRr8qfsTx7o7fpjuVVuMkqUV
         xbjt53w7tvS5w5ll0bbw7HvDqJ/epwx3KV/pYy5ZkcFi/BcKWCLekTM+wCKSBFbdXH5d
         cZOg==
X-Gm-Message-State: ANoB5pmkI1IpL963KsMifNIvgsGo3LkOMJwqUnkBNs/idCGBxp5yJdx2
	10umZcXddYoAQRJGoPADsML3E8rkttKOocmS9SNwrO4ykXIeVETOOQ1i0jn/W9gCxLJhF3GpvNF
	8HvRp5f31sajZSHU=
X-Received: by 2002:a02:caa9:0:b0:38a:4f3e:a8f3 with SMTP id e9-20020a02caa9000000b0038a4f3ea8f3mr7633691jap.118.1670536108936;
        Thu, 08 Dec 2022 13:48:28 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5z9amCYid4VD2QKF39+LEnq0/gOoAHkRrex2ThE5am1xPidFCUVQZkXXRQS46wsmIHSMDr3g==
X-Received: by 2002:a02:caa9:0:b0:38a:4f3e:a8f3 with SMTP id e9-20020a02caa9000000b0038a4f3ea8f3mr7633686jap.118.1670536108715;
        Thu, 08 Dec 2022 13:48:28 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id q18-20020a927512000000b00302bb083c2bsm1115985ilc.21.2022.12.08.13.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 13:48:28 -0800 (PST)
Date: Thu, 8 Dec 2022 14:48:25 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Lu Baolu
 <baolu.lu@linux.intel.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, David
 Woodhouse <dwmw2@infradead.org>, Gerald Schaefer
 <gerald.schaefer@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Heiko
 Carstens <hca@linux.ibm.com>, iommu@lists.linux.dev, Joerg Roedel
 <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
 linux-s390@vger.kernel.org, Marc Zyngier <maz@kernel.org>, Robin Murphy
 <robin.murphy@arm.com>, Suravee Suthikulpanit
 <suravee.suthikulpanit@amd.com>, Sven Schnelle <svens@linux.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, Bharat
 Bhushan <bharat.bhushan@nxp.com>, Christian Borntraeger
 <borntraeger@de.ibm.com>, Eric Auger <eric.auger@redhat.com>, Eric Farman
 <farman@linux.ibm.com>, Marc Zyngier <marc.zyngier@arm.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, Tomasz Nowicki
 <tomasz.nowicki@caviumnetworks.com>, Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH iommufd 2/9] vfio/type1: Check that every device
 supports IOMMU_CAP_INTR_REMAP
Message-ID: <20221208144825.33823739.alex.williamson@redhat.com>
In-Reply-To: <2-v1-9e466539c244+47b5-secure_msi_jgg@nvidia.com>
References: <0-v1-9e466539c244+47b5-secure_msi_jgg@nvidia.com>
	<2-v1-9e466539c244+47b5-secure_msi_jgg@nvidia.com>
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

On Thu,  8 Dec 2022 16:26:29 -0400
Jason Gunthorpe <jgg@nvidia.com> wrote:

> iommu_group_for_each_dev() exits the loop at the first callback that
> returns 1 - thus returning 1 fails to check the rest of the devices in the
> group.
> 
> msi_remap (aka secure MSI) requires that all the devices in the group
> support it, not just any one. This is only a theoretical problem as no
> current drivers will have different secure MSI properties within a group.

Which is exactly how Robin justified the behavior in the referenced
commit:

  As with domains, any capability must in practice be consistent for
  devices in a given group - and after all it's still the same
  capability which was expected to be consistent across an entire bus!
  - so there's no need for any complicated validation.

That suggests to me that it's intentional that we break if any device
supports the capability and therefore this isn't so much a "Fixes:", as
it is a refactoring expressly to support msi_device_has_secure_msi(),
which cannot make these sort of assumptions as a non-group API.  Thanks,

Alex

> Make vfio_iommu_device_secure_msi() reduce AND across all the devices.
> 
> Fixes: eed20c782aea ("vfio/type1: Simplify bus_type determination")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 23c24fe98c00d4..3025b4e643c135 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -2160,10 +2160,12 @@ static void vfio_iommu_iova_insert_copy(struct vfio_iommu *iommu,
>  	list_splice_tail(iova_copy, iova);
>  }
>  
> -/* Redundantly walks non-present capabilities to simplify caller */
> -static int vfio_iommu_device_capable(struct device *dev, void *data)
> +static int vfio_iommu_device_secure_msi(struct device *dev, void *data)
>  {
> -	return device_iommu_capable(dev, (enum iommu_cap)data);
> +	bool *secure_msi = data;
> +
> +	*secure_msi &= device_iommu_capable(dev, IOMMU_CAP_INTR_REMAP);
> +	return 0;
>  }
>  
>  static int vfio_iommu_domain_alloc(struct device *dev, void *data)
> @@ -2278,9 +2280,12 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>  	INIT_LIST_HEAD(&domain->group_list);
>  	list_add(&group->next, &domain->group_list);
>  
> -	msi_remap = irq_domain_check_msi_remap() ||
> -		    iommu_group_for_each_dev(iommu_group, (void *)IOMMU_CAP_INTR_REMAP,
> -					     vfio_iommu_device_capable);
> +	msi_remap = irq_domain_check_msi_remap();
> +	if (!msi_remap) {
> +		msi_remap = true;
> +		iommu_group_for_each_dev(iommu_group, &msi_remap,
> +					 vfio_iommu_device_secure_msi);
> +	}
>  
>  	if (!allow_unsafe_interrupts && !msi_remap) {
>  		pr_warn("%s: No interrupt remapping support.  Use the module param \"allow_unsafe_interrupts\" to enable VFIO IOMMU support on this platform\n",

