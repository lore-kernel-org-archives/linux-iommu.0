Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817A11CF8B
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 00:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742517268; cv=fail; b=cR0/7ropPNcGdyPnr1AsLXrofm78YdU1Hc82VfOV6f7mQV+VisXTijzfvzFMxe08IiaQLBloGQpvMd1ET3CWVGgB7lgQhm3u4UF49Va866bE0zavsCeV9Ag4kF2qdVMYulv/VmAZMfZw6VqLq4G20DZe+stFjFduQpATtbpYOpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742517268; c=relaxed/simple;
	bh=Ce0HH85dDgKtVHfi28kGCuFZU0zHxfLNZ9mvDZpf1X8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YFZTbDqfuH/8SjhGlQQthS1HYYtjpkyjCvE3H2umyaCLnhviRR3/QrgdjUuStmm9MgT0PLJvSKT0gc1m7f0En6ucga94RRtFSLG3YZKqk5cAjw65TvNLBojt0T6OgymzlkwiSEHBAw9dSBMyfnjwIv4t0yIj+D7X3lBu0CXTHzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=im/TnI92; arc=fail smtp.client-ip=40.107.237.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="im/TnI92"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G8UuVoLkOHXa24loKaWdrpZVHX4g62Qf3+hc/j3Tbuo9VPcPo9YN0ycpbGeTfGWA6nmW5xufDlEBNHpP+FMxWVBYyuuejnD6ojBN4madidPYX5psaAMK3W7ICemn6jkAVd4Q3TYQb2GatV0X0oTe202d6q49rrHSdkSvc84uBvwtDKtUG4YPyQdELllTA2518Z1oC4M8eAQMyuNPubvREf+jgeLFHGCDwWEIZ6mrzaDF9SfTSkoQb79Z5diUhccC0m1rx2Q5moa3gwPOv47qOgA1q85ts5+pv8uKl+o/vlWvYIjkcqbJev0DhBhhFPq15g9IjZ360RO7ifa45lCy6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTwCwXaeRQWLvLnW8+hpMMjT+2YN+dNW3o3BelyjE4Y=;
 b=QYB3ux2v/PDYpyIy7qIqUMcQsQ8hl1CeG1bIrmP+9+M7XB2Q0an0i3HaMhpN/dLz35oLnpvtpIff9I0cNRJK8mFwHyf/9+eitEh6gge/Ew6gQJ7EBbZLQlCzkPR1rmrUwxQwPw82BLnYZwmWnOBhJmeZRA3RJ0P/aE+xbNFgen/qt4hdMqwXiahsZT+8WGGhIAUyxijRzavzuf58cZy77VWJpPfgmr1gKDp71oZfqn1jyID4JOTzWrHNLDbQvTeZwMu7ljMn7izhFtUSMt4bqV7aAKaWvCQ79XczYO5beieOUc7i3vEdbI6sOtqGZ90NlbrtwKZqk+s7yAKNqlWJvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTwCwXaeRQWLvLnW8+hpMMjT+2YN+dNW3o3BelyjE4Y=;
 b=im/TnI92CIO2SIAQvmg3KXL5EP7n425zAYxQ9hYBzjAZwNXpL4euI2Aztt9TeeCGmMZs9pRzU1rrG8/eZsB5IJPmv28hhitxgy9Pz+i5eyqzPVYVSYTAs9FGvt3ovO/3gOyQGQldwRcK+JfX41U06f9KQ/+oHuqYMVpIRBuJMniB1cvUhUVffSksg1PGOISz6SsbXp9CDWAJW3wMM57efp8vburePupg02loOau4lRVyDQXH0EYj/cm53ljZ7Ckady8hJJVbkY5+po6gtNtiTiB8uWlsuHNat6QKzOuH2yn7gzI0X/iNAV8vWT9LzX0y+u8mL85kNUyWoyFlp+3/rQ==
