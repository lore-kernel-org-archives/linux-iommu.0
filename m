Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011060.outbound.protection.outlook.com [52.101.62.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F2B2E736D
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 18:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779991575; cv=fail; b=FjQqbitCPheGieXHw+4VF8ok9v0qBq+wMgSUAQBbhbpR9PXu5TmgPVGQ1GfIlUlsWg0xSUQMxjQcP5QzxhTvj53aLZu1CNSYYExZpcUm3+uQIwikMjiS/ZzbvANiOR5A8bADEDYofQZK4Qh7bYnPFltattMXFePcEZ1GxVLjCA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779991575; c=relaxed/simple;
	bh=LKFBdNryOZF/4osum7IpQxEe5eNAB6mZjoGqewP3wTA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XUxfin2AFYNed7V2s2jz04YTrLFa/YdZAN6In3YF14eMTytswQo++bt4WxPqbShxdc3VdaYzkYEN9y3q6hsKDTwxO0saRcdicCgONRvYZbwi88AwTMAYhLIC05nNeqyZaMnL6be+MrKxf+hN69xHVH43BaXgk9HTl3GwsuKcO14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gSyBGsXd; arc=fail smtp.client-ip=52.101.62.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gSyBGsXd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mQ9ercHV/kUtVFedaJ3vPsnpeZgxpEPsA1Ryyuk8YipKvIPrpT0OsfQVKKaoEeAbrwOqWRoDPQTmxpFQZ3MPOir5z1I31kGHRSlI1FWaSxqKlyJYc6/gsLUjhAk5nEwuz86A6RYf0bDveb6y/LtgjBKanmCimE/ToptOQz/+ycmV3emREurqmHydAEwo6rENbErGcSCYiTc5sSNJlKigo0hdaKnpxyUTjoKBBTpeRO5dwoNFdydPDOiI5bHAspothzALih4e8wfVgfG3mjVLDzKwQJPrYJJNvk54v84Ug9/A/6+5aJHrs86wKpnsZd4Abqy0CPezh1BRt9lc+3qXOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jt7Mm5djX32rWYBrd+ccvl5cRx1eOBQ7obgUGvFboW8=;
 b=LSDSFrKP2Shzx70Zpe0EkUjzq3Czg834Em8YvMt9MqIhqbvZSDlOGyPx+n4f0cuoR5nK1i3KNieSK9hvdWGmO6KKDcOTQpMhkvchL6hneAo+zNGO6grqu0fh4HG63m6zc6MTJiNxZV4822Kq66KsBEW4dcQQYZLOuJn2r3+3y1WGw0DR3SY8ol3dorceBqr9A5212GwNCfVeYMkRgh0DbIuuvcLp7Mza+/ISTuh8PDMTwZdkV3sNQSBshiDjqhXs4t45wHJWPe1KyEMuBURIDGkt9PGt8u4JqqaQ96XpUJUNd2KDKbJLyWyp1GziwDHLDMGHzaOrnYjfQbCDUfTzxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jt7Mm5djX32rWYBrd+ccvl5cRx1eOBQ7obgUGvFboW8=;
 b=gSyBGsXdZrlonNFD66xA9ibO4E21RpirEW8ceykPjaI/C9xewEwiUcnB5mq1z8p0ekVrs8bOD/NA1W5rSEHRpwCyODxIfFHTVXiDUjQfwpex3ZgV34nGjNyoH02/vZ41sDxVEV5P+SVsKZxJfSRIrB70q+Lpq8AqTbU1WibtCnbcpJaHZVLLao1oKaaGrYYt84VM+px+VbynGizainT1hy3Jt56f/ZZTO9+4PSAD7j5aCJ/UsUsNe/I/0aicEIH/wqWdsq1A7UBIzPfPkf35ajgmqPWmdtwFMnZ8uIWeiVFgJ8qeRIbjY5UXOHiI5ZImGclUnsB5IDhLsH0DQEeWYw==
Received: from SJ0PR13CA0147.namprd13.prod.outlook.com (2603:10b6:a03:2c6::32)
 by IA1PR12MB7590.namprd12.prod.outlook.com (2603:10b6:208:42a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 18:06:05 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::75) by SJ0PR13CA0147.outlook.office365.com
 (2603:10b6:a03:2c6::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via Frontend Transport; Thu, 28
 May 2026 18:06:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 28 May 2026 18:06:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 28 May
 2026 11:05:46 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 28 May
 2026 11:05:46 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 28 May 2026 11:05:45 -0700
Date: Thu, 28 May 2026 11:05:43 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: <iommu@lists.linux.dev>, Will Deacon <will@kernel.org>, Joerg Roedel
	<joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, Daniel Mentz
	<danielmentz@google.com>, Ashish Mhetre <amhetre@nvidia.com>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v7 00/11] iommu/arm-smmu-v3: Implement Runtime/System
 Sleep ops
Message-ID: <ahiD9+mOTp8MHrUs@Asurada-Nvidia>
References: <20260527221407.1756491-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260527221407.1756491-1-praan@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|IA1PR12MB7590:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bdb8f56-cd7e-49f1-2419-08debce3c933
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	bubW6jdWcNA9ViBQ8nqJMXOS48/r3hmsUeBo134BFOiRa35IJ6kD4q6a4vPRUkmZc4CmX9LJDHEZGFZrSWEiorYM3Urxcj6DjsP27mfpZu4dFVFtzAfjR1nQ79qM2bNlnWdTDwj3KNqJiqun4R1frgiyJFFubAXCgfXC/hFjApjjVzcECJxJsUieNRQvq4r0K6yKwPwgVj2OCcBxD2aDF79nMPymVZcr8rC89ad/XAeRbNPejuqMt6DbDhdRKPU05oq2mCEVS5xnapA4+CbJh1HApzxFWb5rdqm8/awNUYa6UbNVQflA1c+a2B4nP2RqNjU6D0J1trSZ0/pXelOQNudfEOm8sPLg9Xmx/4JpB/WonVEpTjvhSFvnl1k647dlBCa9bnMK/PX56xYKTZCqGqt3nce1yGH5qpFkcoSgp2D0T/bgL7UoJ7Shf0hW4plQsTZ2hoNX0swZj7a+FtX9rKkSMlrWrAXatdCha8LI1AbWpnYvsrlnoQrfUNBmPhYRn2C4EVzqgXS85ZAZ2J05gpRTS+uSyJAk1sBSI3aMdTPmeKGQSihkNQWmz+qpZtTH6/+UeL7XQvAOvEf/A3BBaFvdsNMt+oH/SFW91Ejsxvj9nX+JvFZCunqqEb3wKaTzGZUUarLYQuKEcxO2Xx8MQJVVS+TPVgs5miktkM9wtR3+u3IexmZTbQucvqrzVcjpggIWK5D23KySNuHtRKPKtOTcMzgMu7y4pXbe+ywPCmM=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Vwbmot1OzVBP4zBFUSDBFWMt6rWPFIRAwttwSVFkS6ZO+TV8AQwSOYk4541d2sUKeWHdCZOaLcgeShjg5X7cAQsuKVo/sDcN4JJZCQcYXlVRn7zQhpo6QxyTyNxmuMBZq6fYsyqVQ3AKAJxp0RJ6qA0fCE/Kpo+VxTtxLZWmifpebuIYPSdBP41FoW75GnLQ9MufBlKkxBffsW8TyKPktRD+8NdL8xdANA9a8wVvMPPm6H7yUKgJEni0FvHfWq2LyKmEgR7LrurkCxbk2+DZ9QyIK7L/yGcyZCqAysXRVlPCXGrMoThJqXj1OQ1vZKFsmsEDqAidPSucGKhNhoQfcfP2VyHCWvjz8bWpWLq9yOqPPWcLvcoZMCoqH2X97Bihb1GZfXE1oFynWLXAes/FM59kWZ26zaTs4XngNbni8uXCzJfMQyavXY6MowPOMsqN
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 18:06:05.1919
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bdb8f56-cd7e-49f1-2419-08debce3c933
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7590

On Wed, May 27, 2026 at 10:13:56PM +0000, Pranjal Shrivastava wrote:
> [v7]
>  - Rebased on the latest arm/smmu/updates branch (which has the removal of
>    struct arm_smmu_cmdq_ent merged)

Sashiko failed to apply:
https://sashiko.dev/#/patchset/20260527221407.1756491-1-praan%40google.com

Let's add a base-commit to the series and see if it would work?

Nicolin
