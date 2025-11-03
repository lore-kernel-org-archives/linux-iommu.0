Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012024.outbound.protection.outlook.com [52.101.43.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA1C285C8B
	for <iommu@lists.linux.dev>; Mon,  3 Nov 2025 15:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762184742; cv=fail; b=AmGHGlJLLPTaXcgWCWj7jPhn9LHrQCfxkdjp4tA1ltzGWNrfqyVqVtbadkS3cf/nqxsLWJXq8uz6BZulbJ/+u2wDqcvqleVBwSHTGh53usDuSvRW56sn0ocRwjh/pWFzlr9XcMam5NEJmDKX+MeZ0MvsGAiq+bd8CvI8Ns1tld8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762184742; c=relaxed/simple;
	bh=kxKOUtWEUyO2V874r5Gekxgzg0HFoKQRVY2OjVIgpqk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KhE+ziJQD2QtEdsAw8ySfVgcZ6vxyrqBqBvkZvx35tVyFq9HgbMTBbFF2Aq7XEPLUvpwiz1k+wEJvgk7CcJHFvVta55v8VO10yQtVIwIHvjPNlnxtwFMW4pKjqp4CSYQO9sb9l7IVGu0WI8YtVb5/AFqWPcSUM5e6uhGh7L+1mk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FJVI24MD; arc=fail smtp.client-ip=52.101.43.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FJVI24MD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dEY0CJXOFazDV5KUa/Ap6eK38xo9+SMlzXKSA8pkJXcN4VnrYm5qhPgpsaMGS3Jn5BXUW6a1d180XastSUralURSV/hPccydOIG4KeZK8UyYu5Q0WwmU2qZWahbUVqbppYucwPHBJ6WmAurpGw3s8/YbU2WyhwhpTyzVx6WrzAgLDFsJXi2P9fBBV28Jk+eyvM4u9uNSZZ3+xUtoHk94opJyWO6+W0cu1RzZJuk/clBMLcuPiAbuT2V1etLOgX26Wkoks8NoQcWOhvk4KfJq3l+Gp0LComeO0/K27EBySDvZd5t0Sq3TK4sCNQD9SPlHmQ+w689ZCA0bLwvTukv3nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y2HjS41PJQbFoV0LqxXtT+0M30byhgXU2NRk6PIlO2M=;
 b=AID5hgM74L5+QZmo3B5OQwwrRAtdDJT/dg0XJPdSr6gQRm9B8gL5XPNHamYbfsWZwlTby858dGtHejVQlelw9PbE1B/pqvwG76g3zJlPViKs3nYkWEQZeEFyBu9uR0tN4La9LeiODCXPvJfot/eLy0H/frsVJcMN4xJ+pWIP1vJHjWcs21Z5E2VhcOvyUD7RkWnOZnMIv6XO/S4J26he76tKMe0a9xRLrqAJzOJs1ukNIjf/mKUCogTDyztm4lNupSrJ8yv52kHVSPde3/P/xZVTepp4H2TgcVDODcp5eDkwpUNDkfniqaLBuVSW9bIp0olEljqsc4KrKLO0iN5Ixg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2HjS41PJQbFoV0LqxXtT+0M30byhgXU2NRk6PIlO2M=;
 b=FJVI24MD9lZVW/AX2qE1dMXOUc8Ct+aARnmKbo1qf26yhKKx/dWAog4THgu+A3avlFsOM7t49AQ2fR2k8GKTq78HvLBi5wvxGG88aLMqtbs2plcjL5TadWvFmjxsULrP5LZL1p8Lfu4Cy9Qx1FcPR69yd/c7NNS26ggeHRAabcZ+h4ci2DftjHj/gCTXrgRZLCEDpArIGuFPYNmjwBOmV4Y8mxJ9rCl6dYHWXeZELpFshtOf8xwIIlIDRfexwT2ebT3O+SgNY+BZW4FP/YyksXRQOtwyCAcb718ZmZluz/5DsUvxyrXeYqhM3LT3VGlebc76uECrhThS2IXJUUegrQ==
Received: from DS7PR05CA0010.namprd05.prod.outlook.com (2603:10b6:5:3b9::15)
 by DS0PR12MB7704.namprd12.prod.outlook.com (2603:10b6:8:138::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 15:45:38 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:5:3b9:cafe::c5) by DS7PR05CA0010.outlook.office365.com
 (2603:10b6:5:3b9::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Mon, 3
 Nov 2025 15:45:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Mon, 3 Nov 2025 15:45:38 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 3 Nov
 2025 07:45:24 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 3 Nov 2025 07:45:23 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 3 Nov 2025 07:45:23 -0800
Date: Mon, 3 Nov 2025 07:45:21 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: <jgg@nvidia.com>, <will@kernel.org>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <kevin.tian@intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <skolothumtho@nvidia.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3-iommufd: Allow attaching nested domain
 for GBPA cases
Message-ID: <aQjOEQOPP2p1KsIX@Asurada-Nvidia>
References: <20251024040551.1711281-1-nicolinc@nvidia.com>
 <aQi8TivdgmtAyb7v@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aQi8TivdgmtAyb7v@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|DS0PR12MB7704:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fe64727-4d83-46e6-fc1f-08de1af0098a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GYq5KTL9+YSsMXB2tb01sKgmuDOjcYM2PBWjl5Xzg58wGJIkhondlryAi3Qy?=
 =?us-ascii?Q?fyyu10VxPw85WE2V9yjnWYasCX3pR5fXA/Ph1T459UVpbXssnMgRW3gupPUt?=
 =?us-ascii?Q?wqcb8z0kFRqoN4DZhrsYsFcBBlh6QQJtqOXsDVC7XcTpbV591F8bYh3+z4np?=
 =?us-ascii?Q?90lWvqmd4SvkHgYA1uikgH4fYI9m7jph/+FbtsV0/TdIRlmU5SMPbE9ukIDq?=
 =?us-ascii?Q?USAOGQO63irYQYM2RiXEBDZlh2QhS6gWkZiM7i3xIAmnpr+56ZYrvEAhN8oR?=
 =?us-ascii?Q?8XFYD+IfmDjk2OjL/n4UF/Gt4t69BI1Pm6bzws7YD6s2YAn77KwzdtxXLkGQ?=
 =?us-ascii?Q?uuzVsqh95Aqq6sM3ME2lYp30LhnoPF6NFAJPP+oEzUwgnWnHaQ7wlhgYXB5x?=
 =?us-ascii?Q?vVdc1BO/iFVcXtsmtCMEsUIATCYlQlrOC9GjpWFhhPqag5VXjjKPqfduSz5p?=
 =?us-ascii?Q?/fFJz6W8WABReXUyN7AfsVQh7BIa7WVbhtTPStD62RqZ5nvLvIHhRAbPfVwA?=
 =?us-ascii?Q?ijR8xPWZBq5GaiNkzvuHzENrc0JlQZjgNDP9jbdv67aVz+wIbSDzxhygJ/wy?=
 =?us-ascii?Q?nNXy9mZP6n9YTgpgkynnWGsktDSkbynTWfKxpiigL9Z0/ZglwDX1LznNFZjO?=
 =?us-ascii?Q?U/epwwpziDbpaLmpjCmpg6r4UE+NawxFPsBmfUQ//rbxHKUviguv6OiTmgSx?=
 =?us-ascii?Q?z3iXL+gQSJjvNMjNx0defp5A+mSt1hB6NDGgq3RTxAgeX5V8j8680dkJPwGe?=
 =?us-ascii?Q?AfMJq8jd2kEi0eesmz+pGSHD6fciemXJSYkHhubytOAaz8IE0VGEhzA8dEmq?=
 =?us-ascii?Q?bc9YoqtogIuYc+aZpIm93qF1+AGFRf3imojf+GJ94wdem4krOxsxHAKBuTuL?=
 =?us-ascii?Q?/X+QSaOAjJpzVfub23tNCV6rc4MOpVA/WzdeSNfIgy5L7r5E7FQ/kK1BLHh6?=
 =?us-ascii?Q?vp/zHq/oGIUAtSR57Ptt7PVcwO92vLGOEgS98gafcLXrR8ZiFdZwO15qPTgT?=
 =?us-ascii?Q?lfGo204surKwPRNFTKYjXfBKmTACqkDawkWQwDgANc0+dyhtaCbKl3tyTIKr?=
 =?us-ascii?Q?6pP+TM/Uj98QIHfLppSzE42xT6bhaf+QgZfvL7g4hHLPVYtSQs4mT22PKx9e?=
 =?us-ascii?Q?JkhsJ1lM0hKINYvX20fc4M0d30eVNtEufTzZlp/HcDxchQqaDNjFLi0Wu8ev?=
 =?us-ascii?Q?cu94Ld6pm7ZgZ0GdYVx7vSrMQa5fD8TnJ84sDuHykXQZF9fwj6Ga5MZFL/Tp?=
 =?us-ascii?Q?cEE4C/76xC2LXJAMFERZncTSf7Sp2T7BndBqZMJrUHzkHQcDwZzCHwyqteq8?=
 =?us-ascii?Q?EHlKVJmX3S+T4DVWF2Bg+Uik4ak8sHvU5KE5lxjnPNcr4LdchO5eBk725ROl?=
 =?us-ascii?Q?+/wjUGcIPSoGojICDqHzCajRRzAYphfmZ7upf84ug4n83CTHloLwe8lpM7u8?=
 =?us-ascii?Q?+LmsjcZM5HTLRxPC760QCZ8y1ZPQaZh4/jujlp/C8s0+He2ZkD8QbtvDBtlj?=
 =?us-ascii?Q?D3JZxR7XrgjtFbP50B1llfAcjo1H4WZLjB3JnAVI3/cl45/A1IdscKf8KCOp?=
 =?us-ascii?Q?LWo//YJn7d2muR1mOS0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 15:45:38.6404
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fe64727-4d83-46e6-fc1f-08de1af0098a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7704

On Mon, Nov 03, 2025 at 02:29:34PM +0000, Pranjal Shrivastava wrote:
> On Thu, Oct 23, 2025 at 09:05:51PM -0700, Nicolin Chen wrote:
> >  int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
> >  				    struct arm_smmu_nested_domain *nested_domain)
> >  {
> > +	unsigned int cfg =
> > +		FIELD_GET(STRTAB_STE_0_CFG, le64_to_cpu(nested_domain->ste[0]));
> >  	struct arm_smmu_vmaster *vmaster;
> > -	unsigned long vsid;
> > +	unsigned long vsid = 0;
> 
> I'm a little confused here, can we not have a vDEVICE allocated with
> vSID = 0 ?

Ah, good catch..

> Perhaps a separate bool has_vdevice flag in struct arm_smmu_vmaster
> would be clearer and avoid this ambiguity, allowing vsid = 0 to be a
> valid ID for an allocated vdevice when user-space explicitly requests it?

Yes. I will send a v2.

Thanks
Nicolin
