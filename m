Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3DBEC433EF
	for <iommu@archiver.kernel.org>; Thu, 24 Feb 2022 12:58:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 541B4415F6;
	Thu, 24 Feb 2022 12:58:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v3AZ5L2UzMcj; Thu, 24 Feb 2022 12:58:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AAB6A401E8;
	Thu, 24 Feb 2022 12:58:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5D4D7C001A;
	Thu, 24 Feb 2022 12:58:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EC37CC0011
 for <iommu@lists.linux-foundation.org>; Thu, 24 Feb 2022 12:58:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CDC3B812F1
 for <iommu@lists.linux-foundation.org>; Thu, 24 Feb 2022 12:58:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t2CB4HFu9lZV for <iommu@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 12:58:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::61e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C5716812FF
 for <iommu@lists.linux-foundation.org>; Thu, 24 Feb 2022 12:58:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dl9IZHLB7+W4A0oYnLPu1HhQmb/pYyZ4+GU18wEhsnftUGmKM/0SU8w9N1+EblJJHOAcdpt3iakrBRXgT2xZkxh3aDFzSDwRAT7xXXMqYa9MwNiaR1lE7PDs8MettMGojmLEUXkKUWnaonymCWHCTiJJSMTf6jivmDV+E0UQwvAXGpyKPLyhROQfPiRvyBk5CvOs+57x6pFnD9AmBnY6QI6MACIy9CluCO9DwIs23/04G+mrCnlKuwQvHWjD3Tq1wGcGvFhyourXWsS878rAgFTc/IVmbTpXq2JO5vyiyEmHjBYyFAFqTaOTWsEi3sb9KAoT7PgxG/xdMQsml018kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJaRq1uQKdS9ywGG3B3dKmPLxL1FUGLojp3x1OscV6Y=;
 b=if0csP2qmaYlgedXM6udgyGQheXmflg/rLCVoWQHZKmC/8wWRLO122y9oFI94q9cd7jhwhavPnuX/gG2A3mYecNyaKZJHlCQoHyYD9IivmsyJKPwldJWS2RBQnTBiY3hmk59j2BFq0ay1QNyvmBNb2b9hiR+eZ+2UUBoYagnwWJNKPnWaEFuAEb3orBtKwhFYbiG+ddd/WUSds+++AQtEugLDViKPGbsmGIwpHpAEXVib9OESIMerkT0MpbaPOJPWFyS7t47ynXkDmHkzt8F+4xNQjzfn8mMJflHg6eBQOiWU+L4TCaymT2GSdczQgNGeSphZ2h3wNQQ2S/i3/jdbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJaRq1uQKdS9ywGG3B3dKmPLxL1FUGLojp3x1OscV6Y=;
 b=hTacfZX3u0dr3htv68hgTkJhuNzSnSjIhCZoNBhirZgP00cDd3ztsmBzUubzAT4PZmyY2/gGACwVOqbrEqrN58VhWkN7HpdZSOYL1T9jEJwYusHbcyWl7L64BkE77EEbFM3Pm7TyZFNQ2mQVoVpXqVFb/t4S9hE0B93yYHSFc9jJuSo9friUNpvIJPuyS/Jgs5s8ncyPRVR1bUxi0kBUrjrdFpZ74O4tWoq2Em6SL5YkNYyqF0X1OX55x9PbX/zaC8WAtTjdElw5fHwX+itUebgRUF8gC1opbbUAGSgghLH9qP3+VA3rV2gryd5iHMAwKVZoSUiZ5umNfAZ0yEmILQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
 by BN8PR12MB3250.namprd12.prod.outlook.com (2603:10b6:408:99::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Thu, 24 Feb
 2022 12:58:40 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::287d:b5f6:ed76:64ba]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::287d:b5f6:ed76:64ba%3]) with mapi id 15.20.5017.024; Thu, 24 Feb 2022
 12:58:40 +0000
Date: Thu, 24 Feb 2022 08:58:39 -0400
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 01/11] iommu/vt-d: Remove intel_iommu::domains
Message-ID: <20220224125839.GD6413@nvidia.com>
References: <20220214025704.3184654-1-baolu.lu@linux.intel.com>
 <20220214025704.3184654-2-baolu.lu@linux.intel.com>
