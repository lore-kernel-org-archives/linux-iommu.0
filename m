Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011007.outbound.protection.outlook.com [52.101.62.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DD22E737A
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 18:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779993399; cv=fail; b=gDL48tcaobzjMFqmyzqwHo5Le8Hopqpsgif95vTnZOgKIv2nAmgvHG31K7q1CXVgLtEUoYcacQBPO53Y++nTPUO/6vKvC7+Mm+4rpfI1oDcqO73d9mLq4fEZNhaDz5DYJL3HTas9MiaZc8gRt72sRkUsvSjH73N6fzMoTNiDs6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779993399; c=relaxed/simple;
	bh=c+gnhNRyVEOPZe8Hlg6w4WCTpInEBWEOWD82CnlSDXc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FoQCZzsJ7CNEY3uh6PlIIC1+TxmJWKFnCInm2Mj1ru3DxvFykAmi6OUHsThwL3KbXMzCVGiUSgJMhC7AWFimzceORnn8B8Sii2us8Zqcxqc5w11f580k/N6hC9V1qVRL/1f+3L0dH7SdwenLSZyaRwhK9gAOm/0GggCA7mtEaKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AUqo5fIu; arc=fail smtp.client-ip=52.101.62.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AUqo5fIu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nh2b1Fo8u7dwo3iDUD2z/9XIWfDGRlke++8K/RTetQxOowv5WEF6S8JtXAxfpI8soQp2icKuxI9jBBq3XwFl8xa6K/Alr5AOnPiE1E9tkTc9O3PfHMlY+OwwcnXByGcTqfA47qhPNfGT/hMg1/0t+XhCTdSW7hZ9VEEH0SXRqr4os4kH5pRXlpf8SCs9BlObHZ1qKCcp3iKPX41l3nFk41/ZLZz55b9xbOtk3EX3Xdgq5YM+cA0Vs/ZuSEl5AXAGabgQAS5DGxBgswpT6eVUiMZdLCAEguZ2vLR5LDkiVm4Fcn+3fL6kBGFTmEa1NosUDnyCUF2wPphE6YKzAO9C3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I3malOq5GNEotadrThAyh/wMN/bAxcEwrXnyq/U4GMg=;
 b=Z7HI8sd569ZDWxDPYJK1uq9tkhl9N/qegcwHLoVfewVvWLyqYnqSbHKVU+FjlRDPrya9MT2n25RBd2fuTNgHxB/gFE1rmaivMUwTNrd8CFetaRMW8hNY1ZW7camFQv2yM20wjjR6WljWCJtoSFy43V++6TQ7Bi5en3rSCrY5zmUptzHZaeC5L95HXLK8E7EGlRxdi3+NWeumI2BDoCiGAYqHq0Yv04WIaM9Z9UYthlbVysDgJaers9zZg1GHFMCuCr7dtmxkGUpVLD02XLeLtS7C/902ekMK4m0YO5BSNCBRQb5nlAY+z8HoMFErIVEzkUUR4mduB6+ATfIwfJqAKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3malOq5GNEotadrThAyh/wMN/bAxcEwrXnyq/U4GMg=;
 b=AUqo5fIuJdmzXSYjtBCGrn83B8lm9NJ8oDtPDhszvuM/Mn22xL0cUbsc+YV46JcurArKj7ERv9NNiBygnj0V695okIBTTwEOCUNcFgNVvnXUMVzVHpBA5sJtytDIIK6YsPNmieexXbC3PR0MPdPJIx/sqljNAIrVf+FMWLC7j6nfgBpMMHy5Jin+ROv6ouvu14kBKYZBnIiq6n8lp8Ibrs0KFNUymtoYwWZWt0ZV4wfF0sdB34H0zNpLMYsNvutKao9LnZlSGtdwNVi/RoBHCRR8R7IzPM8fPhd0gU4yzwoDRJ1v/1yoxAbHiHxJ4QpLwTvgaIEhByRRkHY8fL5lSw==
Received: from PH8P220CA0015.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::23)
 by PH7PR12MB7233.namprd12.prod.outlook.com (2603:10b6:510:204::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 18:36:31 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:510:345:cafe::4e) by PH8P220CA0015.outlook.office365.com
 (2603:10b6:510:345::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 18:36:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 28 May 2026 18:36:30 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 28 May
 2026 11:36:08 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 28 May
 2026 11:36:08 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 28 May 2026 11:36:07 -0700
Date: Thu, 28 May 2026 11:36:06 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: <iommu@lists.linux.dev>, Will Deacon <will@kernel.org>, Joerg Roedel
	<joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, Daniel Mentz
	<danielmentz@google.com>, Ashish Mhetre <amhetre@nvidia.com>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v7 05/11] iommu/arm-smmu-v3: Cache and restore MSI config
