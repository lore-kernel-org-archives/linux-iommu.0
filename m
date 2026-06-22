Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010055.outbound.protection.outlook.com [52.101.61.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA186337BAC
	for <iommu@lists.linux.dev>; Mon, 22 Jun 2026 20:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782161604; cv=fail; b=ibUHg9XXOkIq4B1yN8fid8Ax+LNZ383Kznue2bABvzIAcTVm7QdPdJFCP5iRhvCtfmC/FkPVjyGIqGeDEiK/J5fR20E9b3LzeDmbHl7vAuVMEVYIhERQDlUP+RXq8auaNuOUPlU3MB6V5H/30X+muu7zwLdfa/NmplZ99/+jVP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782161604; c=relaxed/simple;
	bh=ihdQISteAhMw8OHVx9SRcQ6m7XViU2obo5btfIAzKfo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rkxKaKEyktOS35s0YizK++G3eT4oiKirzh8sHXjU9OgEuqc/PQ7+vkmsdeEEu20/OYL4yigNiOkzdthG6oLrSiR/Bd44G3Qy6mF/o4lUCe9JCtpHenPTDAt5yLS9ZyVZwSr2Ki3/nCbnoVBvOEsUByLbRt8oxC/wEro3lw0T8ZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oT1Mcpvk; arc=fail smtp.client-ip=52.101.61.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oT1Mcpvk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lq5lIXk9Vb2boEYWmRO17HCPNJQkm02hKYrXp2fqNc9m/fD4OS721BEwYXsJ4BrNM9XZlq9IHO6/7+7dbZCU3yHV3zfhHOZmQmaJqhFl8yUZaMakTULYWrngMdctLGzWdhrcj7yEOG7WssTrILDw2q9bsjmRwSrocv6ykerzXIujKxBDoz/y2/fMPQFejt0RV1aTyBRhXdGAKOiHsIxV2Ort6rkx87RszyF4YjdJMI+yA5LZbqobNXiC427/7IgbMemk7YAdVKzjn7W9oxCzWszZpkQRnew3viLT/Kinhlg0mztbRRn3QJAKzdZydHaQFAKVOJaguE0weB/5laFfsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kkP/+vje+t/8D8XrwWE0R3ArA2HwQUf90ZaUTMgl7fk=;
 b=kXvIeL088dnikkq8nCazfNS/tJfLx5OQWTPGk9JLzU3Wo9UATgOP4wD2O09iVVP/dYRHC1PAjB+kETkSHGrk93WBdLYqR4wEGyFHRguklamvYLFFzPc9hMgLLz/SLM/y+mDI+Iv1BImlKVFcXDSED9669uYGiyInAN6sn2DEplRTT7c5MiAUmH9tXQw9bL+KZzRb5oV8WKbp+lvxJyfSlDcwf3ec2REqTFnkti5k8HN2/ZRycypNDDT6zn73AuAz15VaMmkkNXt9P8Mo6X4PhWPe3VzPvkvvwcMlUXqfu+L4MmfyvUX2tecGiXanxzVj1nPVsbs5b8bfwk09FQsO+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kkP/+vje+t/8D8XrwWE0R3ArA2HwQUf90ZaUTMgl7fk=;
 b=oT1McpvkG8qMU3bbQM+xpww35fkkTN0y5o8dDkj3JWBQMG0NHW9DCkzQV5NguqoO1UDbqBo67KK2mVjXZYJcyFHNu5tMovVLgI+j8XirawI272nn2bwUiCncRStvQvGBb7hUAjJVSEnTO2L70f0C/Lpj017BTKA1x3641oPNJoK1yYuiqDGYtbB2/UCRZLoOokg9AJSptXbXw68ozXHHy0RGCpu6R4fo+U+X3XZnt0bX9K70zU1Y+y3Mlzhv5cQEL1JRNaFtJ/bHzi9uXp6l+8zsJtUHGp/VeoPVCFHA12+cDEVWx5eFzlkLo4gPiD89ma7DRjyUTEPPcFOweyY1mw==
Received: from SJ0PR03CA0034.namprd03.prod.outlook.com (2603:10b6:a03:33e::9)
 by LV3PR12MB9233.namprd12.prod.outlook.com (2603:10b6:408:194::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Mon, 22 Jun
 2026 20:53:17 +0000
Received: from MWH0EPF000C6191.namprd02.prod.outlook.com
 (2603:10b6:a03:33e:cafe::18) by SJ0PR03CA0034.outlook.office365.com
 (2603:10b6:a03:33e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Mon,
 22 Jun 2026 20:53:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000C6191.mail.protection.outlook.com (10.167.249.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 22 Jun 2026 20:53:17 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Jun
 2026 13:53:00 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 22 Jun 2026 13:53:00 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 22 Jun 2026 13:52:57 -0700
Date: Mon, 22 Jun 2026 13:52:56 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Ashish Mhetre <amhetre@nvidia.com>
CC: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<jonathanh@nvidia.com>, <thierry.reding@kernel.org>, <iommu@lists.linux.dev>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iommu: Fix interrupt type in example
Message-ID: <ajmgqHcbapz9lPg2@nvidia.com>
References: <20260622065410.2780215-1-amhetre@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260622065410.2780215-1-amhetre@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6191:EE_|LV3PR12MB9233:EE_
X-MS-Office365-Filtering-Correlation-Id: d5be43e7-f527-4b8f-5943-08ded0a04916
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|7416014|18002099003|22082099003|56012099006|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info:
	mXeUrsSELpv1neQAzBIn1ArwuytRaHEl6mctHCP7PkeNgVAsnvP3HBTv0bAJn+38iGxADCemWNqEvd2dRLMrQLNLzoakKRLlUfgAJyRiLlv+wmaTCzlsMSh+3I/6302WTZ7u7jv1TBhLJxIiXg86L8zVb03hV8RhlMfPEEWRpSMxUvO4W7JUoUCJ9HDnZ1Fgz5ByKftvSkgNgN8sfNQA6abvA8nqNVl8nClqUAziqFE93m3rLHNwpj4WhgI+y4iz0WogdXLnu83EHczLgyCGcOJKt3/sZy5XvNAZNvAKghEBr902pTV9eRnw47403dG3Du2614JDnxTo4EbUxzGi0BYia647wW5XUHM8I53NG4qEyyJO+f+hQDBPd8oN1V08RSBXpd9qLh4ewucqKiAqN24wJpp9CskU1QgRnJfadOwp7bzc4Re6U99q+8oIHC2lW1THq0aokDgz3GtzXZF1mf96B6ky44HgGynrW9MXOGqNaVDjCTuKw/JZ4z20i7xmgLCBr6zSqriNBzjYaOrZq5JE0B5kS+99+Q6PJzFg7HXMtfMcL81dMt/KhwVW3xBQDCoBucB+UZVrd3YOXO4pnLK4bpL1Ru9FXjKrIidARQeR41TxtLIEjNad1UbP3NY6vaj4mCNXEUlH1rzHmoB8UeP1dgWEp2PljDVBxGhjLTelljOjbQ/pkAaNcX9a9oK0MAikzgWsYTgAk411s4rrJw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(7416014)(18002099003)(22082099003)(56012099006)(6133799003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0kfg1B49iLBU8/C5+UXgoHgEFN29TVyWID0ugyRy19H5j590FeLDSXd3lA4AKzPZy1eDEF+8MTZnfj1XkegtIyYYSpYhHgX+BvGF49nY0gxr67nzjJC4uvuwcq5kStw7qJOyi6Cx7/FxfpGXKnYnLWdRlDHalTSLwLFEWSn0OxGi5nNL4GoZbwK5s8hdYg6bE5XCxE6j8p1xvvxdD/2gC/AyH5D1Tx0MtWZdON26RadI3M5+F/QMMRHx3UOwILVLO2KoIcC6FsM8zXGzX+ISK+XteVqDUW3PgNMXKZwplLSDLYaxCdhpTzVAJDQBD/NroUbgmrG8kq0JbrCq2FyxEsZ1nVAEtpGU0iEMa1Z/mA4h4N/kNa8EXItJqqa8R5MDx6OE0CX6prjf6nhc8NVmJuk2BrPqV5qa3XDNPz8UN4eCbRre0Qp1Dl3x0oCAuXJ3
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 20:53:17.1716
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5be43e7-f527-4b8f-5943-08ded0a04916
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6191.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9233

On Mon, Jun 22, 2026 at 06:54:09AM +0000, Ashish Mhetre wrote:
> The CMDQV interrupt on Tegra264 is edge-triggered per the hardware
> interrupt documentation, but the binding example describes it as
> level-triggered. Correct the example to use IRQ_TYPE_EDGE_RISING so
> that it does not propagate the wrong trigger type.
> 
> Fixes: 8a59954192eb ("dt-bindings: iommu: Add NVIDIA Tegra CMDQV support")
> Reported-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
 
Acked-by: Nicolin Chen <nicolinc@nvidia.com>
