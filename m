Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C141862AE
	for <iommu@lists.linux.dev>; Fri, 25 Oct 2024 17:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729875869; cv=fail; b=EG7w6aav0aJ4iZfvQWYEMxOVCjDuM/qhZQVe4yK0Wsftazrmo2WANR0GVqq0SKY01AfbcENwAILqW/eYxwXJZlJ4VJ7Hg+Ej4/gQk4Rm1ym1wXGkK1gj+6yTXEptSj6q+uXcpLmVExPX7VCSvfWr4OAGjeBdFGfUi9WYvxOK/do=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729875869; c=relaxed/simple;
	bh=VQEeOSedbiQ8TsfWTbRXj5h0awy9tnXcgx1sl4oM8dw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uvb4zT8gfN7DKkIjItCoM7naR57kBhTPvrMwy70IazicGa0c4dvomEoX+MpH/oj9M9S9tW3mKgZqy3usbVmfJJU54WybAw8jB2wMkbF5c2mMEruiNiACOA7RSPeocQXJeh9t73R2+VFAn79g4OV3WaiHWwAtHTj5fICfo4/LGLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DHvN7nrE; arc=fail smtp.client-ip=40.107.92.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DHvN7nrE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oN0ql+s2+jsLLZSV2s4EeOA9h171SL4dI0kkDx0jo1aV3qLtVMN8i/WQ5iz/tt8e6ZK7yzBeSKZ6EYALh9gWoi9db7R+oVj3e0zxx83XKJOxWZg3JVkEdl6Dju8YgKZsuj0MoV1UKm7Gj2nQ8gjrGHDefB7+BaIWw5pYfU7dPkpFX4y0pLVR5rWErtGeL6P9SyP/gmyjc7QOSTI2Cj/6Hi1k00TGutJgxjro/HgIM4g9WBbNrtqbus7oNKaxPV67jgmEIzrGue1JJhazk+QfzVQQt9u6OBcFLvVNuP52/8GMU257bxcLOyZYts97Tk87LOa9AER+9YdjuESYZDjsag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t93iQJL3zKsJayIgp/mHmFom6FDU5LGkwoFN9MORCnc=;
 b=AMSU/iCph5ttknLpHsVleHf+mQyCbUPBUsrL/n9XkTz/TsvOkyHn2sSoxlegFnhcBkPz5BWBQh6TlX1GkkS4mTQwNEiVC0wpWr1zKhP/MP9IT+cm0t5fMPg8wR5hgypzo11JHsb71K+2xBv3Upx6+SfYa2gDaSsoaXEG5F98LdAPSSQPdSXthABJJN9KGHDNcl+p9Hgz1n4Weem/i/FX7jG33LEEYC2Pj3MqtzL6RK3A79YXKcD2udecL/sfUw0CNLC+o+cTiozZ4DEAyGraVlVvSAxeHccT76TEJYDbgvjbu2zQDuWsr6RIHwD5JK3iyMIyOFmkvobYLDuZtvU5vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t93iQJL3zKsJayIgp/mHmFom6FDU5LGkwoFN9MORCnc=;
 b=DHvN7nrESYQv+mNpqGvJmXhD3qBUpJMTWNISDf1dwDrMfKIDM7CZAefjMFolndTRS94YWq6k+tohSo9pkxsiKNcirEG6BkxBqe/ClxjI8BhAzaw55mGnHHYFNmzS7MJExMqT2jGj/jM5+LIiwVPcRZZvrDUD5e6/ZbiZITFREPJfcm32UyYL4RGx1+K2bAiJdM/sIQ+mHGK+PZ12y1gOo6EsoQd1Po2V3ShRZ5YZXthnfLkKnVT0sBwVLk8gASTQwlZR9FhWhhKhxKSTrYtt6ehjw1l9MNp69OVAfjzYpmxTK8CgGOJDu3LrXoj3EHKTxKC4YjdaCVSyp9h8phO7nQ==
