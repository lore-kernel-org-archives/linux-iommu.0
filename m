Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14D5944E
	for <iommu@lists.linux.dev>; Thu, 20 Apr 2023 21:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1682027379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ed7BbjIgEG0nlGh5BbIuvSNi/R0nKOIS6+tkSWqjXb4=;
	b=E5pPBcSSUvEFDLU4j7VuQailbrTRSoU48N7CCuSKjz7WR0ckWxA37l+2tUCDNQ7K8FeyaW
	z8iKe759JGVgN6kjqqdDY+FOBhcG0oVVIu4TVUzTSORF0alKYnrNbL1NUdz8ISAMf2zUOY
	5oB/G+1E/p1x2bAIZULbK5yhEQj3P7w=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-3VRKMCfJPoGhtPofnzTvoA-1; Thu, 20 Apr 2023 17:49:38 -0400
X-MC-Unique: 3VRKMCfJPoGhtPofnzTvoA-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-760ebd1bc25so117864939f.0
        for <iommu@lists.linux.dev>; Thu, 20 Apr 2023 14:49:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682027377; x=1684619377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ed7BbjIgEG0nlGh5BbIuvSNi/R0nKOIS6+tkSWqjXb4=;
        b=IkMvJBia62kWkvAp91WSPOs/6bg+lmpHoR+WpBvaDeoKsirrrAJQxetU3Ep6TvJE8R
         LBVF+6wSkCKBDvZD39uoxLbM8vJ4qVR3R/pTP8KtvYpejopGun8z+mE6UKN0/BBbEctu
         BnWThdO2lVzk0OT96W9YhD1nKfKxYruMs/RE/R+XJ1d9OCs8eZeMEznNgO09GxW3aOui
         vq05yWIVeEZc+6xRbagtP/hGlFpsYiU0XM4RpmpX49V5KEPw1V7KMxq6TqopFsLilWQS
         +ubr8hXh3Ps+3BUPt0f+cIScPoQQ7HLHbzm2QOdfjiF3VM0hVZm19SHAq5C+HCKoDh91
         0ldA==
X-Gm-Message-State: AAQBX9eJOcsTwyPyafVXS8a7gNvlPeaqvkgt0wOKEZtO8WPUJD+KVBWa
	qbFKLmXKqGGAPLx7JNqBsjatQZ3Xcoh8Pf2irBsxI1h/b5F267rfBLoJrIqTT2Bt9jD3JwyEAdI
	JrGK52GjBHFYsWaA=
X-Received: by 2002:a5d:884c:0:b0:760:e308:107e with SMTP id t12-20020a5d884c000000b00760e308107emr2524968ios.0.1682027377384;
        Thu, 20 Apr 2023 14:49:37 -0700 (PDT)
X-Google-Smtp-Source: AKy350aASnaRo/ZryK2g65U9txMsvyPJLwyJ6CVMgCX11TD1+qfvyNjUh5x72FJcvybAgdncTdoxWQ==
X-Received: by 2002:a5d:884c:0:b0:760:e308:107e with SMTP id t12-20020a5d884c000000b00760e308107emr2524954ios.0.1682027377097;
        Thu, 20 Apr 2023 14:49:37 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id c7-20020a6b7d07000000b007046e9e138esm647115ioq.22.2023.04.20.14.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 14:49:36 -0700 (PDT)
Date: Thu, 20 Apr 2023 15:49:33 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "kvm@vger.kernel.org"
 <kvm@vger.kernel.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: RMRR device on non-Intel platform
Message-ID: <20230420154933.1a79de4e.alex.williamson@redhat.com>
In-Reply-To: <fd324213-8d77-cb67-1c52-01cd0997a92c@arm.com>
References: <BN9PR11MB5276E84229B5BD952D78E9598C639@BN9PR11MB5276.namprd11.prod.outlook.com>
	<20230420081539.6bf301ad.alex.williamson@redhat.com>
	<6cce1c5d-ab50-41c4-6e62-661bc369d860@arm.com>
	<20230420084906.2e4cce42.alex.williamson@redhat.com>
	<fd324213-8d77-cb67-1c52-01cd0997a92c@arm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
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

