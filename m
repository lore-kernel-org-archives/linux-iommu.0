Return-Path: <SRS0=/c0m=D3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7398C4363A
	for <iommu@archiver.kernel.org>; Tue, 20 Oct 2020 14:02:32 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00BD02222D
	for <iommu@archiver.kernel.org>; Tue, 20 Oct 2020 14:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="iWVnjwfJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00BD02222D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 69158869EB;
	Tue, 20 Oct 2020 14:02:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iucnuY0NAC2W; Tue, 20 Oct 2020 14:02:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A1E50868C7;
	Tue, 20 Oct 2020 14:02:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8C669C0052;
	Tue, 20 Oct 2020 14:02:29 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2C154C0051
 for <iommu@lists.linux-foundation.org>; Tue, 20 Oct 2020 14:02:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 14C7086CE6
 for <iommu@lists.linux-foundation.org>; Tue, 20 Oct 2020 14:02:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oOuq8czKi0gW for <iommu@lists.linux-foundation.org>;
 Tue, 20 Oct 2020 14:02:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from hqnvemgate24.nvidia.com (hqnvemgate24.nvidia.com
 [216.228.121.143])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1A2668653D
 for <iommu@lists.linux-foundation.org>; Tue, 20 Oct 2020 14:02:23 +0000 (UTC)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f8eed910001>; Tue, 20 Oct 2020 07:00:49 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 20 Oct
 2020 14:02:21 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 20 Oct 2020 14:02:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XRYOgalrrqGSSojAypq7vB3ydU6VWDeFlvhO7BsdDVUxUXD7DXrMFCyDTv/lWS80M8KUvWC8Mwm88ABFRKs0cxuITpzq3pJQuViiLR3w2ItjRcXwf9RAXlY0UgAz13NaqGHMoaPWewi1bObhc3JQYdbdZtcg7CPhm4xy4uH6OrKJ2oYmXPtPNKbXVm3VCi+3SQ+6HarU5UFDiz2eGndSHT/496OIAtarGMl5VkBptGRrhpU/pfsf7mpk74WVFSFabPqVJjS0T+M5PSSaasjiOUyGaB51SsDg1IvLa89eaI2LNj5hz7++HuuglN+Fqovr9p/6S4vk+b/M0wOPP6lrOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nw6Dc4thrvxt0k6gfKvOKlGrXPfkP0iXjdAoQL9ZkFU=;
 b=m3ZVybo2vN1gS6E3JYbVZPvCzWSD2lMM+86tARSJxnRgKML0d8cNdKxS0OQxnEF21YHbHSG4ygf14xar71wtV4lDJ63fdJzOodyg4Zl6cOYP4iZC8/a15iMuYYugQx8YEiWP7Jn26Y9paGjSxaxggUASWkqOwD33c+s3pWymzlmhFazSXnUqjtkG+nXI9PsWSVpa8A9dqmxm0nz4VytoFY2rhGTLsDitW3ToZsSMf67cxXVQeIWcFXkAoD50BgPhFmSd7u0u5GSDltYexY3k8wRne5FyQuoiX7Hyo/7MGnDUpCzCltgUFYdicEobneD7+XNSXFHwCVROVNjwfko5Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 20 Oct
 2020 14:02:19 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3477.028; Tue, 20 Oct 2020
 14:02:19 +0000
Date: Tue, 20 Oct 2020 11:02:17 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: (proposal) RE: [PATCH v7 00/16] vfio: expose virtual Shared
 Virtual Addressing to VMs
