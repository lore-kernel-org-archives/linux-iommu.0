Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011008.outbound.protection.outlook.com [52.101.57.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51051470EA7
	for <iommu@lists.linux.dev>; Wed, 22 Jul 2026 19:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784747815; cv=fail; b=eQrraULMlL6y15cnHSiu6/g72xfQbKZp2WHvMWUR9ogOtv+nJNLqjQoJb9vMJ/9UxhJ8+gYOMJy2psu+pEgnG7i2ZL+ivglAUNly5k6wlytS0oOxKKmB96taqYQEjBUjy/HQLkIQyOB+xKp2wGXIikdiLYSF7niessSn6RRTLyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784747815; c=relaxed/simple;
	bh=UT+7at3reLk72OAxo0YRcs/TNbiazHh3z97IJfMnv30=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b4bgiErE6quPusosu3aGhcxF7g+U5pkeTzUdIZE7Mx/IVdcszl+11+spd4xk3f+QrzxgX6EjY5LbI2h7MaVZI8v34s/JMa5LNdIyLPXgY/awuekuwK5xNVzn7ZOuo9Lf8QwstZtsGzku13SZ0exLuz+JFaHsU//OdXrRHGF4f0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o0Oozm5Z; arc=fail smtp.client-ip=52.101.57.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o0Oozm5Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QhdjYldQ0vJ4gNpZHLCCryF/VmD5TrSqOEBYQO0nkWULB+DMusUwQU7zKFkglFAOO0Rlknjc4wLcOblnG4PjcBiM/p3KlfwaRSWzfGSLVge1Py9tJw7btVdvGOWJHV9JeipiD2xKgv3rkPj8DLj+Mpr/UwgEOTG/yg4C72oxGPqwk112fzAe5H7y+rtshVlmiPxOvvZqxKIXprYf0a0nlATEIZPhD+qyb+5aM0roCtVDze3pqFD7ObP48jVic8TkXFTU0CFqFGllXyuggEw7LKShii7JRNVDFv9J3mTohwiCpakuwRWiESkaNaM4xmtIz4+huqmfOz9Ta+eKgMbdbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3TUIOwAx9iMCcpjZK9Bk6/1kViy52184lx+2A5+gyJw=;
 b=lmz6FAbjuz/oNlC0MNdOvkM9WYBxHx6Q5sAiFOiuaDW1Dwf7y9eiPW/SDs1j6SEmW1mj9GC33bGQi/LDgyD/3H1g5v7iwiMoD2AYfKuq4ToMMXf56tRDyLSG27/ce8aDkpWqXlkj/7ufWc7CJGx7EHIF7xQ2W/q3svAPNhmSXPKFTswqF9OJunNH40VL83IMphvhK/cnheXhQgOjuag/+Th1yKjZ2nRbQc7AzHxvKxuIMHbCgXGPnPFcit1Kq9mkcJ+8c7dXHlTgC1sKHh96lCL1It4CV6oQ92IL8RSuRZWKpbu7VvSSyq7rJWomdLSb1rqZIRr3iI4xrY6QhZAPvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3TUIOwAx9iMCcpjZK9Bk6/1kViy52184lx+2A5+gyJw=;
 b=o0Oozm5Zb/KqBvhOpqxqbU41CCHD2t+G9HjGPliQcxWPx6dc7PKtj/w0Sa24G6OTNSE2QW4i68jh/Yx1SprnzcC7LWBTFOEheRHj3689141L6VfjCl/PjGzL8UtopOwa4S5IUYyI82/zxhNbY8DI60f95JwFHH7HEWEU73sTkJyfuZDbi0Zg3CT1ogSjLfIUD6AIVPwcxdz20dZMjKK23YPoaY2lAkvvB/SV3szJFoQwNeQnC++ENsiq1/bbeNnlRHXbyL17Iw/Wl17Jsu0RFuCgJ2/JVtU7YLhnDVwzxlsvKUOWvRoeNlBFadtoHDoj2ZkdvXLXfPEHWrunrS+xuA==
Received: from MW4PR03CA0306.namprd03.prod.outlook.com (2603:10b6:303:dd::11)
 by DS7PR12MB6189.namprd12.prod.outlook.com (2603:10b6:8:9a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Wed, 22 Jul
 2026 19:16:43 +0000
Received: from CO1PEPF00012E84.namprd03.prod.outlook.com
 (2603:10b6:303:dd:cafe::35) by MW4PR03CA0306.outlook.office365.com
 (2603:10b6:303:dd::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Wed,
 22 Jul 2026 19:16:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF00012E84.mail.protection.outlook.com (10.167.249.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Wed, 22 Jul 2026 19:16:43 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Jul
 2026 12:16:24 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Jul
 2026 12:16:23 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 22 Jul 2026 12:16:22 -0700
Date: Wed, 22 Jul 2026 12:16:22 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Ashish Mhetre <amhetre@nvidia.com>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <corbet@lwn.net>,
	<skhan@linuxfoundation.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@ziepe.ca>, <linux-arm-kernel@lists.infradead.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v8 3/3] iommu/arm-smmu-v3: Enable CFGI/TLBI-repeat
 workaround on Tegra264
Message-ID: <amEXBlsOiDyAvZ0w@nvidia.com>
References: <20260722102033.1122277-1-amhetre@nvidia.com>
 <20260722102033.1122277-4-amhetre@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260722102033.1122277-4-amhetre@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E84:EE_|DS7PR12MB6189:EE_
X-MS-Office365-Filtering-Correlation-Id: f66b8ea2-0c1e-40e4-a41a-08dee825c412
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|1800799024|82310400026|23010399003|10067099003|11063799006|4143699003|56012099006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	2/0h8MJeqBNLDBn5nEXb8JXQSqHb2nTcDvXdd4KBqdpf6wOKztnWqbsVzT8mUnl2OBO8/8JaxSQ7anPVaO6o+rVpMeBxWbI10bilIsemzEPdsLXJApZ0yH6W5kpIw7bikvbn9eDzycc9hns5Ccu2tJxW3aWELcVvbcIaF/ii3EfmFbYikHPxtfi/iZuIE4xZpVY/wTzEs/9wdn8o+Ccld0bUdBe5V64oD3RHanx929C9Qd57bOHjcP7J2PxDiexo7vphdgFR0JTW4r/oC4Q6xPnQVOefIHhu6uVLYo3QV7/zGYq3ifbAuAIu5n416TTRVujeUkCOSqMATxXNA+pM4T2EfPx/nNIjCSdqptPsXM3pN6fF4xu0AbWdG1U1+kti56+EaB5H1S1P6ubn9e/XKHzds+Ul3YkdiF1g8EGHePtHH2SyXJrxtpgCgeXGGxIWLzzf7aeGtfttwOxw/07gVgnWeQM5k2ty5BGMb64dv+LzAlxpQSgeyik7ia9geHvh5h2t+fn0ohV0228PF4ieeGMFRuNrce5Ml2fdoZdnjMf7RD7lv2D2amKbT/NTCK9gD96IB44aV6BuhiQne+tKNQkl1ff21EHHNWlcsTGPPP1DB9uKp/0s1k5naEFsGYONWHcqBejhDu7ZrrnhKpUpNjhCfHio7xPx9tfg8P8r0S7KM34N/S5RxsGIbXOkfz6u+iggbBiVye+5AS/cPLJ+6w==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(1800799024)(82310400026)(23010399003)(10067099003)(11063799006)(4143699003)(56012099006)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SU3xIr6b45lw1W3J+DaXPt4BZM5ssTwduXVef6kIqfEKZWT8p9MFZuzeP16x/upeIn0fDLrhaGmRRmoPOxwMFwbLeTFg2KliT9vMO9RCbeWO9mUam9n3Z+iLtY+7ZIWB+ReulcZuvD5rPTamcM+qptUH5Qr/noBJ0kYoUUzJbOlHaSlwR/Re4/Z9F4eOBLBNABogPwb+T2+bGhFwcPSe6NsoVw/MpV3KhNhpKLF3VyzlheAborRsbJ6NrAuDZy+ZrRf6qSmZQR+u6RgKaGPbONrWHnggRCtfYnsLnXxKvabeVUYLenCyBtQIvIIHmGeQluUbZHWdRgU8YkKF3qtlw0pENghQaPf1Ok089Y3pEsfuhbyebaFvBn1CS81YqDD7IPqTEfAD7UsPC9uW3HUGg9k+5oU0MmYl3PoCBjnIOCpChHUJp9jINO6yWcCGriPh
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 19:16:43.3267
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f66b8ea2-0c1e-40e4-a41a-08dee825c412
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E84.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6189

On Wed, Jul 22, 2026 at 10:20:33AM +0000, Ashish Mhetre wrote:
> The host repeats only the invalidations it issues itself. On a nesting
> setup the guest submits its own invalidations, either directly through
> VCMDQ or via the iommufd user-invalidation path, so the guest is the one
> that has to apply the workaround there. Report the erratum to user space
> through the new IOMMU_HW_INFO_ARM_SMMUV3_ERRATA_REPEAT_TLBI_CFGI hw_info
> flag so a VMM can confirm the guest runs a matching "nvidia,tegra264-smmu"
> (or otherwise double the commands itself). The host therefore does not
> repeat the guest's user-issued invalidations, which would otherwise be
> doubled a second time.

I think this "enable" patch is doing a bit too much.

All the iommufd-related changes can be added separately

I would do a cleanup:
 - arm-smmu-v3: Factor force_sync
 - arm-smmu-v3: Add arm_smmu_erratum_repeat_tlbi_cfgi_key and WAR
 - arm-smmu-v3-iommufd: Add IOMMU_HW_INFO_ARM_SMMUV3_ERRATA_REPEAT_TLBI_CFGI
 - arm-smmu-v3: Set arm_smmu_erratum_repeat_tlbi_cfgi_key
  
> +/**
> + * enum iommu_hw_info_arm_smmuv3_flags - Flags for ARM SMMUv3 hw_info
> + * @IOMMU_HW_INFO_ARM_SMMUV3_ERRATA_REPEAT_TLBI_CFGI: If set, user space must
> + *	issue TLBI/CFGI+SYNC commands twice due to a hardware erratum T264-SMMU-3.
> + *	See the description at arm_smmu_erratum_repeat_tlbi_cfgi_key.

You can follow the kdoc style as enum iommufd_option.

Nicolin