Received: from DS7PR03CA0266.namprd03.prod.outlook.com (2603:10b6:5:3b3::31)
 by MN2PR12MB4126.namprd12.prod.outlook.com (2603:10b6:208:199::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Fri, 21 Mar
 2025 00:34:21 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:5:3b3:cafe::ad) by DS7PR03CA0266.outlook.office365.com
 (2603:10b6:5:3b3::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Fri,
 21 Mar 2025 00:34:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Fri, 21 Mar 2025 00:34:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 20 Mar
 2025 17:34:09 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 20 Mar
 2025 17:34:08 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 20 Mar 2025 17:34:08 -0700
Date: Thu, 20 Mar 2025 17:34:06 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: <kevin.tian@intel.com>, <jgg@nvidia.com>, <joro@8bytes.org>,
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
Subject: Re: [PATCH v10 18/18] iommufd/selftest: Add coverage for iommufd
 pasid attach/detach
Message-ID: <Z9yz/pVlPy6sOxP0@Asurada-Nvidia>
References: <20250320134744.5777-1-yi.l.liu@intel.com>
 <20250320134744.5777-19-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250320134744.5777-19-yi.l.liu@intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|MN2PR12MB4126:EE_
X-MS-Office365-Filtering-Correlation-Id: ee9a2cd9-9e78-4b0a-f4e3-08dd68101f09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uzphAqM6FG4IXnHX01M9gRGInxM+PQhDDW03aasBnYDLQCsGXGMLw/oDFya4?=
 =?us-ascii?Q?9wrt45j5ibqx8wPTmfdHWz4+c+Fxk1rw0QFUgueRhKUan2gFJXjKDRVy+9Zx?=
 =?us-ascii?Q?oT2//gBkXViTEXuxHnFyOGy0nmsbqhwgyxvjxaCNOgqrGCN4KMHZ1l3POUff?=
 =?us-ascii?Q?X+xePhlyz9wkwibmNqhjuzMQWImXhHVdBXVXCwhfhBSCWDjI32zfYdnR5KYL?=
 =?us-ascii?Q?i7vLdOx4rzmfazgU2SBhbWM524EKesjK77yEcgk8R1GLFWXugFqSWU28shgQ?=
 =?us-ascii?Q?mFvixl0eeMuDoGLBHbNwhpydRD94bvYZssYxWRwJwUGd6fFGF93mlP93p9dI?=
 =?us-ascii?Q?VJv333XHlCT52tdkI5NnjFOnPu0qri8mV6AqgQfZq6Wre2IlsrIkKz3JRw45?=
 =?us-ascii?Q?pAwltLShcq846ClC9oYFxW9+80kIF+DRdX4g5borYFLn8BO8x94el5eWbCMO?=
 =?us-ascii?Q?yVUO4t1ssvTkq3z5zisi2htXXhlai73VLFctZJsyPoWFMkB6jUFXd4tDD+XO?=
 =?us-ascii?Q?dSBA35l5OWUF1rr7OFC/uopfuLNJel/9zJ00E/J4gG5+NWOEEcj+3tzxfMz5?=
 =?us-ascii?Q?n5Wn8nxZnYMcC3vANycLkcmd63KC4IOdhTXpp/In0G4HtKTdMaASuznweZPE?=
 =?us-ascii?Q?ZbQ1I2SJ7meFVsappca+cK3MB75bP1K1kQZlW+1V5TU2w1hO1h4yq/ii7a4a?=
 =?us-ascii?Q?tUFlDHZ4c+gzZsXHw5aOuxmkJo0BWd0byRAy8TMUiUY687qDSZfJ3X1LAIab?=
 =?us-ascii?Q?KUZs7h2zQdvowR2ZlydWDi+GDuKtZBUosYB9wDU8Bw/JqQW8xbDG+BuNn6am?=
 =?us-ascii?Q?Pj8mtQVV22XHM+vz2yzisOAr/Zf64GvVjwo3nukhNosSA4IWcw1JS0TDML03?=
 =?us-ascii?Q?K4JR0L5APYVfrYA8YUUuI2k+eq92z8iId4tDhx913ob78argdiTHjsgnRRRE?=
 =?us-ascii?Q?7IhrmeKh+otT77BLYN5nA+xdpQEZWEt51AEIrG8+aNMmgiiqN0Px3jcnTBN0?=
 =?us-ascii?Q?U56/Xv4FEhSbU8LXpKxfGPH5iKMKjiCfCSDXx4T0Ar4qaJXlTS0O2FuwURY4?=
 =?us-ascii?Q?pgh9lFqMj7dH7Iq6nk45OEUPIUbe2vef9soU3QnsdHV2JtSLChRECQAF/KZk?=
 =?us-ascii?Q?tGUdZMvext5h1eStkDJlwCfvm50ya5NKf7l6lInQAVPCgt1MeiRK4u0aehpO?=
 =?us-ascii?Q?7VMuvGsd25umDud0whs8YsGAqcLMFVUpdYZK4CuR8V2eC8FFv2Z7XH0+kr4L?=
 =?us-ascii?Q?5XeZ4cSICzC6vyRaMIP7GGBpTQhb8NxFGx5BIrruB6g3r3gcdeTv0BN05TdN?=
 =?us-ascii?Q?EnqCtWM74jmbrWgv4E/m2f6TDmPYtI4P+/Rrc3aJLm9Bz4Trjw2tZofRboH1?=
 =?us-ascii?Q?M+dZG9kB78JwNECme+y9CzX4kuT5z9jaMP1LPVTD4XFooTZkWwSOrMG/SUAT?=
 =?us-ascii?Q?+guJPrP2Aa70oQ+tKggEqtZNyuCepxcHebI64I32HPDpnRzbvjojlk5pu+xO?=
 =?us-ascii?Q?tzqNKOSfGJ1cDVc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 00:34:20.4271
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee9a2cd9-9e78-4b0a-f4e3-08dd68101f09
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4126

On Thu, Mar 20, 2025 at 06:47:44AM -0700, Yi Liu wrote:

> +TEST_F(iommufd_device_pasid, pasid_attach)
> +{
> +	struct iommu_hwpt_selftest data = {
> +		.iotlb =  IOMMU_TEST_IOTLB_DEFAULT,
> +	};
> +	uint32_t nested_hwpt_id[3] = {};
> +	uint32_t parent_hwpt_id = 0;
> +	uint32_t fault_id, fault_fd;
> +	uint32_t s2_hwpt_id = 0;
> +	uint32_t iopf_hwpt_id;
> +	uint32_t pasid = 100;
> +	uint32_t auto_hwpt;
> +	uint32_t viommu_id;
> +	bool result;
> +
> +	/* Allocate two nested hwpts sharing one common parent hwpt */
> +	test_cmd_hwpt_alloc(self->device_id, self->ioas_id,
> +			    IOMMU_HWPT_ALLOC_NEST_PARENT,
> +			    &parent_hwpt_id);
> +	test_cmd_hwpt_alloc_nested(self->device_id, parent_hwpt_id,
> +				   IOMMU_HWPT_ALLOC_PASID,
> +				   &nested_hwpt_id[0],
> +				   IOMMU_HWPT_DATA_SELFTEST,
> +				   &data, sizeof(data));
> +	test_cmd_hwpt_alloc_nested(self->device_id, parent_hwpt_id,
> +				   IOMMU_HWPT_ALLOC_PASID,
> +				   &nested_hwpt_id[1],
> +				   IOMMU_HWPT_DATA_SELFTEST,
> +				   &data, sizeof(data));
> +
> +	/* Faulte related preparation */

Fault

> +	/* Allocate a regular nested hwpt based on viommu */
> +	test_cmd_viommu_alloc(self->device_id, parent_hwpt_id,
> +			      IOMMU_VIOMMU_TYPE_SELFTEST,
> +			      &viommu_id);
> +	test_cmd_hwpt_alloc_nested(self->device_id, viommu_id,
> +				   IOMMU_HWPT_ALLOC_PASID,
> +				   &nested_hwpt_id[2],
> +				   IOMMU_HWPT_DATA_SELFTEST, &data,
> +				   sizeof(data));
> +
> +	test_cmd_hwpt_alloc(self->device_id, self->ioas_id,
> +			    IOMMU_HWPT_ALLOC_PASID,
> +			    &s2_hwpt_id);
> +
> +	/* Attach RID to non-pasid compat domain, */
> +	test_cmd_mock_domain_replace(self->stdev_id, parent_hwpt_id);
> +	/* then attach to pasid should fail */
> +	test_err_pasid_attach(EINVAL, pasid, s2_hwpt_id, NULL);
> +
> +	/* Attach RID to pasid compat domain, */
> +	test_cmd_mock_domain_replace(self->stdev_id, s2_hwpt_id);
> +	/* then attach to pasid should succeed, */
> +	test_cmd_pasid_attach(pasid, nested_hwpt_id[0], NULL);
> +	/* but attach RID to non-pasid compat domain should fail now. */
> +	test_err_mock_domain_replace(EINVAL, self->stdev_id, parent_hwpt_id);
> +	test_cmd_pasid_detach(pasid);
> +
> +	if (!variant->pasid_capable) {
> +		/*
> +		 * PASID-compatible domain can be used by non-PASID-capable
> +		 * device.
> +		 */
> +		test_cmd_mock_domain_replace(self->no_pasid_stdev_id, nested_hwpt_id[0]);
> +		test_cmd_mock_domain_replace(self->no_pasid_stdev_id, self->ioas_id);
> +		/*
> +		 * Attach hwpt to pasid#100 of non-PASID-capable device,
> +		 * should fail, no matter domain is pasid-comapt or not.
> +		 */
> +		EXPECT_ERRNO(EINVAL,
> +			     _test_cmd_pasid_attach(self->fd, self->no_pasid_stdev_id,
> +						    pasid, parent_hwpt_id, NULL));
> +		EXPECT_ERRNO(EINVAL,
> +			     _test_cmd_pasid_attach(self->fd, self->no_pasid_stdev_id,
> +						    pasid, s2_hwpt_id, NULL));
> +	}

It seems that we should test these anyway without a variant?

> +
> +	/*
> +	 * Attach non pasid compat hwpt to pasid-capable device, should
> +	 * fail, and have null domain.
> +	 */
> +	test_err_pasid_attach(EINVAL, pasid, parent_hwpt_id, NULL);
> +	ASSERT_EQ(0,
> +		  test_cmd_pasid_check_domain(self->fd, self->stdev_id,
> +					      pasid, 0, &result));
> +	EXPECT_EQ(1, result);
> +
> +	/*
> +	 * Attach ioas to pasid 100, should succeed, domain should
> +	 * be valid.
> +	 */
> +	test_cmd_pasid_attach(pasid, self->ioas_id, &auto_hwpt);
> +	ASSERT_EQ(0,
> +		  test_cmd_pasid_check_domain(self->fd, self->stdev_id,
> +					      pasid, auto_hwpt, &result));
> +	EXPECT_EQ(1, result);

Hmm, I thought that a non-RID PASID slot could only attach a PASID-
compatible HWPT. I think I am totally confused now... lol

Perhaps we need a detailed documentation somewhere, at least as a
reminder or so?

> +
> +	/* Attach to pasid 100 which has been attached, should fail. */
> +	test_err_pasid_attach(EBUSY, pasid, self->ioas_id, &auto_hwpt);
> +
> +	/*
> +	 * Try attach pasid 100 with another hwpt, should FAIL
> +	 * as attach does not allow overwrite, use REPLACE instead.
> +	 */
> +	test_err_pasid_attach(EBUSY, pasid, nested_hwpt_id[0], NULL);
> +
> +	/*
> +	 * Detach hwpt from pasid 100, and check if the pasid 100
> +	 * has null domain. Should be done before the next attach.
> +	 */
> +	test_cmd_pasid_detach(pasid);
> +	ASSERT_EQ(0,
> +		  test_cmd_pasid_check_domain(self->fd, self->stdev_id,
> +					      pasid, 0, &result));
> +	EXPECT_EQ(1, result);
> +
> +	/*
> +	 * Attach nested hwpt to pasid 100, should succeed, domain
> +	 * should be valid.
> +	 */
> +	test_cmd_pasid_attach(pasid, nested_hwpt_id[0], NULL);
> +	ASSERT_EQ(0,
> +		  test_cmd_pasid_check_domain(self->fd, self->stdev_id,
> +					      pasid, nested_hwpt_id[0],
> +					      &result));
> +	EXPECT_EQ(1, result);
> +
> +	/* Attach to pasid 100 which has been attached, should fail. */
> +	test_err_pasid_attach(EBUSY, pasid, nested_hwpt_id[0], NULL);
> +
> +	/*
> +	 * Detach hwpt from pasid 100, and check if the pasid 100
> +	 * has null domain
> +	 */
> +	test_cmd_pasid_detach(pasid);
> +	ASSERT_EQ(0,
> +		  test_cmd_pasid_check_domain(self->fd, self->stdev_id,
> +					      pasid, 0, &result));
> +	EXPECT_EQ(1, result);
> +
> +	/* Replace tests */
> +
> +	pasid = 200;
> +	/*
> +	 * Replace pasid 200 without attaching it first, should
> +	 * fail with -EINVAL.
> +	 */
> +	test_err_cmd_pasid_replace(EINVAL, pasid, s2_hwpt_id, NULL);
> +
> +	/*
> +	 * Attach a s2 hwpt to pasid 200, should succeed, domain should

Attach the ..

> +	 * be valid.
> +	 */
> +	test_cmd_pasid_attach(pasid, s2_hwpt_id, NULL);
> +	ASSERT_EQ(0,
> +		  test_cmd_pasid_check_domain(self->fd, self->stdev_id,
> +					      pasid, s2_hwpt_id,
> +					      &result));
> +	EXPECT_EQ(1, result);
> +
> +	/*
> +	 * Replace pasid 200 with self->ioas_id, should succeed,
> +	 * and have valid domain.
> +	 */
> +	test_cmd_pasid_replace(pasid, self->ioas_id, &auto_hwpt);
> +	ASSERT_EQ(0,
> +		  test_cmd_pasid_check_domain(self->fd, self->stdev_id,
> +					      pasid, auto_hwpt,
> +					      &result));
> +	EXPECT_EQ(1, result);
> +
> +	/*
> +	 * Replace a nested hwpt for pasid 200, should succeed,
> +	 * and have valid domain.
> +	 */
> +	test_cmd_pasid_replace(pasid, nested_hwpt_id[0], NULL);
> +	ASSERT_EQ(0,
> +		  test_cmd_pasid_check_domain(self->fd, self->stdev_id,
> +					      pasid, nested_hwpt_id[0],
> +					      &result));
> +	EXPECT_EQ(1, result);
> +
> +	/*
> +	 * Replace with another nested hwpt for pasid 200, should
> +	 * succeed, and have valid domain.
> +	 */
> +	test_cmd_pasid_replace(pasid, nested_hwpt_id[1], NULL);
> +	ASSERT_EQ(0,
> +		  test_cmd_pasid_check_domain(self->fd, self->stdev_id,
> +					      pasid, nested_hwpt_id[1],
> +					      &result));
> +	EXPECT_EQ(1, result);
> +
> +	/*
> +	 * Detach hwpt from pasid 200, and check if the pasid 200
> +	 * has null domain.
> +	 */
> +	test_cmd_pasid_detach(pasid);
> +	ASSERT_EQ(0,
> +		  test_cmd_pasid_check_domain(self->fd, self->stdev_id,
> +					      pasid, 0, &result));
> +	EXPECT_EQ(1, result);
> +
> +	/* Negative Tests for pasid replace, use pasid 1024 */
> +
> +	/*
> +	 * Attach a s2 hwpt to pasid 1024, should succeed, domain should

Attach the ...

> +	 * be valid.
> +	 */
> +	pasid = 1024;
> +	test_cmd_pasid_attach(pasid, s2_hwpt_id, NULL);
> +	ASSERT_EQ(0,
> +		  test_cmd_pasid_check_domain(self->fd, self->stdev_id,
> +					      pasid, s2_hwpt_id,
> +					      &result));
> +	EXPECT_EQ(1, result);
> +
> +	/*
> +	 * Replace pasid 1024 with self->ioas_id, should fail,
> +	 * but have the old valid domain. This is a designed
> +	 * negative case, normally replace with self->ioas_id
> +	 * could succeed.
> +	 */
> +	test_err_cmd_pasid_replace(ENOMEM, pasid, self->ioas_id, NULL);
> +	ASSERT_EQ(0,
> +		  test_cmd_pasid_check_domain(self->fd, self->stdev_id,
> +					      pasid, s2_hwpt_id,
> +					      &result));
> +	EXPECT_EQ(1, result);
> +
> +	/*
> +	 * Detach hwpt from pasid 1024, and check if the pasid 1024
> +	 * has null domain.
> +	 */
> +	test_cmd_pasid_detach(pasid);

The designed "failing" replace does "pasid_1024_attached = false",
meaning that this detach() isn't necessary?

Or perhaps the designed "failing" shouldn't set "attached = false"?

> +	/* Detach the s2_hwpt_id from RID */
> +	test_cmd_mock_domain_replace(self->stdev_id, self->ioas_id);
> +
> +	test_ioctl_destroy(nested_hwpt_id[0]);
> +	test_ioctl_destroy(nested_hwpt_id[1]);
> +	test_ioctl_destroy(nested_hwpt_id[2]);
> +	test_ioctl_destroy(viommu_id);
> +	test_ioctl_destroy(parent_hwpt_id);
> +	test_ioctl_destroy(s2_hwpt_id);

Once detached, all the destroys can be done automatically?
