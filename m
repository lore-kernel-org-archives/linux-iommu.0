Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012008.outbound.protection.outlook.com [52.101.43.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A03B3BBFBF
	for <iommu@lists.linux.dev>; Sun, 26 Jul 2026 17:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785086426; cv=fail; b=oZulTMpkJSNnn+PIbW1yImi22lPC9PzSNcOy54RzREBd2HcwFQfcSAEFqrNxsXr0ks2+MXDBKDJQRaj6bDy+WJ/yfoyHb3ofwBHtDRzGEan2gVoGxS7f+UXV/shYTxkZjPxVERuqV8NQMaPKk/SW9bHQ3QYD0qDS9cs+DucJ3ZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785086426; c=relaxed/simple;
	bh=4bpp9MbiKQu6XKylVuvzC7I8il40HKFxr7DOlSOWfP4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ScZBvVthaYQlqkDcaJu5+FV6l1iRW6ZqaA4nP9KpF053dlq64TSBPpaLzRtwSkLvTr4K9Geu3f6xbz0MIE5RdT5fGT9MyaIihfHemDHWHO7RFjgIuOqcB4DB31YHa68BV47fmzUVmAoPcjM8hcci7m8hkRdcMTVBpXkCC6hu/nU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KYiU+NW6; arc=fail smtp.client-ip=52.101.43.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KYiU+NW6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YjITlDo8nr5x5h39ap58YsduDqFBP00TbmFQF3go1DCKKqd62MAEBgJ6koC3Q4W0JFCo+2gcWxUxxNGqN5v0d60uH9TGcC3OPiIBh6KXNMCUd9xd0z2ajdUC+mKkK7xwJJSfTkYUBbHy0bO8NHqBz2Sy2VYh7sCIQZJBDtCH3+WxGIp4/SoId2XQhke714pqFKgBoi1vLPeZoOWdIx8E/kz6+/aTBuKMo6+CWpPpx51HiES7GyBNOxeiN0vnqilBPeWn+284puVhaaaMOFRViFXS/haDTzp5+pJpC2jYa3EwAgY/UEOxQac6jOFkrcyWCKf7YcL5ezMz9c5BV1y+jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kFUfKVcWOcUWmCKlgCAV8U97HptbtlCZKYXRFc9G/HM=;
 b=x+p0FTApt6GmRVbkasVpKolQmUT8dbwTzDpzoGER+tPEm15rbpZpUNPV1DpFV7bxo338T9yhcWuycV1l1hXr77YnpI65aUQV94p6wuJ8dqrgnOrwXIumfZEozRexKhSdiMf7+Hkw+XvbHjdISpwkTFWraOpETuh3JaB3/3/VEd+IHY3OlX8eNtQyupdTwbrS3HR6ibsN+1Ov8DXC07RUF0vIwAU/KDIZXxbcCC3kmYZm+1igT60z05mdT/VBXawK7/3PTZjb55TMk2yMsD7Z//OOyZgi6DmGeiOkeJnNZQOhrAdZNYlJGGIlm+gEGwbukeKoVOq5mHKHqREEFS9xxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFUfKVcWOcUWmCKlgCAV8U97HptbtlCZKYXRFc9G/HM=;
 b=KYiU+NW6Gw12+syaj1GDyQSzHNZDZN9dJzJZ1dg/kSOv9lPEZKsaBYE9Iv2uHuVtaHo7G9sNVHaialI3lrHt9V+AMdsGyERl3XuQBdhx5HNUmSZHQ+NVBXCXkkAQ2O8z+t0crOg9EiYZQR42MX9CqnNHTI7OfbJrZINPMjZ50E44wBLYphOad3rc89LriBokhOkR599ifzyLCEHu8BmoNvSr2alqoyBH6LzPgduXrM8wZgdXhW+bbUDYo0VvKrK8hvrx3dnTuDfX6ft4qt6am7jlNi5VNXfXDGd3PxIuWVUBWNBsoX4ggoMdJFOcDUazGy7fOLrmpCEupscdBijX8w==
Received: from SA0PR13CA0023.namprd13.prod.outlook.com (2603:10b6:806:130::28)
 by IA0PPFACF832414.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bdf) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Sun, 26 Jul
 2026 17:20:21 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:130:cafe::95) by SA0PR13CA0023.outlook.office365.com
 (2603:10b6:806:130::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.9 via Frontend Transport; Sun, 26
 Jul 2026 17:20:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Sun, 26 Jul 2026 17:20:20 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 26 Jul
 2026 10:20:12 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 26 Jul 2026 10:20:12 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 26 Jul 2026 10:20:11 -0700
Date: Sun, 26 Jul 2026 10:20:10 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Ashish Mhetre <amhetre@nvidia.com>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <corbet@lwn.net>,
	<skhan@linuxfoundation.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@ziepe.ca>, <linux-arm-kernel@lists.infradead.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v9 4/4] iommu/arm-smmu-v3: Enable CFGI/TLBI-repeat
 workaround on Tegra264
