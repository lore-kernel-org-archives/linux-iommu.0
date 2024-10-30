Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEABE63CB
	for <iommu@lists.linux.dev>; Wed, 30 Oct 2024 06:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730270444; cv=fail; b=oUv4RtWmQ/yepiak/pjCjWhrlPzXwGmVqZuglX2QW8o2JEqAqUD8WrPGLJzbhPYJ4tFLavS9dgj0ybxlBHMQixDwM2GILWcwiPtJT+7tTeAIbWrSUZv96BEIrFtsNmh1xIQLxGi3paL7RJTO2nyQx55rtLsmmVoHFHMe7eiHNYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730270444; c=relaxed/simple;
	bh=SaGOpPPBfK4pkgzXMzk1G1ZvTcgMAUqMfy7YL7EyJwU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rsxpxaxQM38DXrmYODqwQp9PpBD/2nTYt8H5HbF+RoiKBv7ZV8Az5kVhoEnF5B0WK7aYgdKY55t8Uh1gJWb9BrNHhFJ4rRtV1de0U9GsMH1ncisi8hJnzBytwkqJEXH8Qe+7DaaKTvUj3A+lJFwVGTxgGTyGLOdiLbNIwmmE+sI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vJlOjLwF; arc=fail smtp.client-ip=40.107.223.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vJlOjLwF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HDYOIo4Wx/hXsZLAauemHCStnKZ7vAVSNS1JLIE1Zf/YAJr//tHRFGygfG1G0vNIdgB17r3sW8hnFIwl2q6SP3MVKNJfZjZk46V0XoarFoLmuLFKhXOsRopKdUQtnMnGv6+br2wC/vIeLKnd6bBq2xlWk1iMglKhwQ0IMoB6D1Yt77m2ja4X+zsXPhwC7sxVVdaV9LIAkBlsUk7W2C5WU6QKKVGzHizCtEDJ56x1x66zRfYvFAjNET9ajU7DyWItbfG/AZDH190AnqK9BwYq8I+1x+m9wCl3A7jECI+VbctREotehLKgKfNnDTrYWQM5eo74yaCh7weQQkj9P7I9uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PnJeFvrNfRrZI68ZQXVqEEdtTualaytgvXXm9xsYr7o=;
 b=hsQ96Cv+zz40nwRxRyBdpX1qzUhzr3EioT4MRrbk2ROqXoHnObwRILd36FB6PMN6pdE4azEts1IqtNhgucpqUuS1iRRvE3fg+qBszuFCyN0GYX4/EIwEVxImYj/pJGnHgWSkUygz82x4ygJxH/3vbZO6hk3va7mir5qhXlKYWgrnzkaqZDSmXjZb26fAzSJmLFWZgDRI7gP6BA0WJ0LG1rp82VHodIz/IouxU2loeaJOWgrCBh+U/lSJfwJU9xBCz+pb0YwtsQHG9cpbiBcIF3/TFDi4O0DXxuNACsvxYfPXft+d1XRNpnCZVkArBugm9AYhuktOfMydVQ+qcsQuiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnJeFvrNfRrZI68ZQXVqEEdtTualaytgvXXm9xsYr7o=;
 b=vJlOjLwFv8xFIVCt3wEnR2MAdI34H2FMOj+vqhRZPGnXe2VKS8X5iKt//Gmq/riOI4UFt5V5cajco5ckpOWUV0t1qc8frXrPmbKbP2oAkGvpe9ZfFzYH1PqB49xsU2ZKa+aGQD1gMIp6ECfOxtze0/ILR9SMVFKB6ywHwm+C8VA=
