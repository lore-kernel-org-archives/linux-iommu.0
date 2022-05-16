Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA89C433EF
	for <iommu@archiver.kernel.org>; Mon, 16 May 2022 18:06:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B587C40B8E;
	Mon, 16 May 2022 18:06:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QseRzBbttuGA; Mon, 16 May 2022 18:06:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 65F7040222;
	Mon, 16 May 2022 18:06:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3B917C0032;
	Mon, 16 May 2022 18:06:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6D8E7C002D
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 18:06:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4AFF98133D
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 18:06:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Qsy0hD2rUDEL for <iommu@lists.linux-foundation.org>;
 Mon, 16 May 2022 18:06:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::625])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AC5E581300
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 18:06:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UUtBRBL5dS3fKs6QWVd+5dYsQcp+NwAOxIUp9Fe+WT8kTL+lVnQqiXVzx+lmZplrUI7HiqWGE4Fd/G+JDBJcq35ktGlXt75l+RSdY7i806w+pVQ6cKFQOqaQpuMiS/D8uyI1g8O4DKE1fTSfrq3Nov4gGOXZ/edwzKOqfvckSnk0SDL8Xqg7Kpb0bZY9pqus+LXsl1F5Z8Eaaon8jyykC7DwMz0n1CZzEIv2jlN8wSL+pQvpjg4hzC4ugu2PF6z4qtjWQzEfOvhZn+lN2YsHB8GS3tPti9DjTsW4QxM1JUl2w5TB6nGhLDejqh2QVGgpJujKJgC77kL4x8mMon+Mpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=66lV+vb/k8Zc62qUhTgFEaeEz9WhiKYWzft6P7182Pw=;
 b=LdD0R6z7cWxqZtnb6bmqJdgvmN0JyZy8EDXJVslJbAkv4M2cWVnwgPg9Hdfbk0maRh/sEDeC1pel4pRlJfKdy7gwMkjiv0LbeoyKUp3tbsojz8zDRcVoBxGKhPE59Tw/f7GLTT9v9JngPYNsyhujx0hqpNlxPoMB83+DfrPHsLYqmdtDTwQbXBWmTeobMJVrod+lzToRgMFqnD68OqM6aMzWai1c8BvmkiMZ7WWTRMsUaZP/wEFLzQD0+wEjKvCI+2RGiRoznEIOJM7bgi1cNPI2gH67636DIwSlFIt9Xp6YT80bOvnXIzWyyd67lEDI+3eoPS5WGdLUaB/dGOKH9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66lV+vb/k8Zc62qUhTgFEaeEz9WhiKYWzft6P7182Pw=;
 b=c2c6Smwev6H9gawjmDrLS5dhfb7ENjXrzya82PsczfcsDSJuNsIhKovGZszvJw5LzaHJOFE9rMC56TPhzfowglTBM0+9BhR6j/kqAhdQ8R3VHKG8PDjFq5ibHKhxakhPHv8tcmPQbOxCFhwGWN4dCGIOFDdOJba8HUEPd7/Lh1qbsvZGm3vYvnKkV/SCUTTPblA9lBgjB+B1Q/+Hr/ThQOEZ6gVM7t9jlEUc2QM5nGAbe9kQspUI865lPQ9KGqL/iJ7AiRdCUeXNw+04Dk/1oqrXXHpI1I62sCKsK9VVZQoHkcWzTnuliqSWQ+Dl3Sx7+VNq1qpWm3DabL4T3qfJ0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM4PR12MB6493.namprd12.prod.outlook.com (2603:10b6:8:b6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Mon, 16 May
 2022 18:06:29 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 18:06:29 +0000
Date: Mon, 16 May 2022 15:06:28 -0300
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 6/7] x86/boot/tboot: Move tboot_force_iommu() to Intel
 IOMMU
Message-ID: <20220516180628.GL1343366@nvidia.com>
References: <20220514014322.2927339-1-baolu.lu@linux.intel.com>
 <20220514014322.2927339-7-baolu.lu@linux.intel.com>
Content-Disposition: inline
In-Reply-To: <20220514014322.2927339-7-baolu.lu@linux.intel.com>
X-ClientProxiedBy: MN2PR19CA0066.namprd19.prod.outlook.com
 (2603:10b6:208:19b::43) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8dae12c6-070e-4cc3-7cd5-08da3766cd0b
