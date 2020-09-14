Return-Path: <SRS0=C6HT=CX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6785C433E2
	for <iommu@archiver.kernel.org>; Mon, 14 Sep 2020 19:01:11 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEA952193E
	for <iommu@archiver.kernel.org>; Mon, 14 Sep 2020 19:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="h4gAbtIX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEA952193E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8044B862A5;
	Mon, 14 Sep 2020 19:01:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LCRdrwJ6BnrT; Mon, 14 Sep 2020 19:01:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0BDAD85F87;
	Mon, 14 Sep 2020 19:01:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F23CAC0859;
	Mon, 14 Sep 2020 19:01:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 55C24C0051
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 19:01:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3C6C686730
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 19:01:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rw0dZ4R4b+B4 for <iommu@lists.linux-foundation.org>;
 Mon, 14 Sep 2020 19:01:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from nat-hk.nvidia.com (nat-hk.nvidia.com [203.18.50.4])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 053768672C
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 19:01:04 +0000 (UTC)
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.9]) by
 nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5f5fbdef0000>; Tue, 15 Sep 2020 03:01:03 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
 by hkpgpgate101.nvidia.com (PGP Universal service);
 Mon, 14 Sep 2020 12:01:03 -0700
X-PGP-Universal: processed;
 by hkpgpgate101.nvidia.com on Mon, 14 Sep 2020 12:01:03 -0700
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 14 Sep
 2020 19:01:02 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 14 Sep 2020 19:01:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q99r5jeyCC9CH5Wo3+7Ii+bPWdNxdLfdeTck2PyuH4T39aOSeAnVXrOxBV70YR2+pBy2kI1RbFYkALTqQpmWg7ZEdJ1GJSXVV5nPGidrA2M3e/b0O5tiSS1rHEKuJrR1k83qBCgsLBT3WPRO0WvpC1sxGUaA93YU9yISu8HARxA491rLEj2fwz7/gJswLamdvqEz7ZJA0Vr0D2Izh+JaqsA23p0x6m7e97SPD6jD7rF0RVJGuI4RA76ETSN/6DLfHychz5LcWCl9cSi1Ul40JSq/teLEygktLhS6ugR9OwNCMj+83Tqhew/Axu60ukpS+g3sVIrtnOP+Avn/HipeAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlvj2ZARCqOfsVM+9BOLMvCUB+Vtb8FoFBSD7i0rTzw=;
 b=Q5bScR6WaE/bsjobYQJhZjUnFCG5XYXYQYFprCiDDoYSvuKoKBnS+xqls4p+KXl9Vj6vzW5t8j4n1qE4suV/s3aC4aj2XyVni17piCJ0OdLrURJr2BSSJnp5V3QVSqGPBoJwclWaJMx2pZOUnD1FpzDJbeYWo6u+bQzJhvgnAoOF3TJC3mPwom+v36jhVyewfcsg71TNjHvs9t40Vtkvkg7nr+DKVZtv4Sd26b7nrT4h6Jt4cN21Jjk5+0U42Tqq86XzrHrAjACQK2BP5F9lcR4md+3qr9IFQ716wumvfp6SOsxd9OhRwWodk3k9+uY98QAb5Z/zpL6TsMm7grUz2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3404.namprd12.prod.outlook.com (2603:10b6:5:3a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Mon, 14 Sep
 2020 19:00:59 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 19:00:59 +0000
Date: Mon, 14 Sep 2020 16:00:57 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v7 00/16] vfio: expose virtual Shared Virtual Addressing
 to VMs
Message-ID: <20200914190057.GM904879@nvidia.com>
References: <1599734733-6431-1-git-send-email-yi.l.liu@intel.com>
 <411c81c0-f13c-37cc-6c26-cafb42b46b15@redhat.com>
 <20200914133113.GB1375106@myrica> <20200914134738.GX904879@nvidia.com>
 <20200914162247.GA63399@otc-nc-03> <20200914163354.GG904879@nvidia.com>
 <20200914105857.3f88a271@x1.home> <20200914174121.GI904879@nvidia.com>
 <20200914122328.0a262a7b@x1.home>
