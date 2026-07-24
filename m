Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013053.outbound.protection.outlook.com [40.93.196.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BEA34F474
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 18:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784916320; cv=fail; b=U32PXTD0+q3UM+yabU+yjyAM167fgPnJYBHsmRnmQjcW8a0u+/fZ7l+7GtV1BIlGiYR9Wsp9yo2XgEzaS/MNhpDnSyv7egsphw0QVEwN0a0s6rh4gtH6XT6IFQE00rZ6aLifiWC53vse0iNzHYoneOlOARfonwMA+g7qOqrAuVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784916320; c=relaxed/simple;
	bh=xG5QkOg9k5xV8eVyNUUdZaeUHYlIklPG5ItfqGo1ApQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z4QapXyQCpYjo/shL+Lq3qdj3S7VKMcm3X8vDFnDiZJyNL3IGQEAISIzzyAo6d//QQQYs1LSPZW7Kv0Ei+l2+vvOvGAm+CooUOB3bg/zTCZcWdsaK6eAxgbMwaG82TF2WOmfy9SDdPd94FVW9F2dYIJ3TQN2pkV1nWb0MYb26So=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qF/9jx2M; arc=fail smtp.client-ip=40.93.196.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qF/9jx2M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IId4KfUZ678j8JbTspyuVUegRWVbo0arLgrWoXtu/C9qXYgdgZnLRYkRh7zyabmoPq38v7oM6uGMioCOvWsf0qaee/kryMStVESK6n2E/q1esS4ZHzyxCo6u9ZpXh3tV3dWlE+W5n/ZMjmIv3NpGvTl8dETD1SXFVg9wAOMS0X2XUE1qV752q1ZMQUS1z+23yc1y68QXTWxb2ebbzB3/JXKwInz8bCwlE8OSLPA9L4xTS8y3YZqpG6z0NEvQniszRwaQkNGIkykCIjZ383QWyJsRnF0tHDUFJ7oXlyJFgV3QJa3/nJgj7ewvNFw1CeqIER93tZ+GbPrFiNnyvhHm4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yaBklIEnXSs0wqdbLYG6OP3wkbhIDgt/D4Zh+qG2Hw8=;
 b=HMWAx985omt7yJ0l3HSSRnlsXKqdPDPcKTs1c87r9T0J8D1+uEs4wWC8ZN/Z9Pd16DozuzWQ+/LEHUqclwHWkxB4KZTLLshmKQPJkTJ6AFQt8wYgQ06rTxEvrMgBekn5T70SUWf0yfE2uRHN8yTZ/Ye3DNOAt0nEJd2CT/bmoWOOYVfkISW0R98ksSZi1EiW5Fy2mr4p0Q4dzSeMF/ndqjFjRSN4aPi601Rsb6F7RAoq+p8JcFkEr14iEES4s5MDX0bE3pQpm1+QiSN1qZfEBzdhGUn9y3tanJBq9zIo9BV6mCNI1ornsRWDo0RSuEiVz+MHINZlA2XR3+J9ImK0xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yaBklIEnXSs0wqdbLYG6OP3wkbhIDgt/D4Zh+qG2Hw8=;
 b=qF/9jx2MyJ/796pgWYJyp6ETfpf6rAYMO5KC0rrq97sbfd9bYwbHKrfsiWjTqG1Mfwn5zRNBblm5eZOhXFknRCLkYqx1yA4TNKAytmwCUKRIyq50V+JWbHHP0tF62eC/lxGDIFxG+Ba1yaueKw+777akcGVQacop0tp3rgSMVyJbKgIFIfEgQTF7onXUoNuibXMwP0fH1TDjhka2ljJ9hk9kZL/SHxeYHw6ju3q+DGoEvh4gCuWYR1nmB1XqO1PGP0ALlLErgU9XhzKcoXHL5Sv1s2+pwH/Y/i5B7hxK7O8vXqhdKBjHhXbn8P4P1WWm98zVRpwXuqtkUlkixA9ydA==
Received: from MW4PR04CA0185.namprd04.prod.outlook.com (2603:10b6:303:86::10)
 by IA1PR12MB8286.namprd12.prod.outlook.com (2603:10b6:208:3f8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 18:05:12 +0000
Received: from SJ5PEPF0000020A.namprd05.prod.outlook.com
 (2603:10b6:303:86:cafe::5c) by MW4PR04CA0185.outlook.office365.com
 (2603:10b6:303:86::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.12 via Frontend Transport; Fri,
 24 Jul 2026 18:05:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF0000020A.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Fri, 24 Jul 2026 18:05:12 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 24 Jul
 2026 11:05:00 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 24 Jul 2026 11:04:59 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 24 Jul 2026 11:04:58 -0700
Date: Fri, 24 Jul 2026 11:04:56 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Peter Griffin <peter.griffin@linaro.org>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel (AMD)" <joro@8bytes.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Pranjal
 Shrivastava" <praan@google.com>, Daniel Mentz <danielmentz@google.com>,
	Mostafa Saleh <smostafa@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kernel-team@android.com>,
	<tudor.ambarus@linaro.org>, <andre.draszik@linaro.org>,
	<willmcvicker@google.com>, <jyescas@google.com>
Subject: Re: [PATCH 2/2] iommu/arm-smmu-v3: Override for Inst/Data attribute
Message-ID: <amOpSPmc36+YXgCQ@nvidia.com>
References: <20260724-arm-smmu-v3-instcfg-override-v1-0-e7acf4a8a525@linaro.org>
 <20260724-arm-smmu-v3-instcfg-override-v1-2-e7acf4a8a525@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260724-arm-smmu-v3-instcfg-override-v1-2-e7acf4a8a525@linaro.org>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF0000020A:EE_|IA1PR12MB8286:EE_
X-MS-Office365-Filtering-Correlation-Id: 40cdaa8a-de48-4a48-c726-08dee9ae1b5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|7416014|11063799006|56012099006|10067099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	V75vysgnBPwo9VAs6GmkJ11O9uyThw7B8+d9gL6poEip1Y+aNHhByccK0lVgrpnSP2ywFc2qvjye5Yfp7HKcP7/h/2NETZ0b4Jfh8tMt4GuaUUeEgYzB6adn0ppOixUW1DyF1WSRHldQXcSjZjhIV9sXLyXiuFAeCay0AoFOOEOOBwLDfLkUOmJydwX5Y74fym71uTr780pWiWNdni+JhjrsLadk9syT4XHIURyX0oPc7d8MymqhnRlQK5tfFYPySY8rRudHqBnu7Yi19rrDSZ24HL4zzOAK+geudcBabAHXr13ly3ySxIie6V5OTBwzmpNi45Ko9MGxPo0f6OvnxDR5EGvtcJ2JbAQdipgBSqdcMn/qzui3JHk6/eoabDyB8tbJmaMDTyuhg6Ob7qA2U7te6+TtgmrYlHJB3ErRsXEyDhAzy1cHgL+yEmK0iZbgwEW6Jmxt0mIuyH3KMmQYa+/PLcV25LgdFypCZ152y3xdBG3+745ZPVEBHDMqgvviQbpHvftYoJa4fSFzUa/GlgvRJhIOTHS9wG/GMGPp8+25vtrYwVScrkiYTNcyXPp1gf2nuOe7WpFelBq2C3cpfg72tgBpa6uVNDlINP+F+O03EgPEoXXH4l1IOUeSQF2NHoDXmGOzOxfA4znl3TG0Ja0FK3ffkDk+ppQVZ9VKjE5fGeqa2Jdff0jkNeGK5Qi60XSym+NVRidg17ZNkkRm3w==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(7416014)(11063799006)(56012099006)(10067099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Msapzi+1hEuc0mFGNp5mybScohmIQJkOn6sRPmKeBPAv7eSboQM5bGoYiEWr4dqcgExVmwz+/kkMmE9zJS2rxFZALhWPuYLadqQJdoeGa9/Dw9F2uyR+2qZNVEckAhGlkXe+aSY7BXwHeJVtQBnaYiRecn+CK9oeWg0qCKobeTY6ZAXAVXYcPv6Yynesd5BQPlm0Hv1q48Dw5hYr72eW4D4os6WdI0YlMFHDb8eJeKS8P7iYruKNqgJFhWRK6G0XAUF6w8byir0fWevgpNX15wqueKwoeao5cYBy1731a/rKpuvplE5Det9KIXqagjqwYQqVM5ujD3sdDZo4WuuWZYFlHAzykYYKZIkKPVwsSaZggvjXZ0k5pVzKsXBSIuCWO//0rBvq4ZxNyvF3WxwNy2TezR9UCnPuFcAaD0+YishuvkVfmairhI7St+ddwheh
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 18:05:12.5424
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40cdaa8a-de48-4a48-c726-08dee9ae1b5b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF0000020A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8286

On Fri, Jul 24, 2026 at 01:39:43PM +0100, Peter Griffin wrote:
> @@ -1206,7 +1207,8 @@ void arm_smmu_get_ste_used(const __le64 *ent, __le64 *used_bits)
>  			cpu_to_le64(STRTAB_STE_1_S1DSS | STRTAB_STE_1_S1CIR |
>  				    STRTAB_STE_1_S1COR | STRTAB_STE_1_S1CSH |
>  				    STRTAB_STE_1_S1STALLD | STRTAB_STE_1_STRW |
> -				    STRTAB_STE_1_EATS | STRTAB_STE_1_MEV);
> +				    STRTAB_STE_1_EATS | STRTAB_STE_1_MEV |
> +				    STRTAB_STE_1_INSTCFG);
>  		used_bits[2] |= cpu_to_le64(STRTAB_STE_2_S2VMID);
>  
>  		/*
> @@ -1222,7 +1224,8 @@ void arm_smmu_get_ste_used(const __le64 *ent, __le64 *used_bits)
>  	if (cfg & BIT(1)) {
>  		used_bits[1] |=
>  			cpu_to_le64(STRTAB_STE_1_S2FWB | STRTAB_STE_1_EATS |
> -				    STRTAB_STE_1_SHCFG | STRTAB_STE_1_MEV);
> +				    STRTAB_STE_1_SHCFG | STRTAB_STE_1_MEV |
> +				    STRTAB_STE_1_INSTCFG);
>  		used_bits[2] |=
>  			cpu_to_le64(STRTAB_STE_2_S2VMID | STRTAB_STE_2_VTCR |
>  				    STRTAB_STE_2_S2AA64 | STRTAB_STE_2_S2ENDI |

This adds for "stage-1" and "stage-2", while missing "bypass"?

> @@ -1835,7 +1838,11 @@ void arm_smmu_make_cdtable_ste(struct arm_smmu_ste *target,
>  			 STRTAB_STE_1_S1STALLD :
>  			 0) |
>  		FIELD_PREP(STRTAB_STE_1_EATS,
> -			   ats_enabled ? STRTAB_STE_1_EATS_TRANS : 0));
> +			   ats_enabled ? STRTAB_STE_1_EATS_TRANS : 0)) |
> +		FIELD_PREP(STRTAB_STE_1_INSTCFG,
> +			   smmu->options & ARM_SMMU_OPT_OVR_INSTCFG_DATA ?
> +				   STRTAB_STE_1_INSTCFG_DATA :
> +				   STRTAB_STE_1_INSTCFG_INCOMING);

Sashiko pointed out that this prematurely closes the cpu_to_le64()
macro.

> @@ -1887,7 +1894,11 @@ void arm_smmu_make_s2_domain_ste(struct arm_smmu_ste *target,
>  
>  	target->data[1] = cpu_to_le64(
>  		FIELD_PREP(STRTAB_STE_1_EATS,
> -			   ats_enabled ? STRTAB_STE_1_EATS_TRANS : 0));
> +			   ats_enabled ? STRTAB_STE_1_EATS_TRANS : 0) |
> +		FIELD_PREP(STRTAB_STE_1_INSTCFG,
> +			   smmu->options & ARM_SMMU_OPT_OVR_INSTCFG_DATA ?
> +				   STRTAB_STE_1_INSTCFG_DATA :
> +				   STRTAB_STE_1_INSTCFG_INCOMING));

You might need to set in arm_smmu_make_bypass_ste() too.

> @@ -5087,6 +5098,13 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
>  	if (smmu->sid_bits <= STRTAB_SPLIT)
>  		smmu->features &= ~ARM_SMMU_FEAT_2_LVL_STRTAB;
>  
> +	if (reg & IDR1_ATTR_PERMS_OVR) {
> +		smmu->features |= ARM_SMMU_FEAT_PERMS_OVR;

Where does this new feature bit get used?

Nicolin
