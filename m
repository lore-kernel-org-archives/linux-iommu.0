Return-Path: <SRS0=VyMr=O3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDD2C433FE
	for <iommu@archiver.kernel.org>; Thu,  7 Oct 2021 17:48:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86F1E6121F
	for <iommu@archiver.kernel.org>; Thu,  7 Oct 2021 17:48:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 86F1E6121F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 55BF38439F;
	Thu,  7 Oct 2021 17:48:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GBpzZC_ODSju; Thu,  7 Oct 2021 17:48:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 46F2584372;
	Thu,  7 Oct 2021 17:48:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1C5A5C000F;
	Thu,  7 Oct 2021 17:48:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 54D95C000D
 for <iommu@lists.linux-foundation.org>; Thu,  7 Oct 2021 17:48:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3661A4036F
 for <iommu@lists.linux-foundation.org>; Thu,  7 Oct 2021 17:48:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9Jbmfb6_vfB8 for <iommu@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 17:48:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D64754020A
 for <iommu@lists.linux-foundation.org>; Thu,  7 Oct 2021 17:48:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fxoMRKgyMv1pJf+ty0Ebmn/yJ0YAcWd8AQXgOYPkEkOugG/uVPGDKq9Z2zVKc0F7v6o//MmaVb6wkTjK1uolrycVje1b8eZ83oIR4QQ1m2oNRIsjmHplcOmtUOu/7INOQPOMmjijAyk8fofTBu10+p654vqbGjGTFz+6MyF8jOeecgssc4kaQXqC0YHC+5G+BV+3GOFniasY/6bKBTLLQaQcWPIv5AxBEA5LEApOlcr6FQieuQnfLMGPsSzezLa2SVJDucFfrPKEZ5MdHnNl9RZk00oVN2O18SWXT4Kh92/tRW/fe9lJHc7DXf68ZLvvBTPbtTVHmgt0XE9O4Iwhww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rofns8odPiWSMocyGmbWA8hSIahAd4kXc72Naa2saVw=;
 b=Gew1Sn7As8Fe6xwMawLtqIgCe6FMmezlJiSxyX+AWg45m1KJmtkeDxDoYyHHoZ5WmkdLF550dRl2OaTNULFjYd2KglrGxvA0KJS8B8fTPWYHjh/qcsPaOpkmeqQGvri+fHetxTLJwnd6mZnTnSV+uykhgZZ5T/tHNhfQI92REF7PgZ9DsSnc2MwjWAEmjpIRKjL7SPhxMXDyQkk6WKJ13FmegHPzd6kh9evt3oAU4UF9uxeHBRdaKK6gCAtguQhn/qTFLCub1Dv4TkhSkeuuz3IjGx4pTmlI9xfZ1XfEJir6Dr9lv6CLJ1uVUx6yUW7Qv0cNn4mn9zTXyouVJKrtng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rofns8odPiWSMocyGmbWA8hSIahAd4kXc72Naa2saVw=;
 b=EFrDxI52GDsQ+RUsrthzV0h+kjmZC1reI59StpAKjrzpmiWRJwvb26lVKJ4NBqp5qhb5wjaNvS4vg3YeSKqLs1yxbMYwaf/qg+EAojHXUL71SGffTqrcIxEHgiHu7IuEiOs5zKo/Cjfxqj4Kf3OQWoaIqJIc5JGLDL6UheiN00eW01MVyyhTF3voxmjPn7wSKNICyNnXjYVA2FFWyNdyC8UT90UxsHOLDBDGEjYssUD8/erqu+rhK6IpVaTj69DkuwGUPqqbNOmRqI+7vcm8B3m3odSOQlxsG+Wm1KpRPDVYpYaTdbgWbWOWvBdHeTBex5XYZXMQl61IeKHHwdw35g==
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none; linux.intel.com; dmarc=none action=none header.from=nvidia.com; 
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5032.namprd12.prod.outlook.com (2603:10b6:208:30a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Thu, 7 Oct
 2021 17:48:23 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%7]) with mapi id 15.20.4587.020; Thu, 7 Oct 2021
 17:48:23 +0000
