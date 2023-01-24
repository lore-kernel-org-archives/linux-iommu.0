Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08FB10F9
	for <iommu@lists.linux.dev>; Tue, 24 Jan 2023 10:44:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fWhM7EukON1t7LNCOvAtOzkmSDZ+v5kQHcvaev+uSeDTZKOOhrNb5qaYRfroQ1sm6O3xrRLBodO24b9iNjA7CiPf613VKiB4kVclcjo7m/ZL7wrMC3FyAQQe65FYCQYwEXBHRzByGYA5/6VFL9KIYHpEA5/fb5dijMR/FbKkMbFYDXzAzoKVNgelk+V3Y4bmZkMCBosr9v62YdQplBThnUUvf3Wc1nclN4Cl5DuE+gnNSTBagc0Ts0MUDkWNS4dFXtvL17o7j0vX2i+6RDfyijvjk+eHvXrIkRlu8pYdWlVKhnxwtymfBFQ+ePWV0ImqMrB+lSyJS9Oz9Tme4bgOIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g4eQ5S1B0DwirJFi2acRwQVw8br//ok+RZ3cU3H4O54=;
 b=PbWpT9F/07OhlpAgKz5IMIZmpnvfMtVAea6ZdnJGiDvGAcguzNK+mPyjscg3PnJYTLvD8CuxdocKjruNwhTaYrd+27PwQ7lsGJGuXyq95Igwx07iguuxIfYw9c9xLOHZsxtvr/5AK2k7PUi/POwyZjDJnbgxQ6VfWkXUHPa5LHXkVxkCvKAzi9Yt6YMieOxb7JOA0e1dbcJg9sCYLcn1VuiQBwz8N2EGQVhJGXVjM/S9irBtp2TybrLGLJjH62r3xzhP8F5ggEdM5QoiApsv982ussmamk9mx58WXI9eurL+Ms7tk3YijlYLumAZLlbJZmt76JF01/QEl/z1egOF7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4eQ5S1B0DwirJFi2acRwQVw8br//ok+RZ3cU3H4O54=;
 b=07n2oFnBYyUhM6nur9d81KEAZ5B4mC1X0PLm+libS2/Wu4ZfPl6cx5YSNSFSiuCczxzEjeXVOn9ulTz9MoCTvMkX+bxYmWmeVgxmuAmA1bf95yu1USSO8YaGagcU+2IOY3YV61oLmsUyJicWQsOA7qlKEwQ3OVSe7bKu9Osxlys=
Received: from DS7PR03CA0024.namprd03.prod.outlook.com (2603:10b6:5:3b8::29)
 by SA1PR12MB6894.namprd12.prod.outlook.com (2603:10b6:806:24d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 10:44:45 +0000
Received: from DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::46) by DS7PR03CA0024.outlook.office365.com
 (2603:10b6:5:3b8::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33 via Frontend
 Transport; Tue, 24 Jan 2023 10:44:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT031.mail.protection.outlook.com (10.13.172.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6023.16 via Frontend Transport; Tue, 24 Jan 2023 10:44:44 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 24 Jan
 2023 04:44:40 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <jgg@nvidia.com>, Vasant Hegde
	<vasant.hegde@amd.com>, Daniel Marcovitch <dmarcovitch@nvidia.com>
Subject: [PATCH 0/3] iommu/amd/iommu_v2: Fix refcount related issues
Date: Tue, 24 Jan 2023 10:43:52 +0000
Message-ID: <20230124104355.119166-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT031:EE_|SA1PR12MB6894:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dfcfd5b-45d6-4f99-ee42-08dafdf801d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Eg52aibog7b3hs+9jy5kTjxTXH+Rnkm0olHLXjNsYTYGROt1Qc3SuLqLymWux5desf/C6dqlbpYyWElya4hfBUTzugTFE0ilVav1srQ+VLnHBEHm3aBRCk0a7W51jkXewkVr3QjVBJPoacyYHb+7Xe0Wer1YVBEkSs4glv1Npx5/OHP1VueeN8PhUt3RxTnvt7qaFagP91TXaTjgs7IRUKvCnW9TOQEYfQodJqnVz+yGjBQ8eH1Az5rXlEDE3f/lUYaqMZ/jRJi0jXUyEKobWELe81Ylt9YVp8wxL9xRtOT+q19DysEIVCP0dRB4sKGZ6anVKnP1qbVWlsXd8hecUAdxJIaiRg9IxpZXM07XLYYbGYQM6U+71Vke3lbBq20B7mR7PK56M6YsFZCZVpbmzTXef7tuioPxwg7RrWik9tKS7UQrlwzjjj/apajRl2tb6uCyBAL/69c8+CvzzOQwl4S8OXB3IAEo01kD6ieJau0nbAF5xN7CH3HG29kPyS5hrpBe//9jeJsicnfqOYxLvEAzBha/WZI/RMVSg2RRsmoFuGM03RFv6N70CkLLC6imCD05dcHDPJS8Y4ML/bPYYBvgFLDWLzM6PACiMDmkYrBCPkx4+DM0PLnhAJTD4BGA4CvAJyUXuQsm/u7zsIyXq33fCdoDMfyR7HtZ6jSkdX6oP+hxHMKAW0/Ft8tt7sItEwZDp4wc9+2QZREpHlXkVYKgFXVEMyTnx1C82Nt7juQ=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199015)(36840700001)(46966006)(40470700004)(36860700001)(83380400001)(82740400003)(2906002)(86362001)(81166007)(356005)(44832011)(5660300002)(8936002)(41300700001)(4326008)(82310400005)(186003)(40460700003)(40480700001)(16526019)(8676002)(26005)(316002)(47076005)(336012)(426003)(6666004)(70586007)(70206006)(2616005)(54906003)(1076003)(478600001)(7696005)(110136005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 10:44:44.9751
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dfcfd5b-45d6-4f99-ee42-08dafdf801d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6894

This patch series fixes various issues around pasid refcount handling.

Issues addressed in this patchset are as follows:

1. refcount_dec assumes that refcount will never reach 0:
   threfore: REFCOUNT_WARN("decrement hit 0; leaking memory")
   will be invoked on pasid unbind

   *  Fixed by changing refcount_dec to refcount_dec_and_test
      to explicitly handle refcount=1 (skip waiting for wait queue)

2. ppr_handler calls the wake_up API on the pasid_state wait_queue.
   However, once refcount has been decremented, unbind_pasid may have
   already freed this object - causing unallocated memory access

   *  Fixed by adding spinlock to ensure atomicity between refcount
      check and event queue handling. Moved wait_queue APIs to
      wake_up_locked / wake_event_interruptible_locked accordingly

3. If new ppr_handler arrives after get_pasid_wait once pasid unbind
   has decremented refcount to 0 - get_pasid_state can still acquire
   a pointer to pasid_state after being freed by unbind_pasid causing
   unallocated memory access

   *  Fixed by changing ref_count_inc to ref_count_inc_not_zero
      to ensure no new ppr_handle starts after pasid has been unbound
      and NULL (invalid) pasid_state is returned on zero.

Signed-off-by: Daniel Marcovitch <dmarcovitch@nvidia.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>

Base commit: v6.2-rc5

Daniel Marcovitch (3):
  iommu/amd/iommu_v2: Fix pasid_state refcount dec hit 0 warning on pasid unbind
  iommu/amd/iommu_v2: Fix pasid_state->wq race
  iommu/amd/iommu_v2: Prevent scheduling new ppr notifier during unbind_pasid

 drivers/iommu/amd/iommu_v2.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

-- 
2.31.1

