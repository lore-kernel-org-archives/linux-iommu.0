Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010048.outbound.protection.outlook.com [52.101.193.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9BE477E22
	for <iommu@lists.linux.dev>; Mon, 21 Sep 2026 23:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790032665; cv=fail; b=M5cbsd2kJ5GT+zRqNYTDZ/lrBmclYe38zZPupJulqhFvcRs5oEvE9swOdVQc0pX1KJ+TTI0Tqa4ziIdpprl6xwnEl8Jxg1LKJ97OjFdqz4HTmPfOOIZJW1C3N1hcKq4XKtq1gB30FUdKUHiwQKdEmxvYQCaY0U+QWd8EmUG13gQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790032665; c=relaxed/simple;
	bh=WR9c4p2jCHyC+Bw863SnJfeVro1mLytRCDkZOvVdUmw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CRMqHYX8WXgjUi1Sxn1kPEAvi1gWuLPfaOVbpnYeM6BVHUzxYOGoSq7QvgJzf5klmGUq0ZWLUp6XipEpgv1fYhvcJwv6DA7AvQGk+JKHYQmppRkGcSOh/vecaJ3OEYHQ6ef7LsxQMAiExCZeiQodvx36+/umn/JbOOal1D2plbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RhcHAHSJ; arc=fail smtp.client-ip=52.101.193.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RhcHAHSJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=et9LxqjynHnVFl6hlCp7rQn+O0JYeTACOsEH8ukvXuxw0TtKfLCVzN0vZzA0mvXZN/QbwcVxJZ0HytMDNobRx/bzeLf8MVAQEcjkq8BnZKem+aaXdN6xtYkY1eT+tmfENqV27fnCjz62y1dCp9eX580emQLqHP+pGZJfZO+Qa9ha4+QniDzgWNtjp+rW/bA/d5mSSNUX6Trg2OKeLlYhSGz71yqHUW86XO5kB71AJL0OXHBd6LVHxNWcTez6UnIl8EUJSgX1+HKAxRhFY9bXlx9y6JyZW4j/SMgt3b9qM5njtQIY/jcK8ZA4FDrF50lw8CG8yp3BLe0uRuWgXAzBMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ghYGPH7vELo62p4qjEl8XbjYQ9cyl0Cw0SEkMk1uLhg=;
 b=Fc6k4T8+ZSZcKKliSp7ZRlWC/nQ1UOhaPR05QP29DxKJZzMZ4ElDllD8oSsDdbBrIp6Ka0GfRHEfhnQWG6nvofsrP1SRsyPrTTK3myAt/3cB4yCOc07m1V0qWxJYpnWnw/ybFV0eFqEQE08bsF55ppIIxZhXOMMl8V8GQe35n4kiGGRh3RIYVVn2Evg5yM5itMco5OGixNokGfmuhumeHh1e5qoNGU74nU/DJ2o5pqD053c5Cl7zfEhYpkHrYXRkf/YCqFxiNgZoOWrFk0oDoaNvp4GbFbbMiLmcFaplGhqCTpZBJVTaUO3zG55RsZEcB2MnMXQ6ZD2QmYCmO+QWBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=oss.nxp.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ghYGPH7vELo62p4qjEl8XbjYQ9cyl0Cw0SEkMk1uLhg=;
 b=RhcHAHSJ0SO7wyDjJ359OfAoStaigzisouzySNg23VUWsrPsONOFfZle5Q4MgfK0DItYoyPDC2tz3fmv4xYtj0quNFA17vlxzaRWmha7jqwNjDOwGsm7JBAIrVo5wHX+wCyLRGEZsFO7+JC5h6gDRwbVf9DEnWqLAlOS6wRACXW4VzhZB7ceN1M8Sfmpn8XksZw9h6N5nV3d/7RINcjhfQVXsYObZ4sKp4xh4E4YCF0KPnELeLMezRwZFxTdSdvhFa2DqUAhUoM65vzovU9CG4hiSn666qZBLAijt1ksxg6Q4smvBkuQ8i5rdS/F8ztbL760Yy0AbR98etXunQwTPw==
Received: from BN9PR03CA0214.namprd03.prod.outlook.com (2603:10b6:408:f8::9)
 by DS7PR12MB5839.namprd12.prod.outlook.com (2603:10b6:8:7a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 23:15:43 +0000
Received: from LV8PEPF0000006B.namprd03.prod.outlook.com
 (2603:10b6:408:f8:cafe::23) by BN9PR03CA0214.outlook.office365.com
 (2603:10b6:408:f8::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 23:15:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 LV8PEPF0000006B.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 23:15:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 16:15:22 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 16:15:21 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Mon, 21 Sep 2026 16:15:20 -0700
Date: Mon, 21 Sep 2026 16:15:18 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jpb@kernel.org>, <jgg@ziepe.ca>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <peng.fan@nxp.com>
Subject: Re: [PATCH RFC v2 2/4] iommu/arm-smmu-v3: Support shared SIDs in
 insert/remove_master
Message-ID: <arG6hmng3NddGEHm@nvidia.com>
References: <20260921-smmu-shared-sid-v2-0-4b656ce68178@nxp.com>
 <20260921123846.1663580-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260921123846.1663580-1-peng.fan@oss.nxp.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000006B:EE_|DS7PR12MB5839:EE_
X-MS-Office365-Filtering-Correlation-Id: c0fd8ce4-912d-41fe-3150-08df1836428a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|7416014|23010399003|82310400026|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	d1ccbHEs52RCKq4UPbzTSRJfCJOOF8ODbjmMFHgpNOj1mzDr4DBiQ0EwoC7z+GJaHgBghsU5IeqyGRjyKpQZhPeI3ZN92Mx/3KyPrEJWi0eKOeaZOBvk283Yk0aTCOMoxz8kX/EPq0wWD7brH/eRxqbaZsw70l0m6Ou2PXhVvao665+m9bHwS2LRNtgOQMEYePlhXr6GzoSmbWtdlF7/I2tPhLPU2Gsb4Gm3NQ8PgDUFDtleA8+/UvqHCjt7k4xLHH1qQWtiN7gjVDz+2F+nuZKJfhzeI1MAvd9Gu4dIXHYlE20mI4i6F9zUeuCHsKkdcZSZs+c//DME6wbeaYgwFNjPhI8Ya8SljV6tcm/4jxbyBOkBHGPWRjzxWdbymFKIATNMYeR7LE5SRzIyCxe9GKXEOrcrelu7ZXBFqp+oZvNG34ixjik5qBpYwHNdGQV14SJ5b+gaAK0KNU8/vQ6nOC+KO9Cz1mP+ff+mCTLUv7MQEc+PjCWhqttF4AzIHfKmiXQHB9GRYwrqHTRHH9etZXLFWEZlPcBxv21QoqFHsFiftgKtSLMGixC+paMDec6XPUV9hhHocmCsPnIDF6yS9A0dgtCuulbp55b7TqTalW8ViQaCq94PEvfWrycpOPVSYoODOzh9Cu1XIr9qjzUh25S2TpKEn0xcYJkl26jJOn48tynmV/vHTIbY+lJae5kI6wf2u/CpZs+Lq6N+s/OQWQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(7416014)(23010399003)(82310400026)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eRtq7lUYmJzepv7M6QU71XULvrqgcn4jY5YI5/9fhlIa3t0vPsI7I5RZ2kZb2nCDSJtZEtEtwfQ/9qvM78wiERDpqOyvCmjulJCq8stJdv18vh4Dbr45sY1metxacwTuDjnL85fJaWq25zTyTdme9vZk5PJq6ephPYYJe00i08zKjQknrMXYsNHdg4+IaFPqqxBvnU/3NAEPqiwTPnHjODD+BJdWbG1etJP/CsgF8PDyH3D3IbKetldPAzAswuNtbWBuIPg9ebYEcG/06FRQU9YoSkOq3V6IzItiVqk162DvLU7kp5xV+5qRkmvTHF06KGbl09RiNR/qBoRVuY50PNpdHoPBdhWyni2XSG+2iEpX38CueRLcJHBkVQ1cudLywxywaY81qElstB/W1gvGx6W+3Gy05EqoQeSdyWinsAYFqBhlv/uuDBT3fHeEIpj9
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 23:15:43.1773
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0fd8ce4-912d-41fe-3150-08df1836428a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF0000006B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5839

On Mon, Sep 21, 2026 at 08:38:46PM +0800, Peng Fan (OSS) wrote:
> @@ -976,6 +976,24 @@ struct arm_smmu_device {
>  struct arm_smmu_stream {
>  	u32				id;
>  	struct arm_smmu_master		*master;
> +	/*
> +	 * ref_count > 1 means multiple masters share this SID.  Protected by
> +	 * smmu->streams_mutex.
> +	 */
> +	unsigned int			ref_count;
> +	/*
> +	 * When ref_count > 1 the STE has already been written by the first
> +	 * master; subsequent masters must skip the write.
> +	 */
> +	bool				ste_installed;
> +	/*
> +	 * Links all arm_smmu_stream objects that share the same SID across
> +	 * different masters.  The canonical (XArray-stored) entry is the list
> +	 * head; non-owning sharers are linked into it.  Used to transfer
> +	 * XArray ownership when the current owner is removed.
> +	 * Protected by smmu->streams_mutex.
> +	 */
> +	struct list_head		shared_link;
>  };

SID-sharing masters still allocate their own streams. Though the
SIDs are the same number, they own duplicated streams linked via
that "shared_link" list.

  master_a->stream[0] --> stream (SID=X) --|
                                      shared_link
  master_b->stream[0] --> stream (SID=X) --|

But maybe they could share the stream structure directly? I.e.

  master_a->stream[0] --|
                        |--> shared stream (SID=X)
  master_b->stream[0] --|


The stream structure would still need a list for shared_masters:

struct arm_smmu_stream {
[...]
	/* Every sharing master, ->master included. Empty unless shared */
	struct list_head shared_masters;
};

ref_count could be simply !list_empty(&stream->shared_masters).


Does i.MX need to support SID-sharing with multi-SD device? If not,
the master could have only a simple shared_masters_elm:

struct arm_smmu_master {
[....]
	/* Supports num_streams == 1 only. Empty if SID is not shared */
	struct list_head shared_masters_elm;
};

> @@ -1024,6 +1042,11 @@ struct arm_smmu_master {
>  	bool				ste_ats_enabled : 1;
>  	bool				stall_enabled;
>  	bool				ats_always_on;
> +	/*
> +	 * True when at least one of this master's SIDs is shared with another
> +	 * master.  SVA, stall and IOPF are disabled for such masters.
> +	 */
> +	bool				shared_sid;

Then, this could be !list_empty(&master->shared_masters_elm).

Nicolin
