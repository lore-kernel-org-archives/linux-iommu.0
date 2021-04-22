Return-Path: <SRS0=TTgE=JT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74E2C433B4
	for <iommu@archiver.kernel.org>; Thu, 22 Apr 2021 22:38:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E752613B8
	for <iommu@archiver.kernel.org>; Thu, 22 Apr 2021 22:38:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E752613B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1267140F58;
	Thu, 22 Apr 2021 22:38:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oNO8hOVry2vj; Thu, 22 Apr 2021 22:38:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id D9361405E6;
	Thu, 22 Apr 2021 22:38:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 94700C000F;
	Thu, 22 Apr 2021 22:38:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CF306C000B
 for <iommu@lists.linux-foundation.org>; Thu, 22 Apr 2021 22:38:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CAC5F403F4
 for <iommu@lists.linux-foundation.org>; Thu, 22 Apr 2021 22:38:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B0lO4ja6mLEH for <iommu@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 22:38:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 860574026A
 for <iommu@lists.linux-foundation.org>; Thu, 22 Apr 2021 22:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619131101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5CPnCdS+3PHW7WBSNl+13JosLwiUy7b8OWDjwQeL9f4=;
 b=UvVtUoz6iTK73Xi6pmzNu7OsuSTlLjVhiCUxzt80uSnvu09HfvH9CVbfcdRfvryTmf6Mna
 x/PQArZQQw3eOt6JAo2JMHdQweTf2+uf3e9lEjQXIiiT1S5o21fQJEqTLmu8TLV115PdnT
 8DemSKpLt08LXWnIMzv4Zz7n5oi0xlA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-568-PF18o9DVPMqUKrlxOJ_yGQ-1; Thu, 22 Apr 2021 18:38:17 -0400
X-MC-Unique: PF18o9DVPMqUKrlxOJ_yGQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 061641927802;
 Thu, 22 Apr 2021 22:38:15 +0000 (UTC)
Received: from redhat.com (ovpn-114-21.phx2.redhat.com [10.3.114.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9A03459469;
 Thu, 22 Apr 2021 22:38:08 +0000 (UTC)
Date: Thu, 22 Apr 2021 16:38:08 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210422163808.2d173225@redhat.com>
In-Reply-To: <20210422200024.GC1370958@nvidia.com>
References: <20210416094547.1774e1a3@redhat.com>
 <BN6PR11MB406854F56D18E1187A2C98ACC3479@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210421162307.GM1370958@nvidia.com>
 <20210421105451.56d3670a@redhat.com>
 <20210421175203.GN1370958@nvidia.com>
 <20210421133312.15307c44@redhat.com>
 <20210421230301.GP1370958@nvidia.com>
 <20210422111337.6ac3624d@redhat.com>
 <20210422175715.GA1370958@nvidia.com>
 <20210422133747.23322269@redhat.com>
 <20210422200024.GC1370958@nvidia.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj, 
 Ashok" <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Li Zefan <lizefan@huawei.com>, LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "Wu,
 Hao" <hao.wu@intel.com>, David Woodhouse <dwmw2@infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, 22 Apr 2021 17:00:24 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Thu, Apr 22, 2021 at 01:37:47PM -0600, Alex Williamson wrote:
> 
> > If by "classic" you mean conventional PCI bus, then this is much worse
> > than simply "at risk".  The IOMMU cannot differentiate devices behind a
> > PCIe-to-PCI bridge, so the moment you turn on the IOMMU context for the
> > NIC, the address space for your HBA is pulled out from under it.    
> 
> Yes, I understand this, but this is fine and not really surprising if
> the HD device is just forced to remain "unusued"
> 
> To my mind the bigger issue is the NIC now has access to the HD and
> nobody really raised an alarm unless the HD happened to have a kernel
> driver bound.
> 
> > the vfio world, the NIC and HBA are grouped and managed together, the
> > user cannot change the IOMMU context of a group unless all of the
> > devices in the group are "viable", ie. they are released from any host
> > drivers.  
> 
> Yes, I don't propose to change any of that, I just suggest to make the
> 'change the IOMMU context" into "join a /dev/ioasid fd"
> 
> All devices in the group have to be joined to the same ioasid or, with
> the flag, left "unused" with no kernel driver. 
> 
> This is the same viability test VFIO is doing now, just moved slightly
> in the programming flow.
> 
> > vfio users are extremely aware of grouping, they understand the model,
> > if not always the reason for the grouping.  You only need to look at
> > r/VFIO to find various lsgroup scripts and kernel patches to manipulate
> > grouping.  The visibility to the user is valuable imo.  
> 
> I don't propose to remove visibility, sysfs and the lsgroup scripts
> should all still be there.
> 
> I'm just acknowledging reality that the user command line experiance
> we have is focused on single BDFs not on groups. The user only sees
> the group idea when things explode, so why do we have it as such an
> integral part of the programming model?

Because it's fundamental to the isolation of the device?  What you're
proposing doesn't get around the group issue, it just makes it implicit
rather than explicit in the uapi.  For what?  Some ideal notion that
every device should be isolated at the expense of userspace drivers
that then fail randomly because they didn't take into account groups
because it's not part of the uapi?

> > >    ioctl(vifo_device_fd, JOIN_IOASID_FD, ioasifd)
> > >    [..]
> > >    ioctl(vfio_device, ATTACH_IOASID, gpa_ioasid_id) == ENOPERM
> > > 
> > > I would feel comfortable if the ATTACH_IOASID fails by default if all
> > > devices in the group have not been joined to the same ioasidfd.  
> > 
> > And without a group representation to userspace, how would a user know
> > to resolve that?  
> 
> Userspace can continue to read sysfs files that show the group
> relation.
> 
> I'm only talking about the group char device and FD.
> 
> > So the group still exist in sysfs, they just don't have vfio
> > representations?  An implicit grouping does what, automatically unbind
> > the devices, so an admin gives a user access to the NIC but their HBA
> > device disappears because they were implicitly linked?    
> 
> It does exactly the same thing as opening the VFIO group FD and
> instantiating a single device FD does today.
> 
> Most software, like dpdk, automatically deduces the VFIO group from
> the commandline BDF, I'm mainly suggesting we move that deduction from
> userspace software to kernel software.
> 
> > basis ownership on the group, if a user owns the group but the group is
> > not viable because a device is still bound to another kernel driver,
> > the use can't do anything.  Implicitly snarfing up subtly affected
> > devices is bad.  
> 
> The user would get an /dev/ioasid join failure just like they get a
> failure from VFIO_GROUP_SET_CONTAINER (?) today that reflects the
> group is not viable.
> 
> Otherwise what is the alternative?
> 
> How do we model the VFIO group security concept to something like
> VDPA?

Is it really a "VFIO group security concept"?  We're reflecting the
reality of the hardware, not all devices are fully isolated.  An IOMMU
group is the smallest set of devices we believe are isolated from all
other sets of devices.  VFIO groups simply reflect that notion of an
IOMMU group.  This is the reality that any userspace driver needs to
play in, it doesn't magically go away because we drop the group file
descriptor.  It only makes the uapi more difficult to use correctly
because userspace drivers need to go outside of the uapi to have any
idea that this restriction exists.  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
