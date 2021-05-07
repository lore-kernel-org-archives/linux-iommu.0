Return-Path: <SRS0=Qw1r=KC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B706FC433ED
	for <iommu@archiver.kernel.org>; Fri,  7 May 2021 19:28:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D3806141D
	for <iommu@archiver.kernel.org>; Fri,  7 May 2021 19:28:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D3806141D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1EEE1844DB;
	Fri,  7 May 2021 19:28:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sYxD3CKJvNrf; Fri,  7 May 2021 19:28:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id ECA16844E8;
	Fri,  7 May 2021 19:28:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB9E4C000D;
	Fri,  7 May 2021 19:28:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 80856C0001
 for <iommu@lists.linux-foundation.org>; Fri,  7 May 2021 19:28:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6DD6341930
 for <iommu@lists.linux-foundation.org>; Fri,  7 May 2021 19:28:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n6RilLBIX33h for <iommu@lists.linux-foundation.org>;
 Fri,  7 May 2021 19:28:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::61c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8989041929
 for <iommu@lists.linux-foundation.org>; Fri,  7 May 2021 19:28:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=azcqz+cushPJVRoRhjrov8adbpE5LteN0cYYIT3qim34kB1CONzLWip79lhmbBNWzEKaq/GdwyW91QciiqgdomhFX3gY+AD5DoSXoXR4lqwMjHKRF2mGKIYcbeHXlG/ZZ8DeqRpKpDwN/Tg+gbcXCEUN9aMstH9u/ByMwW4V9WPu/aEZ3eeiN7srDG3Z80VmupU70+211T9czDj5+qnBhkJ14D6AWWjOdVRboiOF6XPa7xMJ4N1RUGEQgD3sC0TOpndbvGpFBvSjX+/pn+UjbbqIj1p1kVRIrgQU8ARr7Tf0CJjzFs8vdhm9rcO857Ef5xyk/sNPPIlT0D0OUf3q6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVjCnUgZG7bFLmsZKWvgm7S8rn2sXFPZXQoCVymeG00=;
 b=YQr8P/DgBWXgB1n8FwU8LebP8YzR3RSNgKn0I23Eg/WfDdIKtNoZsywHaZdMJPlOqMSqW2tcCJJ98rsNQ3Lia2kRiOXxtYe8TiwS4IybCvxCLGBxy79tPDqVCzqqd6Y0umK6b5MrunuPFmzBAztJiC+ftyl9mPdKltnOr5RiGKp8yZHBuPhbnYrnwd2ZbkMD5fzm83nh3AMyP6FENiPQndl+4D1nK6qpbfl3mKVXaEEX2NFd9HneseIcZWJcv/5S+b5ktzTPqNI7nhGdOe1wTA9c3CsdHfiM3GwBa/kmlZzYHRD3K9hve8T4Y8zUTXkU5Ocvwh5s5FFVMmbAGskgYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVjCnUgZG7bFLmsZKWvgm7S8rn2sXFPZXQoCVymeG00=;
 b=k2WAm4fe+IZN4bIbGEwyc82oRA3VuBby5YbZt83mpkRqSLjbRJuuLQCFdS6gF4H+BYQUhe68IqBLMGEfnznNMFkU0Idl3r3Rt7mileBbn1CFiVaFj2EmG6wlsuMSl7bSziqAhXmxSjsFQCIOSzjEYshEzzR9/USkB77YXW6MM66amQyGle5banOJtK3Ey6DdxNFzVGwBtv3zyganR+FchxTZsbDm3X81+BURJyx3CblbR8JfVbq8NpmsmyMEPK95ChRHQfVd2xWFesai0am+v7Nni763h4rCyHkjkPe3WBZH7j7YiIQpYol7R/WuZBW2+XqdvnmVWihZl7hGEmZwJQ==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4042.namprd12.prod.outlook.com (2603:10b6:5:215::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Fri, 7 May
 2021 19:28:12 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4108.030; Fri, 7 May 2021
 19:28:12 +0000
Date: Fri, 7 May 2021 16:28:10 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Raj, Ashok" <ashok.raj@intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210507192810.GY1370958@nvidia.com>
References: <20210505102259.044cafdf@jacob-builder>
 <20210505180023.GJ1370958@nvidia.com>
 <20210505130446.3ee2fccd@jacob-builder> <YJOZhPGheTSlHtQc@myrica>
 <20210506122730.GQ1370958@nvidia.com>
 <20210506163240.GA9058@otc-nc-03>
 <20210507172051.GW1370958@nvidia.com>
 <20210507181458.GA73499@otc-nc-03>
 <20210507182050.GX1370958@nvidia.com>
 <20210507192325.GB73499@otc-nc-03>
Content-Disposition: inline
In-Reply-To: <20210507192325.GB73499@otc-nc-03>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR19CA0006.namprd19.prod.outlook.com
 (2603:10b6:208:178::19) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by
 MN2PR19CA0006.namprd19.prod.outlook.com (2603:10b6:208:178::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24 via Frontend
 Transport; Fri, 7 May 2021 19:28:12 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lf68w-0039tu-V7; Fri, 07 May 2021 16:28:10 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2b14d74-5b47-4bfe-c929-08d9118e4102
X-MS-TrafficTypeDiagnostic: DM6PR12MB4042:
X-Microsoft-Antispam-PRVS: <DM6PR12MB40421635FBA2EBFF309A1BFDC2579@DM6PR12MB4042.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KiSaWiGbxiuDJRrSGYaWWKePKQdY5FpESqEKdeLcub0EiZ8jMqAq2mfQ02+fNu0f64e6nqriMG2mnG1669OaXPWMUwqXxSqMlZirEuC7Q3OS7le7HsXb1KS5HsRhnVjq9Lhfvt+iOaG7nDvDZsmymplhePpTPvVLwZGH3mgQx5x6JIYUEJyDqKQU4JOY5PJJWty98eABCe5bGuUEX3zeErle9nI1jzfDg8qMB90xJGOWN9EYx1H2a0yfUB8xzhqit1UUONfX07/NwJcCBFG4oOHWfiuJLPDSPIfSi6d4m13RNH1YKG+rKyG629/IGjLdRGYYayi6+5BH9g1nWKA1bwoq0HkqNai8Po9EtTOsKo1/sdQXiqz2l6ueGNJUcuPeoKM+PkT91WI6iNYBMYTQYCHHGRj9spuMyGqUKaM4z/mK7p9VrEgSlPXaQp//656XvNym1ur60oRV9960kUuWBagQT6RwwmzTspaJWbbw68ZyWHQbZ4w00dkH9zq0plO8KTjuX0ehcjjc29/1TAVy6Lu/wiFs+lGVzPnscF7/jlL9X3DSRiOGPCv7RyPs9elbRZaZPBp+mVyWflKOTr08ndv9sOFL42TZUKySIbUnC7A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3834.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(33656002)(2616005)(6916009)(26005)(66946007)(66556008)(54906003)(66476007)(4326008)(478600001)(9786002)(9746002)(186003)(36756003)(38100700002)(86362001)(316002)(2906002)(83380400001)(1076003)(5660300002)(8936002)(7416002)(426003)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Vtp4aIVhOAWmEiX0SSTXp55uPZSXsiHs+gM9SPjGLroWwJhfFb+HRePpltFJ?=
 =?us-ascii?Q?QslbXDwNRIYkQ4n4Ca4u2vvL6Q9BWuiMhuzWxf1raY/E+wGUnEI+SCM2YhWB?=
 =?us-ascii?Q?EBKlbON8k0dq7J0hJrXN5BimIApd0QA9IxweaRwG3qrhrAQaW5E45syNClMt?=
 =?us-ascii?Q?KuHQb5zzXocbJT5nMZRbSXOLaSEQv/kSj9rOXkjXXNPQh/o6EnaiQkuAVTfT?=
 =?us-ascii?Q?X8Ti8XA+rW0N2UWwJwznXcmI4FsGEA22sXJTwgv731S4xFixf3417HBdX/xs?=
 =?us-ascii?Q?Lj5aUT4kj1i1FmCFjBMzWRBG8FUam/h+Z/5idtzNsF7Qs0nitYOIA0R4cHE8?=
 =?us-ascii?Q?akpLPvDcb4aBvChW50cx4bQyma+9srw73FSnF+7UtqVeeD7IJ9XITPZQc/CQ?=
 =?us-ascii?Q?7LKDi4Bvn4i7E+za3XzuLUPZ3MG3vWap+lECzDivIKw5HdK8LjJQa/Z5M/zR?=
 =?us-ascii?Q?TzG5q1zrXC3hfCOPnUtT+KbUh6I2u8yt9UTAXbl72PFfCIA6DMjAkgEwtt0v?=
 =?us-ascii?Q?SPTIw4QVwPlHmjSkswLs6uruN0sYX5PSFQx4eAENnGiu8oZYa2PZZtQvdVG/?=
 =?us-ascii?Q?TmeIVe3HKB5KagdfACYv95XsuUt1BOt2fzguqw9IdG+qyJiXA0q6UfZClRvi?=
 =?us-ascii?Q?zrsx8ChJ4jgXoboMUMU5s5CFBoqcpbz+qU/GaChFrpqjFe8asf2NLGx8wjCH?=
 =?us-ascii?Q?kDbPRcr5FEgdBURQuSiyElQrUnfF8dklCsEhyOspDUC+jCH9nHqZPRwUB7DV?=
 =?us-ascii?Q?CcodetZtpGeepVX+95ivlPqGVYTxEIcr+fmtVu/+i3erOViRYQRWoLWSO2Oe?=
 =?us-ascii?Q?ZJfcyKjRrSgkxrAqkvf2XFFvs9ORkjfOMmovAEWvq2PUzfYxd0pCLSze/KoS?=
 =?us-ascii?Q?HEV2uxpbnntxN4SFdYvSetMbUQKsSiCo/kGY9K66xoUsOIUPvyGR3HOuTEg7?=
 =?us-ascii?Q?NVICsM9d/1oAoSd7dq15gjGvjiTdKM4XpwfAjRoeBeQu1Drr5Ll2TehkY9+B?=
 =?us-ascii?Q?0bjoUDeZKqHdPBOX7FX+odVlbdc3oOPRrjDwpKTkoCh3ws2h4Uo2m+Xfxlhu?=
 =?us-ascii?Q?0A56LyigvYlCPwEnCSg+M4a8uSbYx0bjRT3VHq1ZPPbXHsDABVWds/yAv8f3?=
 =?us-ascii?Q?quFeCE0f7dVNCBLDvp9qd6EP728QrqGJBVOnt5Cif3Jyl+o9aUzijXtD/NTL?=
 =?us-ascii?Q?qzXxUBdU9g/fZ6lX8RojX5aFB5uYSQBH6Dt1tBrKEZNUji4M8rvaEkLHgB5E?=
 =?us-ascii?Q?vf6MCoQnGN6VG/CzPhxYjHoJBIyd5QfBYD8uaeSwGOn6xx66am3qbilbvMFz?=
 =?us-ascii?Q?oZdl8290DlaYv7+AcOGtPLsf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2b14d74-5b47-4bfe-c929-08d9118e4102
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 19:28:12.5414 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +BdXthI7zn7/+L5/Q/PzlDfmAw25mnHtixpmvcIQ5DdIWmFW9eyjNtx0zqAeAK3z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4042
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
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

On Fri, May 07, 2021 at 12:23:25PM -0700, Raj, Ashok wrote:
> Hi Jason
> 
> - Removed lizefan's email due to bounces... 
> 
> On Fri, May 07, 2021 at 03:20:50PM -0300, Jason Gunthorpe wrote:
> > On Fri, May 07, 2021 at 11:14:58AM -0700, Raj, Ashok wrote:
> > > On Fri, May 07, 2021 at 02:20:51PM -0300, Jason Gunthorpe wrote:
> > > > On Thu, May 06, 2021 at 09:32:40AM -0700, Raj, Ashok wrote:
> > > > 
> > > > > For platforms that support ENQCMD, it is required to mandate PASIDs are
> > > > > global across the entire system. Maybe its better to call them gPASID for
> > > > > guest and hPASID for host. Short reason being gPASID->hPASID is a guest
> > > > > wide mapping for ENQCMD and not a per-RID based mapping. (We covered that
> > > > > in earlier responses)
> > > > 
> > > > I don't think it is actually ENQCMD that forces this, ENQCMD can use a
> > > > per-RID PASID in the translation table as well.
> > > 
> > > When using ENQCMD the PASID that needs to be sent on the wire is picked
> > > from an MSR setup by kernel. This is context switched along with the
> > > process. So each process has only 1 PASID that can go out when using
> > > ENQCMD. ENQCMD takes one mmio address specific to the acclerator and a
> > > source for the descriptor.
> > 
> > Oh. I forgot this also globally locked the PASID to a single
> > MSR. Sigh. That makes the whole mechanism useless for anything except
> > whole process SVA.
> 
> Is there another kind of SVA? Our mapping from that each process requires a
> single mm, and PASID for SVM was a direct map from that. 

There are lots of potential applications for something like ENQCMD
that are not whole process SVA. Linking it to a single PASID basically
nukes any other use of it unfortunately.

> > I would have to ask for a PASID that has the property it needs. You
> > are saying the property is even bigger than "usable on a group of
> > RIDs" but is actually "global for every RID and IOMMU in the system so
> > it can go into a MSR". Gross, but fine, ask for that explicitly when
> > allocating the PASID.
> 
> If one process has a single mm, is that also gross? :-) So a single process
> having a PASID is just an identifier for IOMMU. It just seems like what a
> mm is for a process == PASID for SVM-IOMMU support.
> 
> The unanswered question is how do we plumb from vIOMMU without a custom
> allocator to get a system wide PASID? 

PASID allocation is part of the iommu driver, it really shouldn't be
global.

When the architecture code goes to allocate a single PASID for the
mm_struct it should flag that allocation request with a 'must work for
all RIDs flag' and the iommu driver should take care of it. That might
mean the iommu driver consults a global static xarray, or maybe it
does a hypercall, but it should be done through that API, not a side
care global singleton.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
