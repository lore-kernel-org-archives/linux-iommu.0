Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.23
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793213532;
	b=NPk5RI2jSWpsuBDGxeYVN8gDwWTlraYFOMYZbL/el6diuaZtmLMzFhVb3Nx9Pa83qHC1
	 /G4Zl4jIbIQo/1mxfDMFcKiCHUgNlUPpRUhkb7LrvYOjOEAM1PUATHvlTFi90hWibUOG/
	 1pXsWL3yV/LnraYwK0afb8DhEttAd0tFxPwu98YHOKfg7So/tRQmUTrkvUTC34NybMSH7
	 cbTYX0H32J3gTP6SvsLRrNtS1jerqI5KMvMVXTDjkLAAgxIJPtckjAsxJT++ud+kaCBmp
	 uEyQ6XOvdC4O2MQ+BLEQU55I+et1sWv97sQPaqGyb9EMqws5l//pxTdoIjm9GFKI74Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793213532;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Date:From:To:CC:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-NV-OnPremToCloud:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=WGO7o++LfqsQkCzqBHAwq0/EZtsPQvC/+YnZtCY/7iM=;
	b=r5u5ulDXgS2ZDq0TcLXc7XJYKu0FZj/rY1SbiTNiyBIUSdqjFbwfmDIF9ueJuSlxdayk
	 fzJZfa2ehPMmJtrV2QrYrJyOuwJq4FOfPnl2GjN2w+DJUkPJGod7BOcwz7hgqHNQr5bw2
	 gPksXUVaTDCScAO5UAY2I981wh5dpivjPDzda3YegVKLar01tHuKcxEkswuGtmZBlA5Mr
	 VmVf9LbwzDieqfiiILGYPUV/36B2gt5bTOPP99M5dKLSLCnxRuWYW98VRoZWYDVAvsHFe
	 HF0sJH8dX9/JiXYrB07uoi0jQU1mcHZpnj/znIDR6pzRrx6NDP2OjLzKiS/M91qFaZQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=MOAkwM2D;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.23
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010023.outbound.protection.outlook.com [40.93.198.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC988606A320;
	Wed, 28 Oct 2026 18:52:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC988606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=MOAkwM2D
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=prr+Ls+W4n36y3SsipAbOq5RKjBgLE1eFoZgpixsKTfroNgHjfmbRsfqkDaZLBwyd2SS52xr9TlEtphoCqEI551uFvyneQI2u0rQ3gtY/CD+OGpx//Klb4SLzVvcbzj221a1pSCUGsEAozucNhgHb8hdJsjVjHbgtBaFNsFryskezrKkD8RtAMA+/POetKdpDL3WkgQrMFm/opgK9+0ZEEg0P1DBftvGCz9mdhRPZD0sxSoXwvJ69ZLplkuT12WSGEC5zLF8D4LcigchFmRTeRe/yfonQPvbHOBKQ+MZM1lh1n3jypW/swDSoWGCE42SIMG3HMBdhxTmAS9DBNpLiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WGO7o++LfqsQkCzqBHAwq0/EZtsPQvC/+YnZtCY/7iM=;
 b=PaF327EItbKKwnDJ5KHY7F2UQLh9pYhT4chB0x0R9IwbbEOHuaY8LiAFfSSUtuDA2W0VD6iKdem6NbqFEtQeWcFtyHF4xpCSKbBGenGbYveZinFXYDdUZzaQL49y23MrLBwslNgVHWNH4aK7GLRaB7r4q9d2zHtblb8skY63IC9WJ54bRvM3iI4vCFia+HobBQCHwjQKR+Vp5kizbfITVu/YXkQN6QFCjVXsPickM/oopojRLAOlSEBcu+smpwONnqOjSmDdtabP2/Nn84c5vJFvKFKpM5ltEmnkAzUDfoWcj5vXs2aYk0N9KTYjTu+NL9lvUzqmQ+d4xgmixpBk3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGO7o++LfqsQkCzqBHAwq0/EZtsPQvC/+YnZtCY/7iM=;
 b=MOAkwM2DpDgi9KCYxkS9VjA4Zhb4no92MlF3B2hg1mu2DDr3TG6zOK/ZQjHsjJ6mybyXjK4EXZdlndFm9SOgHnlcJXsTlEguQtkEvRL2LLA0ejAdWf0U9I1jyIj+1N1HbyrNNdHlqu+cyIamQ3ZPam2ZpFujVxvktA9vHNmem+vaVhUZ1YtnZw06ZeqU+pXEkZpHPzfn8I+2REwmmWXXFNyihk3GHmc11+kpUL4X7sN1AcYSF39uUTwJVNKqg5mIU8J91Mf5arliV7g6mwzVuLnAYEWr6yu5r9S1wkeX0xhx02dKWE4fiZaBBDjiabyaJY8o/AiHEVEGHl43hNeTHg==
Received: from PH7P220CA0164.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::7)
 by BL4PR12MB9533.namprd12.prod.outlook.com (2603:10b6:208:58f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 18:52:04 +0000
Received: from CY7PEPF000000EB.namprd04.prod.outlook.com
 (2603:10b6:510:33b:cafe::93) by PH7P220CA0164.outlook.office365.com
 (2603:10b6:510:33b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Wed,
 28 Oct 2026 18:52:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY7PEPF000000EB.mail.protection.outlook.com (10.167.247.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Wed, 28 Oct 2026 18:52:03 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 28 Oct
 2026 11:51:44 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 28 Oct 2026 11:51:44 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56 via Frontend
 Transport; Wed, 28 Oct 2026 11:51:40 -0700
Date: Wed, 28 Oct 2026 11:51:38 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Shameer Kolothum Thodi <skolothumtho@nvidia.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, "joro@8bytes.org"
	<joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, "rafael@kernel.org"
	<rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Marek Szyprowski
	<m.szyprowski@samsung.com>, "aneesh.kumar@kernel.org"
	<aneesh.kumar@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Suzuki K Poulose
	<suzuki.poulose@arm.com>, Gavin Shan <gshan@redhat.com>, Vikram Sethi
	<vsethi@nvidia.com>, Anshuman Khandual <anshuman.khandual@arm.com>, "Shanker
 Donthineni" <sdonthineni@nvidia.com>, Mostafa Saleh <smostafa@google.com>,
	"rppt@kernel.org" <rppt@kernel.org>, Thomas Huth <thuth@redhat.com>, "Marc
 Zyngier" <maz@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
	"kas@kernel.org" <kas@kernel.org>, Kohei Enju <enju.kohei@fujitsu.com>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Ard Biesheuvel <ardb@kernel.org>,
	James Morse <james.morse@arm.com>, Steven Price <steven.price@arm.com>,
	Sang-Heon Jeon <ekffu200098@gmail.com>, Omar Sandoval <osandov@fb.com>,
	Andrew Morton <akpm@linux-foundation.org>, Jinjie Ruan
	<ruanjinjie@huawei.com>, Sam Edwards <cfsworks@gmail.com>, Douglas Anderson
	<dianders@chromium.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
	Chen-Yu Tsai <wenst@chromium.org>, Huacai Chen <chenhuacai@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, Pranjal Shrivastava
	<praan@google.com>, Ashish Mhetre <amhetre@nvidia.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "driver-core@lists.linux.dev"
	<driver-core@lists.linux.dev>, Sonang Patel <sonangp@nvidia.com>, "Ankit
 Agrawal" <ankita@nvidia.com>
Subject: Re: [PATCH v1 7/8] iommu: Park TDISP T=0 devices in the blocking
 domain
Message-ID: <auJEOpTq6EbMZUuv@nvidia.com>
References: <cover.1789010941.git.nicolinc@nvidia.com>
 <0d57c59aa3cae891e9d3e07e939e13918a4e99a0.1789010941.git.nicolinc@nvidia.com>
 <SJ0PR12MB8614232EFC74C584CB44AD28AB6F2@SJ0PR12MB8614.namprd12.prod.outlook.com>
 <20261028150909.GC3040767@nvidia.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261028150909.GC3040767@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY7PEPF000000EB:EE_|BL4PR12MB9533:EE_
X-MS-Office365-Filtering-Correlation-Id: c110140f-03b3-46fd-8a6b-08df35248e6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|82310400026|1800799024|23010399003|18002099003|22082099003|11063799006|5023799004|56012099006|4143699003|261022075727099003|261026140227099003|261021121427099003|261022105027099003|261021135927099003|10067099003|261026121527099003|261009223027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	1cRTLVt6dCANHKgvV7i8w+LdMWcD0WyMRnPcAUU8MKSZ4gBAQ00I8jTVlI8POA7S0JgG7qxDmMNKnI0iorcgaHZQKmF4olFjGYHu8Ur5YLZpOrdgi7bWHzepkT/tWNn2RN2qJu7OfC4RGQfR/lBeIitKWeP+iylxnSbzqLeAukGZImkF2o915t71+W11cwsY6//R6Qi250tARj0TV1V/VvoETbtX8q8C8dvbsi8CQq5TOXQnH2+sFuV52SLpZyLvvqM14UyKIk+p23BX3WCIo3/YELZch5OonOrCwbXRktfhv2WYZ7rQsSFWh72mtAhOZ7ZV0FNLqoZUZp/vXXhVMljOXwQJKEq0uOVA1oCh7Ykmvhwi0Rn4binvyFhzvAX5z38bBePtMDq6uUMHbsKujD2cGwxlTALMIoEgAuRqkJHOEZ6G42/mqnu9i3k4Nq602eI9w1EOwsnmIZ7M4JSTHRJ3lh/wvXGwmMh3oYy8dl6Od5E4eWm4iACHV45kIT/m66uvD9dXr3b/aYUZFzMcbupIvUG/ymvKLp2brKtpCyLoVHmpW7l8oWP+q8w2mgE+dQa3GP3/2EKq0vMeAPCV7U5+JD1aVwqAojLGyUOBmTG3mftkj4GTz6r9hgf/mpMbgpzXF7k6Y6Ap9zg49p6KaX4Q+urTAcnM2P6Z1Aat1hvALqKDZe7m05hkudGI6GEfGdnM/Lr2vFXyEEUT++IQ2w==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(82310400026)(1800799024)(23010399003)(18002099003)(22082099003)(11063799006)(5023799004)(56012099006)(4143699003)(261022075727099003)(261026140227099003)(261021121427099003)(261022105027099003)(261021135927099003)(10067099003)(261026121527099003)(261009223027099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+sGuwxy+2QHT/AuT6K4mAFXJDJoRLWBohshkps7/FWCHIlypRaXPwWMZ6SBlo77Yv1NGeW9AjIFwKg3jH4b9TIDW67KW2ZZ7ugJK4ayu6s5OZL150nANpUxz+oaa3oswizJtkD4/mfKPtX4vzfJChoUsPJaXe9Tlt3oonU6Hb5Nz5+YHFXhqNRxiaEC1nAaaCg8Hh3T888VzZKaYAf1S69kXrQcfbSyzDUw8NQjvbaFjwZ0qpIlK/xZMd+ynehjjMiEXkMwUREssbmaiCzYP6NIlqE0sTh7zwc0d59JKhe8Bt/s+N+BhXrKjQRnYkurDxL6W840XaS4mfxF6Tpv8tebVAdKJmGT3SROZehbxd9zvLf1zhFJMQqZJ6MlbCgA4PSOKoHnWpB01MxMTJMCudiNnB/QI0GPXRJZCDmQCUgEPnx63qGaNJC+Enf+tw46o
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 18:52:03.3440
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c110140f-03b3-46fd-8a6b-08df35248e6b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY7PEPF000000EB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9533

On Wed, Oct 28, 2026 at 12:09:09PM -0300, Jason Gunthorpe wrote:
> On Wed, Oct 28, 2026 at 02:19:17PM +0000, Shameer Kolothum Thodi wrote:
> > > +	/*
> > > +	 * When in T=0 mode the T=1 vIOMMU must always be set to
> > > BLOCKED to
> > > +	 * release control of ATS.
> > > +	 */
> > > +	if (iommu_using_t0_stream(first)) {
> > > +		if (!ops->blocked_domain)
> > > +			return ERR_PTR(-EINVAL);
> > > +		return ops->blocked_domain;
> > 
> > How is MSI allocation handled for T=0 devices? The ITS calls
> > iommu_dma_prepare_msi(), which appears to return -EOPNOTSUPP
> > for the blocked domain. Is that intentional?
> 
> For a TDISP capable devince MSI is always issued using T=0, meaning it
> does not go through the SMMU. It should be wired to defeat
> iommu_dma_prepare_msi() and use an identity IOVA as though there is no
> iommu present..

I'll fold this in:

------------------------------------------------------------
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d6b00e0373f5c..1474224c2565f 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -4324,8 +4324,9 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
 		return 0;
 
 	mutex_lock(&group->mutex);
-	/* An IDENTITY domain must pass through */
-	if (group->domain && group->domain->type != IOMMU_DOMAIN_IDENTITY) {
+	/* An IDENTITY domain or a T=0 device must pass through */
+	if (group->domain && group->domain->type != IOMMU_DOMAIN_IDENTITY &&
+	    !iommu_using_t0_stream(dev)) {
 		switch (group->domain->cookie_type) {
 		case IOMMU_COOKIE_DMA_MSI:
 		case IOMMU_COOKIE_DMA_IOVA:
------------------------------------------------------------

Thanks
Nicolin
