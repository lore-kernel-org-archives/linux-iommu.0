Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD50410F9
	for <iommu@lists.linux.dev>; Tue, 24 Jan 2023 10:45:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k0kU9G0Kcg0i+4USpDq4n/xL9QSUrL1WIIrQssOuxT/FyqZAyUcQq0e1CllCU+ZFhT7Syxupy+wiOJLLTSC3nAfEJCZ4rSM5x9FL+VheB+XwT2OyxbDpRlpox6UV8vMCLxeYpL+7CHx+yjYVJ32G+GVlXt8qk11BOrpXoIgh3WdjSMKYvMhrG8sDu0K9TyjIe6QZkOisUjI6Vg4n5AxQLtSbm0sAE6ZscjN51juQgc96SkDJnJ7eyb9VD+hrS/NV0F42J/PXp1kXY11Ai+vdAeFYi6S49lMFwLAV7d88WPMXUf9RcrfMCB+pjyzynvkXEBXGXx3DAtIPFb+bll7geQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sNxPDiUoXm1Sg8Aa0LjluecrksIPAxxspEpXduF2lOE=;
 b=S7P6ftCcvxl+R3gYt/Lr6HVWx1bc5MHEWYfy22kYuckMkDf0hEJga1UoybOeZhbtxMOelTPsPZvSr/UHkY/mzW54xp301RxofTgH2ebkYTaVxQ2tm4TK6fNo6AXtMUDAvdXa+Rgg3Ck3JQpreGVNehmQPTBKwM6cH8tSDWv4P3B8mDe5yb5x96KDRL/krAZ60vgPnsEkKuHak2urkoVDvo4KXPtF43n1HkKC/WpDMxeHmGNJ3OuAaq+BneAXsRk0orlcj7VhjWJFrkZ5TxEbA4zl2o1fI1BehoFS5LEeSMzDCJfWT3KpP6rzs/njWpV3IlpzHF1OOEmmwv7Xt+I1dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNxPDiUoXm1Sg8Aa0LjluecrksIPAxxspEpXduF2lOE=;
 b=L34QqrTbDrQCRM6l1jhw61hrECXmfN5+VZnkyeGO6gmB6pANoY2lNBh25Hqec7R0P/PVnesF2emWZi8CxdN9oxruJbKmfFKCkE0ZC6dgFz4DZElcNjHKVqSLy+WGyPjmKT49hvlMd+zRcdjIE3ZkemHqP4I6C2l8vHOxkf222vc=
Received: from DS7PR03CA0180.namprd03.prod.outlook.com (2603:10b6:5:3b2::35)
 by CY5PR12MB6297.namprd12.prod.outlook.com (2603:10b6:930:22::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 10:45:14 +0000
Received: from DM6NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::be) by DS7PR03CA0180.outlook.office365.com
 (2603:10b6:5:3b2::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33 via Frontend
 Transport; Tue, 24 Jan 2023 10:45:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT078.mail.protection.outlook.com (10.13.173.183) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.17 via Frontend Transport; Tue, 24 Jan 2023 10:45:14 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 24 Jan
 2023 04:45:11 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <jgg@nvidia.com>, Daniel Marcovitch
	<dmarcovitch@nvidia.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 2/3] iommu/amd/iommu_v2: Fix pasid_state->wq race