Received: from SJ0PR03CA0185.namprd03.prod.outlook.com (2603:10b6:a03:2ef::10)
 by SA0PR12MB7074.namprd12.prod.outlook.com (2603:10b6:806:2d5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Wed, 30 Oct
 2024 06:40:35 +0000
Received: from SJ1PEPF00002320.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::72) by SJ0PR03CA0185.outlook.office365.com
 (2603:10b6:a03:2ef::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25 via Frontend
 Transport; Wed, 30 Oct 2024 06:40:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002320.mail.protection.outlook.com (10.167.242.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 06:40:34 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 01:36:26 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, Vasant Hegde
	<vasant.hegde@amd.com>
Subject: [PATCH v5 00/12] iommu/amd: Improve domain allocator and device attach code path
Date: Wed, 30 Oct 2024 06:35:44 +0000
Message-ID: <20241030063556.6104-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002320:EE_|SA0PR12MB7074:EE_
X-MS-Office365-Filtering-Correlation-Id: 40fc8f21-d9ad-49fa-efd4-08dcf8adc21d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bjmyoy8UnyS7dJSIlRbrneH7I1ZPFZWSKkEbAhFRAryF+c6xe9XqnWpsIxG/?=
 =?us-ascii?Q?t4tjPQeB675J5DuIdnlghU9DyQu3xSqmjFbW2WATLlNGBcm6tHJ+rfp1pRFS?=
 =?us-ascii?Q?X7SS0xr1LcAKSMsoKksCE/cXkav1dt4xW2zERv2NJk7QIxmYu3cCC7oUr7jW?=
 =?us-ascii?Q?rc2uEyuKUILXvDZJBuEqeUKmixL5ldT/1sERf4Z6/seMptiycTvsb4idi3wV?=
 =?us-ascii?Q?ujp6oQIXQFdVXKwhQiW6nmwI1FIbjR5+njx+DR9p9GAm0Rf51nxanihNXX6I?=
 =?us-ascii?Q?0rC+opAbdAcEN1eBqwwN3UPQnB5xuA/59wnFxErAyiG8v52VmdFh3fXMwgOz?=
 =?us-ascii?Q?FhMhPJGEM3v9IMot3xF3JIibiu6eNGG+aBddRRhCb2D5bH1boARrTDK+pHlb?=
 =?us-ascii?Q?jlaMYwDVxTcg89I58+GwADrwsYQHSGPnPm1OQyVjzt9ok6BuLiX9dg983MH6?=
 =?us-ascii?Q?7xPl8HW3Mo569yQAY3Vhs9wYjdiXPRbu8ke2j/smOmPp1NCKbRGrUbb4gP5l?=
 =?us-ascii?Q?PqCUfM3iGMgZqn3guihyjinqsDnGvjlCvGtRD7bnYTBivWvP9hJqeFs9Hxxp?=
 =?us-ascii?Q?HfBLPpyMu2luPFLaIwAY+tr+RO1TD2mh/A6e/l2MIg0AG4/9g7QXvoyvXsPE?=
 =?us-ascii?Q?2ibiMYK6v5ode5kxLI5PR6W05d3xXlIHCaIDaoMgwIcV9u3mlBOtMOVt5YUV?=
 =?us-ascii?Q?dljhBdzeMErsJxzOLJ9ssLOzbsr15FiOCTfjdYJAWOyfvkvIMUxJc1HNSFS8?=
 =?us-ascii?Q?9UYvTT+IbqDXZhjIR2I0I6xDnA4Ocz4cPJgdWKFuYm6a+EjfLd6hNEg2OPAt?=
 =?us-ascii?Q?LEbSY8gBxcpsWELDkCYOALADBqg/hz3GLvgO6Uo4hZMLOkQ8NwuoxfjxLAol?=
 =?us-ascii?Q?n+bfYIUgQvGnAovrVQkmBb8reWh7fYFZO2cdUSlQYUscCGj3pjeHU5uM25U6?=
 =?us-ascii?Q?rkCbZnSk6IgWmIN43M03ez1grGHBwHDlcghC0JUr8zF161EYOXz/chwQFBZL?=
 =?us-ascii?Q?7Ntt281rBE2UrzPd3/HihZzlua2wcj7T1rL+JV6pdyXk+X/XSPB7rFGOaX7f?=
 =?us-ascii?Q?gH0Ou+MqVDBOku/9GnlvtlQXxGjG7KNHTUrNJx/H7ZQO0XU0QZUA5jP3MLSs?=
 =?us-ascii?Q?UjszVmnJu+hdkJMB5ZpdLa/jpVf3YgrDg8HG9Bcj9TQUUDNMHelJUiSQH5Oa?=
 =?us-ascii?Q?YNRpVn1SS2aD2rmHxN8cHmTmNchV85zNc4S/mmf2giBebfnZTGzaJ1DwfdyS?=
 =?us-ascii?Q?uT1B4cCkUeoYfJSxR9HigAbSp2a89sc0hBYXn5PeTEpVzjzmZOwnyZ91P2Qd?=
 =?us-ascii?Q?k/qfGOxBKjjDSkj3j1Oop/gvRzAqQ5t/0+WAx6ryrtmhV3T5tnd2tDBemYoy?=
 =?us-ascii?Q?GsSagW4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 06:40:34.7977
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40fc8f21-d9ad-49fa-efd4-08dcf8adc21d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002320.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7074

This series aims to improve domain allocator and attach device code path.
  - Replace custom domain ID allocator with IDA allocator.
  - Improve protection domain data structure
  - Improve attach device code path and replace dev_data spinlock with mutex
  - Add ops->release_domain() support

This series is on top of iommu/core branch (Commit a33bf8d8ce7).

This is also available at github :
  https://github.com/AMDESE/linux-iommu/tree/iommu_rework_attach_dev_v5


Changes from v4 - v5:
  - Rebased on top of iommu/core branch
  - Added Reviewed-by tags
  - Renamed amd_iommu_pdom_id_alloc -> pdom_id_alloc() as its static function
  - Fixed patch 11 subject line

V4: https://lore.kernel.org/linux-iommu/20241028113148.5774-1-vasant.hegde@amd.com/T/#t


Changes from v3 - v4:
  - Added release domain support
  - Added new patch to fix missign lock in pgtbl_v2 code path
  - Reworked protection domain ID allocation code
  - Fixed missing lock in TLB flush code path
  - Improved amd_iommu_release_device()

V3 : https://lore.kernel.org/linux-iommu/20241016053501.97497-1-vasant.hegde@amd.com/T/#u

Changes from v2 -> v3:
  - Rebased on top of v6.12-rc3
  - Added Reviewed-by tags
  - Updated patch description

V2 : https://lore.kernel.org/linux-iommu/20240910065812.6091-1-vasant.hegde@amd.com/T/#t

Changes from v1 -> v2:
  - Rebased on top of iommu/next
  - Minor fixes.


V1 : https://lore.kernel.org/linux-iommu/20240828134317.6239-1-vasant.hegde@amd.com/T/#t

-Vasant

Vasant Hegde (12):
  iommu/amd/pgtbl_v2: Take protection domain lock before invalidating
    TLB
  iommu/amd: Use ida interface to manage protection domain ID
  iommu/amd: Remove protection_domain.dev_cnt variable
  iommu/amd: xarray to track protection_domain->iommu list
  iommu/amd: Remove unused amd_iommus variable
  iommu/amd: Do not detach devices in domain free path
  iommu/amd: Reduce domain lock scope in attach device path
  iommu/amd: Rearrange attach device code
  iommu/amd: Convert dev_data lock from spinlock to mutex
  iommu/amd: Reorder attach device code
  iommu/amd: Add ops->release_domain
  iommu/amd: Improve amd_iommu_release_device()

 drivers/iommu/amd/amd_iommu_types.h |  23 +-
 drivers/iommu/amd/init.c            |  37 +--
 drivers/iommu/amd/io_pgtable_v2.c   |   3 +
 drivers/iommu/amd/iommu.c           | 360 +++++++++++++---------------
 4 files changed, 194 insertions(+), 229 deletions(-)

-- 
2.31.1

