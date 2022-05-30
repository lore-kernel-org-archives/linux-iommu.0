Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA52CC433FE
	for <iommu@archiver.kernel.org>; Mon, 30 May 2022 12:22:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7284D41A37;
	Mon, 30 May 2022 12:22:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pyWowgOYDxDd; Mon, 30 May 2022 12:22:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B1F7441A18;
	Mon, 30 May 2022 12:22:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 81EBEC0032;
	Mon, 30 May 2022 12:22:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C4F50C002D
 for <iommu@lists.linux-foundation.org>; Mon, 30 May 2022 12:22:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B23874011A
 for <iommu@lists.linux-foundation.org>; Mon, 30 May 2022 12:22:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CA9Wu1QenrWD for <iommu@lists.linux-foundation.org>;
 Mon, 30 May 2022 12:22:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::617])
 by smtp2.osuosl.org (Postfix) with ESMTPS id ADBE6400A8
 for <iommu@lists.linux-foundation.org>; Mon, 30 May 2022 12:22:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CaQrbp0EdDDTKXGtvEPvy1IcRtxKgOQll2kiT0KBD17KjmCePbyXthuUBfImKF70HU5KBrdRP2QBtUx3YeqO/tsExfW4bvKEFC8JhvPzloElfaj3w7d/IK3LCVW1/116juyzA7WC5LDArx45CJBvTqjTVWqerrGMHqUUWydf4b6f0B9OBDiVYvoYHe0angfkC9Rlc5HHNdH9xFzGogkSvReFgGxaVHkJaDr4ZWi2EX2xxjzq6uxhNV3KwTcUA1rxxJvedziQTCaRaYYeeeP5EJZIQdf/kNwjJnaLjv8z3KaS+d7wwkNZSxvWxVqSHyM28ksKsVAykziAoi2Sxmrc2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Od/PypjkWbYH7Nl+PwR6UpGUx48414rIxRVvISNsXGI=;
 b=fZRRhsK0k3fDcj22LJx2Q50ZkPIzllFB2ucPU5Aensa1+nebfvsPSLB7s8/UgIkdHDh1A5zFDSFEmXvqES7axjA+sQcQMl7Mq4BZKiCeK/e7bqIiHxyzgZnqclQmbfrEFErBWMC3g+wFw2yc2216mwMJ0vWJy6xiwZWBAqGj8ewvC1yA/CCNiA756c5Ct3HQpHFX266ada4gdv9d9GitlJEPeaetXlxakDpsP112cDrH/rde+svwrUT9hUOcML/VPZzIROMQsFH68zGzhgS1PYRm2SkGZffMN5aPR24VlcYPrKYEODpShnSmnQZs0RVK8DoKKMUDlVqK0MlW9dWVjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Od/PypjkWbYH7Nl+PwR6UpGUx48414rIxRVvISNsXGI=;
 b=VPxVra4lw/LOLFQ/r6BxsI5YdeAmYuBTbQ6oAokD8iGghIx2ZuCfpqdsxZyF8FINZKOazFeQOrnzYKOET8qxSYdvCYCdWnd3gPMMtCZipXGvOvnCngqgQ37fnQG8FYuwNoDfnOqz0d3ui15Aw5/KkPpv4FP0iR1t6YuIOzhUifjba5kzxLBNq/ORYprEA1VYzTCYRO4VDbFJECKLQrAuM2di+UCz5mYp+xyBzKMvseHJMaEz87Pe/dcsPGGySVn6SKBlYexqCQ/rlQ6UU7j0UkV1ukkMB5ldT3y/KtPlJSSCfzSvbwa1dGYvPbHN/NUxQGPZwVqO2w8+YMVQGXo50Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by SJ0PR12MB5405.namprd12.prod.outlook.com (2603:10b6:a03:3af::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Mon, 30 May
 2022 12:22:49 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5%7]) with mapi id 15.20.5293.019; Mon, 30 May 2022
 12:22:48 +0000
Date: Mon, 30 May 2022 09:22:47 -0300
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v4 1/6] iommu: Add a per domain PASID for DMA API
Message-ID: <20220530122247.GY1343366@nvidia.com>
References: <20220518182120.1136715-1-jacob.jun.pan@linux.intel.com>
 <20220518182120.1136715-2-jacob.jun.pan@linux.intel.com>
 <20220524135034.GU1343366@nvidia.com>
 <20220524081727.19c2dd6d@jacob-builder>
