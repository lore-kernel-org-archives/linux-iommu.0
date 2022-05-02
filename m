Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50815C433EF
	for <iommu@archiver.kernel.org>; Mon,  2 May 2022 18:52:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BEA85404CC;
	Mon,  2 May 2022 18:52:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ccMYJo2_w_rM; Mon,  2 May 2022 18:52:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 34AF1404AA;
	Mon,  2 May 2022 18:52:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EA48CC0039;
	Mon,  2 May 2022 18:52:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DA734C002D
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 18:52:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C4FD04017B
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 18:52:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1vQUGIDi662u for <iommu@lists.linux-foundation.org>;
 Mon,  2 May 2022 18:52:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::60b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AADA540133
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 18:52:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=acKlFHaDqAHFGL0Zv0ToMK3VgITjmhVcatKfN2ObxAB7OX7xBH0OA/QxSwBnOeqIMIz+yZ6r2b7fulN8n3G8x7nXDwvCEaqHqanb9gmTzK9xacN6i/HkrCMmxPgj2bAmnC6ilB5przDJ2XjwDvCkkMYFDqzGWqquiaoTee2GEAdH/70i7w3AbEkfKMtvqLJzLYW07ILNPtixVUgfOZCx+0Gdy2ML/sqb9ppx52bsNW/bQYonVtUbNiKcrpAewKJWYyyZbUJjad1Abxv47kgdEj7ibkGjdspfhX/6yVVjjE2BZ1lFOelYWFMDmdsWprynnKUJ1MoUmcx3n/2eeDnGDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YTrH54Q0ak3O08Ua75SP0cngekWvRxhcobdfzgzTyTA=;
 b=gUg1kYE5GbHwmSUUW0i7T1fCr/0E/+n760WQtjZmjdLDMarbGP6gmD0uXiJLM8++XahKfrmU5RsR89ASxnlAKlDpxvOgcfxjRbp8DEhU+MDwPt5MQlBf8vKd6PvFQJnEWH+efaBX/J70yLaikD0hJIPnHy9A9DFW+3dIG29jMpPc5p7hRFb9nzFPFCoLm4Jlr9uEm2VPrDS+M5L3eUoj3yHz965NQRQEgbR8BNNZJvPhUx+1YB67YXvFHQuxnWMnaZwjOpVRRELLzT1aFtl1jEx1smetAK5cI5ZIyMGkh/+7pfuvDuN0tgvIkAkJpEKsKUdsNrCqVV7qCeGbM0EYMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTrH54Q0ak3O08Ua75SP0cngekWvRxhcobdfzgzTyTA=;
 b=pejgcQ+aIKr04hvyOfh3hRV9vl6ujWPvZWeeRibAatsFzUTHU/EXSdQsRwApd3hHrEiPa29t6umGShd2zTcdsM9zRKassFghJRmiZG31MXDSDBM+hvzdT32j3UPND8/NH4ydISUtRX6VCWdHyKSoyPYZuJh5pFZkoFAD6TPI+whKvsnh0jeZBPkG7Of7tWErhxSL0RNs3aVrajXEi2+5Yw/G3qy3FzO9Uz5jvfluxBP+AYd+Rrkf1XSEByB1aZ8tiaqH/r+i//TmstbIIcbU9Jr5m9K86emGyGebcD3gVtbaqFS1VRAv8t+M1WhSX7MoVR0MguXYzb4HI8FCuy8CJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN6PR12MB1921.namprd12.prod.outlook.com (2603:10b6:404:fe::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Mon, 2 May
 2022 18:52:41 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%6]) with mapi id 15.20.5206.024; Mon, 2 May 2022
 18:52:41 +0000
Date: Mon, 2 May 2022 15:52:39 -0300
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH RFC 00/19] IOMMUFD Dirty Tracking
Message-ID: <20220502185239.GR8364@nvidia.com>
References: <20220428210933.3583-1-joao.m.martins@oracle.com>
 <BN9PR11MB5276F104A27ACD5F20BABC7F8CFC9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220502121107.653ac0c5.alex.williamson@redhat.com>