Message-ID: <ahiLFoRk4xaxr2vn@Asurada-Nvidia>
References: <20260527221407.1756491-1-praan@google.com>
 <20260527221407.1756491-6-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260527221407.1756491-6-praan@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|PH7PR12MB7233:EE_
X-MS-Office365-Filtering-Correlation-Id: ef8cbd90-52be-447c-92fe-08debce80969
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700016|82310400026|22082099003|18002099003|6133799003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	DvsflVmzPcDEVp0utNB2sEkGy2VQO6ftJRt3AIEPEjzWjh8twjP4MwNwGXFxAucmgb/xfXHjHqUdNQOs4RYX2gwEy0SAhZBRXc/jG++Bn9rafpHo5S8j8CFghKAnswvZ3e16Zs6b6uIVKyJv9nV7RywJsvopTpQ5MPYOLOIhnPfT8/HaJJ25r8kxTTZ8OUvscr88fN1QgboIsb/xtEgpozwT1T4NVAheP5rTHDyPdAm+0MCq6pviruZNX9x4SvLzwE7JneHKBl/NF2C+em4USs/7SUIPtY1Zf7j3oXwtcgQsXJxR/AXmrMljsRse0dAA9zyhaQCHblJBCnIpNU2MCDgoufmgJ4zoDeNJzea/dXjeHWTo9qopCGqW0EHX5K2UWxipe9O4mCvihZj7J66v/Djcofd44yJtFtfclpidp76jbaaL/C57y3kEsXMCZ60rcDBeTMt4g36J3tm4/UeUYMQxNpbBRxYkvD2ZMZPnp7yJr2utQZ2YbfGSCouhdqwQCUswRWP8Ixz/RkLklfyeuORAz00JrCc5q6JEhM/2CTzNckb+7qJR9z5NVyxdarA24nMpVYZn/dGIge8i9e3Du2pfTCOouvn8A8FbdyuX49rEB4kYoCY7KhcaXO8iov9KRw8UMIARe0Xlqs4FUfiJlLm2DGGVPSGjKiDrVZcYpB85qIm6IhduNpHWb5su2RuwB9d0rNXgRXlfT/028RFGJt/5/dsu5f6aw6mAQs2rpjM=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(22082099003)(18002099003)(6133799003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JodID9doFAAtg2mmsXXtvxownyHRK9tY/IFnwfhP6+bIo4jVv4tpPm79xrn8hzpX8nvHCDpP7OBTgigj33Cku7QpwDkHDCtkTc6OPlAien4VQSQ6cgv4zwub0gi/H6ZSqDEuSFuklCFj9FebAbVWurx8nzCqfpogrd/YKfUWtnXGQToiAmewFeD0xZQzrhBSjmmD2ArDoG2d9AloxBaEdZNtucQ6+Hdc4j5p4S6hMhiIE/Q64rkVEDGA4ODssV05L0un4gUrVcDlIrYMp+3/qN7UaY5sICwFvNO14XMT3U8wG22dZa4B4Ax6ff3wHK/qzrfIYubZLNc4Glz1pHTQB0I8oRhLjEPlTyVBxOtb6FTZXGL2mrpL6XfPWkMWiZUZ3EB8iq9r7dsfc/ge2qIpxQl4ARQWh8IvKAg9BHLUTHepkI7bmKAepVtYZGSJ6N+7
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 18:36:30.8395
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef8cbd90-52be-447c-92fe-08debce80969
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7233

On Wed, May 27, 2026 at 10:14:01PM +0000, Pranjal Shrivastava wrote:
> The SMMU's MSI configuration registers (*_IRQ_CFGn) containing target
> address, data and memory attributes lose their state when the SMMU is
> powered down. We'll need to cache and restore their contents to ensure
> that MSIs work after the system resumes.
> 
> To address this, cache the original `msi_msg` within the `msi_desc`
> when the configuration is first written by `arm_smmu_write_msi_msg`.
> This primarily includes the target address and data since the memory
> attributes are fixed.
> 
> Introduce a new helper `arm_smmu_resume_msis` which will later be called
> during the driver's resume callback. The helper would retrieve the
> cached MSI message for each relevant interrupt (evtq, gerr, priq) via
> get_cached_msi_msg & re-config the registers via arm_smmu_write_msi_msg.
> 
> Signed-off-by: Pranjal Shrivastava <praan@google.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

> +static void arm_smmu_resume_msi(struct arm_smmu_device *smmu,
> +				unsigned int irq, const char *name)
> +{
> +	struct msi_desc *desc;
> +	struct msi_msg msg;
> +
> +	if (!irq)
> +		return;
> +
> +	desc = irq_get_msi_desc(irq);
> +	if (!desc) {
> +		dev_err(smmu->dev, "Failed to resume msi: %s", name);
> +		return;
> +	}
> +
> +	get_cached_msi_msg(irq, &msg);

I wonder if we could use __get_cached_msi_msg() since we got desc?
