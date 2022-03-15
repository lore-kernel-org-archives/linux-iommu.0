Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2372FC433F5
	for <iommu@archiver.kernel.org>; Tue, 15 Mar 2022 14:33:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AE9A140A22;
	Tue, 15 Mar 2022 14:33:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SGfI_x0ytI9k; Tue, 15 Mar 2022 14:33:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0B3FB400C9;
	Tue, 15 Mar 2022 14:33:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D43A0C001A;
	Tue, 15 Mar 2022 14:33:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A309FC000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 14:33:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7BF4B40A11
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 14:33:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jzkVKbqmrlGS for <iommu@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 14:33:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::604])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3683D400C9
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 14:33:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AWBQiCkFXW2U+Itzfe0tL/ixCRSosXKpeQOx0GQeQrPFD/tjsxwYRcfbi5X11Z53GBYbe81kewum6uUtLjkRBX5Wp2q7ZcdlcIOuyjfINW+Srx52Qk6+ScQat7JqefsXV7Of/tuK9vrA1rCrn9chUo0Oko/Aga4nKCCOyTSBlMFIvpoGE5zDpqwU1PkpgvXw0aNOs77WYOsl2lhSGoEaSHnfBTxDXMFtok2PrpH+kzybUHQS3xJ5BgUo44LnyPRreRl62gX5Gvks48FxV/lq4dwTobDIhhy5QUSTijuXsYLCV4THzWIg+IWLwRxjYl6Gup3IZ6b5jSOlG8zWaRDidQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KcG0A+QHKnD/LxSg5aNCpDL0iKYnd8nBYbuGQBWKtGc=;
 b=D8g8+H/iIDcIKNgccAJXaCZIsHiOrG6+q9bkbDrHBv0yVw6/7RkkBEEkyKP/x4CB3A4hcTbvrIHITiMh8vNn5sAqF1heqWFCONcPHzcHsF6+CBY7imB5WkUINRnBdbj6f8L+v2qv1+smVoKiCvXNmrnzVn8NEsUa5PeXbLyY+5POYXJD3ZYsfSSqIAbMYIDz0pZ5R6X5pXVuHMCcDH5HCIlB4d7YFICNznAyWmvFQHyW/45UaobvOSfMuBQiBNfvPK/ywIXjedoj8I+xdH36y2urMcdMLVGKJZKhUw6ISfY4xIDH2epbEzIQcbUizQeIuct9MVRDZArXoBGT+fPAZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KcG0A+QHKnD/LxSg5aNCpDL0iKYnd8nBYbuGQBWKtGc=;
 b=UKSzxbMjjrcNSE9rM2gK1oEbTGASOR8Gm/fTIRUZI0Q8UKmv6tzMqXdd52tuSRu0VGlRe35TzIp+vuoYZiYYbTm4u6Ijt8mEYH0VUQQAnEjP2YEw16xF5HnOHw2uRUO8Wu1n/el9JOOtGGetzoirnF3apSEm/KhYSVyBaCiV88FWH0TAG7XTcKvo62xAKMkiHP/JSHE1nXqZB2zpCSQLazaKXThGsTZKc2GrSWNST5r/nc0YEWcKXaNda73qFKzS+fjIwd0kBXyWxw+wbfgxJM9B1RhfYapG8ISLNkNACOD4c0hpEuKO7ROCTZv8f5e3yqXfreN+co2dcxGhNrccdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN2PR12MB4454.namprd12.prod.outlook.com (2603:10b6:208:26c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.23; Tue, 15 Mar
 2022 14:33:23 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::51a0:4aee:2b4c:ca28]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::51a0:4aee:2b4c:ca28%4]) with mapi id 15.20.5061.029; Tue, 15 Mar 2022
 14:33:23 +0000
Date: Tue, 15 Mar 2022 11:33:22 -0300
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v2 3/8] iommu/vt-d: Implement device_pasid domain attach
 ops
Message-ID: <20220315143322.GW11336@nvidia.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
 <20220315050713.2000518-4-jacob.jun.pan@linux.intel.com>
Content-Disposition: inline
In-Reply-To: <20220315050713.2000518-4-jacob.jun.pan@linux.intel.com>
X-ClientProxiedBy: MN2PR10CA0021.namprd10.prod.outlook.com
 (2603:10b6:208:120::34) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83cc4c89-f263-4df7-be6e-08da0690c292
