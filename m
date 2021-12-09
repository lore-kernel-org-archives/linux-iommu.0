Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98A79C433EF
	for <iommu@archiver.kernel.org>; Thu,  9 Dec 2021 23:41:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 474F380CD3;
	Thu,  9 Dec 2021 23:41:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p1NPswLjRG2j; Thu,  9 Dec 2021 23:41:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 37AB580CD0;
	Thu,  9 Dec 2021 23:41:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ED6E0C001E;
	Thu,  9 Dec 2021 23:41:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C4011C0012
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 23:41:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AF67B40184
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 23:41:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BkpL_rmFT7Nx for <iommu@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 23:41:40 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 67F0F4016E
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 23:41:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fz20ONiLuwPM9NPaMt6kGNOf1LdsHA84K8VHDuH1QxelTrMcPOsaUt2Tzha8YOs/VYSFKgrkneQD0HqYi4hDlWrvmKMe3TVfhag7+JMqFvc8v9WlDQlOIr+j0U7f/mIQ8NLtYcd/8FzVdn7nqsNS2p9uqeN8EQyfzGlfzz4fghBHdNZ1ka6BDZFQ+PB1uDePNCbl44Y8fscbrBOjl2luyqmTmKQ4ZFpKMDeNs6qRsb/gjAV/5ebeG0VjmWEJgx29Ig6wA09CcAkV85vYnDKhB/kSg6TezMTzsU9jo/ciQ/nK8Q/i4fCeVm9U5WUWoTNN1Q26di+zpvx7OPtTmXrt+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5XOdSRM3YKnmE9vEUy9if+sy7S1zN8NC1YVOp5HsjKs=;
 b=A02ZoTnfpyVSigctZ1zUmjydjBv8zQOi54KJsBuADcnRdJCIz8YG5zmIQIZqEbM3c/z5WJ535+xGhGS3372BvbZGhuctnhsP/AxoYkjJ594PCWrcfoiEwBABe7xx7l7agM6/G+9ECDLeJQYLvPo5lj62FfUbHsLPontxJe5SCA6Atu+I8B9MggVQVf/oJAfY7VL+7UNCIyjgYyEk+HGcY68Qaqq5RbSBlGodyYrz5jG7lIy4aZdg7/A6waFUD9wuswVkF2JVldXfSHhi7oGa9Fyc+F9xVx/9l6OjPu79m3bzn35S2sx9Pq0AB/J3UwPb5GZiqHT2BtcET+KF9lhnCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5XOdSRM3YKnmE9vEUy9if+sy7S1zN8NC1YVOp5HsjKs=;
 b=A599myIN0rLXuLIegrYcf0KU8WP1vBemUKb50KPoDAVrYHWSETeM1SltDGUFe69l51abILg/c6E9fJBpig7RG+JPhjvZMI/lltE/GLdPRbXxVOe5GMnLAdWatAb4E0X26MpZjtCB/YauYXrcEPpbgb2fyMcA7PdxGG2vUm90A4sbmasnhreYzgC4vbLe9WvUBi+HOqoJcZGUVRlH74CzqSMVTEEpAGVKBIEHGGviMDrAzqqrmCrEX3GHz99wBWGopcopQhDQs7hgS2dvL11XPEjLY1oxBNSWX8i89HsctHhG4NGoJ6VfpQHLDBlbr1jUsmRAUg6RIdWYJfK75f67xg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5301.namprd12.prod.outlook.com (2603:10b6:208:31f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Thu, 9 Dec
 2021 23:41:36 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%7]) with mapi id 15.20.4778.013; Thu, 9 Dec 2021
 23:41:36 +0000
Date: Thu, 9 Dec 2021 19:41:35 -0400
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 3/4] iommu/vt-d: Support PASID DMA for in-kernel usage
Message-ID: <20211209234135.GA6385@nvidia.com>
References: <1638884834-83028-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1638884834-83028-4-git-send-email-jacob.jun.pan@linux.intel.com>
 <20211208132255.GS6385@nvidia.com>
 <20211208111659.6de22e52@jacob-builder>
 <9f724b3a-6028-43d7-b4fc-d8a939e7b2cf@linux.intel.com>
 <20211209152113.64b817b9@jacob-builder>
