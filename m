Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D478D1C6A1
	for <iommu@lists.linux.dev>; Tue, 16 Jan 2024 16:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OQeXMORD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eg82qHrsYCOrb7/31vkLxsJn0MbnK6KTq/XpE4fpFL5x3iRVLYhP4QiJVN3rNzkvvM72JCumoMz4sDJZ9CcQyZc9s58IocV3SL/USnY7LRwFmkO/v3ymHCqTEJMYNSRBobIJwT8mcZInHUoZyOxGuwf7rjgk0YWaPCnR/Vrol2fOf88eG3shvc8tYK2p/fk3+7cJJlvzIB7RYQ6EdoNxjB02mYVZjymePHFHxZViqDHlTjZ2jbqjwogWAQZ8lZH5XFrBFDuDMjzTIsEPLcU1s8dWzcL4bKQREqYyGv3UDKVfFhsj+3JAyNDZ8eUvlrCYFErjIZV6Kgc0MP0f8zBHXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HKGbl3QHA9fR71SJFowdWXg0rh322n49D5eW5UbOhQw=;
 b=ABLoneeEao8Jro4ZNg45RZCWwjCzQYGWeLi+ub1+RVo1WOe3cTmwU+QVL2zsoxwdJEO+S13s/SwkW4A0JJW7wmgSV2jDcRMQShx/q/3CT5RPpIC3Ho/xmRYv91uouTlDyCMS26zrL3mOmN/wvQmd7ClYuHhJ/pROnhglkP9JL77dQvhsA2IEwkejnSNcqcxzjUkO+TIe8xbjbyr3iuGmnf8xEWKKespUL24r8CKTdo+jQkR19/uTxk0rH0x7AapaJvKbff/itGd76OMvcURxyBU1LMMsmEkeky6gKB26yVKLNjIXaY+JdkApxaRJUkMNpcAUX4uDOfs45u1f5aHB9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKGbl3QHA9fR71SJFowdWXg0rh322n49D5eW5UbOhQw=;
 b=OQeXMORDtCVlqQBSmle4ipXnSDU10jBOHobJvED+XRLo42oHM7ajKeiOOeJu8Fi+s31JzR2TCUbC+bBmsSIoa+L6ObibE4b5en4pQax8dca9Ig/1sDprRByKjokkXYzDpxLHSYBZdIcEyQji3UZADZl4SNk44k6pa9+81MFstpY=
Received: from SJ0PR03CA0190.namprd03.prod.outlook.com (2603:10b6:a03:2ef::15)
 by SJ0PR12MB6757.namprd12.prod.outlook.com (2603:10b6:a03:449::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Tue, 16 Jan
 2024 16:56:36 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::ac) by SJ0PR03CA0190.outlook.office365.com
 (2603:10b6:a03:2ef::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26 via Frontend
 Transport; Tue, 16 Jan 2024 16:56:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 16 Jan 2024 16:56:35 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 16 Jan
 2024 10:56:32 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v5 10/17] iommu: Introduce iommu_group_mutex_assert()
