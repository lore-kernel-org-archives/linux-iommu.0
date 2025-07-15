Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AF82C3252
	for <iommu@lists.linux.dev>; Tue, 15 Jul 2025 19:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752606817; cv=fail; b=nJAPTjRdEluvyynuMJdKD9YGV2XSVdQEoEL8KeSKsrluZslYdT1qCYN7iT+BYM5QFbPMmrPFlTRLw11HfZtNI6w2IMRO5EGR0CrPOdfqDf/zrkixvfalM3U8YjNGeoSDspnbM/jJG2cWg5SClHeZ0Zy5dIDt8+XiicCtDWI+VFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752606817; c=relaxed/simple;
	bh=GvFS21BDfQrYb1a2/SHRWyVu8H4amDniqZFUbmQNe54=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KBQvl6Rx3yKxHjOn+x2MRWNBl3kHTpvPFo2ywAroPRqNlIWziW6IVQqGoBADfdIGrN3Wxc3vxip7G8rldQ9tdM6BDvbnWqlK8SULLOx9hkOSSdSYf8dRpcg2md2dY3hWELBJLjCk/bKiEQCZwC3eTu08Ihaoex13tDgOrEag/Ko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Sl4Qi5Q5; arc=fail smtp.client-ip=40.107.92.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Sl4Qi5Q5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OW/0EAp01sD+ZqS9VzN9j7J4w3dbvdZ+SmomlpN5Htk4be5Xnc8pZMo4EOgjuTAANelwyvJhY5QAb4z9RwkVz97eBjJ+bNd0zOKCn79N6GxaqTyRLh76Djb7VERqktJO1PgjqwQug2VCi+AnIs4twXkTwxYNFGPuw8PMgMxTFQ+L9d4x0eQtw3LUe07zQVOxjYng/Y030mN+wm9zXHHu8Px2Ge/hNmwKzCG2VOqKSywA5vj1mBp1d0SJf368mQPVfvocd1StyJye5Wmw+Bv7AVodulVBJX2rEGEuUcqAQfUv+gx44VMSdEWNicxmH1FQ5+Tu78mQ2AMHmgm8428oXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wGDEmtbpK8dsIccJ71ZPW7g61J6A2hUv1El7HZjjU7c=;
 b=YKrlUBYjYgYpl+UCQC3Pbcehv9JHFpXPncYIKFkPUXhTGHGWJjQlLP+KhstuUUGbjYbFGEXeoZJRHoUJp40NA08GIuc893WH6Gv6z0nsuG2ksaX9DU8SGpxbt7tqsBHEwj8Tedo0EbD6wjW0OLmUXEd1GqMdCKDxKBbp+uby3pL0uX0e92DuowJH6OaK/z+6C/HnLvgBhCidY2Ld/p3lO50dDobXEJoaeFhS5AvqctsGi7mvLVZPPB3OMg11wmX0O3kDlicOcqYPmYm8W5QthJOXqhaK6Sicmwhj04dXPWRmCkgH0sjkIaHklLfQzy9d5gj2l/zToVLp6VxCBp5kng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGDEmtbpK8dsIccJ71ZPW7g61J6A2hUv1El7HZjjU7c=;
 b=Sl4Qi5Q55x9B4dP5laZlHFeGFGoqAJa/fJbopDJdzbnyEk4X1TucEuAOE8KwTj5cz63ENf4DYIGc9xR2DLW3lXuUI8+zASV8G6JpmLkM29Zv9/CxfIgw0v4TRfIejRyD6YzVkQe24f5oWY3o+wf1upExErZLkzFYIpDphqJ20Czm1jfE4QCliW9LAwcbR1q8QVu/RZQck63r5iocIHkjdNBhEWQmTxLmJ02TrVd8pLtXDAXk7TKtkm/+9IFOH/my6ILLCmIv7HLGr/pC2ZRz/e9t/0SvSrdnKsK7OWMgJfS94a3G95jWp8d4ZMiWoO9gRVHRwzDZDW54Xn6qEaNNvg==