Date: Thu, 7 Oct 2021 14:48:22 -0300
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [RFC 0/7] Support in-kernel DMA with PASID and SVA
Message-ID: <20211007174822.GK2744544@nvidia.com>
References: <CAGsJ_4z=2y2nVStXP-aAPnQrJJbMmv78mjaMwNc9P9Ec+gCtGw@mail.gmail.com>
 <20211001123623.GM964074@nvidia.com>
 <CAGsJ_4wfkrJp-eFKiXsLdiZCb3eS_zqZtJvXQTBafoTWY2yWKQ@mail.gmail.com>
 <20211004094003.527222e5@jacob-builder>
 <20211004182142.GM964074@nvidia.com>
 <CAGsJ_4w+ed78cnJusM_enEZpdGghzvjgt0aYDPpfwk4z7PQqxQ@mail.gmail.com>
 <20211007113221.GF2744544@nvidia.com>
 <CAGsJ_4x2UEmNXCVhJAVRyB8568VMrTkOLeVCNp8CyP6xZJwCig@mail.gmail.com>
 <20211007115918.GH2744544@nvidia.com>
 <20211007105010.33d706cf@jacob-builder>
Content-Disposition: inline
In-Reply-To: <20211007105010.33d706cf@jacob-builder>
X-ClientProxiedBy: MN2PR15CA0054.namprd15.prod.outlook.com
 (2603:10b6:208:237::23) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by
 MN2PR15CA0054.namprd15.prod.outlook.com (2603:10b6:208:237::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend
 Transport; Thu, 7 Oct 2021 17:48:23 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1mYXVG-00C4EM-FU; Thu, 07 Oct 2021 14:48:22 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 914a82b7-8e7b-4010-aad4-08d989baa886
X-MS-TrafficTypeDiagnostic: BL1PR12MB5032:
X-Microsoft-Antispam-PRVS: <BL1PR12MB50323622E773D4C2B2FB25F3C2B19@BL1PR12MB5032.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VnNRr6draYSl+hTwF0OFuLmkTqqFbxtZS2AMgcngs9ZHPLdmiyFxZovemuuxr9mFzWEFMBRLCKMGra106Qrz0HetOavSlhCybwC9AEaKAmJbgUYlo6uycIIis/+vQqkrNHF6zfJNeThvhaVguDMWy9RqCQHse5l7pKY0/Wh8rUK70YD+disI+2wYdZDh6tY8PbcKN0i4HWrj75AvrzlzocvSGwle0U2t9SkZgMItxAVN3WGSY06+Hxf1xDQq6g0lvWA9C+stsZQTeBvMt2yxE9vKWU3Kt+i+iMM4Bun+GnEGv+5G5m5jacndC02qJHxD39CBn+J2WBsraPpk8q7VujRf2P5NJqOQmYX4ZJZB2dgwyemxmI9NHKjiajkh8Vh0f2EiJsWFkcbeCQ66HhVoJiWNMz0TfUwftrqEDrYnatUL2TZA9XKBr7r5Wvd3P/H3XlbcGTCLpktx6EX7hUIEg74y8cmuj/UE37fKd3VTjECPzNoy7ebWdRgFxZyiTCR+fN7IjKgG2GKc2pxdApIvnj8qb/DFH7tGgBZdaNjbTvRvmssQ4zMo49GY02sBl0DXJIBz345xfP11Llt5jIPaoJFw9q2WzCf0iFK0W4PErpqKUh52OW/5gjUGDAjEMhNtKBXB5VJ301vZdtNXH+S2lg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(54906003)(4326008)(7416002)(2616005)(316002)(186003)(26005)(508600001)(6916009)(426003)(2906002)(9746002)(86362001)(8676002)(8936002)(66946007)(9786002)(66476007)(36756003)(66556008)(5660300002)(38100700002)(4744005)(33656002)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sF1Hj8wI8Vkw8ndiDrTkfa1amh4woGGpCyKyfPSMQrOyjX9Ket0oQ3CKvOwv?=
 =?us-ascii?Q?IfVURTvjPXSVjAOxjPcbEu+q/X9hIYpBF8xMoA+MYzK+gTJNblxxKwVGbUi7?=
 =?us-ascii?Q?OKb1e22dgI3PWYj2I4jpJ83cvx9z/DKBk3kjfT3OlnCwcWIF6W1hCqRUQ4ku?=
 =?us-ascii?Q?A5w3WPM4Xiwjmcj2sKa/P8Hwjr9b42cQJSUgDze9k4G9fYzE+QLHvlY7e/PD?=
 =?us-ascii?Q?JypwmCBug0fgMj5GAeNp/ycZPq3ydb8pmkSz+25/t+F/CV+L2ar+Nsxsr/gU?=
 =?us-ascii?Q?aWuQdPV/pV6FXANA+dHPFITih0YdqrNWhT0YWpfxB4IcrAfAG0N42vAOL8px?=
 =?us-ascii?Q?7w4eE7GZE3lgL9zR4f/N7RVNGV8GX3i9OfX5PHGv95hOhW7oMXlVN3WyW7Ig?=
 =?us-ascii?Q?IoKxrYnenwctZCZIEmP0I857pDWZEICQaxItlMSvagM3yH2f+x7HPOAB3sQP?=
 =?us-ascii?Q?JtZAaTj6MZstDXA61CLwI07adiGq2xQcZAqp10vOsm71NINLZ9JC1Y2/fHaV?=
 =?us-ascii?Q?fuLxhKm43PccxXEP3bgw9Wc5S6DIr82Cr+M9aZzewy9DvAvaPhJXUcHEpvX8?=
 =?us-ascii?Q?BNXI1NptaURlI/RFg0ER+ptXmh+QpIKx2AGEpaXzXyCiWaH7/rneqVuYBJfc?=
 =?us-ascii?Q?jBMxaPtTEN18MbUvo+UGun3n+aESfwSBT5ddB/yYA6FAiP9EMwKqYHms7UUf?=
 =?us-ascii?Q?m5J/UfUDeHkUoNPtXlg05btE2QQ7MugYdpK6+JTKSJ5nH6hyaxTv/MVHWKHd?=
 =?us-ascii?Q?vyz4n/kIkk29Ulw+rsQoS5yvCw8gcj9iVlDsK3Q9ASnPYsq/trkdmRGqJwUO?=
 =?us-ascii?Q?0C2qj92L3JvdpRhfTx8wKsiHZcn/ah1nN3vGAz53oYnPExNbYsU0m7xfx7oO?=
 =?us-ascii?Q?aPH0vOwEme3Va4PG0ohGHV1MKZMh7mwq77FaATni5UXAil1GCHHz0mh0G+Gj?=
 =?us-ascii?Q?+THNJakK0cBc9XDiYaakLtFLIXvO0XRoMVSJB3OmgiO3l7TK1pOzh9sIG7Wd?=
 =?us-ascii?Q?ZaJYduyu15IOIq76K6yvP+D7L53V11U9pWBXmnrqpYXKyfpT49NvRS+REaF5?=
 =?us-ascii?Q?ygRL0DFkg8sqFo2XF/++wuVPrPLdtHdPaNkNld9cT0VAoDPuoC81GkwhXxcj?=
 =?us-ascii?Q?dTwCK5M7WaV4Bm+vyPqX9wx/owCsFFiot9gFeQVdoK0mXImeT2jrsEr5Ujhr?=
 =?us-ascii?Q?PwsvY9W8iHIeHHDFYS9qql7MIMtUAXQ3RbIg03rE6dAYHbGwsEGa8RJEHKAH?=
 =?us-ascii?Q?uJvIpPcd/Pa918KCnIuiVG3WsTOQB2Gs8FQHeroFKYJaQP9yP1vCjTwB++BI?=
 =?us-ascii?Q?mP10BXwt24wsTejnS803rNqO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 914a82b7-8e7b-4010-aad4-08d989baa886
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2021 17:48:23.5459 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pA0X2/g5kYpAsbKjk4DKsz4rziUigDkGHg1+8MW8KibmU3VgPMCHeMOFFn24xc38
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5032
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Tony Luck <tony.luck@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>, "Kumar,
 Sanjay K" <sanjay.k.kumar@intel.com>, Barry Song <21cnbao@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
 iommu@lists.linux-foundation.org, mike.campin@intel.com
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

On Thu, Oct 07, 2021 at 10:50:10AM -0700, Jacob Pan wrote:

> On platforms that are DMA snooped, this barrier is not needed. But I think
> your point is that once we convert to DMA API, the sync/barrier is covered
> by DMA APIs if !dev_is_dma_coherent(dev). Then all archs are good.

No.. my point is that a CPU store release is not necessary a DMA
visiable event on all platforms and things like dma_wmb/rmb() may
still be necessary. This all needs to be architected before anyone
starts writing drivers that assume a coherent DMA model without using
a coherent DMA allocation.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
