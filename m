Return-Path: <SRS0=Y/Kh=OV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F190C433F5
	for <iommu@archiver.kernel.org>; Fri,  1 Oct 2021 12:36:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E69B361A8B
	for <iommu@archiver.kernel.org>; Fri,  1 Oct 2021 12:36:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E69B361A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B77834052E;
	Fri,  1 Oct 2021 12:36:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3cDM_X2saTRe; Fri,  1 Oct 2021 12:36:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6E2E140466;
	Fri,  1 Oct 2021 12:36:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 51A54C0011;
	Fri,  1 Oct 2021 12:36:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D2450C000D
 for <iommu@lists.linux-foundation.org>; Fri,  1 Oct 2021 12:36:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BAE6040466
 for <iommu@lists.linux-foundation.org>; Fri,  1 Oct 2021 12:36:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S9eIpxapFNFH for <iommu@lists.linux-foundation.org>;
 Fri,  1 Oct 2021 12:36:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::62b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9869D40467
 for <iommu@lists.linux-foundation.org>; Fri,  1 Oct 2021 12:36:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wzd8/xpVGv4jSPyYSrGNY5BJx/6A/mne4Hh7lge0pkwLwD774GFQ7DcLZGsKyV2SXLchzXqRXAdeRwgGYlDIrYRj+KzvrEMtBVjJG0sbmxhkgeCKKEn8dw+AfTDPqS8+8cnoeFv/OVD1vh53ZjW0DNjkvPFnaxLHLNgdSbk7LoxJ1Mg5DMvrmoX7bU+Wc+mm/T1eKb/XcydeYrwIgYDmN4lpQYW5X9euuqKIYnHL10+ttM2rHs0hJ/ctkynaN8DY436FxaWOGd0Y4IXe1W38a//N8QjwH1Xe+TUQL83W4TTtkGgX0nhh7+R13+eZ1ofaL4fFUTo67Y8aM7Et31pFYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pOcKtE/1VE85U8VUosBT2OMpeDhoCPF4Z2Z2xCjNTj0=;
 b=gC5Z9FDtKHOv0rK6mUIKH50lqHO+dyzSv2+3Knq2KNTqSwnzZf8+vUimvV0azai4RYW38nqo35loh86zen1+2Q7JDztBcFjIf7SsWrezc8G5CIS+PTbJj6y07UrO78Wvs+NfMR4mOFaoC/pHiYb/be+Sh3j5IMvu1yLd0l9/vmPgW3dLlRR450z9dwRprSnZhEETi8So1OyX+fdtcVcZSYrvNDNcMCh8ueVCtdOhL5Co90xEwFoWd3BPeJ3msrJI0WWn0G3NmUcbFBpIG6TCU6y7VQQyDQH0BJNE4sCO24CtlOWJU57egyuXK+wB0vQa4v2tCFATvZt+Lo5OAJbz+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOcKtE/1VE85U8VUosBT2OMpeDhoCPF4Z2Z2xCjNTj0=;
 b=I3MphTczYcrTsPUGdmQimjq71GFP22yGwrtehMRXiVqaAwhNYGZWdiCtHYVEWwM9w+cKNRB7s2nTS5rAWymhVOFeAdDXSAMtJxHl+xhJvVE/t4M4oBqP+rFGFrMWsXwxaBA6EJJOHYnz/RUC1bW4DJSgMmZlM95h1lQtUK7C3LdARQroA+IRlYsKWKL4XVVemdrFYPCVfNklCo713J4tQq9HonOlkUwCItxaVnLVA5s3q1S34RluPlnelxnDQmrPEJBgVV0EOTB8TgIXmquB164B/Y4N3Rkb979CyN6wk+HcfFkY92sIktvqjwQOQYi9pvllsNNIyhr9ITBx4G35KQ==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.19; Fri, 1 Oct
 2021 12:36:24 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4566.019; Fri, 1 Oct 2021
 12:36:24 +0000
