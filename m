Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010052.outbound.protection.outlook.com [40.93.198.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF062D47FF
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 12:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784030894; cv=fail; b=tTdjgP1rneTW6m5KA2Ccy5imLNNQHcV0fh6MidlBpAJf0enJfmzaKUeU2Uk2hXEja6uu1F9kJvwwUR0T26J2M6vSj2vZw5PxS1aMVT7CUltybWi5VhW5GJwatJEJGOMynYt22cKSUZAZkt/z5nHGJKyqkORsld0g90H8v+m1ocU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784030894; c=relaxed/simple;
	bh=Wf2ptzDGKEcWbRJVLdkZMT8K03j0IlNn7Og98fH50N4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=foX63qOm07BMD3tnVd1luoLym0Q18YWjn6okPL8REA+2WxNcRh37CQwykcBAMbBOXgSOj+GAyBHtFUIzs63uViM2JITwUKvkSg2cLf2opErboEXgWAzggLm11yDF8hZM0Jp/sBf1c+U5vvwgOscmuDy7fAv0Zhy7L/xqYydqN6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pubjzq39; arc=fail smtp.client-ip=40.93.198.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pubjzq39"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bU0dMnxeU4qjep+EAxNH6NnePHHJK+6r9we15ZPbcIAySQilEYh1FBp9Q4I4nh3ydbruyEpJzprNNwpSYOD25n1bTF3aNav1Nb8vcmU7SPBinZHg6KJCThkUNWkuBf//1qtqxpQr11rERGA9NVkr7vu/bM9+rRfBHged8y7FSldtQnKoZvYHH0Jtf5EgGZBMfklsN6RgMmRszveZxokJ5OZselmlYjXdwlZjGIHRyviE5/YZg9lDGk5tkN+MnLkehVcEEpnptItHA2pISLlzfQbpxigR/xmaS3Ad0xoIO4bn6/IsIK30dSBYNbGJCSTL6PwVfhwW4Di1lpcOlOndnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gcyzxg5heC9VzxKvsoiPHqnJe2/Q5DxT/g58Vy3v4JI=;
 b=Nx18b3YP5ETi/pWzaEL5jBCZERAy3eIOVG8rU1eilYsqNNhPPDGBTRAfWcBO/SHdydOJxGU468fE3d/O0P3Efh2owR4l0TnKKgAieqsDJNECBCx6JufmJhE9hvj44yeOErcGYQeDqUrq5aN1VR/v4/prf9It0MuSJrEYZUlBnnghJ936/7vPgo8hUtbkc76NRt2jm5p4V0PPRJ7x2OzbpGsTy0e9y+fOd3ovuLzUAyqb7qni9jWmpRfas502gAT4oKzc2yL0os6+xpoHY6KGQpG2iIWW9h2DK17ZZTY61SHq/0g02alLfp9si5GRrEecfGRZhDFA7sH91DKwgGLAyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=163.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gcyzxg5heC9VzxKvsoiPHqnJe2/Q5DxT/g58Vy3v4JI=;
 b=pubjzq39tuAiu/xsbPJ87qz2zOxkjVi+YnwVzlEFSBNELKfWHWu7Bj/69xNcJs7n8YSxw0YEOlCcAP0Mizzgi1and0gSwqL5lhQbtR/D1XI61S1u/t7rlTcofCI16HUfuy7PTqfEoczZFQa3wL5n/sXuMrfxV6zR3kEohkvcQ+0=
Received: from DM6PR08CA0064.namprd08.prod.outlook.com (2603:10b6:5:1e0::38)
 by SJ2PR12MB8925.namprd12.prod.outlook.com (2603:10b6:a03:542::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 12:08:07 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:5:1e0:cafe::24) by DM6PR08CA0064.outlook.office365.com
 (2603:10b6:5:1e0::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.20 via Frontend Transport; Tue,
 14 Jul 2026 12:08:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 12:08:06 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 14 Jul
 2026 07:08:06 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 14 Jul
 2026 07:07:50 -0500
Received: from amd.com (10.180.168.240) by satlexmb08.amd.com (10.181.42.217)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Tue, 14 Jul 2026 07:07:48 -0500
Date: Tue, 14 Jul 2026 12:07:43 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: weimin xiong <15927021679@163.com>
CC: <iommu@lists.linux.dev>, <joro@8bytes.org>,
	<suravee.suthikulpanit@amd.com>, xiongweimin <xiongweimin@kylinos.cn>
Subject: Re: [PATCH] iommu/amd: Use device max PRI outstanding requests
Message-ID: <orrfv3ikdiyebm6zpb23xqvawnmoc4jpc5leeliwfmdm64rxhe@ma3wf7vutd66>
References: <20260714020250.175808-1-15927021679@163.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260714020250.175808-1-15927021679@163.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|SJ2PR12MB8925:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d9e58ad-bc66-45d1-3a86-08dee1a0907d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|1800799024|376014|36860700016|5023799004|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	VZTVo4Ml4EWNnRYW8hweI7Rq3Hfr2x4kLGTFbjmCgUsVy4U0qHJY9ZlQNdEYqeFnqwBX2RWC8fvmtG/iDlOa6YXVIw/yZEBfCO8wj68utiY3Gc9Rg8SkrWU7UNUJlyhp9fyxGBeWpzyEpc9rSn+MRbiWVGIJRm8bsWsw5pCcSfhC+pZGlup1bwJMIMW2H3JWVR4J6az6YqIOBPMhKHs0K/xylvH6aw4Mvh5pSv68D6lOseRHgdkhDCXwk1xKt82kFdBzf+wrdEjciGnXEZ1DTzZfkbMPmvZf3q6wtYFxj7Z9km1R/mVoJxc3iOFMVHcSKlnvVyy8qQAZBKc+Wk+t0RU0lzoCQvPspusEVucENOIpBJ6jqEICPGrKjSK6x+hLUEyMzUEVasJqke5K7MAn9J3rfpNapj4fo7hzgwxYYaqKVZG9pYnPybB9ODTsnRKOrBYunF0Se03dkyA+YlKx61+K40uDYHbIkg0MO6bdKUyRA0fnwwUaNSp2RYHXJ7QVGFi62wqF44/qIYfBuPS8Noc5LvfVFNpmC/0zuXwR1vR6u7dZELG5fo9C4fUywvNB/oRCVsp2x1ysc0zVZKUh6flKxamXNxQCQ0OEcoUFS4Aaul8+OprV62ekv144DSmSL9eF68XcjH4gywf5LSTcFb2a9OnulnvNzvrU9ofz6P/wGOp34fCemZv9NrZ+ltIWZqzRnsLOEhEiloXGNcgRkg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(1800799024)(376014)(36860700016)(5023799004)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4DwU/cRnQ1lnz6bgJpagJ5DDRK89Gc0mIcsVHGOG5QhNcRvdzNAScNjO19HcGyuWyqtUr4jWQE6+KG31QYYkNrc3Nyi5pD9Z79BnmasVTRSwjNL06ZniuHanJBzxS9FJ+Mp/qYfH+RPuqYn0g5wab60f7CL2fLp0qBNZbkkzyvvVMDQ8GCb1+78hu6Bh6HfuNtzkb50+9qhKHyXEBzecg6KlQgi5sHrFiza6U8au6dAGZubEp9TeWMUX79NoEaHuWA+plcnj2M2jsuG0QaObxqJOPMIbjeOuuLLWsYD/EydGH3RntuJlxEPvGLP60oOa9hoYjnjbDLQpAWNNnRd6D/nCeizMJTtRxJakayaMnWTMK3pBeVlOMOhWst5qaRvujcsAYU1tlFKfUSmJy6W+P8LMPlwILcZblCwU9NFGn06/9OBeE43FOh/ld7AKiYyR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 12:08:06.7719
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d9e58ad-bc66-45d1-3a86-08dee1a0907d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8925

On Tue, Jul 14, 2026 at 10:02:50AM +0800, weimin xiong wrote:
> From: xiongweimin <xiongweimin@kylinos.cn>
> 
> pci_enable_pri() already clamps the requested outstanding count to the
> device PCI_PRI_MAX_REQ value. Passing a hardcoded 32 under-utilizes
> capable devices and can oversubscribe weaker ones.
> 
> Pass ~0U so the allocated request count matches what the device
> advertises.
> 
> Signed-off-by: xiongweimin <xiongweimin@kylinos.cn>
> ---
>  drivers/iommu/amd/iommu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 563f9c267..e1ec5ee76 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -602,10 +602,10 @@ static inline int pdev_enable_cap_pri(struct pci_dev *pdev)
>  
>  	if (dev_data->flags & AMD_IOMMU_DEVICE_FLAG_PRI_SUP) {
>  		/*
> -		 * First reset the PRI state of the device.
> -		 * FIXME: Hardcode number of outstanding requests for now
> +		 * Reset PRI then enable with the device-advertised maximum.
> +		 * pci_enable_pri() clamps @reqs to PCI_PRI_MAX_REQ.
>  		 */

Hi,

I don't think this is a good idea.

The outstanding-request allocation is a per-device cap, but the PPR log is a
single buffer shared by all devices behind the IOMMU (512 entries by default).
~0U grants every device its full advertised capacity (potentially hundreds 
or thousands), so a few PRI-capable devices can collectively far exceed the 
log depth and rely entirely on the optional overflow handling to stay correct.

-Ankit

> -		if (!pci_reset_pri(pdev) && !pci_enable_pri(pdev, 32)) {
> +		if (!pci_reset_pri(pdev) && !pci_enable_pri(pdev, ~0U)) {
>  			dev_data->pri_enabled = 1;
>  			dev_data->pri_tlp     = pci_prg_resp_pasid_required(pdev);
>  
> -- 
> 2.43.0
> 
> 
> No virus found
> 		Checked by Hillstone Network AntiVirus
> 
