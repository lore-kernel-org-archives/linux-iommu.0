Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB85C433F5
	for <iommu@archiver.kernel.org>; Tue, 15 Mar 2022 14:22:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B5E2E40199;
	Tue, 15 Mar 2022 14:22:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jbmnylThGbKN; Tue, 15 Mar 2022 14:22:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 91480400CC;
	Tue, 15 Mar 2022 14:22:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71D76C001A;
	Tue, 15 Mar 2022 14:22:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16525C000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 14:22:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 13186842A2
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 14:22:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O8RhbTTWq9eT for <iommu@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 14:22:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::606])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 815D88429F
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 14:22:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZCzQ5Q7pXy1uBI1dJGSh8o54FjCNuJ7+2NLsIzTZu2ep0y0nusfUIwJKBkVsKCFsgHM8djsxt4iu6PLZJ0Skxm/lyX+dfepx3TlPnL2qpOtEMRDQxAl8aRjsPwxtaGSZrt5KSNFkdzaVRSR49k1H8grhi9IQyDk6iCrhSOBMQFVSwccGL6nGQDGU6vj3z/6P/21Hh2fDAdrjjmhRY6pY0ftA3GyWYFRXUPcd59apwQpeVcNDVLf2G4uWq+iKD/QaGEBDHO9lPEP2MHFzi9ut4Oi016aio4qqAsbMZF0A2Ao0SqneYPDJmQoIyD851ta+sQw9RVLVw9u3FJnOgo56w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8maagDvFZJu90WB3fdFQeSAiTEdFokKANTW8fMvb+DI=;
 b=mZ9oDd3wXr1uFXwi24theHmARS/A1Ww7zrhKA7TF/bzFgeb6ViiakjL9Bki3512smiMvq6GwjFYehf4wNBW2dF/8P/IQf0uGdO63XYVAGuUej4k6jvnWXzqMbq9MIJwCojzlng9yxey8gTuUh6sb8X+IcoKdqpWyRfRURdeuD1IrFMBUxyzTDrsPtv8AY1Rhs4gfOKim8cThWokIwlKTqEHho7h7JcpEzvRcHKAnX+TYIs59Qwb+NtigWe1GQnl/XPAMN/QGCn9T3I/d36obrCAZb7ixi6b7oAT2Nbf7IHX1soWnwbw0dJhEkrZb+14JUhR/32bKq1h+aIHSbW9aXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8maagDvFZJu90WB3fdFQeSAiTEdFokKANTW8fMvb+DI=;
 b=gueENaC2gVMs8sFdSFWIDMvxAAbywcm0WGuzGdb+41no4qaX4sZC18vBwJrxr5kZG6SL1cUY8aMdZnRumu8Szstqbr6aYjAZbx5E4x+A68OtxuktblP6bmgJH6RcX6nRX9k3qniJf058bsLFR2cv2pRpGK0YTs8rCaUtxQwOtgBjVW1Jwh1tcSFFfx3EA5X4YbJ+61DDj40ii69qeXxPIRuXqIPCJCu8o4FBWTxohPV8difb84fVUB7Gajv11PdhJnukpRLUgfaB1ekyR9Ko85wQGRkJdXQTHIsxukTGpKM4Fmc5a6ymks6EamL37M0xfAW5+tJNZqvo6RN7qyvmgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN2PR12MB3502.namprd12.prod.outlook.com (2603:10b6:208:c9::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Tue, 15 Mar
 2022 14:22:18 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::51a0:4aee:2b4c:ca28]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::51a0:4aee:2b4c:ca28%4]) with mapi id 15.20.5061.029; Tue, 15 Mar 2022
 14:22:18 +0000
Date: Tue, 15 Mar 2022 11:22:16 -0300
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 5/8] iommu: Add PASID support for DMA mapping API users
Message-ID: <20220315142216.GV11336@nvidia.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
 <20220315050713.2000518-6-jacob.jun.pan@linux.intel.com>
 <00286dbb-fe73-3604-4dec-340eb91912c3@arm.com>
Content-Disposition: inline
In-Reply-To: <00286dbb-fe73-3604-4dec-340eb91912c3@arm.com>
X-ClientProxiedBy: MN2PR19CA0030.namprd19.prod.outlook.com
 (2603:10b6:208:178::43) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e93bf918-8cc5-46db-6f05-08da068f35c4