Content-Disposition: inline
In-Reply-To: <20220524081727.19c2dd6d@jacob-builder>
X-ClientProxiedBy: BL1PR13CA0155.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::10) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7bcecfb7-51e0-4259-a781-08da42371c04
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5405:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR12MB5405A9069449EB28EB4C6C6AC2DD9@SJ0PR12MB5405.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PWp/yTmXGm5IK4WJqt3pwY0/rutFh9WkIxoQZvFR4ToB4wJCoSJ0KGqs+SSJTKX+Uo98NpkUuer298Ykj9FIb7DumU67UC3YXOiP7UJ3BnShGMELDgJXyGrAMNm5VHvc2qtGHUtEyqzBfr/HmCsNsBgJ5XCXhfAxBsewA9kZchtbAV4446K0a+iY0DGpSNnrN3n+NXkPg5HGEa/GqokhIxEGmBuXK4NUfRyFgBWwuo+urAw4O0gHoXoXaeKORdcNh9jUwO53b4EV/kkUkmVgBFiZUg2ZFrRx/q7i4c9WEIkMGIT4eligvHrJEmmBYPQcAAGn6P67EcSnEAGDWRKIe9Lm955jqMuT+MBj4jq2QrWzJx9Z5zwOGJwdXt0vNc4HlcHepQ2qYs84/PHIkRJ5mgV/0EigoXuZq09EChghYBSQK/+xm3thzyDLr/WZHgaZZKooNfdLK5AZiDNZu3rtZh1GeuHZZM06J/8/SVi87wt/Xm7xdYlVJwLUvf6soMKFtObyNo6s/CQRAh305nIDk/aEcGCTMDDGEIIYIXN7POcd6T+ylol7Xl0QiDfJ0IuVcoH+z+D5y80Ij+WJR5Znwmi1AOjc8s1Fywgx6U9eXFUqCMPGfO5Qva07eEFyemVwnFtrWigSNENiNcR2JPgjUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(508600001)(5660300002)(33656002)(6486002)(7416002)(8936002)(6506007)(86362001)(26005)(6512007)(2906002)(66556008)(66946007)(2616005)(38100700002)(186003)(1076003)(83380400001)(6916009)(36756003)(8676002)(316002)(4326008)(54906003)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EU01j8HHu8b9igd/nNMvMO1GobakerL+yiqauepS2QLwHUaZRHvNeWEt2LZe?=
 =?us-ascii?Q?nDEoHU7CSzEJFHu1B7wx0NOa/lk2tLw1uaGnsgZthvW8Ujj1EWlIgL2p+3jP?=
 =?us-ascii?Q?Nq0W+gU1CJ7mLUUqoYCvtZwd/MI1dOG6cjO3Zh4gizwc3aBWtLAut/N+Fw1n?=
 =?us-ascii?Q?W0IuQ2hDkRXRtqM5M4QU7gXczBJ87Fm7jfwW3d6xYJg07/4brL7d1i7fWaAu?=
 =?us-ascii?Q?b3nMCy80NiUgHrae8r4FSTuB4ZTPX4VIixvtA8QQ6EfbEv1xuXMXZYNslrho?=
 =?us-ascii?Q?tvJwNSg0is0pKpteJMlhD6EClVJq9sbz/AIaNd+HebJ5Wy8gjk9v+3s6mH+z?=
 =?us-ascii?Q?eU26tFSChIVY+voKdwD9eZvEI2OqdUt1dIUXpgPWNIzDOnB48E5x4UxgVB/s?=
 =?us-ascii?Q?Zm2WT7Jiav4X4gawtGMFNYZM35PRVSc27h9+WS5XWP7DZPbSrwQ8KWFzv9ow?=
 =?us-ascii?Q?Xijvgc8Z/AvTYDDhNt9R8L6j6Hk1HstV+QxRGQb94ukQsTS3uX0ExFSeDyaF?=
 =?us-ascii?Q?dod/9ZBcuowzimlwg6fb5WkM1NNnsBV/wM5W8zQE1zpN8GM6G3x8QNHwh9Qg?=
 =?us-ascii?Q?LIS4cEw5ca18wlfd26r+FmrUTRj2lIgm3BGam03dpwOmrlTldpOTQQg73Pzg?=
 =?us-ascii?Q?4OGWhixDZWx37yLOZQW7E1rDJHV57shcoITpi+o8eC+EfIIYHwGdYqGPCty4?=
 =?us-ascii?Q?z2/i47aKf1J+WQariix7YYtZ+1RAy71jf5bFVEbvsZQqkpMiGt1evzXSYtcM?=
 =?us-ascii?Q?I+17QQ/kiVD5Eybnmp7FrK16+lKUZE4126f4zvqyliQNpT/2LW0O4CjAzwvT?=
 =?us-ascii?Q?0Lq7LDw0JJuskhSCBdf8iFv22FqBSHw6kfq9/1VvFiNyturOyWKIlP+Lf+RW?=
 =?us-ascii?Q?9lEwboAc5sRljKAPEGxy8GsUG62LfMfsr5k7LHXw7BIOjVfOlZrIn4KJp+cQ?=
 =?us-ascii?Q?1lVWQNiOC7jnkhC8h+p6on9YaQC013rob7eO/4hL6dHdqYT4Hx53YaWcFaeC?=
 =?us-ascii?Q?gFHwNjvVG20kITao9HeIHRgjbAEOpaOKrt+nhjm+oFqd4SIQLq6TJre+Lsrr?=
 =?us-ascii?Q?rjIBwjqNRR7eMLNlgsRFNtFzxzpDwHJb4ssGx9Cl3+tO2HsWQ++huj78cFP8?=
 =?us-ascii?Q?zDkkn6YUONkzm+QS7bKne3LHgYrz9TOAG4vSUftvR7XDKnoQ65+14TzB+s5M?=
 =?us-ascii?Q?SbU3Cs1hxsWxHe5aYM/e+i3GgtaOY9guzBF3oRxjeG/wvf7OkNpWSRtbBWWT?=
 =?us-ascii?Q?PGKXBjAQRn442XBWYrCVcyYkzGZqmC1Y3bK/nwXMCFEeUdAydm67KkgvoQcM?=
 =?us-ascii?Q?RqB5clSR1677xTmZwtrsxG+m7EukDg7pGHoQWjKbkUkL+RYhjc+zTo6JgU7q?=
 =?us-ascii?Q?W98oCsIAvDxFSPAlt0cQUGqWRLt9UEvKuIE1OOT6GpRU0Dwwele3JjelNGHk?=
 =?us-ascii?Q?0aI/7PHw/e4RmIquZ8BuSWlpL57xyXeQb8tlnHVnuclj2NnHY5fKS2izfZUB?=
 =?us-ascii?Q?hnwAtnIKgWZJNBqmLzVgajufPzKCn+osttji+rhZS781s0v6olnD19QOpBso?=
 =?us-ascii?Q?tOVvfYngzpm+0DKEUyumfMMRHQHlQUsmsRoqbA7Ag+ILiTgan05H3eKd1tb9?=
 =?us-ascii?Q?5RudmYJrjGbQW2HFfi7Nc96OWrdN5oUururTDz4Mi44HIzcAKKhD1vEvJQ+3?=
 =?us-ascii?Q?28nbYCnlcfmTm6gH5I7Nk8Y2N6a1DEe+BO6XibZgUByUnFe7OV5h3HnYVJHQ?=
 =?us-ascii?Q?1Mafh+Cfdw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bcecfb7-51e0-4259-a781-08da42371c04
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2022 12:22:48.9078 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N5ub/F18Yl9kaJ0BGERWihExYDKHqCwBqdiCZqeqj2F03R/fW2DswjcP88jl9KSB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5405
Cc: vkoul@kernel.org, "Tian, Kevin" <kevin.tian@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 will@kernel.org, David Woodhouse <dwmw2@infradead.org>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
 iommu@lists.linux-foundation.org, dmaengine@vger.kernel.org,
 robin.murphy@arm.com, Jean-Philippe Brucker <jean-philippe@linaro.com>
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