Content-Disposition: inline
In-Reply-To: <20220502121107.653ac0c5.alex.williamson@redhat.com>
X-ClientProxiedBy: MN2PR04CA0009.namprd04.prod.outlook.com
 (2603:10b6:208:d4::22) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49b4ecbb-3eda-4e9c-2e09-08da2c6cef3e
X-MS-TrafficTypeDiagnostic: BN6PR12MB1921:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1921D2A3FA9909062F49059AC2C19@BN6PR12MB1921.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kejYvvN6AbMFhgw0zMbUjnYwRXbg88ykRt53cKiapn1gd+QT0klRGiL7KGDFMM3sd33m9kVye5JPJIuX+zq+h+mUmkv5ds+XE9E5kih41YAQJuDI6FzHZTU2e5g1KG0Tz6ao/bkWI9a5MPzdlZJDbihApcZ/UCl4MuMDKqAM0sLJYXmaOGGqfKAnUurjlZ8AIkwt3BhsZREqvIb0IyCjnrdMOaze1kjZXYEez/VXmqNM+wGdQFz8c9t69WHr/OVVPGzeEupmdCwroLQnVdoH0AXTcDdqfpDoWTLofEmfNZNk8tySXA3I/XKMDW/p8EOC2tlb44AV33jaCRsSvVYB7UyWsZSDQNndnyrRbKhS1DHJY8+v+NUsBZ+z0VuUBvRN+jUdL6hcXozqJMJXS/6byHY9vm24bwVmTt5S1w0xbd1lKKVIR1BNSwbXkEBj05lspO8d0b/MrWaQOuapP7Wyz9/TQINK0oRz6CQpwqRzqgCtFk2GzI//yhcv8iei/JfgkbcHhjgR/KV5RKuZpmV0770zG5HEw6ihK4eMghEpAvePPai8+JHmh6k5ykpbj+CsuaPqUVq+TZZPW+Ol3iXiTEwKi61MU/dPABpeYp+A2pHIZ3mL+fjaCA4IfnRjIQg7/YEgPXFFmsoigFq7TkfXwCaM7+1dOs/Sku9/84q9owRdKQL1Zt75bVmPLR5r5OfSWCNTTFCc1Xxhf3t07VVtWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(86362001)(8676002)(66556008)(4326008)(33656002)(66946007)(508600001)(66476007)(6486002)(54906003)(316002)(6916009)(38100700002)(2906002)(36756003)(83380400001)(1076003)(186003)(2616005)(7416002)(8936002)(6506007)(6512007)(5660300002)(26005)(14143004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cNFxr18iKRLaZ8TNCRXkNumynbaApOmes+ezKTkOafxow+6ImIVNYmJvD1uU?=
 =?us-ascii?Q?upPsmdU5m9pEBkdeZVyWJtkxrHcQIqfw+0xnvZGLSkTCDyP5NIz9eAouhT2t?=
 =?us-ascii?Q?4SNlxf0WmKQcVlhE+dJBFehiLkDU+Pr3ip6GxoHuvP5vJNq9J5S7StGY9Toq?=
 =?us-ascii?Q?hwBWf4bRv4D6SQfJx/6Lj4dFuvgonyRelCW62oldnPJXDcM+I5n4bCFE+N73?=
 =?us-ascii?Q?Z+JFBCKyTAvCRtrlH9tvVlaa8ynaGpnPrLQogK91VNaxV63ku3AdXIl263C3?=
 =?us-ascii?Q?xY62243CmmBehWYItjogN64kEMG1S9oouIZ35+32EU8WHIeaaQ4QCsvFeiJM?=
 =?us-ascii?Q?X+2Iomz3hxHxolS2rvp/8MSc+yTp+OIy0peHOlWhptLGJ8EfqY6M0FuSXoEH?=
 =?us-ascii?Q?7n3Rn5hfyEENfLHOPwoqlIdvGg1Z6m9Yt14ctxPGOpfIIE8QsBU0I7hzRaO3?=
 =?us-ascii?Q?OOy7gp/fETZ1KT3doJLex7kLo6v83VHDMPegI/xCiAbMrRtwNRVqaKwhaRsq?=
 =?us-ascii?Q?SJ9Ye4Ji3mvKJw8W0AYw82TsCw7FxdQVDeYpd8RPg92ChLN2dQtpYdrS1UpY?=
 =?us-ascii?Q?IwOx2miBWhXVQFGR0ghnGBaRXxZnVDMRrNd8t5ZhtPQ1m6Hk31qJ2OKnnSn9?=
 =?us-ascii?Q?SrcYHQlNFsi91V7ZdekUkAcR4ErFQzz8fktOWdTtOk18kLRWxw9RpuLejrOG?=
 =?us-ascii?Q?LwqUUF+17OVhHFlCiZGxP7oMCY1kITyuxjqotkFA3DT/4cu0cC8HCLwYcvTB?=
 =?us-ascii?Q?tXWaT+2yAT6ajdASnjkvw9/b9f5G9upN7s6sWKeGmRpJ5ot7BLByy9g4pFgN?=
 =?us-ascii?Q?83WPUzmV2F5DMo5KAQnqjJYM9IJiCvW5YlgmXsqnlggc+s4wbpx6LpmzBpa5?=
 =?us-ascii?Q?aAqCAtO5o3uGGRELvzxylxQCzzKUJV2iGWxw+H3he3dxAt5M3BSsYixgNc00?=
 =?us-ascii?Q?EIaYrU06uLhbXnQoe4r7/CDs9Rhz/BGKqbbZ1zup6gSLgWVYrSMFoQFaw6jX?=
 =?us-ascii?Q?bSTCrFtCKNU2FfSGRLoMP/Q2oqZUDxbk7+arQHS6VIai8jzM5NGdPH9GDZ3l?=
 =?us-ascii?Q?VPAd3jgUstW1waYlg8h35bnubu05bmGaB/SJzM84yYsyCBk7GRujsdVypikx?=
 =?us-ascii?Q?4+iB1Bv1sbLOjJ2Tkm4RbijwnONe4t7I2B/OFBKTOPulKWxA8dCGbDlblguz?=
 =?us-ascii?Q?+avCXqkm/7M5ndKovhA+Wv1nzpr7gk28OcRs6sFVDaGNGj+d5zVRzzICEghZ?=
 =?us-ascii?Q?CfmsYmE/ButYh2bP7gTsZNZM2jt0yDboMxfFKOFWQZmKspNJnea6QSB8mR5j?=
 =?us-ascii?Q?CbWPqVmR3/J36bYZdGfZW4eoEpTDPbjAIeLleJKMLUl4TSPFLo67YjLaqZf6?=
 =?us-ascii?Q?h6z9lx64zmdUZfpy3GRMoZqcXcqttI1hFEVthM0/ETzvzRKa2kjK3dTRrBds?=
 =?us-ascii?Q?ycUHCJh9QVUqUbbJFnsyrmxamriCPexkOLPdwZqXUxeqRrqTTbuW3ag5RVZa?=
 =?us-ascii?Q?XiEX/okX956Fp21SzEVvw+olXo/SEYtNplDqog9k6gjmFq1KF6TOdia1ih+9?=
 =?us-ascii?Q?agkz+Z3cqw90SuxxZxJfy7c3egTRigpNMHIqiU/tRHgM0UCvw4nFlrfsrL0s?=
 =?us-ascii?Q?yDt+tCUGzaVoH8XeWfAZ9oafKQ5gc+9fa4xA2bS0oMloVEVQ5/Fm/JVPm3fn?=
 =?us-ascii?Q?0Rxcyxpb0BwC7LhSF8/mwZs3iUPIcen0E2GazYTG2eo6LN9gxxfNlrEyYbrl?=
 =?us-ascii?Q?pjMHWqo9cg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49b4ecbb-3eda-4e9c-2e09-08da2c6cef3e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2022 18:52:41.0453 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nAqx3lwh6CydFBxyO/rVI7vaMYmR6pHjvJeqvsc636+eTgfpZfMmZAqgJbLk1OLB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1921
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, Yishai Hadas <yishaih@nvidia.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Cornelia Huck <cohuck@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "Martins, Joao" <joao.m.martins@oracle.com>,
 David Woodhouse <dwmw2@infradead.org>, Will Deacon <will@kernel.org>
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
From: Jason Gunthorpe via iommu <iommu@lists.linux-foundation.org>
Reply-To: Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, May 02, 2022 at 12:11:07PM -0600, Alex Williamson wrote:
> On Fri, 29 Apr 2022 05:45:20 +0000
> "Tian, Kevin" <kevin.tian@intel.com> wrote:
> > > From: Joao Martins <joao.m.martins@oracle.com>
> > >  3) Unmapping an IOVA range while returning its dirty bit prior to
> > > unmap. This case is specific for non-nested vIOMMU case where an
> > > erronous guest (or device) DMAing to an address being unmapped at the
> > > same time.  
> > 
> > an erroneous attempt like above cannot anticipate which DMAs can
> > succeed in that window thus the end behavior is undefined. For an
> > undefined behavior nothing will be broken by losing some bits dirtied
> > in the window between reading back dirty bits of the range and
> > actually calling unmap. From guest p.o.v. all those are black-box
> > hardware logic to serve a virtual iotlb invalidation request which just
> > cannot be completed in one cycle.
> > 
> > Hence in reality probably this is not required except to meet vfio
> > compat requirement. Just in concept returning dirty bits at unmap
> > is more accurate.
> > 
> > I'm slightly inclined to abandon it in iommufd uAPI.
> 
> Sorry, I'm not following why an unmap with returned dirty bitmap
> operation is specific to a vIOMMU case, or in fact indicative of some
> sort of erroneous, racy behavior of guest or device.

