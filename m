Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012016.outbound.protection.outlook.com [52.101.53.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9697F2EDD6C
	for <iommu@lists.linux.dev>; Sun,  5 Apr 2026 00:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775350560; cv=fail; b=AtPSveQXb1VsU+ZWjAzUYA6lHfYV0R9KwxjdrqjbFQxGB4D3EILb3QHtzukaaJl9oWG41w7BDIdIs9oDxWcBYQkFQvqttDafqFkYihxVrlHG8Hh64rLvWEhJN+p+gabDZSakx01L+X8Ol1HhFamaQrhpQxsldQmkbn3ZS6iLZVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775350560; c=relaxed/simple;
	bh=31EkdG5e2S4ym79TTufzAUraKbe85wa7quEzyYY4VwA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MDhN2CRzTw10PE/bmLOSSfJ5cW2mfFqtPq+LDGB79rjSHoDXbXu9qxNl3iXusQlGWBk0MuWrTSPNDdt/chMojLUB1cDLX1CIOmOlEkreNQn/5CFqyEeh+EEpQstF6nNG8f5HZX+bPQZdsOmEcUYHENqsrSuwMkkS9cVwEKF5ZJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K53sdIpD; arc=fail smtp.client-ip=52.101.53.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K53sdIpD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MkqpY7/4W/7pMeCPbZIj4E0fssTKTgO18t3mNYChfyQ0sblOW7EaHBOqMIUgNebgJrcwjrCLHeE2DGh6YG0HFoEmZrAyC9AqH76By3irCggDSgAOqpl8Rm+bqizjYYsLU7TsmDjq/leQh28bf4slXxKQ7lzcHxp3zPKCM5T3DnlOqHqATSA1j9oeT9/H++IKXv/2XXP0b2t/CqnQ6AAJSKRj1drHq8QH+hvugD96RF3JE2WUyOdU+oiK1a5URnmOOunsPxz0rYsNqroSCM+CBaJeeGMLM2HETGAikYQZK8BdeHHVz4PQ1bxj1ZE4rGxuCUGTi9PRv96B0bEwnYlAOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NquU+lQuWEwpavlURv6sal1qCSBNX26lSwZ/xsIybWA=;
 b=WlX2okCGl2EHZQaTOk7YVxyDuVBKGxE8rOq4eyAKx03DnDfR4NH34Ny6WxN0A6JDu/zmuCc4NDsKhZwPe4GgV7iiX64MiYXRHtsH2/ntW1lUp6ZCuMycjG7FYEH9xtNjURA9ondeaRaEitLtxwQWHKXORBVHIPTUbmfzzu9sCSX9bToPUSaP5zwtnhfpurotOUUIz7bSK8R0CqaImFL9XP1zBaH1+YxQMrQGcLfVYHeimOMzHi3plOcgFGZeulwSraQzTdiFz38tmihWGV90ATsXL0zr/9uRPaMJeC02+6XWwxgro/onuSN+GmLqeUzz03y6qDBUxgal5+2XfjswiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NquU+lQuWEwpavlURv6sal1qCSBNX26lSwZ/xsIybWA=;
 b=K53sdIpDfRGBGBH8Fylsdz4BjQpe4AZs34A501mLTgQgtTk8/K0rrQ6e/UIJldcJRA3XO27fvJ/XGLnVyS3HQN1GBXixNp4A9p5Cg0KHnrlHRz6eqF4eCrma1fumu2WR4G6Vunmt+Et5vmP2GR7jhjrsyyu/+EHvum9Hk3cMrj9eVi90blpjamWvbjTdawOesH+j9Mqe0BUCnLQ4iyACQiCmrTQFTDAnlbZ8MaBgQ3j6B8xl594/coB/gYViV8zBlcd1cKESENPUoCQqlUaYTeWyeFZSqOFsfZE9B2YIt1FyNIcycg8hpnrsndySIBguxTv+7SlQpyK8o/113n/Seg==
Received: from PH8P221CA0065.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:349::13)
 by DS7PR12MB5768.namprd12.prod.outlook.com (2603:10b6:8:77::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Sun, 5 Apr
 2026 00:55:52 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:510:349:cafe::e1) by PH8P221CA0065.outlook.office365.com
 (2603:10b6:510:349::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.31 via Frontend Transport; Sun,
 5 Apr 2026 00:55:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Sun, 5 Apr 2026 00:55:51 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 4 Apr
 2026 17:55:41 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 4 Apr
 2026 17:55:40 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sat, 4 Apr 2026 17:55:38 -0700
Date: Sat, 4 Apr 2026 17:55:35 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <joro@8bytes.org>, <kevin.tian@intel.com>, <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <baolu.lu@linux.intel.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<xueshuai@linux.alibaba.com>
Subject: Re: [PATCH rc v5] iommu: Fix nested
 pci_dev_reset_iommu_prepare/done()
Message-ID: <adGzB1qLGQqTJgi/@nvidia.com>
References: <20260404050243.141366-1-nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260404050243.141366-1-nicolinc@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|DS7PR12MB5768:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a4e4c73-6383-4789-533c-08de92ae15bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	iq4CfcWNMfy7WWUcPSs1b/K7ehEIsQ1Cz9Jykzp8lr6FBEbpEdRJ0G3ovvm/RO8DpwZRNpv9wlo2TppLo7EYNIy9IElYv1cL0C5K1bKr1lCpfGGOAA52v4LRpAC/hwpqXyXg5WfzpWkbes+2yTxrek+Wu1qK1CRMYdatwb3JYb8QZ8FMiThtIt7c4seeKaUroZOuJDz/4hkgjYUAO1WzQB0bhgF1ecw7ZNYLa/Sr4eRMo5gPR8yFwf3gZXfY/UCIbgnhJWedcnJYJxJ1X7H5wJFEbuzNOXXwIAw5wAJQ+ma/DdKZm9s8uUPGO2/XUTDpCW2t3BjRS2SgfCj+Gilky1fn2tvitQDqLVupnJv7fvCaTWD9G+UGDTaGalXKdHfyDd8KebiTkKcoGhwFlMxAvvEr+ggcV/BGFc3qdsMduSQy/fnWCki5dfGqW3E4osYMSKgy/eAa/i8G4AfuR8dgWDPlx+Glb0/dkP6VmTJVEbzJWIiT6cIA8tZNSPl/GoUwo1olVp0BxLxokcbISzoRWTTf4dY4veJ09u6EAe7QxpCv05JHsKA2xWgOuHmb40J6vsac4+hyCkMzFdlCKwrcdRnEXY9qFzH39se7a6dXsSpbTYtLQsxa+MC7jeoGU1LCXAo+9yofD4jeaYT3m2AvcK4WS82OvzgsorzcyYOLulDza2igMP3hsBDp+oVyPJ25sxy0rydgZkn4cmBFoVklLoDUpo81oi73ZPUv0mL5dN9Bnaalf8ChCWfNeI9tBcFxkgm5yy6Lh9JBuIHNKP8x9A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NPRIJuOTr7nnSSQ5EcCWjmsAgGOWZYx2ICNrUYXyN/G+Zyw6FTyV2dhH6tWJYnyyDJDHp66n9zk5J2/PYEypqF2S48FGDL1lN2/J6zmzN2PjdJ1Cn1g2KkI3e6UofEC+4pGvNPtfQwcyUZojvI58sB3xYSX7i+fGkK6zVrmP4U3+qfiHBxi2KHm7NzA8YRfMSUw1VxF7zvcRJ14OlUh/Brq/cL08HPgIbCEjoXecG9odB7lUkSz5xTa/H4itMhYxBEKXpwsWcwa9Sl0qFh8UnwzKHEM//7YzTecdyGqVYxIAI5tNn8cyuCNU7gYLA2talqe/ycFhb/Wml8HtHqitegp44vBucx0Bn2XIZq2/3tKE5Gw2ibJAv3rtDaBN0phWNYBdxbECkM9y5Yl9RZqKTo6/gAz8/vq87qkHlSrCh1IAp6Yk46AnYfyOieL8tv3z
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2026 00:55:51.8613
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a4e4c73-6383-4789-533c-08de92ae15bc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5768

On Fri, Apr 03, 2026 at 10:02:43PM -0700, Nicolin Chen wrote:
> @@ -76,12 +76,28 @@ struct group_device {
>  	struct list_head list;
>  	struct device *dev;
>  	char *name;
> +	bool blocked;
> +	unsigned int reset_depth;

Perhaps I should have mentioned that this "blocked" will be useful
when shared with the followup series to flag the device blocked by
an ongoing/failed reset or quarantine.

Nicolin
