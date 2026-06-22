Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010062.outbound.protection.outlook.com [40.93.198.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213DA3655D4
	for <iommu@lists.linux.dev>; Mon, 22 Jun 2026 20:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782161933; cv=fail; b=PNeAIg/knFQCTLV8SlGwqAQr3MIp+m2+2N70QRzOIF0D6ImUioUREQ/uDA6m92keCTDvlmhEj6JNLK85Va0Q6b1/p6UqJuy4+3YJas+tKbQf3kWQ/QnR9lZIhIQJkEGUMMNNZotzKbZOd0beXcLDFxA19nIkTEURW/jiSaOmyJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782161933; c=relaxed/simple;
	bh=R2aJpNKorV7x46PryA3PKAp4pf37SVTI8lfTLhFKTIM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XmJY9Lg3+gfdeqYkcPgkieCb7Qdb8onC9HcSvc97ZffF8Wg7tt0VKS1ikf6rv0x5o/p9e4rRSsCTpOSwniHyKNN0PO/qm9f6bv5tPbt0n6wnO3i0KVin6MEzzjzVQ8cDjvY/ug2X9MXDqh+NxgMCMlUnoyL03d279lfHMYOapwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IpkE+0NQ; arc=fail smtp.client-ip=40.93.198.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IpkE+0NQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EvuH6+eDDd0F1Tt6t/byJB1Be+DF7tkNTplFCI2ymrBOqGGdUrsI6acrTAPpJWUtI8gps4YV2WdhoX3REEcC+CwlVGCNIV3jZpKBi9NIxtUP2I1JycH93TVUS8lIh5n1Tvs5j8NtU7bSEXYvc6RQvjJ0+TZlLfhg0j0VXHVmYTt0QQFA4WSH7N6U/pwEGaPYuL40NFyAYytBNmQCxHqQ3vvMY0rYg7RgtR4QD15+scChT9at/ZLx0dhoB5beQIXcDJ0K8GppJk0hQNxC5xONtfYcOhQ6KJM0IMZWKpQP/l7oL/vQg6u2BI+SpBcKzAf3/nMJJpvh+15O+7ni10HjuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UWADidc0sBAsQslnORXKgj1rMdd8ISSwcDEgA9dBY/A=;
 b=GesUokr7pD0pQ28/LT57WzjZETbaT/iQAQ1K2ooM388qNcm4yorAitSmXuumdlp1GFEyUhRAnB6cbKzpgBCR3FQW7IHcIdU7UGVmZ4kVDp3m4pBHadLT2B5RANIoJ4jlJhMVWWqA89fY4zPTlt4xLtR4F0rFHW+2mZsuP+Jsj+o182TGivF9aKn0fvQ9d2AXppdWwlLKve45g2ptt7ZnsIC6vCM0NVy7u8lPWHLlgCqa2kPPy/d+D4gs4TgDAgF4QwoOGpUYIYJiI16xtfrGYDffxFXGCa81JyB/MptUwt34V5BnAPORxefEyiXPA231keOIeBA+rAXijPLjwLCpzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWADidc0sBAsQslnORXKgj1rMdd8ISSwcDEgA9dBY/A=;
 b=IpkE+0NQfj9AgfFFzJ4vTQ/e5YiQfWpTWngQ8TJD5icmse96YQ5dO9b1OWnq34xVAv5yQVvtLm5xdNAabfNlm+atrwzMjXF1L2UBweXVpdIzT6TMj3cs29uegxGcmOSa0EK+Nw7GLAlq8J/vB8DKidBhcqOkBEgz95HU3xAPTaVA9l/wrfmhqR/tXz53YTfjmzpFwmPDRoVWDVcs0aiCJ4SV5mQ/E13bOPSgXeEJbxdc9lTjbIpxSxcdsdKmUraxqGXzNtKf1cp5mOqhTk36Pg58zQOVd2uGdhjeVdNuQdWQRAXNmg3ER/zhDWRAfvGNKGak+U0N16OqBKuJKEcH2g==
Received: from BL1PR13CA0213.namprd13.prod.outlook.com (2603:10b6:208:2bf::8)
 by PH8PR12MB6988.namprd12.prod.outlook.com (2603:10b6:510:1bf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Mon, 22 Jun
 2026 20:58:35 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:208:2bf:cafe::8b) by BL1PR13CA0213.outlook.office365.com
 (2603:10b6:208:2bf::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.11 via Frontend Transport; Mon,
 22 Jun 2026 20:58:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 20:58:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Jun
 2026 13:58:15 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Jun
 2026 13:58:15 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 22 Jun 2026 13:58:12 -0700
Date: Mon, 22 Jun 2026 13:58:11 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Ashish Mhetre <amhetre@nvidia.com>
CC: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<jonathanh@nvidia.com>, <thierry.reding@kernel.org>, <iommu@lists.linux.dev>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] arm64: tegra: Fix CMDQV interrupt type on Tegra264
Message-ID: <ajmh4/bnq8rB/eCW@nvidia.com>
References: <20260622065410.2780215-1-amhetre@nvidia.com>
 <20260622065410.2780215-2-amhetre@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260622065410.2780215-2-amhetre@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|PH8PR12MB6988:EE_
X-MS-Office365-Filtering-Correlation-Id: 523c8c5d-7089-4c76-9b51-08ded0a106ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|23010399003|1800799024|7416014|82310400026|18002099003|4143699003|56012099006|22082099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	qajlFOL7Pi0XengFgIm8aUkXpoX/AHnw2RF5hNxCUPqKDTxNwaG6NinEfWH8jBAfNmLNGoxLmpUsXNeQeUXBD7/6nsQAQvArqk2jN9eWYY0KoKPFw8eSLUDZiroFb9UfvM0jCkILq3nilo6T6WlQ6cLvBm9wSUoJDHPKKQi1Pzl3e07ZGdCOY9+3HxPWXTkdUCghUVYzAQ9wLJ+sdBnLUiW9TeDkt0BWzrRCxY+FaCD1PX5H7HM7KY4lEnJV6MeqiZYsNKunJJxZLSPZcHM7SlorxD1I+iIAEBU/6MzbsRwstmvfbMbbKG32jiub5/BvoZux09J04zrOOEipPvcAqMsb9n/vn70qGvqRqr2fkyNAKdHzrlEuVMXq3KUpOsnLy55RnxGD/XSE6+phs/0jCEWMYa/JFNnLIYsuPTBpbKnYnBmvynU3VWfCBfT+03JQUtSPpetL9j0vGhPYu56ciT/D5N1a1tqHG+pmv9KKZlUIUf0+bpqBa+LmahbzD2hLMG0MZX0c21xK+SkieopCtGHvExg0wZD0Gb0TaFtbyE01VqSoTmhUDKKWgV6ObY2AQxBK/iusRfiWAEhWFHdFm6EkerK6HdWMs2pBcuu5xDUT5Yp5O/CMBjvGrD3xLQU1C6TXAqWEF9RkzpqB8Xt6kyleUIm0VinBWbDdAxC3EUvOiv658wcpA0q5F8SHJdOr/Wju0A2xw6PcnWimERYPbg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(23010399003)(1800799024)(7416014)(82310400026)(18002099003)(4143699003)(56012099006)(22082099003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RQXeOmfK2zqY+PgwiLd8zGe8VmrfBl2iXpJgCfLGws1koUYha5HoEdpEl9XBOtgbk413VhLmc49nQjyPaSTusW5MdfqrOMZGPxtBvN4YL9hwfV26BsLwTcLeTjWz87XfKHFbSXnxb719gUQU+7bYhH9GnMV628XUUCx+PztqVSZ29xaIjfm444BQJW7s07/DlRA/PXK7dJjfuy54/YiPmlTXfrxz4aAXTZPTOa6xKWBbaMsK18dSUi4UVBRMXEXS4VM8xR/DBAXR2R8/n1VJ/1km/PSn+8KmfRSCcYJC9ctQ5XyS0o6PDmNgAinuoBPZcrd5zS95OK6Z8LnhSaupmJg59cDIKzbNBxplxbVhqE1FBaF7Mb0M9AlUhTZHNRoZyIrddtIjrs9b3VcPFcwwnCnJx+9FxFDk5TOncgs1w/d2Do8FbAq6bRuqzqLfeGOR
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 20:58:35.2593
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 523c8c5d-7089-4c76-9b51-08ded0a106ba
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6988

On Mon, Jun 22, 2026 at 06:54:10AM +0000, Ashish Mhetre wrote:
> The CMDQV interrupts on Tegra264 are described as level-triggered, but
> per the hardware interrupt documentation these interrupts are actually
> edge-triggered.
> 
> Correct the interrupt type for all CMDQV nodes from IRQ_TYPE_LEVEL_HIGH
> to IRQ_TYPE_EDGE_RISING.
> 
> Fixes: fe57d0ac4835 ("arm64: tegra: Add nodes for CMDQV")
> Reported-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>

Acked-by: Nicolin Chen <nicolinc@nvidia.com>
