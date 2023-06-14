Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A8F15A2
	for <iommu@lists.linux.dev>; Wed, 14 Jun 2023 05:57:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OGxaAlldqq+eNX4Ug7W35srzc5xuD88s/UkHPlc6UsRLbwepQ4qGnKeHrvuQCAzxnG5+o3cdYXRDf3mGBG+o01Zxdj4a+MvtccpgvadUqYZ+X/PooDN4ER5u3QnFfxWtU7vfajYDA2ikfjFAi9DKc6gNLLrktO1ACEL1qPJKV51my34CQl+TmaD0/BCLB4DcIDExetYEjxyf+5xfy66b5mzPloGs0vixRN8Wo2nSVUdykZucFU5S5anlNkCuniDSf/0IXFvW7liJTSgFZ7f+8EXszRH+bcHFmT3j1N3iJTsp4qA7YKyxEoy5sJRTGZtxNjB8PhqhIYtw+/aqwurMlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQnTSYHp0nwfkvtCs0JZjQOWNBl3VBCVWnLuskvYFfw=;
 b=Pf9TxtkYYlkRG4Rha5AV1thqUm0b61NU2Lqw7CV35BnhhWGi1TPUtXTTw7cksMXn2H0NNrj0/EHoJ1UfN+OB/IzRnN7I1hmTiZonZpFASXz5B7jQZSvmjlv7mGwzpFh6abRmeRSmYNw6Uq3QIGVX0X7l11iOCWJPQLQ1bIIekK3OmVKEgHS+F/nC6gFWgmNs5V3W92SwDfmelrLyBEURXrVKKuwHiIjZwtOu6ZsZFcjZN0mW8TjiDUSrPwsFMhzd6eyYRkIprOyQpc7DNe7ZkIWVi7I+vWQ5IFVseeOZq8gYgUf6ZArArspty9fmAHqvLO8cFJBNp9YLTWLCnCeFoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQnTSYHp0nwfkvtCs0JZjQOWNBl3VBCVWnLuskvYFfw=;
 b=lbm+OLde52ex2AOKUQDoH8oCO3RsQ74nIZQBFXjh42A61Cwxer7rzL/5BK+/avXtXVvl/P8xH8p3SlCzA31cRVlCZSS8/b2WWOhE/XlJ/Lu17FX5xZqoLM2YeUyN3KsGUtvCVRatAkfSvoWqQldhJK5jU9Ms7dhQU96uTZt0CBQ=