On Tue, May 24, 2022 at 08:17:27AM -0700, Jacob Pan wrote:
> Hi Jason,
> 
> On Tue, 24 May 2022 10:50:34 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > On Wed, May 18, 2022 at 11:21:15AM -0700, Jacob Pan wrote:
> > > DMA requests tagged with PASID can target individual IOMMU domains.
> > > Introduce a domain-wide PASID for DMA API, it will be used on the same
> > > mapping as legacy DMA without PASID. Let it be IOVA or PA in case of
> > > identity domain.  
> > 
> > Huh? I can't understand what this is trying to say or why this patch
> > makes sense.
> > 
> > We really should not have pasid's like this attached to the domains..
> > 
> This is the same "DMA API global PASID" you reviewed in v3, I just
> singled it out as a standalone patch and renamed it. Here is your previous
> review comment.
> 
> > +++ b/include/linux/iommu.h
> > @@ -105,6 +105,8 @@ struct iommu_domain {
> >  	enum iommu_page_response_code (*iopf_handler)(struct iommu_fault *fault,
> >  						      void *data);
> >  	void *fault_data;
> > +	ioasid_t pasid;		/* Used for DMA requests with PASID */
> > +	atomic_t pasid_users;  
> 
> These are poorly named, this is really the DMA API global PASID and
> shouldn't be used for other things.
> 
> 
> 
> Perhaps I misunderstood, do you mind explaining more?

You still haven't really explained what this is for in this patch,
maybe it just needs a better commit message, or maybe something is
wrong.

I keep saying the DMA API usage is not special, so why do we need to
create a new global pasid and refcount? Realistically this is only
going to be used by IDXD, why can't we just allocate a PASID and
return it to the driver every time a driver asks for DMA API on PASI
mode? Why does the core need to do anything special?

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