Date: Tue, 24 Jan 2023 10:43:54 +0000
Message-ID: <20230124104355.119166-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230124104355.119166-1-vasant.hegde@amd.com>
References: <20230124104355.119166-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT078:EE_|CY5PR12MB6297:EE_
X-MS-Office365-Filtering-Correlation-Id: ec3a1b05-387f-42c0-0b9b-08dafdf81326
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6U+BsAO2i8PyZqXTRXI4raN3JiBLIOXkJ05C2F7QaUR4+PVeEmag8pArfFiiY6NpbUtltZn/5fWcrLdMn823Gws1BVBVcNUxuJY3v/J2IuR98Ja48qixjCvloCFevrkaBdEChwfQohs0iyeUgsTC8Oe8g99BNcGjn4gWQ4rjnBnW4wR0nUjWbmrqVuvcljPfQaQuISF7uleTZEt7o+cFvb488xBbhiY4qJuUqVGoZxS48Yqn20hV1WudIYc9hsXnmOfaDpDG8uHSewLAB/+oOCOpetbzLWE1ffhoFSj6xqQjX31LDw7KiZ0g3qmFTf+sg9fexGzSkgI4wXKfP2YmzA+OEiAZSl+BW3TlTGdnStNA3GLeP44hFzpwX0GesutSwD+y9255u6YxhU4fruTM0xmLLjEydJBToIIpN6zFCK2lS4iX48OET0yTQMS2J1owSfnZSBzj13+pZaHPCe2DgzXfTZCS61mxLCljvmH1T23vkTJolzXIhyU4rzS2aNA5EW0Poby/Ik6yuL70NdQbW8BL47qFFJtIV70d5jcRLe99B9WfmtpPS7FNeJDGofalfVsOemdjMRrXnFvyMFkRd9nP0Jih2OR+XTtBow0xTPj99PcN59qfCbi8zFsgtexyciILKGa6soxt2/bBIH7RszH5eRxX7zI1+D/tvkEcHMzBOSVkZbrx+GplrLoMpy0D9M/CEw9ahVA4Y8IOpS/Vs39BegB9gktYT8XwHXKrgMc=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(66899015)(36756003)(41300700001)(86362001)(356005)(81166007)(82740400003)(8936002)(5660300002)(4326008)(82310400005)(44832011)(2906002)(83380400001)(36860700001)(478600001)(110136005)(7696005)(26005)(186003)(8676002)(40460700003)(316002)(16526019)(40480700001)(70206006)(70586007)(54906003)(2616005)(1076003)(6666004)(336012)(426003)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 10:45:14.0542
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec3a1b05-387f-42c0-0b9b-08dafdf81326
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6297

From: Daniel Marcovitch <dmarcovitch@nvidia.com>

pasid_state->wq is used to wait for all outstanding pri handling prior
to pasid unbind.

ppr handler calls the wake_up API on the pasid_state->wq once
pasid_state refcount has reached 0. Since refcount is initialized to 1,
this will only occur during pasid unbind.

However, unbind_pasid may reach refcount check at this point of ppr_handler
execution. Since refcount is 0, it will not wait on wait_queue - but
rather proceed with pasid_state deallocation, including wait_queue.

This can cause unallocated memory access.

Fixed by adding spinlock to ensure atomicity between refcount check
and event queue handling. Moved wait_queue APIs to
wake_up_locked / wake_event_interruptible_locked accordingly.

Signed-off-by: Daniel Marcovitch <dmarcovitch@nvidia.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu_v2.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
index 858748baae0b..44fed4ca576f 100644
--- a/drivers/iommu/amd/iommu_v2.c
+++ b/drivers/iommu/amd/iommu_v2.c
@@ -256,14 +256,18 @@ static void free_pasid_state(struct pasid_state *pasid_state)
 
 static void put_pasid_state(struct pasid_state *pasid_state)
 {
+	spin_lock(&pasid_state->wq.lock);
 	if (refcount_dec_and_test(&pasid_state->count))
-		wake_up(&pasid_state->wq);
+		wake_up_locked(&pasid_state->wq);
+	spin_unlock(&pasid_state->wq.lock);
 }
 
 static void put_pasid_state_wait(struct pasid_state *pasid_state)
 {
+	spin_lock(&pasid_state->wq.lock);
 	if (!refcount_dec_and_test(&pasid_state->count))
-		wait_event(pasid_state->wq, !refcount_read(&pasid_state->count));
+		wait_event_interruptible_locked(pasid_state->wq, !refcount_read(&pasid_state->count));
+	spin_unlock(&pasid_state->wq.lock);
 	free_pasid_state(pasid_state);
 }
 
-- 
2.31.1