Content-Disposition: inline
In-Reply-To: <20211209152113.64b817b9@jacob-builder>
X-ClientProxiedBy: MN2PR14CA0005.namprd14.prod.outlook.com
 (2603:10b6:208:23e::10) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79008b6a-fb23-4ed3-32f7-08d9bb6d7075
X-MS-TrafficTypeDiagnostic: BL1PR12MB5301:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB530167635EAE458B8450217CC2709@BL1PR12MB5301.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ufsX4R260hW/Iu+yKXzFo/C2NBdQlMC3MMUjVkk516Bxu1bLfr58SqXFgIRjWtfoei8C/zr+FDK+tFF1SUepEkS56Zw68B6+/XjXycI2BlpQ7HuyzU90dqLLbpGxqTAlnFaCKDjzjePENOjP58xT8mLHNq4D0bk5oh5hFhlD3MV8+u/CnnrWQbH1Ei/5Ss0OAp0YSMA5QSLaicFRLB4qvBQWxJ3T8JnuiM/dR0kQTwgp3/tUoFEIWUAHK/4EMW6Zqj9caUdgr76wCngoeB7hL9s7VKT9sEChcNfVV+TQeXjn++RBxqr0E7RyH9UIXszOARvSEgQu6AwPTvyMQpetMAMT5MhNK97/z9Bzt2Hhu646yWFkZvapSrDKWDUjY0Pl4qLVkMbBbivGTkzU/1XbF03Kmq/hFeLX0MRy0Na9wJWqORW1i7Tz6O/VBR/rAAXIIzVuHtk5P2eKODTkSOySFuAQL245noU5NQ8rHfmuIRk3gEAExzApweJtGnz1alQh8lK/FxkxetA7tnaPVeyzNFmWdEXP7/5yR76W5ZRnGOhXPBTuNROsrIZQ36sN9pBHWgXRDUwYQkq6+ylR5iMd/WPubpXZlCTReqhvdIpX2jRLIf1LB0HekigGzcMIvQz0VXKTEMAhk1NbIirEWJ+ppA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(54906003)(2616005)(5660300002)(6916009)(66556008)(4326008)(36756003)(2906002)(66946007)(316002)(33656002)(8936002)(7416002)(66476007)(6512007)(26005)(6506007)(6486002)(508600001)(8676002)(558084003)(86362001)(38100700002)(1076003)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T6O/jb4CK3N/iIigTC3SqSzA6hEKYOO2YtdHzQ67swU/lBFTc8QsNFCoAPEP?=
 =?us-ascii?Q?NdeeTkJAdrNH3W35A62UfphAIjx09/OuHrwVgTT0B7/ImznHV5KhD0j99Z05?=
 =?us-ascii?Q?3+vA5/ruMnAAZoSzBHzCDPVDrnUjTFI+GMgfrudsGDKXmEjSLvawARATVfIe?=
 =?us-ascii?Q?1MmtVmWjHpXH0R4BkKAvAgtGAODhE4oI9mlweRP9qB80cYYuBrAwIyb1adwy?=
 =?us-ascii?Q?oDQ2NV57XQkqdPrwi5LbcRlDT6zMakZ39yhkroKWWVwfbxwyRzAwC63y0Eun?=
 =?us-ascii?Q?SJtV8UBPtAf5IG8TjkBnTkQArU4pJpoHi0/92zs5El4oSCEsDMYL5ve4PvWW?=
 =?us-ascii?Q?7Ij1D882bXSqcskk5HQMrkS+4vQEnek0fFtfPGmC9pH52fSghfTwNMBVFhJD?=
 =?us-ascii?Q?FUjhR/tdlXG2HSWZDduawc67/ca/fPqjdQm1IrXK8UwK0Ryfvc2jtM2Ef4E8?=
 =?us-ascii?Q?GyFlzX6mbUOIaqhN3+LoO3+JiV1H3wrv4NU3qI5N3QJwmKiwjae6z4Tir4bu?=
 =?us-ascii?Q?7vDg9Ra5+fO/RerAOHlzwF7i5cAktATdPvEbFTdnoSkGLUCGkrbgoMCAGI9O?=
 =?us-ascii?Q?OqXwm9gxMHrUmgugwsJPxrbzVHz3+xUPgpCmH66S7c/J5mjBVQqBpXvCZpwb?=
 =?us-ascii?Q?DqG2vu3odcsrvdnmY/k+85624lSQO7x0FtenKIrSdwgX5iF7aFOpQZilFY2k?=
 =?us-ascii?Q?LWLXM0O/E/Q2a/JtcLv4qrUXeCmdAmhnc2x2tZm4b7NLdeYP+oz0PDr9VvJc?=
 =?us-ascii?Q?FZ/BlqOKgh4FRNIW53foRzeyg+MAEVRm/9eDoO9X8xVPKmPZEqQNie/UKQeK?=
 =?us-ascii?Q?u/V0keAgqUPP4155rZ/17L0yRUa7JItSFxVVWk8JcUP5LoK+/4W6M/fCIwv8?=
 =?us-ascii?Q?nsHlxHwRjkZDuEvQAfFGN7YHH6Vc92SmAjBbkOwrhkET007qvG2EK8kD74+i?=
 =?us-ascii?Q?yxmCrud8+3RJuo/CMtd/f+ov2E9cuD5g8lDqz5NmO+oBmqH5eStLxc15GS+w?=
 =?us-ascii?Q?a+m5bMHzhMxn6zQ5EBrV+WZAEMj1XreT+vCF8BB764bYB08cMn67CwShOFAL?=
 =?us-ascii?Q?FGCO6hTen4GALB6E9BbTDXl2w2l1ERkQQLRzKMckkbwwm3uLVcsh9VWSnnKo?=
 =?us-ascii?Q?mRzSixPjJKS7xnCSrR9bKCcBhedH5a65VxyNWeE+WyzwSI81OQunetFFm6LP?=
 =?us-ascii?Q?xefJMp/Zu3k/DjXvaSrVMrIeiuPetRKkHngXz8ZkQHdXwsqadsR2FmCjwe+p?=
 =?us-ascii?Q?oMJC/BH/9vx9mtSavGdPH7y/vOsuAzeRnHpWGIMGNUGfZ86w7U29vLK/U/y0?=
 =?us-ascii?Q?Ae6KlQxmvHfbpa8d+iRnYmDB2i9xus7g7ERGwB9a/e7GOixS4SliH6xfp9+c?=
 =?us-ascii?Q?U93pnJPj82qR5Yz7uCVBG9lku9M8LAUsvZ9RJ3WtgewwHtBPdLzhWfJyhqD6?=
 =?us-ascii?Q?MYo2Nv5XZwmIFYK+EfJN/tbHz42NG0pxmFzeNE03aQkV6oNPRaDQuui1tZmk?=
 =?us-ascii?Q?tFR0qduYQLsbeTJ3q9EAQRGzhacZifrlFWMIHAlAb0YtALlgb20uXV9sEGzW?=
 =?us-ascii?Q?8Shnh11XsrVC1hhz8Co=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79008b6a-fb23-4ed3-32f7-08d9bb6d7075
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 23:41:36.3756 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pZwWn7milpd/Cl7N5VFv5XTUbLz3+2gP/hL0rQ5SQmHvNaSTur5SDoCXMXQLwEvo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5301
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Tony Luck <tony.luck@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Kumar,
 Sanjay K" <sanjay.k.kumar@intel.com>, LKML <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org,
 Jacob Pan <jacob.jun.pan@intel.com>, Barry Song <21cnbao@gmail.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>, "Zanussi,
 Tom" <tom.zanussi@intel.com>
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

On Thu, Dec 09, 2021 at 03:21:13PM -0800, Jacob Pan wrote:

> For DMA PASID storage, can we store it in the iommu_domain instead of
> iommu_group?

It doesn't make sense to put in the domain, the domain should be only
the page table and not have any relation to how things are matched to
it

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