X-MS-TrafficTypeDiagnostic: MN2PR12MB3502:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3502B7A3D236EC748F9967F1C2109@MN2PR12MB3502.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /m4qR8WBajtZa3jZLch2WMfAJeF3l4zlApmdVRAePdVpxqOt74sMezGyOvBwu1aJbF7W6gaE2DRShtddLAwTZY/aFXrMfAod10k6MmQluyTPkbkqX7E7UmfvmIwGu4ekV0VmgyZAM6XDEoTEdGPMPyL84Fln+daQhbplhoIvNBWsIDElttNFyGV2TmFl9qnvJ7RJD8IXtaFqqpRPBWCpqTlgDNZrg10F46lH4f0lZM3aF+H54eSRmTUUGKBiPBApRcLt0uKuGRjNtea99lMdyZD27DWNY+gzt6MYPi0JuF+hKitX9DABcQ23v/AR/7vzvImjJ4xvFux7ztzLEgE516C8LFnR5FvKL7eEk6BByKeMo+wEJ7GyHnOE5cisg+/kobelfHKf6ZU4/AESCCvrMXFDy5pp6zuZiS/xtF3RlF3pZKnApo5CsQDDm/OfEBsXEDtB1OFMGVyxDTG3RqL2hm6dal+sP252UJciznYTFgm9fiaIz1BjFG5znikSK6dLdP2vK+nmJ+2xl1kD74hO0jwJRD9mnYFy8Ou92MnvqYehmcEgHC3xAo/heUQ0P2thjm8l+0h7qMAh7gwU8F2hgPwecFR5PK6up489yxRt7iyT0IiU6UdBx/nHJBnXe9I705mBLbRxes9iCTsKMd/VWisdOP83QSKX12/TvailRwRKZzAAiXKwirjFKl+/1HkjTDAgtBeg9Xewc8vvHiSZlAf1bjn7UmBcKr6cXiVYpQs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(54906003)(508600001)(6486002)(4326008)(86362001)(5660300002)(7416002)(8936002)(66476007)(8676002)(66556008)(316002)(66946007)(38100700002)(6916009)(2616005)(53546011)(6506007)(6512007)(1076003)(26005)(186003)(2906002)(33656002)(36756003)(26730200005)(19860200003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yXLyNLN4BkNccsLk1WOBvN5DKcs7+tup3Z1OVfQHQjODBkI2UQYtgNfbZzvy?=
 =?us-ascii?Q?x1J1bCM2Pt33T2o8iIGIplVn1D1QEBC8c8oIdGup4T3OTKZ2IbHO6Vxs3rZH?=
 =?us-ascii?Q?u/bFlyoOc19FF9ohRb7BqJimBnngSrTivQSRa+/6r39jiOceKo4NjQe5Bcds?=
 =?us-ascii?Q?Ypa1LGqgA+SmLEvl1VvWjnbN9T++RkXptI/aj6/ymKKb4GGzBMBW4cpKbRoF?=
 =?us-ascii?Q?d3+ybqE2wsGQS/KbV1TO+tdbKU0DYuxFcqFQn8MedMaKY1/OKIl9FbgIYofl?=
 =?us-ascii?Q?pvzNXJ2reVo5Y6oYDo2CsKmagpxvt0JzQS1F104a5uVAoXcsCxarJsZ/R7tD?=
 =?us-ascii?Q?j1nLH6UyZ2lSLfPqsHi7C+2kTEwA0fbtWbP38zyXkeQVM/LqTxImpbxT98Zc?=
 =?us-ascii?Q?B99ybq4Fyq9WQ6VevdALsAAnDRH+it6a/NKjNduoNFvF9hGNZDwhymsms6lV?=
 =?us-ascii?Q?lUJ+2MGiKu3KEiGoaiIHZQBdgHW7Ve9ytqwyw07u7Kr4xFd4hhkdwOxc9sR8?=
 =?us-ascii?Q?GqAKzpYOxqVbR+p77YLCJ5tOfwkHj6GvqgEIN5SNktr5GI/CvcHqxcDAKfaJ?=
 =?us-ascii?Q?6EhZsLg1IoU44qWwUlwqtmfc0DdS4xQQ5jqG8N+cmfVXBoI0al/gi1h9KT7J?=
 =?us-ascii?Q?IhUX+NlIGHrIfpdmmlhfGuysJnZkGIEA8BVuVIi2ZTeguLX6QLn0vbxUG9ak?=
 =?us-ascii?Q?9rct1Npw9kQyadvcYfKgNGfq7MLEom1gVxpFKKYwMM+rnHn4pEv99OI9J1Yo?=
 =?us-ascii?Q?gdBGg36eUmgHU31sZxc7c7TKQ6XHcchz7rH2vCSoRDv3bc5toLMkyRRbjXk4?=
 =?us-ascii?Q?0vM1r64QsYKJjqOeCAnwGCtAd6SF3B0zGMx7C5tKY+Um656JMhGoC9yjHYXT?=
 =?us-ascii?Q?88Yyrg5RzYC/alM7cOJaJMrfJr0FaEGXW3oO340d5rs2GHBi1jaVeo6cM/c3?=
 =?us-ascii?Q?fL7VYK9WmHhkjGJms2tSc+djYTCbkwYI0gnoKGSG9W6SkfgklMsoMzVG8YNI?=
 =?us-ascii?Q?e0fbRPmt4kIMShRMYYMs3CeDArQMX61ddpWBsey81/97wvv7Sc3uTCTy7Odx?=
 =?us-ascii?Q?/iIFMd+UhTLqsVCkeyUTOS8SXZyTSe3p/6+Dejml1RjiabuQ7D47zYv9P+wE?=
 =?us-ascii?Q?5/k03tq09EVI70Xx0EPGF6AddM7dm8ywV+T4f0pWYMlPJdofDoDXYsWznzQE?=
 =?us-ascii?Q?wdT5ea+zcn7pd0ICqgkGLUM8Ed3DauQZJJ+Gat2rjmDcpRvZdzHbv/NEzSsY?=
 =?us-ascii?Q?KRM4H7+yMdZsd/1+pn1ddbp9W/g7V+pNI8oaaZd5lv7uXrnkwMMEm0tOR+BR?=
 =?us-ascii?Q?uUBFhM3e+iSaWDng66bnwNYbv/zM83T1FDhN1nxCcvCdw7OpnrHssNDHOz18?=
 =?us-ascii?Q?sYX0/tKZS6MA1AB5KfjADSliEm8RwKPe17kybx2oQYNfvAh4pwTnYLdn/4P5?=
 =?us-ascii?Q?e9SwoYrcBHpNyAyKvl+Mksqe2EQ9iR24?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e93bf918-8cc5-46db-6f05-08da068f35c4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 14:22:18.1314 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j117fYlcMy8kZjfREqyRmM+Fhm1scGhCefkjqQz1VNh6re3rykYDNNnwf7YE30/N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3502
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Raj Ashok <ashok.raj@intel.com>, "Zanussi, Tom" <tom.zanussi@intel.com>,
 "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
 iommu@lists.linux-foundation.org, Tony Luck <tony.luck@intel.com>,
 Jacob Pan <jacob.jun.pan@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
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

On Tue, Mar 15, 2022 at 11:16:41AM +0000, Robin Murphy wrote:
> On 2022-03-15 05:07, Jacob Pan wrote:
> > DMA mapping API is the de facto standard for in-kernel DMA. It operates
> > on a per device/RID basis which is not PASID-aware.
> > 
> > Some modern devices such as Intel Data Streaming Accelerator, PASID is
> > required for certain work submissions. To allow such devices use DMA
> > mapping API, we need the following functionalities:
> > 1. Provide device a way to retrieve a PASID for work submission within
> > the kernel
> > 2. Enable the kernel PASID on the IOMMU for the device
> > 3. Attach the kernel PASID to the device's default DMA domain, let it
> > be IOVA or physical address in case of pass-through.
> > 
> > This patch introduces a driver facing API that enables DMA API
> > PASID usage. Once enabled, device drivers can continue to use DMA APIs as
> > is. There is no difference in dma_handle between without PASID and with
> > PASID.
> 
> Surely the main point of PASIDs is to be able to use more than one
> of them?

IMHO, not for the DMA API.

I can't think of good reasons why a single in-kernel device should
require more than one iommu_domain for use by the DMA API. Even with
the SIOV cases we have been looking at we don't really see a use case
for more than one DMA API iommu_domain on a single physical device.
Do you know of something on the horizon?

From my view the main point of PASIDs is to assign iommu_domains that
are not used by the DMA API.

IMHO it is a device mis-design of IDXD to require all DMA be PASID
tagged. Devices should be able to do DMA on their RID when the PCI
function is controlled by a kernel driver. I see this driver facing
API as addressing a device quirk by aliasing the DMA API of the RID
into a PASID and that is really all it is good for.

In any case I think we are better to wait for an actual user for multi
DMA API iommu_domains to come forward before we try to build an API
for it.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
