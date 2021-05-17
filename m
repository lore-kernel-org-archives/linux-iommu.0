Return-Path: <SRS0=Mf8z=KM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A23DC433B4
	for <iommu@archiver.kernel.org>; Mon, 17 May 2021 14:38:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ED75613F4
	for <iommu@archiver.kernel.org>; Mon, 17 May 2021 14:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ED75613F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E18E4402F1;
	Mon, 17 May 2021 14:38:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9xS1xtz4Prqm; Mon, 17 May 2021 14:38:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id C9A5B40103;
	Mon, 17 May 2021 14:38:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A3E5FC000D;
	Mon, 17 May 2021 14:38:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0BF87C0001
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 14:38:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DF0BA83CA5
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 14:38:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gGHIjnQGaN-x for <iommu@lists.linux-foundation.org>;
 Mon, 17 May 2021 14:38:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::615])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D1D5882C61
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 14:38:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FgsZM6ajZf2kCxLyCTTyGos0h6Q7kyXW+nCvsVmtuoSEkGy9+LHeI7XsMPTUFE43654skiWpB3NN6OOVmmmKEqZr6nlAVmJ2HvovAZ4Nqpt7a5K037UV+mKPrY/3WDfRLbzYd9Ml59Zyy6KpxwXFckMznXWTcfxwos/no3rb3mY3aTOTzWC9Yn0c8jplp/A+l99iwGDL7zeW9DDb3pEW7/Z0rIKFs9sv/TDFxSwexp31W6LRukovnqonm3NwGWvgYHHrE9hqI9o3KPSo7V3L9LHhsMEdMcscgQwAb1irNyKd3fIo0Ehsx8y/lJ1bmdyqGTA85L7Vz0j8iKgApBjFrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+hSho2A4FWRPTjC18YOjFdguhvw5rov45iMks4ULHU=;
 b=eG5R7eFeY6EIO57SGg2rZyYxludmfzqLX9WvW2MM1pClszL41SUonuGKLj9ryxXwchoU+3ISslTRwdZLCbywy2+VJhlUOugWZLX0yldgW6gu/nZkHvZWv4jNIME39Z+MiQtCMVqWywgGJVEBqPn0Q1ouxjBDPmBNz1KN9n3hCRkO6tNyVtVrW928t5d2Fbmu54/IePs76+2xakvkwBUGGcA6rng9PWGmA/hm3jBUntABBHoj8dn7lV0CNqY42ZgSEcHNup0c0Atom1kqu11rfqsXSM3yQCl3tJZQBm5TfKom6NaQQXRE0rIm0CYiVDuVycRnfTQXFKyiV9hp7NyNKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+hSho2A4FWRPTjC18YOjFdguhvw5rov45iMks4ULHU=;
 b=mIX0b7flboedBlIlDiFQcWUIR8nUN3+kUtKw5OTc3gjDwVZu2TLb+w3jjnrFm2KLeR5cFd53bv4FUuBMIQt2T/Rbr8dG0riDKi8txz0vY6kTOPFszaI/BGxI/qBHO94fmznPJHUN5qC/YOFywjOIn/KAD6MOad5nmdAQNiSTaZMZd+y3M/sUYMFWOT0lvbmHH0ceL0N0dQZkXT+hKtNTycuC/xSDch8XRzAzThV9yHIz+6JSzEnzWe0ukYZv77ssYmWiwvl57Nl9F3OkPD7A7QM9qWcE9j+8aTWqV+5XywxyTprxr9takwM+S8/bab24utHWMW9Aqgc92IQ4apx9DA==
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none; linux.intel.com; dmarc=none action=none header.from=nvidia.com; 
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1755.namprd12.prod.outlook.com (2603:10b6:3:107::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Mon, 17 May
 2021 14:38:00 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 14:38:00 +0000
Date: Mon, 17 May 2021 11:37:58 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v4 1/2] iommu/sva: Tighten SVA bind API with explicit flags
Message-ID: <20210517143758.GP1002214@nvidia.com>
References: <20210513173303.GL1002214@nvidia.com>
 <20210513185349.GA801495@agluck-desk2.amr.corp.intel.com>
 <20210513190040.GR1002214@nvidia.com>
 <e9dd39aa8a144c23beffa5ca58936385@intel.com>
 <20210513192014.GU1002214@nvidia.com>
 <20210513124621.01421173@jacob-builder>
 <20210513195749.GA801830@agluck-desk2.amr.corp.intel.com>
 <20210513132251.0ff89b90@jacob-builder>
 <20210513223122.GV1002214@nvidia.com>
 <20210513164028.6e2d6e59@jacob-builder>
