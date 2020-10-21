Return-Path: <SRS0=cHqw=D4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F658C388F9
	for <iommu@archiver.kernel.org>; Wed, 21 Oct 2020 11:48:54 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B424A21D7B
	for <iommu@archiver.kernel.org>; Wed, 21 Oct 2020 11:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="CzuRkD2q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B424A21D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3B3558671A;
	Wed, 21 Oct 2020 11:48:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id njLKbf5-D54B; Wed, 21 Oct 2020 11:48:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id BAF69866DD;
	Wed, 21 Oct 2020 11:48:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9CB31C08A1;
	Wed, 21 Oct 2020 11:48:51 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9ECEBC0052
 for <iommu@lists.linux-foundation.org>; Wed, 21 Oct 2020 11:48:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9B59786687
 for <iommu@lists.linux-foundation.org>; Wed, 21 Oct 2020 11:48:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O5qlethT8kdF for <iommu@lists.linux-foundation.org>;
 Wed, 21 Oct 2020 11:48:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from nat-hk.nvidia.com (nat-hk.nvidia.com [203.18.50.4])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 6D087866DD
 for <iommu@lists.linux-foundation.org>; Wed, 21 Oct 2020 11:48:47 +0000 (UTC)
Received: from HKMAIL101.nvidia.com (Not Verified[10.18.92.100]) by
 nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f90201d0000>; Wed, 21 Oct 2020 19:48:45 +0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 21 Oct
 2020 11:48:45 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 21 Oct 2020 11:48:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GcU1FkL/wMqGHk2LMh1QIij1zh6FyuaSl3RDoO0BJHlqx773suA6JCZJxxyfR4Jj6Y/5ddwDZPdsTZDjeNqRjYTrsJQR+u0k3LC0Rz8NDQ5pC+Bhe3yVmEFALSpcQQE7NGY66O1TMW1bQ+qj4xX5fZGUzmCCvWcWP/QsP711G3t2sol7Q72DlmlfeUlOrXDRCOo0RXlQmEtClOvH/deQ0vqv5trT3QDqoGp4ChxNGJNmu+AYsBaftNwr1IhNG7GLj9wQgPENsZb0IEbIy0wIO/vVn5N/hocQVbB6oxZQcPBhRRkbwPTa6gEgp7Ra+ODLn9sAF2nXRFVPY5BNa6xfaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hL7l1UrAwcl7mVUXmSFrbtdy5zhf/G2m8SAiFg48/gA=;
 b=d23FBIS0a6gF9T/NR9bZ/CUGw4BXDj/cZBVeE/06Dsf8BLGIOGGsH5n+0qHHtLFGvEUjxN7S0iNBxaGqEyYL1F4RT5qT1Lsw4F6hTQvP+iUzAM20q6kjwajyjhd9yDNK/+1DjapO8sZHheGR8t0E1Aed/sV86oLImEILR2sV1TpX2aGC2KTdqKEVOfoB2nvC0icfBL1uOGx8+6otZ36Jy3byyBtuEuqC0OxWMUaUhePVnrebjwnjLOY0C/bZclNkAOLrm61Wt3C3QDLvpL3miexvcFdnbhTjI9n9VUEh5pTO4y2mEwMzCwSi/pqaBBpHd5r+TGdVoXTjM5F7Gsbo3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1754.namprd12.prod.outlook.com (2603:10b6:3:10f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.23; Wed, 21 Oct
 2020 11:48:41 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 11:48:41 +0000
Date: Wed, 21 Oct 2020 08:48:29 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Raj, Ashok" <ashok.raj@intel.com>
Subject: Re: (proposal) RE: [PATCH v7 00/16] vfio: expose virtual Shared
 Virtual Addressing to VMs
Message-ID: <20201021114829.GR6219@nvidia.com>
References: <20201019142526.GJ6219@nvidia.com>
 <DM5PR11MB14354A8A126E686A5F20FEC2C31F0@DM5PR11MB1435.namprd11.prod.outlook.com>
 <20201020140217.GI6219@nvidia.com> <20201020162430.GA85321@otc-nc-03>
 <20201020170336.GK6219@nvidia.com> <20201020195146.GA86371@otc-nc-03>
 <20201020195557.GO6219@nvidia.com> <20201020200844.GC86371@otc-nc-03>
 <20201020201403.GP6219@nvidia.com> <20201020202713.GF86371@otc-nc-03>
Content-Disposition: inline
In-Reply-To: <20201020202713.GF86371@otc-nc-03>
X-ClientProxiedBy: MN2PR15CA0052.namprd15.prod.outlook.com
 (2603:10b6:208:237::21) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by
 MN2PR15CA0052.namprd15.prod.outlook.com (2603:10b6:208:237::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend
 Transport; Wed, 21 Oct 2020 11:48:41 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1kVCbV-003SlH-8a; Wed, 21 Oct 2020 08:48:29 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1603280925; bh=hL7l1UrAwcl7mVUXmSFrbtdy5zhf/G2m8SAiFg48/gA=;
 h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
 From:To:CC:Subject:Message-ID:References:Content-Type:
 Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
 X-MS-Exchange-MessageSentRepresentingType;
 b=CzuRkD2qfapWIkjlDLoFY/6x6waJj+c1pZwPgv5n4gRuhr5NYvpqb8rgeBQnzMRGi
 pTfur6VmQXGnY2KN7C97JD58VpxDzK42FOAw0PJWTgp/u97ELTG8BvGkQXoEJeOmSL
 G90SHnyhuDA8sEomIIU3m7qzj92hlCE63radRNUv4BjXDDQUxScIZF0NjEjeZIcY/r
 8To/9MY5/RLaeDTuS63FED7Rj/iKoBdg+fBCBMhLNC30SwqL3KRuhe/dIH1t9EX/WI
 B3HPyRsJTFSj+/DT5wMJemf0E5pAXl+asqLI40O2LAlpyyp4X3Qcyqc5e7M/WyL5ae
 ugzqEMb9RPt4w==
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

On Tue, Oct 20, 2020 at 01:27:13PM -0700, Raj, Ashok wrote:
> On Tue, Oct 20, 2020 at 05:14:03PM -0300, Jason Gunthorpe wrote:
> > On Tue, Oct 20, 2020 at 01:08:44PM -0700, Raj, Ashok wrote:
> > > On Tue, Oct 20, 2020 at 04:55:57PM -0300, Jason Gunthorpe wrote:
> > > > On Tue, Oct 20, 2020 at 12:51:46PM -0700, Raj, Ashok wrote:
> > > > > I think we agreed (or agree to disagree and commit) for device types that 
> > > > > we have for SIOV, VFIO based approach works well without having to re-invent 
> > > > > another way to do the same things. Not looking for a shortcut by any means, 
> > > > > but we need to plan around existing hardware though. Looks like vDPA took 
> > > > > some shortcuts then to not abstract iommu uAPI instead :-)? When all
> > > > > necessary hardware was available.. This would be a solved puzzle. 
> > > > 
> > > > I think it is the opposite, vIOMMU and related has outgrown VFIO as
> > > > the "home" and needs to stand alone.
> > > > 
> > > > Apparently the HW that will need PASID for vDPA is Intel HW, so if
> > > 
> > > So just to make this clear, I did check internally if there are any plans
> > > for vDPA + SVM. There are none at the moment. 
> > 
> > Not SVM, SIOV.
> 
> ... And that included.. I should have said vDPA + PASID, No current plans. 
> I have no idea who set expectations with you. Can you please put me in touch 
> with that person, privately is fine.

It was the team that aruged VDPA had to be done through VFIO - SIOV
and PASID was one of their reasons it had to be VFIO, check the list
archives

If they didn't plan to use it, bit of a strawman argument, right?

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
