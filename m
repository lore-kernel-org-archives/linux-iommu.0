Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A3128F5
	for <iommu@lists.linux.dev>; Thu, 20 Apr 2023 14:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1682002150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EUb3YvO/wIrjR5ODzmimb+GAFSaZ6gkz0JLMjhCNuXo=;
	b=EX8+Kc0HCjEcLB7RrmNrxk3ynrWRhzthTM/hz+1FYByGTLMuPgXM9hNyCPJ0wb91XjJ0Ts
	RjqUZua8Yyg2dpaIN8l7S1G1I2TlaIYMLYE1GMokUcqmp882LXUJ9smgcWcT928VPJn0fP
	SnDVvJubsLgJL9rsTCYuySzkqcG2Zwo=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-iY2bdFDjOs-RW__jkodB2g-1; Thu, 20 Apr 2023 10:49:09 -0400
X-MC-Unique: iY2bdFDjOs-RW__jkodB2g-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-32ab192a7b3so6189175ab.1
        for <iommu@lists.linux.dev>; Thu, 20 Apr 2023 07:49:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682002148; x=1684594148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EUb3YvO/wIrjR5ODzmimb+GAFSaZ6gkz0JLMjhCNuXo=;
        b=TwBWtu5t69+4rsuM3DA8h+7lK7ueMYGuY8WdTSsRDdouESzhltCTO8LFxMdZb0ZsG6
         /Dg7osFfXuuAJovcpo4zRMfSHaGK9+JhyTstkr17c+0569cKwPZVYrtLVy8CJ0V39Zzm
         7uwXEutjezXw6ix83EbLeWQ1cMaOj/5vzzBx4LJKtFeuVF+q+HF3E8U3cOIx7+jisV12
         /csPmInX1it5eIWmcTOtE9RCC+iFMoHoSjRHQ7+DYyblJadkp5qmRDA28WecOCfmNWUs
         FHsnXXo/SnV/ehDKDfOmx+UdA+RE9wxrOqoa1xTriHHv0G7RDvbon5o2kXGPQnTXTm3L
         mAiw==
X-Gm-Message-State: AAQBX9dqN5uNoZ6AUbq9Ul/F/mNcGgTBlbzZ3XPHSOEJEAOpjxrxbs+Z
	FXq5bVK53sxJ6fGxFJV2ea6XP2FzE54F/drvqhRaA/8Sej896Un7GucmUFIj8yhekTkBoO+K3Bb
	LYgZM+W/yh+j3774=
X-Received: by 2002:a92:a30a:0:b0:32b:6433:668f with SMTP id a10-20020a92a30a000000b0032b6433668fmr1405433ili.4.1682002148443;
        Thu, 20 Apr 2023 07:49:08 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZM4/NPXZvDqlpTo2XPVjWlGmQ+vov+dMQ64Rg338eTxD/JAqaVGnP8msaPqebeE2XRFKNAHA==
X-Received: by 2002:a92:a30a:0:b0:32b:6433:668f with SMTP id a10-20020a92a30a000000b0032b6433668fmr1405423ili.4.1682002148139;
        Thu, 20 Apr 2023 07:49:08 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id 127-20020a021185000000b0040fb5d5429fsm537563jaf.131.2023.04.20.07.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 07:49:07 -0700 (PDT)
Date: Thu, 20 Apr 2023 08:49:06 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "kvm@vger.kernel.org"
 <kvm@vger.kernel.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: RMRR device on non-Intel platform
Message-ID: <20230420084906.2e4cce42.alex.williamson@redhat.com>
In-Reply-To: <6cce1c5d-ab50-41c4-6e62-661bc369d860@arm.com>
References: <BN9PR11MB5276E84229B5BD952D78E9598C639@BN9PR11MB5276.namprd11.prod.outlook.com>
	<20230420081539.6bf301ad.alex.williamson@redhat.com>
	<6cce1c5d-ab50-41c4-6e62-661bc369d860@arm.com>
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

On Thu, 20 Apr 2023 15:19:55 +0100
Robin Murphy <robin.murphy@arm.com> wrote:

