Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22690C433EF
	for <iommu@archiver.kernel.org>; Mon,  4 Apr 2022 10:06:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D7012607F7;
	Mon,  4 Apr 2022 10:06:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rsRU9Fr9hVXo; Mon,  4 Apr 2022 10:06:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C342160803;
	Mon,  4 Apr 2022 10:06:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D8D6C002C;
	Mon,  4 Apr 2022 10:06:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CC44FC0012
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:06:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B68B340145
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:06:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oQLm9HdocN0A for <iommu@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 10:06:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::607])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D9E804002B
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:06:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TvLtwqFLXtrm/HPRJE00O8V922IKfBVdHWqFSkyl5DcCYCbLnOvnJgJUsQoPlqMO+eepowrKy+22b2NeBSpRXbpl1kw30ohRB7zcx5GcHmyfRxqzr39QG+/rU1TyanjSxpeyTIspVmyq6FYWY4CLnb8Q6sRUFysbcK15lzW6s3FkTsEb+iIXmHO5TdkMSSh+8TD1Hl6q3+Yzffemv2QrGfVP+bxREGTYIb22nxrssDfEoTAHHGHeU9G+FsOgRSBXPFqQSxWyOq9pT+2tagPTDBZog8Owh7JCdAxWXQ+kFOpiQPQzK8RJXo3aSEF6U6MaSbKndBUnfHskYm4YcnUOzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7TOl3zaekKoYvqyJwC1DHbcqJ8IAfMPKYSq7Actuaxo=;
 b=GAq9GX8k9AYV0vhDsqc09dPEPlevvVUPpxdk+3k6q/QMLTiJ+x4JX6EwJVhyRqLQg1jEXfkRQgpjZD+4v4JO+fnriP2BSUwvE4bLy8w2mfWXAcZV6kVGNNVr041ay1yraZzpQIJOW37iMZF3lFtxJSCL0rZDHFEXbr5ekALwhm7gia2hSmQej0jHhTfUZsueerSuY82C3vrysWMgZ3WbeGtkppcTgh/U/cdVRJYW9KZblmhTriU1Pye/uWXW1w/hmFmRvI/DHBM2r9kIoaFgsKVthPOvpbDZA8SgL8HGvtSX63vKZuHuwSmZeDEOsvtPJHrtI9on92GyRpY/k8E7Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7TOl3zaekKoYvqyJwC1DHbcqJ8IAfMPKYSq7Actuaxo=;
 b=WPRZCA14tafHoD/wluLTlrv3ExWOQKPEVVx2QLAsEamhTLHLpazDMPmX8BcNtXD5O5OrFbonyrgZmSYNSFCh4OKHh3dA3MbubGmVaJQ5fAwEtfcliR73qiRb6YFeeiVQSfl/39HoHu9kueT0cHmBnhYRknh55Z3BjF7HJaEASI0=
