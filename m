Return-Path: <SRS0=IGn4=DU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87883C43457
	for <iommu@archiver.kernel.org>; Tue, 13 Oct 2020 10:28:25 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0987E20872
	for <iommu@archiver.kernel.org>; Tue, 13 Oct 2020 10:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="akq3IGx8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0987E20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8D17987B16;
	Tue, 13 Oct 2020 10:28:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AGWuTneyOxbG; Tue, 13 Oct 2020 10:28:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id B6AD8879B0;
	Tue, 13 Oct 2020 10:28:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 88608C07FF;
	Tue, 13 Oct 2020 10:28:22 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7879CC0051
 for <iommu@lists.linux-foundation.org>; Tue, 13 Oct 2020 10:28:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 669098720A
 for <iommu@lists.linux-foundation.org>; Tue, 13 Oct 2020 10:28:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G-G-XbOW-xJq for <iommu@lists.linux-foundation.org>;
 Tue, 13 Oct 2020 10:28:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 241B0871F4
 for <iommu@lists.linux-foundation.org>; Tue, 13 Oct 2020 10:28:20 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id dt13so27513644ejb.12
 for <iommu@lists.linux-foundation.org>; Tue, 13 Oct 2020 03:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=AOyGbFGBFW7IttULzsANlRi4lqSr3VNc7xD02DIgAWM=;
 b=akq3IGx88v65EmpzfX3uQCPH4Z/ifmvztR0aVsED6cf/SUl9WzA8IN0RykxXcIZswS
 FchIteuFvzAkYHkpkpAPrb0L2Y5WXvtSBsLbZvQuJsJBuu6oJevmkB/ECVXSY/itUMjc
 ENRlh/P7TgrixcQr9fnv01sRHxHygggxTusXO7yM13o+bof+VAskRyFDmMNIbWNSHMRm
 oPYrqoLgQAx4uzWDk6XxiTEML9iypT9O2f86gO7BpR2bWWa07vDL4CoQUi6OaPDpWV4t
 NszlZgoUZRPTgc+5AEM3GWTAgqpRZuHGOXQzNILgJpbppePhONqeNW2OpEuWg0rXtTKs
 ogPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=AOyGbFGBFW7IttULzsANlRi4lqSr3VNc7xD02DIgAWM=;
 b=K/LtLPvGgY3JKiSZ7gB51yMgoRqqMlioEkT4aMhYcCstM12eRiA3ilhQLWHWTqGQSL
 T9jRKFZsWOz/keFmSSyGtkt8dXlWrMcjDB3Gu/mIsqh8vEX8296jXHiDKaIs8Yca1nSt
 GJZWjQzOzM/IDt1ewijOs20gmNoNDqBR7b/jnK3udwEXM8BPplZt5gf40owus9O1yANH
 vuDXpBjgGMgKO6nXcgN5ufLqBP2y0jkRKlqVZX8W/hgwpROZZzi8guxqu4Ib2Z6tz/j2
 rwznaBqJse0nuYz3FijppLYmZbC42TP7Zk4fsbk8VjbTZMaYDRGLSoXRKbyC1o5bnYTy
 Figg==
X-Gm-Message-State: AOAM531VVPVqKsAm3LVf84LULmlncKALQCqgKm0RUXMwPBvZTV/90ZR4
 /Y6ObbyMjAmO/uXakAaP28K2iQ==
X-Google-Smtp-Source: ABdhPJziTva1KqYf14pDRVtwD3+jwROqc/Tcpgez4s5eirqsZWkYGdAehcgVgInF2li4RYF2MIEwMQ==
X-Received: by 2002:a17:906:d8e:: with SMTP id
 m14mr33694709eji.448.1602584898502; 
 Tue, 13 Oct 2020 03:28:18 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id b6sm12848314edu.21.2020.10.13.03.28.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2020 03:28:17 -0700 (PDT)
Date: Tue, 13 Oct 2020 12:27:58 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: (proposal) RE: [PATCH v7 00/16] vfio: expose virtual Shared
 Virtual Addressing to VMs
Message-ID: <20201013102758.GB694407@myrica>
References: <MWHPR11MB1645CFB0C594933E92A844AC8C070@MWHPR11MB1645.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <MWHPR11MB1645CFB0C594933E92A844AC8C070@MWHPR11MB1645.namprd11.prod.outlook.com>
Cc: "Tian, Jun J" <jun.j.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "stefanha@gmail.com" <stefanha@gmail.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, "Wu, Hao" <hao.wu@intel.com>
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

