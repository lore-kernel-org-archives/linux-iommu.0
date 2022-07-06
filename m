Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDE133C6
	for <iommu@lists.linux.dev>; Wed,  6 Jul 2022 11:51:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HCnX3LXugRCvjiUb6Oaa8y3/kJScjZUHd/CnXL9yZR7NtbGdT9TFG1Uk+ux95VjZix7pDut0NuHvcSGlCN1KraCtuavRVqF57tLY2g/0eb3jzeylAqiw2/sn7vAxYdXXv20VEUMA7UL5VQoqyFjQOo+BRgBtRUgy6ltEXi7pIuVLBPh915R3Lqzc2FmEhgQXCqIhgWAw1knv7y90gmwIU20rhzgxyyD//RvQq2BG5Kh4AUqGPB2uYowUPKpg/WWYbhJzxdPJ7Q92CyFdDinQ6hpMtvboBKy9PdURxYGKn2miweUIh5P4QVio1UgTJbPyfkc35K90eUSSzCi1MXw0+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7b/ASmGD+kyiWTeF5vwGlzDqFQawyqOI3gFRP+1roTo=;
 b=L5G7HSk0x2nhcRo2U9opEqbjSSVX590ClsBNiGTcaNWi4iilHNjWE8SJJr55tPpcMVWtMQyQsMmPZcbM33qgxzCgyPpjTC9efk16qnT10P0Sn0SGDDOaujoC+WAvurU+FUyzqTT33Rwqbmde73owYxUi9kQDSUz1TJCia7CUdtkg4IO/gM/dtnDApY8J0B04jAKUd1UrgEamF6XunJiZ5ftDOWdqmk7MOUly/b4vxWkpkq/YCstH2UKUAp9brjMtXMgl+1jIAbb+gv4vowQnnf0/+MwHRBvd+5JUXh2Acy+G1Iy14M2/ixJzkW6cFwPXMbTUaMN0Is0aGSZGOA8Wgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7b/ASmGD+kyiWTeF5vwGlzDqFQawyqOI3gFRP+1roTo=;
 b=e8eAkgxQU+tHfJOoDvV1H+iKXug/4+CBDvnXZ7R/KSPqyVXyk5qwr6swgBqmKJ12lTpsemgHqdspfyG44TMsW4rMPn/pcDLFUh6NUK+GBIiRL3YD9eOFp/ZlOu6DAFfCBevjkGneZ2w2oQOM3KrH2Ez9RIsyFcgfi4/7nzZDhLc=
