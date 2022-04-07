Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F6F5C433F5
	for <iommu@archiver.kernel.org>; Thu,  7 Apr 2022 17:43:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 05C9360C06;
	Thu,  7 Apr 2022 17:43:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JE-SbV9KCizW; Thu,  7 Apr 2022 17:43:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E436F61267;
	Thu,  7 Apr 2022 17:43:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A9C66C002C;
	Thu,  7 Apr 2022 17:43:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2C72DC0012
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 17:43:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0AFCF40CDD
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 17:43:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SiCxH2mAcgiH for <iommu@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 17:43:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::629])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B70AC40CCD
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 17:43:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YRP3dzcOU74szc2PF/1ZTXhUwOV7C8IuutKlEobmdvVM6Fx9W82mGXrAIhNBwtw49EXPpHvUPoRJv5/MXocFehnABpqvI8aqCz5772p9rG7Eif+nMb3Zsm+vSDusG7v5WpJJ/K0xnA3A0MRviHK87Y6V8uCTTBS6OeVbHAbfThu1EWs5xhc+wLND8AeOLTHYuiG1+FDrVkj3q8QnwVi6QFuLYiGLQCjRLvN46bg40PCNTY27mOwMcygRpiwt6NGqmQSYPlyo1L3Hzg1kOutTnc+58EWEIQRHbt3Vdaz/U4Mm7j6ke6ivWeiNoY2/fd+w7wFSJzdpuN903dBQypm8BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DtVxwULVyCHUo5BfMuKLNUTK1/UlDa7I/50FOZ0UlX8=;
 b=gZTSBkf0jPO7JHaXqTLhahjiykc63NjD55PgfHUitB/GjcERDi/siWBLtAn4MWlB9a9CdLE8vobKnLRGQS9RKuSN6G7c3+zYFIfNMyrGseK34Z4COXtOnYseyjQaKu4MtNA8I3+IJ+KvQIePchCdCookPdxFARngFdM0i3coYqTXPFOaHXOnldxHNTCF2KFqw2cvWOGu/PsPwGAfKRz0qEmxb1UUc4drxFVTmcUCiuLoP7222hWD/uiVCnfBC/beX/4+dID3o/h23syc2Wo5A76EDsmvDQu51i9e9Nos1zZW7AfrQvW/X3dSk8b/uXqe2UQ1t+ft9q0+P53GFA71Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DtVxwULVyCHUo5BfMuKLNUTK1/UlDa7I/50FOZ0UlX8=;
 b=jxx9nluanUsaVBbXWOjZw8AKARHh+/g57G1v+RqcIuHA8tHMJcF7E3BBfI1kCjzyp4WdgjLnHXzgTYp+TPrNKJbDSUFD9ZRl9LSH4c/LT9AuYjJmFPKF518dZX+Zsz9zi/eJPEpuZmTePuXVOJMgLCKJP1CI9x/gwJeh0tAV816VvWhldoAyor7B/RWUH/L/pnSh5TqZBH1q1U91vFTzUro6+prHRwuRLPlyIj8Dw7kJDV4qt14JwVQUgDmzCrVLQHMWUmPW+/xSaBMZpN8clD4YOxqMmm4hLy3hHZj2vJlAEM/RKP8hbszrVDVv54QN7luGACOzzDzKB3cAR6GPMA==
Received: from PH7PR12MB5806.namprd12.prod.outlook.com (2603:10b6:510:1d2::10)
 by BL0PR12MB2531.namprd12.prod.outlook.com (2603:10b6:207:3f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.21; Thu, 7 Apr
 2022 17:43:31 +0000
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by PH7PR12MB5806.namprd12.prod.outlook.com (2603:10b6:510:1d2::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.21; Thu, 7 Apr
 2022 17:43:30 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374%6]) with mapi id 15.20.5144.022; Thu, 7 Apr 2022
 17:43:29 +0000
Date: Thu, 7 Apr 2022 14:43:26 -0300
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 0/4] Make the iommu driver no-snoop block feature
 consistent
Message-ID: <20220407174326.GR2120790@nvidia.com>
References: <0-v2-f090ae795824+6ad-intel_no_snoop_jgg@nvidia.com>
 <f5acf507-b4ef-b393-159c-05ca04feb43d@arm.com>
