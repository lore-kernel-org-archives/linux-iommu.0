Return-Path: <SRS0=/c0m=D3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B22C4363A
	for <iommu@archiver.kernel.org>; Tue, 20 Oct 2020 17:03:56 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 062E52177B
	for <iommu@archiver.kernel.org>; Tue, 20 Oct 2020 17:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="rHZUzlXZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 062E52177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 78BAC2E1B0;
	Tue, 20 Oct 2020 17:03:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CUyDmJbp+tfH; Tue, 20 Oct 2020 17:03:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 72BA52D8B7;
	Tue, 20 Oct 2020 17:03:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 59982C0891;
	Tue, 20 Oct 2020 17:03:53 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42C50C0052
 for <iommu@lists.linux-foundation.org>; Tue, 20 Oct 2020 17:03:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 33FA5868F9
 for <iommu@lists.linux-foundation.org>; Tue, 20 Oct 2020 17:03:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XSt9qfaQ5hDV for <iommu@lists.linux-foundation.org>;
 Tue, 20 Oct 2020 17:03:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from nat-hk.nvidia.com (nat-hk.nvidia.com [203.18.50.4])
 by whitealder.osuosl.org (Postfix) with ESMTPS id EA74C868F1
 for <iommu@lists.linux-foundation.org>; Tue, 20 Oct 2020 17:03:50 +0000 (UTC)
