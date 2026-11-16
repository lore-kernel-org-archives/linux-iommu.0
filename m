Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.8
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794855552;
	b=uYolsaXCDDZXd2bj2PpXiR1TcSFqSPoKLZhNVGY8Ckk5sE3toEZhCnfrhv8ol7/j8zuz
	 ORTwbi5EyBryp1IMtRyurOILzMvfLGdI6pwh8sypYQBycBSdnj1XA1rYkUpPKtnRje0aa
	 iDChDBANIuKBQYMVaFDqfNoFmXkqOqTaW8fBv8f+7Y5xiWmVqGwqHeRrhPnVCDeKZge6O
	 9nbC5q+TMlWdDK77B/GzhHnR+qq4jg5ce5e/WiFN92jzOYd623S6DTIaVjysW5H3LLK5+
	 w3MaADK+003V+vYBf5xpUF2c7BHbP7OtDeZKXAiItfJOtDgLQmbXUUZOhTS6as0953g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794855552;
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
	bh=6uZxX2VodxEyJ/RYf+cCYB8tuwn8+ufFF9b0AItFCvk=;
	b=LOihuND71uczgJTrerkAt/4CveKutpid2RNm6dmyoF1QLh1Rf60DgUC6DrOW0VJ1OBht
	 aKYBcYXRDl3iSbBVZAX1Csc43BzoapkSK69fPs4BxQWJu0N43ksWm28Zt3dM3njhMhe6Y
	 VufLvxoQ4Ke6XGkSxVomJVRGgFlY5vUpUL0+Ag4AA9NVJkAu1jl1hMrpb/YApX0Be3iab
	 z81EreietOU9fjBxDhsYh9lpQw0DaCr3h9c/sonexgCbQiAye+5PiFwk335FUdSo2YV7x
	 +T+aEYdzjSoV1MFSUAxHSVwPfF9zVcDDZanXGhm+yyh8qCm0bKnUdSzDQZeb7mndYwA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=JqI2bWaS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.8
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010008.outbound.protection.outlook.com [52.101.56.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF99606A323
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 18:59:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AF99606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=JqI2bWaS
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yAKGHwe/+7YQcSCZfkGUIB6ZV3z27mJ60ORdR7KKT6o94180r90YRVCnnBDqtIWuIW2Ta4WbHdj1v0I8Bpzu6pvNG0Ezpu0EliFpyQP3XPVS1m3DWGbdDls0aNv2mHzs4AulG/St17xi2CU4E4I5hh5I5XE1ddqpZXcU3IgJ7jjBuRZl02iouQ9dIPd6+34eu3mpgc4EnpYhxU7yA4nhOzSuVcQMi0RdQNg6WhQSrzjEC0ezrhNZHoRj9n6WbkN7K9TlrEqaNPvasBWEZ2pMmCbdSrmUS7riXm81QWf+9HvX54LbuWnZ/KenayPnDjy2us+YwAwfpnAa+Nw2J2ULSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6uZxX2VodxEyJ/RYf+cCYB8tuwn8+ufFF9b0AItFCvk=;
 b=Ecig9C78x0pR1dV7TFR+sMo/O5cBK5ffReGC0GYVjrGMCuFUik6gBsrYKES0EaOYpTMhpbkFkNaabx9lmxQlLqUeymCu3+YEow/oxqzRbGlgKSH/IcLivBABbax/igUfIM3QWioCjeJLRvb+574lChQXgwNr0dse58t5La0y9GrKKzAEE3RfP7TdyhUbJRh/n6BzZbhYbZ4tHRXAE6BniXc+kAtH1fNFes/RdWZnMieTX3Zl3kBudj1yKeBuBBAeBtTzrvs8K6Hw+mNFRy+avunpfnufzah5t/Gr3MWsiiH7Lre4DBCjmitv4kD6BV6x/4JtzQrXNpc6y3CXNQEN4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6uZxX2VodxEyJ/RYf+cCYB8tuwn8+ufFF9b0AItFCvk=;
 b=JqI2bWaSa0rXLgCN7j9A4tDBuz1QzibKbZeiJJCsATTxa3RBziETy3gD7doAuOdaAXrjLuLvGUIK2MuHArYNNhmH/EaibIOffuIUBxr7rssgydMg5klLeYbrmOrLjY37FaMvf/ZxBFP3OEWMv6Wd25s3XKutA9uShMRDEij6a64b3yjI6e7nQ4e/SfULkTvUKHa/Ns3Ex69CrM1wLRqgxpDf3tinLJY7h3IqGpCaY5Gkh5MJuQ5Lv/TSnrxNNavX530je+RO2z+lyzAx8aKRon6cn2MPJwN8rMH+BrpjAHNisqLzX9EK/x03YVddjRpQRXcChbmYfDuDktGveABmuw==
Received: from CH5PR03CA0013.namprd03.prod.outlook.com (2603:10b6:610:1f1::11)
 by LV2PR12MB5941.namprd12.prod.outlook.com (2603:10b6:408:172::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 18:57:53 +0000
Received: from CH01EPF000BE94E.namprd02.prod.outlook.com
 (2603:10b6:610:1f1:cafe::8f) by CH5PR03CA0013.outlook.office365.com
 (2603:10b6:610:1f1::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Mon,
 16 Nov 2026 18:57:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH01EPF000BE94E.mail.protection.outlook.com (10.167.244.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 18:57:52 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 16 Nov
 2026 10:57:23 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 16 Nov
 2026 10:57:23 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56 via Frontend
 Transport; Mon, 16 Nov 2026 10:57:21 -0800
Date: Mon, 16 Nov 2026 10:57:19 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: John Garry <john.garry@arm.com>
CC: <will@kernel.org>, <jgg@nvidia.com>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <praan@google.com>, <kevin.tian@intel.com>,
	<smostafa@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <jamien@nvidia.com>,
	<kas@kernel.org>, Cristian Prundeanu <cpru@amazon.com>, Breno Leitao
	<leitao@kernel.org>, <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v12 04/12] iommu/arm-smmu-v3: Pack the MSI vectors of the
 used sources
Message-ID: <avtSD34Rj5+XAz3t@nvidia.com>
References: <cover.1793593923.git.nicolinc@nvidia.com>
 <0d28afd67694fc6882e0ff5f054027488b1cf816.1793593923.git.nicolinc@nvidia.com>
 <db4f83f3-d35b-49b7-8570-04e158125b53@arm.com>
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
In-Reply-To: <db4f83f3-d35b-49b7-8570-04e158125b53@arm.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE94E:EE_|LV2PR12MB5941:EE_
X-MS-Office365-Filtering-Correlation-Id: aa0698a5-435b-4573-364a-08df4413847f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|82310400026|36860700016|10067099003|56012099006|4143699003|11063799006|261026121527099003|261026140227099003|261028144727099003|261021135927099003|261022105027099003|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	yWC2qqoyJY0+obtykxnP7PKiadHxB+mXQGgINf2YpjVru1kSaxsl6X24pTD7fEmTjSAYWt6EoWHTikmPOp13NK9IB5v45LlEkAtmlG6mUt0zy4x9XdSECoEwYpLpVfpwxNlhUEHItlwegiP7YcCMS97RAPJt/p3XdPFBYGlfedZlPVloWaZv3lB1ljmklr9fSIcxfkiTfpBHYzozgvT34IZmnCfqKuDXLI8o0Hk4rnDmt1jbCoLLzIG4BElf6BuGBp2O5NOeqouw+kcKtCLHFTMYpoFGrRVuAcZGThfNcG0PVk0PlwSOPYpHvZD65KmnVVPCzlqsw2S2Ra35HfGykRucm3uhW0SvjB7xmrTYCtLsmycZvI/AGyfONsavwmx5nE4TfsYPLnfs7tTP2HdDptW7hQ5gSYubN1CVuUBlmBHJCpQ/nOEcRYswpKKlTUAqaQJTyADGqS7xRPZr01bVXroLvcZM4YwV5tMx5Xj2GGjJCKvrES3ItXwK69blL8DUHvbhASkxDASQMY8yazfcJP+yU9DcdLTBQcoW3Vs1f4rixjLQEnf3Dgqh3/h/365RX7lu/zDymHlB5F2gNa/Ipnui3ryg4ZwCke4C5Lcb1lJrHbVdfmax0nd/3b1z9KBo7qP43lvazb8Q3kXub/l72fvx/U8ra6zCemlco/EUHsT0mJrAlIKcASkWP1UAJdMFYcZpYVyQmWVqPH+l3y8tlw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(82310400026)(36860700016)(10067099003)(56012099006)(4143699003)(11063799006)(261026121527099003)(261026140227099003)(261028144727099003)(261021135927099003)(261022105027099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lhXuZX7EgZDOFjnYsF3ExpcxskkXck4T4R+LA/K2TBLYlsM7BC5MegcrVOhW6o+RCG469yCMwXu9V2EEAyEaLz/jAUnW4pMQvwoi9lUAmrWndsgFmD+/wl0hVYkq8oMKvuWZbCjM7yzqxKrgafbv+x/OonFSCMfDXx7q9gSm5PA2mqfWqXM8CkT3iCY40ZgFU0nfgxisf/he0tyEU08F3a61LzbSBnBX4f/lxCrXGQb2lyLU0pVJ08V0jGMXezNHOFOWHRtPfpNfLEQllkkt3hI/LZ+PxGkA7y/bZV+WveHwSPKyGH0NBknXm8jN5MWHia1F1S6fsqqNHCMZFovtmArLmLwhWG/kn7eQbcjy/aFO6yHOUmunR8zkUYYlbRrqpksLmwnJBzl5UDgq0sEEw3Gw2I2MwQHR/+M3i9Ot9weWUVxlGKNVes+jgnOKZX9X
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 18:57:52.6474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa0698a5-435b-4573-364a-08df4413847f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH01EPF000BE94E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5941

On Mon, Nov 16, 2026 at 10:29:46AM +0000, John Garry wrote:
> On 11/2/26 05:19, Nicolin Chen wrote:
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > index 8f2c0b1cc4a8d..bce592fff0b12 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > @@ -936,6 +936,13 @@ struct arm_smmu_impl_ops {
> >   			  const struct iommu_user_data *user_data);
> >   };
> > +enum arm_smmu_msi_index {
> > +	EVTQ_MSI_INDEX,
> > +	GERROR_MSI_INDEX,
> > +	PRIQ_MSI_INDEX,
> > +	ARM_SMMU_MAX_MSIS,
> 
> nit: I don't really think that the trailing ',' is required after
> ARM_SMMU_MAX_MSIS, as I asusme that we will never see any entry added after
> 'max'. I appreciate that this enum is just being relocated in this patch.

OK.

> > @@ -993,6 +1000,8 @@ struct arm_smmu_device {
> >   	int				gerr_irq;
> >   	int				combined_irq;
> > +	/* MSI vector index to enum arm_smmu_msi_index */
> > +	u8				msi_map[ARM_SMMU_MAX_MSIS];
> 
> should this be an array of enum arm_smmu_msi_index, as in
> arm_smmu_setup_msi_vector() we write a enum arm_smmu_msi_index? I am
> assuming that is why enum arm_smmu_msi_index was relocated.

u8 is optimal in cost of memory; ARM_SMMU_MAX_MSIS is needed here.

> > @@ -4943,19 +4936,29 @@ static void arm_smmu_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
> >   	writel_relaxed(ARM_SMMU_MEMATTR_DEVICE_nGnRE, smmu->base + cfg[2]);
> >   }
> > +static void arm_smmu_setup_msi_vector(struct arm_smmu_device *smmu,
> > +				      unsigned int *vec, unsigned int *nvec,
> > +				      enum arm_smmu_msi_index index)
> 
> mega nit: "index" as a name is quite vague as we are indexing vec[] and
> smmu->msi_map[] in this function. Maybe "msi_index" would be better.

OK.

> > +	arm_smmu_setup_msi_vector(smmu, vec, &nvec, EVTQ_MSI_INDEX);
> > +	arm_smmu_setup_msi_vector(smmu, vec, &nvec, GERROR_MSI_INDEX);
> >   	if (smmu->features & ARM_SMMU_FEAT_PRI)
> > -		writeq_relaxed(0, smmu->base + ARM_SMMU_PRIQ_IRQ_CFG0);
> > -	else
> > -		nvec--;
> > +		arm_smmu_setup_msi_vector(smmu, vec, &nvec, PRIQ_MSI_INDEX);
> >   	if (!(smmu->features & ARM_SMMU_FEAT_MSI))
> 
> In this case (or any other time in which we return early in this function),
> it seems less than ideal - as a coding practice - that we have written
> values in smmu->msi_map and they won't be used.

Doing so it a bit neater. But fine..

I'll Move this behind the FEAT_MSI guard:

+	/* Map each vector back to its source for arm_smmu_write_msi_msg() */
+	for (i = 0; i < ARM_SMMU_MAX_MSIS; i++)
+		if (vec[i] < nvec)
+			smmu->msi_map[vec[i]] = i;

> > @@ -4972,9 +4975,10 @@ static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
> >   		return;
> >   	}
> > -	smmu->evtq.q.irq = msi_get_virq(dev, EVTQ_MSI_INDEX);
> > -	smmu->gerr_irq = msi_get_virq(dev, GERROR_MSI_INDEX);
> > -	smmu->priq.q.irq = msi_get_virq(dev, PRIQ_MSI_INDEX);
> > +	/* msi_get_virq() returns 0 for an unused source that has no vector */
> 
> So are you saying that msi_get_virq(dev, ARM_SMMU_MAX_MSIS) returns 0?
> 
> If so, do we really require checks like the following:
> 
> if (smmu->features & ARM_SMMU_FEAT_PRI) {
> 		irq = smmu->priq.q.irq;
> 		if (irq) {
> 
> I am talking about the ARM_SMMU_FEAT_PRI flag check, as smmu->priq.q.irq ==
> 0 and ARM_SMMU_FEAT_PRI unset seem equivalent.

It's slightly different: In the MSI case, it's registered upon the
FEAT by SW. So, it's ensured to get 0 without additional gate. The
other one gets from FW, so gating is necessary.

Nicolin
