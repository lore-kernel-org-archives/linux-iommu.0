Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793645399;
	b=dbrrbww6vEorpV76ANQIc3FXrlA3YJhGBT1wawzhrQYDj22Ykc6HWT1SJt3AKNqMVtT2
	 +xQlrVcEDgaffMHrhSgU037uW1hGL1wiO6EGQu8BcUMH7TG5tgsuH+wWVS6g/G33+FRtD
	 umHX7PcNhTVUBhIdv5TAnIvnxRVATbjBaXnP1KotzkutREulomMQiRsPzGMyU4OvxmQYq
	 zJ4P+URuhoo1IFEilZKor+cdkEFKnowMR+x2c641/YmHNZo86NvA0a5YGoK6sN2Gf7Tds
	 ZlKZoQSv3PLxJSVSPiOl3kYyyyEGrm8BHOHuVeHGMsTiZYmES8RNXsttp8XNSncsN4Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793645399;
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
	bh=mZWTDYLtSuuAeaPS9c5bJrnsNCHpnkCyUvC96yDn2zE=;
	b=ivurhi16b2T2bAaNSfHYFLQijgI4OzMxQvYQsPy9QeYf8moBpoqEukrkT/ni9uA3tchO
	 yPbmwp5Hi2W5ATBGD5Hm1glyw1rePK1o2TD/7uah570dRVF06FEhfjiwfaeUBucPQFCe2
	 OlSlnh59z/iHoXOK6DR98sOeLCOsBH+ppleKrESl1h3lcRAWancQwQbJkM8PIbHZ7fjUG
	 YEPAG/P4+hxmprxyyCW828DwgJSv0061IP/uQsDHGBKsMXwN0mU2f5WEznu84Jij3ilLR
	 HhfBd5yRekj5k191G1p3+IaukTEMldjw3TlwNNgpMtWjutkA4YTjzc733LTf8bojdFw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=gEJhuh+d;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.13
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012013.outbound.protection.outlook.com [52.101.48.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CB0606A327
	for <iommu@lists.linux.dev>; Mon,  2 Nov 2026 18:49:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46CB0606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=gEJhuh+d
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OvUCDARXyNmiC5gqLN07X0VH+HYYgsZWHcF+NBKCoD3FidQfuqwzMbHGxdYL6SecKi3dCzd8reEuo1m0XHsA5ILKsjQNe6hADWyvk2I3mdi9q9kAyzmtEr1gYuYwSEmShLfX8MxGjYddhleATsNZ//+nTDludH6Hsfg1nNk8RLuHU0VxT1cW2q37ldD0Dv0Dwr8rRy93RNdcOjgvWrB60AHiru/pr0O2jJOgmjfKEg45DEcjJj/ImhggTTCq9ppNZWR22HRtutBRHezPrsxIaI4RZ3qfI3Yb4p+97mvCtqkO56E5b7iUmJ5YUpEGoAhyTkB0bOPJc/C4S4MzRdMwGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZWTDYLtSuuAeaPS9c5bJrnsNCHpnkCyUvC96yDn2zE=;
 b=JPG/qyaLr3s/ecitt6aTG8iElC/85TJxmkYHIANh8lwRdJMou5nKmRTXXxkOu0saKOXnCgp2EjfQ4BKTarode/mqMLJPTW3+uQVTaETmHOUreAqs5LmaAzWShO8qQfr7/Yb69sQzWfW5oPGqADp2pBIOMmdqNpdZ+TTuCzu2cZsnSLwduuP3kG/ih0xPph6UenavLL0pUTRMM4jflxDoAN4W/QGJH9pMB8lLC/GrtFsDrGmTHmbmr/AUrarFPlOrA3GB6mhXpfKNO+cFmtO4MlN6A9VF/pvjOZOldjNeIUjUfDq83Wbz9/gWetXTYcwAVf9OJojSCLCdvgAJi8g/gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=oss.nxp.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZWTDYLtSuuAeaPS9c5bJrnsNCHpnkCyUvC96yDn2zE=;
 b=gEJhuh+duGPNS+ple9KbJKIdmsac+Pi0nxncuUDOuCjsy/NWugUu9/9U2mfhuv6JZZhqC4gFJ93qz90eHwK5rwiOpdwAZFcdzph4e53Dx1gycrsU5wXzC0mri+JHdUCJxglm+C1U2ea8od/PI7hmyMxcvN6hUeoQQNZkstx6pWEXH7/51w1RHKzJdyb6BeuebZGk8iHMyItSaPVxZUGjLaxoqlvjcFr3pmLppuV2ZK1DIkeUjOHqFSW/mVSKhZIcnLJTB01tXnR4PLOgMh6nMD74Q+m4vMtxvvnBaxxrpD9639BTFSiel/a1PPlBeW5m8HHxALOsADzha4lLzM/pXg==
Received: from BL1P222CA0027.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::32)
 by PH7PR12MB5976.namprd12.prod.outlook.com (2603:10b6:510:1db::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 18:49:44 +0000
Received: from BN1PEPF00018073.namprd04.prod.outlook.com
 (2603:10b6:208:2c7:cafe::6e) by BL1P222CA0027.outlook.office365.com
 (2603:10b6:208:2c7::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 18:49:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00018073.mail.protection.outlook.com (10.167.245.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 18:49:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 2 Nov
 2026 10:49:24 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 2 Nov
 2026 10:49:24 -0800
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56 via Frontend
 Transport; Mon, 2 Nov 2026 10:49:22 -0800
Date: Mon, 2 Nov 2026 10:49:20 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, "Joerg Roedel (AMD)" <joro@8bytes.org>, "Thierry
 Reding" <thierry.reding@kernel.org>, Krishna Reddy <vdumpa@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>, Jean-Philippe Brucker
	<jpb@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH RFC v7 7/7] iommu/arm-smmu-v3: Wire up shared-SID STE
 ordering and feature gating
Message-ID: <aujbMKormSlNQMOm@nvidia.com>
References: <20261030-smmu-shared-sid-ver7-2026-10-26-v7-0-961726ebd6ab@Example.Com>
 <20261030-smmu-shared-sid-ver7-2026-10-26-v7-7-961726ebd6ab@Example.Com>
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
In-Reply-To: <20261030-smmu-shared-sid-ver7-2026-10-26-v7-7-961726ebd6ab@Example.Com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018073:EE_|PH7PR12MB5976:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dbecd4c-fca3-435f-66e8-08df39120f4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|376014|7416014|1800799024|261021121427099003|261021135927099003|261022105027099003|261022075727099003|261009223027099003|261026121527099003|261026140227099003|261028144727099003|4143699003|11063799006|10067099003|56012099006|18002099003|261102123227099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	mOui/pV8prV7R0OdPuP9cS53SBGC6LPyy8sknDMTog0wg0HdDN/Sc47+U44W6cIZBRwL1iyQkPSwsfIPosjG1AR90HDhtGBLEZpAqmwlXhh2V427Rs9WVPUlC0IXSAEPCdQKkGBjTX/f83fpwwzyRtdalisewZN8d26jvu7Jw5AtWwJQCDpaLozw+0JnOhJ73agbkbSkLXjC/7zjqEqIgX+K8NRemVJ+0eZRjfi2t2ee5wDLVGUEcAv2TIGRe5WH7s++4jdbrsFLBEW5QDxguPSDRTAmPPGnX56Pe8OdSG3UG16iW4wq03GbuGv+o7jDVVSeAdlL+g84qb2mCzSNkVe9ARHvosw2n5fDogdgO8FwjxdfwQt5gsu1TapDAE6i3R592BecOARnlC2Zf/d8qa+Ne7HenTznOkD2OSPL3p2FIQe1mFo4qc02JxGl9z9dlFMO1Wjw0jwTzZx1uhZd34Z47COdsFnrwgNfLj7QYYbdy2V+F0PftUib9udhx38ydmzeBiFh7D8bBZocl726MO8cLvDuZu2PeP7SP0jXTPoRzgF+43K2bRgNmlJ4+zCsbf9+SNnyJJClB4162gctQNvLIYI5fR6fRbvwckivnQj4aDRTClJkl+IRJr0LA5HSz+I9JZBZVITRy4zMjlOxGCd9qkVEoE3DsKu7ZCjwDY6cUWCm+UcHp6VQDMubcL8acQW2svqMAFaqkQ38/ruzHA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(7416014)(1800799024)(261021121427099003)(261021135927099003)(261022105027099003)(261022075727099003)(261009223027099003)(261026121527099003)(261026140227099003)(261028144727099003)(4143699003)(11063799006)(10067099003)(56012099006)(18002099003)(261102123227099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bXJpJ+/odPLWxUFeQhh2kA4eeKpWpzsLQXgcfRhVWsDVAKcDuDLqzg/iRnK7ykdW59vJWkeAl9WUTINSCbL9r4YN2CV3wZEoiBS3Hdw6wyuRH+0s/nwD9RHIzQaMCUn25OBi6O3L+QWbyxzhyjEWFdsu49tqINh+Xub8cp6oO5Q6FOIDrX3FYRACqXqm9EbrtYL+nW9kscd+3uuM7Z2hdw4r3rKiAJwYCUYTkipD7v93OBZuess5Vm546d+q+TTFn2s0BhDG9etSiNTZ3qu0aHAzg3fuAD7cuqFDnBdG8amJ+ZE44UX7JL2PIN5XMxNJOgt6cm3yUHJ3PzBeot8M29TbR1Chgol6xOd30Y5sSgn61J/PBXyj2ggxCXQ+wMiTwYdNeodUPxIfFHPB8BYzzr1bx5qcBB00I1LDKUAU0nCjhkjPoKTZJg56du4XisiW
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 18:49:43.6915
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dbecd4c-fca3-435f-66e8-08df39120f4b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00018073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5976

On Fri, Oct 30, 2026 at 08:09:39PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> With the per-domain CD table, every non-PASID sharer of a SID builds the
> same normal-domain STE: same S1ContextPtr, S1DSS and S1CDMAX. Disable
> stall and ATS for shared SIDs as well, so the remaining STE fields are
> common too, and let any sharer program the STE. This also handles the
> case where one device's driver attaches before the stream owner's driver:
> the first attach now installs a valid STE instead of leaving the boot or
> firmware STE in place.
> 
> A release or blocked attach must not abort a shared STE while other
> sharers remain, otherwise it would break their ongoing DMA. Skip those
> writes while the SID is shared; the last master (no longer shared) still
> tears the STE down. This also means removing one device from a shared
> group no longer leaves the survivors aborted.
> 
> Fault events on shared SIDs cannot be attributed to a specific master,
> so arm_smmu_find_master() returns NULL when the stream's shared_masters
> list is non-empty.
> 
> Disable SVA, PASID, vSMMU nesting, ATS and IOPF/stall for shared-SID
> masters since all of them require an unambiguous SID-to-device mapping.
> Reject sharing at insert_master() time if either master has stall enabled,
> or if the existing master has PASID or ATS enabled.
> 
> Introduce arm_smmu_master_stall_enabled() to describe the policy actually
> programmed into the hardware: a master stalls only if it asked for it and
> its StreamID is not shared.

Why do we need this? A stall_enabled master shouldn't share its
SID in the first place.

> Add arm_smmu_is_shared_sid() as an inline helper in arm-smmu-v3.h so that

Use arm_smmu_master_shares_sid or arm_smmu_master_has_shared_sid.

> arm-smmu-v3-sva.c and arm-smmu-v3-iommufd.c can use it without repeating
> the list_empty() pattern.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Please check sashiko findings; all seems valid.

https://sashiko.dev/#/patchset/20261030-smmu-shared-sid-ver7-2026-10-26-v7-0-961726ebd6ab%40Example.Com

Nicolin
