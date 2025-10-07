Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010050.outbound.protection.outlook.com [52.101.61.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43CF1DBB13
	for <iommu@lists.linux.dev>; Tue,  7 Oct 2025 01:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759799311; cv=fail; b=PB0kfkrutma3bmXIVSffa15QIf7PC9NL1oALDV8ABiJt5dvz0xd8roOAF2C1zLmXlDwLMzcmJKtp0h3dQeEDBoJaH+cpNuyuJpeF+TdRwUH/6lN0/btITC47I96PDnl4TocJR22y6QDLRKSj+LGVSZ694W5fUXi1XwvVQDDpkv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759799311; c=relaxed/simple;
	bh=M1U0rX/b+ig7JsVL6ADACjV2ie2zaffgB59cdMoSNB4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UD9rusGmge9phx2QH57D4Rp/Kpb+tONe9MRtUNT5Km8WtMv45chk+0X5vHAOLe163yJPbEiwuaLLnfCyH28QLwDW7d90HMd+fFLDByNVi+SKj7nmpdo0m3Gg7d0OBo08Odb9I97ucCpZ5SqJLfzjrDciiZ4wlvPGIPOjBo8yFB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YnU+bf+S; arc=fail smtp.client-ip=52.101.61.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YnU+bf+S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RQ7uqu12oZOKak8hfJKqnz2X4uW5gz3ofDHhjK0p9fYZtwqTEYSnFEdsacJggockIEFEYn8qqiUh8S316UezNoE8dmZLBeQAWxMAqGlKFQIaihqewTWoXNkWirkQg+OZ0N6JlPZYSx0U3/6+hmL3TJ+r9gvMTG/MBB5JLUoXUcMRkiTNUfDsh3DxUUDSgo6ZzLf2SadJwhN6ZAKaxOSjSKpvbVW2t/0nnaDDjCzF6aS78wPYzTejsNM+UyyP+3fHOhGPik8n72c8rWs9Ebp7DwtWpUO24mDru/AH33xVKPpRwhPjZbS4zn12d3gqJVCqjI68Zq3vFMFjiTVcI+E1RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pr0QFisNY2roYeraKNxtXOxFkvO9dt9PQj8Lhd6o/Ik=;
 b=hmb73g0QVUza7kr0rBPAu1w8DtiAnUH3YD+UiVGnAWmDTUb9bJ2ntpy0Pf/Mjsy7BiBZRDWKKPoDtsrOvEHkp2oifFRDNaAAKo4fD9YV6F/ctRNJ8Tw9FTokxv/ENwcEPCevVD64T2z/sGOaUb+UgORENhws4RB9SDJpwJSqmmAlPEgGrn2nJ916UD2672otDm4T2iLEW5ucOsMwco8meZr5INqTUBEGX/hAIxl/PqfX5vrAIR1NP1gdJiXxRrxrzxJw2Tffu/6NCItEm2w380dGSphg1vKJOtrW3YYcZYY1Fi7U0oRk17xACQLXhbGskUyp5yAnsZNQAG8dA8yKDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linux.microsoft.com
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pr0QFisNY2roYeraKNxtXOxFkvO9dt9PQj8Lhd6o/Ik=;
 b=YnU+bf+S5lM1jA3pPGum9TF54KA4d57qqO9z2lcVbHrlVkalX+H5byuUcKpaLyvXP+h/QNq+qCewBl/+a0KNnii/RmoXck0qIc4g/b4GbXzT/bfZ0yvRnzsPtRYfrh7Kmjv9aUiFAI8ZDwYbwgkuPRFYc9e09dExx66RlzoHxIvldxU+eW5hSzurhR4Sj+ppBBv3MJXPypmHjiyetWYkvWGetMCyFlIFapBWVGYynXSI2+6poAy0VHdg0jaPLwyy+aheFlN2FXQglOWh7JQ/v3NCsu8VMaWgEnRvpHnMzVZAQ+QMRCcwYHackn+9rdgJoXdalhEVZi8ztujFgUmTrA==
Received: from SN7PR04CA0214.namprd04.prod.outlook.com (2603:10b6:806:127::9)
 by DS7PR12MB6191.namprd12.prod.outlook.com (2603:10b6:8:98::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 01:08:19 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:127:cafe::26) by SN7PR04CA0214.outlook.office365.com
 (2603:10b6:806:127::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Tue,
 7 Oct 2025 01:08:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Tue, 7 Oct 2025 01:08:19 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 6 Oct
 2025 18:08:16 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 6 Oct 2025 18:08:16 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 6 Oct 2025 18:08:15 -0700
Date: Mon, 6 Oct 2025 18:08:14 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
CC: <linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Will Deacon <will@kernel.org>, Jason Gunthorpe
	<jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>, Zhang Yu
	<zhangyu1@linux.microsoft.com>, Jean Philippe-Brucker
	<jean-philippe@linaro.org>, Alexander Grest <Alexander.Grest@microsoft.com>
Subject: Re: [PATCH 2/2] iommu/arm-smmu-v3: Improve CMDQ lock fairness and
 efficiency
Message-ID: <aORn/vKfVL88q05w@nvidia.com>
References: <20250924175438.7450-1-jacob.pan@linux.microsoft.com>
 <20250924175438.7450-3-jacob.pan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250924175438.7450-3-jacob.pan@linux.microsoft.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|DS7PR12MB6191:EE_
X-MS-Office365-Filtering-Correlation-Id: cf50d9e3-ef01-4254-20c6-08de053e00d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k1r86ZeUBP3h6+nQBYnCvlW2F5W+Brkyki3Ly56aG8hf4fCgX0Cc25QiDN/E?=
 =?us-ascii?Q?EZ1wBhWbhVapOVj1Hr7Z1dFeAjxwfoVxE45ObG9X+rENIwLV+RtogCgYgCnD?=
 =?us-ascii?Q?oXteJrBVRrWndkIg0E1r3EEAzkzM8DwoXp2TikJPXknb3dDmAMgtzi5u2vjv?=
 =?us-ascii?Q?CHEQW2O4YcScRCoALzYwy96kkAwNjUvvjg2kvFONMfJ4WKam7RrHOlhVBYFj?=
 =?us-ascii?Q?ChhKr/VtAh15wJuh9kXDzdjDoQS0yLGj7f3C6CXrKWiq1+xE7WHzluRfNq9k?=
 =?us-ascii?Q?ykxmKk4r017lthwrgCLKkAIpao5c++yIipb/vDXKepyo8A9zJ21ILVLOl0RX?=
 =?us-ascii?Q?i8996eGa62eaZrGOEzx6AKaocBFws62fw3erRM1ubvw7Ip89x4p9ZrY6tQ5K?=
 =?us-ascii?Q?g1ZND8IBWh1G+R1K7HOzoGGrUf75W7jsW6VeXRbGxAi9QNoQtp3vVon54AZ6?=
 =?us-ascii?Q?fc0PYekmV0G7F6J6zyUNNachGdJaEM0E6i++bBqLmNj5VhhoXhXOQxaesPP2?=
 =?us-ascii?Q?Y9RcoiXquZW209cLNkPQ7QCI/BjrfWta292cxwzuFfTSUQ7tQH4+QC0cfjRb?=
 =?us-ascii?Q?Dz42z/0KIzLbCSbIn1SSzV+yqPS+2Q8D7q1xUwO+YXesfwVtbhxDelP6nZO6?=
 =?us-ascii?Q?w/oof9ksF/bt/aDqG4gDG/xCucWOY0tNRGTIe0emg6UzaKo9nJ+HuFwbqpOY?=
 =?us-ascii?Q?RabC9LbM+n0aYQ88VVyNV+VXVkmOm/LnI5zsyTDm7TzoAl3lgN3wBEHH62QI?=
 =?us-ascii?Q?HksiXk0klJUPy+v9OD+ME22K+RzerfiM7e4+OEdBlIpgWtc9Kj5CswbevTo2?=
 =?us-ascii?Q?NNLSfabZnohKuVjf2DnhvlWhMOMLYb6Uy0Z7tPpFeHBXqU8ksp6jS4WaUA+6?=
 =?us-ascii?Q?r4w7bwpfWD0fFw5YfAWv8avs7Mur+VpDaXXSCzK2AHf6fPnnKWX0ubs9l+8C?=
 =?us-ascii?Q?Vl2zK6cgPagLJChU5WpEvlxb6I1We/tk/Zf6C5NCNQlUScG0rp8ca2Gro1of?=
 =?us-ascii?Q?6OOGTBPal8jwGXY+sFeBltlyCzMqF9SjVPQ8YL9ZSEQ1q38Z30s9toffWFa2?=
 =?us-ascii?Q?Wfwi8uOysl18beT+mQoDns+GViCoBftuTw5ehciDcKNQJ9RcakinrH7UqUH6?=
 =?us-ascii?Q?W7ndP06szZWs554qQptfJJf1gXIGD0+1sdmnZ5U8gilybRbGuQDgjIq7wWWU?=
 =?us-ascii?Q?9cY6BhnKEMOApqV85QGcO/ZtgIp7LUq5La54JP/ZZoGcNC60rRqC5u63g5Lp?=
 =?us-ascii?Q?x9lJ6RCacCYeZ7+CW5svKSPzbBPY/ABVBrWPm8KIJkeC42mHHmGHJA1Z9i4Q?=
 =?us-ascii?Q?QCq9HCaIt6haEL6+tysxI4Oj34/jVaFzOsuM0+/UDvWkFPZ7brh9szDbbRoT?=
 =?us-ascii?Q?1d0zDeAG8T4PLXaf7cuVhrU5AYi/vq0BVc/Txw63qDXmbuvJkcVhtFUNuyQV?=
 =?us-ascii?Q?T47CxAoN7X/L6L3kWIuGmchN6IXqHrtaQesC8ZS8GtzU8GN+eLLUr9OfaOV1?=
 =?us-ascii?Q?bhfet230UqinIY1h8Oig5oIAWnIcr24UUP/q7jVNnGIHZTlyY9I9BOrgcHdl?=
 =?us-ascii?Q?aNqnByVFLdDJtBU2Ud0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 01:08:19.2321
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf50d9e3-ef01-4254-20c6-08de053e00d5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6191

On Wed, Sep 24, 2025 at 10:54:38AM -0700, Jacob Pan wrote:
>  static void arm_smmu_cmdq_shared_lock(struct arm_smmu_cmdq *cmdq)
>  {
> -	int val;
> -
>  	/*
> -	 * We can try to avoid the cmpxchg() loop by simply incrementing the
> -	 * lock counter. When held in exclusive state, the lock counter is set
> -	 * to INT_MIN so these increments won't hurt as the value will remain
> -	 * negative.
> +	 * We can simply increment the lock counter. When held in exclusive
> +	 * state, the lock counter is set to INT_MIN so these increments won't
> +	 * hurt as the value will remain negative.

It seems to me that the change at the first statement is not very
necessary.

> This will also signal the
> +	 * exclusive locker that there are shared waiters. Once the exclusive
> +	 * locker releases the lock, the sign bit will be cleared and our
> +	 * increment will make the lock counter positive, allowing us to
> +	 * proceed.
>  	 */
>  	if (atomic_fetch_inc_relaxed(&cmdq->lock) >= 0)
>  		return;
>  
> -	do {
> -		val = atomic_cond_read_relaxed(&cmdq->lock, VAL >= 0);
> -	} while (atomic_cmpxchg_relaxed(&cmdq->lock, val, val + 1) != val);
> +	atomic_cond_read_relaxed(&cmdq->lock, VAL >= 0);

The returned value is not captured for anything. Is this read()
necessary? If so, a line of comments elaborating it?

> +/*
> + * Only clear the sign bit when releasing the exclusive lock this will
> + * allow any shared_lock() waiters to proceed without the possibility
> + * of entering the exclusive lock in a tight loop.
> + */
>  #define arm_smmu_cmdq_exclusive_unlock_irqrestore(cmdq, flags)		\
>  ({									\
> -	atomic_set_release(&cmdq->lock, 0);				\
> +	atomic_fetch_and_release(~INT_MIN, &cmdq->lock);				\

By a quick skim, the whole thing looks quite smart to me. But I
need some time to revisit and perhaps test it as well.

It's also important to get feedback from Will. Both patches are
touching his writing that has been running for years already..

Nicolin
