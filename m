Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010053.outbound.protection.outlook.com [52.101.201.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567F131690A
	for <iommu@lists.linux.dev>; Thu,  8 Oct 2026 01:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791423017; cv=fail; b=L9kNwnq3ZnanmGBPVfonQizx0V9CoZX9Op8ygvGCsJ3uWW29j3oH6JRXcKoC/jqvgV/PCQxKd0ApiozCj6ty+urXJhrNlpsn7/LnLZOFmxLQpS3xAdoQFUGFv4mO7fpQzqhZ7Kvas9Cn09BjlNq2hkZn1QmT7P/C0ywzMjGR3yc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791423017; c=relaxed/simple;
	bh=zZkg7dwJr5D+cAqCF/OtDHKnfUVCaahTRIivKD6uXdM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UnFid9b+E5ib3Mhsa/2g/wNOyfsBdcW5nsIr46RV88N9kzXyojUMNvihR7TWvUnKHSD0eteOU3vWkoF8amxPprNqaJcrth7X/pnaxWeMb4THgV1mTwIIAnYNCQQ+LZ35yq00INm045FBKLLdhrAq5zSclwMnMlOzMv4NhNyNWmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P9zZ7qXv; arc=fail smtp.client-ip=52.101.201.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P9zZ7qXv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D2DHWzd9WCIgASBvEqbC4Y6+cUkj0OPYBNy/zOwXVWxXbIausxfU0R/JmrBxsczboq53kOQmi3990GKW35lwVhNYW43fZndj3FNmgwtujdQoIMz4F12QwySK5nN1xGMkS7It2fgjssRJqjUr4r7zY/zwm7zlpfkcAbs0dGtgvTw2CI/yTory1/Q3DW6C+IgP2luFc0gu/jfbpyzAwfMILceh+X3Exb3KDGGIRdkAj6aFP5+IpD35LUf4ZYKgQ98sNTwrzAywu9eZAVXq1Aq32k7ymw32gPPTArBfo8KWaUFP2KsIX/Lotr1XLC3UP/odT8P+ehjcgghZtcrMZ6nWsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joVq/SLGYIR7p+H9WE/4a22MFuUDNP6W4nL5Y06B5A8=;
 b=AJHTf2MWsjbttFMK5yT8NCZIj+Bi25Bkg+Wb1evAg95y6kS8C+uy8QCWJtnczwb6oj8BqP0Zfzi2pHIIMg057XrE7P5YDl4g8/KMqJv0BpdbpGkkbiFsoaAM68Ph8lrjMk+ORaY+FXqO7B0njU3cV0NvgZoLF0DM1g4hQGyHojex4jPla1glHn5rXWCIDnB56axKpGqFtj7SC8cgqngFTAUDPuCAtwocG3/0OhfEIKCTRIip9iu4YHlyBzdkC+YyaNQsi8ATzg4WjobaJRbIQgEiqz/holWWRCpE2qJ3+MnGDfhCwq+Vy1V3WFqAVTccOegyYAuoy0RDQ8qDU9MGbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=oss.nxp.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joVq/SLGYIR7p+H9WE/4a22MFuUDNP6W4nL5Y06B5A8=;
 b=P9zZ7qXvOVOm59NAOOXYlIrT3kfPZQ8gFyviY9guztf+FkWz9NALX/TksCTVFeiRRRNTsrEcd9+svR90GnPTfWwS8zd2nzqd9uXzc+PqvxLes4O8t0X59s8VT0vr1bOxgOGyHfGPC7EpW5FUrBk6tl7DHKq8iaW1C06FENf7d2KoUUpKGsAh1N2CwItK1h8cSu5t8abGWoPTdzwzUpIOcPJ1OMKJGw2C9fdyKEkWEw9T78BKS6s58Q1IoQ3dH80LNEGjN+2SJTLmi5RdoWCKKdBX4Ic55STguOGx9ZRPZfAVtJTOdYhn1a5Pr+feND9zWbxgui5myGDU5xB7InJAyQ==
Received: from SJ0PR13CA0005.namprd13.prod.outlook.com (2603:10b6:a03:2c0::10)
 by DS0PR12MB7777.namprd12.prod.outlook.com (2603:10b6:8:153::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 8 Oct
 2026 01:30:08 +0000
Received: from MWH0EPF000C618B.namprd02.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::14) by SJ0PR13CA0005.outlook.office365.com
 (2603:10b6:a03:2c0::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Thu, 8
 Oct 2026 01:30:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000C618B.mail.protection.outlook.com (10.167.249.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Thu, 8 Oct 2026 01:30:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 18:29:53 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 18:29:53 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Wed, 7 Oct 2026 18:29:51 -0700
Date: Wed, 7 Oct 2026 18:29:49 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel (AMD)" <joro@8bytes.org>, Jean-Philippe Brucker <jpb@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Thierry Reding <thierry.reding@kernel.org>,
	Krishna Reddy <vdumpa@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>, Peng Fan
	<peng.fan@nxp.com>
Subject: Re: [PATCH RFC v5 6/6] iommu/arm-smmu-v3: Wire up shared-SID STE
 ordering and feature gating
Message-ID: <asbyDdO5dInAkm63@nvidia.com>
References: <20261006-smmu-shared-sid-v5-0-169a59c671d3@nxp.com>
 <20261006-smmu-shared-sid-v5-6-169a59c671d3@nxp.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261006-smmu-shared-sid-v5-6-169a59c671d3@nxp.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618B:EE_|DS0PR12MB7777:EE_
X-MS-Office365-Filtering-Correlation-Id: 5142d6f0-5127-4eb8-1149-08df24dbafe5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|7416014|376014|1800799024|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	DpX4cpkh6zL8N4Blnb80iU2Oe8tCBzdCdUhnl7JdP7L+RI6aVLeaF0rZs0NAyUmLvZtP7RCjt0QTWo4FgIXmebfTEHKIAvonmHj9mz45gAUf2C2kqt5pFG/mAVS8/ICHxWLX6PlFwXqnlUYK0HIrcO2BUMiw/koV/XSFLjBH7mOojWabs99tdzZ29rYaXriklY1+zjt8ii1gINhMFjyi9OyKoDdGu7M6S9puTQLvRvP5IZFnC16+0TY0mSkrRtb2IQrv4YfwAM6pzO7TsBwJGgtkFFXvr7dxk88s+LRodsDj64hZZqKXKt1+5oDp6YiD0P1B0c/qxhPvI49tZMKwis7CQM29vr2774BnEHO2hxRE49CDfYBidGPZ0tt8izQTE473kY5BYugkltNErYWRidYjO+2BbMweor6lawO17frmK+TEnOY5pAOo1j5bvRdwNlwMJGf1eFJXvr7XbnTvb0gaY8bswK6zncJ+rV3as4/SqcUi5GicPsddUHLRc+DhhgyENvNLtWoc8rEFHgAgBAfmzSVH3rPUBXelhQSkG/tmNyhl7YMQfjB5LHAvKKUs/MZ7wnJMKJkJKVOQuI+j/roFn8wu24muuwH5FLUHXtdGNvWazFHbxzEn6gL0Pz5BW1ryTAWGOsvDIdC3FYHtxo6lZlZzlE6/QCXoiD+/vSIDItPb8RalFLZXFmvb1T3SIUvWURjHZidbGNO7jdMtdA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(7416014)(376014)(1800799024)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	38BZNsELOLzUKEImALIA4TEkKVzmJxSucTzixo67kihIDmRdhBX+MRhR6MUaOehT3zuTSbETP4q4qRelHrC36Fo8Qu3VcFl3d/ooczovrpdQDd4ClZMFr8TVYECKBQ5vYHdImQALP32G8CrxDUltr0YOlfn0EbpDhOTTFeJlA9uwCYIe6spT5BUfU2vrz/ITov3IokHRDOhrEUvh+7sanw+ObXiwybnvWgcAq/zPLHE29yCZhUc3L5LVyjNOZfA+7U8fDL0D2WRyyMVDTgA+u846Yqhv8UR89I90EbXxxyOKoAKVuHb3V74DdrtSNstt+PjOeoF23pVgwgeQlgquZpRDB9N8nuoFTRhIw5HQ1Pvg0KvFBJMl9b4APwc8shn5vQNuipCInEmvnVNSAc364Wbf/vzUJz/SWOenmwZmPytOit7RxcRKyBgpwxAjWSxF
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 01:30:07.6360
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5142d6f0-5127-4eb8-1149-08df24dbafe5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C618B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7777

On Tue, Oct 06, 2026 at 08:19:12PM +0800, Peng Fan (OSS) wrote:
> +static bool arm_smmu_is_shared_sid(struct arm_smmu_master *master)
> +{
> +	return !list_empty(&master->shared_masters_elm);
> +}
> +
> +static bool arm_smmu_skip_shared_ste(struct arm_smmu_device *smmu,
> +				     u32 sid, bool is_abort)
> +{
> +	struct arm_smmu_stream *stream;
> +
> +	lockdep_assert_held(&smmu->streams_mutex);
> +
> +	stream = arm_smmu_find_stream(smmu, sid);
> +	if (!stream || list_empty(&stream->shared_masters))
> +		return false;
> +
> +	if (is_abort)
> +		return true;
> +	if (stream->ste_installed)
> +		return true;
> +	stream->ste_installed = true;
> +	return false;

There is some issue here; check sashiko report:
https://sashiko.dev/#/patchset/20261006-smmu-shared-sid-v5-0-169a59c671d3%40nxp.com

Nicolin