Content-Disposition: inline
In-Reply-To: <20210513164028.6e2d6e59@jacob-builder>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0245.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::10) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by
 BL1PR13CA0245.namprd13.prod.outlook.com (2603:10b6:208:2ba::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend
 Transport; Mon, 17 May 2021 14:37:59 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lieNa-009IOb-Hu; Mon, 17 May 2021 11:37:58 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57f8522c-8c26-4a41-03b2-08d919415e92
X-MS-TrafficTypeDiagnostic: DM5PR12MB1755:
X-Microsoft-Antispam-PRVS: <DM5PR12MB175549C9F3AF051057432E5EC22D9@DM5PR12MB1755.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MVpgvrPSqX2slUQgEL3q2B+hz3cBSUUsl/ApupI/f6A91ClHdc80fYx/yWUm1WxT18pk/LeEErf0GaXfK3KDtwDz4DSxK0HLhyd3bwizsqBv//1X7EWo/A2R/i4a6NmxlZNNFRII3k8EqlotSJ21uzDyoa/AOE15t5CsH22jQqK/NsKSMzWpGSVl+h4UyYoMrU4tW2HB1/6Wv5pZJJeTkiO0PYIvCG/Et58wZ4LUlmRNjxoN/L/7KU2djzBhgu6Od/pdQM4J8LDvEcJnA5axqrWU/m4exdE06nyNZNJBMTuZp/uHyQrMzd9FJwHCosg+JzlNMoW//zOo3kXEhWkKWg9b3UaQ/OK68W2/lA0jzOPV/UlgO8GumeBuMu8qMMXil6fVgCxvI1tzoAKgywOaKCEByFDYsElk+IopLXUmZxXmhpCm745Nnc+phiDl9WoVLKqR00qJIbLML6JVRW7OTJcvFmlPfpmOu+pinGHgMaCH/rSViLn2EATYLqkk8OawxiDcQgr2OMJ5LIqR56niwlUmYXVJROBtSbbtM6fMVHzYTgHP/k2dXA+BBVKYdL9HMFbUUdhw9NmDivuNMlUVEXgVjyaedUjR4b7ir8C7clY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3834.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(376002)(136003)(366004)(66946007)(66476007)(7416002)(316002)(66556008)(36756003)(38100700002)(2906002)(8676002)(54906003)(9746002)(478600001)(86362001)(1076003)(8936002)(186003)(2616005)(6916009)(33656002)(26005)(4326008)(9786002)(426003)(83380400001)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?FKgl4NVbPtDeXs+EBHpb/zE3fLgSU8UI01/VahCWyW+y2SqrFw6Ahl/NBZbB?=
 =?us-ascii?Q?DIjYgJtcWySI5pj4wd+vbfNe6wObHT5Y0HiyIgpg/NAuKnkXqsXQ8p0YUliU?=
 =?us-ascii?Q?NI2dwhQUVDZ9FICOIUITHzi8wcs/QBa/1QlalFt9laRPdkS/PfOHk5oDojAc?=
 =?us-ascii?Q?wDhGbxhsMS3VFq+mmlewvX1iAXDPohipIS3aBZ0cCAHCLZZ21pHjqvfpqtpA?=
 =?us-ascii?Q?uSqOpgp7FfZiTWOf5EHEi8lC/BaLgRAranf4x/m/pYG56Kz6muvGgB38D/NH?=
 =?us-ascii?Q?IsZ9LtsUWfavfZCUerCXHKQQC1OfImLb0WSwnUq2BIs3J4umYFNxWjJthqGB?=
 =?us-ascii?Q?aURus6PpnWbG6Ab7g2INY3MnYwDL6287sx/glB8stypjNHn6tX00guBvSXif?=
 =?us-ascii?Q?YMfyYT4yfetpnySNnxjLoEt8vXuilffSAe8H1YSC/Zt8rbIfcrFdHWujwNTK?=
 =?us-ascii?Q?Kqd0Qc0KEckSrUy/6m+vuYRqoNT4qomLxZnLcOxvea7z87o3pJiN5hVHWN0R?=
 =?us-ascii?Q?lcURdLRAygk1CDZfsgfiM/rSQjjrGx0yMRyzdSOnU6uUp5d2dOVRvuqjSlIL?=
 =?us-ascii?Q?5Z32U+/lsUCxtnMbCHnX3273M7o1QgXpxKUyvvLwGsJqf+gJU7/SxbLoM9yI?=
 =?us-ascii?Q?ahZLzGP5b72LK0LbLaPo2/zppUB4TB6Oead1ukQsMyjYViDrmhnNSKx61dbx?=
 =?us-ascii?Q?KcwViSDooLRCu5WH+3Dso3abNKT9xQiDbopjRNO7RcJ10DbuoI9qZd4RHNeS?=
 =?us-ascii?Q?md8bUX8xHMzWKv3t2WwD71ezh2okxHmH4JbyJ5jcZacWWjQqU6vJnM9VYVR6?=
 =?us-ascii?Q?PPpWBauKbNP6nZxh+/F0IrxIo/z2ikOgcGmfuI56zfJPMnyOxwFE+9R0qhL3?=
 =?us-ascii?Q?KkRDrA+N0qwY2Mnj7C6wpAbHwgfSkPGJJEzulM7jv0+h0oBhgs/ZCF5wvj/V?=
 =?us-ascii?Q?GRUpSEXtBf34+eVkBefEtB3ZVmTIPmQdhCAHPHauoWLLjtprlImbeUxssuqM?=
 =?us-ascii?Q?Ct647KhqJKSinctSjw9mlD3Hk5cNEjY1iKRAqL/bYTY1A22aUAmuNTaZN3Jm?=
 =?us-ascii?Q?DXWD2UWQYbH7ZRzV3lmpx/I3Gdk3rlRRdjmWsUEof8MV8ZyWftRXls+0Z8ix?=
 =?us-ascii?Q?RSB2o+dtzsbAtzPSRtEsp5GwRDWf7QOqT4N+T0msvU+hgo0x/qYl3nBfhRag?=
 =?us-ascii?Q?w/3kMTL8MBaXTSqOunHPgWNEIco+/keJjBnxtvZ8RdR8Aie9qAmC//CdiWuG?=
 =?us-ascii?Q?dHPkZYp3lsimYZu4gQ9H0aoTQnIiyqOxTCmxhFz4l7+sGg7YXS/rHK7t3JFC?=
 =?us-ascii?Q?dcKNZxMDa0ZNCvhAPGTjuu7s?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57f8522c-8c26-4a41-03b2-08d919415e92
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 14:38:00.2150 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +fiXq8Lyld0gjL/0pTg3LokvSmpr3e17X/LGu+nrI+y5PRR1drlO4yHqx0k4W/+P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1755
Cc: "vkoul@kernel.org" <vkoul@kernel.org>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Luck, Tony" <tony.luck@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, David Woodhouse <dwmw2@infradead.org>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, May 13, 2021 at 04:40:28PM -0700, Jacob Pan wrote:

> Looks like we are converging. Let me summarize the takeaways:
> 1. Remove IOMMU_SVA_BIND_SUPERVISOR flag from this patch, in fact there
> will be no flags at all for iommu_sva_bind_device()
> 2. Remove all supervisor SVA related vt-d, idxd code.
> 3. Create API iommu_setup_system_pasid_direct_map(option_flag)
> 	if (option_flag == 1)
> 		iommu_domain_alloc(IOMMU_DOMAIN_DMA);
> 	if (option_flag == 2)
> 		iommu_domain_alloc(IOMMU_DOMAIN_DIRECT); //new domain type?
> 		setup IOMMU page tables mirroring the direct map
> 4. Create API iommu_enable_dev_direct_map(struct dev, &pasid, &option)
> 	- Drivers call this API to get the system PASID and which option is
> 	available on the system PASID
> 	- mark device as PASID only, perhaps a new flag in struct
> 	device->dev_iommu->pasid_only = 1
> 5. DMA API IOMMU vendor ops will take action based on the pasid_only flag to
> decide if the mapping is for system PASID page tables.
> 
> Does it make sense?

I think you will run into trouble with that approach when you get to
patches..

For 'option 1' what you want is an API that is 'give me a PASID that
is equivalent to the RID'.

Then all the DMA API operations map IO page tables to both RID and
PASID access. For the direct mode the PASID and RID will both point at
the shared all physical memory IO page table.

Otherwise the DMA API won't care if the device is using RID or PASID,
if it needs to map a range it does it to the shared IO page table and
flushes both the RID and PASID based caches.

Then the driver will use the normal DMA API with its normal struct
pci_device and simply tell the HW to do DMA TLP's with the returned
PASID.

For 'option 2' it should be a completely different API family.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
