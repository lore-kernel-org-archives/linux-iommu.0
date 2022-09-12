Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29C07F
	for <iommu@lists.linux.dev>; Mon, 12 Sep 2022 06:33:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TUiSxkwEdraD+miM2b0XLAbOKepQPEBJfEYRJs8L0RULJhThwItVbz4KU/fmh4axl3lpBfvBn5S/gM9F4vJOs4ZWv95fT3uZJhpY7GaLxTVkcZz3QCqRqtEg2EHXRMV2kSlP1Bq+pK5RBJOh5Yh7qqDBWcf9gNhCURzyN7haZNMf1T8qQaevOdu2pE2zX3KmIn8kQQ9tIuPnFL9Kwfxtm3u+tLbqcFgn/u5AHxNqwsf40QT+HeRPMNatMn/l2vP/f380QN7Yr+lf9Nj9n7t+ADT1oCUlQBoBwH6WlZBOqj8P9JguMrW86ScUNPGo1hq+wD62k3JznkYAc1gQJXNNUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HwGCDs0cL5ABQpAcyBuhbgwhJd6WW3D5kSaicULxxB8=;
 b=dgpsCO1O6FgZaZEA4useXuP6M2P5qYKmebemeF8E5tS9jrdiLmU9FWXkkGGhY+JwOPJjpWr1ByzsqCzu85gwJyMoHCOJHZ5tGDLlXME/fmlwfi1zxJ7u9zERHpdWGrrqHmPh47lTWE/jKaWWMeBW97+UazSEZ2Wq09Qp+YXrpJELA6HtyABUww95XOPXPmK/EX+8dqUoavGcug4UDuPMf62zTKwUyFhe1yfpwKmfum6bYGvT+aHg4cjIbYAXSyojCfpc4waH/s2ssJjdECpwQH2FCl53b1oPfYubweLOLHAPoG+qX9EgpI/0CnZZXaimvh2qQ3PdmxLtDSkSvAVJrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwGCDs0cL5ABQpAcyBuhbgwhJd6WW3D5kSaicULxxB8=;
 b=UpPA/ToZtTrzw6netZGaG4uu7WqMgqSovdgbeBUiQLNNVGhcutkUlfDm2hGo0+dUOZ+NxsuMVTZXO0mhKqK+44dcWpVKbxd3gZ0XyEDYXlWcRhdZSbb3a/A++P7EIxcXcupRmniIeeda46LrMyIsAuccF4U3cuxOq1nZcBU7peE=
Received: from MW4PR03CA0187.namprd03.prod.outlook.com (2603:10b6:303:b8::12)
 by SA0PR12MB4367.namprd12.prod.outlook.com (2603:10b6:806:94::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Mon, 12 Sep
 2022 06:33:11 +0000
Received: from CO1NAM11FT106.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::b4) by MW4PR03CA0187.outlook.office365.com
 (2603:10b6:303:b8::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19 via Frontend
 Transport; Mon, 12 Sep 2022 06:33:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT106.mail.protection.outlook.com (10.13.175.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Mon, 12 Sep 2022 06:33:11 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 12 Sep
 2022 01:33:08 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <robin.murphy@arm.com>, <suravee.suthikulpanit@amd.com>, Vasant Hegde
	<vasant.hegde@amd.com>
Subject: [PATCH 0/5] amd/iommu: Cleanup and fixes
Date: Mon, 12 Sep 2022 06:32:43 +0000
Message-ID: <20220912063248.7909-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT106:EE_|SA0PR12MB4367:EE_
X-MS-Office365-Filtering-Correlation-Id: 8720f4b6-0ed0-4045-e970-08da9488a9df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HuuMVnxx7jE5GTvEIZCsifJ0xsWTesxjbPkDThJdcJ72hmnPpNqlMu+QmXSns9yqaMcgFnzan+LzXmg05BkmQwx90wI0wjc2GyVHveYwl6FkwKchpNdadPn5se4cwSu4437o0SkEhatkK+4bm/mrlRba4d0tSrYLC8i4HNb9vCIMeNP99c377rRHm7WMX7hjh7nxpSaJluLHIfGZZUkMmEBDa8oyFY0e1zJa4V9+sncrgamAtce1cLiP4W7q5Yd6xuuEdX3mNc6SGxJbP4xiphlEe0EKq7BR8i/vcrXhBgzKOX2d3FqoLAM8mTuILKFln9IZMM3jffLkdvnQxvoOYlEqKg90WfsnTdxvvfvQj5/8lAAsgUUXYJVZvH2X8sWKYQFpJtdIPv0c7GJiTTZyj7iQ6E4b1BWPReZW6ovB0/esb3m9sIZ9K+3B1YPaA2NWp65Oosb3UnS7B6fdVoQCUiX3TrWQZgWlng5K2kL70XARS32eQxIDMw7CM9rxp3Jv+WSEs34S9pgCB5jQzkWxAjEtbJYfqJ1cXdDzZeXiKNeYITeIqw0hH8+CY17YgralNGVVDST0nmpBsTJCqsTUaOi7Oc4pIqk1mM2OobCbhgdUxHlMYy8fMNCApHgErC7bb1Er+cLdNtaO0NjS51kg8LB1CJk3QqP7cf86C3hl4RLjur88Onp6pbH/WMLB4vxlRc+h57hzZyiPyMfRqApJWpo/BX7sqNVnN0Q+ckwXQB5zgm4xE9+gV5f4JWpOyfX0JrCIqdOX+Q/F5Lmh6geENR1ehtuQnlh3YVcQiiAeOvZjhXXkAkoO8mu+eTXGtcCV
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(376002)(136003)(346002)(40470700004)(46966006)(36840700001)(44832011)(8676002)(478600001)(356005)(41300700001)(70206006)(4744005)(4326008)(5660300002)(6666004)(8936002)(40480700001)(7696005)(2906002)(81166007)(26005)(70586007)(40460700003)(82740400003)(83380400001)(316002)(186003)(86362001)(36756003)(336012)(110136005)(82310400005)(36860700001)(54906003)(2616005)(1076003)(47076005)(426003)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2022 06:33:11.0958
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8720f4b6-0ed0-4045-e970-08da9488a9df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT106.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4367

This series contains few fixes like better handling of error path, fixing
sparse warning and trivial cleanup like removing outdated, etc.

Vasant Hegde (5):
  iommu/amd: Free domain id in error path
  iommu/amd: Protect domain update with domain_lock
  iommu/amd: Free domain ID after domain_flush_pages
  iommu/amd: Remove outdated comment
  iommu/amd: Fix sparse warning

 drivers/iommu/amd/amd_iommu_types.h |  2 ++
 drivers/iommu/amd/init.c            |  2 --
 drivers/iommu/amd/iommu.c           | 22 ++++++++++++++--------
 3 files changed, 16 insertions(+), 10 deletions(-)

-- 
2.31.1

