Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010044.outbound.protection.outlook.com [52.101.85.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0124562B1
	for <iommu@lists.linux.dev>; Tue,  4 Aug 2026 16:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785861960; cv=fail; b=S653vl6V+wZdAFjYpFAwJCr0F6cZ20Q3QHA4IsygQqLTsgl46nsWZRK52U40vd/aIw9AB6D4uU3YOyY6/kb1N1LtCxXwXD8v/9x1ZU4MqNBx5Fvhv1TevBx/vVf7uld8tqz5yNNhZicTS1Swv/ol4b8tx0eprspblFn2ezjEb0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785861960; c=relaxed/simple;
	bh=Xo4rPUhGFuigxv2O1p62Qs+Jz+MSuz9WpVDVRpUzVHs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IHtRKMMvlxn2zPy/rEfqo95pg9lcnyKK7QpoNY/xDjCbXRzYCwx9oUpCYW2Ejao8nHvhRTo6032X5gUGc9nFf582oiYsi29GnvXHfCmHz28rL3clnVfIadURcNy2ZY6/BzCN83w6G1xf8qbCadwtT7m9P5iwyUND4G31jgjBmxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LKmPCLIn; arc=fail smtp.client-ip=52.101.85.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LKmPCLIn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tII/Akn1ddbW/u1ZD5A+ZcuNDac3/aEqUYdIu32amttRQJYXNPFfRXYuvSTgdqL3XGdWnOdWEAzR+eJ1yxW2hiYyve/KsJiSRn1Tny3AfKNmC/EQwUpk/29U/EO+wTCaLzXYvTWVs5IJIw1FA/uIIWhgEbplwNohdjBxJuP1q8cRea07cc99rSSDiBIL0O4wu5y6K2QRKtOh+v3G5nxxBi1m1MoUy8Sz+2tppFMAn54phmQAh4B6LAtxAHMiTp9Zuns0hfozZo28nbBj+y50hLuWMeoYUcFZ38k5Vu0n+AZHGbAVtOPJGWqQYCpGF45UfAD5LoDKlnUtfEKJXmymmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AnoZSb6ieywlhJXub4m/rL0q3kbL+deHmZ5GhfgoWfs=;
 b=gwWmOJGk/e6vYtenylU259V9NyzsUFxKMiQ+ubjFB/6ZFcuj20QvacXsAoDyXBuBlspHruz2osGT6z9vLRUuIN6355djsg1wrJhIBJDM7Gk63N26Js/Og8VIpyN84XuFj0KYOZRQC32gTU/+wdFFdyeZrXKmY9UuQ6m4saQRcfGAMdRL32vUs3hx1L/z/wO/ZU95Od2tNzrHQDRJ7h+Q8aGi9H4+GQ4GNfk7UfN404UZGMUCsYvfL9YhWwr1AyESTCpmPTvVwfWWrVD0fPl9VdfFH3H1gfZBH8jSu9E8j7+AWWLTUykHZmTmU3Oquq2/u8XIJpwK9bmb42mBbn2/qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AnoZSb6ieywlhJXub4m/rL0q3kbL+deHmZ5GhfgoWfs=;
 b=LKmPCLIntYYOzOt+fXDC7oedCAGQ1mXpg+bZ+5sgP/rfUyOKHcfG3BZhZQ2d5rNS1u+l7rPP73sXSrqFLqg/JifRErZXJq4ukY0kPhG3WSYsN49vlCmOZySprZdzz3uAb2ipKoBY3DCzfPMUjBE4xelBTQZJItVgmeIwTBqcrRL6dwSMYTtITjqOfaLmfS4jAmFgjDpC2k+hYDh0WV11KraQF+2V8Nh4A7nlOO1EuoDMh0JZ0Y2qxcty9bMGiEHPD6ezI3Cxq1gXCAOD176YuaF+kKeM2YDqWYC8yM/l/rvF+gofojmVyMumOm3cqihaHuK9hGcEY/9yM+41/XncjQ==
Received: from PH7P221CA0078.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::9)
 by CH3PR12MB9313.namprd12.prod.outlook.com (2603:10b6:610:1ca::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 16:45:24 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:510:328:cafe::a) by PH7P221CA0078.outlook.office365.com
 (2603:10b6:510:328::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.16 via Frontend Transport; Tue, 4
 Aug 2026 16:45:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 16:45:23 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Aug
 2026 09:45:04 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Aug
 2026 09:45:04 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 4 Aug 2026 09:45:02 -0700
Date: Tue, 4 Aug 2026 09:45:01 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Will Deacon <will@kernel.org>, Kiryl Shutsemau <kas@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, "Pranjal
 Shrivastava" <praan@google.com>, Breno Leitao <leitao@debian.org>, "Kyle
 McMartin" <jkkm@meta.com>, Usama Arif <usama.arif@linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] iommu/arm-smmu-v3: Shrink command/event/PRI queues in
 kdump kernel
Message-ID: <anIXDd839UC/M2n/@nvidia.com>
References: <20260706084708.8072-1-kas@kernel.org>
 <amiBagGKn-Aym1DK@willie-the-truck>
 <amiz6GQZ-XGlH706@thinkstation>
 <anHxBh-xGW9JXsa4@willie-the-truck>
 <20260804141704.GB27883@nvidia.com>
 <anINkO1l9Kz8lTVh@nvidia.com>
 <20260804161918.GG27883@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260804161918.GG27883@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|CH3PR12MB9313:EE_
X-MS-Office365-Filtering-Correlation-Id: 17ca485a-60bf-4d6b-8c3e-08def247c733
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700016|23010399003|22082099003|18002099003|4143699003|11063799006|56012099006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	Z4oRH3znbSaLVjVdZ/gYcWyFb/MOb51zopBa2zl6XdjCost4nB+CRh2k9ZUjnfNjreoquLadvKG/RfXV83kei501XWKSf93k03JJ2/J/hLz4PMByfXvZQXcDzRJY3jJAQHeRR85LjVXXGU33ZkKyYOHbR4m9mzJR9aBqAGrFlNWdNlbGtXoi3/WqV4D3/l+ETAoF2xeIJn2LrHyivgRrkN+gV60btxaLlcaoWpEEfy6m5rt997s4iBUhCQmd9ZJItOHBJyYYFKYbs1v8d/SnpOZXDMJza65hXnbEzS9OCjZMeUnitxHYJHaVwPjIrjdjv9fZ0KBree9wdp4tHRMIsF/bbPRrb6RYMl9V7mfo9PZDXNZoZJf5wHfAeYYrsYA/VK6Ct9PUpub3sd5IZo26BCC+39KbyZOqYdY4dVLDLQ1i0Hhggshc4g85Pds0e6p9xoRLITesbwEbdgjY3ug+WFjPDrt7uGboWbvdfx8F5vFT/IQ8E8z5QwDwCUs9jDs6EJ6FmFmD7EFxTI1Lg8sRdGV2HBwS8rbVPafxQY7hKPUALFiDOVIl9gP5KOvT4YCvrmYB/x8Uj9ORMTEU0foIw5g+2cdWMVboyUI9lb+5Lcw50/mMdXCjDRaNA5D/dMD8/o4kjughP81wwG2e8hW8gkug1Jr1ahMfjeSYkc0Ecg+yOlfQYpnpCpEquogZY4HuGvTo9y+sRKudd6cc2v5hMQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700016)(23010399003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KGzOfcqXM3EPTx1Wf0+60BpWFpdUhE5mHBvRcCatEKqH6UCBsivUzitWF55Ji5/gGjZO14l3rACsXU9lLK56edUW69t+gLeXAeJ4h1kHQnSe/nJMU9BrQeEWYKzprlZXr1nb9OBw51xYwW1qdpC5tbg6yLk1Lf+/NpQ375L9qlmma3g1LE7U/IIuFlmTS8MBze4g+8i9RUvgO7VA9womP4/G1y8KAHHEuMdPhhl3WwZvUZVm5UYA9DK7KnnXVQhoSSRYh+Aspmw/fRzkMd+Yo5fZtQkZRTfTsBAacQfqRyQED/IZ40lmIaCiJ53F30U+ShVP9tLz/ROwpg16XFsVF3GO0Q4gDoehCySKkZZclsqC819L4ir8S7X+e1DSxGuHSmWPFYXFmKb5OIZOmo301CQzTIhxae6/jBef7TcqUp4EjhDm+SiHbDwGFgZ5nJTj
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 16:45:23.0145
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ca485a-60bf-4d6b-8c3e-08def247c733
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9313

On Tue, Aug 04, 2026 at 01:19:18PM -0300, Jason Gunthorpe wrote:
> On Tue, Aug 04, 2026 at 09:04:32AM -0700, Nicolin Chen wrote:
> > On Tue, Aug 04, 2026 at 11:17:04AM -0300, Jason Gunthorpe wrote:
> > > On Tue, Aug 04, 2026 at 03:02:46PM +0100, Will Deacon wrote:
> > > > > Would skipping their allocation when is_kdump_kernel() be acceptable on
> > > > > its own, or would you rather see it done differently?
> > > > 
> > > > With Nicolin's patch, we can just avoid allocating the priq and the evtq
> > > > entirely in the kdump case. We can then add a cmdline option to control
> > > > the maximum size of the cmdq, which is useful regardless of kdump.
> > > 
> > > I would still prefer kdump do this re-sizing automatically, even if we
> > > do add a commandline. It makes it easire to deploy than having to know
> > > secret command lines :\
> > > 
> > > So functionally I still think this patch is fine, though yes it points
> > > out more things in Nicolin's work too.
> > 
> > I will send a v10 of mine, to skip the EVTQ/PRIQ allocations.
> 
> I think Robin's point is to structure the v10 so you introduce a bunch
> of tunables, including something like 0 size to disable a feature.
>
> Then have kdump default those tunables to the right thing

But in kdump, EVTQ/PRIQ are disabled, so my series should have
skipped their allocations regardless of the tunables.

So, I think the tunables can be done in a separate series. And
its use case might not be confined to kdump?

Nicolin