Content-Disposition: inline
In-Reply-To: <20220214025704.3184654-2-baolu.lu@linux.intel.com>
X-ClientProxiedBy: MN2PR05CA0058.namprd05.prod.outlook.com
 (2603:10b6:208:236::27) To CH2PR12MB4181.namprd12.prod.outlook.com
 (2603:10b6:610:a8::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12c66640-d3fd-4428-e8c1-08d9f795611b
X-MS-TrafficTypeDiagnostic: BN8PR12MB3250:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB32509FD2CD3E097A4394812BC23D9@BN8PR12MB3250.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b60FH0wZe8hPcKF4Oyb65MRUYd9x11RoOqUgYOk66/mQSTUP1GMB+BDbscBqJl3OAjv9ucWFrXTAQtK5hS1EhlHR7FDuzRzFCnFmrBc3IjhOtYXpAwc2vsrCGduCmLY1x8OokBr0ewmsLUZ7icdgbKjSymxd1XzflAwXUljyMG5ZKE/8mgHUuuln9VUAjg3E0gLizwJeAB1zNHA/FOInwmlFsLIpfgn0ABhmI7GfzxLLBfDdke9xyorbMw0Y2C3unrjkNZNvRYET2dPOG5iFQj/olpMSDcpfDvSbPUPh2CA6RF2HqejCSPXcpVp52PidRCV/FZM9UcWxX2nbU4tQ/9MFWetENG990wN5EflNnVxVDH+8IX0HRtSjWuX2LB+QclDYkLJgZNpSOVchasGbrGUoIfnT948svXl0X78xnMYQdKINbI2jesFFd7Lv+tDeOXYEvDYyPrltVnFL9PKYnOMdfoMsESotvZTOZkY7lMkvbJacLVxsrculOxWCDCoYOLdlzYQbR5a0rGI4/lOSeDoVBZHu2AGkgVHNgsrrrj8d7UYukZ0PXNL9FxyhSn9M+90SYTw/c7vY4SxWcHAQhmzddS3Y3CTFjQDE9ctFqh8L9wypRbghMBL5l39LsD2/+5Xw/mwNoe24sEXqO1b5aw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4181.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(4326008)(66946007)(66556008)(66476007)(8936002)(8676002)(83380400001)(5660300002)(6506007)(33656002)(186003)(4744005)(26005)(86362001)(7416002)(1076003)(6512007)(54906003)(38100700002)(6486002)(6916009)(2616005)(2906002)(508600001)(316002)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fQBtzQRbX9UsuFcELJ9RW+V/+WAlcsHLZmG9PHVz8hnjPNExznPsrVC5+XCW?=
 =?us-ascii?Q?jqlelPbL/Z/YZXQTjZUuZgNDNyqSzyr9zZHwp+cJyFbrNNu7KWgSjIMm2x76?=
 =?us-ascii?Q?FIBVIMZe/Jymzqq0Ti3tLMaj23CDV3W9XSdTCtnzp2ODBOGC9DndQvZayZAQ?=
 =?us-ascii?Q?ovbyJ18uLxtGZRvtsrr5jZaQ9u4dwUYaJxAJkJ2yS2NnReL2JDy8nQAk6cYT?=
 =?us-ascii?Q?3h6J48EIgtaCQZCFT2r3q7fvZgFIWv3RCyI1bCLK846Ez0Zgp4L0AD+5+0yj?=
 =?us-ascii?Q?fDE71fvnfaXOns2Ky2wnSHfCTZlaBzjU8wJfK3JYBnNtkSujN7GifM1ZAvq/?=
 =?us-ascii?Q?W4H4hP0QzCrYSTazZxsAGzClWxbzAcdN2uZ4zb9jvJACKJBcUW7XRaYoizZh?=
 =?us-ascii?Q?MYfHrlx8YBXjVf50WeYAb2smASvp9ekg8BSRjiI/XtK6cHe7L7DDqafAKGj7?=
 =?us-ascii?Q?mO0njRFI99aMa/Ixks7iojz0AjEJePu/HkXZWNtbp19vjxGXf4DVOLIUovDQ?=
 =?us-ascii?Q?AIK4BEwPKUZ4NTeLwLAhF+DiOE37Gpg7+FXFF4p7E2Yf2lYYrbIzubammm5P?=
 =?us-ascii?Q?3jir3GWebsTRqp4i/ILCj/0rkVuNajKjsmtmgWTRVQ3vXBL6QhvEwSTsa6Pj?=
 =?us-ascii?Q?FjrGxSYDQmTrZxs6j7Cq3beR/hmKjuP4WNZzCIhXODMrbMU0PcnbgaJ1N86Z?=
 =?us-ascii?Q?bv+4z9Nj00+sBCjveH02CDNhm/ayXphZKFDlTzMq+pf7xpyUAaHIOfh3NSRR?=
 =?us-ascii?Q?t8W+jtsqIg6KtKuMSVCjVzPy7mBX4Fs3kNMb0eVg/CSu18YWUxTkk4FsNJfp?=
 =?us-ascii?Q?QzTuIK2muegbe207Sx3IPkKLe2xmewRbCFH8DECfNb6sQ2VI3yqsayj/NEzu?=
 =?us-ascii?Q?MY1Z+Rfq/Ttf1AI0DgThlUd4LanJ+QHpyourU6oBmBJJAutP9Ya0CG2ER0/D?=
 =?us-ascii?Q?RfkaBQ1yrjVa8EbG4YbgWOifvtMMfU4YEq61vnv2aFAK5EniLs4l1hDPk4d4?=
 =?us-ascii?Q?+bQ3qz/7liLo8VmyfJnlQ2IyKFwUJ6TzjXsVhOHE88Eb1FUPFwMTvEIqTJNt?=
 =?us-ascii?Q?QcGAmGW0oK6g8wZlJ/mjV8yjHXVEgligeEGMmF3c/GYbdQRfbuFCLIoONAWN?=
 =?us-ascii?Q?9Te5OUSAt5B+4qACPSVVJUuwf7jsy7/HqKjFblA1TECyW8d3qnTeyUylVE7U?=
 =?us-ascii?Q?qsCRAdbEcUnz5kH4Y2TF/ynuAq+qCyv9LKPhia7K3n8jaU9g7DsOBcHwIvoV?=
 =?us-ascii?Q?e/CXVNGkIHdEI34DB7JNV9yUM5ZNh2PVAYE4jl003E2p1v+J59ycMu/N5EUU?=
 =?us-ascii?Q?Vnfyn7A0GvxjkPW5OAc7rTv92dv3+jbOolUol6eyxxkVE0rU0BVWMRazu4LJ?=
 =?us-ascii?Q?+5gDCUM09RHCx7Stvi4pGuP7VDOlrBXh4TdOHkrN5VXSpyMne7to/uPhv1iR?=
 =?us-ascii?Q?/fAObI6TU46Wys/DahswgVjFVMCuK0yqoPAVY8hKyEhEW016so2SdFagQLAO?=
 =?us-ascii?Q?GkymqlM1PlFaXKgRKUokncRaMrGTW8pewKGb6YDryJM2F5PFhYuxMYaNyVMF?=
 =?us-ascii?Q?BgACN4+3jW7g2YWHbYI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12c66640-d3fd-4428-e8c1-08d9f795611b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 12:58:40.2907 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gLoFq6W1W9Rsg8Btnk3vhaYqwoiJJYYsbbh41Zs0dKXLttc9VHzyD1zsU1zcnfoL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3250
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

On Mon, Feb 14, 2022 at 10:56:54AM +0800, Lu Baolu wrote:
> The "domains" field of the intel_iommu structure keeps the mapping of
> domain_id to dmar_domain. This information is not used anywhere. Remove
> and cleanup it to avoid unnecessary memory consumption.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/intel-iommu.h |  1 -
>  drivers/iommu/intel/iommu.c | 68 ++-----------------------------------
>  2 files changed, 3 insertions(+), 66 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