On Thu, 20 Apr 2023 17:55:22 +0100
Robin Murphy <robin.murphy@arm.com> wrote:

> On 20/04/2023 3:49 pm, Alex Williamson wrote:
> > On Thu, 20 Apr 2023 15:19:55 +0100
> > Robin Murphy <robin.murphy@arm.com> wrote:
> >   
> >> On 2023-04-20 15:15, Alex Williamson wrote:  
> >>> On Thu, 20 Apr 2023 06:52:01 +0000
> >>> "Tian, Kevin" <kevin.tian@intel.com> wrote:
> >>>      
> >>>> Hi, Alex,
> >>>>
> >>>> Happen to see that we may have inconsistent policy about RMRR devices cross
> >>>> different vendors.
> >>>>
> >>>> Previously only Intel supports RMRR. Now both AMD/ARM have similar thing,
> >>>> AMD IVMD and ARM RMR.  
> >>>
> >>> Any similar requirement imposed by system firmware that the operating
> >>> system must perpetually maintain a specific IOVA mapping for the device
> >>> should impose similar restrictions as we've implemented for VT-d
> >>> RMMR[1].  Thanks,  
> >>
> >> Hmm, does that mean that vfio_iommu_resv_exclude() going to the trouble
> >> of punching out all the reserved region holes isn't really needed?  
> > 
> > While "Reserved Memory Region Reporting", might suggest that the ranges
> > are simply excluded, RMRR actually require that specific mappings are
> > maintained for ongoing, side-band activity, which is not compatible
> > with the ideas that userspace owns the IOVA address space for the
> > device or separation of host vs userspace control of the device.  Such
> > mappings suggest things like system health monitoring where the
> > influence of a user-owned device can easily extend to a system-wide
> > scope if the user it able to manipulate the device to deny that
> > interaction or report bad data.
> > 
> > If these ARM and AMD tables impose similar requirements, we should
> > really be restricting devices encumbered by such requirements from
> > userspace access as well.  Thanks,  
> 
> Indeed the primary use-case behind Arm's RMRs was certain devices like 
> big complex RAID controllers which have already been started by UEFI 
> firmware at boot and have live in-memory data which needs to be preserved.
> 
> However, my point was more that if it's a VFIO policy that any device 
> with an IOMMU_RESV_DIRECT reservation is not suitable for userspace 
> assignment, then vfio_iommu_type1_attach_group() already has everything 
> it would need to robustly enforce that policy itself. It seems silly to 
> me for it to expect the IOMMU driver to fail the attach, then go ahead 
> and dutifully punch out direct regions if it happened not to. A couple 
> of obvious trivial tweaks and there could be no dependency on driver 
> behaviour at all, other than correctly reporting resv_regions to begin with.
> 
> If we think this policy deserves to go beyond VFIO and userspace, and 
> it's reasonable that such devices should never be allowed to attach to 
> any other kind of kernel-owned unmanaged domain either, then we can 
> still trivially enforce that in core IOMMU code. I really see no need 
> for it to be in drivers at all.

It seems like a reasonable choice to me that any mixing of unmanaged
domains with IOMMU_RESV_DIRECT could be restricted globally.  Do we
even have infrastructure for a driver to honor the necessary mapping
requirements?

