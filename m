Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B620C433EF
	for <iommu@archiver.kernel.org>; Tue,  1 Mar 2022 08:57:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1C8E24016C;
	Tue,  1 Mar 2022 08:57:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6Z6vxeCtp2jF; Tue,  1 Mar 2022 08:57:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A596D400F6;
	Tue,  1 Mar 2022 08:57:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 87F63C0033;
	Tue,  1 Mar 2022 08:57:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E5BA3C001A
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 08:57:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D41D94136C
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 08:57:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j1aNAM9b0Vds for <iommu@lists.linux-foundation.org>;
 Tue,  1 Mar 2022 08:57:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::611])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A133441299
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 08:57:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b52q05IASGPvRGn58kjZwqR/zZlirAKnFEYd42Y5DXYI5gfNkn75WQvG4bvcvud4o5cnV7C+yow3r6i/HD/TgElOrtuSBR9ZHc6btrsJ/VG5IOIOGzA/ZzfSB+L7q1ZikGTBkzkrFPYN8FqlTr0n6N52YzFphfKM0UGE42q7MC4N3UKwOYIvvJjJRsQWdeazTDhigPgBxuR+A97Bzw7Ce3bqXEt1S50vN0c1OKBrcpDPbiHOmz6+aZwloGOzd552Y5ZY4x6v7klHf7qxnF8gPzJvbH4c1vZp6y7peaanoAyYK24uLDVH3RkkN0cKCdkm3Dc6AYMRQw7+UV9RYDyFqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I3hdo2hXrJjdeSMIEO3ULXKO8PqgA0qJSYLOfQLztOY=;
 b=BHyKU2Tr21a3RohQxAMlPdXPwA4BrzHF98uOTPJIBeOS+un8enHoPjLL4Kncr5bbfEaroxQGGpOXuK85hGQzkwhenAIJViXKn/mOl8BChy902o+1Wli/YPWMalO6lTmHdqvCM+lysXYSnTu68sPfXrrS9UFz+B2RVmhiTFQkVI2ATv/uWXI3UYM5ZNQz00QiofcK4OwIEoyEYZtgWFH1dwvX4Pqum8B5nPOZHT3e1FA33MrKkHbiNjkjd/xCNYjRNrt2VhweXFa/KoSu9q0KETN/9+pzDWjkf+sLUSuIVL1mY7K7XVV5dq3y7KdQ1+2GpPqoCtHeiSPilG4vt0C+Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3hdo2hXrJjdeSMIEO3ULXKO8PqgA0qJSYLOfQLztOY=;
 b=zQMsSGg33GIETopLiFtRMYHN5y+rHJnHRxLnrlD6nfLsKhxOlBjxw4sTHD3wVPbzHMyTiV9Yu3H2sXQXqO1dNDY7PnOOxFBlSfrrGtF1I00gWIzXLHXFq/sY94LuKHkUr0eWeOWsh2M0pmQwyo42b/JJSF4jnkEcxdQtAhJALFI=
Received: from MWHPR14CA0034.namprd14.prod.outlook.com (2603:10b6:300:12b::20)
 by DM6PR12MB4482.namprd12.prod.outlook.com (2603:10b6:5:2a8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.13; Tue, 1 Mar
 2022 08:57:26 +0000
Received: from CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12b:cafe::4d) by MWHPR14CA0034.outlook.office365.com
 (2603:10b6:300:12b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22 via Frontend
 Transport; Tue, 1 Mar 2022 08:57:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT010.mail.protection.outlook.com (10.13.175.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Tue, 1 Mar 2022 08:57:25 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 1 Mar
 2022 02:57:22 -0600
To: <joro@8bytes.org>, <iommu@lists.linux-foundation.org>
Subject: [PATCH v2 2/5] iommu/amd: Call memunmap in error path
Date: Tue, 1 Mar 2022 14:26:23 +0530
Message-ID: <20220301085626.87680-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220301085626.87680-1-vasant.hegde@amd.com>
References: <20220301085626.87680-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e53230e4-e008-4f77-9440-08d9fb618174
X-MS-TrafficTypeDiagnostic: DM6PR12MB4482:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB44829E8C52EF90A808D3F49287029@DM6PR12MB4482.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: prwbuV/kNQrt8m315NtPoiBDlpi8HhDErXSfjP8nKtOhBT9Nsrq/+MnpJtcQ/fD1EF91sm+Ddw3MIr7QAcdPP/k5C1on/WIka7bWsvBUC83Tt9CzJpjdSqxwRwqfnTR3JgU2E4N1cdSldmI9ZKYyJWwJ22217lAWkCrR/Edn4qhpNMHWt0gseRIuhiJ/vnt3HyjnxlxEGIBZi9DZupQqO6DRb/jbKQHCnBXzONQueALDAIf1z/ehhADChfZQtQa0JubuxdBoxe3l0LzZtF9F8zfzZ0ZV0A9rWeeN1GYVAk158lI4OAyjb37xS+Q77PmNdIylFDEZafjNJfGztZZuncD5G7YtFHJK9rfRhKvSPxinWKKTQyujKV047FENhaZjYkP8FgPbaxO05rSLG3vEY6r1c5h0wrhRUo9OzNN4UEDHnqIsrw6oBZ2PWszp4jeZrxZjIjEqrtlyshjjWu+h4sf8kgfgF08G87LWEyuDS7+djswcOsklBf6DFK3NN7I4vOxJJS9ztwfsHF6JI2fdCNSI0UGGxZLXICcE9IIlkGGWk4KMT3V6m06IpVvFVxB6skrRTPJOkn1St3tT3rn6FJLVkXJwFaN+az6uoCnV4fU8gESOjHoPzlcOhl/egUMcHW1hhi8xXWJgm933lKXOIKPYSeslgQucbQt4wg/zs70PR64il8C4irwUZ4fbdScsh/z87ZVx7MsvIvIgM4Rb6Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(54906003)(508600001)(82310400004)(110136005)(44832011)(8936002)(83380400001)(4744005)(426003)(336012)(2616005)(2906002)(316002)(356005)(5660300002)(47076005)(36756003)(70586007)(36860700001)(70206006)(1076003)(81166007)(186003)(26005)(40460700003)(16526019)(86362001)(8676002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 08:57:25.0061 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e53230e4-e008-4f77-9440-08d9fb618174
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4482
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

Unmap old_devtb in error path.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 6b5af568f3d5..f7e7d208063c 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -980,6 +980,7 @@ static bool copy_device_table(void)
 				get_order(dev_table_size));
 	if (old_dev_tbl_cpy == NULL) {
 		pr_err("Failed to allocate memory for copying old device table!\n");
+		memunmap(old_devtb);
 		return false;
 	}
 
@@ -1010,6 +1011,7 @@ static bool copy_device_table(void)
 			if ((int_ctl != DTE_IRQ_REMAP_INTCTL) ||
 			    (int_tab_len != DTE_INTTABLEN)) {
 				pr_err("Wrong old irq remapping flag: %#x\n", devid);
+				memunmap(old_devtb);
 				return false;
 			}
 
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