Received: from MW4PR03CA0213.namprd03.prod.outlook.com (2603:10b6:303:b9::8)
 by CH2PR12MB4860.namprd12.prod.outlook.com (2603:10b6:610:6c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 10:06:06 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::b2) by MW4PR03CA0213.outlook.office365.com
 (2603:10b6:303:b9::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Mon, 4 Apr 2022 10:06:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Mon, 4 Apr 2022 10:06:05 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Apr
 2022 05:06:02 -0500
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [RESEND PATCH v1 21/37] iommu/amd: Update set_dte_entry and
 clear_dte_entry
Date: Mon, 4 Apr 2022 15:30:07 +0530
Message-ID: <20220404100023.324645-22-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220404100023.324645-1-vasant.hegde@amd.com>
References: <20220404100023.324645-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ddea4a5-a697-49c2-0719-08da1622bb70
X-MS-TrafficTypeDiagnostic: CH2PR12MB4860:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB486015FF7753E6FC4D172AC487E59@CH2PR12MB4860.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aMhJvU4pyQ88O8k3i8KQuBwRxwW+B004IBmu9pAl2t1YsPezD/k32GvT7S83SOWoq2cVQ3w0/R8UlMIbXUpV2wIA8gMvJtIfynvo/LfrwMXMjA0trCSerY0OIN0vtbdiZJ4jrHDmjjcRkfWnvKedWIxrQ066I7ji0f++yWsk87rJnkeiuDR1euOTEVYlQW2D8/et0LBjY7AM7WFR6U6uaQx8BZwiYIQvac4D+4h0uEnAcaHzyxuQrMbqj/uRc3UgeKgwAZwc9ewf2L3BHwKsjysZg9X0nDlGt/GL8N240AII3Z76OABLXMLcHRmOZJXmWCnRUd4AB3xAImm/9jThrtOcoaJuB8P9Cmhao3B6oLnYdN7Q+6+hKwxLQJ+ygVU6SBtZjWgf+Ocwuf5ekCxbQBfkedBVn+hk/m5Aagw25jOePN0pmTNIpxGztW2J2ZTP2SztLR8cc1aayhqvzgDUnr3GtIKQL9k8CePwGxhkdOx0KRpt+zFVcqr4p0HgCwmDG0+AVC4TKkQEYPXqtsoegnzC98+oPWfm9tyUa40PivawfSI23i8ZC/OKtCZVSvxWRGpBfUdC6X1kENM2wJKTL+MUxqGLJJ2FEUjVhvfXKmlK0ScZwMY+2WUIhym1IFLfVHXKcJ+BxdWVwzNQ4BD8iVN926DKk9Bhwj37+axg+sj0FUJchI08ojNhKV5U/AXXV3AtTzo1wMpy4G4ivyGS0g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(86362001)(83380400001)(36860700001)(47076005)(70586007)(70206006)(8676002)(4326008)(26005)(16526019)(336012)(2616005)(1076003)(426003)(186003)(82310400004)(508600001)(40460700003)(356005)(15650500001)(44832011)(8936002)(5660300002)(81166007)(110136005)(316002)(2906002)(36756003)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 10:06:05.3695 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ddea4a5-a697-49c2-0719-08da1622bb70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4860
Cc: Vasant Hegde <vasant.hegde@amd.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
From: Vasant Hegde via iommu <iommu@lists.linux-foundation.org>
Reply-To: Vasant Hegde <vasant.hegde@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Start using per PCI segment data structures instead of global data
structures.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index bae65b05e37b..adc1747234ff 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1534,6 +1534,7 @@ static void set_dte_entry(struct amd_iommu *iommu, u16 devid,
 	u64 pte_root = 0;
 	u64 flags = 0;
 	u32 old_domid;
+	struct dev_table_entry *dev_table = get_dev_table(iommu);
 
 	if (domain->iop.mode != PAGE_MODE_NONE)
 		pte_root = iommu_virt_to_phys(domain->iop.root);
@@ -1542,7 +1543,7 @@ static void set_dte_entry(struct amd_iommu *iommu, u16 devid,
 		    << DEV_ENTRY_MODE_SHIFT;
 	pte_root |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_V | DTE_FLAG_TV;
 
-	flags = amd_iommu_dev_table[devid].data[1];
+	flags = dev_table[devid].data[1];
 
 	if (ats)
 		flags |= DTE_FLAG_IOTLB;
@@ -1581,9 +1582,9 @@ static void set_dte_entry(struct amd_iommu *iommu, u16 devid,
 	flags &= ~DEV_DOMID_MASK;
 	flags |= domain->id;
 
-	old_domid = amd_iommu_dev_table[devid].data[1] & DEV_DOMID_MASK;
-	amd_iommu_dev_table[devid].data[1]  = flags;
-	amd_iommu_dev_table[devid].data[0]  = pte_root;
+	old_domid = dev_table[devid].data[1] & DEV_DOMID_MASK;
+	dev_table[devid].data[1]  = flags;
+	dev_table[devid].data[0]  = pte_root;
 
 	/*
 	 * A kdump kernel might be replacing a domain ID that was copied from
@@ -1595,11 +1596,13 @@ static void set_dte_entry(struct amd_iommu *iommu, u16 devid,
 	}
 }
 
-static void clear_dte_entry(u16 devid)
+static void clear_dte_entry(struct amd_iommu *iommu, u16 devid)
 {
+	struct dev_table_entry *dev_table = get_dev_table(iommu);
+
 	/* remove entry from the device table seen by the hardware */
-	amd_iommu_dev_table[devid].data[0]  = DTE_FLAG_V | DTE_FLAG_TV;
-	amd_iommu_dev_table[devid].data[1] &= DTE_FLAG_MASK;
+	dev_table[devid].data[0]  = DTE_FLAG_V | DTE_FLAG_TV;
+	dev_table[devid].data[1] &= DTE_FLAG_MASK;
 
 	amd_iommu_apply_erratum_63(devid);
 }
@@ -1643,7 +1646,7 @@ static void do_detach(struct iommu_dev_data *dev_data)
 	/* Update data structures */
 	dev_data->domain = NULL;
 	list_del(&dev_data->list);
-	clear_dte_entry(dev_data->devid);
+	clear_dte_entry(iommu, dev_data->devid);
 	clone_aliases(iommu, dev_data->dev);
 
 	/* Flush the DTE entry */
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
