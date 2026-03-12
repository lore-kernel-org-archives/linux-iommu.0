Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010031.outbound.protection.outlook.com [52.101.201.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F97326928
	for <iommu@lists.linux.dev>; Thu, 12 Mar 2026 22:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773355840; cv=fail; b=pWIivwkWLeqiwlkrwrfoBcgvU28L+AsHKWJ3srwKqzQSmLyAY3URHAeT9rJxwGDIXmbyeEQJmbg2tlX4R5Ce86BktYYofbid1+SQYNQX5sf5WsWl/fgOBLfZwG7GVAMbR24O+SrjNdr5WgtCKuyXMYS0KLHngxC5JP97hpiHrZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773355840; c=relaxed/simple;
	bh=rBGqw71jnO0F6JWvO2uQYboV0NaPs+GiyiWp7AdAJIQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TN0jDPVW3iCIO/aQz29wad8+p5G2p6LQBDmJ6l9GAv3hglwPCg4o65/c/er3I+nmsoNCA8x+YJ2VeQcoc0UrC9UNNo4jY0AjACXyp+lsxgU23KCjB+gAmPeCDo8srScxdv9hvTp/8IUM6V/Fwuo22LvFza6VOjWHRbFZKb4lxcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UcBM+FIJ; arc=fail smtp.client-ip=52.101.201.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UcBM+FIJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YIYvOb9Mmix0i11tKyEjnU4LG9Exl9NikuF1DfEQRaPUCrdBYTNrd3Hm7/sjTe+wI4H2VruumT95t+CB4bIJHK8BBSzE00vb+UgiibJ4syN4AlBoTBSHGQkZFIRrvuZQtezGZHHp+lRvfDrP/XT8JntzCTTtvw+SzGXo+FwV7aep+l1GHRWoOMSNJW5M688NYAAoLFx/PrOQu+8BddS4TVKxFD7C+pvWYet84Ylscx5HUKXW0VZUHvisiIBp07tV8SmW5SDA/YZvra66semvqwsvNP+KWTL+JWsTgV3nVyogGmsCoRcnAoWwmZVkNGaBY15wYy1B045Upq8sbJ57IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E54psImGNfS+wUOX02Nf1vwI0Mzm5awsBJNd8JsUlt0=;
 b=V7mMR2W8Fvjs6ubyfnxXFbyXbVN5P6k11+z6mC96tX49DNAK4Pjs0msLGO9yx8Y5E3TsLv5EsACBrQQqVkWh8AUwnYXTjNLz+SW46s1mQhcRrURPsI1vOfzMV3xl8WyUKGTTF65hwdYXiG8xEJbfOmu9JLQiTPlwKaH43zt4n+eyRiaCPjk3W+tvQ25qAdUxDAtNmbygmv2yxh6jAnOqFCiQTlN1RfA0SHkDUZSrMeanyQnxJ7GJwjei5A9QHbGL9pIuNhK2Al60Wc4+7m4UStVs1NU2cx0ngssNKlAfIhh4h+clSFM91t2L2YVMXC5q9wuiY/KsSFFycwXvvISIzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E54psImGNfS+wUOX02Nf1vwI0Mzm5awsBJNd8JsUlt0=;
 b=UcBM+FIJn8iLlhgZDy8ieTYVPJoKlzw4BlOkPIdv9CRi2iVvQSY4dSHjTtbioFemRd7EBoNg46ZEV4B5VnDQyCfTRUXtiofLA/2WLX1iys4z9InOAGQ4niOqK+KReVzVTxAEZTk2g8LkMVuiOATlcifNWxkqCZ9qizJlZ0Y2+eMEXoTV9fTKfcVtKZvT/4L6RzOX6erfj1UalBZMbuteX7o+QBbfYR4qBbIu/yCPc57wh6CUAiYH4lxTnIEV91pI5/72+fbluvVD9qUMPzj6kP/fOJigWSHKHCaghcbbg6LsRX7PH5pa9DGuII8KmCgkt6LzLzLu+/58HW8LtFdTgw==
Received: from CH2PR12CA0024.namprd12.prod.outlook.com (2603:10b6:610:57::34)
 by SJ2PR12MB7944.namprd12.prod.outlook.com (2603:10b6:a03:4c5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 22:50:35 +0000
Received: from CH2PEPF0000009B.namprd02.prod.outlook.com
 (2603:10b6:610:57:cafe::b4) by CH2PR12CA0024.outlook.office365.com
 (2603:10b6:610:57::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.29 via Frontend
 Transport; Thu, 12 Mar 2026 22:50:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF0000009B.mail.protection.outlook.com (10.167.244.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 12 Mar 2026 22:50:34 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Mar
 2026 15:50:21 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 12 Mar 2026 15:50:20 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 12 Mar 2026 15:50:20 -0700
Date: Thu, 12 Mar 2026 15:50:19 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
CC: Pranjal Shrivastava <praan@google.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <jserv@ccns.ncku.edu.tw>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Allocate cmdq_batch on the heap
Message-ID: <abNDK/d/8CpLhcyb@Asurada-Nvidia>
References: <20260311094444.3714302-1-yphbchou0911@gmail.com>
 <abF6un_jrQ8zGZZ4@google.com>
 <abMEybRcTskHOjd1@eric-acer>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <abMEybRcTskHOjd1@eric-acer>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009B:EE_|SJ2PR12MB7944:EE_
X-MS-Office365-Filtering-Correlation-Id: 23f9664c-a757-49de-38a8-08de8089c5d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	/9ROpbfTbSjDJW8Sxq4jfYJKq8CM2zXPvV9Z2ArPl+0gHtIF4fEKt1dPmNXRnrxnsNwfzqKRZZgWdywBEkQviVJe+upmpYE2vRQQmLqWzvRbjkGixK3J+0vYSnxJRlOM4NqGy6TmZLoowpoQdcTnubQyjdWyG1sH6uX1RGNXC0Zs3hoqhhlpW4BVdiSxgCSJXay+TQSR7+eUdNcExFw3MpuguBJmXKv1bfUFaDbONg6HcbHOwM69c3FsetkGaicieNvYM7C2aF3nRHxqYkUhMqg+hqKO/yVlFSvRusX233wni1RUR7md61GtYZmklpBPY2yUMPRTy+B4qc1PrMsMIAN8zQGLSnYL5kmWN3/TlIJ+Totz1UXWvHOum8StoPbBnVncQ7vhJCLks4vNrVBN9VKgufyvHwuyolpIXtlHkuMhlJ/vML2NBIy4CkVxrqkafe7VzMWLWnh9by+35wQBlTls9LX/l13WIhQmn80WFzuNHtUSzh5s4PSJO7O+qTusmYGvAjD2IR4NO8qyi7dUNbU38s1wV7SMPoFmDdqSlHuNja/J3n+Vgeho1xsnz+Ds448X6thZGIoDhAjnK7+dqfFRwIY8fowtgVmh54YX1DMmer6c8vj10kYrGqRuicsUQk3p8aPDt4jXi2TCOKKP62E5/Ac5icFrJN9cn2oy+GCEMdmZQSYFE76CT2mFW4U1fwaOciGi4R0cSQswe4vKieQt7xad88dbi3i2Ogb0bqKn4pMToHJO3R4BHtqBFpStLk0j/Ed60xsAjd/8X6XZHQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	AtfE4WH6ZpDJWnxsLV8k94GGDWjoGHjTgo0Kvw0Risg4wwMHS9gNfT3z0pycfTcJp6FEFXCJBVuJ7Us8J2FHYMw0HXZg3EtO4We7vG4jJ1bv1oSi2nlhxMPF6Fo48vBN64BkiIuxnbmWtoXe3Y/nBbc0KjsT7V1tIrBM2eCf+Cl3ilJnjfRIBZcEVCb2tryWb4Llsaq9+km/0gtH2EB9K5FF/qpni7ejLrI0CdAJ3jEERww4gAMHfe+QQsl8SlN7MEmFNYGiJID7hJpSD15kcS0dqRFIdj3QAc3MIj3KFeZH/DKgB4d2MgtIfZ/bfw0MCkZid4RMugpkPXuDoS4NlfZCwBwHLE/A3GyXlu5CfNoh74tBLxK2icaHGSUQmF3XNtfLlG801TOdtZomntmr7zYBTuIeNg7ghmlBltnF3RPlXAtqXdoiFn32vTXYICh1
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 22:50:34.9974
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23f9664c-a757-49de-38a8-08de8089c5d9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7944

On Fri, Mar 13, 2026 at 02:24:09AM +0800, Cheng-Yang Chou wrote:
> On Wed, Mar 11, 2026 at 02:22:50PM +0000, Pranjal Shrivastava wrote:
> > IMO, if we really want to address these, instead of kmalloc, we could
> > potentially consider some pre-allocated per-CPU buffers (that's a lot of
> > additional book-keeping though) to keep the data off the stack or
> > something similar following a simple rule: The fast path must be 
> > deterministic- no SLAB allocations and no introducing new failure points

> To resolve the stack warnings, I'm considering using per-CPU buffers in v2. 
> Does this direction sound reasonable, or would you prefer to keep it as-is
> to avoid the added complexity?

I don't think per-CPU buffers would work here either..

arm_smmu_atc_inv_master() is used in a preemptible context, while
arm_smmu_atc_inv_domain() can be called from an irq context.

Think of a !SMP case for simplification: we only have one per-CPU
buffer, which is not enough if an IRQ preempts the task context.

Maybe having a smaller backup array on the stack that can be used
when the heap allocation fails? Still, I don't see how to address
it elegantly without losing some of the performance optimization.

Nicolin
