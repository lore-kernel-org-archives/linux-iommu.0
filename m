Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013016.outbound.protection.outlook.com [40.93.201.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2013C5DDD
	for <iommu@lists.linux.dev>; Thu, 12 Mar 2026 14:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773326576; cv=fail; b=i/KoziMlBkkQ72OIE/IJ8qK/EDjvjJg8lonUxyqcKUYoYscUOamDpBYdAuk9qvlMjETKXu1adp4NvAmSThnB2eFyObLOg5gILZi7CEZ4rWjSUDf0vmEeOqsi7hQiemoEqkIAGyjpww7FyCyMj2Re9slw6H9EW0nNAmBpCLsASLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773326576; c=relaxed/simple;
	bh=bT+v/5u4uIiCzSwQq2kJ8x7+C6BEnpH5oL1E5oxNwIE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9qseEqi8pNLfK18c8U0ttIUlFS+LgzXjIVrlfTvzZSsM8W5mylI5FWMuf0zhirpIjOirPfD7ZugeKQ7v3RJ5p5yh3S/vbWl2czy2vmGbDJ6/01Z/rYGXV2qjDnTQjzACsTmjGjEqjl1M1r1RyoQ615RA3oQ5DjMmPs1z4Y3mwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vS/gquao; arc=fail smtp.client-ip=40.93.201.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vS/gquao"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XeFTc9I3T357xoyIVlgikb6Nd8ngus1L4WktoGaLQeC9FkhlAecURIYcwyo4O/COlPruFTOVtWLT5U4ldW1pVxOk2ozDfgh9RQ1ZQLhTxaH7uRFcFZ7jmXHUoDjCPnvDVcBHAfz/F944sClGXt+Pc75JOsdCzKGtMgcw5gAS2GYRWAWvs2tWABPW/If8M96VO6ZlL1xjgf2BYac3+SJViVBKHuCNd30H+XfuzUro0fGJd/HJoU4xntUR3odpak84FRALdxlBBnyAg5BOX5LPUXE+vuZnKP5vHN+ZgEQWDenA7VBbanpwS+H1tgDezzsRGnq+3tAnOSpC6bLoMJBLXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41qPzHPHr7zSNm6YSKoFbue6wnKRAJ1sNdmj7BP3arI=;
 b=sdEUgPNGjedpcCtF9FDlC2mBg9aQ7Ld235tigA3sk5RgXgsT+TZXrSTqm6Z9xisYt3q3j7H+nqfcF3SMSTyb4qSm8PCOV/ga8X/3W29w3OKx8df997F7FF+wKTJ2G+tKrVpmlSwTsNrMD8a9u5F0CHCSlw37MU4/P02WeiV5I2G0qNVRsXiT0d3GmahYcRd/w6RfeDNs9YUt5Ff0ZoG2/Jn18Or7WWEnndpem7z+IVc81hFAatY/5HrQgtBkkGbgKV0204Lf4Wgq/ECPQd0J9vL/lXSJwrfmYyt7XsIItaDMX8tnvTwxwXF/jBBB6xIklhQIAtTacTX0gc2vsUZ6eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41qPzHPHr7zSNm6YSKoFbue6wnKRAJ1sNdmj7BP3arI=;
 b=vS/gquao4sHYdvsrNUS0+go80gpi2H4+X6TwCLHOnJptHnP241XH8kATXWOBXfg6CTDYZiI/cS3MSjjYpaQQJss2xOZfoHw4iDdCcbhIdWEUhj3yLRFJM9BQoqmnGh+akOoHiBgP5BRWB4yCkkN8b+wxwGXXiZTzTP5UpX9pA2o=
Received: from CH2PR18CA0027.namprd18.prod.outlook.com (2603:10b6:610:4f::37)
 by CY5PR12MB6105.namprd12.prod.outlook.com (2603:10b6:930:2a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 14:42:47 +0000
Received: from CH1PEPF0000AD80.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::68) by CH2PR18CA0027.outlook.office365.com
 (2603:10b6:610:4f::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.26 via Frontend Transport; Thu,
 12 Mar 2026 14:42:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000AD80.mail.protection.outlook.com (10.167.244.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 12 Mar 2026 14:42:47 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 12 Mar
 2026 09:42:46 -0500
Received: from amd.com (10.180.168.240) by satlexmb08.amd.com (10.181.42.217)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Thu, 12 Mar 2026 09:42:43 -0500
Date: Thu, 12 Mar 2026 14:42:38 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Vasant Hegde <vasant.hegde@amd.com>, <iommu@lists.linux.dev>,
	<suravee.suthikulpanit@amd.com>, <joro@8bytes.org>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] iommu/amd: Remove PT_FEAT_DYNAMIC_TOP from
 PT_FORCE_ENABLED_FEATURES
Message-ID: <doxqnixjqned3cz4lcmg2ps7oxidaosymn6qwepyjlkhprvtue@mspn5cm5556z>
References: <cover.1773058553.git.Ankit.Soni@amd.com>
 <0e71bed81bd7ce5e40a7fb24e6aab32dfb7de306.1773058553.git.Ankit.Soni@amd.com>
 <ed1715de-951e-4794-932e-577aee2c76f6@amd.com>
 <20260311164403.GC1448102@nvidia.com>
 <rkohijfap7j4kqbspdp67ygdjy2witildk54ar7ty6hogpqzxk@n6dzmnipzbxf>
 <20260312112223.GF1448102@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260312112223.GF1448102@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD80:EE_|CY5PR12MB6105:EE_
X-MS-Office365-Filtering-Correlation-Id: c476ecce-64e7-44da-9f3d-08de8045a0d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Zt8bat8EV9oIXPtfh/JJgCRdkmjoIE14UWN3uLwEKLTRyfCufjYdlrGOdKBbcVdJABy3UkPCMLzlkjF7LAsk23MAC0KzdMP/cQ6p3RWgSTRHMZfvC/sETLjXXeqom5KDIGJBMUqlceYvEKTo69CB5NuAUaLIzzIDrPcwIbMxMsFIXET+H/3E0u7z4ZZRuPWxnp5iP8qD7wA5jjgLurPDB+Ie7KX8cY7/YseoDJzrwczzSAtyIclV2LmLDsJ1g1q1H5Ega2YEn4DAHhiFLmJJkEb3pZ7f29bMM32/E6CZLGo3WAHil90yJl293I+XVSH3g5rZuCQXNilFu9qMcKC91ayGGgY1POlYoR8QifOzh26gTEprF84Bo1gQF6klNVDGIv3yHjDEoajiPEGy1ePGmxsSwLQAtztu+zSAiarqx9Rylhyqrh3ps2XcmGFmvf+pfX+PTTSFre2H5d3fSWPtWH+iv67pcavZPjYR+WOSAe636K8OwiXDXK5kA1rhsE0caEfPcY1Zgs5ncQYigOzSugKZ5NeaSgUc5Hz++BONnRYefgvvXTLK3NNbm3eUU5ps0SnPWOPviYcc5fZwSe2l2dVarpSjmvLHPrvjmDzeBHXuoKMfiODVuNIlq2FBkJz87//PDlBTeyaFfChedSCYwG/3HZSMC+nSJ5ZY9/nJoZchL7QoXdX0hvkrCTA+PKRLA57fLc50wXwmwyh0y0sDPWCdXwL+t/37lCEBXKEsiPsIV3rp6weRGPs/FeHoOY1mZYcRQfM7hLUwTt60hTi4JA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QamEMKxKGeqOkCJfuNUS0tRHDtcfLLBMtpfQXiXKpbWBfcY+YWZ3XdPExsuiL/PP+DNcAAVwQ8nJ2k6FzZ8hmxfAFKcmWz7bATK7GCOL37icLueQaJ2X9etdFI6nx+0my6MJbY0GL1OVVFZo3uC5fvMLnK4z73WGwGSDy4bzJ4AmRZjohnA2BzAUAUYVC6jf18gGoiXiMMyFSR0lI3vpXS8psPDFQIwTGh3LfJ2tQyODHPCvJNmXozFWh+9plsLje5z/6jSQBtRjPTS9AmihliiOMs5jDgUfcWWtbCADKiV/hozo+C9NTfaWueS41+YQ39/ppHj03K4GLF/awOSEJkJOku9ARhNoUV9y+gE4aPHvR1kTgZ2CZUvOt8RMErwy+npDbaQkRoUXnBX7OWm9zp426RywGH+Oh75SbeL6GNgb1+SajhNGP7aUiJpvkHYB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 14:42:47.2026
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c476ecce-64e7-44da-9f3d-08de8045a0d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD80.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6105

On Thu, Mar 12, 2026 at 08:22:23AM -0300, Jason Gunthorpe wrote:
> On Thu, Mar 12, 2026 at 04:10:13AM +0000, Ankit Soni wrote:
> > On Wed, Mar 11, 2026 at 01:44:03PM -0300, Jason Gunthorpe wrote:
> > > On Wed, Mar 11, 2026 at 09:54:55PM +0530, Vasant Hegde wrote:
> > > > 
> > > > + Jason
> > > > 
> > > > On 3/9/2026 7:35 PM, Ankit Soni wrote:
> > > > > Dynamic top is used to grow the page table levels. However, if the VA
> > > > > size is small and the initial page table level already covers the entire
> > > > > address space, table growth is not required. In that case, the generic
> > > > > page table framework clears PT_FEAT_DYNAMIC_TOP, which in turn causes
> > > > > error -EOPNOTSUPP and leads to domain initialization failure.
> > > > > 
> > > > > Remove PT_FEAT_DYNAMIC_TOP from PT_FORCE_ENABLED_FEATURES, since during
> > > > > domain allocation AMD IOMMU driver explicitly sets PT_FEAT_DYNAMIC_TOP
> > > > > via cfg.common.features, this keeps normal runtime behavior unchanged.
> > > > > 
> > > > 
> > > > Fixes: 879ced2bab1 ("iommupt: Add the AMD IOMMU v1 page table format")
> > > 
> > > No.. There is no bug here.
> > > 
> > > I don't really understand why you'd want to do this, the driver still
> > > sets PT_FEAT_DYNAMIC_TOP, so what is the issue?
> > > 
> > > It shouldn't be removed from PT_FORCE_ENABLED_FEATURES, something else
> > > is wrong.
> > > 
> > > Jason
> > 
> > When hw_max_vasz_lg2 = 32 and starting_level = 2, top_range.max_vasz_lg2
> > comes back as 32 (clamped by min(32, 39)), so it matches
> > common->max_vasz_lg2. The 'pt_init_common()' clears dynamic top because 
> > "the table can't grow beyond its current level." with next condition in
> > this function, domain init will fail with "-EOPNOTSUPP".
> 
> Ok, that is much clearer, but this is not the way to fix it.
> 
> First it needs test coverage added
> 
> And probably we should remove that if but it should be checked closely.
> 
> Jason

Thanks for the heads‑up. I’ll add the test coverage and the other changes
separately.

-Ankit
