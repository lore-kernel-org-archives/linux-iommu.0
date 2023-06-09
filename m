Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06E479FB
	for <iommu@lists.linux.dev>; Fri,  9 Jun 2023 10:52:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4G0eTYLyHl0iWkAXq4vbJIB6PtzveMXDeei4s4XjJT8+Mclt6CbrVg5PjKKgOP4QZAa3JGzERMOyPB8pCBkHAoTCvxD+AiwpPK0k21Au+dzQCAGDS7XGMkeLPbsLEA5kdlBqZj5RUTgajJ5l4l5AD9kTgesnceHzbtG0uMv6QiY5aRu0a3t5zT2tiTgSyTn7fG5w7F54MhLR8uNDKQlwRuYsNgvNVaYY18m1cgWGqvEXhQQCOAqqgXfDu7tGVDw8AVXxW7yvq6pLNy8jZT4nvpkTl5yMxkhTPns3Wt5xOsD8pUkNND+J2sLP0/VOl2DJxuCNJEXCoPZn/Pppc3lIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F15l4nL7HBBXpyxOzPu2k5rpP2kXnwWrHO8mt7C1SW8=;
 b=P7dygvS+ZFay4KLZz79O9nzePYhAKewsRFo4YC7JCsWXJGAxz5nX/U3cSXidXrocvH09gjxwiX6/FYEtrlhXP9BZHp913+sxdHyQ8JjcM+MpBQJsmxB4PH+RZRiUBXPaDp71qns+hb7+JEHDJZMKiJyE4AM7qMrq5SXcXrqHKqiPrz298AKZBLnjn16rP2r9D6tvzovoJ4Myrg0VNU/47X4gJto5R5/KP2mTengD9ubXFhl7aePbgvYZNFLdKICVHpKIujJn69eh7XeO2kKdV4K8azPdg0+PEcbSjqBS4Tl/ztTNDVZ7Sa5JdVVWxgOu5j2xu1j9Wk2keh8PCt/Wcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F15l4nL7HBBXpyxOzPu2k5rpP2kXnwWrHO8mt7C1SW8=;
 b=kszljmb6SvGeMy36yi+s237GS9h7WDbMqnee78BzrvQ26VY15SQrKxbhHQv2bn/qkr/91kaQrV4RRx8lKBNMQQgQBopAkaREcj2zCvm46r/R9mHCNIDE5WN6OF2xFnSpncaN149/P7HQ5waLsI/mRs+iLtbmYXDalwgueALJLUU=
Received: from BYAPR11CA0060.namprd11.prod.outlook.com (2603:10b6:a03:80::37)
 by SJ0PR12MB6853.namprd12.prod.outlook.com (2603:10b6:a03:47b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.31; Fri, 9 Jun
 2023 10:52:19 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:a03:80:cafe::b) by BYAPR11CA0060.outlook.office365.com
 (2603:10b6:a03:80::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.27 via Frontend
 Transport; Fri, 9 Jun 2023 10:52:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Fri, 9 Jun 2023 10:52:19 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 9 Jun
 2023 05:52:16 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <jgg@nvidia.com>,
	<dmarcovitch@nvidia.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 1/2] iommu/amd/iommu_v2: Fix pasid_state refcount dec hit 0 warning on pasid unbind
Date: Fri, 9 Jun 2023 10:51:45 +0000
Message-ID: <20230609105146.7773-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230609105146.7773-1-vasant.hegde@amd.com>
References: <20230609105146.7773-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|SJ0PR12MB6853:EE_
X-MS-Office365-Filtering-Correlation-Id: f3008f40-2d38-4006-0e95-08db68d798f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kfok1vRX0fQTu4QqdirA+Btnoov3pjvKbsxsT+EurdsHxSsDBIyXQ0RyRxEKGcoANIWz2dhtOlB3wepyDJGEKJ8ZuDlZVud8POZO4EC0nijesBWEB80pUDwWjMC+QmdyM06piFe3uCZyy2PIUf+dZ8DU7rEL5gnY8QIfP4N74YQ5I8VkvK5ZcfNKO0XnYQVqAEKz08RVqXMCwyhW/0PrkUkMOPJeAE4rdzdURUs+XCmFbYTllRXdZkc3nsZA4Cm5A2UgkUNsectFihWBbNnqv4A1SXC3QI+omRUW1pPUki5Vwsb2g0VJ8fSPgMG9T1/aum3h3vZFU1z/qBp0vAq8h3Lvnp72FyHs9Nwf9XDJ6criJfqjaXDEUs1+xShSmTPEmDMLmy8gAP7QGo+Y7dmkJzliCVeETb4m41Wjx87hfyqfAhbS5bQIjGNMYvUDL0sjsttA8j/ZzEFVL+eXopxV0CkrLLZL8Kmh68nukfK2/2qIY8uG97jXNVZ3/p/35eTapMhRGi2OfgDkYbT9U+GCLUCV3tl/f8vWvuZUimWvCtT9LNN3WwsmOPeRIHJFktn3luFa6SDKZSGmOzj1fzDGNbMvCkITleNkDwJUa4Nr4pjDM37TGn6fBGU/aTlNCYuyYYEEQbvY9uLpdp2+kJldsvaV2kqCAJZWDpjLPSsAXc6rY/TFDr9XxPfxX+uhYNr6lKN3O3QacO6oeEctppxh9BTrSIpmLkj8kRWHuvOdTG4Skj5f/s7dcdrbUn9VacWfYZXfFRDdf8HYlk/QFcH7pA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199021)(46966006)(40470700004)(36840700001)(47076005)(36860700001)(83380400001)(86362001)(40480700001)(82310400005)(81166007)(82740400003)(478600001)(356005)(40460700003)(110136005)(41300700001)(7696005)(6666004)(54906003)(8676002)(44832011)(4326008)(70586007)(8936002)(2906002)(316002)(70206006)(5660300002)(2616005)(26005)(336012)(1076003)(426003)(16526019)(36756003)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 10:52:19.4908
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3008f40-2d38-4006-0e95-08db68d798f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6853

From: Daniel Marcovitch <dmarcovitch@nvidia.com>

When unbinding pasid - a race condition exists vs outstanding page faults.

To prevent this, the pasid_state object contains a refcount.
    * set to 1 on pasid bind
    * incremented on each ppr notification start
    * decremented on each ppr notification done
    * decremented on pasid unbind

Since refcount_dec assumes that refcount will never reach 0:
  the current implementation causes the following to be invoked on
  pasid unbind:
        REFCOUNT_WARN("decrement hit 0; leaking memory")

Fix this issue by changing refcount_dec to refcount_dec_and_test
to explicitly handle refcount=1.

Fixes: 8bc54824da4e ("iommu/amd: Convert from atomic_t to refcount_t on pasid_state->count")
Signed-off-by: Daniel Marcovitch <dmarcovitch@nvidia.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu_v2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
index 864e4ffb6aa9..858748baae0b 100644
--- a/drivers/iommu/amd/iommu_v2.c
+++ b/drivers/iommu/amd/iommu_v2.c
@@ -262,8 +262,8 @@ static void put_pasid_state(struct pasid_state *pasid_state)
 
 static void put_pasid_state_wait(struct pasid_state *pasid_state)
 {
-	refcount_dec(&pasid_state->count);
-	wait_event(pasid_state->wq, !refcount_read(&pasid_state->count));
+	if (!refcount_dec_and_test(&pasid_state->count))
+		wait_event(pasid_state->wq, !refcount_read(&pasid_state->count));
 	free_pasid_state(pasid_state);
 }
 
-- 
2.31.1

