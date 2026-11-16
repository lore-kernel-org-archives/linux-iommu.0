Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.37
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794857131;
	b=uYAGNAOaWRut/AlGXY/nVdFSj8h6x7rim87QU6RqCkIV1cvXjOxsthsnDBOYYFRcBUZ2
	 caQesOZu2TDzx0OepNl/oLTtxvYI8jyT3Vx2ayxGZDO2T5bpTfUEOTT0385/HxxqRRs//
	 llqveMs2akScy1KX0zmCqjCTOTZ/vxhV+0raAug3/IvzdRFIcJNDrR+qvjgo/wYmKwyd6
	 54r0mg7H7fbFRjWi1dDEYceeHCBdoQfrhPrdbFg/UFWwi1d3jCajB35TOCuRNCh5OR8+6
	 qRdcQrtLMeE1A4ckaNoLR04OFhEVi54tvnRVmTppsO50YpmGtDqvsTp+m1ZvcEIRsRw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794857131;
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
	bh=/qwZxifJdYCAPFUA9SvUjOTZ3/aYFDq92/2CmJXWaM4=;
	b=M6PCXWqje6hyZyuqag7W2E+dTu4LSarFc8j2RMi3fuAE/EFjYbd37wMS8uN/1O2pmiI9
	 lkB0JI9GOCsu3Bp7wZhnjaNRzWjYG3RPasLN705VKJY01/adMAp1tNsO6xh7dbC4fHCBC
	 DycM+t7RGKdfCWc6UWs3m1AEqikRyzmXKt9G6N7EwAOaXHxBcmcSeXNkst29KFqnsPCQB
	 Zx/teOIc5mNVagFXOEbCj9rCQixUFLl+UlqCc3P/G90m9X+Kg8MDdlWLZUK5nTUzMkzrP
	 EMvCYMBfhqLbXIVT21OSgbqd0DFv9zhD9j8saqlk3eS6zeKiRKWHWEP2Xi3zI9KVOFQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=tUOOijdV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.37
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013037.outbound.protection.outlook.com [40.93.196.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F67606A330
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 19:25:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58F67606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=tUOOijdV
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lB8lN3g8A1tK5NUf5a8W313oGOoiNl1O48rbgP5QrZMJxfBNXJf1IYzWAO99yZO/JtNoH7jX4IEM76MCeG+e6pjfDQt/9I3XCFTiHUbG8Sn3sXRwKHwOghx2fbAS6C2Q7TA9dakJ+d4a2jyNdFl+Bq2c+qiuCzRgw7/lFrg9QXOkvNXe6zSRrI2YifoczPaSyPXq6qPSTXcs6MkddXNzfRrYP7plh8fig4jfz/AT9OMVMOLJV50rJbBnSSD3HcDlmEScM45oJQKRbIRuAOJLOHnQaozHWyY45FgpjMQUOxGRcvJTIl8sU3PqJ8jKdflg0Y7nsWEm3JQhzmdiAAiVag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/qwZxifJdYCAPFUA9SvUjOTZ3/aYFDq92/2CmJXWaM4=;
 b=Tvc/p4PIVOUGcQSbR8BOJhlZMLza9YggiwcWJFCfPmN6Kw/AkLXrr3dP0itOLsKoWFCTejg4/EMhG8inJ3qHcsrnQzvgTwt+8qxZ5CmnSsGIjS5zCx8o+rFnCu2hArwRiGTc5nzzZXFs535D8qmsd+3HwCBXF374NBGSFTTiunTX66r5nWwbwlW/w0WHhgBClEIDshj8MYHMaGCDriViGF1WgJHtm97rd5xaYRSCjF+WfibWddCNdTUrxxrVwW8upebn9gehkCwB1ibi+kLbJjQMARt4FOz2nHxlLcx6dU7NaxclInuS1a/1moZ+CUbdWmGtoA4AaVp4O1JEUr/YZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/qwZxifJdYCAPFUA9SvUjOTZ3/aYFDq92/2CmJXWaM4=;
 b=tUOOijdVQ4Exd1ojuZzOgX0FaVgORr9sQIq4UHX0fYOmBzlvWvPXtZ3VQ/LZVbEkoKzwnYFBYUAOpuvYqiLo5W1PxXoVG+e2Oi43iAMG4mNxoqWUUoRs285LlIfpLCOF5HymDnnajqaLIOh5TY5QyUMJ2/yRzXIzoYisCrVHnpmW7SSFH6aNp7AFQ01qq50UuEcsKWqT/ejtHPyN0X11+QvWbFe9vyhTP3A28cNtXtFnIiHhTACd1tNE4wxRP4UT+0VR+gDzNlTqnJSsBx8/OjJgliqTdlUWk7xvP2oDM6Ja2YlYcaCiMJN+x9LKnXLCL+5AHOzape/Alf3khQn72A==
Received: from PH7PR17CA0038.namprd17.prod.outlook.com (2603:10b6:510:323::17)
 by SJ2PR12MB8061.namprd12.prod.outlook.com (2603:10b6:a03:4cb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 19:25:24 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:510:323:cafe::70) by PH7PR17CA0038.outlook.office365.com
 (2603:10b6:510:323::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Mon,
 16 Nov 2026 19:25:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 19:25:23 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 16 Nov
 2026 11:24:58 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 16 Nov
 2026 11:24:58 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56 via Frontend
 Transport; Mon, 16 Nov 2026 11:24:57 -0800
Date: Mon, 16 Nov 2026 11:24:54 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: John Garry <john.garry@arm.com>
CC: <will@kernel.org>, <jgg@nvidia.com>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <praan@google.com>, <kevin.tian@intel.com>,
	<smostafa@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <jamien@nvidia.com>,
	<kas@kernel.org>, Cristian Prundeanu <cpru@amazon.com>, Breno Leitao
	<leitao@kernel.org>, <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v12 11/12] iommu/arm-smmu-v3: Skip RMR bypass for kdump
 adoption
Message-ID: <avtYhjyAarKdi33b@nvidia.com>
References: <cover.1793593923.git.nicolinc@nvidia.com>
 <22a06965287dd478ee92f8028ae8ac27e054555d.1793593923.git.nicolinc@nvidia.com>
 <4cf391ff-804a-46a1-8d3e-d0ff8442841f@arm.com>
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
In-Reply-To: <4cf391ff-804a-46a1-8d3e-d0ff8442841f@arm.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|SJ2PR12MB8061:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a7fce57-5679-483d-f014-08df44175c7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|7416014|22082099003|18002099003|6133799003|261009223027099003|11063799006|56012099006|10067099003|4143699003|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261021121427099003|261021135927099003|261022105027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	E50yjDdNbo+SLpZ3CgB2TI5YOL0TMehIoxTslbL1zKFTKA4A8Ra4mHYnDNQGF9o2OYwjJbIOs8I2rlUX7r9fWwqyx8WfZxYYvS+nJ3uSGOraEbA4eGznHZSRRaubRT2MnlglOPFTxSHqEpCAKPi8dM2TPXDIhrZSPZvmP9mc8Gm0N7INL9hBjrKUrakEh/37DkBsdeL8/pf/yROCM57fgHf/uVe+MSbj0THgOcb0lMqeOu5SzMcq42ydihr6LO6hqZjPPexTESX6qgvbeXerd2xXcPes5/Qb5U24SfpXnjfsbOuQKDJYnWzkuF+7CvM57loPM0aSNJ9a57J7Nr8VAOzYQ6zc7xxQmBtNMjsa2NetatQCrIT90+IOL54M5zcNBgBFW0im+tVKOqhJyF3yV4ZKuFplV3+F5khPt+CbsoGSk+k2OxoUSSywOZrm5ePw5stlt8gWLTqVl5eSIgxbq9j2HXuz9Max1sCq+lwnGKyd18R2NLzWfcyhr3Em454qCniLA0rt24z7H6KaeiP3jpwFS0vhUtuJX7nYLZa0Pi5A+murxIIXNahyURB2ADlLNtaAe59GvgCo2snwMQqPFfBAm/zvGTqYJR0TlBaFeCuOaomibA7tzhb7frZ+2IulNNRCSymZt9d6znKBHc3cu31UxWnPdS+KvllIlhBjZ6yrVNsmgobYbEsGRcEDSy3MlD3j1rkQyacwkBLEtUIzCg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(7416014)(22082099003)(18002099003)(6133799003)(261009223027099003)(11063799006)(56012099006)(10067099003)(4143699003)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021121427099003)(261021135927099003)(261022105027099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iS05PaT0CQPuDEEygep7X7czPl7reYbXp3C1yKTLUFHnnpSs504xRHrRwYcjPx8MwQAfEfVp6KOFW8OBVyeeOa6AKkdD+ib0iR4POj75VdIM7T7MufSFuBRtUN5O80+hpexbxyHJxn0uDoPHwgluW1u6simE83lKocdgxGWkZ43FEaCQQUP0wjKBDx73b8vJbdHj/uPves1UsZAr+4LOz9ZGzhXJSWZnL9u9BsHB2cGQQ3Y9cVDzvzF8uUlFoS6LwLam/O3o4Rb4/U/05fxhEM73qC5qwXCr44pRB8ZwxsU2mSiISTM9UMsFSW+yR/NK8F36YfrfNCAusc647cZaxF9DXlQD+rwJd8H1B7uhKx/ShIlN8G9wQgZlQHsTT4xHXIogohcq1PY/4KKMlYxe+DjxNJNwahEcu5f3m3hW6g2MQKAsxgSPeBMXyHSjYnXX
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 19:25:23.6035
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a7fce57-5679-483d-f014-08df44175c7a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8061

On Mon, Nov 16, 2026 at 12:26:20PM +0000, John Garry wrote:
> On 11/2/26 05:19, Nicolin Chen wrote:
> > @@ -5810,6 +5810,14 @@ static void arm_smmu_rmr_install_bypass_ste(struct arm_smmu_device *smmu)
> >   	struct list_head rmr_list;
> >   	struct iommu_resv_region *e;
> > +	/*
> > +	 * Kdump
> 
> mega nit: "kdump" could better better, as it is a keyword

OK.

> > adoption keeps the crashed kernel's table live. Rewriting the
> > +	 * adopted STE here could expose an in-flight fetch to a transient V=0
> > +	 * entry, or change Cfg=translate to Cfg=bypass. Must skip here.
> > +	 */
> > +	if (smmu->options & ARM_SMMU_OPT_KDUMP_ADOPT)
> > +		return;
> > +
> >   	INIT_LIST_HEAD(&rmr_list);
> >   	iort_get_rmr_sids(dev_fwnode(smmu->dev), &rmr_list);
> 
> Did you consider if we should sanitise the adopted ste against what
> iort_get_rmr_sids() returns? I suppose that would add even more complexity.

It's not necessary: both crashed and kdump kernels installed them
from the same IORT. If STE is translated, they are mapped as 1:1.
It's certainly not worth the complexity.

Nicolin
