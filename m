Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.62
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794853415;
	b=ZLc+tfcPa5RY2ofFPyQDSPi04krf8qW95cTqCsMqVuXzmF/TvEBUQ1cKbf+/v59kqkEU
	 UHQMSE+NxRCRj8VMbUEmaJkIX2BAFTBa7aaCWJICp4FjVLPAkhfNQ81TcagYRODTpS4kg
	 5mU5NKxEqio8P9oPoAVLMJ7HOShbUIDv44GCtBDZp8a0c5BWWWdjjt6mXgyVSdTD+S14o
	 /6GSP9Ijz4Authv3FYtRygh4HVNGWYtCqDSlHrLEsxDDWjlHWWbWzzagDwCCxbi2HuE1E
	 TZCr5lvl+gqwGvt2lzY8PYa6cCrHIq1u9t7AYlzfWvX81+BKGTDAPmd3zUj4+bsnTJw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794853415;
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
	bh=RF47G0eUg3X1yV1Rny9TmopcvFkGbLCkskvCtLYNWKk=;
	b=exxzI+4BvRfNiO+Uhe0S30RedBfOlOEx134H+NQ/I2GdVPxNEikfh87AhJ3HSpSGRMO5
	 cepUGXcZo2dfWBvKkA9S81rdkXmzY4Z0CU6ffFCVRoaKZTGwhfHUzguqqLWMLQSC1eitr
	 YqUhq+ilDcVaisJAx9042FvpU+Ge2klFE2mfixieSpov2Vw/+sO3OB0s5M+2ZlnGLEdkp
	 toSA82Vl+x5UGqsSs1eZKtlv9fMFe65y5B6o6tkWB10DgazkWHPYa/vopSduUaoK8PkOo
	 KeX4unBcXzDgnguPIKM3mwfyo56THqi8yd7+qddXH3nhWpnrY+huA27e+LCgHlebJdw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="krM+fTt/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.62
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010062.outbound.protection.outlook.com [40.93.198.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858BB606A322
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 18:23:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 858BB606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=krM+fTt/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dxr7yVOwWVZx0br99ppiqzCbEWiCZTq0NtggAjR6AwJC2GdbRD7e87Rdv1I3xlXZSfhhmDRJ5/wluxksgIA6x8TxkXxeIHFeGZQkEdHCPcnXcJulwJ+pIdN0sBIIgL8tz/eqlNB2vhRaXzYgwqXxhGQkyrQmxlrYOf/x12tfEd8AUUgdukOv2BWgNL0E4Ii4RSUsxnM313oD3t4LFgYKVBc2GQpR8T6J3H3+vUo3HrZ87obDPPQy6+GW+94FsbCLLh2PqJPv9SVaWYIsQHJ8S8Tc0OusApP89WkalfYQ229309re+VCdsAsVJOv4p0IqPO01OeXYRa05OoEErfwq7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RF47G0eUg3X1yV1Rny9TmopcvFkGbLCkskvCtLYNWKk=;
 b=KRpbT48YK0uq7XN528xOgo+Dcl8p2efXlEQwIxY2N2BbulTbLVgrCZkj/7GQJbVB4g4NlyvgVYIMjlkVwKMVI/AhhoI2edW8jstOWEBUCOAj41KaEUgSvCcb7XsjQ2R3yoYkFalAuj9cd+Y4F8oVXx3J9aQ4qgtSKGfDUbUZ3Zx7c7Y4vnLb5UcvqDBeUEmkFHpd09O4Tdt7SN4E7EfbT5x1VxBj2QWLQPkT7W0WHXp1XzNGGA4EkX3XV3kXmnV6y2At4aX+WhsEZOn318Crzy3os8o6pcGb031AmYmtUyBLWYqIZ01SgnN5iKq82FNc8Tbtdh2VUSDiTkGKapBgCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RF47G0eUg3X1yV1Rny9TmopcvFkGbLCkskvCtLYNWKk=;
 b=krM+fTt/mgxKCcAiBSudE2bfx8zeZq8WKpIu3y6iv83Dug4CSJireE36xtegAr+BpTJppSJcK4Uz9y9aiGUyQdyFd0Vl26CNOyvDgxJNUAnxZAETqCmgs11TTe6w3keYhw8SZ7WQ8MR+cSYhXEs1zU2KW2fx8L5mUB+O0X1EP2xiusasjmuPGjipEsgWKXAV1CRGU8M6K3lgVVFIInvE1+gPHPz/DdgubfGMyHHeYL74pRdoQnsSM36TjHfiR9TWjcvgNoWIv6nYL9vEVRpod5mQ3H4jG+rcBdHmVRHdC9iOapyLnMx0EiTPjJI8YibRufAmWM0finooaJQyUybG7Q==
Received: from SJ0PR13CA0223.namprd13.prod.outlook.com (2603:10b6:a03:2c1::18)
 by SJ2PR12MB7895.namprd12.prod.outlook.com (2603:10b6:a03:4c6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Mon, 16 Nov
 2026 18:22:29 +0000
Received: from SJ1PEPF000037AD.namprd03.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::4c) by SJ0PR13CA0223.outlook.office365.com
 (2603:10b6:a03:2c1::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.0 via Frontend Transport; Mon, 16
 Nov 2026 18:22:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF000037AD.mail.protection.outlook.com (10.167.244.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 18:22:28 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 16 Nov
 2026 10:22:08 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 16 Nov 2026 10:22:07 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57 via Frontend
 Transport; Mon, 16 Nov 2026 10:22:06 -0800
Date: Mon, 16 Nov 2026 10:22:02 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: John Garry <john.garry@arm.com>
CC: <will@kernel.org>, <jgg@nvidia.com>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <praan@google.com>, <kevin.tian@intel.com>,
	<smostafa@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <jamien@nvidia.com>,
	<kas@kernel.org>, Cristian Prundeanu <cpru@amazon.com>, Breno Leitao
	<leitao@kernel.org>, <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v12 03/12] iommu/arm-smmu-v3: Make the ASID space per
 SMMU instance
Message-ID: <avtJyvvLnDV3Dl/N@nvidia.com>
References: <cover.1793593923.git.nicolinc@nvidia.com>
 <9295479f55d247961b25d913b6f4de1d7a72e0ad.1793593923.git.nicolinc@nvidia.com>
 <9d39ed4c-f19d-4504-8c59-0e2336185a7c@arm.com>
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
In-Reply-To: <9d39ed4c-f19d-4504-8c59-0e2336185a7c@arm.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AD:EE_|SJ2PR12MB7895:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aadaa1d-d58d-455b-307f-08df440e929f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|23010399003|7416014|22082099003|18002099003|261009223027099003|11063799006|5023799004|56012099006|10067099003|4143699003|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261021121427099003|261021135927099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	BGZk2beSTMiCvTt4FNsfGZgCO5VD8cmdgeXYqI9VstjwxvDSCKUICtykxqBXrBHuVnt5I2xgQSoYYWYVbJJRmzT4GRtrgFN7m9zW9V0OBhNgS6+yPdGOR/9ZFEn0LlJItQUXRe/Jz39dAyoz5k7ote64DXvrzFL58e44/ywl236W3zp01eHi5Nlt4b5qXSzuKf9QuURkFxV2PkDnnNFlGuOETZvmosabJXaZkQRZP5vEa3I9dtaqEhQt6v0Owt/60TQwr3vI8qEN+HiO73qA1oFtdUzi/gI/xbMAwDVQ3CpQfrqLUHZ1BaWNBQTomG/ne+GhwGKazMCwg/kpDrohCfzXql0SoBvyD00hk4yt/iE1iGrgzJqL4ffIPJmfuibox9VPFz8HiF54emjeTf+cB7x70PjmdoFNcK0HvkDsE2epYYYsfDwEJ5jtdTQPyMZ5YQY2IbQHD45BzpeB1Lg8uRxC5ZDwtlg+Sxex2Lw7zvi0V3ObuMscIBdRMf3u7soSBgWhUWjxdl4f2I4W1yZzoKN9hATKYBCi2fvgOZm8jsu6ndvFAk2Wxwxfc9sS3XhJxeFHl0qwkze3KGhxxGr6wOtFjsN7ZLE6eT8BcBtb01PHtUtMrnmUiinid53Sh4Qhe5nOtVD2l/VJfZ8cnfEhejzR8YQYPI/9MSNzOStRzVUuKQXOlubh6Sto66NsLjfFzSCIhdk/3wBtREGeyLXN2g==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(23010399003)(7416014)(22082099003)(18002099003)(261009223027099003)(11063799006)(5023799004)(56012099006)(10067099003)(4143699003)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021121427099003)(261021135927099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bz4s9lM2Zi5BUBnvLajjvHYCWASMlFvONa94BfpKjOjcPAYgzQvpQSV5Dak4Y+uhpwcfe28MJs0jNN2ldJ+cTrn0SJqPyTDPOCc1q5ABfG5d+K5Kc2ciIsXPv2VX7tyI/KRPybeFeq+Xnj6o+dCJaZWUCl/rDpwHFENiFm28neCB3p3Tk1OinuAf5NnBIrnnguC9SR7NDrKB4ow7GNUY7dUK9wqaxFPn7Zx8K8oKjYt+iE+qjc2fxhqCDbsvS/UDbB/BKHnb07HlVZOB0gRmEkyipXWXbThh1/QCcNKyMovTF/e+hRRzqbotlnlxWFE0xfjnQ7cExwoTDynlFvYfDoCdeaJDrqPuCxMcctABCzE0BTA26ybZd07c+DB597WS3IOLVtre62rcRsgmzlf5aGEbFD1tb6tmRvAKrmJc7GQtPjNYnXcRhaQpxjirVcDf
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 18:22:28.9800
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aadaa1d-d58d-455b-307f-08df440e929f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7895

On Mon, Nov 16, 2026 at 09:46:31AM +0000, John Garry wrote:
> On 11/2/26 05:19, Nicolin Chen wrote:
> > An ASID tags the TLB entries within one SMMU, so two instances can use the
> > same ASID without ever aliasing each other. Yet the driver allocates them
> > out of a single global xarray, which makes the instances share a space that
> > the hardware keeps apart, and lets one instance exhaust the IDs of another.
> > 
> > That global space is a leftover from the BTM support that shared ASIDs with
> > the CPU. Now ARM_SMMU_FEAT_BTM is never set, nothing looks a domain up by
> > its ASID, and a domain is pinned to one SMMU at the attach.
> > 
> > Give each SMMU its own asid_map, mirroring the per-SMMU vmid_map, and clean
> > it up with devres,
> 
> maybe you could use a single devres for both vmid and asid cleanup, but I am
> not sure if it would be neater.

Doesn't seem neater to me. I'd keep them separate as-is.

> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > index 5cabbe5652dc6..cb45bd154c9e5 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -90,7 +90,6 @@ struct arm_smmu_option_prop {
> >   	const char *prop;
> >   };
> > -DEFINE_XARRAY_ALLOC1(arm_smmu_asid_xa);
> >   DEFINE_MUTEX(arm_smmu_asid_lock);
> 
> Ignoring what I wrote above, it may be worth adding a comment that this
> global lock now covers per-SMMU instance asid maps.

/* Global lock serializing the STE/CD updates against ASID changes */

Nicolin