Received: from MW4PR03CA0098.namprd03.prod.outlook.com (2603:10b6:303:b7::13)
 by MN0PR12MB6200.namprd12.prod.outlook.com (2603:10b6:208:3c3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Tue, 15 Jul
 2025 19:13:31 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:303:b7:cafe::bc) by MW4PR03CA0098.outlook.office365.com
 (2603:10b6:303:b7::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.17 via Frontend Transport; Tue,
 15 Jul 2025 19:13:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 19:13:29 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Jul
 2025 12:13:11 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 15 Jul 2025 12:13:10 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 15 Jul 2025 12:13:10 -0700
Date: Tue, 15 Jul 2025 12:13:08 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
CC: <jgg@nvidia.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<will@kernel.org>, <aneesh.kumar@kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <joro@8bytes.org>, <robin.murphy@arm.com>,
	<shuah@kernel.org>, <aik@amd.com>, <dan.j.williams@intel.com>,
	<baolu.lu@linux.intel.com>, <yilun.xu@intel.com>
Subject: Re: [PATCH v5 6/8] iommufd/selftest: Explicitly skip tests for
 inapplicable variant
Message-ID: <aHaoRAfClCoCtm21@Asurada-Nvidia>
References: <20250715063245.1799534-1-yilun.xu@linux.intel.com>
 <20250715063245.1799534-7-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250715063245.1799534-7-yilun.xu@linux.intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|MN0PR12MB6200:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ccf4485-034b-4462-579c-08ddc3d3af0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VDLNnqhnSo8bug+1dH4xbzNJJsQWmLg7QqsUAtLA8v+D4dLkz2Lvvb8hMRlJ?=
 =?us-ascii?Q?FpvWv6Sg5Hnsxum9SbU9bww+v+G1tc/74kvdV5FYADCW+E/blu2j5vEG2rov?=
 =?us-ascii?Q?Y1o8iJLUjIVCfi9XsVHYKVC7sVdMaItqCgWDdBGfkDclXK1ReOavaeONDAqC?=
 =?us-ascii?Q?R4eFXb/uB+9k9b2pe35PY2Ilu+Ffk5MxQvOYmNzsnbKKuN/D24QIRZaFl7hC?=
 =?us-ascii?Q?FWau+jjJzkdeS10jsj8v/xvNA/bTQCzbBYCGeLG3lj5n6OymAaCKStVu3Sn4?=
 =?us-ascii?Q?2xBfdc09KTyr8pptcWITEWGjeTw9rBZ/KBD1pNHpHr9nl3sCf2KlsRjU9QW5?=
 =?us-ascii?Q?/75vnw/bkDAEKE2Gg9+CaHyOkZbTi7R0omR5KwlydZ++kiDY3Z8tXEC1H2pI?=
 =?us-ascii?Q?iD5SdzgncKitIGi/sChXAiXwHC8wxyho/6k9WWPADBqCYM9CeY2IgfIPzOHW?=
 =?us-ascii?Q?G3oSZ7EPRaV4SafaLgwPUdbeY293s9B82PDM+Im4TajY75pa/vJb0FauJRvU?=
 =?us-ascii?Q?3mVKvsB5vG/dhNuitDzdlWmdZ7FLCWo7Qm1MYvXnzstX7+uzES2v8Vur0bwk?=
 =?us-ascii?Q?5YP8/TaTzxZzvfv1lRPtf5nlV7B5piuhoDfk2IOrupvzfZCswGYnirkF16MA?=
 =?us-ascii?Q?ovzdZar04ekRjHh2M4XWh6CkCrsWrUtID7x0KMb6QB4Fq1uBbaxUTIkYacge?=
 =?us-ascii?Q?NVsfAS+H2RnmnQhbBKvseG/+lRhHiz84kHLuzw0zvo9klj6iboRHZdGjm+sD?=
 =?us-ascii?Q?2yTq+mtqOzOOMsfI/0TntUcRcv9m5bVfw5RBAX5hhwigvSqqERvgEvQfDrU0?=
 =?us-ascii?Q?o5SH0DZURbsCIermvtGiUDx79s10GOD25Z8k4Dm7hToqk8qBraI/6fxXFowY?=
 =?us-ascii?Q?dr3AeqXA+lUQdqKW2PEWsRMTVzWbmlv/EidMi9dO+yoWUelcpYSwN9ZWil6o?=
 =?us-ascii?Q?2nZQaDc/cGS3N+ounEiKCh6Fm0lLrC62rhtORTa01CkMfW+Xfz7Z7xNIz3vU?=
 =?us-ascii?Q?uJqnt1gBQBsKxy+LLrj+AfDELUIKTitNs4wY02/AkAIVNd99sTNb/xAc6GmX?=
 =?us-ascii?Q?hDJ7zZ7tCIW5q87xhOIpEQ/FAOPySl6a/UynJhHnFCkBXx0p/NLljmZ4CECU?=
 =?us-ascii?Q?ETqa/1pc2VVdcL+Kz3jLX+27tEbHbTexTDhKFCaDjqIjAFe+3oZYS2FgviEl?=
 =?us-ascii?Q?LSzIMymcxqagWRoEHO3pm0CrGMTswkD2xYWNjb/3SvOggBIMH6zvbBgG+Ben?=
 =?us-ascii?Q?WRBcBCP0YR9uABhHZurKhl7vdAdIhW+y8lG2eHMj0OJHB+CqUJLxf6QGiCKW?=
 =?us-ascii?Q?wJfwRge61BSjYmVWJh3TBRsMkfwDJPopJzGnUSAX/u8zNTSXQ16A9HNrQ1vp?=
 =?us-ascii?Q?ys1TSnKuy9T/kMRw90Zgwn1FbMoNC0w96AALdsSwH17WY1xlXofq/Z356EDT?=
 =?us-ascii?Q?2YjAo2RnRxYHEk8H17HqKnSw0CwOhsc4Xcr+E3VQJGf2vdShSfjsB9okO2vd?=
 =?us-ascii?Q?e7FynVNx1nDoaxh4t/MhISveRRb8gNWDbkki?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 19:13:29.7706
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ccf4485-034b-4462-579c-08ddc3d3af0f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6200

On Tue, Jul 15, 2025 at 02:32:43PM +0800, Xu Yilun wrote:

Two nits:

> +	test_ioctl_fault_alloc(&fault_id, &fault_fd);
> +	test_err_hwpt_alloc_iopf(ENOENT, dev_id, viommu_id, UINT32_MAX,
> +				 IOMMU_HWPT_FAULT_ID_VALID, &iopf_hwpt_id,
> +				 IOMMU_HWPT_DATA_SELFTEST, &data,
> +				 sizeof(data));

sizeof(data) could fit into previous line.

> +	test_cmd_hwpt_alloc_iopf(dev_id, viommu_id, fault_id,
> +				 IOMMU_HWPT_FAULT_ID_VALID, &iopf_hwpt_id,
> +				 IOMMU_HWPT_DATA_SELFTEST, &data,
> +				 sizeof(data));

Ditto

Thanks
Nicolin
