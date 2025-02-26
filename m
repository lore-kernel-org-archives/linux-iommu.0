Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2063.outbound.protection.outlook.com [40.107.101.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6C823A9AE
	for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 21:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740607103; cv=fail; b=hcUugKgMVwTDfWC4R/wkpjNuOEnltYwHnqob4n+YVMnU/HyzHap1bBay1SGEN2h8yzLDmPXrXBzUKuLNmyAtdfVBpW0+n/+5qqPtHH9fst780oPQ9d1DNY6CZ2KJthUJlRQxUcUkXTagk7OuEGsse15NV4fxn6ulhoNQZ6b+Vvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740607103; c=relaxed/simple;
	bh=xuEZwRs7IuSIWAAHprEndIuw+ByTka1SCvedsrh4MRM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TGX4HGp1wAfJPZi8D466pBkCwbUfWa97PAiuVsj4KsI5jBM1+hGlNKj7lZxIdiCGVBzrhDxlTCcAHjzQw9phwQxbIHJ7G5TTyvyq+dxljsIT3qLhpvBCOuvI5TLFnvo5wyefWDo+nax1P4mDlSh7j9ez+OmO914Hc7Gent+cBEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XVSon4AJ; arc=fail smtp.client-ip=40.107.101.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XVSon4AJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f8NEz9C4v8HvPAKghOUxhCTZarKNk+cdhZZUycUkK7mEAffMvxsWCar5UFaA3fks9cVJQE/cWzx4yeJ2bXFQ7bgsSjCFzHsTUPKLc4C0BJnYcfJmhZ4n+F2/7zFcIoTywrN5bHGsALZkN0lJ61JlwrYusw1XBBDETyi4Nu8zstYhn2GhbdA1ehMvgfdWKdM5A0YARAAvNMV3UKXM/8CU7M+fYAdWv23OeWwOy7gcWUTbmATMsfOF6F8x/RsE36+NdcElYNofN7pmdZaZO+ZmLOxpugl9ojmzEnVaKeUOnQqoNGKsL73Dwr1KPDCuXnNyVCxfTdW5OyiMlLMojOkuUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=26+k3sYOPHmbALHTEpQpwm6gs3nwnZGhrCzGiOlKjBc=;
 b=gC39XU59FgSURCk6Yap6o+8EV8zYPmYSlar0Eo9igbWMsYa7dLHfjsd+kme+M8LCtCAYmRlXQOLlg6r5LvOaiIESolasrjRh/mbBQEexULFCyhjJeDTekIGsorEywlI5ydBepFZJWxqP3T2YBPOEJjCFkYo+5NSrPoKnKo/wx8lN14ljbfZ2qN8IabNuJh6GvlNSvVBv7w9Cnas74hel03bXdCQ3hlbfU4sYCncxv7moRKXQGrNkzI/jjnJmS7kHsm3pJCCUCqOSVADtXZto1cFwsKdAlRtKWbue29gZrudwL2q3oLLAYdFtLepcOX9eXYul8BsQYS1sPMK8cWA7fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26+k3sYOPHmbALHTEpQpwm6gs3nwnZGhrCzGiOlKjBc=;
 b=XVSon4AJlFbfFVJbc6UFdqetR14Vw4iaron1N3+QsADOmnKNRwF6PeiN+aCpWwcrETNUB2byLGtMovQkzWiUWy9hCK5JR8YCMvwU7aI+1F/+ACcTQPQYpieGWFxOvINYrBmPbvHFeh10Zk2X0BjGbKseWEowksMENsKYpBICqRguMiK9pq7FsbF0rZ4Cd9EAZdHkJz7cGJT611IWR8mMm1P3bpLWrz3BsAs5wim91BP2+duSMwPtIzTmRYHbcZg9QPH4R5g2YGvvG1cY5DnbQx3qpTeDo0BGVJa90OJt8dglmVgiTcevPvFHcLgaOZLdHVRGQnamOSEUiyHSQged/g==
Received: from CY5PR17CA0031.namprd17.prod.outlook.com (2603:10b6:930:12::7)
 by CH3PR12MB8754.namprd12.prod.outlook.com (2603:10b6:610:170::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Wed, 26 Feb
 2025 21:58:19 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:930:12:cafe::fc) by CY5PR17CA0031.outlook.office365.com
 (2603:10b6:930:12::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Wed,
 26 Feb 2025 21:58:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 21:58:18 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Feb
 2025 13:58:02 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 26 Feb
 2025 13:58:02 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 26 Feb 2025 13:58:01 -0800
Date: Wed, 26 Feb 2025 13:58:00 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: <kevin.tian@intel.com>, <jgg@nvidia.com>, <joro@8bytes.org>,
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
Subject: Re: [PATCH 2/2] iommufd/selftest: Add coverage for RID replace
 between handle and non-handle
Message-ID: <Z7+OaMOs9nK6bwj9@Asurada-Nvidia>
References: <20250226050130.5814-1-yi.l.liu@intel.com>
 <20250226050130.5814-3-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250226050130.5814-3-yi.l.liu@intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|CH3PR12MB8754:EE_
X-MS-Office365-Filtering-Correlation-Id: ad0e0aab-12d2-41ba-255f-08dd56b0ade5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PQ7AtF+LqlsCh+SzC32aLZ0iBXnYIX9JNu/bYwo7ci3PJjmPrqbfQNCD0FQM?=
 =?us-ascii?Q?2Nkuk1rZRoFvRww8SAEmIrSyM9APb6+6aWUAOtMAstsaQl14CRi9x1XJlN59?=
 =?us-ascii?Q?R6r7BDUqrkBVWI0f57+sOi4J+tZ4PyVXyTZyYWeeGTM23sbFkBeLaigFO5+U?=
 =?us-ascii?Q?mhjlbu+kkp/2Qatn3v7icHCGuG/cyLQg4Rf1rk5NJUnEXCBYetGcWtA92wQM?=
 =?us-ascii?Q?oji0wgBICo9WsSPwoqxnhMyeYEtj/imqKVnJXZEl6l5MQv8Zt4H8NdhF+poi?=
 =?us-ascii?Q?F/iZ5LiDQgS4ITGubuEdj1htoB/GYbcyVQgy0oKRLls8WUZmibDGZnPh40eQ?=
 =?us-ascii?Q?MmarBBtXKf+8XZoUcTYGkk+0VZt7AlPnQ8KfridAB8r4VdFT9oy++6v/NQg0?=
 =?us-ascii?Q?5rH/8bpt1p/Gqw1DvxUPS3HJzIUoBP4YHA8mHVnsGPXzge7g7rQ+Q9y9G185?=
 =?us-ascii?Q?VNtZNgAJQLxkxfI+Rd5dIjeWzi3H03n8fqA0usJfn27eo+n4o0e1EwvtO6ad?=
 =?us-ascii?Q?1oBZHFpg+mzYitTeo4Yozlvsuoiap+w/0G+zKVgG/AdGoBdyTq8cj7BZ2wPb?=
 =?us-ascii?Q?sdK0Cqn38nN1JBOBYV4blteP1b+CxVuC3e7v8pkYBnbfLiff7sIfAYKsUHy3?=
 =?us-ascii?Q?e9yk5lCNL/f6Hn3pGnrJ1TqMituiOYkzknrfXI7opss3V1iCOOAhYACIaL1g?=
 =?us-ascii?Q?mJA126k8Xhz7LItuGdqt8yCb1Y/DSc2jUQFlIyuY5A2hq3DsRL0x9ezDuIsK?=
 =?us-ascii?Q?NfK393O5YJvm+HEuDg54gScVF0hh9lNXA66j08Hd9PAL4wjDRAdTn9rEzX1+?=
 =?us-ascii?Q?/hE1vggVlyNQLeHDbRam57Y2LrfC+4A2xaWa+akKIPJPpXZHhiV8Sky8GleN?=
 =?us-ascii?Q?VmTDNOKfgb7Kl7AtaelznuVXvLYm64deCk6jXs9piO0VhefDJEdOTzTSHypK?=
 =?us-ascii?Q?9SlgmuAS9NAJXo1Z4HWOzMHNCsotPnEVy43C/wcXCoOU9xhEIEwDIAX6jQGO?=
 =?us-ascii?Q?8Cc3mk+omZ4J8ehNGQKeQXCGNxP4xKMZog1KVGs2rKZpGcJpEfsk4lvuR3iJ?=
 =?us-ascii?Q?LBPyGFu1uLvXY1mXsGCmnjPoQ6AP2Qk0W2iabGNbm8cQUoSMACUEB3UWhoav?=
 =?us-ascii?Q?b1AMnDzeslFIc6ApYshZE6lFsUrt7z65VMWlab2P38XsgODg0j9vyI/iQIAc?=
 =?us-ascii?Q?bZs3BP5Gv1/Ku6ODjyCF+Z2aJ7npi9bp6zW0IhwpqM8pjbcCNzuC1m3kBG9M?=
 =?us-ascii?Q?6Mpc2Jd3TssFeuagm1p/UWekJ50aIeRZodbbpEgNsZFw6VOYzvR2BgxOqMK5?=
 =?us-ascii?Q?r/BVGyDJfgk1i4tHp83J+mlvXdb+H9OOVO+9F0iajSHjsGlW8ZER60gceyVD?=
 =?us-ascii?Q?F3Ny0qYA9QpJZ141TkVhgNeqPFvbvgyPP/j5UatdeJnqpm4p9eCg54fBGMvO?=
 =?us-ascii?Q?P8/gWcaQ2ejyCbO5U2EPM4Xqp08S2wk8dVIpJKy2zBlOlVa7OkZtManzny8u?=
 =?us-ascii?Q?g0qly3KlS/teDwA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 21:58:18.6780
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad0e0aab-12d2-41ba-255f-08dd56b0ade5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8754

On Tue, Feb 25, 2025 at 09:01:30PM -0800, Yi Liu wrote:
> The iommu core supports replace between the attach with/without handle,
> add test to cover it.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
[...]
> +static inline struct iommufd_hw_pagetable *
> +iommufd_get_hwpt(struct iommufd_ucmd *ucmd, u32 id)
> +{
> +	struct iommufd_object *pt_obj;
> +
> +	pt_obj = iommufd_get_object(ucmd->ictx, id, IOMMUFD_OBJ_ANY);
> +	if (IS_ERR(pt_obj))
> +		return ERR_CAST(pt_obj);
> +
> +	if (pt_obj->type != IOMMUFD_OBJ_HWPT_NESTED &&
> +	    pt_obj->type != IOMMUFD_OBJ_HWPT_PAGING) {
> +		iommufd_put_object(ucmd->ictx, pt_obj);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	return container_of(pt_obj, struct iommufd_hw_pagetable, obj);

Will there be any other caller potentially?

> +static int iommufd_test_mixed_group_replace(struct iommufd_device *idev,
> +					    struct iommu_domain *domain)
> +{
> +	struct iommu_domain *old_domain = iommu_get_domain_for_dev(idev->dev);
> +	struct iommu_group *group = idev->igroup->group;
> +	struct iommu_attach_handle *handle, *old_handle;
> +	int ret;
> +
> +	/*
> +	 * The test device should have been attached by the _handle API,
> +	 * hence there should be an entry in the group->pasid_array.
> +	 */
> +	old_handle = iommu_attach_handle_get(group, IOMMU_NO_PASID, 0);
> +	if (IS_ERR(old_handle))
> +		return PTR_ERR(old_handle);
> +
> +	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
> +	if (!handle)
> +		return -ENOMEM;
> +
> +	mutex_lock(&idev->igroup->lock);
> +	iommu_detach_group(domain, group);
> +
> +	/* attach without handle */
> +	ret = iommu_attach_group(domain, group);
> +	if (ret)
> +		goto out_revert;
> +
> +	/* replace with handle should succeed */
> +	ret = iommu_replace_group_handle(group, domain, handle);
> +	if (ret)
> +		goto out_revert;
> +
> +	if (iommu_get_domain_for_dev(idev->dev) != domain) {
> +		ret = -ENODEV;
> +		goto out_revert;
> +	}
> +
> +	/* replace with the same handle/domain should succeed */
> +	ret = iommu_replace_group_handle(group, domain, handle);

Hmm, this is switching between domains with/without a handle?
It feels odd to me, as we should do this in the user space code
other than in the kernel?

Also, I think that any iommufd-allocated domain (via hwpt) has
an attach_handle now, right? Mind elaborating a use case with
iommufd that can switch between domains with/without a handle?

Thanks
Nic
