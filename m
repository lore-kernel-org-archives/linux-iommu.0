Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010069.outbound.protection.outlook.com [40.93.198.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D88818DB2A
	for <iommu@lists.linux.dev>; Tue,  2 Jun 2026 00:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780359373; cv=fail; b=C5tUgYySUS0gEb5SkQtqXlHbhmPkalQbY4WL+dOorvR3dXm3CiMGNO4oXDLuRjDcbD5Cu+6+dGNxDwnARridO6uTbenME8onRrhMMIiOD+1ljbF0ZQuEnAZDvpzZgqG/+mWzzV+vGeBbhXfh2KbvP4FCF8ZsWv0+/4C//amxU2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780359373; c=relaxed/simple;
	bh=EC/sREgwUjnzWcCl2eJKkeZSDB6AX/pQDZcReqQq3A4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mk76jtrfmKLxp6cdEm8dqOGMl13A5vNxHbTU+R9283RdvBUmJ7S7U6RbxmSRspCSlj8cEnmiqD1mGVRkynZHYAWrb/jx3KXTI0kyGJL5PPi3TCdcp3snfE4gi2QyeQFpkNHrA49FE+d+1qwKWieWMmVT1npLvPoyr/u1R/IlJzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VeRSOkoF; arc=fail smtp.client-ip=40.93.198.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VeRSOkoF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sg4gh6TsgcoXeIo+CdNi9gY+bNCuX6bXgAG6i3p5kdVFoFkQbWV6+yvRE41TS1eU0R/fdqBelfVgyJYkouNoiRxqPuE80QT2RZQz4qz6Puf0Z1HbbXwqF3Xja7QEYPKeVThncu3s6t5pLmK6NTTzIC/5BuLmjTCgr5PcdLxJQHtbOTG7jmZ2OS20XUTP3t0/NmNB2OpAASumcYITCgEwsRMRDBI7fUA25DptXTtewZ1KSstU2RxR+RBIW1eAoTo3UipE8+3L1nwIDxDzss5HP8hG/k7OwzmVxvrVJ5Sd5fuMwSn3yP9qvOBtBcOEEV6hUE38xrEJEAEhDLwAMFL5fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JLMMCjYsDYeF4ImDrxNPdr51tcxo1/GyPSOARceYvfM=;
 b=L/IP0vTYkvSJZE6vX7MwBlkcZRcyHK9uryuOBA9PGlZdaGJrUVp9DdL05V8ruJQxu6MCN4chCh5ClwRxWQWyj4z3S+tgq9h+UUwVjelrHCzU0Eyq3h6js6l7nPGtav3UX+FSFtd19IfXZuK8lB5oH6QfwHJ/QDaz8KrbMu6562RthJiMqNppXQOf5zXjvEAMO0tTl93XF0TKrbiezbpwgu8GLy9IwU4A2xveSPbGmR6GXIf6FjIEdevEL2jdWuL3ZBov+PmyH+OYCh8PRzu6SzzDlimTZC/mRZNS96ahFRsUZ9IYiF/WtxtrWl+iE8DtMpDXxhjHcUgz+zLb6RsoCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JLMMCjYsDYeF4ImDrxNPdr51tcxo1/GyPSOARceYvfM=;
 b=VeRSOkoFspmR4zGIRknnWeYY2xGSMb1cgRCahSy5FZn4c3yPlBnQh50esaokVSrHSRs5cmVbH6kXL31oPHeksmxpm/5rIo9pdhxfoDokSws4oGeREZkAuWRYYSN12UGU529PALlQcK0I//G1GpLd0PfZMrrqdUmjm5ZvrgnRaVquWKFrVadLR8B5KTqReDIV11GHTUQc/oT2FONkJ0S1gGoEc8JxRx2+4fhybh1YVXqhPGgqjkiDXTjTknc23x0xw90WKdVIR97BiNeQgX9zC3L8IaznOtj9j8HK0oCS/+ku1lnn6y72PgzTkp1VrRR48IVSdlw+brBMb/HKRFkuzA==
Received: from CH0PR03CA0238.namprd03.prod.outlook.com (2603:10b6:610:e7::33)
 by CH1PPFC596BECF8.namprd12.prod.outlook.com (2603:10b6:61f:fc00::621) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Tue, 2 Jun 2026
 00:16:06 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::15) by CH0PR03CA0238.outlook.office365.com
 (2603:10b6:610:e7::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.14 via Frontend Transport; Tue, 2
 Jun 2026 00:16:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 00:16:06 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 17:15:51 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 1 Jun 2026 17:15:40 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 1 Jun 2026 17:15:40 -0700
Date: Mon, 1 Jun 2026 17:15:39 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: <iommu@lists.linux.dev>, Will Deacon <will@kernel.org>, Joerg Roedel
	<joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, Daniel Mentz
	<danielmentz@google.com>, Ashish Mhetre <amhetre@nvidia.com>,
	<linux-arm-kernel@lists.infradead.org>, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v8 06/12] iommu/arm-smmu-v3: Handle gerror during suspend