It looks pretty easy to do as well, something like this (untested):

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 10db680acaed..521f9a731ce9 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2012,11 +2012,29 @@ static void __iommu_group_set_core_domain(struct iommu_group *group)
 static int __iommu_attach_device(struct iommu_domain *domain,
 				 struct device *dev)
 {
-	int ret;
+	int ret = 0;
 
 	if (unlikely(domain->ops->attach_dev == NULL))
 		return -ENODEV;
 
+	if (domain->type == IOMMU_DOMAIN_UNMANAGED) {
+		struct iommu_resv_region *region;
+		LIST_HEAD(resv_regions);
+
+		iommu_get_resv_regions(dev, &resv_regions);
+		list_for_each_entry(region, &resv_regions, list) {
+			if (region->type == IOMMU_RESV_DIRECT) {
+				ret = -EPERM;
+				break;
+			}
+		}
+		iommu_put_resv_regions(dev, &resv_regions);
+		if (ret) {
+			dev_warn(dev, "Device may not be used with an unmanaged IOMMU domain due to reserved direct mapping requirement.\n");
+			return ret;
+		}
+	}
+
 	ret = domain->ops->attach_dev(domain, dev);
 	if (ret)
 		return ret;
 
Restrictions in either type1 or iommufd would be pretty trivial as well,
but centralizing it in core IOMMU code would do a better job of covering
all use cases.

This effectively makes the VT-d code further down the same path
redundant, so no new restrictions there.

What sort of fall-out should we expect on ARM or AMD?  This was a pretty
painful restriction to add on Intel.  Thanks,

Alex

> >>> [1]https://access.redhat.com/sites/default/files/attachments/rmrr-wp1.pdf
> >>>      
> >>>> RMRR identity mapping was considered unsafe (except for USB/GPU) for
> >>>> device assignment:
> >>>>
> >>>> /*
> >>>>    * There are a couple cases where we need to restrict the functionality of
> >>>>    * devices associated with RMRRs.  The first is when evaluating a device for
> >>>>    * identity mapping because problems exist when devices are moved in and out
> >>>>    * of domains and their respective RMRR information is lost.  This means that
> >>>>    * a device with associated RMRRs will never be in a "passthrough" domain.
> >>>>    * The second is use of the device through the IOMMU API.  This interface
> >>>>    * expects to have full control of the IOVA space for the device.  We cannot
> >>>>    * satisfy both the requirement that RMRR access is maintained and have an
> >>>>    * unencumbered IOVA space.  We also have no ability to quiesce the device's
> >>>>    * use of the RMRR space or even inform the IOMMU API user of the restriction.
> >>>>    * We therefore prevent devices associated with an RMRR from participating in
> >>>>    * the IOMMU API, which eliminates them from device assignment.
> >>>>    *
> >>>>    * In both cases, devices which have relaxable RMRRs are not concerned by this
> >>>>    * restriction. See device_rmrr_is_relaxable comment.
> >>>>    */
> >>>> static bool device_is_rmrr_locked(struct device *dev)
> >>>> {
> >>>> 	if (!device_has_rmrr(dev))
> >>>> 		return false;
> >>>>
> >>>> 	if (device_rmrr_is_relaxable(dev))
> >>>> 		return false;
> >>>>
> >>>> 	return true;
> >>>> }
> >>>>
> >>>> Then non-relaxable RMRR device is rejected when doing attach:
> >>>>
> >>>> static int intel_iommu_attach_device(struct iommu_domain *domain,
> >>>>                                        struct device *dev)
> >>>> {
> >>>> 	struct device_domain_info *info = dev_iommu_priv_get(dev);
> >>>> 	int ret;
> >>>>
> >>>> 	if (domain->type == IOMMU_DOMAIN_UNMANAGED &&
> >>>> 	    device_is_rmrr_locked(dev)) {
> >>>> 		dev_warn(dev, "Device is ineligible for IOMMU domain attach due to platform RMRR requirement.  Contact your platform vendor.\n");
> >>>> 		return -EPERM;
> >>>> 	}
> >>>> 	...
> >>>> }
> >>>>
> >>>> But I didn't find the same check in AMD/ARM driver at a glance.
> >>>>
> >>>> Did I overlook some arch difference which makes RMRR device safe in
> >>>> those platforms or is it a gap to be fixed?
> >>>>
> >>>> Thanks
> >>>> Kevin
> >>>>     
> >>>      
> >>  
> >   
> 

