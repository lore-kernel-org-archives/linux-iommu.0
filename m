Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011006.outbound.protection.outlook.com [52.101.52.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDCE23185D
	for <iommu@lists.linux.dev>; Thu, 16 Oct 2025 21:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760650343; cv=fail; b=EK1sjyvl/1qsRaAKwEfkQ6ZgrmEfF6DNLMrsiXCg9B8MPVnXdRshUxLZLifhavlF1vkiR8BkEv63VScVAy76U/SkudSKQuUl4p2yn1MFBRKntg5xqVeGB+agqc+vzig+GCotSbdx8Ye6Kr60uTQSNasUYZ8RjMsJ5XemRss/bls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760650343; c=relaxed/simple;
	bh=Hrm7dQLBWG9Dv+hMUp5eCfQyRt7WJc4UwllagBbk7jk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dIk1tZQqZtfd0RhQSS2Dzi6efTjEAABQYBjd0ThD+og/iWzggiDPzMGgIyXToXCb1eQmOV7U8GzpWm9lR4WtxzWV5+LotWCgEdWO+DbeP4dPSFzMKB/frRLI/BxAfcbbzOY5e+beQGzPIKj/6t4+nFzPrOsPmUfUchzBM6uejpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g1ewhrn/; arc=fail smtp.client-ip=52.101.52.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g1ewhrn/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pIUZVLXV7OL82q5vLyJq3w4GTm7VHD/cIRQkmRGKbPEqLHI8BCpzZP1cT2nzLd8L9ApHPEAXgFL2ITr6orw80GfRQTx80mwQ4FlurdmHoE3zesNm4gUf5zNrx3oq8MUh6uTfsLVxP/aK9pMrv5lcoMMfChjBgEvn2VVMnG9kb2M0xOj8cEmB7SGxsyk+MfD19B/YZpLPwRDHo+jbEZqxnzyM+FxwMM+ZVx8UPwtTRfuZhcZI1m87JtFssOFxpBg/4KmOAdUH6ElhQcfEVZ5RS9fyT2vRapBZyIbEQLTpjedVgO/IWIoxa3a9iuDESHql+6cAwBJD9PYOfTvl7J7KYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mkXzIdQUUxuhiVY6nHw70guxmcPo1I5G7VKvcssMe9g=;
 b=uL+mKNLhbP04bUQQ15SqFmQwS/DJjyUyCt1qb1VA+oeS/UkU4hC3/DlFDiNuCTFrtcZBBJQrJFkkDcngR+jv24cru3mc+33N+j0EhZl2SyNK/bFwHL7rmw851diwf7H/GH46D9brTX8ZtZuUlBgIQPqlyPOUjr1lFaO76te5km5lsj1SmrHLF8Z9e+tdTYdLcRBd61u6/OMgaS/FGHxBmdtY8FFeP6xDckpG13oMPs9hleN45F9EGP6RRomSaDzYA01QxOX1twFZuop4VTQPDXIWcK1KN+BdBbOhum91+Hz8yDwP9XWTBFap+tt3SgPUs+GGRLSVIm+5cKXioTRXDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkXzIdQUUxuhiVY6nHw70guxmcPo1I5G7VKvcssMe9g=;
 b=g1ewhrn/ChFF5Kicz+Wqig8aEbBEePsRxMa1HLxE/h67nZSIPPwU4G0dIl7YF9h8K2wCZ7a79NQjXkR4X6BfPfw2KHZCIXzJIlNWK3cYxTYkqBweKMsRmxi3XIzg3GulZdAysQPY7OtL9oeWmUXURgoEgtIJW+of2zZpAiQpG7Q6cxwqR8kUhcf+afLJPU4mTy/jkh1a7fn19Z6EtWp+WcVFM1+/LKHMt1u2XbPd0y/MlsV30L2744mW5ld/YAolOmoF7UOUfHryPy99t6sgIZO884nwIWHT7uQj4iuVbVkBFQ8DkEfnH7FLLA3YSKF3+BHvtLqzamqBkTHRuj2HCg==
Received: from BYAPR21CA0007.namprd21.prod.outlook.com (2603:10b6:a03:114::17)
 by DS4PR12MB9586.namprd12.prod.outlook.com (2603:10b6:8:27e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 21:32:14 +0000
Received: from MWH0EPF000A6731.namprd04.prod.outlook.com
 (2603:10b6:a03:114:cafe::d3) by BYAPR21CA0007.outlook.office365.com
 (2603:10b6:a03:114::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.5 via Frontend Transport; Thu,
 16 Oct 2025 21:32:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6731.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Thu, 16 Oct 2025 21:32:13 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 16 Oct
 2025 14:31:57 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 16 Oct
 2025 14:31:56 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 16 Oct 2025 14:31:55 -0700
Date: Thu, 16 Oct 2025 14:31:54 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <jgg@nvidia.com>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<balbirs@nvidia.com>, <miko.lenczewski@arm.com>, <peterz@infradead.org>,
	<kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/7] iommu/arm-smmu-v3: Introduce a per-domain
 arm_smmu_invs array
Message-ID: <aPFkSn9Ta6koq91Q@Asurada-Nvidia>
References: <cover.1760555863.git.nicolinc@nvidia.com>
 <345bb7703ebd19992694758b47e371900267fa0e.1760555863.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <345bb7703ebd19992694758b47e371900267fa0e.1760555863.git.nicolinc@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6731:EE_|DS4PR12MB9586:EE_
X-MS-Office365-Filtering-Correlation-Id: cd7efca6-7e32-4e0e-cb68-08de0cfb78d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?as2VSWCP2B/76OglexfsFD3JLG33VszorkJlwFwBAD1utpvSg76K0DEEmVKV?=
 =?us-ascii?Q?71j/aKeZEal5TSTiMsS8w5Mh9+R4MFFeFtyn2JidBEdF+OBZ7uepV4NNbOTy?=
 =?us-ascii?Q?2zHjUVrRWXvF7Z0PCooAU53VDbCz9Ov9PCVEmd3/uxF/9ZJbrW4tidV6uroV?=
 =?us-ascii?Q?YQltC1Id5uR3bl76/Dd36wZt7MMltDdbF93dtcRAZTTGSTgwvegqOujikMV/?=
 =?us-ascii?Q?oWvOCWsGnfDUKrvtgmcFETVk6R3fKIn8FZUClTJMhaomh7rA4oNCCTi4X7yQ?=
 =?us-ascii?Q?LSbvjeyAekKKiSnDf0pGaF2aaJozLNQLzSJAMqv6VXJx+dJMcIPOVLKrsmrd?=
 =?us-ascii?Q?PZSAG+RVsP0y2eLNDpUWxQlYoHeNC8DLNgcXlNJ2XuWqzYrrb4t8cXyhb3B2?=
 =?us-ascii?Q?MOCR2mDZzJwvyReDNBqhu3Ruq70QfQImFWXWojhO/qwNNsKxIfovmrpFzmwR?=
 =?us-ascii?Q?4mXLBsMov2wO3FQNDjOpPphk/NccqchtYvX3+0KdKpKMByA+ksqn7Oz8S9ic?=
 =?us-ascii?Q?khY49dRMLWIkvMHBcfI4dxt9RA6O3Or4xUIPMbdPWucK2N6E36Pyh8cBEGj7?=
 =?us-ascii?Q?yTxLfcU8wpZTNkJjfngqXdRJcMeRnCwHIOZTbAu7pExkXMYnSinqLizuWtGb?=
 =?us-ascii?Q?+Ksmx6S9Ot6yLTlW7r+tXoEhxotd8lk+QKerJrXTNXXEDnc8OsTFXwX9973i?=
 =?us-ascii?Q?QkSbcsqFtxBuCMJ6z0M/e3hnX2z4GQsAXFiMSgrn7MMr1b2Os1EiaQrLFSGd?=
 =?us-ascii?Q?3MQy17KDfRECVhHBu0CMLpQhLcmpeeshAI4yJ3TqkWdIxCogwgNOHJK4qIrY?=
 =?us-ascii?Q?sCL/NrqrlwMxJToquXwmJzDqQ8zMt/rdwk8CbXChBLjCRFa1Yp76sHRs9Oyi?=
 =?us-ascii?Q?adgl5WbaxuFzHJgsT2dbAjhgg8o4tA6sezbz0lmXUG42EhjDEk94DtDim57N?=
 =?us-ascii?Q?LPTzdHz1s+UPu2yTe+m0tosMKse6Mro2+dxMMbwdOzGKIhraHFvroTd2FwJ7?=
 =?us-ascii?Q?ZDbsJxdFnF8ivNDZzzLF5+AnouNWjaqugCJU5ckeeW3nIScyBKnP/KQr9Yy0?=
 =?us-ascii?Q?lu+J7+hc1Jjcxf1qi6JKGK6iPA749T+XkKtUR9ANwHLLoN7e0kiE27THRZvo?=
 =?us-ascii?Q?CAIFUgNifThJuOsgfNj+rQSeGs6HsY/VJrBiM0f1HvvEQF/2700JVXWrgyBo?=
 =?us-ascii?Q?lMN/44L4c/hWTiA/Ea/iV6jT7982sqGTos2Tx+nleuYZJhEDJw8TgoZ/xB03?=
 =?us-ascii?Q?qPNIzurXpXRIGtAu4tG2IX8NpiTxYvrgc2TXp/48zxVmWPhl4p/F6/lMfC9A?=
 =?us-ascii?Q?XunFEc3YqGtKFgJnRBgjTXMZRjNmbVKE6TH1SYXlcrbDLjmJi+GZIZZROvk1?=
 =?us-ascii?Q?lbEQeNJmPBU4KYThxuDXK9xVR4XJRU8s5LOdLaXlD4R3TdWLdglpui9ED3wO?=
 =?us-ascii?Q?CeJo4RXQHdaqFoKgoe+tvVaCh2+9qVBWBSAKwqcv0nw6xVKsFVr1azRb8TXj?=
 =?us-ascii?Q?SeHNJWDPf7TqwJo5+yv9pQtdDGF5dCoZthOBSxAUwHqr5uHHN1F6hYpymQAN?=
 =?us-ascii?Q?KScQrZtW7HehZPb1ZL4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 21:32:13.5534
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd7efca6-7e32-4e0e-cb68-08de0cfb78d9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6731.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9586

On Wed, Oct 15, 2025 at 12:42:48PM -0700, Nicolin Chen wrote:
> +size_t arm_smmu_invs_unref(struct arm_smmu_invs *invs,
> +			   struct arm_smmu_invs *to_unref,
> +			   void (*flush_fn)(struct arm_smmu_inv *inv))
> +{
> +	unsigned long flags;
> +	size_t num_trashes = 0;
> +	size_t num_invs = 0;
> +	size_t i, j;
> +
> +	for (i = j = 0; i != invs->num_invs || j != to_unref->num_invs;) {
> +		int cmp;
> +
> +		/* Skip any existing trash entry */
> +		if (cmp <= 0 && !refcount_read(&invs->inv[i].users)) {
> +			num_trashes++;
> +			i++;
> +			continue;
> +		}
> +
> +		cmp = arm_smmu_invs_cmp(invs, i, to_unref, j);

This should be moved upwards to "int cmp" before if.

Will fix in v4.

Nicolin
