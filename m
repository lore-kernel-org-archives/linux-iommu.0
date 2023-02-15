Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2064.outbound.protection.outlook.com [40.107.101.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23333CBA8
	for <iommu@lists.linux.dev>; Wed, 15 Feb 2023 05:27:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lH6d1y4k5nIwifyACj8OpK0hXIi16g1yaPu3RejpQprd6g0sAMKq7O1zFtNUBlEcD3vPcOtX+kjkvS+eQdxUUbkRV1FNHbgu4UPbOdjmr9ZPx5NECRbSTF6ro0Ayj1vJL6FwW0ThQqB/fb8o+xKt2oNKFKs/kPqwCwcfnuY2SgbytQTnnO2bzVgQoeVz2Su7cdcn/QfsHYUqcEpmKGFSO4Wj5or85oRJsu5rMAbm9meIdbs1aMrAOFrnTWLrdtnq8FUirzJq53M1VmHdKPEhgAUclR7VWJSFD+vRFy+z8CbX0yVBuXiqdABs9RNEDVfaNrWXBjKn47CPZTKyjo1BmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4nD7yppGegekV6wAXORP0InGT1WniNOXpjNcxbD0xxc=;
 b=i+zqZ6ZGOBbzJ0F1Hgi6RqwZ40ZEOfBETtIrI714AUE9QiIlMUxy3au0xXo+o7fHLljIVQhpv4uXI6HRjaMkcmv0pNlwsUaCdQ9MHBrrEjra/Sut7fFBFSZzbjpJhnJ/W4LsuJnH73RiMOfjQVDFQ6MQUwJp6m+aPgmdVWunSHsbjs36r+S1bcbcKVrVOKhNCw9vUsmTgnIy9BtqwXDJDmjgLQTS/kEs6/Pm9h5lfuxJQg9vGuDd8hvUb237rBgPvT5DO6fjhCGO37LnYa4UsIX5Yiybz1tW8nJtO7ATvk2H7C+YdND/e6KT68WkjOkuKFeepkdkOzcnz3JlR8uyBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4nD7yppGegekV6wAXORP0InGT1WniNOXpjNcxbD0xxc=;
 b=eTczrM9UYIFpap4j4bsDdUHN0xSkxmjqr/4OSA/aauga9j83215sFg0t8z+Nmq655piu4knoHLORnWymV46aG3/6f73gfQc5gJECvLRubXgL/NHcvcw71Y6TDUQOWMi0BREoh2OiT4jVQNZsH6EAFiMPZn5liyfXIP9g1VSzoNU=
Received: from DM6PR02CA0102.namprd02.prod.outlook.com (2603:10b6:5:1f4::43)
 by PH8PR12MB6866.namprd12.prod.outlook.com (2603:10b6:510:1c9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 05:27:24 +0000
Received: from DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::8d) by DM6PR02CA0102.outlook.office365.com
 (2603:10b6:5:1f4::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26 via Frontend
 Transport; Wed, 15 Feb 2023 05:27:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT031.mail.protection.outlook.com (10.13.172.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6111.12 via Frontend Transport; Wed, 15 Feb 2023 05:27:23 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 14 Feb
 2023 23:27:21 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>, <baolu.lu@linux.intel.com>
CC: <suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<will@kernel.org>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 1/3] iommu: Attach device group to old domain in error path
Date: Wed, 15 Feb 2023 05:26:40 +0000
Message-ID: <20230215052642.6016-1-vasant.hegde@amd.com>
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
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT031:EE_|PH8PR12MB6866:EE_
X-MS-Office365-Filtering-Correlation-Id: e1bc3f92-6ce8-4efb-7d16-08db0f15518f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IO+5tnatckzB1vTqlSkKA3Xn4JCFm5MsGob30dJqmbuUQq7suAVJZGbRJqlaJEc4zGs+r+jaNzFXcUnvC+d67WTkDiBrdpxXM14fv8eW2UsSDzdI/9cmp6GgUTvgEo77Rwzsg6JwynnPuN4+gEhjal7rMwTJKfn5Mrj8Nbo24uhkTVg6/DLGySIZ6213hhCMLD8JSiaOnZZv6IcpvVQTgpfRddDMcYb+CeaaProGuuxU5FXsgQUS6MH5uXw7xM3hsOHdPCSJzXxXkZmginDqx64cZ9wsmLfqmUuohk0RU1jsbtCH6dKq7/p4g+U7aZ8mxOB2tuB0ESkK1ZG7tJ7vVFCJ+EXb6m27ZP5lIPB6GPNBelCa67mngtQ/QLS65sI0DyRydRYI7JUzrsUQkhvhWTyPRZlKzwBkqOqUoS/RrkWSOSGPnaUuGDFh89ySnDCLXx9C/s7Wx4qfQd9TI+h5mK84k+czz1RB27xsBhZZPkDl6SdaUKm9bmcblBp4LCLwu+8sdh4dJT/46bz1ZHArpDcLVuX+26eOBmvZOSlf8BbnG94k4B3fG6eIjAoSk7D1PXW5hT8VL5aqpVPm76o/XDwA9AQq4Gl09u+eceM8Q+Z2OWThVBXvyBH54fmQjMFDKieZAo41DZjWmYIY8zItIny3oxRplshIAmdGFGUSC8SvNrqKiPi8QY9V8CZIbCFqhWeffsWyffyikbdRyQWeHDZFjO/uL9tqpmsRNLN42B4=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199018)(40470700004)(46966006)(36840700001)(356005)(81166007)(5660300002)(2616005)(36756003)(6666004)(966005)(478600001)(86362001)(1076003)(70206006)(316002)(40460700003)(4326008)(110136005)(54906003)(7696005)(70586007)(8676002)(40480700001)(26005)(8936002)(16526019)(186003)(41300700001)(2906002)(82740400003)(36860700001)(336012)(83380400001)(426003)(82310400005)(47076005)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 05:27:23.9363
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1bc3f92-6ce8-4efb-7d16-08db0f15518f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6866

iommu_attach_group() attaches all devices in a group to domain and then
sets group domain (group->domain). Current code (__iommu_attach_group())
does not handle error path. This creates problem as devices to domain
attachment is in inconsistent state.

Flow:
  - During boot iommu attach devices to default domain
  - Later some device driver (like amd/iommu_v2 or vfio) tries to attach
    device to new domain.
  - In iommu_attach_group() path we detach device from current domain.
    Then it tries to attach devices to new domain.
  - If it fails to attach device to new domain then device to domain link
    is broken.
  - iommu_attach_group() returns error.
  - At this stage iommu_attach_group() caller thinks, attaching device to
    new domain failed and devices are still attached to old domain.
  - But in reality device to old domain link is broken. It will result
    in all sort of failures (like IO page fault) later.

To recover from this situation, we need to attach all devices back to the
old domain. Also log warning if it fails attach device back to old domain.

Suggested-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
Robin, Joerg,
  As explained in previous version [1], I still kept the changes in
  iommu core layer. I hope this is fine with you.

[1] https://lore.kernel.org/linux-iommu/f2151603-de54-7717-60f9-748e9205139e@amd.com/

-Vasant

 drivers/iommu/iommu.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index de91dd88705b..e3336a11b6b9 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2124,8 +2124,22 @@ static int __iommu_attach_group(struct iommu_domain *domain,
 
 	ret = __iommu_group_for_each_dev(group, domain,
 					 iommu_group_do_attach_device);
-	if (ret == 0)
+	if (ret == 0) {
 		group->domain = domain;
+	} else {
+		/*
+		 * To recover from the case when certain device within the
+		 * group fails to attach to the new domain, we need force
+		 * attaching all devices back to the old domain. The old
+		 * domain is compatible for all devices in the group,
+		 * hence the iommu driver should always return success.
+		 */
+		struct iommu_domain *old_domain = group->domain;
+
+		group->domain = NULL;
+		WARN(__iommu_group_set_domain(group, old_domain),
+		     "iommu driver failed to attach a compatible domain");
+	}
 
 	return ret;
 }
-- 
2.31.1

