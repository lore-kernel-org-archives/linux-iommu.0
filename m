Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011058.outbound.protection.outlook.com [40.93.194.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C0736606A
	for <iommu@lists.linux.dev>; Tue, 13 Oct 2026 00:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791851178; cv=fail; b=mp35SEIfTwoYNM+uRzS2tEdE2rnZZLZyiTi4zSc8C4Kie7jR0RTxeRWfOzlM/88sgZjjl087GQhU53ZX4wbYNr8zsEL+m/ynfIzmM9Vn+T5XIQ34EtHYXxxaHCYf2V8BKg1+up8w+AQCjD1CwnbaI9stMJhG2P3Bj+vPRbVjJW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791851178; c=relaxed/simple;
	bh=YAv3hBxyfIHdIJy5vvnYjwKSS5NJGZ6QNAbywO5dW08=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gqiv+v26SJwoJimwoaTPLKOQJ6qBMMG6nAflgjJMPfx+FKQwvVy/TB91uAsFEONj5Fx9hyv+YhnxUJWVW/3F0x4NHDnCD/fvVHuHYbMhT8Sss8Lzy/Qcr/NHY/GV8NSFAmIC84dhfoc6HaYSH6TyU/lVw9FtWLptZWHRMPHaO6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JGL37ZSZ; arc=fail smtp.client-ip=40.93.194.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JGL37ZSZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hT1yNwGWeIK7DBTrwElI1eYWkpxtxz5AfsE6yEILWLIANx9B98Q4575+Z4WqzBK/SSL7OEzjjZsmvn0+nnU6UAvI3y8gA+NdYDV2+O3BGffn4BT9kobpPm/RgMdVLTDDLyKzBiLWvro4+ubSkEyzQdt3KKPOxjL66wrG7ZAM9Qvdn+6MLrHSRxwRU7Wa8uHmze/bIsKzpqF+J5vvOEw+tUUsL0DlZaATRgHRs+GCe4ky+sJkTRcYk4OwqJN7waQJT24be3sZUgvfOz4W7XT60myqM9Y5GZun9UpJy2QDNtNCRKI8QMY79JY1cQJ6huOM1+GqVpCwCzj46bKyz6uy+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ym72IAjGQLRCMJ2JbGX9jDuHlyFPOSOaOgytfIFiExs=;
 b=Rl3Xu8soUar0W2LHpyHuL9wnnm/Qt0N8A4Wvlkm1LOUzYb9P60mTuIzTROXPjLax1pngKIoyCdmMjpfnMHJOHnsRllRQbMAHxG6JvdZwd1gT8ABGmLRJ1NoXOG6ANFAStnYfiYaNGVer3yfH1BhNVrEPyOExI/L2wjdYworgo/FblYa3eCvN+OQnmPBRzystmT/9q1Mi+ryB6qY7Rf2nXQ+QwRon6DhZLdSJCebg9iKMohdM5S03oovjSJA5kl3NXA0nYkbH5lZO+PGSKhqHSrZ6D5yJTntBfKRTSbw6RQqHgctxUMA1PmECwuCjm5gleh2B3CAYMFSoWybKSt88+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ym72IAjGQLRCMJ2JbGX9jDuHlyFPOSOaOgytfIFiExs=;
 b=JGL37ZSZX/aAiT9KmvgsMbn1A/yiRQLvAfBLh/Dad8vv4KoOgxU76yBGtUiE1kBESuPyonRfSD6m5g6uQ+tb93CdIhujutrVh6zXd0zxgGfrNIUeyh6uT0HqBBdwgng7XeOKjL1l9a8XYzMilFazJ5xtRsoyRgmGlE2CKG3+ADQ/bgZ+0RETHBvULEz5esV9krwMFjtRP4Bq79KbZzIdN2z3tStEcxwE4dfrQURM7riAu6qdvrCn6VRfbP8IrA/TSmyKA0O4rwAj0UwOYk58bs3xw6EyIgpjRUi/L89HSCc+lP5EN9H+E53WvPGcVzpQmX8bZpX8cK2tl7MoXFcvpQ==
Received: from BYAPR21CA0015.namprd21.prod.outlook.com (2603:10b6:a03:114::25)
 by PH0PR12MB7814.namprd12.prod.outlook.com (2603:10b6:510:288::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 13 Oct
 2026 00:26:11 +0000
Received: from CO1PEPF00018863.namprd03.prod.outlook.com
 (2603:10b6:a03:114:cafe::76) by BYAPR21CA0015.outlook.office365.com
 (2603:10b6:a03:114::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Tue, 13
 Oct 2026 00:26:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF00018863.mail.protection.outlook.com (10.167.249.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 00:26:11 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 12 Oct
 2026 17:25:46 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 12 Oct
 2026 17:25:45 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Mon, 12 Oct 2026 17:25:44 -0700
Date: Mon, 12 Oct 2026 17:25:42 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Samiullah Khawaja <skhawaja@google.com>
CC: David Woodhouse <dwmw2@infradead.org>, Lu Baolu
	<baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy
	<robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, Alex Williamson
	<alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, Pratyush Yadav
	<pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, "David
 Matlack" <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>,
	Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v5 02/18] iommu: Implement IOMMU Live update FLB callbacks
Message-ID: <as16hl29Kepg9AcT@nvidia.com>
References: <20260921004834.2601285-1-skhawaja@google.com>
 <20260921004834.2601285-3-skhawaja@google.com>
 <asWEtTcNJSbrY579@nvidia.com>
 <asmj6ErFqQMJe0_u@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <asmj6ErFqQMJe0_u@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00018863:EE_|PH0PR12MB7814:EE_
X-MS-Office365-Filtering-Correlation-Id: ca564450-5c4d-424c-865d-08df28c09557
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|36860700016|376014|23010399003|1800799024|22082099003|18002099003|10067099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	vFrwgFIvrADEIZi5hPzsQ7f+qEVbp6Yc/UYFdE/fF0QT3qWVPTM5+SGSSV2aer/S4SGO40uZ2aCgtth+8ESEXJO9nWaBqM2mPwCVYkXvfs6dOl/5LtC1G21lV0NfV0VNn00QUGRdm3+IqaNtpnrDIpBFwK6SXFFvcOBqROA05z9nsZD+dx+voVpM+TWjkid+IjeKVluHfDLpOKfl+iWUX+C0LR7gqAgkqARi/bh1yspUYOSGDmhxYhSfdYWoEhM+N/8Ay9G+EgAJm2DQjjONzHUj+YTIUNdnayk0Q3pf2hI9+t/lmahpMtl+aUrPe/Rk4GQVJTllL7EQDKEnm7S+M72MOgLD5liBlt8ZdPtonSPvm8VHCF1OkpI7+iU5qf0AEFFzDmfj0gmzoxCYuP96lp5jXJfT99LUYcPNVa2zoIE/55nrGPep+9VteHXJ7cvNL0wAYhhNFd9eoPYhnTkdAItQXNkxnuML4xkxR2J/7pY35J1dyNrxPxdh478l04qsC/JbjKfgD6kNv1gyy5v9Z9ksnerB25kkrD88I9SZKQ4UjL3b4WLDZ9GMA4psoAtcIWtg1XwgKoXtWU5ZrlA9MnMtzS9Ff0v9mbmpYCig7vtzA+RY8uHDUo3Z9u25Tuc/K+v3q7tULRv8mOeOyEYU0ZVvtM8z4tRIDbhuV4EVfYoZVHVAR9NdrL0eDWB0va1neoHr6QXaB7dyIOLw0klnxg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(10067099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rk1E1SW0Znd5/ZNQUluQk35UeBqXKEhw/JG4OEXqUK9MZ559fkKUc7TmP8a6L9bX4OilbzyZIKqo38Q1e7WZUfiCp7w03v+B0AOW0AW0mKq8Vk7At0cnLKg90WxK/mDqVWjQCG2fleC06kJd9anA3PkjzXfie+RZSkU+oXtGm672iYVjyYYAz3vs4kcZ4MJPji8DzpT+gKWYYLKYrFso2XLphvw2P+y5q543eg4IbEKFAcFQ0c+CANOHNsBqZVvuI500Iln0azf/wPvkK6u1YXnZmM/ebK86/WT7mPK5gq3KoBBu/tJt6hjM5jzwQf5dy4yBCQQb4b0h517iLe6wqC2iE0u40k4/9jpAMV6PuMufVM0Lpsk7b3GxenS05pRdEtsYVu2e48GRl8LHkr6Iz/KKLuwn2S5b0JbADYx48NFutxyDl2AypBn+RA3jbW5z
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 00:26:11.2868
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca564450-5c4d-424c-865d-08df28c09557
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00018863.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7814

On Sat, Oct 10, 2026 at 03:18:11AM +0000, Samiullah Khawaja wrote:
> On Tue, Oct 06, 2026 at 04:31:01PM -0700, Nicolin Chen wrote:
> > On Mon, Sep 21, 2026 at 12:48:18AM +0000, Samiullah Khawaja wrote:
> > > +struct iommu_flb_obj {
> > > +	struct mutex lock;
> > > +	struct iommu_flb_ser *ser;
> > > +
> > > +	struct iommu_hw_array_ser *curr_iommu_array;
> > > +	struct iommu_domain_array_ser *curr_domain_array;
> > > +	struct iommu_device_array_ser *curr_device_array;
> > > +};
> > 
> > IIUIC, there should be one pair of obj + ser in the entire system:
> >  - old kernel has one outgoing obj + ser
> >  - new kernel has one incoming obj + ser
> > right?
> > 
> > If so, things in iommu_flb_obj (except ser) are all transient, and
> > there is no need to preserve them across the two kernels.
> 
> The contents of iommu_flb_obj are not preserved. Only the contents of
> iommu_flb_ser are preserved. Other "curr_" structs in iommu_flb_obj are
> only there for quick access to add new iommus, domains and devices.
> > 
> > It also feels redundant to have this iommu_flb_obj structure. Why
> > not link liveupdate_flb_op_args directly to the ser? Then, things
> > in iommu_flb_obj could be global?
> 
> The liveupdate_flb_op_args is linked directly to the ser, but it only
> contains the physical address for the next kernel. Basically LUO
> provides following mechanism to handle FLBs:
> 
> - data: ser structure for the next kernel.
> - obj: Live object that can be used in the current or next kernel for
>   easy access or staging.
> 
> For example here, iommu_flb_obj has pointers to the end of the array
> linked list of each type.
> 
> Also note LUO keeps separate incoming and outgoing data and obj for each
> FLB. In the new kernel both can exist at the same time, as the incoming
> one stays until finish and preserving for the next live update creates
> the outgoing one. So keeping these in the obj avoids managing two sets
> of globals and their lifetime in the iommu code.

Could incoming and outgoing objects exist in the same time?

Correct me if I am wrong: I expect the lifecycle of an incoming
object will end once liveupdate completes, and the outgoing one
can only exist after that?

Nicolin
