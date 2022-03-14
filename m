Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF2CC433F5
	for <iommu@archiver.kernel.org>; Mon, 14 Mar 2022 07:03:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2D95360D9C;
	Mon, 14 Mar 2022 07:03:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lu_i7Jct5UfM; Mon, 14 Mar 2022 07:03:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DEEEE60D91;
	Mon, 14 Mar 2022 07:03:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A163DC0012;
	Mon, 14 Mar 2022 07:03:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CFC55C000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Mar 2022 07:03:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B000440274
 for <iommu@lists.linux-foundation.org>; Mon, 14 Mar 2022 07:03:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y0UCamEb8N1m for <iommu@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 07:03:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::606])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7F99940265
 for <iommu@lists.linux-foundation.org>; Mon, 14 Mar 2022 07:03:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQhuWaJLN2AvApHp9dYl9T28W/JY+0eJD1QFrNKx20+unaEf/66tGcwmdckbm5wgJu6FgkvnDqPDctyTmc3EH6+Z7Vr6SyE/XrJzStlitHS7L9F3hY17Maf8x07prNPg8WIj14soJ3aMc+EqIor27o4KIEnuRGvy0vuPaYIq+VX1vPjlo/nGmfh7J+U0+gXEstylvw6en1UFKnKd0/F4pF66KMNtCtsQLHfj0ezTybxub3SE5NzpApSUmt8vguziPxy5GNMxscMAc36jYC5vkhbpnFO6ViCanQ/HjWStKYW8e+UxNL8zjrlQ2GH48PkRv1rzoHnxCKU/j1QCWr5DUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h04LVpfKRdjn/6+VsmUV2cqbvoHE3jXJ87IprWIAANE=;
 b=N0SQX98ozRokGUZdD5WopkwN3Nf1W1GYuYODengsdBftxPTCYY7/d2DyBMZMGcq5XSMc7rCUesAMUmQRbXu0Qo2NMP5lMPMt+qEwVdFzLdVXnqkHuQupeID7VHB3hSDecoDuKG3fT6aTGRlOPSjP3wBnq15C0DpvucJuou3IIFWvSMjlTYHx45Hh0oz1x5huSqiVHuXiRNXxxXBd2j9gNkyAledIg/xuAUZn8PEGGrJxkGxIBbNjv53trV16/8o+h5rGWEJsLtyem5zq64XTAag3vWmgp4/5IvqXSk3GSLkGCt3ejDFlr3VkHsXc1BD4UAjUIVlCOMB+M71iTfJRNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h04LVpfKRdjn/6+VsmUV2cqbvoHE3jXJ87IprWIAANE=;
 b=Ct18ikIdaBwIwpvcWZVjdDaL645VKOsoPmV0UNTmj85W+whcCPTujJFoE7W3wuLPMDUpp6Inr9xOkHq6x+tTZ0FZVmG4skp5TDDwCcZIN6upx6E5FEYGhkdP9GNu+wJ20JhpqNuaFToO85tGj1DTLvKMS8jPqNFowRiU7DUMpFE=
Received: from BN6PR13CA0041.namprd13.prod.outlook.com (2603:10b6:404:13e::27)
 by DM6PR12MB4698.namprd12.prod.outlook.com (2603:10b6:5:34::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.21; Mon, 14 Mar
 2022 07:03:05 +0000
Received: from BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:13e:cafe::11) by BN6PR13CA0041.outlook.office365.com
 (2603:10b6:404:13e::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.13 via Frontend
 Transport; Mon, 14 Mar 2022 07:03:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT049.mail.protection.outlook.com (10.13.177.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Mon, 14 Mar 2022 07:03:04 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 14 Mar
 2022 02:02:57 -0500
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [PATCH] iommu/amd: Remove redundant check
Date: Mon, 14 Mar 2022 12:32:26 +0530
Message-ID: <20220314070226.40641-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6cf9ec8e-176f-4868-adba-08da0588afc7
X-MS-TrafficTypeDiagnostic: DM6PR12MB4698:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB469881B8ACB6601B7C98E1F7870F9@DM6PR12MB4698.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t/w4r5gKOiVRLeGFhK0ox6spqrCkIxtl2sFNYBUAE4ij7a1oRTPTqc761Y7NCQW1kQoOch6ush3NlE10EYhnWl7STr/erOd+XW8DpxEzS7ZBVbYs5VKC1ftiDRxxV50nSKkON26jSafBwdH8fI+3TOREQ4D3yy3sCVfJ9QSmOg72pWfWi7dFERiQZi8ADbsZCBInMcNZ8dDr33/DtdqRdFScXLQEDzCKVV19I540zi4iwXMmhFTsKUc3qGhkYH/p98HI/XjhyNdbhyLK9a/crwwXfnuDGbENTpo3rV4V2mx93DOfWPgkVOr59F3jNT8FGjsvHZgTlCIwYhErol2FQ1pnR8nBszUr1PZ5MZh0VFPMOxH7a5NwGNIs81YmZhO+qAPmwK+Err/8NAczwwp6eZgu5/dHxxXutTRsCJoAO4Z4i6U1c+Nodl1sKE7dig5LKn9ZRSrYAlJaRT1v+rWOUyVxvT5oz1NgQhNbyzJ3YhOibgxOuSeKFi9+SswZddmry+32Thu4p/MbGVm59PsbDUQ+QBTBlzf1HxPxa+nYI1F6ZNqbYDu0vkn99oMJP5L7h2K9HWHdo/0YJPGtc+piIK1THDGLRpJkcKe3WpdDLJGxPNkt5aMIY7QXnhkhAl7A8YS5jb0gcw5sHAyUEcTAy4W4Z7wYu0ctDXTGB061R22FcrVdO5+CscS89UIkWtVr22pH5DwMXd+pC7UA2AVM6g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(2616005)(8936002)(6666004)(356005)(70206006)(70586007)(1076003)(508600001)(4744005)(16526019)(5660300002)(26005)(81166007)(186003)(336012)(44832011)(426003)(110136005)(54906003)(36756003)(82310400004)(2906002)(83380400001)(316002)(40460700003)(47076005)(8676002)(4326008)(86362001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 07:03:04.8199 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cf9ec8e-176f-4868-adba-08da0588afc7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4698
Cc: Dan
 Carpenter <dan.carpenter@oracle.com>, Vasant Hegde <vasant.hegde@amd.com>
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

smatch static checker warning:
  drivers/iommu/amd/init.c:1989 amd_iommu_init_pci()
  warn: duplicate check 'ret' (previous on line 1978)

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: 06687a03805e ("iommu/amd: Improve error handling for amd_iommu_init_pci")
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/init.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 2586e589e54e..8ed1f86fe93d 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2137,8 +2137,7 @@ static int __init amd_iommu_init_pci(void)
 	for_each_iommu(iommu)
 		iommu_flush_all_caches(iommu);
 
-	if (!ret)
-		print_iommu_info();
+	print_iommu_info();
 
 out:
 	return ret;
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