Message-ID: <20201020140217.GI6219@nvidia.com>
References: <MWHPR11MB1645CFB0C594933E92A844AC8C070@MWHPR11MB1645.namprd11.prod.outlook.com>
 <MWHPR11MB1645AE971BD8DAF72CE3E1198C050@MWHPR11MB1645.namprd11.prod.outlook.com>
 <20201016153632.GM6219@nvidia.com>
 <DM5PR11MB1435A3AEC0637C4531F2FE92C31E0@DM5PR11MB1435.namprd11.prod.outlook.com>
 <20201019142526.GJ6219@nvidia.com>
 <DM5PR11MB14354A8A126E686A5F20FEC2C31F0@DM5PR11MB1435.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <DM5PR11MB14354A8A126E686A5F20FEC2C31F0@DM5PR11MB1435.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL0PR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:208:91::17) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by
 BL0PR05CA0007.namprd05.prod.outlook.com (2603:10b6:208:91::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.4 via Frontend Transport; Tue, 20 Oct 2020 14:02:19 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1kUsDR-002wbX-Ng; Tue, 20 Oct 2020 11:02:17 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1603202449; bh=Nw6Dc4thrvxt0k6gfKvOKlGrXPfkP0iXjdAoQL9ZkFU=;
 h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
 From:To:CC:Subject:Message-ID:References:Content-Type:
 Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
 X-MS-Exchange-MessageSentRepresentingType;
 b=iWVnjwfJSK3EL3ZsZ85wDoLA0iVHzdnAHqMVMKhTR1+/oANfBSiS/93WSfx3A2rec
 z1y9Yf49taIvNp5NlfRDcZppoQrjEXENC69fIaetSL5+8HiSt3cs+smhaTBkWq0grL
 L+/sYOIC1mjpKi4ATN9MCG+cOtG5ygY/wW+L7+5s6PN0Ig8a7aV2+3dgEkWOgbL2Fg
 sBMMfSHRaI48M0SGFsH1kXtYmrLjkIeNpErfhHGJldBVEgwIZartvl0Bgn+9fZDTQn
 /MHi3qdmgusSST989Tzy5enpyOoFD1eB/KdUWZhlSgL4l889ZQaWvChr6VvZyE5kn+
 Cu7f3wDVN8Hcw==
Cc: "Tian, Jun J" <jun.j.tian@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "stefanha@gmail.com" <stefanha@gmail.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Zhu,
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

On Tue, Oct 20, 2020 at 10:21:41AM +0000, Liu, Yi L wrote:

> > I'm sure there will be some
> > weird overlaps because we can't delete any of the existing VFIO APIs, but
> > that
> > should not be a blocker.
> 
> but the weird thing is what we should consider. And it perhaps not just
> overlap, it may be a re-definition of VFIO container. As I mentioned, VFIO
> container is IOMMU context from the day it was defined. It could be the
> blocker. :-(

So maybe you have to broaden the VFIO container to be usable by other
subsystems. The discussion here is about what the uAPI should look
like in a fairly abstract way. When we say 'dev/sva' it just some
placeholder for a shared cdev that provides the necessary
dis-aggregated functionality 

It could be an existing cdev with broader functionaltiy, it could
really be /dev/iommu, etc. This is up to the folks building it to
decide.

> I'm not expert on vDPA for now, but I saw you three open source
> veterans have a similar idea for a place to cover IOMMU handling,
> I think it may be a valuable thing to do. I said "may be" as I'm not
> sure about Alex's opinion on such idea. But the sure thing is this
> idea may introduce weird overlap even re-definition of existing
> thing as I replied above. We need to evaluate the impact and mature
> the idea step by step. 

This has happened before, uAPIs do get obsoleted and replaced with
more general/better versions. It is often too hard to create a uAPI
that lasts for decades when the HW landscape is constantly changing
and sometime a reset is needed. 

The jump to shared PASID based IOMMU feels like one of those moments here.

> > Whoever provides the vIOMMU emulation and relays the page fault to the guest
> > has to translate the RID -
> 
> that's the point. But the device info (especially the sub-device info) is
> within the passthru framework (e.g. VFIO). So page fault reporting needs
> to go through passthru framework.
>
> > what does that have to do with VFIO?
> > 
> > How will VPDA provide the vIOMMU emulation?
> 
> a pardon here. I believe vIOMMU emulation should be based on IOMMU vendor
> specification, right? you may correct me if I'm missing anything.

I'm asking how will VDPA translate the RID when VDPA triggers a page
fault that has to be relayed to the guest. VDPA also has virtual PCI
devices it creates.

We can't rely on VFIO to be the place that the vIOMMU lives because it
excludes/complicates everything that is not VFIO from using that
stuff.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