Date: Tue, 16 Jan 2024 16:53:28 +0000
Message-ID: <20240116165335.6043-11-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240116165335.6043-1-vasant.hegde@amd.com>
References: <20240116165335.6043-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|SJ0PR12MB6757:EE_
X-MS-Office365-Filtering-Correlation-Id: b3bcc08a-6d16-4b8e-cd9e-08dc16b41992
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VFFBfNHvcUju7yHp4ZSJViJ6oOv0lhbkYrA/XL6wvWvr1+RSzuPKkyYIlCPDvREPea6w4dZN/wJ7vuH6WvGS++e/oZzjfk5NxfK1o6mqMsDtDZ3ZV3tEtFvN7bxc/exNsPa0SHOuobfO+EDKk9Zl/idPr4F0Uui7UgMhs6lsYwJNdvFJPH6KuKyp1dxETgf9kAmkHiIyLYnvGZziUpjXwSVfi0xgrHvbsYcCE0txwTKos2GlpENheKUFAocsH8v1SKrKUkN43/y8/X4UCFtvWQEYeqOvI/2uoNQV17iFHr5d68pcqqBNlTI0rExleMK05ctMYD/GOVnLLAKSXOoRYxOXdK6GtzjJadcXLM8wgF8ERCoym2ME/b1h31GGEhHEuO7KgZRKkYSbfR1ZGHDA7KgcEv6CGaIDKwSfN16WWjSW15usoqJAAHAybPV3+7H2l47K/6ROs1bL57zPUWkuKpTJtc9O5u7Dizv1TyYPgbMGHYE3eU2JjA7dHx7jacaHLR2y1wObf3TIwzaab4FpN6U1o3utukI5BMw4RPf2O+PVJ3JO4/iKElBNLJ6RrdOzrvpZayb1zp+pHHg4egtOpR8EXQzsaUFftB8FEgiW8aJWTBpzFCepzz9Zth0YHWL+j0cPDeaT6C20IoIcohfFhpxia54XAcEyw3qdqoHV2cxhwC2UxF0AICulCKCJKHjIgS8NIaaH78vAldAYWacrYQC7ROeLlaqESLehDPm4jfEpN43NIhHZ6vwagQhY0aun8fgXy+0OEOcLPFjzUaJJhA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(82310400011)(1800799012)(64100799003)(451199024)(186009)(36840700001)(40470700004)(46966006)(5660300002)(2906002)(8936002)(4326008)(44832011)(8676002)(70206006)(7696005)(6666004)(54906003)(316002)(70586007)(110136005)(478600001)(41300700001)(81166007)(36860700001)(40460700003)(40480700001)(356005)(82740400003)(86362001)(1076003)(16526019)(426003)(26005)(336012)(2616005)(36756003)(47076005)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 16:56:35.7337
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3bcc08a-6d16-4b8e-cd9e-08dc16b41992
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6757

Add function to check iommu group mutex lock. So that device drivers can
rely on group mutex lock instead of adding another driver level lock
before modifying driver specific device data structure.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/iommu.c | 17 +++++++++++++++++
 include/linux/iommu.h |  5 +++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 502779d57b68..b27d98374d43 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1246,6 +1246,23 @@ void iommu_group_remove_device(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(iommu_group_remove_device);
 
+/**
+ * iommu_group_mutex_assert - Check device group mutex lock
+ * @dev: the device that has group param set
+ *
+ * This function is called by an iommu driver to check whether it holds
+ * group mutex lock for the given device or not.
+ *
+ * Note that this function must be called after device group param is set.
+ */
+void iommu_group_mutex_assert(struct device *dev)
+{
+	struct iommu_group *group = dev->iommu_group;
+
+	lockdep_assert_held(&group->mutex);
+}
+EXPORT_SYMBOL_GPL(iommu_group_mutex_assert);
+
 static struct device *iommu_group_first_dev(struct iommu_group *group)
 {
 	lockdep_assert_held(&group->mutex);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 7f6342bc71c3..c983b6a1ebce 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -751,6 +751,7 @@ extern int iommu_group_set_name(struct iommu_group *group, const char *name);
 extern int iommu_group_add_device(struct iommu_group *group,
 				  struct device *dev);
 extern void iommu_group_remove_device(struct device *dev);
+extern void iommu_group_mutex_assert(struct device *dev);
 extern int iommu_group_for_each_dev(struct iommu_group *group, void *data,
 				    int (*fn)(struct device *, void *));
 extern struct iommu_group *iommu_group_get(struct device *dev);
@@ -1144,6 +1145,10 @@ static inline void iommu_group_remove_device(struct device *dev)
 {
 }
 
+static inline void iommu_group_mutex_assert(struct device *dev)
+{
+}
+
 static inline int iommu_group_for_each_dev(struct iommu_group *group,
 					   void *data,
 					   int (*fn)(struct device *, void *))
-- 
2.31.1