Received: from SJ0PR03CA0300.namprd03.prod.outlook.com (2603:10b6:a03:39e::35)
 by SJ0PR12MB7065.namprd12.prod.outlook.com (2603:10b6:a03:4ae::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Wed, 14 Jun
 2023 05:56:59 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:a03:39e:cafe::82) by SJ0PR03CA0300.outlook.office365.com
 (2603:10b6:a03:39e::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32 via Frontend
 Transport; Wed, 14 Jun 2023 05:56:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.25 via Frontend Transport; Wed, 14 Jun 2023 05:56:58 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 14 Jun
 2023 00:56:41 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>,
	Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
Subject: [PATCH iommu/next] iommu: Fix default domain setup
Date: Wed, 14 Jun 2023 05:56:27 +0000
Message-ID: <20230614055627.27286-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|SJ0PR12MB7065:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d23cb52-3949-4d9a-17d8-08db6c9c2aac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NHYnyhDCXdc+Ojdpoc56IezlsDln4W8aA1R3kpG3qS8/MGNF7067AfENO7WqyMc+li7ltVV6J9PrdiUsrZvMlPZlNCwqTZC1wApSgA1ZVu1pIrwaAkUlixMY8eyWEpL2m7QPALqLkmKJ8uENyzJrbdOrIhP9puQEHGgE/dTIerctGvLQdUDUl6t9iW902oL/RNhB20N4h4wfJJBclnYbtd9eY3OXgYg415nm2cK8l20tSkHoz5Ms/3A+wv9w2HIWdv1tbKleNC9kN4sTG0tBFIHcHmmja8Liasr64ISVMmGN5ubgLx/qiRmSTjpWLJcACW2FmMyap6MqP/zfx6+6RBcPAwKIhN3fHM9FfvHW9YWZXpkmxIWCDRdZszUraoRngq69bThIE9GmlQOYBJumKG3eLxrgvNxbfXOQQ5rqS7xZqenTGowEZp829t0F52UvzerC3ZlcudrOizVx3YaoDFsgX5rAIhr80dY2rCDfQg/CVnmpNFQ3+w1dNjU1expYUmKqUI/X5DWoEeBc7xCZQj/ChGi5SlFDLRnzfV2vpwR2eRhCiHpmYYoqvUjMRi6evmjc+SOhLEsBEfiQH7STLwSmVaM17KYitEGCTAxhyjt/jzD/BGrbfUaivbq3Je9XpHApSvNxSHjV2qFV88GsoqfIWCe0okMdGOuuhBPZx5g4bdVXlVJ3eIGS/UYSFB2hGiTZ1fEvY8gF36xy5MUDyu3/qYLqw4krvMi5nKTf7Ydh6xCm9urUsqtmhMj7MTcUz8gfnTNyfEM/mTFFxXiqvQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199021)(46966006)(40470700004)(36840700001)(36756003)(86362001)(2906002)(82310400005)(44832011)(40480700001)(47076005)(6666004)(7696005)(83380400001)(186003)(426003)(336012)(16526019)(36860700001)(1076003)(26005)(81166007)(82740400003)(356005)(40460700003)(110136005)(54906003)(4326008)(70586007)(70206006)(316002)(41300700001)(2616005)(478600001)(5660300002)(8676002)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 05:56:58.8270
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d23cb52-3949-4d9a-17d8-08db6c9c2aac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7065

Commit 1000dccd5d13 ("iommu: Allow IOMMU_RESV_DIRECT to work on ARM")
accidently restored "group->domain" to "old_domain" while keeping
"group->default_domain" to new domain. Also freed new domain.

This works fine during boot as 'old_domain' is NULL. But if we try
change domain via sysfs using below command then kernel crashes with
"kernel NULL pointer dereference".

Change domain command :
  - Assumed we have single device in the IOMMU group
  - unbind device driver
  - echo "<dom type>" > /sys/kernel/iommu_groups/<group id>/type

Fix above described issue by handling error path properly.

Reported-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
Fixes: 1000dccd5d13 ("iommu: Allow IOMMU_RESV_DIRECT to work on ARM")
Tested-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
Hi Joerg,
  This patch is on top of iommu/next branch.

-Vasant

 drivers/iommu/iommu.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 9e0228ef612b..d21d0a217bdf 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2880,7 +2880,6 @@ static int iommu_setup_default_domain(struct iommu_group *group,
 	}
 
 	/* We must set default_domain early for __iommu_device_set_domain */
-	group->default_domain = dom;
 	if (!group->domain) {
 		/*
 		 * Drivers are not allowed to fail the first domain attach.
@@ -2896,7 +2895,6 @@ static int iommu_setup_default_domain(struct iommu_group *group,
 		ret = __iommu_group_set_domain(group, dom);
 		if (ret) {
 			iommu_domain_free(dom);
-			group->default_domain = old_dom;
 			return ret;
 		}
 	}
@@ -2915,16 +2913,20 @@ static int iommu_setup_default_domain(struct iommu_group *group,
 		}
 	}
 
+out_free:
+	group->default_domain = dom;
+
+	if (old_dom) {
+		iommu_domain_free(old_dom);
+		old_dom = NULL;
+	}
+
 err_restore:
 	if (old_dom) {
 		__iommu_group_set_domain_internal(
 			group, old_dom, IOMMU_SET_DOMAIN_MUST_SUCCEED);
 		iommu_domain_free(dom);
-		old_dom = NULL;
 	}
-out_free:
-	if (old_dom)
-		iommu_domain_free(old_dom);
 	return ret;
 }
 
-- 
2.31.1