X-MS-TrafficTypeDiagnostic: MN2PR12MB4454:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB445484A98E194E3A686322BBC2109@MN2PR12MB4454.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tqavi9RZLvBHIy56H1InH9Rmz3Y+H/ZprDiQJAaAQHmgt7IvWkVSpEL6163qOIH92YfXCyhh2mzyiMDL16+SC1Jq677o8Jom0ban5T83RnCHjIdXzU3R6gwnNPE2jL+M/UzmuXvqW2L6oEin+vl1bpLlX4hOpAGBOYAJJNsUpyHd5MOPxDnSjK0+Wo3FQ493MjFSrX/6Md4dqzup+EllchBUHcGoax4hl/+8AWpo8G24oqq4jao+rPOXNBo1enCE/+CegA2KUpIGz+VfZ6parEgdmo0+V0Sg+jIuvv5JEzJmdFuDOUU0SiXN3A2sDYZjzfQTcguedX2HcUn60h3whHoxgfGdHx3NPjltoQQtjL+8YIxeoHAzdewRchHtXGfQB2rfLa+MpZioQcjm+yVBvfWk70jNVu+p2YDEHvnf/QfRnharKTzcYFfLFvlOufAtR5ICJdvJ/bUuEJ8xOAEvDPnaCVFblZF2q0eU1lTTc+N27OKXLEYIviLCAapcchFv87Uk+ge/uZu0x4OwafGu7pbZz/Dj9qLApbcbJvfzHsa+kNVguDYo2C8yiuR2pKEOuOOjq7fIexcNQBQm3y/6ohd79c+1vGoyr2NvJ/WiJhxanyZTUMKfJmTwEu4hytHhL4k7SNaCkmmnlBquOtT5sg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6512007)(6506007)(2616005)(6486002)(33656002)(508600001)(5660300002)(38100700002)(7416002)(2906002)(316002)(86362001)(54906003)(6916009)(8936002)(66476007)(66556008)(8676002)(4326008)(66946007)(83380400001)(36756003)(186003)(1076003)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nXvkfRspKSncSE7MHhnu8obyVchpEYxyIUaVKNZV9FXWEciS7CCrkFMc50IC?=
 =?us-ascii?Q?x8SKuNtbmmugS2z5HI/QE5kHHuZGeJqSNgdi8MVaySZZGre5SHMYI9mzqKeG?=
 =?us-ascii?Q?NFq0C592GDO/7WJQaKT/z+JwwSbdBmgpFzTFw51ud9kOJrs+weIZCcXzxpT3?=
 =?us-ascii?Q?k/nU0SMCCkGcNCNJ8tTY3LupYsGUrMxqhYU7a3dJlZaBDK+wxNbSNjDWaSKA?=
 =?us-ascii?Q?NPsRUnC7nliVpLlnI1PxpyMAhb7DO9wmpdG+6UxTsBZq6RbLIrPK3ZNlf6bs?=
 =?us-ascii?Q?2UkcU6wFqqONHnHM7Dp5wYYutLqthUd6Ub+mDdOAWTgs8U3qfJDY2nfiAGeX?=
 =?us-ascii?Q?C4fqcw8t/zQDNLnCbMSCttVe8ui0CdCdq69ynsXprPza3b8XXPodPxztgPm2?=
 =?us-ascii?Q?v+WmtzjT6pYkSBBjtx5L+qXobfixX2rpQPDrVAet5DRFq+4CQ1Mym/pCzbdr?=
 =?us-ascii?Q?8fZATzSR2gFlwylrd4DlnN1pffObp2sdOPvyEkjNEwyhPOVvnc3nWMCrWYIi?=
 =?us-ascii?Q?9MtBeOqVbWq4d+6vr7fqdtdrXcyHFsWrOC7rw7Tf9vXXpBU+ssR+qnjJRtSA?=
 =?us-ascii?Q?05pLFxv9L1zxG6W5dh+8od51QMISo4iq3mbhFalK9bAbRL7XK+ryGATyUwzS?=
 =?us-ascii?Q?yLuqzIdD1OVFu4zv9sYQ5i6Sio4BuVNzIOWBgCz2MvzmNtlK5YJlhkmQkzPt?=
 =?us-ascii?Q?z/4jCSR2d2aMiLMDy3DN2O72zGX/EwOIaaLFkw1tVyev0E0w0LPI+6UBO0IP?=
 =?us-ascii?Q?LrRORVLus0yAXHzV/yt9KlvyyC3MlNM8jxPPV8JUhLoewL2SDOPkpu5RlQMO?=
 =?us-ascii?Q?gGK3niBq7IbKod9BR7yGvndDMKfTZGvkbYFAR+DQ4g2tRdyCLdfytqM+ikau?=
 =?us-ascii?Q?jPXmnBNNCX82qYYvmr0k/roxKnu7HFm6QSZxp4qHOzjHIzaG1ZUsDA4jGbk2?=
 =?us-ascii?Q?rLmJh2+c/h/D9qSuwyASg30nl3/YS2Qg0L0GwIYIwC5tOo2XR0QGkHDu9LfR?=
 =?us-ascii?Q?IyS/v6B9wm6t3CaFilq/mKMR4Zcx8NFyF7+5hW0WT3e0VQ7QDZM3Af3Ggbju?=
 =?us-ascii?Q?Es41gcR2o0ttd3411qCLRXMCTnJ7OVSy9822rxxWhXsHTVMP3/OYgZ0vQSv5?=
 =?us-ascii?Q?b9QGxAgO+J/pGGcpaE0MCaDQgCRvp+d0/y9knOixLGz94GAJmDqG4AdolJ5T?=
 =?us-ascii?Q?Ss8SYSdxmrX5AoTR6/vhOdZ512VdBEMhKJ4yztcTvMM5yRXcq6bqhXgaj7YW?=
 =?us-ascii?Q?XtPkKknYr0UQe1fljT6WMwE9MdkiCjQk8amJtvuZCz+Xym3PdB0dkVXgcgtw?=
 =?us-ascii?Q?pSgteUQP6PAEE74uIpU8F8pVc3YZqwYWy6+6MmagxT2ui5A34Eh/xhuko0xo?=
 =?us-ascii?Q?TglNBs8AByeyQbPNOSgtcEQmpymGSFGT9XTvDXYFaKXmykarFOurvdYz+uHH?=
 =?us-ascii?Q?VFR0czU6CxO28EFYBagLihhFGyQiMnnO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83cc4c89-f263-4df7-be6e-08da0690c292
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 14:33:23.7362 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6qXjgqjj9oKZxoQG32cBfwp5YkeVYvHjE+J5B0ASrnO3c3VXmA1sfQ6flF37P2aG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4454
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Tony Luck <tony.luck@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>, "Zanussi,
 Tom" <tom.zanussi@intel.com>, "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
 iommu@lists.linux-foundation.org, Jacob Pan <jacob.jun.pan@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
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