X-MS-TrafficTypeDiagnostic: DM4PR12MB6493:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB6493C304AAA4C469915BBEB4C2CF9@DM4PR12MB6493.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fmknOjlLMNsgLnOWziVa45gf7kXw/UX2fY/Kd8iH8sKjuzRA76qopFTkvg3CEvyWEWMc0co5loqXCjpoGZXxyp+oHtGOhCeKhw/uSb6GSvo6t4VnG56UldUZMAsqDaD59eNLRHDXndArQdWYINVonqOsYdiQFgjoESWgmhalb0M0kQFYUdoRTDX7fxdhAbeDIGwOxeRUtI0w+T8PyWc+hH1DgZVPSpqW6I6pzxwVSCG/nNhT89gzE+7RumgBOu2utPq90E068cvH/Nc6gnQENJK0BPD7TbNa2QZJ6gmCRmWqRWnAGBl0I80Wq0OvVEC6KNC9BmaZVIzwJx4o+ad6Zm8XqY18l+iQhqoiInTIjPq8uSXXFp5TJ0OlDpXCJpM0cbqiDreXsuISdkwIwug8pK26GxLYwugIB1/QK7OPgj7lE64S2BJ48CApnOx9huw8oPRu9Tcm8HWa+kwzviGCnOsR9Mt3Nn+Y+gY9WnrF4AtfYqfMn85jDucHyxRSITm0WIMlYkp+9mz7EG10XbI7Rn696AUB9JkeDykL4e/EBrYWSPxd4RdhylFurjq+QTODLb3RxpGY9OMwtE7R/GXSjc9mafOw9dYyJ71eOFLwhTWS6wMxiGa/DZ/H+DP31OhUX491BfNkA9c4kEWqhWqLnw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(8676002)(66556008)(6506007)(66476007)(8936002)(508600001)(2616005)(5660300002)(83380400001)(2906002)(33656002)(316002)(6486002)(36756003)(6512007)(26005)(54906003)(6916009)(7416002)(66946007)(4744005)(4326008)(1076003)(86362001)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hKLpXUm6HRprpPeTnxuWDxIPAE0zlzw6ttilqqjHhFCWg5LgaFt7tUTI1gVJ?=
 =?us-ascii?Q?VNBdCY7uk66ra5F41d9bP2j5x+fv7Rtcr3BPfh4X2Nhcm7z1+GTmtEwLlohk?=
 =?us-ascii?Q?QXCgMzMWvT19uVQn7GSXdeUp0+lv585Sgm5FkXFpNPuUaRS6OeXJt9WahD5j?=
 =?us-ascii?Q?Lrlds2KkVAboZzAhHT0fATlEEWJjovwj+3KRI8PksGqDrm/RTMw2XKyaugyN?=
 =?us-ascii?Q?zh9YYJKy3TZSu2SsJhnMVILoIkCWwqJQMe0tSRmPE2lzYvnV/kfhZfrfr0Cz?=
 =?us-ascii?Q?xTzrJegJrCdPLWed1I30qgr+X+jIqacGRFbk34sg/OGsxb2zPb1564pTP97p?=
 =?us-ascii?Q?AC24l/pJ3rxEngCPpAzV6BZR8Z8zgAI1LpXW7hvY1qAmxQm3W/UVlI/PvIMG?=
 =?us-ascii?Q?53XdXZn3knDAWcz9ZTeMH9mMQBnqGfa2K4RYhpkw5uwYqD46aVl0h0i6P/zh?=
 =?us-ascii?Q?jabxFI8tmIXZUqbzJLDiJ6a9RdScRB6v+zgu7zBrcwaJKWtRZDcirOYN52oi?=
 =?us-ascii?Q?TQLK0mGPpnff/GZjGzxvyNkGJdlzmEg0+jhjqzkw6+azM3b6po87Gx7GCXx4?=
 =?us-ascii?Q?kqVxZVHGAZBR/xz07AMBmx7049tvCIOj94l0nv+RW2xyZ7jnoQJ1dxae1BCj?=
 =?us-ascii?Q?69yQdUlvkhFTgEbMOzwHs2ZM2wpfeUfWz7iv0k1bWqdpOfAt81y9AQtjgUB+?=
 =?us-ascii?Q?ISA/sRx9KJi6iMGsWUHMvY2SYfL1ROFUvTkMhfV1HxEpIiN0IGynee1AqINC?=
 =?us-ascii?Q?J1uT/KiiGDRC5ibWbBtGLYAxml09Ba7c9vOGoH5YjXS9P4iIy62OgGdHF/+7?=
 =?us-ascii?Q?RI5BwnZCX3zql8rFQrq9H+Rt7BDtcTcEQEgj55HHac+pBw5krleMXOqdJbRu?=
 =?us-ascii?Q?Tlu2+aZaJ4iHcCKm/6eixWO0Z0HPhfmnAlHeiLYk070xUlM+meh3iFnju+PV?=
 =?us-ascii?Q?cglI3VhWHgI4O/NVPrnyaaQ6f1YTvIK/CgNHWteZA/pHPC7mcNKfrreVj9b0?=
 =?us-ascii?Q?mDJQEpwNKLle2Hvt56vwGLx3qbZsF7oVrxahYfBiHKVVlJlXlcNZV2Ha2aH7?=
 =?us-ascii?Q?spmTXFooEBJr/iiaTI7IHrZNL1NBCoPBT7XWdvunpPPC2K3LkDf65Iuw6Txd?=
 =?us-ascii?Q?5ObvGjEsw5vFvAmss96j5QigaLvK4mJTlYMzzVSgduxq11sKVH3DP0MNBY3U?=
 =?us-ascii?Q?XIIziZ7xzGKeMojdI4SRQCIpKZFArJ7rLl9NTmV8LNYUJL4GTURJo39FvoGR?=
 =?us-ascii?Q?cBQaF0Cuo8id5rxeP9IdXoN+ZZGUy7vb9iFRqV18HlNblh/rpp9+14iykAbu?=
 =?us-ascii?Q?3mlcJASibrHRcBin0EUQ1V3q9yujxxkq7OLSGUfm8pDSzNgavwDfaTS7bCPd?=
 =?us-ascii?Q?zyhFj8rzn5WQ+Hi0hl5+9fvv1wdYyRjgZiogzGga4bmZweqp2LTw/IJIhvwv?=
 =?us-ascii?Q?vKdLgSYQ8ItUD6LvHMCc0rpOupFkYonor3Ld+QGuk0l9sM1oHA+HUAPQG4XS?=
 =?us-ascii?Q?N9k2798J1t7s14Qi/CQI+L+GvNIg7A0OkYg5G5TMInKVbecJ5yteRZU44QDT?=
 =?us-ascii?Q?7vz1GQgSc68A/2LU8h46izjcK1Xh9LCHdshCRB5qlGrftEOLQePJS6nChFWA?=
 =?us-ascii?Q?thImGG8Itr86P9DGJ/2XG1CP+Ybvk21WP6hdHtfpX2IzinE0y4gcPPWtQ/9C?=
 =?us-ascii?Q?TMuK/7zpqlkwFXriO047DavJUVzz9MdObN4e+cwEPPWiGIz/6CFky0Sigaxx?=
 =?us-ascii?Q?1n2VnyrFbw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dae12c6-070e-4cc3-7cd5-08da3766cd0b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 18:06:29.7307 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M1xdFyF39tja5NAT5AfhPu5K+WdtEcexwdbs8K1LA8Pie4ALVlxqBLyHHO5SueZR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6493
