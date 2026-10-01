Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011027.outbound.protection.outlook.com [40.93.194.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEFA4AD4B5
	for <iommu@lists.linux.dev>; Thu,  1 Oct 2026 16:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790870883; cv=fail; b=e1D2bDdeyo6640wkEyUzRVSvjJ91bWWthH9lVXdXbwKktmFxKRl2uNCdX7dMKJD/0rgTlrfoXO+BCGmEK1pqKGfEhlH/m8k5oC/y6xrZ69cKgb7AchkBRvy88ljuPjyOwf326jid9iZRkhHIKAK7uaGfn5BolHpxlDBhl3qm13Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790870883; c=relaxed/simple;
	bh=+zhzJ2C7zN0BbylPGgGP615YQ7kWnv66TLwqLS78K1g=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G6E0uqCKksMbZlUgMnPBqmiyNAn+03HRaYcvWHDG6MYWyZl3p4ZORpGSj1SnW7aphOzAYUBDMyIafQ9fhZNtYlvGVmR7jAp9kGuDcquSbcXrxRrzI/gP11UUdWzRk3dBmdkX/LHMb/NiECfwmWs9B9mNs8coFuB4JRNvxHyP5GI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PMV4KYwC; arc=fail smtp.client-ip=40.93.194.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PMV4KYwC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ig//65JYSSCTmCATYl8upOBWqUI3XRG6YIy7ipMN76HLaxUQ4pkBwGDUmnSvkkletO58PkeAYPyuEPfyYUFltvz5HqS52qIlUbZE2APH5wcSuLbeO8tSEGGiR5/n2ta648y747tuwJWp+69n9gX/CM9aj5QUotnuGMcpD4w93Viy1Tm0u2G1jMhlo3cAsJR/gSu/oPWfGtg0Ak9vuFml/GtD2wjYeNFAo1nYhtv2WuSGcoCpqKComJUPYr2m0odXpe3C1FS7GsjsgwgHnudglJ87uSiElQiLo1QcHBsG8yBl3YDMrVcPcSVdZvvWJQ1jn3DRtqGJPGyA+N1RtmF58A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZlIwZqfS4qkAG4wU/kx4+s6vSfa4ae8MTU3fVmSFJzU=;
 b=kg3c5mh3wCfExZ8p/Y6or+cFWXL9pIP0FpbfCVJnWGBshBQ/OsMoT2DLUBUdh40X4rX2OJ3JyMFJXolhMtgU1KlG/47TyyZ5Ul+Cb9fNvMFZJIWIfEMj2Na2L+BPXYlGbyyL6w5v53644omzojNnDuP9dtHC8Ir9Jct7aDArNpWa8+4gxHJrUvImXYpzED0rF45C0bVAIR3B3GISzdKLZBin/Bd9KAjAZNv6aq6LKs5pEQ4ApL1FHcXsNzRXOjuW5tXeIt1aNHAV9uf3ERB41IOsf+62AGZKSLIF7LNa5EqdW4BIABRN0QoSCoNOC7FTQzwm6VjmibnsMBuB1MPYeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=oss.nxp.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZlIwZqfS4qkAG4wU/kx4+s6vSfa4ae8MTU3fVmSFJzU=;
 b=PMV4KYwCOBIK7HZeUnkwPjpHevmUe0roT+vHI/TOU47vHmmAuSV/bxWktesj+ADbiPTEzkURC4O7EcYqe8msp8+9gRvDjuzDJElyQdHH2sp5votjvDBW28NxE31C+MGxvnoVNf8f3TPbnNRcW83A5K9QG433c5PLUnixpAEPkbDUTJrv2YWuuUMb0XOGz+SmAsxGMsBetpS16GMCmvHHnDNMP6Gj+7h1gbnXT9p2t0YMF/VZ05TFrLyCP92axQpCVSixxM2PtIzsevSBy1jbfhyK5/mICxLBlUpcIWCZFuMsfsG+obfBFE0ZBGPj6sqGs9SN52oxmpp9zn4pwt3pxg==
Received: from BN9P222CA0025.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::30)
 by CY5PR12MB6431.namprd12.prod.outlook.com (2603:10b6:930:39::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Thu, 1 Oct
 2026 16:07:51 +0000
Received: from BN7PEPF00000097.namprd03.prod.outlook.com
 (2603:10b6:408:10c:cafe::91) by BN9P222CA0025.outlook.office365.com
 (2603:10b6:408:10c::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Thu, 1
 Oct 2026 16:07:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN7PEPF00000097.mail.protection.outlook.com (10.167.245.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 16:07:50 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 09:07:21 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 09:07:20 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Thu, 1 Oct 2026 09:07:20 -0700
Date: Thu, 1 Oct 2026 09:07:18 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel (AMD)" <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jean-Philippe Brucker <jpb@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH RFC v4 1/4] iommu/arm-smmu-v3: Skip duplicate SIDs when
 erasing streams from RB tree
Message-ID: <ar6FNrZfN+ZXVtsk@nvidia.com>
References: <20261001-smmu-shared-sid-ver3-v4-0-06b34fb2e691@nxp.com>
 <20261001-smmu-shared-sid-ver3-v4-1-06b34fb2e691@nxp.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261001-smmu-shared-sid-ver3-v4-1-06b34fb2e691@nxp.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF00000097:EE_|CY5PR12MB6431:EE_
X-MS-Office365-Filtering-Correlation-Id: b3d96162-b21f-41fb-3ae6-08df1fd624d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|36860700016|82310400026|376014|1800799024|10067099003|260925021911599003|56012099006|260925022911599003|260925021311599003|22082099003|18002099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	3Vly5svhGAM0mU+1DJYcv0BpVJoG2d8ban/Ia6i/P5rQe3NdbN7dx8aXNIN3pqnhW7IRHafsU/Wdon3X3tN4YCc14efAdJNgGn/J9jeYhDBPJP43+Kowlt8A1RltSwrla159vRsNFqBlB1VCMlhyYmhbmgdZ2nYsjRBcQhAKIEtcSq/Gv8NyNH35yDbwDP999+1Y/R9YVvDSLUuMDKMag/iGBVsJ0i5MAE06YqVylxQWKd2sbnpz0dtWjDlSBJHa2rhs7vNU5Y9MvFBepAt6C4rJuUM/7d1/Amy+eOdc/UrR4blU6Mgh6fW5h31O8s6Srp434NHW7PXE7uazQ2Up3KJL8mNcTfb6JcUwBf+32PWvtZYuYGRmtlKLvjtwwVtnPGgBxl4R5OGKL+8RKne/fyXe8EUq9MMttM2qpN5Vz4bQ3FuGrwx6W11Chtz9L43MGaok13iBAMfkNSrAFMLxO2+GdbjmJZAy/9IZQ9FSh3CiRyWPbcgm7hQnRbAhP2aeEmGJGLJUZ8rbK9qrACVGa7EFkIqWBEmiv9Wn6wGAtiihwFlYFsc6NBFYG4SkCUCHEb1dcap28icS9XzcHswPsOF+LUB8Au9DRfH9OGWI2RnuN+zV7kshqzq1ykyYX4huwwb6sEfrbhkRyybbMdhWK2+ayVEsVr7judBiV8Zqw6Y1DlGOx5uZis1LxxUYZ0ex9/4cbuDDqS22O68769OMOQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(36860700016)(82310400026)(376014)(1800799024)(10067099003)(260925021911599003)(56012099006)(260925022911599003)(260925021311599003)(22082099003)(18002099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dXIOMtaM1NbiAjYhvKyo9ZNwWXYuKfnEZGHrp6VS008x/PaWCq7Oy+Xwit/i26DgVmB22BAMfWncx8wvKseu3WF+C74246IfGDhEntxG7cU+LFxiXlAN0PjgRYMVXBtTOz+h5meNlKnKyNl0M7Ta/c1L6mwu5pqERXLOH1donmjnW9Z3jnH2sg8/je7tc7vzLGrbaP10yMUq4IDw22UgNQbh59Gu8bj57z8L+Y9PdVbix5IBiuhdpyOtnuseNJINA12nOlWaDbO1OL5w4hR0fiYFr5vuvlirVjGl82CTrcpcvzdnP3dFz//uOVSXt0bAr2r9H5jIciq1dv36HTBYO44K25ZXeC09kaG94TSjGLZ8HO3eko44kcqs/jnZ2qNImNMD560sPkqtBgzz3V/4KnbCNFejgs5UgbrEDVzPnht+VwUIBWsn7C5DcCu12ef+
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 16:07:50.9236
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3d96162-b21f-41fb-3ae6-08df1fd624d1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF00000097.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6431

On Thu, Oct 01, 2026 at 08:49:58PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Bridged PCI devices may end up with duplicated Stream IDs in
> master->streams[].  During insertion, rb_find_add() silently
> drops the duplicate node when it collides with an already-inserted
> entry from the same master, leaving the duplicate's rb_node in an
> uninitialized state.

There is already a cleaner fix:
https://lore.kernel.org/linux-iommu/76c5f9dde30269995ef842a12a3a5e1ebaa3e6df.1790188510.git.nicolinc@nvidia.com/

Hopefully Will can take it soon.

Nicolin