Received: from MWHPR2201CA0038.namprd22.prod.outlook.com
 (2603:10b6:301:16::12) by BN6PR12MB1361.namprd12.prod.outlook.com
 (2603:10b6:404:18::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Wed, 6 Jul
 2022 11:51:22 +0000
Received: from CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:16:cafe::55) by MWHPR2201CA0038.outlook.office365.com
 (2603:10b6:301:16::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15 via Frontend
 Transport; Wed, 6 Jul 2022 11:51:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT059.mail.protection.outlook.com (10.13.174.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Wed, 6 Jul 2022 11:51:21 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 6 Jul
 2022 06:51:18 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <joro@8bytes.org>, <iommu@lists.linux.dev>
CC: <iommu@lists.linux-foundation.org>, <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 RESEND 35/35] iommu/amd: Update amd_iommu_fault structure to include PCI seg ID
Date: Wed, 6 Jul 2022 17:08:25 +0530
Message-ID: <20220706113825.25582-36-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220706113825.25582-1-vasant.hegde@amd.com>
References: <20220706113825.25582-1-vasant.hegde@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 456774f8-d489-434d-091b-08da5f45d8c1
X-MS-TrafficTypeDiagnostic: BN6PR12MB1361:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7BP7bBUUbX7nV/ve3zvhfKq0G1RjgEpws43UXWM+ZF52YIeDmG3hbHlLvlgQ0sjeBoaJvpaFrOMMVePRpC7vi+aCShY0TsC0Bv0zJfDwhneATOV6MBt3ygY1he77/qVH7dh4KSYz4NGcTPKcL3bgXyJ94gUhg1vdihK50sDfENd2owb/cl4nD2ZJ5KH40R5NuTKJsy3wvQ2nyFwB8JaPVBm/jKW6Ygbh3RxSEXGlhBOoaSF+AkrVYkjgTswNiADzUE1CMzluRWT/zMjv8AlicCWuWeb904BJ7lIEJgofTz1Srn7Q6CpCl+ASFokpUlZRSTo0fH6K/ft6SHE0sza57WSmV2/awH+OiyFNfRf9EKfRNy8Ui3cbmi1vpdiEuHAfImq4JnM0PdryrFNkM/a9N9+KN23Js/e1iTKnBdMCd6kpEuf7LTq5YYja5ywbiaRI8dxyLe4qEXvkBfP6f5p5DBZOxJNAKuuuGtYT7JpvbUWARLLyE4IWwcBfV+dP453JZWFaunUFD6LYGY6aOVwkbwljbYJIzNWUMyInMiNk8nyNWjFzDkTUvE0Ggn9ufTcK+n6Apoy+Q4BeCL3nVgNNHhmzgF7stDh1fg8L2w53BHNeGSkFZQLlSj6rG21P18wNSgslWQZJVhbgdlTRcU3xLW14vTFt4Mooy08fk9yDAPBF7tLGgxATbokZtXcNEXACIZv4j1wrEPLY9IK7SuY3V7smw+Rywn+rPlH0CgPPBK8OnftPzJ700TDDp6sbQnDPnAGJQfBYHxMhoyzczUWC/2Upi2s2dUWluq4ZTQaeF1ixJKrdklbtuY0ROOW6ZwqjbsPki6hTKCxLfnCO+mCAlSuphBoRMXlgS5QKJQ2tevBNaCpYUpxwpnnQR4gU8PPV
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(136003)(39860400002)(346002)(46966006)(36840700001)(40470700004)(5660300002)(6666004)(82740400003)(356005)(41300700001)(81166007)(4326008)(8676002)(70206006)(70586007)(36860700001)(82310400005)(186003)(16526019)(7696005)(478600001)(316002)(2906002)(8936002)(44832011)(1076003)(2616005)(34020700004)(86362001)(40480700001)(40460700003)(26005)(83380400001)(47076005)(36756003)(110136005)(426003)(336012)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 11:51:21.8226
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 456774f8-d489-434d-091b-08da5f45d8c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1361
Message-ID: <20220706113825.trKhQPn1qnfMZXfy6H1aojodC1KHT9s7R_5Jihyf0V8@z>

Rename 'device_id' as 'sbdf' and extend it to 32bit so that we can
pass PCI segment ID to ppr_notifier(). Also pass PCI segment ID to
pci_get_domain_bus_and_slot() instead of default value.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 2 +-
 drivers/iommu/amd/iommu.c           | 2 +-
 drivers/iommu/amd/iommu_v2.c        | 9 +++++----
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 1ca54803702a..40f52d02c5b9 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -486,7 +486,7 @@ extern struct kmem_cache *amd_iommu_irq_cache;
 struct amd_iommu_fault {
 	u64 address;    /* IO virtual address of the fault*/
 	u32 pasid;      /* Address space identifier */
-	u16 device_id;  /* Originating PCI device id */
+	u32 sbdf;	/* Originating PCI device id */
 	u16 tag;        /* PPR tag */
 	u16 flags;      /* Fault flags */
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 6a1db8f9f453..a56a9ad3273e 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -701,7 +701,7 @@ static void iommu_handle_ppr_entry(struct amd_iommu *iommu, u64 *raw)
 
 	fault.address   = raw[1];
 	fault.pasid     = PPR_PASID(raw[0]);
-	fault.device_id = PPR_DEVID(raw[0]);
+	fault.sbdf      = PCI_SEG_DEVID_TO_SBDF(iommu->pci_seg->id, PPR_DEVID(raw[0]));
 	fault.tag       = PPR_TAG(raw[0]);
 	fault.flags     = PPR_FLAGS(raw[0]);
 
diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
index 40484af2ffc2..696d5555be57 100644
--- a/drivers/iommu/amd/iommu_v2.c
+++ b/drivers/iommu/amd/iommu_v2.c
@@ -518,15 +518,16 @@ static int ppr_notifier(struct notifier_block *nb, unsigned long e, void *data)
 	unsigned long flags;
 	struct fault *fault;
 	bool finish;
-	u16 tag, devid;
+	u16 tag, devid, seg_id;
 	int ret;
 
 	iommu_fault = data;
 	tag         = iommu_fault->tag & 0x1ff;
 	finish      = (iommu_fault->tag >> 9) & 1;
 
-	devid = iommu_fault->device_id;
-	pdev = pci_get_domain_bus_and_slot(0, PCI_BUS_NUM(devid),
+	seg_id = PCI_SBDF_TO_SEGID(iommu_fault->sbdf);
+	devid = PCI_SBDF_TO_DEVID(iommu_fault->sbdf);
+	pdev = pci_get_domain_bus_and_slot(seg_id, PCI_BUS_NUM(devid),
 					   devid & 0xff);
 	if (!pdev)
 		return -ENODEV;
@@ -540,7 +541,7 @@ static int ppr_notifier(struct notifier_block *nb, unsigned long e, void *data)
 		goto out;
 	}
 
-	dev_state = get_device_state(iommu_fault->device_id);
+	dev_state = get_device_state(iommu_fault->sbdf);
 	if (dev_state == NULL)
 		goto out;
 
-- 
2.31.1