Cc: Steve Wahl <steve.wahl@hpe.com>, David Airlie <airlied@linux.ie>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Will Deacon <will@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Ashok Raj <ashok.raj@intel.com>,
 Ingo Molnar <mingo@redhat.com>, Kevin Tian <kevin.tian@intel.com>,
 Jani Nikula <jani.nikula@linux.intel.com>, Ning Sun <ning.sun@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Daniel Vetter <daniel@ffwll.ch>,
 Borislav Petkov <bp@alien8.de>, Robin Murphy <robin.murphy@arm.com>
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

On Sat, May 14, 2022 at 09:43:21AM +0800, Lu Baolu wrote:
> tboot_force_iommu() is only called by the Intel IOMMU driver. Move the
> helper into that driver. No functional change intended.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/tboot.h       |  2 --
>  arch/x86/kernel/tboot.c     | 15 ---------------
>  drivers/iommu/intel/iommu.c | 14 ++++++++++++++
>  3 files changed, 14 insertions(+), 17 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

> +static __init int tboot_force_iommu(void)
> +{
> +	if (!tboot_enabled())
> +		return 0;
> +
> +	if (no_iommu || dmar_disabled)
> +		pr_warn("Forcing Intel-IOMMU to enabled\n");

Unrelated, but when we are in the special secure IOMMU modes, do we
force ATS off? Specifically does the IOMMU reject TLPs that are marked
as translated?

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
