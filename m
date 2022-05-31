Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EC1CC433F5
	for <iommu@archiver.kernel.org>; Tue, 31 May 2022 16:03:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C272B41948;
	Tue, 31 May 2022 16:03:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iqk7nNECJO68; Tue, 31 May 2022 16:03:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6353441949;
	Tue, 31 May 2022 16:03:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 444EDC0032;
	Tue, 31 May 2022 16:03:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E3821C002D
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 16:03:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D12DF40604
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 16:03:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q5Sl1pf_-zsI for <iommu@lists.linux-foundation.org>;
 Tue, 31 May 2022 16:03:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::628])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1F95E40104
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 16:03:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=REgk9oWcmX0g6Tee/FbP9B+pBJV41Nk60bw+yTR2dx+OeeNiUjl2VOfFZiPzzToSS5gjSYIlgjG9gLSmkFfyP5E6B5q4bib9WHmbUucOQ8hY12gfw5SodaH0PEz0rBrV2oT3F9Co7rnhFvP7/v/mrRG0/v8Ex71Oggd9tyAfxz9Ytz9gzvVZyot0SR+JGAh8XTuMezcDcqvt/ER4aR/EHbnLTfkrVxeLn5ovRHB0rBurVmDOwP1oSzZWN7g0B8od06GKwV0GpdhQEzHrMXxWAOJPXikDEkwjAzddFh8P7GqgpizI1hBlgPPKAkmZ1RdwGZamqyfOSR2TTg7ju+QaGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hCcRjUPpmiNd7zDB3/L9bk8oboZifp99E1HGeLEDv/c=;
 b=Pgh1rPbmeUkrFONhxx4nhKAyDwDFbctX5ZPIUONLKHWP4aDSoAzMzsWv6Ar3haOGExb5VwTsj+Xg8Tn6IHeAqkTh6WszxntDTHMXCZkuKhqkPsxhhWjhM+ngEGscxRcGKw4khI9ITrFLc+fW6ReAxwyS9xL4X40PIb4EaOhtmUGBa3oCt7EYh6xuETFHd/zbUC0JftSdddUk8G5BWOK/usMWB/ooUVrnnzK0jYBifsQ2ivfnfTnZOLsHUz2W5UHX4hKXm7cRnFtGs13SYFCZAqilZchaNt47KkJoX3XYlsZRQagMWWOFjRFjcx6GfMx/MqT1lEogHlqwSQxLovgngQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hCcRjUPpmiNd7zDB3/L9bk8oboZifp99E1HGeLEDv/c=;
 b=mtPdqiBQU9wo/SRqO2GsZmftujJANtKUTdaWuXtRLu6qgMILaPdT2vN1fzubhU+SPzqgTzeqvI5Br03SMpploXBKBhHuMpTalL6vG/wQDpMcGNpWgBhktQ1+OZ0jqI8O/MGJPbYglISa3O6dpw+kXaFxOzClQUCdrb1qfCM4r8g5jtRV/TUTjZLJps8OC3zEszQfiIwmXw/gtk8EwUrxLfpp3yVlpWarLN4MeH0QyslFT896qlhGcSJpsRvlgyvcLVwIuy6g8NgrKtT7B2v2D/CdngoFEu+E9kP56SA4gWisKEyVf57pQdmC/L8luNO3SuOyKF9lPYe8IEN08b17Cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MWHPR1201MB0224.namprd12.prod.outlook.com (2603:10b6:301:55::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Tue, 31 May
 2022 16:03:10 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5%9]) with mapi id 15.20.5314.012; Tue, 31 May 2022
 16:03:10 +0000
Date: Tue, 31 May 2022 13:03:09 -0300
To: Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v4 1/6] iommu: Add a per domain PASID for DMA API
Message-ID: <20220531160309.GG1343366@nvidia.com>
References: <20220518182120.1136715-1-jacob.jun.pan@linux.intel.com>
 <20220518182120.1136715-2-jacob.jun.pan@linux.intel.com>
 <20220524135034.GU1343366@nvidia.com>
 <20220524081727.19c2dd6d@jacob-builder>
 <20220530122247.GY1343366@nvidia.com>
 <BN9PR11MB52768105FC4FB959298F8A188CDC9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <628aa885-dd12-8bcd-bfc6-446345bf69ed@linux.intel.com>