Received: from HKMAIL104.nvidia.com (Not Verified[10.18.92.77]) by
 nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f8f18730001>; Wed, 21 Oct 2020 01:03:47 +0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 20 Oct
 2020 17:03:43 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 20 Oct 2020 17:03:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CRGaZ1kKv56ldppLFLy4nsnT5eji26+g5hb1q6tdlBS4gtuk3Z6X/uAcQVRxyRp4lmYTWL3b3FpUoAy0aRLjlNR+XFnB3i0OLylYKzfMfIcAYAPH9Ro1lnuEtW/fiP3k7+YW8YnIRSz2P5JvMEBcUv+uv6S815wziyDkHfTMRl9tugMOkD8zVwb9gefnc5LkO78ByitqQGiA55d2unJE4bfkcbNjr8Rj/QWRmSoDA+iFiQDeMDjx9FW+N2eIvjElW5SYpE8RsfD9T/7q0ZyXHI/rW5CBvOy7DEQK3BFjPY2KY8pheY9flB0bERRa2xL40S9gwbUH/O+DNa9ZGoIYpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCcDUZsUjSDIQ0tUi4f/rcVUPE6JuXrapwhSWUxkR3g=;
 b=lysBsXMCBPpfObhCeXiwetgupFC0aBOxfeydvvdQAj2+OW/ZIlt/izrKk0+2TSJ6w42O3pK/NA50Pw+RmtbSm9UjahQvR1XToFA8V/81kzkSCCgyHLHGBPV/5StoPrsTgqcZANmDm6Q3difE7qsb3lxZ5at6SAceaPZunH4Yyml3zewUxIaCU346tW5BD7Va3DMOyYk6CFpKNoFXT1Fu/wY6j5s+K6T8lkD3LYYXqQSqAJU+rfplVXFeQWzBEmCSIxQDP/bpB7mS0mvb5g0jVaihOEWxcjwniZsDqH7qQ/ihn5KSlrOtETb/NkZlwfFK18BbV+y2nAn+Ok8orgwr4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3515.namprd12.prod.outlook.com (2603:10b6:5:15f::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.23; Tue, 20 Oct
 2020 17:03:38 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3477.028; Tue, 20 Oct 2020
 17:03:37 +0000
Date: Tue, 20 Oct 2020 14:03:36 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Raj, Ashok" <ashok.raj@intel.com>
Subject: Re: (proposal) RE: [PATCH v7 00/16] vfio: expose virtual Shared
 Virtual Addressing to VMs
Message-ID: <20201020170336.GK6219@nvidia.com>
References: <MWHPR11MB1645CFB0C594933E92A844AC8C070@MWHPR11MB1645.namprd11.prod.outlook.com>
 <MWHPR11MB1645AE971BD8DAF72CE3E1198C050@MWHPR11MB1645.namprd11.prod.outlook.com>
 <20201016153632.GM6219@nvidia.com>
 <DM5PR11MB1435A3AEC0637C4531F2FE92C31E0@DM5PR11MB1435.namprd11.prod.outlook.com>
 <20201019142526.GJ6219@nvidia.com>
 <DM5PR11MB14354A8A126E686A5F20FEC2C31F0@DM5PR11MB1435.namprd11.prod.outlook.com>
 <20201020140217.GI6219@nvidia.com> <20201020162430.GA85321@otc-nc-03>
Content-Disposition: inline
In-Reply-To: <20201020162430.GA85321@otc-nc-03>
X-ClientProxiedBy: BL0PR1501CA0015.namprd15.prod.outlook.com
 (2603:10b6:207:17::28) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by
 BL0PR1501CA0015.namprd15.prod.outlook.com (2603:10b6:207:17::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25 via Frontend
 Transport; Tue, 20 Oct 2020 17:03:37 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1kUv2u-003072-Ia; Tue, 20 Oct 2020 14:03:36 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1603213428; bh=XCcDUZsUjSDIQ0tUi4f/rcVUPE6JuXrapwhSWUxkR3g=;
 h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
 From:To:CC:Subject:Message-ID:References:Content-Type:
 Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
 X-MS-Exchange-MessageSentRepresentingType;
 b=rHZUzlXZO67dbN7Mvjcq8S6ZbooLb9JjVB7Kd7R+ejxwnh6BhOpTh/PpBiwMQc+fU
 JJvSyptxFfWWFV7jnHBaSdejSACrlt8a3bZu4bp3EElyld9Gg4AmxM0WMQrQZ3WHDq
 ci1jtVPcLRr3BBq7CUQvO03tHzfUOlo5IFgtK077bAZiwj+Wpd5J9q41oLrwHr+0LP
 6/5EITk8nHpUMmtEO1qKsyeAlTDAPQBls4SjYKa22EwkXJEE8kKfngHRZd4h1ve62B
 TRdOTv8b/BGpKG86kGCdiA8qWsz80YqcmDQBJFhks/A8F6ur5j2LiIUKy4w4eXsutR
 /xitW8HcLMnlg==
Cc: "Tian, Jun J" <jun.j.tian@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "stefanha@gmail.com" <stefanha@gmail.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "Zhu,
 Lingshan" <lingshan.zhu@intel.com>, "Wu, Hao" <hao.wu@intel.com>
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

On Tue, Oct 20, 2020 at 09:24:30AM -0700, Raj, Ashok wrote:
> Hi Jason,
> 
> 
> On Tue, Oct 20, 2020 at 11:02:17AM -0300, Jason Gunthorpe wrote:
> > On Tue, Oct 20, 2020 at 10:21:41AM +0000, Liu, Yi L wrote:
> > 
> > > > I'm sure there will be some
> > > > weird overlaps because we can't delete any of the existing VFIO APIs, but
> > > > that
> > > > should not be a blocker.
> > > 
> > > but the weird thing is what we should consider. And it perhaps not just
> > > overlap, it may be a re-definition of VFIO container. As I mentioned, VFIO
> > > container is IOMMU context from the day it was defined. It could be the
> > > blocker. :-(
> > 
> > So maybe you have to broaden the VFIO container to be usable by other
> > subsystems. The discussion here is about what the uAPI should look
> > like in a fairly abstract way. When we say 'dev/sva' it just some
> > placeholder for a shared cdev that provides the necessary
> > dis-aggregated functionality 
> > 
> > It could be an existing cdev with broader functionaltiy, it could
> > really be /dev/iommu, etc. This is up to the folks building it to
> > decide.
> > 
> > > I'm not expert on vDPA for now, but I saw you three open source
> > > veterans have a similar idea for a place to cover IOMMU handling,
> > > I think it may be a valuable thing to do. I said "may be" as I'm not
> > > sure about Alex's opinion on such idea. But the sure thing is this
> > > idea may introduce weird overlap even re-definition of existing
> > > thing as I replied above. We need to evaluate the impact and mature
> > > the idea step by step. 
> > 
> > This has happened before, uAPIs do get obsoleted and replaced with
> > more general/better versions. It is often too hard to create a uAPI
> > that lasts for decades when the HW landscape is constantly changing
> > and sometime a reset is needed. 
> 
> I'm throwing this out with a lot of hesitation, but I'm going to :-)
> 
> So we have been disussing this for months now, with some high level vision
> trying to get the uAPI's solidified with a vDPA hardware that might
> potentially have SIOV/SVM like extensions in hardware which actualy doesn't
> exist today. Understood people have plans. 

> Given that vDPA today has diverged already with duplicating use of IOMMU
> api's without making an effort to gravitate to /dev/iommu as how you are
> proposing.

I see it more like, given that we already know we have multiple users
of IOMMU, adding new IOMMU focused features has to gravitate toward
some kind of convergance.

Currently things are not so bad, VDPA is just getting started and the
current IOMMU feature set is not so big.

PASID/vIOMMU/etc/et are all stressing this more, I think the
responsibility falls to the people proposing these features to do the
architecture work.

> The question is should we hold hostage the current vSVM/vIOMMU efforts
> without even having made an effort for current vDPA/VFIO convergence. 

I don't think it is "held hostage" it is a "no shortcuts" approach,
there was always a recognition that future VDPA drivers will need some
work to integrated with vIOMMU realted stuff.

This is no different than the IMS discussion. The first proposed patch
was really simple, but a layering violation.

The correct solution was some wild 20 patch series modernizing how x86
interrupts works because it had outgrown itself. This general approach
to use the shared MSI infrastructure was pointed out at the very
beginning of IMS, BTW.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