Date: Fri, 1 Oct 2021 09:36:23 -0300
To: Barry Song <21cnbao@gmail.com>
Subject: Re: [RFC 0/7] Support in-kernel DMA with PASID and SVA
Message-ID: <20211001123623.GM964074@nvidia.com>
References: <1632256181-36071-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <CAGsJ_4z=2y2nVStXP-aAPnQrJJbMmv78mjaMwNc9P9Ec+gCtGw@mail.gmail.com>
Content-Disposition: inline
In-Reply-To: <CAGsJ_4z=2y2nVStXP-aAPnQrJJbMmv78mjaMwNc9P9Ec+gCtGw@mail.gmail.com>
X-ClientProxiedBy: MN2PR02CA0015.namprd02.prod.outlook.com
 (2603:10b6:208:fc::28) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by
 MN2PR02CA0015.namprd02.prod.outlook.com (2603:10b6:208:fc::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.15 via Frontend Transport; Fri, 1 Oct 2021 12:36:24 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1mWHm3-008PZ2-GZ; Fri, 01 Oct 2021 09:36:23 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c74fa014-c89d-4923-a419-08d984d8148f
X-MS-TrafficTypeDiagnostic: BL1PR12MB5112:
X-Microsoft-Antispam-PRVS: <BL1PR12MB51128BFF1C20B136CD2DCDECC2AB9@BL1PR12MB5112.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z9flkMUuSSRipi65Uei3VwQBNSDZG8KWXBI1qzI0lnVn9uOgnKi4SC4HbFfFovD1w8eDuo455USCRyKgNx5F4dymYICL5GW+qDgiHVnn7EMk7ve2cdT3dtLRvusTKPIXXuioJwJ8IGdVAt0bzxv/2RDkrwbBqd1pgrWsXSgqJsCfiDdRYAh10OKZdEnFaZ+hS6kwUhQry8QYonOjPijLr5BC67NFAQ1G8/nEHIuye/C1Eewzu7MzC8I4vXzIgnGitVnDOD8xqGNdWbkhIZRJBXaNujptaj9p913yhOdspmclkWc4aTinZnmPNaqYjQtasjySHDNVJRPdw8gn2SFeMtX/qkAijfwxDWPtxDjM10lPV0D838CAT0iAkgM6Ve9SwlZlqgR1EHTM0Pr2dtT+o3boXKcXFWS1iN7IlEsPlhXXzV2E+gmXkdLlO6JmtSajaOyH5Z6Qfx2K1EuepPtkj4e2o1fyCPFYWTazxoBnGKjEe0a3UTvpgvagwuP2cY5nAJRNLZ7A5HoHi/UxFtratcDPgZZDsD6RO3ZI5MVt4D20vCkU+zICH46JkA8S23VtnHSyF067n2KWih1waPlTACgGjOMZueZbDETpPLO8NqrjRnG37o1mZh5uvPfdeDUD9KZJ6fYscPhNcMbvZzUpfMT3RUWoVZmTUhG21Vjym4D/tZUf1k4FFPf5OjeZ2QJEAVx7ytVSAkalCX+8YoceRA7hR5CQUCML+lbNfmy230iJ0KTn74XipFBvP5ftGc/4umN34hcUqZbs0xpu3Vm7feNsfcdkas1umoxgHEv5MoQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(4326008)(83380400001)(508600001)(66946007)(66476007)(966005)(2906002)(186003)(86362001)(66556008)(5660300002)(38100700002)(26005)(7416002)(316002)(426003)(1076003)(9786002)(6916009)(8936002)(8676002)(33656002)(2616005)(9746002)(36756003)(54906003)(27376004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e0uhq7aW4qtdgjVkR3kXuJUdoPk7QfdE/o/Mwi35pjNcr87SHB0guJU86kVX?=
 =?us-ascii?Q?I3wPAtnXPKwr5iji+tHVMuhDyJ2KfQZbgKB09J4dX1mJIY2LMSDs4gjTqStc?=
 =?us-ascii?Q?yyu0CDcSED3i2CJgZ60ru82IwrUPyZi0sRm6ApfkqVizoGWqd8PIe7O8IMWA?=
 =?us-ascii?Q?/dK6ELxRnVx06aUCL3o8Wze+EVCDmj7fwN3AEpdIAL5Dsaka/tKaHwwgZr92?=
 =?us-ascii?Q?AKRLp5FQG1Ga/1wFet2nhno5+YjkOG1WhodIm7dG23rMYxdjMccSXJAbq6P6?=
 =?us-ascii?Q?fjlz17YLLBeQ5UBsIg30Y30jQZOJYinEkWqYu2o7HOJVB0MyQ2AwvKqDiTD6?=
 =?us-ascii?Q?MhoSWxXcBkoz4dMA7eCf1G8bCRrGf70Jjf15nJykPVIaeGO053CFXYCw1YDz?=
 =?us-ascii?Q?tZaKxVGkuBLk9bTy+pUN6iD6wFItpg+mgoWbWEF1PC3LgnmdeDIpaM6trhtm?=
 =?us-ascii?Q?Vi/qh1tX90pDBaZ1ZQoI8E6GWCqn2vOQF57Ld0NXP1J5vdwNjtbDQ6ZotS50?=
 =?us-ascii?Q?D94mSFS4/HOL5f7pwWiluUEuB50sm87rg4a9E6hxbboy0LGPBvqed4fOSHCY?=
 =?us-ascii?Q?QuGSO7x85WOdKninOQyCk3QgHqUEsjNqTio4NjI4ScbA1rf+1PWCYFCGCW1L?=
 =?us-ascii?Q?Fsh12Kd6tNhauH5sZXSOKDyJveCYwhXNzOIyHX6Enmp+0tkFjTc/jdNVwKeH?=
 =?us-ascii?Q?WWuDqIJ1qODJBv7Vf5R2Bnsf7HvTrRD4aCvq9DCHA+czPjuhebdxPD8xdHHx?=
 =?us-ascii?Q?8zzXUT2BuNJIqohreXtWiS+3Z1TtseUlSMgO7SuvKp/Ti91as2jNrzOKDZVm?=
 =?us-ascii?Q?Yt4dRt85mfmtjVfGOTXW5F1bsK/LIWy2oz0x8XlcueHqOzi1o/1sdBSogzzN?=
 =?us-ascii?Q?duMo9J2hmBZzE6ykXSD9wRxmEEvfT+BcJiyCxWGyXSOWQ9khmapiEFXSYoXO?=
 =?us-ascii?Q?9wVj9yrvBdN+gPgQmGWcZEP5YdY7giarhi+s2MXbrZs7kMRP90Hv0OA+CHrN?=
 =?us-ascii?Q?lTHm8D43v1/miUYYG75EYJ3qHX1Zv+z2/ayODG35ybdZeA+jXNl1BY4wMDnA?=
 =?us-ascii?Q?a2r4h4UMXWXF9UGnA9cZlUrIpzaASl6viItpD975m6ByJlG3VpI/cmeKYKIS?=
 =?us-ascii?Q?VKb+H26AQjlJoloHOc3p7xa8Krt9lvfwj57bSRH6hye4dneY2nDvQ/B/r21/?=
 =?us-ascii?Q?B7HXTlEEykULfAXL5l015Rn18s+oHkO5XlltMMyLFXg+Fp9yNRO4qcI5GeYc?=
 =?us-ascii?Q?7M9C0ABy7NYupIf0LkejH+Zl8ff+oyxwBWZkM8mycr5pGNQlIBEU29xOYuo0?=
 =?us-ascii?Q?KWUjVPdzWPa0AUi5L2HrMjVi11GBi5aLRU+4EtZMDkasIA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c74fa014-c89d-4923-a419-08d984d8148f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2021 12:36:24.3690 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IK1V+U/VNScraVZq2XqY67KaE83AeMe6XUnOwd7tRE8XmMoOnGaHIl10x+sgPnwV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5112
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Raj Ashok <ashok.raj@intel.com>, "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
 iommu@lists.linux-foundation.org, Tony Luck <tony.luck@intel.com>,
 mike.campin@intel.com
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

On Sat, Oct 02, 2021 at 01:24:54AM +1300, Barry Song wrote:

> I assume KVA mode can avoid this iotlb flush as the device is using
> the page table of the kernel and sharing the whole kernel space. But
> will users be glad to accept this mode?

You can avoid the lock be identity mapping the physical address space
of the kernel and maping map/unmap a NOP.

KVA is just a different way to achive this identity map with slightly
different security properties than the normal way, but it doesn't
reach to the same security level as proper map/unmap.

I'm not sure anyone who cares about DMA security would see value in
the slight difference between KVA and a normal identity map.

> which have been mapped in the current dma-map/unmap with IOMMU backend.
> some drivers are using bouncing buffer to overcome the performance loss of
> dma_map/unmap as copying is faster than unmapping:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=907676b130711fd1f

It is pretty unforuntate that drivers are hard coding behaviors based
on assumptions of what the portable API is doing under the covers.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