Message-ID: <amZByocd+B+fMk/L@nvidia.com>
References: <20260726081904.1408859-1-amhetre@nvidia.com>
 <20260726081904.1408859-5-amhetre@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260726081904.1408859-5-amhetre@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|IA0PPFACF832414:EE_
X-MS-Office365-Filtering-Correlation-Id: 70efa891-e236-4595-864e-08deeb3a2bda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|7416014|82310400026|36860700016|56012099006|4143699003|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	2PNIul2y/MXQMJLmGZOfBT4OXj9aGhlH+B3rMvVF/ujMsh7yXfRy1T/n7+VAUJzOfVVY+xl25HRU6rmRe4w0S4bm17jllpEWIkryexvackLZnpvBmEbZwYNi4BuznxyHO4cXqQKvqpCY8M4g13lbBKMtbwbHZchfBdN63GmMBLc90ZbiAlBzBEzeKSIAsjq6/c8rkY7YT7N0f+Bg517Z7Rph6wOisi+0E6uDWq6H0Hrpm53EpvaEccbCEWXWBwp89il6yrNwWQNTuapnI2fR2SkzqQPjZF9Qt1VOXegSjZY5ohQpATWNBz4mJLQ48NcOmkprxzYOED1zzUkms/01i5NAWW5aBEQl+6UP1tDlQ9Xm4w80DI5k0Z5MXxlQ5yu5WSEprMeH8ZQT+9iI0Chkqw3564CS0ZVwAx6cdKktkwwHFWwW/8LPebjhKUBAo7mBOQ/+rmdMij5cJoai9Mk+Ok2mk9d05ANTZbxodx2/c/3GMkKUEoXufnAfgJjuWd4HLAnI+Ywo+XRP8ow+KFUALsCOY3IoOAz0bb9npvCztkBZbKw+ij6Ioob9XKmU7MKVWOh5sKEeCj/ohLt19Ekd/orwqNarsrWlXuDEZIyCKHVAyycVgS+4pke0ZxzVAvnwsgM1EL/ZK2nEb78jh05tqzupbn5qZ66S4OcOPVxgYRvhOHQeDvFvmSOjgsRlTDqLtFucoi2oFY9lR6+UkbV49g==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(82310400026)(36860700016)(56012099006)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QUZZWSOrP8hzZOfzrtwRm8GA1ePyQ9NBzXWAVGqY3XsOFG1JMLMebHhDqmrJ5GPeTe9nbkY07mNl+2i4BLUuSHbIol9Uri2bQBaI5LXl+td/3tyFVLxr+GG1KS5MpNactIoi02a0F7t3jx35pa+1WsfcrVQELfk3TvG2coF2oKLuCoMO8FphoATq/Mj1YrTlBzeGmGDmaDvOKOw9rXqApb/E3id4lY/n2Oi++SVb7a+3SJyQ4VgDAg56GQHXFdH5MZuSxaegQzEbohW5dsUOZr39OMrn7fZQTpi/ZZC+KrJLCDwXhjdjH+xmDgwO6cdjMjseefyXSjyehD/ESULIqOZ1lcYQTfMTJvhnZxVff54tXn8yB5hoa7omN7caWcSJOwENpJ1WGV2skQHQEZk+8Z3Jl5UVHgHn5VO7KHuWsKKXd/nB3w1ZGyEwCp8IyDgy
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2026 17:20:20.8159
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70efa891-e236-4595-864e-08deeb3a2bda
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFACF832414

On Sun, Jul 26, 2026 at 08:19:04AM +0000, Ashish Mhetre wrote:
> Nvidia Tegra264 SMMU is affected by an erratum where a TLB entry can
> survive an invalidation that races with concurrent traffic targeting
> the same entry. The hardware-recommended software workaround is to
> issue every CFGI/TLBI command (each followed by CMD_SYNC) twice, and
> that infrastructure is already in place behind
> arm_smmu_erratum_repeat_tlbi_cfgi_key.
> 
> Neither IDR nor IIDR flags this Tegra264-specific bug, so hardware
> detection is not possible. Tegra264 is device-tree-only (no ACPI/IORT
> support) and already has a dedicated "nvidia,tegra264-smmu" compatible,
> so DT-probe is the only viable detection path.
> 
> Enable the workaround on instances matching the existing
> "nvidia,tegra264-smmu" compatible by calling static_branch_enable() on
> arm_smmu_erratum_repeat_tlbi_cfgi_key. Document the erratum in
> Documentation/arch/arm64/silicon-errata.rst.
> 
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
