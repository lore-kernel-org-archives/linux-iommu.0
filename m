Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04445C433F5
	for <iommu@archiver.kernel.org>; Wed, 16 Mar 2022 14:07:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 84FE8611BF;
	Wed, 16 Mar 2022 14:07:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EqCb89DrPfTl; Wed, 16 Mar 2022 14:07:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7189E611D2;
	Wed, 16 Mar 2022 14:07:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 52295C0012;
	Wed, 16 Mar 2022 14:07:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C671CC000B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Mar 2022 14:07:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C4449402F8
 for <iommu@lists.linux-foundation.org>; Wed, 16 Mar 2022 14:07:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hEcokbVKq8ff for <iommu@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 14:07:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::603])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 040AF402F3
 for <iommu@lists.linux-foundation.org>; Wed, 16 Mar 2022 14:07:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UB/EddL27En3adrJuVfApInXOPciMx0+oDMElRLE1KoaKmwTC6lYkZLu2oSFq2gXQ35VRq7M9jo6ltvn2zpSIf0+70zZry74cHvM/ecWywVc1E0Tf4sVxqTwtiNKYwDfxaVTX6jn6pClyoInSwcC6mZch3LJWztVgtyVS87mcML/Ytz/l/eY9ooX+MHE39LmIXIs2eSUWm0O4fZmIiYyt6p5CS7PXHVffQ2nJgPofCEv7zn1aJZV9a6OzJIit/4w5MWG3bu8/5nnko8bh81TPPgyjdaVEnR/yLqhaN/x3MTvI4d77LBU1x7WnN06ZfeLmgXLZDzxbmOx+ekYHoHaSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YYb937HCOWyzWfTVYC7AYKPtPhxoMCyIVwcVhSDw6fA=;
 b=Hts04P2IfvJ4WdggcYrV+NJ7Ff4bMq2YkIVUAdjZ+Ws192q0apFgHdb5d4bfj6T+fEbAz+bmGpBtmbvTKcQEpZCiwcft8HEi+qJAqY0qTDJOWqjg+DGYuEMLTYKExDo45Lb8kYF0AnivKC7zJMe11CjDnSttoMAyUuN5WM/H6xNb3Iv2PaN9TQVBRGP0H9NvivXGZn9GjVwwsyHDVFmrrwlYthFY43nyb5IdSeqcGwxXZ7ES4BlzWShSFGwIsj+gL19Jqew80UTPx8T697x7U46Mvb5hDYARVjs8PhLfmHRUY+Z3MhExlvKNL4xwnHI2nRIaCL4pSRKTM6X2h6kdpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YYb937HCOWyzWfTVYC7AYKPtPhxoMCyIVwcVhSDw6fA=;
 b=CRNiRgPVn4Fjb6BmEfheu8ZPDU6rFXJ/rr93oYDF/rK2xyNkTBZ7uq4/Ym5sn571QXNbA15yh6ztBCwfbyHK/Dm9xSCw92ip4jpPivTBkkrbOxErcsF9mCT8in1GbLmw17iI37LFCIt79e8pkLh29rla1hMY0eEC/tb6GpWU2zjQHO47JH1i8neO+Dp86/DQpC0KYjUrwTNnf3P8wYIogkXSH44JU2y0CwxNwJ6zIFohfZMK+1Dctj4AqnatkuhZ2c8K+93iZ9VTV5isK3YvZYLj0KsLM03PRbWdCirbj7UpLLBlhzAn7NL3uZi3jfRJNKlVvSedQc8pfc6u90RZMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CH2PR12MB5545.namprd12.prod.outlook.com (2603:10b6:610:67::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Wed, 16 Mar
 2022 14:07:50 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c%5]) with mapi id 15.20.5081.015; Wed, 16 Mar 2022
 14:07:50 +0000
Date: Wed, 16 Mar 2022 11:07:48 -0300
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH v2 5/8] iommu: Add PASID support for DMA mapping API users
Message-ID: <20220316140748.GF11336@nvidia.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
 <20220315050713.2000518-6-jacob.jun.pan@linux.intel.com>
 <00286dbb-fe73-3604-4dec-340eb91912c3@arm.com>
 <20220315142216.GV11336@nvidia.com>
 <BN9PR11MB527697CA21B1D28BBD0BE0DC8C119@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527697CA21B1D28BBD0BE0DC8C119@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR11CA0005.namprd11.prod.outlook.com
 (2603:10b6:208:23b::10) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ddbfc6a7-8b56-47b4-20eb-08da07565afd