Message-ID: <ah4gq5NzuW90OyoS@Asurada-Nvidia>
References: <20260601215909.3958732-1-praan@google.com>
 <20260601215909.3958732-7-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260601215909.3958732-7-praan@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|CH1PPFC596BECF8:EE_
X-MS-Office365-Filtering-Correlation-Id: 9233e0ac-ba18-46c3-aa56-08dec03c2404
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	8uF7annuS0L3+bE4FylVs/PdSwmlZxFY/3TXK0OBEp5gcdK0WrWIpFqp98P79+pFQ8UjCEhi7BIuryx4t9+xv8wlqzH7ZTgXY7JXuFTqIAl4wfFUFqJgx/bNC6mQLQugecBuqgpbftBOxtQZ9nQDMX2fc7E+L+r2T6SEfLeSgMb/aDgzfb52i664h1nufLsgzItLm4aNUG1/Zm4sQAoZjt/x4EWwpzITT2l3SUVVZsx+AhY5UvabD3AFNeC1rzcbXftuob7YtW90PHkOiytzHTysVgW6LnIAku5oxVkqrAymx5XmGPMkhZQ3Z8QGwXkZYNx6GfmzcRnBpwt+ILUviciHcllW2nYIYwnTDExEamyjejSWuIto4pILzPqeYfiw2TkLOUwEGp0/494fuXb8hjv2Dul5TPfbCtBBhAkfGTYGyVDoOrpEBctXMSTM3dPli5Xdw3od1YuUBqoY2PnrsjCZ2xbCnvDoFkpHmX7QITAYd/TK2aItHcCOO59B6LQ/YAvRCw3yLhMmtlbR2RIxG4/pZjxqlZ/UuOnYJQL1D7wbMMYH9Wtlayz1ptrP/fACJOK8fOZRfa40odN3z5OMrt1CiWue10vM5Q8pdhHTtMWdRzgTJTR7aN/h+wIVBLoQA/mDshx761mdW62wroSVPmbMOASFP5JbocQh6nmICmiRKmjGT3fAVDbHgRPW/XlIHHynbZ74xZ/AREEymVMq6JCNELldi+QI/cCOw+wJVw4=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eBsBcDHBf9VQ2GQGK/54OCDULOAYDN9ehjCXVH0q/E7LlJxPYL3qaHrE1XSci/6+OTJlFNSziy2Q/xZSkQMglh/3D04KK8HInskGsXxcZ2AXdofHP4unvEZNFDnK/qjqKIPenAVSoBo1gwVN0BIBaS9ZHlccyvdnzSmVmasGgYzzboiGl4VLY1hQhR1pvKtoHzM0YUu02Z8d1ZlMjALD78h3dNG6t4XfZCyL10GpkaIG2MFpv2m+4+rTAogXEHq7oi2CX3gAjFAeEG7sGDms6ucnUdChSCh5EuXvC3hmzomPCziWRgdz0p1Hid+SXXwj5C5xvJfMlLp/+w+SfgE0Tpp2o8FSI+NuGEFw9xDsffUzgl+aaE04yh2Bd/rHuMfW9oGuAICWDgVEWGpo2q8lmJVgr1guvDJCoBp0zbxZZIfMLqMpi6yzp/Ez8m6so1Bb
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 00:16:06.6792
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9233e0ac-ba18-46c3-aa56-08dec03c2404
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFC596BECF8

On Mon, Jun 01, 2026 at 09:59:03PM +0000, Pranjal Shrivastava wrote:
> @@ -2300,9 +2300,17 @@ static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
>  		arm_smmu_cmdq_skip_err(smmu);
>  
>  	writel(gerror, smmu->base + ARM_SMMU_GERRORN);
> +
>  	return IRQ_HANDLED;
>  }

This seems unnecessary.

Nicolin
