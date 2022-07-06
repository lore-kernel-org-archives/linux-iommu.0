Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471E633C6
	for <iommu@lists.linux.dev>; Wed,  6 Jul 2022 11:48:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lG8F5MkhhwGP4Te6znq+ImtHNNac2ptt2r6lvm+pYIEFoZzC3cLf5B0NFmOeSzDfu8fZhOFZ7/vsTlnHHyribNmBRJabyJCl7CHsPYnb9qhPng+V+7ihCUjKBmUglsEVA2rX/4NjLfzzOLjlPzi+w2zxL9WkvUZv0Nic4D2Lgr8vfv4pw2Ihz9YOwzbbLyXelNjIisUt3Zl+nguYgTzSPAAh2zi3XC8NhdXKzX10gCTVdncPnI9xYtWr0jiYx2ocGviTF6UCuAwmYAGricVS9g/DNPEAGfpRBWKDfpmFUDDwydizkeLeekwo0/kuuKaqOn+JcAvywxN20ccZHISohg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OhSVc0BaUErIGLYzy6Wr96DH65x5a5ydUMKHu0LOG8o=;
 b=NL+/NZWL5nAImhi8NF87M8GX+N5/athTGc2d5dz/Josy2imvBsRuL9P/CrBSzJ7OTSlsfWH2xOh8neeP0IiaEi6suo3nHd5S1aFb855fnSb4h8Uh2Hp/lowLO0tomQc8EXtH+f4JQQQFAa4PsvEQDu1eDgrvTPzlk7IrMS9Ab43aZMSm5WLY8Ae3HQnWUZd5J7ZtKV3socxg7TxNkM7Dg9/d0Tk8Idfi4k9Ell6B4dF2mVuT/JYtr2gAPIKGfErOfPhUjR+4l5l89YsTWJD1WuiKdOhqgEYApZZd4/jkB/S5CpLbu+fI4Vrt9uM5HZBDMz0mLviVbJMtEAJJOJzf7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhSVc0BaUErIGLYzy6Wr96DH65x5a5ydUMKHu0LOG8o=;
 b=FHXy0tQgv+J5f7ah71LBv5Tou++LakCSZX87dNpndjPrWdJnE9jPlV0ZjFkQktFojGzfNhy0YwjtFU+HUJ4hmLyV8gY/NbEdXKbCRcnwe9QDHXG8mw26VjuGKmu2wJd9timHmBhPWhP7cqnk+5rV+1qwYO6WfotlntAed8ULbFE=