Content-Disposition: inline
In-Reply-To: <f5acf507-b4ef-b393-159c-05ca04feb43d@arm.com>
X-ClientProxiedBy: BY3PR05CA0027.namprd05.prod.outlook.com
 (2603:10b6:a03:254::32) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 467065d6-eeaa-4b8c-7159-08da18be2090
X-MS-TrafficTypeDiagnostic: PH7PR12MB5806:EE_|BL0PR12MB2531:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB5806B48B11CE5D159FC76127C2E69@PH7PR12MB5806.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /UXqQqV0Z9D0hoMRbuoeevmBhmdRNQ2/KMzL+ptT0nwpLkh4nMg4E733uvED8YLZNzlhV9ytcBm9qqwrp4hGxIaCnaJr/WFn+bJ69ktSvd0byoo4xqIMA+oB+jgMM0GVwiluFDQFZH3P3C1E954BvqVDm1hr6pIB2ErIN6AAzYt4kn8ncIsmle2frkpWc7rmgbRMK11s0ZDb6RCb3ec4L3G6NMTasUR2lAbNn6YOhySyzSWKixlfmyNQEzXVhwZ88F/5xLBta3WyRtGsxviEv6hbMu7ud7stgtBEiHQ1RrZSaHBEaCapXsZximk6TSS+9IDAgyd2az9cOCJqZx4VOSGfQOJr10zQlgYBDyeDBM80pTZUu4Ni0mDum/9uV+OFszjftGvSg2huJdT1eiRJa4vBcoP3JmROLPkmZLJp1UYptuwtOcv9tM4IMJ1Rwcgu3S24IX4ypFCnfj1p9fHUHEaKXOELWFAnwzvYSfJbus5gBwyb2bLxTHJA8Aayeqj3OtrET/naTnEWaQ4WEwrVxYgmYTrxpHh5CadnI7NyPEpS72rhVT6uD7S9NXspHC7pMtX87zohvsukWjzLgcEhzs/LPR7BoDpci9KfJ7iTgiTlwFOMuQjOr0mL8tnhCVz5hwsD6qAi0kv1PlUNU4ZZIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5806.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(316002)(508600001)(54906003)(6506007)(86362001)(6916009)(6486002)(6666004)(66946007)(8676002)(66476007)(4326008)(66556008)(33656002)(4744005)(2616005)(1076003)(26005)(38100700002)(6512007)(186003)(7416002)(2906002)(36756003)(8936002)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HPANjovf38gIZlR/fW2ywv3moYacLs1zOEaMHhQW7x885tcGXUqqKCkKf/5e?=
 =?us-ascii?Q?ZflqboPOlEsBtNpbOs+2r3BMqkdBXqKCqdRhmXMMHa0ARg4Ii5UtHu/OpuHn?=
 =?us-ascii?Q?c42W/h4LxAvQ4oASOQuqMv8B4gzFPPsQyrtW7+TJImQtfYbEKCQv9Wh5Acn4?=
 =?us-ascii?Q?8L18uQdVi4n7uj7zmv1Bypj18qsllmmdEH7J+WsSo/Esos9rmUBympJzcXjt?=
 =?us-ascii?Q?4Oiw2Q3369foiFBdF61bb7kDGpZtfHEGm/TQ7XKnovocjJa1DMtj3rKxfgV3?=
 =?us-ascii?Q?/BePZpzsRIyU4pn4Y5eOV2djdjUfmwLN/FhSw5NWTlQNx/E9Q2u+0hTzNo6a?=
 =?us-ascii?Q?+Dn3EYAlaBDYC1JzD3hAXHpZCYtkU1phO4Z8U8arY+PMR1CAtvoA82Pu6t/p?=
 =?us-ascii?Q?BQw8TUxmQIwwg6OEIHHyARAHqKDMOCire7M4EdI9BKXYlcVnQYl/eB8kEEYS?=
 =?us-ascii?Q?mC+Zq7kt5wVkdlPcGdyln1WtNylQLUwf+rsL2lvNtziQi5sTF428yPMlAheN?=
 =?us-ascii?Q?n8c9/kibT8Dk0IUcsgU7q8BWiCyUZROKhBLG5OgFsDr1jXnvzTVMNAbNKyVS?=
 =?us-ascii?Q?0cyeMO1sNGnWchc/fn1hmtcAwmx3Pfm0QdGfkRPSmzBvSNoFnAYrE3PrrCyn?=
 =?us-ascii?Q?K4C7VVM+A3FjRoMfjzusetuvi5vqGiVGFdaURD7UptFIIb1u7dfteaqrsoeA?=
 =?us-ascii?Q?gAPT/t15lLTviu5e9kTlD9U/sxbR1DU6oB83ThTCwe5e2pBfXYiu3/GsOPLH?=
 =?us-ascii?Q?CjD4oTTg/OhZD5OkHarX6OUW9c1f+w/JgM9ItHBN+Pq1JcyiPFWoVS362clZ?=
 =?us-ascii?Q?1RSs3h8Lh6p9ybQaehh2RJOqRldxXJZcqoO9kphDmCRgdEmAQq8Y0/nJw5sn?=
 =?us-ascii?Q?sX/AvSEK0cI4ykBogUJ7bRhvj2QONkIy7o0z0yyQsaq5ENWKk51tfScWxWJ9?=
 =?us-ascii?Q?hJ8Pmje0uxLJ0JDSx5AIGijTPg+YBOtUEQz2O2EesJTbEgg3jntlnbtewqe8?=
 =?us-ascii?Q?PsWStpY+CJguknFLnXsz7/I7FP1AN37fuoE+z5TMta3bctW66k9W/yRZr+xR?=
 =?us-ascii?Q?u+R9rf3LZAt9Ap2ffny+IgNdykuGsjWag/tIuCnyX1ANEoZT9GM9nzaQ7ube?=
 =?us-ascii?Q?Q/6kjfOxFQD1/Uk2qgIyaS62X4rFPSE17rO1UC9KcnfXn+AoIZQSBkIlWIBj?=
 =?us-ascii?Q?sxiqenjTIOQD7xSaI5VwGYF1GKhlOysV1/X9X3UPZcLKwDrRdDoTLgzxpVQU?=
 =?us-ascii?Q?kYeZuAZmJopqQ3lUgynt/JraUZbgIeKD0nazt8BVkruB5x3g66FQyAa3gHbp?=
 =?us-ascii?Q?scfwAZrx4auf+EEJTu7DyaHPdoqxt8RayEyI+01MSlmvwseD8iy5h9hWgcz7?=
 =?us-ascii?Q?8NzO/bqrdJujyBXqe4GmjM+6fuzO1pEgIHAXlJDT5i0tGgAyGKYWWs5/9t8W?=
 =?us-ascii?Q?3xdbjhZ9rahBMNcHiOZOd2Ld9af1rRH777HVFYGEpwRkOqVGaqGSraYP5j68?=
 =?us-ascii?Q?X9P1ahGy51drI4IdjErv+3Mvb+1e3wAcoP0OwGZoRvilI+d7edRLF9iwlQVh?=
 =?us-ascii?Q?n4etL0c77jzIemQWbj8koDzABFvVkyVa1816fJ3MlA7G5S8TEl6D2ydOSSa/?=
 =?us-ascii?Q?AV9BvH9lj+lbMTy4FdNCUBWRkfsE26bX2z/GqxLAZoyRec2viIFRrr1Wvyj7?=
 =?us-ascii?Q?OyceJQp/TGjb3mYjgJz68x1GwxdcNLIdAIbt+aKrFTIFAjtL8XP7K9EgkNnw?=
 =?us-ascii?Q?O5wbtqoKZg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 467065d6-eeaa-4b8c-7159-08da18be2090
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2022 17:43:29.7411 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KxDj2FArjPOijWxkaNz4CIV4FKA0aQGcu4h8xcR89RXlcKH3ftaWHG56ej+Q+4Ot
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2531
Cc: "Tian, Kevin" <kevin.tian@intel.com>, kvm@vger.kernel.org,
 Will Deacon <will@kernel.org>, Cornelia Huck <cohuck@redhat.com>,
 iommu@lists.linux-foundation.org, Alex Williamson <alex.williamson@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@lst.de>
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

On Thu, Apr 07, 2022 at 06:03:37PM +0100, Robin Murphy wrote:
> At a glance, this all looks about the right shape to me now, thanks!

Thanks!

> Ideally I'd hope patch #4 could go straight to device_iommu_capable() from
> my Thunderbolt series, but we can figure that out in a couple of weeks once

Yes, this does helps that because now the only iommu_capable call is
in a context where a device is available :)

> Joerg starts queueing 5.19 material. I've got another VFIO patch waiting for
> the DMA ownership series to land anyway, so it's hardly the end of the world
> if I have to come back to follow up on this one too.

Hopefully Joerg will start soon, I also have patches written waiting
for the DMA ownership series.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