> On 2023-04-20 15:15, Alex Williamson wrote:
> > On Thu, 20 Apr 2023 06:52:01 +0000
> > "Tian, Kevin" <kevin.tian@intel.com> wrote:
> >   
> >> Hi, Alex,
> >>
> >> Happen to see that we may have inconsistent policy about RMRR devices cross
> >> different vendors.
> >>
> >> Previously only Intel supports RMRR. Now both AMD/ARM have similar thing,
> >> AMD IVMD and ARM RMR.  
> > 
> > Any similar requirement imposed by system firmware that the operating
> > system must perpetually maintain a specific IOVA mapping for the device
> > should impose similar restrictions as we've implemented for VT-d
> > RMMR[1].  Thanks,  
> 
> Hmm, does that mean that vfio_iommu_resv_exclude() going to the trouble 
> of punching out all the reserved region holes isn't really needed?

While "Reserved Memory Region Reporting", might suggest that the ranges
are simply excluded, RMRR actually require that specific mappings are
maintained for ongoing, side-band activity, which is not compatible
with the ideas that userspace owns the IOVA address space for the
device or separation of host vs userspace control of the device.  Such
mappings suggest things like system health monitoring where the
influence of a user-owned device can easily extend to a system-wide
scope if the user it able to manipulate the device to deny that
interaction or report bad data.

If these ARM and AMD tables impose similar requirements, we should
really be restricting devices encumbered by such requirements from
userspace access as well.  Thanks,

Alex

> > [1]https://access.redhat.com/sites/default/files/attachments/rmrr-wp1.pdf
> >   
> >> RMRR identity mapping was considered unsafe (except for USB/GPU) for
> >> device assignment:
> >>
> >> /*
> >>   * There are a couple cases where we need to restrict the functionality of
> >>   * devices associated with RMRRs.  The first is when evaluating a device for
> >>   * identity mapping because problems exist when devices are moved in and out
> >>   * of domains and their respective RMRR information is lost.  This means that
> >>   * a device with associated RMRRs will never be in a "passthrough" domain.
> >>   * The second is use of the device through the IOMMU API.  This interface
> >>   * expects to have full control of the IOVA space for the device.  We cannot
> >>   * satisfy both the requirement that RMRR access is maintained and have an
> >>   * unencumbered IOVA space.  We also have no ability to quiesce the device's
> >>   * use of the RMRR space or even inform the IOMMU API user of the restriction.
> >>   * We therefore prevent devices associated with an RMRR from participating in
> >>   * the IOMMU API, which eliminates them from device assignment.
> >>   *
> >>   * In both cases, devices which have relaxable RMRRs are not concerned by this
> >>   * restriction. See device_rmrr_is_relaxable comment.
> >>   */
> >> static bool device_is_rmrr_locked(struct device *dev)
> >> {
> >> 	if (!device_has_rmrr(dev))
> >> 		return false;
> >>
> >> 	if (device_rmrr_is_relaxable(dev))
> >> 		return false;
> >>
> >> 	return true;
> >> }
> >>
> >> Then non-relaxable RMRR device is rejected when doing attach:
> >>
> >> static int intel_iommu_attach_device(struct iommu_domain *domain,
> >>                                       struct device *dev)
> >> {
> >> 	struct device_domain_info *info = dev_iommu_priv_get(dev);
> >> 	int ret;
> >>
> >> 	if (domain->type == IOMMU_DOMAIN_UNMANAGED &&
> >> 	    device_is_rmrr_locked(dev)) {
> >> 		dev_warn(dev, "Device is ineligible for IOMMU domain attach due to platform RMRR requirement.  Contact your platform vendor.\n");
> >> 		return -EPERM;
> >> 	}
> >> 	...
> >> }
> >>
> >> But I didn't find the same check in AMD/ARM driver at a glance.
> >>
> >> Did I overlook some arch difference which makes RMRR device safe in
> >> those platforms or is it a gap to be fixed?
> >>
> >> Thanks
> >> Kevin
> >>  
> >   
> 

