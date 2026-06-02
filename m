Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013011.outbound.protection.outlook.com [40.93.201.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2CB282F21
	for <iommu@lists.linux.dev>; Tue,  2 Jun 2026 00:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780359290; cv=fail; b=nA9wV4qtB5DLXWIUB9xD8sRAJvuvBiCREVaVzlvVgTnA+LslqMA5rQzE1livUrKaMq+cyqA7wr27e5EWztA3XaUoDR0UQvaRvwuk8dFfAGBVk531jHrfukxoEyT/GaE+GlhMhyoq/+F6+wbq5QZZVLPSGb6q1RNsIAlJD31ER+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780359290; c=relaxed/simple;
	bh=M8I+yY3IizoEMIFPLtC8+3Pi95GdGjYSAA0a84sXZBQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMyY9AmfO4PC92LOl8gYuz25uqnFKwSZPFU9o0nHgeBvDHRnWx+8WrEqdvGgADJvM8bg0sj4CGeEUTg4/lM+/WY0m5PYiqnEF7DOC5XR9QOYE0w/jwF3Yf9m8mAi8St1pfYl/xpvLkJ6iOidRAoLIeHZKHEfsnQ678YDlFGC3W4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XUrlF2SM; arc=fail smtp.client-ip=40.93.201.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XUrlF2SM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AQB1tSgWnCR+v3EzSYoOILlqjWDqunmx7TFq/QrRFfqrhhmNugkOPvBTyRA54v2IkX+VBUa7iAGvW0n9lvjFINc7Hl9JG9tneN4G2+Vs/7y/L9twUtyxeFCOmBeEyQyEO3TvebFeZFZ+jeM8ZhlZ5PdQhNEFyzuioFdvtQjkI3z2/H8KjqETbijeMoAgLmbana1Feuzw1QZvvMFsxZHFQWTDxbjsRuZ1Tc5UgxjR56G/sGBD1WiYoU30tXDNeHCJ5a+1YDfCb6tpcho/Fhk+Ikkk6S7vjF23kBafPS2AYso/yvpxoH0uS9yEKE+q3ClBczRygKXyhdArfZDerTQnvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7E3xrd1Ao2OD0/y5EPt3EtYMZF+xrwUqgzXcICqQTs=;
 b=w1MoTuLHa6lqbXtLaxFESqSZC+OPZTPePu7mwcOJqRFRn6fH4NfzKLvRhBqOcROLRGGfUMf3EQg1gsGG7HTnPLEZ2NFRpbQXzU9TLkAVrvv2GKtjQ2NNwmxCy5GsQl65HiavhL03Abw6ywKnnBCKw9QnU2/H40Ngx2YLd2Ex/ff4hoWl1p10GlYxXPJOq9O7ljahpy4XJ8dvRmnFFHE/YqxSYVTtSErB5B7lw0BCLe8ZXP4ZVJqeea9+0mu5x2sdhABB2y/xwcX+Des7FQwxDArwdjowsUKGL3PF6bkfvJuAROf2hVp9bJ8leU4tQLkk2u2ZQYw+nTEHcBUtf9pzAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7E3xrd1Ao2OD0/y5EPt3EtYMZF+xrwUqgzXcICqQTs=;
 b=XUrlF2SMlF9E6VEqMElSHO64wW+OQVGWASu0913XGp79oFf+ZnePvGu0uCAZh4wK9m4xy9D2qVbvDJ3Pcqs2tuGForOiOUZTM8YfJ9yGMm7zvTtGrySx5qAe1zN27rZL/QUTkiBNYEBaqlLJHRCuk7lReAFVXyni+CW2H8jidIyHwpqZLjOrEzSjJdRrr/FmUZZjNHMZxynY3Pn9WFEXodp5S/Dy28KTjdZSFb9cdLPKmicF+vqbI6BVOeklWzTJu5Ecjk1TcbohuLOeJj4sGRkWMtnhitzy2gIQ/zptw8vfPGS8Pm0FeMneM9c9sCHYXBo3EW8X3DyxjTfgw1fu3g==
Received: from BL1PR13CA0018.namprd13.prod.outlook.com (2603:10b6:208:256::23)
 by IA0PR12MB8645.namprd12.prod.outlook.com (2603:10b6:208:48f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Tue, 2 Jun 2026
 00:14:45 +0000
Received: from BN1PEPF00006002.namprd05.prod.outlook.com
 (2603:10b6:208:256:cafe::67) by BL1PR13CA0018.outlook.office365.com
 (2603:10b6:208:256::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.6 via Frontend Transport; Tue, 2
 Jun 2026 00:14:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00006002.mail.protection.outlook.com (10.167.243.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 00:14:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 17:14:26 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 17:14:26 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 1 Jun 2026 17:14:25 -0700
Date: Mon, 1 Jun 2026 17:14:24 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: <iommu@lists.linux.dev>, Will Deacon <will@kernel.org>, Joerg Roedel
	<joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, Daniel Mentz
	<danielmentz@google.com>, Ashish Mhetre <amhetre@nvidia.com>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v8 08/12] iommu/tegra241-cmdqv: Add a helper to quiesce
 VCMDQs
Message-ID: <ah4gYCgSO1bBOUTj@Asurada-Nvidia>
References: <20260601215909.3958732-1-praan@google.com>
 <20260601215909.3958732-9-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260601215909.3958732-9-praan@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006002:EE_|IA0PR12MB8645:EE_
X-MS-Office365-Filtering-Correlation-Id: b9fa41cc-05c7-4070-6ac0-08dec03bf3a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|82310400026|1800799024|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	1PZsvNbOTSksOpLZopbwJfN/35SY+6mlVL8ow618u7L2nw35ztPSSCwQz2dkrrEiDiX5VscHwz2QxIr/wg6rYAY9GGHn80HFJPT0D1/nyId7RJyF9SuX3k7j/OXtV/gY6LuuZqQmE7cutFzeH7oiPLeSs2sUqzweoSDFo5ZA171p98Mgd0YUBG3WggWOYQAfAr03iRm71Fpuemt3lY+iCSl25S+DgJ9kCnX1yJSuC7G65NHU9k1OGPdy92sN57/VomfSqfsQvNgsNf5fc0TKgYClKgu1HOLGC7qcbv7t5dhc65uzrjgNxFtef7gDt7+DVavmR4Src+EIaUWwBtR8EfgqPvvLl7UlrSrFFEK6bC8NJ4EJpYRk/ug2Y90QRvh5fwoYtHZAJHgtFc3jaPFBFtrNDTtWMMXpJkA8DqKe5ie1re1stx+wCB0XyZhslsI0oPuYq9JBu7oyEqsPi/vGK8o731NKAU4mFHu76EBDCQEUGUFI7wUqhbj8JmUf0/RUeoSPsXpss598E37OLcFTKOkQ4j+qbL9y9ZVdBOuG12+6Y3TUmv2Je+eARUXGjQ40Dh/LUnUiYEP+GW0YWDxp74Q/CI9ifx5iKiqQ2Ru5hk8LOjoVyDS5corvVL/uXEh6hk4do4wA/j1CgyPENS8eGMVa3CRXEDpO0Luwi/SocOkt3G+rAVJ8aEDSvADP2QBrZbc+escSW1Vcp/mIUF0ppesq3Aw/lwTHuv9wAtdaE80=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mOXQYzNR2ssB0vEzjdDpKHkABt2XyaeDROUj+uBMGdMbQvs5ehJn1A62Y5pek0uAmnQMytqrmSUCfUkQDQ5DTKZwKo/NxOWPF2vceYSsjY405l52f6trslXIm23GddTKcFbI19PAO/l0/4JSOemjvVPxnXTYGJcuokxTM4jtORDgzBuDRmHz+mwtwBjd4jvcigcef3KjrK3Vx0xZuOoQTonPmT6tH1ZzqQlCd2262SLAYbwyUidf3o4qo9bXNDYLzrp1r152fNUBy4s86fLc2FLyBMFvqBSmMus0YcpFwBUPXcdXZl29w0DUuCrdYUiwopP73YMxRRJKFGBaIhe55ISAYyCikKbQOf6B9Ri2UZGgZIW3s5FV9BzQ0L9ayhn/u/5ZYcOi/eyjJFLi477jzE3mscQflP4EH0/eWs62haxh8c0B5Dnw1NaJ3CQi5FLc
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 00:14:45.4277
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9fa41cc-05c7-4070-6ac0-08dec03bf3a2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006002.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8645

On Mon, Jun 01, 2026 at 09:59:05PM +0000, Pranjal Shrivastava wrote:
> @@ -887,7 +887,7 @@ struct arm_smmu_impl_ops {
>  	size_t (*get_viommu_size)(enum iommu_viommu_type viommu_type);
>  	int (*vsmmu_init)(struct arm_vsmmu *vsmmu,
>  			  const struct iommu_user_data *user_data);
> -	int (*drain_queues)(struct arm_smmu_device *smmu);
> +	int (*quiesce_and_drain_queues)(struct arm_smmu_device *smmu);

Hmm? What's the point in PATCH-3 adding drain_queues then?

Nicolin
