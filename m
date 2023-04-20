Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013E38BE9
	for <iommu@lists.linux.dev>; Thu, 20 Apr 2023 14:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1682000142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KHtItohlMimKkEP2hNqh88Wn+W8r/ovnf3iKQc3h81A=;
	b=ihYRsBM+kdNDvF/PDXv77NTjzJ2gIpFTC+cUGiOhZWz6yE5Stk5Igvo1WZW4rNCFVJU5vP
	slp15bzJK1HLYUget19Dk/4V6CdKuIVnb/EgNv6iRtwgxAqXjSluWDzTgpoINWLUOfLSDp
	0lz1xvvrKVvLa9L5HPle6Se0evFxibY=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-6kFvRb7JPC--olM2pZ71iQ-1; Thu, 20 Apr 2023 10:15:41 -0400
X-MC-Unique: 6kFvRb7JPC--olM2pZ71iQ-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7638744ba8cso47339139f.0
        for <iommu@lists.linux.dev>; Thu, 20 Apr 2023 07:15:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682000141; x=1684592141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KHtItohlMimKkEP2hNqh88Wn+W8r/ovnf3iKQc3h81A=;
        b=XwZf4geaGiMtqvRby8EMGt+sDu7sLXrcZts2AyFSrkWdz0OJ907G9eh//DWhx5RkE+
         yRY39LqdWnfFUUTcKfqai/IXhrpb5FWz3qQZnsbB7w/T0u+rv1vEs54AsJsqF2aS5YKd
         M+wcrPlo+JdPiOFGhpGNCAxVH9kuo4RoZavz8zYK/eRq/zj8T4LnnXNAcxybQHUD5RXL
         WZnKaXGVuun6XTh8mfUBSxbofvAqTh2HCfs8zRvG9godegVlFHZLL2xH9V/lGIrXM5v0
         J1MiFKzaT9a3m3JEPd46jWC+xATrAjg9GTFEa5ycbEZ1h0b+9mSYx1a/JC18eS43S/I6
         pvNg==
X-Gm-Message-State: AAQBX9cYZcytYs8lPPoMFoOG/m9l5D0bLHc4GyvZ6aCr2BDIdlktD/Kt
	XkRUeb70fLGuYLRPgP3TyuTTIAYUZSVDUjDi1fC6tl0n1b8Vl/OYVnm9maGGsDrJxwio8P5ktMp
	iIXANi4xc5GW3tnI=
X-Received: by 2002:a6b:5b0f:0:b0:760:a07c:322a with SMTP id v15-20020a6b5b0f000000b00760a07c322amr1371845ioh.19.1682000141068;
        Thu, 20 Apr 2023 07:15:41 -0700 (PDT)
X-Google-Smtp-Source: AKy350bU+94qs0c104x1ZVxCUmrOc+6uqD7OfuljJGoS19DxMv5FUHNvmQAXcSEjbtCs06eAoy6hLQ==
X-Received: by 2002:a6b:5b0f:0:b0:760:a07c:322a with SMTP id v15-20020a6b5b0f000000b00760a07c322amr1371826ioh.19.1682000140759;
        Thu, 20 Apr 2023 07:15:40 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id z7-20020a05660200c700b00760f8bae7aasm453392ioe.51.2023.04.20.07.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 07:15:40 -0700 (PDT)
Date: Thu, 20 Apr 2023 08:15:39 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, "robin.murphy@arm.com" <robin.murphy@arm.com>
Subject: Re: RMRR device on non-Intel platform
Message-ID: <20230420081539.6bf301ad.alex.williamson@redhat.com>
In-Reply-To: <BN9PR11MB5276E84229B5BD952D78E9598C639@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <BN9PR11MB5276E84229B5BD952D78E9598C639@BN9PR11MB5276.namprd11.prod.outlook.com>
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

On Thu, 20 Apr 2023 06:52:01 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> Hi, Alex,
> 
> Happen to see that we may have inconsistent policy about RMRR devices cross
> different vendors.
> 
> Previously only Intel supports RMRR. Now both AMD/ARM have similar thing,
> AMD IVMD and ARM RMR.

Any similar requirement imposed by system firmware that the operating
system must perpetually maintain a specific IOVA mapping for the device
should impose similar restrictions as we've implemented for VT-d
RMMR[1].  Thanks,

Alex

[1]https://access.redhat.com/sites/default/files/attachments/rmrr-wp1.pdf

> RMRR identity mapping was considered unsafe (except for USB/GPU) for
> device assignment:
> 
> /*
>  * There are a couple cases where we need to restrict the functionality of
>  * devices associated with RMRRs.  The first is when evaluating a device for
>  * identity mapping because problems exist when devices are moved in and out
>  * of domains and their respective RMRR information is lost.  This means that
>  * a device with associated RMRRs will never be in a "passthrough" domain.
>  * The second is use of the device through the IOMMU API.  This interface
>  * expects to have full control of the IOVA space for the device.  We cannot
>  * satisfy both the requirement that RMRR access is maintained and have an
>  * unencumbered IOVA space.  We also have no ability to quiesce the device's
>  * use of the RMRR space or even inform the IOMMU API user of the restriction.
>  * We therefore prevent devices associated with an RMRR from participating in
>  * the IOMMU API, which eliminates them from device assignment.
>  *
>  * In both cases, devices which have relaxable RMRRs are not concerned by this
>  * restriction. See device_rmrr_is_relaxable comment.
>  */
> static bool device_is_rmrr_locked(struct device *dev)
> {
> 	if (!device_has_rmrr(dev))
> 		return false;
> 
> 	if (device_rmrr_is_relaxable(dev))
> 		return false;
> 
> 	return true;
> }
> 
> Then non-relaxable RMRR device is rejected when doing attach:
> 
> static int intel_iommu_attach_device(struct iommu_domain *domain,
>                                      struct device *dev)
> {
> 	struct device_domain_info *info = dev_iommu_priv_get(dev);
> 	int ret;
> 
> 	if (domain->type == IOMMU_DOMAIN_UNMANAGED &&
> 	    device_is_rmrr_locked(dev)) {
> 		dev_warn(dev, "Device is ineligible for IOMMU domain attach due to platform RMRR requirement.  Contact your platform vendor.\n");
> 		return -EPERM;
> 	}
> 	...
> }
> 
> But I didn't find the same check in AMD/ARM driver at a glance.
> 
> Did I overlook some arch difference which makes RMRR device safe in
> those platforms or is it a gap to be fixed?
> 
> Thanks
> Kevin
> 