It is being compared against the alternative which is to explicitly
query dirty then do a normal unmap as two system calls and permit a
race.

The only case with any difference is if the guest is racing DMA with
the unmap - in which case it is already indeterminate for the guest if
the DMA will be completed or not. 

eg on the vIOMMU case if the guest races DMA with unmap then we are
already fine with throwing away that DMA because that is how the race
resolves during non-migration situations, so resovling it as throwing
away the DMA during migration is OK too.

> We need the flexibility to support memory hot-unplug operations
> during migration,

I would have thought that hotplug during migration would simply
discard all the data - how does it use the dirty bitmap?

> This was implemented as a single operation specifically to avoid
> races where ongoing access may be available after retrieving a
> snapshot of the bitmap.  Thanks,

The issue is the cost.

On a real iommu elminating the race is expensive as we have to write
protect the pages before query dirty, which seems to be an extra IOTLB
flush.

It is not clear if paying this cost to become atomic is actually
something any use case needs.

So, I suggest we think about a 3rd op 'write protect and clear
dirties' that will be followed by a normal unmap - the extra op will
have the extra oveheard and userspace can decide if it wants to pay or
not vs the non-atomic read dirties operation. And lets have a use case
where this must be atomic before we implement it..

The downside is we loose a little bit of efficiency by unbundling
these steps, the upside is that it doesn't require quite as many
special iommu_domain/etc paths.

(Also Joao, you should probably have a read and do not clear dirty
operation with the idea that the next operation will be unmap - then
maybe we can avoid IOTLB flushing..)

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