Content-Disposition: inline
In-Reply-To: <20200914122328.0a262a7b@x1.home>
X-ClientProxiedBy: CH2PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:610:59::37) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by
 CH2PR03CA0027.namprd03.prod.outlook.com (2603:10b6:610:59::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16 via Frontend Transport; Mon, 14 Sep 2020 19:00:59 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1kHtij-006ERD-KU; Mon, 14 Sep 2020 16:00:57 -0300
X-Originating-IP: [206.223.160.26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a1c6c0a-c0c1-4c8f-b686-08d858e08468
X-MS-TrafficTypeDiagnostic: DM6PR12MB3404:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3404826624E7BEECA9C88577C2230@DM6PR12MB3404.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AGFfLVrxKgxn65LXhBk2+y5Pcpi64Kg3UBs23FHqqI7BGYUK4gGHFNJ2HLSDwdG3Qnh72gm2VbiOCWoychJiYG8HC/jEZBXwTH0yic7H2nbm53yrb5xjLb35nvUyQOvGIND3UBS2hlGjOya09AA+d6S7NC5uFxrybaw6DslaeBg/jvVv6KIsjLbuDeaZY/8PrFWy2uQNSVzBT0V9pcLJBs6MdoV2q0Gh6Ji8z0Q3+6dVYcSnJLSNvRHCiETvbDgcpQATBSSZrbmCFAsF54/qJmbXplvRRkS/daBecrJjQAeRdVO81pVbN1E7MVq5h6hKPCsMZo0E5Qi05YNnVk73LQyT5rc9+AZz+9Fco/IAQ7Wq1SZg/+rRbSt4WG6W/VWH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3834.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(66946007)(86362001)(5660300002)(8676002)(36756003)(54906003)(66556008)(33656002)(66476007)(6916009)(1076003)(316002)(2616005)(2906002)(186003)(9786002)(26005)(9746002)(478600001)(7416002)(8936002)(83380400001)(4326008)(426003)(27376004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: NWBv1sY2ng8lzEe+ElNPoPkg4Oz4ptCyJ+q8wJNAM6b51GcWyV0HR6mMr20qTydYk+6hLE5MVC6hJq+Kon5LIzWd70qkHFlgQqJi9SB8nuHljC4lUx47Vfvp4ZUy8Z4rR/0vuqodQ1JvI4wlo5+9Nq22rk3JWfzl6jb2b/NNFjvrjpmcUNzvwZWuQZXBWxXq9UOKTAI49QPBDzcueoatv1hVMSGEuJJYInVZtEbXtSSQGtVUO0yQS6AJvd+4q3Urgpe7Kl7bFshUZx1ouDptD3qlqUkpvhwE2SwBYD+bM5mn1JQhKZZvCaEYXG3+xMAbE5ziDJsOZJ32OHxIBv8IJqofIVu2169D3Nycm7pPFqSja16H3neQnz7K5kMzDebd+NXPoD2KRC4gq5rGNy5RuXm+DKdpk4+DXpqt5MizZdVVwJxd13zmvMpVPKFchuce1uzANGEfcmrGIdiEDoW25Ji4iO8aK0aU6yPr8IVygmbuBPetjGJKShSoHyB5NGMMSXkRr4iI+94umBzrO3q9vaD2Q2Eqv+BTdYbOkQfJCtDHKYNrSV15Z5YC6/vV2bVuS4b5b0mVkzGHGCaoTp71l2Qz+dEbJdm8p4vQL7ZSktxvKBDPHuZJN9sg5hWfzPI3fGEZbb2v+NU6MuY2y76l+g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a1c6c0a-c0c1-4c8f-b686-08d858e08468
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2020 19:00:59.3726 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ot2dwTl4kd/iEKOytP8tsrBncYnJbzzlOz9H3tVhsdzwyTuKAG8g+6rGtCyu67NM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3404
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1600110063; bh=vlvj2ZARCqOfsVM+9BOLMvCUB+Vtb8FoFBSD7i0rTzw=;
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
 b=h4gAbtIXQjOMRhWfvdC4UjAfy9tSowrqMx5gOz/4VsG/aKQIkI5EB2hXGkQkhqXDh
 qz7S89Mh2I2xgr9LTnhtUZ/q1O32tsOWaXbp3MPitLAcS5LtX65+ov1BaXju/EburT
 CWYGlRsR5YieTeSbX4f8AT4QeoMS0fN0nCvV+EC2mPzfMnCXgTDZr/AHOWCwDqxK/h
 VpUE5Gbi8NOiL4ZER6jI2fLSb+sPDRZQXCTvDb1YRZNy9U9MVbqhHAyMDpJyF0wWMB
 bzeOQmRUvgYt0rzvDMDuOqwqeinN8uO7W3umsEZjre1EEOpXZj6OWXFdppkk41/bCp
 fcExIJMrruyIA==
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, kevin.tian@intel.com,
 "Raj, Ashok" <ashok.raj@intel.com>, kvm@vger.kernel.org,
 iommu@lists.linux-foundation.org, stefanha@gmail.com,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 jun.j.tian@intel.com, yi.y.sun@intel.com, hao.wu@intel.com
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

On Mon, Sep 14, 2020 at 12:23:28PM -0600, Alex Williamson wrote:
> On Mon, 14 Sep 2020 14:41:21 -0300
> Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > On Mon, Sep 14, 2020 at 10:58:57AM -0600, Alex Williamson wrote:
> >  
> > > "its own special way" is arguable, VFIO is just making use of what's
> > > being proposed as the uapi via its existing IOMMU interface.  
> > 
> > I mean, if we have a /dev/sva then it makes no sense to extend the
> > VFIO interfaces with the same stuff. VFIO should simply accept a PASID
> > created from /dev/sva and use it just like any other user-DMA driver
> > would.
> 
> I don't think that's absolutely true.  By the same logic, we could say
> that pci-sysfs provides access to PCI BAR and config space
> resources,

No, it is the reverse, VFIO is a better version of pci-sysfs, so
pci-sysfs is the one that is obsoleted by VFIO. Similarly a /dev/sva
would be the superset interface for PASID, so whatver VFIO has would
be obsoleted.

It would be very unusual for the kernel to have to 'preferred'
interfaces for the same thing, IMHO. The review process for uAPI
should really prevent that by allowing all interests to be served
while the uAPI is designed.

> the VFIO device interface duplicates part of that interface therefore it
> should be abandoned.  But in reality, VFIO providing access to those
> resources puts those accesses within the scope and control of the VFIO
> interface.

Not clear to my why VFIO needs that. PASID seems quite orthogonal from
VFIO to me.

> > This has already happened, the SVA patches generally allow unpriv user
> > space to allocate a PASID for their process.
> > 
> > If a device implements a mdev shared with a kernel driver (like IDXD)
> > then it will be sharing that PASID pool across both drivers. In this
> > case it makes no sense that VFIO has PASID quota logic because it has
> > an incomplete view. It could only make sense if VFIO is the exclusive
> > owner of the bus/device/function.
> > 
> > The tracking logic needs to be global.. Most probably in some kind of
> > PASID cgroup controller?
> 
> AIUI, that doesn't exist yet, so it makes sense that VFIO, as the
> mechanism through which a user would allocate a PASID, 

VFIO is not the exclusive user interface for PASID. Other SVA drivers
will allocate PASIDs. Any quota has to be implemented by the IOMMU
layer, and shared across all drivers.

> space.  Also, "unprivileged user" is a bit of a misnomer in this
> context as the VFIO user must be privileged with ownership of a device
> before they can even participate in PASID allocation.  Is truly
> unprivileged access reasonable for a limited resource?

I'm not talking about VFIO, I'm talking about the other SVA drivers. I
expect some of them will be unpriv safe, like IDXD, for
instance.

Some way to manage the limited PASID resource will be necessary beyond
just VFIO.

> QEMU typically runs in a sandbox with limited access, when a device or
> mdev is assigned to a VM, file permissions are configured to allow that
> access.  QEMU doesn't get to poke at any random dev file it likes,
> that's part of how userspace reduces the potential attack surface.

Plumbing the exact same APIs through VFIO's uAPI vs /dev/sva doesn't
reduce the attack surface. qemu can simply include /dev/sva in the
sandbox when using VFIO with no increase in attack surface from this
proposed series.

> This series is a blueprint within the context of the ownership and
> permission model that VFIO already provides.  It doesn't seem like we
> can pluck that out on its own, nor is it necessarily the case that VFIO
> wouldn't want to provide PASID services within its own API even if we
> did have this undefined /dev/sva interface.

I don't see what you do - VFIO does not own PASID, and in this
vfio-mdev mode it does not own the PCI device/IOMMU either. So why
would this need to be part of the VFIO owernship and permission model?

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