Content-Disposition: inline
In-Reply-To: <628aa885-dd12-8bcd-bfc6-446345bf69ed@linux.intel.com>
X-ClientProxiedBy: BL0PR0102CA0063.prod.exchangelabs.com
 (2603:10b6:208:25::40) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a172d63d-d443-4dff-a978-08da431f0f40
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0224:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0224725C3C189EA1F4266B42C2DC9@MWHPR1201MB0224.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jqrCzchKhPB5+WtlhbkbZ6MsQOq4zfDzhyQtRTO+cT72fgVIYWBSNNDjUI6uy7LIlPTas+kwMmcLrt1VO2hERTNSS/FyROPNXTM4PWwapOOhLMTvR9izOAwiy0+97bFO39U5PyPabn3M73Bi1toIiCUlsYMm6zvW9YuK2w7OCgsCcWeYadNGBAiGPZUAMCDcfNRe9VqOJY7VOarvCY0R16EcpcpONYE6fwvQPjEKoYSkZvaRZNTRCIKvoH4RQWPXZMRUpIwqsgUlOJKuwtoxReTZJufwwwojWXu+XDSoU43dQgkpfcs/WXJp5OZcA11SS4jjzgGOR/a/GeKy0YaRqIIXPAt+Nw05AkC6vptStJGSoTXiEr0EHxb2s9ER73CZskwoLMYgzbnaPo2aDA0YlqDMa6USeVqahyFb+GL908bwejkYq5Ne5/Pjjne+bRvW/QUPiJ+Q5OAciWXBUyttKDnXSamPbBh60dYNKjsY7BCO8v8La2DmT/9lK2EIvjB4cqpg9PvHtYy4As6jtky3aBngbTFHdDPcnh1RNl3JaUA/SsjVw3X60N1PBMYLx+BecCeRgVQ1n72MlzdzCf28XolRBEhN5wnrkr5bF8ZPVKHce5KiYtnNqqY/hMEcMZ/pSnA+Nwm0Fv4BaRhdM2LRRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66476007)(66556008)(2616005)(5660300002)(2906002)(86362001)(8676002)(4326008)(66946007)(186003)(36756003)(7416002)(6506007)(4744005)(6512007)(1076003)(26005)(33656002)(508600001)(8936002)(6486002)(316002)(38100700002)(6916009)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GtDn0KACArBfgAIUl7lKFQ5C+ajjc5ul/s+/Kjn2EVKxYJnRq+SFhmog5uIG?=
 =?us-ascii?Q?vMMiaks2mHRk4bzlJe50eIclrUfM+V2fgRnq+/icMExw6OEtwhbbBrEdKWnm?=
 =?us-ascii?Q?xNdz+CapEzg4c9gffEQA2neXn/2+HOsuWZRd5dtHK8UxXY2zH74On27tqvX8?=
 =?us-ascii?Q?O9Z0+9j0JbdHTcHLhisUNWVVS66ndWqMyxzMv2n1GfZ+1p26KDCDvICE+95d?=
 =?us-ascii?Q?Le3zeEBozaieP9FXEH90V4VJKY69uoHkUcD9hooLrB/IlyyVSX6Ufp/nEKvV?=
 =?us-ascii?Q?/VM0RLKXJbCEkZUQqrvPflE1MLkl6L1b5Vln1sK2FytMRBJxuUiX7xx2UYvl?=
 =?us-ascii?Q?5T767jAXAR32lTCHGSl7pFP4EHOb8E0K1b685LBlDYCUM9eUnWkbLGrhEFAp?=
 =?us-ascii?Q?rv34+1e7bSdxbvj+LYpcQW4+wQQu7Iy064GixJfQO+BdNL5iSxJdkmGVRv7Z?=
 =?us-ascii?Q?sxAyQ1WTjMeY0GjcMwo54AgfTUue1k6I423wza79GKJZtkcIPLFGELUYBV+Y?=
 =?us-ascii?Q?Zz2k44NY5Cl2kYY5lBMS7wdlSt/zB4oUsL16EsdDPR8T8DALONZOEc/wmveC?=
 =?us-ascii?Q?WgDFTp92jNPPGnc/IeAsiZQgCtX62SFpjyxbfKNMbZ4TsE9uxuUaKmQTXCeN?=
 =?us-ascii?Q?7XTqPj8bvMnTtMWgRhXgs9L/zaXzpLqrHm091dl4Y5xIJsYXGnoGKUkppZ2W?=
 =?us-ascii?Q?UrwIBSSlF2i2xyqbBpivufdu6Rs6fq4+1/BfCAwNuevolD1CoRoZanz6+125?=
 =?us-ascii?Q?sKpAQjlMn0jT2Z+paN8Sp92zqQabBDBdbmBiIVvahxe9wuWEpAKEu9YMtk0A?=
 =?us-ascii?Q?XAm4JISZJ70EqgHTP/i2hxrifQ98gkqvicGNys+SuU2uj0+EjwWK7pTsMqgu?=
 =?us-ascii?Q?F8bW9WHU1l6NxH9pHImr7f1K4Hn5r90G5ACCzk4J7UJoFiWgA6HaaiUnzPCf?=
 =?us-ascii?Q?wU3XtBFPJTYqz1IV1C6TPJl+2RR/Ri47hLySkAJfQqsOWnxXDJncwlSZoUip?=
 =?us-ascii?Q?vLrbQPbs4gdHD7//RYAWIAU+CCxTo0d6IoJJwkF6294kWrqlTR+8Ik5ogeZX?=
 =?us-ascii?Q?Lvi2WqBHw2CdV/stGoxSu2yhLBtPALnuM60J5VfKXE/TM5ePJx7y+4kvXbsR?=
 =?us-ascii?Q?FgZ7e+LLqoOvhKf0L+JVs69k34MmFeLZBQiLeVo1uLe1Ku5EkBb9CQdatBw1?=
 =?us-ascii?Q?uDDmK/tYnZrM0U+IpdIzDSK5gvdPxiz1CbN0vQoqHCbF4zklTUcqiU0AdAsl?=
 =?us-ascii?Q?jpv+fO8UkKaPeCrG3hiTNish7pRdMdUcO3YfR1iAFJY07wyvQ6W1qF2U+F4t?=
 =?us-ascii?Q?GcwiFv1kWI9o2m0GZqwqAR5sPwii30K+YfMSHPpP2lgRCOUHSIxHZbIPbxs2?=
 =?us-ascii?Q?OF6oNIszyf1jKr5tq6UBUoeDlWwTI9lRvDbZTuqiFDQJGP3iUSLEUSrBCqBJ?=
 =?us-ascii?Q?P/UKpUI+RiLIWmrGJgOM3FNyJMyw0Jt5rMIcS4AnamIGc7moKTm8981OAaSy?=
 =?us-ascii?Q?AdFOQ5WMFaTnzUFeMIiPoDB3rC2ab54UPCjRNlJKHhlzzfzVhs0UekM3c+7F?=
 =?us-ascii?Q?omtTn6STEgTCbMUKr2S3FJ0gq/nwLFQj4Ci4DP1++YPSiG5r3a+hfqcalupz?=
 =?us-ascii?Q?ZZvccyL7SdUHaXkFuLCyXpY5qyEEtmDGP5MT3VFVCeAr4GkY1R0rAambBvFN?=
 =?us-ascii?Q?Ud9cJNxxS/y21XScBOw6eWqUIk1DTppU85BefBfAvVhh1zVFonVw9U7Azuht?=
 =?us-ascii?Q?iTqZGNOzXw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a172d63d-d443-4dff-a978-08da431f0f40
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 16:03:10.6539 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HgtEsa9b+PzaDnCiS7B3kazOgnYcGk3rcckVRFnYYIj+RSlSCUMIq52LMZz2Bl14
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0224
Cc: "vkoul@kernel.org" <vkoul@kernel.org>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Jiang, Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "will@kernel.org" <will@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 David Woodhouse <dwmw2@infradead.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
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

On Tue, May 31, 2022 at 08:45:28PM +0800, Baolu Lu wrote:

> My understanding is that device driver owns its PASID policy.

I'm not sure this is actually useful, the core code should provide the
allocator as I can't think of any device that actually needs a special
allocator.

> If ENQCMD is supported on the device, the PASIDs should be allocated
> through ioasid_alloc(). Otherwise, the whole PASID pool is managed
> by the device driver.

This is OK only if we know in-advance that the device needs a global
PASID. ENQCMD is one reason, maybe there are others down the road.

Better to make this core code policy.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
