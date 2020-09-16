Return-Path: <SRS0=cHis=CZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9667AC43461
	for <iommu@archiver.kernel.org>; Wed, 16 Sep 2020 16:32:58 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE44E22245
	for <iommu@archiver.kernel.org>; Wed, 16 Sep 2020 16:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="afDXwjuP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE44E22245
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 858FC86AB2;
	Wed, 16 Sep 2020 16:32:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id blt5ZxAWPkRD; Wed, 16 Sep 2020 16:32:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id F1354869F8;
	Wed, 16 Sep 2020 16:32:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DB312C0859;
	Wed, 16 Sep 2020 16:32:56 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 767B3C0051
 for <iommu@lists.linux-foundation.org>; Wed, 16 Sep 2020 16:32:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6E2C28722B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Sep 2020 16:32:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v9R-Bxx1wG2h for <iommu@lists.linux-foundation.org>;
 Wed, 16 Sep 2020 16:32:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from nat-hk.nvidia.com (nat-hk.nvidia.com [203.18.50.4])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 7E77C87225
 for <iommu@lists.linux-foundation.org>; Wed, 16 Sep 2020 16:32:54 +0000 (UTC)
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.77]) by
 nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5f623e340000>; Thu, 17 Sep 2020 00:32:52 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
 by hkpgpgate102.nvidia.com (PGP Universal service);
 Wed, 16 Sep 2020 09:32:52 -0700
X-PGP-Universal: processed;
 by hkpgpgate102.nvidia.com on Wed, 16 Sep 2020 09:32:52 -0700
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 16 Sep
 2020 16:32:50 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 16 Sep 2020 16:32:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9CwzWQodcMoC6fpiQLjyJYN8+5JOqtjhUJ9tllmWXJhK3T2f5KBN53Dv+hYILxM58PRHrRT/3L/B/CPJuuMDLGjyd2bVRak2jbLgHdk48ZwH0bsoiCq2odptLmbLvJf4Vf7PajEzNbTsLP0hGS7T669S8wRs35kMQe5PXIc8hKKBo7igCLlToT0uHj4QmbH9mfCKnZCt0bB30SWtREmVg0ic8zUK5QDz4OCi7xKS//MirHJdNfiW+CNFiyZHsKYLVV9/cEmEn7Cq24TH59G7H1LfIiZG7LvWubP/qwIzm/OMXCRrAyFnWrCVUrt3hLgHaa7jPIrfh+D8ZMO/E80Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPRXU3d7kZ8NOgReGG773i7RFqKldXjhhu16Kxzb11g=;
 b=cX69Wyd9vKMzoTOoz7Ea8cNm9ptCCsR75oG7jLikx/SOVptFv09TEd7gGONHcwdoOnEydqP5RQgyfezRi6GXiPxXyXjB/a0CPIzReWWmU6cRsbSuVjC/oNFCmtt/f9xSMC2qoNHJ0B4houDzP+v4w6vxyEcimoCTvQigaNBja+852rmJovIPf/k4C5vujqq+2PuHPLKkBddlTSg5tTf7b4UixyMKCRcHL2PTSHkvre46wedzTfSrVcm6gBp39qPjkuKNKvJTlHgtZoyZRMjEfsx9FgBEAiUiMVHrg44BJZQ99DOvGjuUaiOBpCzsuzzcgdyP+MrSYqbA9MsKZLvgCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4265.namprd12.prod.outlook.com (2603:10b6:5:211::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Wed, 16 Sep
 2020 16:32:47 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3391.011; Wed, 16 Sep 2020
 16:32:47 +0000
Date: Wed, 16 Sep 2020 13:32:46 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v7 00/16] vfio: expose virtual Shared Virtual Addressing
 to VMs
Message-ID: <20200916163246.GC3699@nvidia.com>
References: <20200914105857.3f88a271@x1.home>
 <20200914174121.GI904879@nvidia.com> <20200914122328.0a262a7b@x1.home>
 <20200914190057.GM904879@nvidia.com> <20200914163310.450c8d6e@x1.home>
 <20200915142906.GX904879@nvidia.com>
 <MWHPR11MB1645934DB27033011316059B8C210@MWHPR11MB1645.namprd11.prod.outlook.com>
 <20200916083217.GA5316@myrica> <20200916145148.GD6199@nvidia.com>
 <20200916162052.GE5316@myrica>