On Mon, Oct 12, 2020 at 08:38:54AM +0000, Tian, Kevin wrote:
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Monday, September 14, 2020 12:20 PM
> >
> [...]
>  > If it's possible, I would suggest a generic uAPI instead of a VFIO
> > specific one.
> > 
> > Jason suggest something like /dev/sva. There will be a lot of other
> > subsystems that could benefit from this (e.g vDPA).
> > 
> > Have you ever considered this approach?
> > 
> 
> Hi, Jason,
> 
> We did some study on this approach and below is the output. It's a
> long writing but I didn't find a way to further abstract w/o losing 
> necessary context. Sorry about that.
> 
> Overall the real purpose of this series is to enable IOMMU nested
> translation capability with vSVA as one major usage, through
> below new uAPIs:
> 	1) Report/enable IOMMU nested translation capability;
> 	2) Allocate/free PASID;
> 	3) Bind/unbind guest page table;
> 	4) Invalidate IOMMU cache;
> 	5) Handle IOMMU page request/response (not in this series);
> 1/3/4) is the minimal set for using IOMMU nested translation, with 
> the other two optional. For example, the guest may enable vSVA on 
> a device without using PASID. Or, it may bind its gIOVA page table 
> which doesn't require page fault support. Finally, all operations can 
> be applied to either physical device or subdevice.
> 
> Then we evaluated each uAPI whether generalizing it is a good thing 
> both in concept and regarding to complexity.
> 
> First, unlike other uAPIs which are all backed by iommu_ops, PASID 
> allocation/free is through the IOASID sub-system. From this angle
> we feel generalizing PASID management does make some sense. 
> First, PASID is just a number and not related to any device before 
> it's bound to a page table and IOMMU domain. Second, PASID is a 
> global resource (at least on Intel VT-d), while having separate VFIO/
> VDPA allocation interfaces may easily cause confusion in userspace,
> e.g. which interface to be used if both VFIO/VDPA devices exist. 
> Moreover, an unified interface allows centralized control over how 
> many PASIDs are allowed per process.
> 
> One unclear part with this generalization is about the permission.
> Do we open this interface to any process or only to those which
> have assigned devices? If the latter, what would be the mechanism
> to coordinate between this new interface and specific passthrough 
> frameworks? A more tricky case, vSVA support on ARM (Eric/Jean
> please correct me) plans to do per-device PASID namespace which
> is built on a bind_pasid_table iommu callback to allow guest fully 
> manage its PASIDs on a given passthrough device.

Yes we need a bind_pasid_table. The guest needs to allocate the PASID
tables because they are accessed via guest-physical addresses by the HW
SMMU.

With bind_pasid_table, the invalidation message also requires a scope to
invalidate a whole PASID context, in addition to invalidating a mappings
ranges.

> I'm not sure 
> how such requirement can be unified w/o involving passthrough
> frameworks, or whether ARM could also switch to global PASID 
> style...

Not planned at the moment, sorry. It requires a PV IOMMU to do PASID
allocation, which is possible with virtio-iommu but not with a vSMMU
emulation. The VM will manage its own PASID space. The upside is that we
don't need userspace access to IOASID, so I won't pester you with comments
on that part of the API :)

> Second, IOMMU nested translation is a per IOMMU domain
> capability. Since IOMMU domains are managed by VFIO/VDPA
>  (alloc/free domain, attach/detach device, set/get domain attribute,
> etc.), reporting/enabling the nesting capability is an natural 
> extension to the domain uAPI of existing passthrough frameworks. 
> Actually, VFIO already includes a nesting enable interface even 
> before this series. So it doesn't make sense to generalize this uAPI 
> out.

Agree for enabling, but for reporting we did consider adding a sysfs
interface in /sys/class/iommu/ describing an IOMMU's properties. Then
opted for VFIO capabilities to keep the API nice and contained, but if
we're breaking up the API, sysfs might be more convenient to use and
extend.

> Then the tricky part comes with the remaining operations (3/4/5),
> which are all backed by iommu_ops thus effective only within an 
> IOMMU domain. To generalize them, the first thing is to find a way 
> to associate the sva_FD (opened through generic /dev/sva) with an 
> IOMMU domain that is created by VFIO/VDPA. The second thing is 
> to replicate {domain<->device/subdevice} association in /dev/sva 
> path because some operations (e.g. page fault) is triggered/handled 
> per device/subdevice. Therefore, /dev/sva must provide both per-
> domain and per-device uAPIs similar to what VFIO/VDPA already 
> does. Moreover, mapping page fault to subdevice requires pre-
> registering subdevice fault data to IOMMU layer when binding 
> guest page table, while such fault data can be only retrieved from 
> parent driver through VFIO/VDPA. 
> 
> However, we failed to find a good way even at the 1st step about
> domain association. The iommu domains are not exposed to the
> userspace, and there is no 1:1 mapping between domain and device.
> In VFIO, all devices within the same VFIO container share the address
> space but they may be organized in multiple IOMMU domains based
> on their bus type. How (should we let) the userspace know the
> domain information and open an sva_FD for each domain is the main
> problem here.
> 
> In the end we just realized that doing such generalization doesn't
> really lead to a clear design and instead requires tight coordination 
> between /dev/sva and VFIO/VDPA for almost every new uAPI 
> (especially about synchronization when the domain/device 
> association is changed or when the device/subdevice is being reset/
> drained). Finally it may become a usability burden to the userspace
> on proper use of the two interfaces on the assigned device.
>  
> Based on above analysis we feel that just generalizing PASID mgmt.
> might be a good thing to look at while the remaining operations are 
> better being VFIO/VDPA specific uAPIs. anyway in concept those are 
> just a subset of the page table management capabilities that an 
> IOMMU domain affords. Since all other aspects of the IOMMU domain 
> is managed by VFIO/VDPA already, continuing this path for new nesting
> capability sounds natural. There is another option by generalizing the 
> entire IOMMU domain management (sort of the entire vfio_iommu_
> type1), but it's unclear whether such intrusive change is worthwhile 
> (especially when VFIO/VDPA already goes different route even in legacy
> mapping uAPI: map/unmap vs. IOTLB).

I agree with your analysis. A new coarse /dev/sva interface would need to
carry all the VFIO abstractions of container (minus map/unmap) and
group+device, which are not necessarily needed by VDPA and others, while
the original VFIO interface needs to stay for compatibility. To me it
makes more sense to extend each API separately, but have them embed common
structures (bind/inval) and share some resources through external
interfaces (IOASID, nesting properties, IOPF queue).

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