Received: from MW2PR2101CA0028.namprd21.prod.outlook.com (2603:10b6:302:1::41)
 by CY4PR1201MB0006.namprd12.prod.outlook.com (2603:10b6:903:d3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17; Wed, 6 Jul
 2022 11:48:18 +0000
Received: from CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::ee) by MW2PR2101CA0028.outlook.office365.com
 (2603:10b6:302:1::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.6 via Frontend
 Transport; Wed, 6 Jul 2022 11:48:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT029.mail.protection.outlook.com (10.13.174.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Wed, 6 Jul 2022 11:48:17 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 6 Jul
 2022 06:48:15 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <joro@8bytes.org>, <iommu@lists.linux.dev>
CC: <iommu@lists.linux-foundation.org>, <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 RESEND 23/35] iommu/amd: Update dump_dte_entry
Date: Wed, 6 Jul 2022 17:08:13 +0530
Message-ID: <20220706113825.25582-24-vasant.hegde@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: aec7c2e1-c7b4-4a14-a3ac-08da5f456ae8
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0006:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	k2OyFHU5StQOFAZpv3IKHxot/61xjOsJIST2GNtRrGH+lQxRitzwU4tvJ0ESfuKXexLXG4bbEahLP7zC5CzM4UFLoc1KYfMgKT+eJl0fEOFgEL2tll7271PbN8nliNdaFApGozHXigoTTcBQ+1qtTltefD4Q7+7DPgUyay6vMDq4xfcKYdeqOuo0EymLEei6OCs8+tZkw8sBhfzikQNwmsaa5x+ohgB3sxxLIFbw0yQHgr5nL3aYWNJ+2l3Ga9NA9TuX3yDtjT9QlRoDHfQLw0ENtqRwlyGdXXK9f0Fs7PbHp38dbyxGndVPnLy5ySvhlA2GgiFOvqkm67CqUH13DLh3uIIs/A1cP4hSw1FwsOOgt6bRYBcjC0XVg394KMhhETAvHfSaUYDh7aL7YewZuOGiuQCBjb4i0dTZljULYxm/iTKKQoqa0yPGvfkiUMQMXmIAiq8Cezx3szrmR4Fg4v390yyjUo43aVQVUT4zZ8v/FS036J/J1FGbAJ789hAnX6YRdrGn+R8dY8y7+e1WhDSl5f0ueiu4FuUSyWUE1s78Y0+CT4D9+2HDRpIZrdwhDnaodRTGbzKP+xBahQ0iqJwCrLD7phxYC3wVlfc3WxFl53GqbKhnt9Y9nNbZB9c8m8E2OaB/ZpuzBNUdCY7LzGXczzLDT0kEOI1aX0ymxBIi3WNuE8kAYOjBAQsHmjxku1Lwj0jPx4ZEaIBt8yGydsLeWboLvTCw/XH0qxAPVOMRp7I15iXd6P49vO/CB7NZ275yusEbdlaQwR4uE7GlBUc7FfwjAksKzPfiHeYDLq/dCAVKYQP1ayuuvJJTNNk1xgAMAkX9MC0rbOsGiZK65SiOnGe8U+TTTGtpEj3gkJQtDQnEeDjyQMB63nMy99Dn
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(39860400002)(396003)(346002)(46966006)(36840700001)(40470700004)(2906002)(5660300002)(70586007)(26005)(70206006)(47076005)(7696005)(36756003)(54906003)(110136005)(316002)(8936002)(8676002)(86362001)(478600001)(44832011)(2616005)(4326008)(81166007)(82740400003)(40460700003)(186003)(16526019)(83380400001)(34020700004)(426003)(1076003)(40480700001)(82310400005)(41300700001)(36860700001)(356005)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 11:48:17.5328
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aec7c2e1-c7b4-4a14-a3ac-08da5f456ae8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0006
Message-ID: <20220706113813.qqBFZhxdh6lxp8pxz0h-Yb3AtEZlVxaIK-eTDp3ZT5E@z>

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Start using per PCI segment device table instead of global
device table.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 90755da7cff0..790a3449e7b7 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -451,13 +451,13 @@ static void amd_iommu_uninit_device(struct device *dev)
  *
  ****************************************************************************/
 
-static void dump_dte_entry(u16 devid)
+static void dump_dte_entry(struct amd_iommu *iommu, u16 devid)
 {
 	int i;
+	struct dev_table_entry *dev_table = get_dev_table(iommu);
 
 	for (i = 0; i < 4; ++i)
-		pr_err("DTE[%d]: %016llx\n", i,
-			amd_iommu_dev_table[devid].data[i]);
+		pr_err("DTE[%d]: %016llx\n", i, dev_table[devid].data[i]);
 }
 
 static void dump_command(unsigned long phys_addr)
@@ -618,7 +618,7 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 		dev_err(dev, "Event logged [ILLEGAL_DEV_TABLE_ENTRY device=%02x:%02x.%x pasid=0x%05x address=0x%llx flags=0x%04x]\n",
 			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
 			pasid, address, flags);
-		dump_dte_entry(devid);
+		dump_dte_entry(iommu, devid);
 		break;
 	case EVENT_TYPE_DEV_TAB_ERR:
 		dev_err(dev, "Event logged [DEV_TAB_HARDWARE_ERROR device=%02x:%02x.%x "
-- 
2.31.1