Content-Disposition: inline
In-Reply-To: <20200916162052.GE5316@myrica>
X-ClientProxiedBy: BL0PR0102CA0045.prod.exchangelabs.com
 (2603:10b6:208:25::22) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by
 BL0PR0102CA0045.prod.exchangelabs.com (2603:10b6:208:25::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11 via Frontend Transport; Wed, 16 Sep 2020 16:32:47 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1kIaMQ-0004qL-6o; Wed, 16 Sep 2020 13:32:46 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e9e48f5-48d0-447f-0c38-08d85a5e2564
X-MS-TrafficTypeDiagnostic: DM6PR12MB4265:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4265BA2849653D16F55FC0A6C2210@DM6PR12MB4265.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k4wKUhGEOLjkuN152OUoI6RbQDGEoXTPK0A1Tm6FwJkB1r4uXHl5lsRFrgMw1YZV7L9HU8CAKKl+8UgtWY19Tzktk7vBn8Fy8AUSVxvW39e6rbPSGcS+Gs6HCUiluIVbG+OjUNrEhLL94zuirkCkLWc147IValVOsr/W4+m7BzSqg0o4Y0cgTp4JLlJmFOQa1FF7bjshGgw89uZj3txKScwPsRd2HxlOHMxDj2/+C4s8orPodp/m5JAWEETrFQ52VTGehpGbjGqONkPKqghPd7SWXT4Y5vEuQ/CBH3Q2bxb3ndlAv0LuXxdw9mJGyLyfUl1tbDqGpZYmvIyUichTPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3834.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(4326008)(186003)(8676002)(36756003)(9786002)(9746002)(86362001)(33656002)(316002)(6916009)(478600001)(26005)(5660300002)(54906003)(66556008)(426003)(66476007)(66946007)(1076003)(7416002)(2616005)(8936002)(2906002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: IyfvYqvinpdM6hpO/aBkVFEPDwyPcuFK2smWfrUWlHAgxqc9dhkrndobFgw6j+Tt9eL1InHfAG3gEB9cVSBtkb53vAKD1t8Uitgcv/SaIXVJ/NZRB3KZOMb9J8kshM7SjN9nXFV27X5e2T6aTf8o9wJfTryuTjFj24AD8O3F0p4rN4nrC6F0oDI4tfX/g8IC0c2JQUW+2oHGHbUcXzTMDhVCBwDoCs2cP79VIeZ9wjxFRxZJMvXuIaU40mEVQM9rID2pgALNnw8zkTR7nboQTAfaZ8SWlwFVa/K9feu34PLO3GtIwVoltNJLVtqyG/DISqDP8qCnDrbeCoGRJssBrC/BBWnGGsajVXz2Wk0dWug0Vya1hkA6Q34k8f98GAwTMU36vl7tuidfFg5w5H3BME+QmGX/qHljHh1uMFC8/wvUhzG7JCWEqJJpI3CzL+eKV8UcM4ydvo6dI1q6htzYtYj3Xyas/mSCzG/uucmM/ZWkP9lqIv0PLX41HlSZQI/4swGLeFccPS+1PdLRciHy04V22bXx/iJmwdvWMmRtXg4zx0XsDYypM0Q/8Cv26oZdHeevduyLUIL8UktfxfozD8zcR/0QzWZ7YIgH7WQRTFKeDUJRF14Bcl7RUpXqqBEj3T6fnHczyNsmkYh6Pf0jmg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e9e48f5-48d0-447f-0c38-08d85a5e2564
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 16:32:47.6123 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CzUTsuN0zDxK0yWySe5S0UQ5mh8fdp16aL/hxodSS0RqqFQoW/57NR3JrKY8mUzr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4265
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1600273972; bh=dPRXU3d7kZ8NOgReGG773i7RFqKldXjhhu16Kxzb11g=;
 h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
 ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
 Subject:Message-ID:References:Content-Type:Content-Disposition:
 In-Reply-To:X-ClientProxiedBy:MIME-Version:
 X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
 X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 b=afDXwjuP7DaNVKDMfp2KcGG4nfRP/3mBGIXSFtg5VNoEeddLbZbvhx3NCWZR4ITO4
 Ya3YYawZtPuHIU3C9ScCgEYd8DRELwq/VyV782/uiORjLn9+yc3QN8MIKRp6LG0yVM
 IMrC8Vnc5hk2xPzng+sW7UlnTs9w6WPdlBCIgEj/sMwo7cUCPYW/ogmFgvB+eWQVD0
 HNBp0AIrZJ2+iK4TWYDyOwC+DWV/XfdI+tgtccetDApVV3nyg6s6J1rMdIFrYUiLXT
 5/gk6k/Mq18GzB1kiit2+LhhtNpTayzWhXY37clkYP7M0Kow7jyOEW+a/t/5XDD8s0
 stKMU9WXO3q4Q==
Cc: "Tian, Jun
 J" <jun.j.tian@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "stefanha@gmail.com" <stefanha@gmail.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, "Wu, Hao" <hao.wu@intel.com>
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

On Wed, Sep 16, 2020 at 06:20:52PM +0200, Jean-Philippe Brucker wrote:
> On Wed, Sep 16, 2020 at 11:51:48AM -0300, Jason Gunthorpe wrote:
> > On Wed, Sep 16, 2020 at 10:32:17AM +0200, Jean-Philippe Brucker wrote:
> > > And this is the only PASID model for Arm SMMU (and AMD IOMMU, I believe):
> > > the PASID space of a PCI function cannot be shared between host and guest,
> > > so we assign the whole PASID table along with the RID. Since we need the
> > > BIND, INVALIDATE, and report APIs introduced here to support nested
> > > translation, a /dev/sva interface would need to support this mode as well.
> > 
> > Well, that means this HW cannot support PASID capable 'SIOV' style
> > devices in guests.
> 
> It does not yet support Intel SIOV, no. It does support the standards,
> though: PCI SR-IOV to partition a device and PASIDs in a guest.

SIOV is basically standards based, it is better thought of as a
cookbook on how to use PASID and IOMMU together.

> > I admit whole function PASID delegation might be something vfio-pci
> > should handle - but only if it really doesn't fit in some /dev/sva
> > after we cover the other PASID cases.
> 
> Wouldn't that be the duplication you're trying to avoid?  A second
> channel for bind, invalidate, capability and fault reporting
> mechanisms?

Yes, which is why it seems like it would be nicer to avoid it. Why I
said "might" :)

> If we extract SVA parts of vfio_iommu_type1 into a separate chardev,
> PASID table pass-through [1] will have to use that.

Yes, '/dev/sva' (which is a terrible name) would want to be the uAPI
entry point for controlling the vIOMMU related to PASID.

Does anything in the [1] series have tight coupling to VFIO other than
needing to know a bus/device/function? It looks like it is mostly
exposing iommu_* functions as uAPI?

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