Received: from CH0PR13CA0020.namprd13.prod.outlook.com (2603:10b6:610:b1::25)
 by SJ2PR12MB8012.namprd12.prod.outlook.com (2603:10b6:a03:4c7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Fri, 25 Oct
 2024 17:04:20 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:610:b1:cafe::74) by CH0PR13CA0020.outlook.office365.com
 (2603:10b6:610:b1::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.5 via Frontend
 Transport; Fri, 25 Oct 2024 17:04:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD7B.mail.protection.outlook.com (10.167.244.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 17:04:19 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Oct
 2024 10:04:07 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Oct
 2024 10:04:07 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Fri, 25 Oct 2024 10:04:06 -0700
Date: Fri, 25 Oct 2024 10:04:05 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Steve Sistare <steven.sistare@oracle.com>
CC: <iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian
	<kevin.tian@intel.com>
Subject: Re: [PATCH V7 9/9] iommufd: map file selftest
Message-ID: <ZxvPhQZOBR7g56eh@Asurada-Nvidia>
References: <1729861919-234514-1-git-send-email-steven.sistare@oracle.com>
 <1729861919-234514-10-git-send-email-steven.sistare@oracle.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1729861919-234514-10-git-send-email-steven.sistare@oracle.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|SJ2PR12MB8012:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cbbe399-748a-45ec-7d96-08dcf51710ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Nv8Q9FpmfZe/9C8YPwS/bXQJhfQ37zSlE8aJj+CxQhAgTVsDuoAgKnSohnUd?=
 =?us-ascii?Q?hR1hb3FHRDpP4rgknvdNG1ZmwyUHhwub06NwqRnNjfP+F7uhRBGbxfxgVKje?=
 =?us-ascii?Q?Us6CrYO6aKz3XB7r4gsHxmrLRom8IC4ReUJ3Rim2EzBMVyZL48hAyioUZ+gD?=
 =?us-ascii?Q?x6AmJZQFYqrMPqUTCllomycqbKMGghT/YLRF1JKaVUBcfo5/xDrjIDdvQh2h?=
 =?us-ascii?Q?g8Qex5ctUhPkmM4pTDd4y2nVBxgnYkLp1WxSlBojOgT1aiT9MP3CIfhU9Z3/?=
 =?us-ascii?Q?aFOrRmMwM/I37CPMcG9FzMVxjigUePadTqgGtWfZ+Iv+WShdUNQO+SKp17CT?=
 =?us-ascii?Q?v5nMCBeEBOCWZDSZtTzC2FUYZyuX+4KjM32fn2RwSTn0UKgZ+6AkOazRPp66?=
 =?us-ascii?Q?sI3HJxGd+AKN5kL30QGOJtEuYJuWjZiNkV3CgN375AdCxp4noPsUw228aOjV?=
 =?us-ascii?Q?qbHIp8MOuZZwmc2Fvjx4589YHRwqjv/PCJz6uK6TUY1x16LEAtZFhEwFaYkb?=
 =?us-ascii?Q?qIVkbTyvivPmeKTeassny97zCtbLgeBQxm1Q1FV/aYeXcrnXrVvHq9isRaaz?=
 =?us-ascii?Q?P6qU4YYBIKv4gu/O3nxaq1tdHPfxrBZCyRNF80sUMFPZwXc00fc3bJZo8z/Q?=
 =?us-ascii?Q?DCE6mFB2q3VhIo6jwnlMCP7Psq3sEK0M8yNeZc6+C2Kplb1yHu6VP+BItAid?=
 =?us-ascii?Q?S/xRQhGnHGWWXMvF8LvUq4x2CwpLqn9RDZfpbbfI3ibL+QpyR8DEx5JmqMvR?=
 =?us-ascii?Q?vfip9IOuPrG5ktah1bzCJ9i4/PX5afbhwTrlWtiYUeOX03KCQqNIyGZj6ql2?=
 =?us-ascii?Q?ffWd420KuOxvtsmHVHNlzxML4Mr6QK575ex1ELgrO4Fz3naeogs0qgcTVzET?=
 =?us-ascii?Q?yEw3fMuLHKJ7xWMzIovGCeDfnkghrzzesDoeKHvIkw5sSo76dWRJ9210NEVR?=
 =?us-ascii?Q?9xCrPvCbtCFHgwBYSc1YAPJ/wBO0oRh4RkDCaKWQkJsjWcIZ8liDYCakrZ8S?=
 =?us-ascii?Q?rZbvBhYcNspNbt5Zb5Xxf76x5QR1TXTmc6BblLhU/+4xbttfF5dp83Cuu0Fv?=
 =?us-ascii?Q?DGwdbVaFCiiwtYtM9KF8auYC6ewdsnJDLjXMLG0EOVvtZf2CF8JYeEAuJ9+i?=
 =?us-ascii?Q?aYG4MWTez38Jb/En/wOud7/t+pIHFC4YPHkNuyYzqD2Rqscvd2pdGKhQ3jEt?=
 =?us-ascii?Q?YUpEmsBPfVueeCybF01+iiDPn3NQZ/9MXBVo2PmJgcqwnb/GvFlmIKajaGkm?=
 =?us-ascii?Q?QBltu5gvfhWSr1jwySRqW+bxvHuoCCZGhnea91nAnE2HyXnoMZNwu2OHIP/q?=
 =?us-ascii?Q?Qx/J2qYt6ZV/fGHN5Vm3ym7sfKzZcPH03czVGothUv+ZeyuihQTqvNL2C/wT?=
 =?us-ascii?Q?t0cEFDkLPkO7jWF6OxdZMLpGWfX9TkrFRaOShnzSkzh3n0ykZA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 17:04:19.4748
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cbbe399-748a-45ec-7d96-08dcf51710ea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8012

On Fri, Oct 25, 2024 at 06:11:59AM -0700, Steve Sistare wrote:
> 
> Add test cases to exercise IOMMU_IOAS_MAP_FILE.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

The build passes, but I now see a few failing tests. Any idea?

#  RUN           iommufd_mock_domain.one_domain_file.basic ...
# iommufd.c:1521:basic:Expected 0 (0) == _test_ioctl_ioas_map_file( self->fd, self->ioas_id, mfd, 0, PAGE_SIZE, &iova, IOMMU_IOAS_MAP_WRITEABLE | IOMMU_IOAS_MAP_READABLE) (-1)
# basic: Test terminated by assertion
#          FAIL  iommufd_mock_domain.one_domain_file.basic
not ok 136 iommufd_mock_domain.one_domain_file.basic
#  RUN           iommufd_mock_domain.one_domain_file.ro_unshare ...
#            OK  iommufd_mock_domain.one_domain_file.ro_unshare
ok 137 iommufd_mock_domain.one_domain_file.ro_unshare
#  RUN           iommufd_mock_domain.one_domain_file.all_aligns ...
# iommufd.c:1602:all_aligns:Expected 0 (0) == _test_ioctl_ioas_map_file( self->fd, self->ioas_id, mfd, start, length, &iova, IOMMU_IOAS_MAP_WRITEABLE | IOMMU_IOAS_MAP_READABLE) (-1)
# all_aligns: Test terminated by assertion
#          FAIL  iommufd_mock_domain.one_domain_file.all_aligns
not ok 138 iommufd_mock_domain.one_domain_file.all_aligns
#  RUN           iommufd_mock_domain.one_domain_file.all_aligns_copy ...
# iommufd.c:1656:all_aligns_copy:Expected 0 (0) == _test_ioctl_ioas_map_file( self->fd, self->ioas_id, mfd, start, length, &iova, IOMMU_IOAS_MAP_WRITEABLE | IOMMU_IOAS_MAP_READABLE) (-1)
# all_aligns_copy: Test terminated by assertion
#          FAIL  iommufd_mock_domain.one_domain_file.all_aligns_copy
not ok 139 iommufd_mock_domain.one_domain_file.all_aligns_copy
#  RUN           iommufd_mock_domain.one_domain_file.user_copy ...
# iommufd.c:1712:user_copy:Expected 0 (0) == _test_ioctl_ioas_map_file( self->fd, ioas_id, mfd, 0, BUFFER_SIZE, &copy_cmd.src_iova, IOMMU_IOAS_MAP_WRITEABLE | IOMMU_IOAS_MAP_READABLE) (-1)
# user_copy: Test terminated by assertion
#          FAIL  iommufd_mock_domain.one_domain_file.user_copy
not ok 140 iommufd_mock_domain.one_domain_file.user_copy
#  RUN           iommufd_mock_domain.one_domain_file.replace ...
#            OK  iommufd_mock_domain.one_domain_file.replace
ok 141 iommufd_mock_domain.one_domain_file.replace
#  RUN           iommufd_mock_domain.one_domain_file.alloc_hwpt ...
#            OK  iommufd_mock_domain.one_domain_file.alloc_hwpt
ok 142 iommufd_mock_domain.one_domain_file.alloc_hwpt
#  RUN           iommufd_mock_domain.one_domain_file_hugepage.basic ...
# iommufd.c:1521:basic:Expected 0 (0) == _test_ioctl_ioas_map_file( self->fd, self->ioas_id, mfd, 0, PAGE_SIZE, &iova, IOMMU_IOAS_MAP_WRITEABLE | IOMMU_IOAS_MAP_READABLE) (-1)
# basic: Test terminated by assertion
#          FAIL  iommufd_mock_domain.one_domain_file_hugepage.basic
not ok 143 iommufd_mock_domain.one_domain_file_hugepage.basic
#  RUN           iommufd_mock_domain.one_domain_file_hugepage.ro_unshare ...
#            OK  iommufd_mock_domain.one_domain_file_hugepage.ro_unshare
ok 144 iommufd_mock_domain.one_domain_file_hugepage.ro_unshare
#  RUN           iommufd_mock_domain.one_domain_file_hugepage.all_aligns ...
#            OK  iommufd_mock_domain.one_domain_file_hugepage.all_aligns
ok 145 iommufd_mock_domain.one_domain_file_hugepage.all_aligns
#  RUN           iommufd_mock_domain.one_domain_file_hugepage.all_aligns_copy ...
#            OK  iommufd_mock_domain.one_domain_file_hugepage.all_aligns_copy
ok 146 iommufd_mock_domain.one_domain_file_hugepage.all_aligns_copy
#  RUN           iommufd_mock_domain.one_domain_file_hugepage.user_copy ...
# iommufd.c:1712:user_copy:Expected 0 (0) == _test_ioctl_ioas_map_file( self->fd, ioas_id, mfd, 0, BUFFER_SIZE, &copy_cmd.src_iova, IOMMU_IOAS_MAP_WRITEABLE | IOMMU_IOAS_MAP_READABLE) (-1)
# user_copy: Test terminated by assertion
#          FAIL  iommufd_mock_domain.one_domain_file_hugepage.user_copy
...
ok 2 basic_fail_nth.map_domain
#  RUN           basic_fail_nth.map_file_domain ...
# iommufd_fail_nth.c:338:map_file_domain:Expected 0 (0) == test_nth_map_file_domain(_metadata, self, variant, &nth_state) (-1)
# map_file_domain: Test terminated by assertion
#          FAIL  basic_fail_nth.map_file_domain
not ok 3 basic_fail_nth.map_file_domain

