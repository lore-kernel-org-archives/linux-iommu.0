Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794604182;
	b=AfSfM3qIdIGKC2+7NWTEuhrRlc3o/KkE6cl7k58FQDrvNHcIZ8+4KZJk6EZQdhO9ySMv
	 zipyOqcfeUEvgmw2AN0Px0eitGpz2o3ly5Tq9iqdTbiEeblMBUnsQrInPm1CZTO/AnPip
	 HU1Kx2YsmQNS622wJLxdo0fuaSxSgRC46550lI5JtcuEAT2U91LbrlgFX/NF+jLwsbeKR
	 VCK1pMY3vWmuSOY3BqBWUoHRiQLe1THsKnO/eny26z4N5i0PrQBhocbyWHVyW6G8OU/cg
	 3qBNWRmWKGbxRJkpsb4Sl++oOscgd3Qa2guPgNIB4u0wfaiQFYYq+2ZAKH7hYOlHLkA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794604182;
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
	bh=Daoo5ND8JTOmUiByfVyI0Dc9ic8ar1R3lPyO6185fRE=;
	b=f8jAHWfujP1TwUrX0IdyGtOQ7YFeyZgDrDW/+VKpnDiasUJRm8EIZBvgN4n167ui8LWs
	 rtHPD0ygC/OUvN6yh3eUrgy6ha0hQEQ+ApD92d2s2x4OLTDlnhWrM2b789hvh11aLeNPM
	 TtUm7L/O8hPsOYver4fwm0dglg1c6QYfbHV0dmX7c7QB4QjgnrKluE2vwzAykB5WlJGTQ
	 9ljxszi/tEi+sFNgaWWtTfBXOcdWVv5u6O+PL9pu+663ujbHMtu0UhtPy3PqE4cq2oqll
	 KdIU2br/A3c5J2BXtunKqmT5mY8FcmbsNXIk9T3ukqRGX5N4GeYo7WLuPNVoETLL6wg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=c5JguQCn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.12
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012012.outbound.protection.outlook.com [52.101.53.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A967F60A382D
	for <iommu@lists.linux.dev>; Fri, 13 Nov 2026 21:09:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A967F60A382D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=c5JguQCn
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sRyRX+zYYp2esnd3Ud6Fxh8HkFIZ1wyLaav0Fig20R02bs1Du/gLbOmF43f/iQXh3a+KwdrCVG2q1jmeSUYYTCEeHMqFMlaiw6BqoSeVpEYmAmQVbqAyRwkAZ9roUiBGnZn5SjwJlHsTnrha4nFeKtLeRSSIf6jy1hyXPzL9FMjRplQLJ57V5wzKJ/B50yHJ76ERBNB0c7chJpjRkF6TNmlnx3ayxYfkhbD0p75LSqYApfW4MPrq9jfoNp19MBpB5jwL0zSJ0aE+/55SbE9TTc8aIMGSDjTtJRORGfl0kES6hzunHc3MTY/T0ZWzIy+3GGc9UcPYQXwJmyT6Kg0pPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Daoo5ND8JTOmUiByfVyI0Dc9ic8ar1R3lPyO6185fRE=;
 b=kC8xO94yikUTjIQ12IBc3wYUwM/b2UaTwZ2zgwA4kKs21Vv84annHCKIIE7tskDfYlWzcP3JtWQh366YHSuxgzu5QLf1/nUey6txiJeNMxB/FKJW/vu2jH/eJ7BX5FVBrfYztjcNMkYIX/jOI22oPHUvIFvSk4SQjMJQp6eEBtgWU+xqCTtRw5AoszPmx7cgT+lk7rEOskQqGQj8KtWbjUHZk2Qo3Z69cDjtbhP2f8DBYkg5dZQEwOMqt87733RavStAGoHbSu7oVlWQ6X5qpzNft7VOSnofyotMTc8jOHI/+0bCpc1cRFu+B1k89oZ+mouLUvErOSqTFPAVIbRPUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=oss.nxp.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Daoo5ND8JTOmUiByfVyI0Dc9ic8ar1R3lPyO6185fRE=;
 b=c5JguQCnqmKBZFCoR/aVMfJiW3maqSF17chYDhViWAyU/mfO3Ek5oMAIaY8FzI+0MHn4tXOYA2SbVtk8J84MQvSmZc3GZL8PIVib5VMNSr2CdCKaIVKF7nNrk4idTDFTWNo/6ZBcmGZSf52liYDNZF/GCQZv+f4kYN/f/2ot1vBj65YPgniHXnva14OMIDDPUdipbSkQWNRB5S/p5HAVy4cnbGu12UwfsDxWNotpOikazr4hhvXBKeJYNuTZFVwQ50Ee4/lzgvAtdurXLmLDKhn3otNewApPcnXNxm1R0Mr1HC8Vh2I/xacmVaS0Khb5TmIepJWn4Vgr+mm7pAMfnA==
Received: from SJ0PR13CA0066.namprd13.prod.outlook.com (2603:10b6:a03:2c4::11)
 by DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 21:09:29 +0000
Received: from MW2PEPF00014677.namprd04.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::8a) by SJ0PR13CA0066.outlook.office365.com
 (2603:10b6:a03:2c4::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Fri, 13
 Nov 2026 21:09:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MW2PEPF00014677.mail.protection.outlook.com (10.167.249.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 13 Nov 2026 21:09:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 13 Nov
 2026 11:09:33 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 13 Nov
 2026 11:09:32 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56 via Frontend
 Transport; Fri, 13 Nov 2026 11:09:31 -0800
Date: Fri, 13 Nov 2026 11:09:29 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel (AMD)" <joro@8bytes.org>, Jean-Philippe Brucker <jpb@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Thierry Reding <thierry.reding@kernel.org>,
	Krishna Reddy <vdumpa@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>, Peng Fan
	<peng.fan@nxp.com>
Subject: Re: [PATCH RFC v8 7/9] iommu/arm-smmu-v3: Wire up shared-SID STE
 ordering and feature gating
Message-ID: <avdgacwSFkfopVFA@nvidia.com>
References: <20261113-b4-smmu-shared-sid-ver8-v8-0-587307a77f3a@nxp.com>
 <20261113-b4-smmu-shared-sid-ver8-v8-7-587307a77f3a@nxp.com>
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
In-Reply-To: <20261113-b4-smmu-shared-sid-ver8-v8-7-587307a77f3a@nxp.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PEPF00014677:EE_|DM4PR12MB6280:EE_
X-MS-Office365-Filtering-Correlation-Id: 98b3e7ca-6bf1-4aef-5551-08df41ca656d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|7416014|376014|23010399003|18002099003|22082099003|261009223027099003|11063799006|5023799004|261102123227099003|4143699003|56012099006|10067099003|261028144727099003|261026140227099003|261022105027099003|261026121527099003|261022075727099003|261021121427099003|261021135927099003;
X-Microsoft-Antispam-Message-Info:
	U7Lr2f2B0HyMfL3vFauVM0COsvkBX1LXVpJcZvAK/wkOW2h9JCYWbbsZWinCVAFFiGCx2A4I1WXNKNVY6u+OREqD7JCOd0g1OX0vX5niTGn2GZZBi7rnZZDT5xjqX0GIWm55/HAJIHL4h9d3a64NY42uSVowHeBueRltNklbEz/fDW+HAmFdQ43r1TqA8tIccU001EHULNYi7sM4iJHQ6Xn9bU3jscDijNV/JT8xephg+/3RjFekBhpg46Z9dI6zPlnRFRA22HmghpfdqUvnXHXB2JgiGdQ5MvAt8HqoMVhvZ3axezClqKBiMcIZ4hoPGNfzEbSgWt5VwNWR0fR0HCnz9jd5HOs5lkIHq1LZoe7EWNzgb7801tNF+X2wtb5C0a4i+c7dFOHqPojg+RSmmPymVv+QsUn84f69vwP+FFa/9cSCXETzMqcVuSCPa15nQUQMmfHNYRF98429sUwDSAEzw/W7m6O3Wn3hfqpd61OdE9US/qfBwDhYwsfgdyVzejiw6G76gF04y9S7gHM5qJUbLFoFHGIvyOmq4w9AtMGGUxlp1TplI41+eXjnDwYsyhtkDka5gNlKHjlBGf2dWzKuJV5Mj2uUI1hyC9w80Z/tqDg53t4Vq19D6FlhunZEsDzKpnVhB/hnHvfvRggifOfwgEEO+Ki0wyfvRXjmbqE8o4njs84k28P45mTlzERsHEOYtxVho5MpMbJc0AYl1g==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(7416014)(376014)(23010399003)(18002099003)(22082099003)(261009223027099003)(11063799006)(5023799004)(261102123227099003)(4143699003)(56012099006)(10067099003)(261028144727099003)(261026140227099003)(261022105027099003)(261026121527099003)(261022075727099003)(261021121427099003)(261021135927099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fDtfDvuBF99MsVwzDXO/tvaRdrl6A5W15uHqxVTuoe4cNtzYUqqzY+UUB3M9RIk6mZu4pknUdSC7CkZlusVfKdIupRx3ekx01uB8UZP1lxXYPV0C4fwNoPnsAV2Wn0hP/Ph2ALOYGXB661AnvEhYXGRs2938+SidHE9GnTVX9n7AohkT4VLi/22jSj/UZtdV2T2oHEOtZKkgfaPNdwucRm5FfmxFShbESEz/D9SbeZu8ZzOKxgditydIDpnlcRSdqftjkdy8Kud3Ez9iPsvP+mXE+PFVy+WiPAB2/G4+kddB5e1Z8qQ8tcC7JjY/yYpw8uHm7z7M6/baIEmx1l0fe9NWKoAmYt5+68T3ww91yV4IyA69vP1Te8StYpa7cK3uYkTDqwOjWGyZwUsIbjHAcC3Bq4TUdRF/cDsdQvhC0LAk/7+OmKZICYUEu98VzLa5
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 21:09:24.9719
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b3e7ca-6bf1-4aef-5551-08df41ca656d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW2PEPF00014677.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6280

On Fri, Nov 13, 2026 at 09:27:19PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> With the per-domain CD table, every non-PASID sharer of a SID builds the
> same normal-domain STE: same S1ContextPtr, S1DSS and S1CDMAX. Disable
> PASID and ATS for shared SIDs as well, so the remaining STE fields are
> common too, and let any sharer program the STE. This also handles the
> case where one device's driver attaches before the stream owner's driver:
> the first attach now installs a valid STE instead of leaving the boot or
> firmware STE in place.
> 
> A per-device release must not abort a shared STE while other sharers
> remain, otherwise it would break their ongoing DMA. Use a dedicated
> release domain instead of inferring release from the STE contents:
> group-wide BLOCKED attaches still program the abort STE, while the
> release domain skips writes until the last master no longer shares the
> SID.
> 
> Disable SVA, PASID, vSMMU nesting, ATS and IOPF/stall for shared-SID
> masters since all of them require an unambiguous SID-to-device mapping.
> Reject sharing at insert_master() time if either master wants stalling,
> if the incoming master requires ATS, if the existing master has PASID,
> ATS or vSMMU state enabled, or if a PCI and a non-PCI master would share
> the SID. Other ATS-capable shared devices have their ATS capability
> prepared, but ATS is not enabled while the SID is shared.
> 
> Resolve stall_enabled before insert_master(), and use master->stall_enabled
> directly for CD.S, STE.S1STALLD and STE.S2S. A shared master can never
> have stalling enabled.
> 
> Add arm_smmu_master_shares_sid() as an inline helper in arm-smmu-v3.h so
> that arm-smmu-v3-sva.c and arm-smmu-v3-iommufd.c can use it without
> repeating the list_empty() pattern.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

I am asking a bigger question in PATCH-4 for Robin to confirm,
yet Sashiko gave a few scary findings against patch 7-9.

Would you please run Sashiko locally and address them as much
as possible, before sending a new version?

Nicolin
