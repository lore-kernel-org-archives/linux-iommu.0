Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012030.outbound.protection.outlook.com [40.93.195.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D8247FAF7
	for <iommu@lists.linux.dev>; Sun,  4 Oct 2026 20:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791147567; cv=fail; b=q0mGxAToDIeBk5EtPhlFMy3omee9CwcrhbAsicyaikJPB7LJZ7kcqzI2qnUvcY96m226Y0/PaGVD+IUXpx8UFfhs4j6LmlJfN3F49qnRstntQY4luhxyILPLYjlJz33qQWJM41EdVsCTolM3Rt/zUVAPuIlVAOQI0iR4AvlSxPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791147567; c=relaxed/simple;
	bh=iOT4zU/iNeA/CvEr28RIfAwQdr825DSqTHNGncD6IKg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Orqg2ODXfjy8DhW1BA0vvuxNPgDctLyvH0+wPajICfVchAUVrke/wXw74iHv8gm6zBKvIKWYu5MiNGXm2CCZd3aKBBgEFh3AWN8B3ts8eZGR9pHJr26uSLxwrQ05pEh8nQsjq4o3VuYdR7UGUnIrMktvapO/koJRYfcmjtYXPvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tntlC9KM; arc=fail smtp.client-ip=40.93.195.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tntlC9KM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eSOzz86+qnVQ8vx/oPu4JH1PMaUsOG0OOi0/RgrUABS63vKcwvI0kSoRRY6c6+8LZ64CuW3vTfQP0tYUx3qjjDrp9T6pDIdcNnshtZf62B8RKqqYCyjRrWFb1kjg60m+Vo7cfvMpFAWjr5BMM2aVc9wizYdVqzQton2TYGO7l6jzlAWGf1jcbKfP/ZX1f2Y4Y52l4CVrmydEYdYj8f/yCKidj6dGGjfaq6ySiMQmvKmYK7aGYwh3JAxE2ogK7QZJnzRogNksPTN0ubuMnFG+GprjkFH3lJr31vbgVMEsTPTZ9yF8JxYKy6WKoWqTesg0T6PQ6teNoMDAiM6bdBuRTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=toKCLuddFKZGK1knkyz1JteG7hTUcdTTUOfnApwFp6o=;
 b=ERTWS/nYBndNmy1RrWhMHcgjLXQEl8kwTwvccph8ueRTNOIN/rwPntMFFAXeJvNOU/oAxK870HiAzOkP1emtfTLJQVP/Gmth8MzkEd2gFJO/VlE82xJ2IUaSJqb5jFryzLeJwYeXSo8gxv1L021pSR9pLdXI0y3KMtCNgfy8X+vC3ASND0WE5ugALu14sv4kv0H0eJMPWNC+LUsWTP6L5GtDKbq/GBXI5gz9jPVf2MybAFcFlESd4g7lst5brM1Sw0Ef4/LpxPInHH9SUh0JEvU2vNVe2TaN6nq/lgjDgTjCPLUB7Mwn52/iXTIS3ppDAW7SaKPyA/23Zi7ePJAJgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=toKCLuddFKZGK1knkyz1JteG7hTUcdTTUOfnApwFp6o=;
 b=tntlC9KME7hEETL+oT2gMipmctFBLbf5P1gA2Lzg2RAT3NwPNUaSH0FufYpX9Dc6EtMjV0Dl6nhcMPRNnn5NVCl2RetmKMQbwwwF9jngVqu9tHdepz/UpAZ5jcRU0rDIZvDZhVl9wcHu6A75Hx+dknBHjm/rOVyNDeAJ7capIXbJPNW6edKlQY6ftw2RKgaoDC9m+bESlYWbNqw4bahxIc+BneD1TdUORthF8dyLY0FkCNl4EKOxfy9LyXLs8Hos+cPEaOHk/9MJp7FBt87R3VpqZ3pMczfgLiGanHzzLm9TZKwk3y2CgIrsCsZu9Q+y2PMyrZnAju/2Ng2++7vlsg==
Received: from MN0P223CA0009.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::7)
 by DS0PR12MB7898.namprd12.prod.outlook.com (2603:10b6:8:14c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Sun, 4 Oct
 2026 20:59:21 +0000
Received: from IA0PEPF00000041.namprd04.prod.outlook.com
 (2603:10b6:208:52b:cafe::23) by MN0P223CA0009.outlook.office365.com
 (2603:10b6:208:52b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Sun, 4
 Oct 2026 20:59:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 IA0PEPF00000041.mail.protection.outlook.com (10.167.249.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Sun, 4 Oct 2026 20:59:21 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Sun, 4 Oct
 2026 13:59:08 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Sun, 4 Oct
 2026 13:59:07 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Sun, 4 Oct 2026 13:59:06 -0700
Date: Sun, 4 Oct 2026 13:59:04 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <praan@google.com>,
	<kevin.tian@intel.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <jamien@nvidia.com>, <kas@kernel.org>
Subject: Re: [PATCH v10 06/13] iommu/arm-smmu-v3: Add
 ARM_SMMU_OPT_KDUMP_ADOPT for kdump kernel
Message-ID: <asK+GIWzXjwN3EaB@nvidia.com>
References: <cover.1788130528.git.nicolinc@nvidia.com>
 <d661395d986d3aa78af200f55e43740996ee8a0f.1788130528.git.nicolinc@nvidia.com>
 <asJTsw-oWDlSqNa3@willie-the-truck>
 <20261004163501.GB4064@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261004163501.GB4064@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF00000041:EE_|DS0PR12MB7898:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e37410c-e4aa-414f-3023-08df225a5d03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|7416014|6133799003|18002099003|22082099003|4143699003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	6a9N8jAzLwmUxAizcTzy9lBveA2liY9XTpbm2W8fxBXU6ZhDeR7DY9XqwxkSXz15Y6heJH5cLkmnIvEqYxUXfbgv3Xgnb6iStvbNt/VdFeVE6JluMJFJrU4XQaPlx3LDYrx8u1VK53bWa7dvfipbOKb6xZAaYbhE2uHQxxbk9hVqEuDL/t9b3jIPTh2iRqmDKp7J2vgzXA7sXu54oFbKrda6qCrnfMdWnCep0y0g2yD6nuPmNDzblzhreVHe/bk67cctONND6/2NZFnCMMAQnDsXJ0ky7wJxjXAe9mtSix/qasJ1wa1wzg/YfZQZtZOAOcTyDBUvVoi8JM7dE/OTEhZfomj2+350HTpaZJU3dxuwN+zvrNGMQrxfHcrpTIrjwjaKDLqZfDZUKq8U50yd+y6AEg3X7FtpK9fLeA3WvMWApNZkGEbm8EONtbyzMKw3aAZjHqRTQ73SFUrvKFIEXNBv7WE4bfXM2Gk1WAxS9W53djCqcUM2BKS20KAYsXC5+0XT84NYhNPl19pHhmP50soA6k6A/m8DETNcAndyssH8VaGowJmZD4YU9oQYh5Gw24aMKyVDb5bcqZfx5dRE1UlzEfXNFlIMaGIMXBtYi1LRA5COZNzWvvoDA2GojH6qlZ1NdhQ1SdEdg6BLDlWhUHKP+JZoO6gjmrT0FB1Hij5cxKirV34XaNW4KzBSiE81e1h7cdHp1M/laP5h1LbprA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(7416014)(6133799003)(18002099003)(22082099003)(4143699003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3gX5DC6Uiqtcl4KUnuddRYwunv4rCAPQ8S+tR6haf2SsdrodzOgTRB94j8ChtMrNA1RHzI02662gQbX6jjsNxHxtx2Jzgd0u4EP/QBUHj1KlAk9sS7N+U/TpwnBfBVvlHHkk8JJvV/Ik7TYAxRPiD3rVWY2OioD3fWcYwOrP4GnvcioJTOQL2JtVioNBH9DZ1/u/h3HQH+bLvkixHcBUGvZ/4tyciwWMrCWp7PoYFb+kRGmLHwGd58YH/huLED9icccWYgX0DOyXOVfZ1Uogx7HvBANWTqW9qwh19Ex80ltsCYVRbQFZchYZHXIMJU+vtip8EUoEmBTCuyQhK5tm4ZtK6IfWRvkAvWXZQCqaX8XhcJRke8/R08rounNtEd4HNlxXhjMjUlmUD37D6cwDc3Tj9Qk71lxoYQSdzkwcseSNvqXCT5jliSv/xqcKqTkp
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 20:59:21.0893
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e37410c-e4aa-414f-3023-08df225a5d03
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	IA0PEPF00000041.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7898

On Sun, Oct 04, 2026 at 01:35:01PM -0300, Jason Gunthorpe wrote:
> On Sun, Oct 04, 2026 at 02:25:07PM +0100, Will Deacon wrote:
> > > + *  - A structural inconsistency at adoption time tosses the entire adoption and
> > > + *    makes the SMMU fall back to a full reset blocking in-flight DMAs.
> > > + *  - L2 stream tables are adopted lazily at master-inserting time, to bound the
> > > + *    peak memory use against a corrupted L1 table; any lazy L2 adoption failure
> > > + *    rejects that device alone, as its blast radius is bounded to the bus.
> > > + *  - Only a coherent SMMU (ARM_SMMU_FEAT_COHERENCY) is supported, as the stream
> > > + *    table adoption is done by memremap with MEMREMAP_WB, which is verified on
> > > + *    the real hardware. Callers of these functions are responsible for gating
> > > + *    ARM_SMMU_FEAT_COHERENCY once during the probe.
> > 
> > This is an artificial restriction and not one that I'm wild about for kdump:
> > we should be able to support this for non-coherent SMMUs as well. Is there
> > anything more to it than using MEMREMAP_WC in that case?
>  
> I've forgotten why it ended up like this, it was some complication
> that seemed hard.. MEMREMAP_WC is not the same attribute dma coherent
> would have used, I'm not sure we have the right stuff to be able to
> flush any write combining buffer? I'm nervous about that at least.
> 
> Remember this is not just reading it but it has to operate like this
> after the fact. In handover you wanted to use the dma cohernent
> preservation.
> 
> So, I think this restriction is mostly a lack of the right MEMREMAP
> flag? It is not insovlable just work outside the scope of this series.

I agree that it's safer to defer that to a followup series. It
also needs someone who has a non-coherent HW for a full test.

On the other hand, this series is tested by folks from multiple
organizations, so it's really a needed and verified one.

Thanks
Nicolin