X-MS-TrafficTypeDiagnostic: CH2PR12MB5545:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB55453784ED84462F1B3C3A87C2119@CH2PR12MB5545.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gJpHNKva9LZW7S0MnUBVLzDyuQW4cI4XNz5lX4PFzV1st0pP1oTqXsHpOFZtjpva1L/UpaSisIsrl/K+87rtTz0/MXTLFPOOexVcTL+3e9BC+RCBzMlrT9i5BqwEJPPJB6+FdpY/Il1vqVXg5gKFBs1OgkMhGuNT0H2xmDUMUEP6D7pUnIlXV5EeOhTQNjqx6QC0NM8hAzuH3+6bS+ZTTBKRpIP6XCcBwL309tdPLJ3qPcFZmkluLYhKPh/Q6JvJ+gYW1K/G1lFlv2cwStcqpPlu5yMG0U9v9DFfXI0IfOgRsA1caLKTGlc3HVD7oSSpH4vwWMFDOR0wpjwNXMedxYcXJN11KEWfbyjQ44icsky9Cy28lwfHFvuuMUyGuNVJnjxuJj54olQf+0JaCIyniv1Eeg7Gh6idZ7Y+1ubElla1QgP7MO/JAoBsmDpTpJ8A7Q4hel0ToJIUh6PEx/YYfx8LBuNJAEHZd4gfsiBFGVmxYIEugQeptcAF4QoYl/UzQdDWTH+9bIA1MWDVLGU8434XDiuQNuH2ClWqizdPP5ORvjqBN3au+9wVanXTuTFb8jqz/wWuy39e0ZVs/GupXytzzXczMB7olAxZaTYNEVh5AeHLpTgjz+XVV0zUcv2cHmbkGZT+j0yOfAP8uoYXButgNd9fTMiMW/zLoRs/eqlEwBfn5CfHUGANcKtrfRcE/s0heUEWc340I2ODwpNG68/rxi91U+DiFuRmvr1Bz4c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(4326008)(83380400001)(508600001)(38100700002)(6512007)(7416002)(5660300002)(6506007)(33656002)(6486002)(8936002)(1076003)(2906002)(316002)(2616005)(26005)(186003)(54906003)(6916009)(86362001)(8676002)(66946007)(66556008)(66476007)(36756003)(26730200005)(19860200003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AL6ZPSGl3wf+JOngQq/BAUzI1rdF7eUnGXC4Hb6VRE5Da0Hy0iijpYpUL8X7?=
 =?us-ascii?Q?P1evcG27AQ9WLiLfGtFOzJWMpKZum8xHIVniPONawBfqHqih6pvB98WK3EKu?=
 =?us-ascii?Q?ehfdbsrAeDh4wGXdTpA+xevgLoR+nR9EwstaPCGhbXexbyPL/r7X/odmdckA?=
 =?us-ascii?Q?+UNInSlCMv9bI59iC4+ZImv7Mie3XPfBWGgQKE9bxoggt+EiuVUUfR5VCB5b?=
 =?us-ascii?Q?bF/MrFF+j/uWr+brDXjdWz3Vcku00ATG0+a5ylG2KAPyLU5lea0KPMc59LdC?=
 =?us-ascii?Q?ra96207p81PGQhilpzOfQekLefY2WU2W/rT8Uv6+P5fSbY4H00bVVyfOPoGe?=
 =?us-ascii?Q?pWN+FFhJaNvbH31WtoiaVoMowfJ/4+e2N12VOddk4z93nK4pQ/JQWxxJOLZ1?=
 =?us-ascii?Q?WEdWP6qXfbd4QT++DdQrq05M2vOT5eCYKugkqNBPLS7ks4MCvPLOFCF3e1+k?=
 =?us-ascii?Q?tHcf8VUs+N83klJ8WcJHuoyV/EPIMFX0Pi2N66i6199JnCokXAosRbclekRw?=
 =?us-ascii?Q?X8MmQK/pbTNhXqI2Rst7AB8T3eRnmk3azM00UNN//lymCMMedCIWHGVtuFzr?=
 =?us-ascii?Q?QpHLHcZijAgDPoZJnNp6mlduTgMbbpvWD+7WnVCVDNIwfpaVQihydTQmERz3?=
 =?us-ascii?Q?artvtnPwsnvCywEzcwsee5fT3nKah9hT5EA5rsdKwnKVxO2eqMne8RU228u/?=
 =?us-ascii?Q?+9cH02YxCANpHrQhW05xOs/mAOYdZGS+qt0YFMS/Yl2LNWT4NWQyJlkYCcEZ?=
 =?us-ascii?Q?nQfeVQNnqUfDoKX7HbmaehC3w6yoW92/tgzE28BC0uBekFpKBStzKFhnhmQ7?=
 =?us-ascii?Q?JCqDgqZ9LjfralrBOdnS8xgDyHyrExGrb475UCB1O1Q5pdPsNGS1oX/Z03gc?=
 =?us-ascii?Q?OGKVc86TOxaervYxqyni0Lphn7H1AcXAaigaTpB7ObGbSfDWB8BbAbX/Y+9M?=
 =?us-ascii?Q?2m12+2OQ8IECWIYzsMRDgGOqtt5c7vjKcGDql0Xxf0CpvbbZzDPfvzYI/axi?=
 =?us-ascii?Q?ihl0QHulSLp8NdK4Vbn/a3NVyFO5N8b0Sn+pL+9yeYtEXw5FAglocK1Y4FQJ?=
 =?us-ascii?Q?IQskIVo3RZC0eFOKMiULwAJ2uAyK9dbbxMCTan+JiKnCCiuPcvcDD5Ne4p5I?=
 =?us-ascii?Q?Bp/r6V0snFq/Seb/2GS5RSyiXNdmUsttXvj0WIudSXobGCflOoujik+IymAk?=
 =?us-ascii?Q?f/7vlL1ptkwawwg29lkm1I8IknFnIXfh5bT5KdYOVjbKV/9OkU4FjJyDEGZ7?=
 =?us-ascii?Q?qaP82IktVqg3VmnZpPb986gLQ43BWT5rMgZj5yngbdQApfMfC3GhSw8VpeeB?=
 =?us-ascii?Q?HtLeztDqPa3dUDJdbaHWKKQOIYDn1SUDgpXFD6cuKbyvesrIHBywFsEldycY?=
 =?us-ascii?Q?9XgdaEb0YV2heGu+uIFvdJxSVT5zmVi8SVndWiWCR4FHDnCmlLlM9mxNw+vL?=
 =?us-ascii?Q?eyJUXM89d7RQSpakijQ6yhcNp1B3hjQK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddbfc6a7-8b56-47b4-20eb-08da07565afd
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 14:07:50.3497 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aTbLXn6KAmSGypI2RIwASd4KvMmEG3bnm/BynUceQP+ijFZq9Qhpwlw5wqQE4c6H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5545
Cc: "Jiang, Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>, "Kumar,
 Sanjay K" <sanjay.k.kumar@intel.com>, LKML <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Luck,
 Tony" <tony.luck@intel.com>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
 "Zanussi, Tom" <tom.zanussi@intel.com>, "Williams,
 Dan J" <dan.j.williams@intel.com>, Robin Murphy <robin.murphy@arm.com>
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

On Wed, Mar 16, 2022 at 08:41:27AM +0000, Tian, Kevin wrote:

> 1) When the kernel wants a more scalable way of using IDXD e.g. having
> multiple CPUs simultaneously submitting works in a lockless way to a 
> shared work queue via a new instruction (ENQCMD) which carries
> PASID.

IMHO the misdesign is the CPU can't submit work with ENQCMD from
kernel space that will do DMA on the RID.

> 2) When the host wants to share a workqueue between multiple VMs.
> In that case the virtual IDXD device exposed to each VM will only support
> the shared workqueue mode. Only in this case the DMA API in the
> guest must be attached by a PASID as ENQCMD is the only way to submit
> works.

It is the same issue - if ENQCMD had 'excute on the RID' then the
virtualization layer could translate that to 'execute on this PASID
setup by the hypervisor' and the kernel would not see additional
differences between SIOV and physical devices. IMHO mandatory kernel
PASID support in the guest just to support the kernel doing DMA to a
device is not nice.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