On Mon, Mar 14, 2022 at 10:07:07PM -0700, Jacob Pan wrote:
> +	/*
> +	 * Each domain could have multiple devices attached with shared or per
> +	 * device PASIDs. At the domain level, we keep track of unique PASIDs and
> +	 * device user count.
> +	 * E.g. If a domain has two devices attached, device A has PASID 0, 1;
> +	 * device B has PASID 0, 2. Then the domain would have PASID 0, 1, 2.
> +	 */

A 2d array of xarray's seems like a poor data structure for this task.

AFACIT this wants to store a list of (device, pasid) tuples, so a
simple linked list, 1d xarray vector or a red black tree seems more
appropriate..

> +	if (entry) {
> +		pinfo = entry;
> +	} else {
> +		pinfo = kzalloc(sizeof(*pinfo), GFP_ATOMIC);
> +		if (!pinfo)
> +			return -ENOMEM;
> +		pinfo->pasid = pasid;
> +		/* Store the new PASID info in the per domain array */
> +		ret = xa_err(__xa_store(&dmar_domain->pasids, pasid, pinfo,
> +			     GFP_ATOMIC));
> +		if (ret)
> +			goto xa_store_err;
> +	}
> +	/* Store PASID in per device-domain array, this is for tracking devTLB */
> +	ret = xa_err(xa_store(&info->pasids, pasid, pinfo, GFP_ATOMIC));
> +	if (ret)
> +		goto xa_store_err;
> +
> +	atomic_inc(&pinfo->users);
> +	xa_unlock(&dmar_domain->pasids);
> +
> +	return 0;
> +
> +xa_store_err:
> +	xa_unlock(&dmar_domain->pasids);
> +	spin_lock_irqsave(&iommu->lock, flags);
> +	intel_pasid_tear_down_entry(iommu, dev, pasid, false);
> +	spin_unlock_irqrestore(&iommu->lock, flags);
> +
> +	if (!atomic_read(&pinfo->users)) {
> +		__xa_erase(&dmar_domain->pasids, pasid);

This isn't locked right

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
