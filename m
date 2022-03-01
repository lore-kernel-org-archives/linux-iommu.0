Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A75C433EF
	for <iommu@archiver.kernel.org>; Tue,  1 Mar 2022 08:57:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AA90E60E77;
	Tue,  1 Mar 2022 08:57:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VUTMxkq1fNFs; Tue,  1 Mar 2022 08:57:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7F2D960C1E;
	Tue,  1 Mar 2022 08:57:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 59374C0033;
	Tue,  1 Mar 2022 08:57:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C7FFFC001A
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 08:57:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B58B94016C
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 08:57:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1uI39MUZmB3Z for <iommu@lists.linux-foundation.org>;
 Tue,  1 Mar 2022 08:57:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::62a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B4223400F6
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 08:57:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Su6BN6kiFfwiD52SYkaKuFH08iETj3+Ry/OKhixf7C9mQOVLuB9QWjMt8o2f+mi/4MkIp9Xe2Q59puKPTjukBVGYgg6bUNLFi9lwcETvdCtwb7TQddKhfADaYSAqxAfQSjWUFUUmj7loU+iGIImJvw86mUsy68kuTZPHSaRlq9VqODtHNcKODRHld7KVZNRSKFKE1g6RYt+rL5Ae5en5+uaFhIpwN53p3QqPMy/4Jjh7fkTGBSjsOvmrh1CtSKWaD8ysJ5r/mAvfMmaezM1RAyHKuFEikW71Ky6UjZk2LQm7QinqLpTvM9KSWKAAZiUtMNYQ/F2aMRnHlprk+zFOww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DFoGMDE1eF0sGHG0u5JqSJc2Adc0njuwaTLfl/efYHk=;
 b=bE/nlw4Hx/fnHZsSUNC6RWBTXUCzj8gDkJ4Cp8kb+INNOw4gsKLLYYUlUwsbsmygWLZXIM2LHJELFa5nnMswkdeTc02pkFzwxETjzJBKjtYTO8/Z8pUSOuTFtKV9R1LfiL4W4GBgIYFcDlRnkO14zieg13hyPId5qrrtVDPtab7KuCq91So68noyosUR81rIdj/SbuFzzuLEBJMvxLXgmlhIBSiMZx1fBvXBOxqzskbhD96OiV6oKjpMtfLtiuOtlHdP057H/7ePDvj8WEr3VBnEPuDW4AqhcqxLvRnft7cszKBv7qaGVLzo+NYPoODuDVHraO+XbEhbt35Bz7ZBNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFoGMDE1eF0sGHG0u5JqSJc2Adc0njuwaTLfl/efYHk=;
 b=Jt1FEgTOqvTBD6tnVc63nDxg6wYPzeViZ/QRttLYOMO3pIAx9XAfKpt5WAsVfWFl+nw+jQOL2321T+fnONy6K0D3wEFQE/Sld2EOIh0rQSUcaT2Yincfxh4YhZHbf+pAMH1xEQ/qYoMKxyKpDq5iNc7QXxe1Pg9pDT4zlqX1vWU=
Received: from CO2PR05CA0107.namprd05.prod.outlook.com (2603:10b6:104:1::33)
 by BY5PR12MB3907.namprd12.prod.outlook.com (2603:10b6:a03:1ad::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Tue, 1 Mar
 2022 08:57:10 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:1:cafe::a9) by CO2PR05CA0107.outlook.office365.com
 (2603:10b6:104:1::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.10 via Frontend
 Transport; Tue, 1 Mar 2022 08:57:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Tue, 1 Mar 2022 08:57:09 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 1 Mar
 2022 02:57:07 -0600
To: <joro@8bytes.org>, <iommu@lists.linux-foundation.org>
Subject: [PATCH v2 1/5] iommu/amd: Improve error handling for
 amd_iommu_init_pci
Date: Tue, 1 Mar 2022 14:26:22 +0530
Message-ID: <20220301085626.87680-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220301085626.87680-1-vasant.hegde@amd.com>
References: <20220301085626.87680-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 096fae43-fc64-4f57-5117-08d9fb617836
X-MS-TrafficTypeDiagnostic: BY5PR12MB3907:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB39071831CF547651FF5D3DA687029@BY5PR12MB3907.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v5ewGROH+xzFUzsLdqAT7akhWPz8XJkEYRjqnkSWvJvtmn2RZLoYKGQKPB7K6+mP4AWYyD+MkSwHy6mzBF3yFZxYJGENKXGT7byfhpAD8X7T9vuDI6tfKLHZML7DuWbQhuuwxDpiZktUfV1t420CJVg1Us38Vw68JCOhvDJEDnKr3H1SlgioJ8W0WZsggql4nLdjKpEipvecRZabGKSBnI8ZsmjbG6M/GMjpOfFcOZcMGAzSI2hoYPCoiNZhRnf2zmVs2Lj/HZbPzCa64iYwrAhg5fVsItht/A1rYpSbAxsEB7G23uhP1axToCufSxLqjZsFTI4fujXEleL3nwHVkBm0Vr1LubkDlwm/WG9HOoBeODwGEb/rVmArEny9nDabdI5bHzhbpGK133XW0k9ONz60WNHVDfnGEg9nmDCLftPWw+nbrX2HC6pcFT1MuMO1tPZniCcAdqUBUVuQTYgGTH/aYse/caHVvJQhu8wanmhS7J/Nd63fZgtWv7DhhB4L6l4U4W/WSnlADuWhKgijEbK1SdBssLfzJt1T/pmoOWHK1AC0SV0t3I/89NTtNWIAE7int57aDX5j5Go5+ptL/Qp7SOYLi7lRWeH6XETwsayXOygPn667CdNBYxgini2vRUTLezmEv40qsPgXmrU5Qt39SUfQ2iNdlE5AUClwIY1jIutSWrGRy2axaDWGHnXbcHp5MXKjtTlCL0OIDaLesQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(44832011)(186003)(2906002)(2616005)(508600001)(26005)(16526019)(54906003)(5660300002)(316002)(110136005)(4326008)(86362001)(8676002)(82310400004)(83380400001)(8936002)(36860700001)(70206006)(1076003)(356005)(36756003)(81166007)(70586007)(426003)(6666004)(40460700003)(47076005)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 08:57:09.4986 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 096fae43-fc64-4f57-5117-08d9fb617836
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3907
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

Add error messages to prevent silent failure.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/init.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index b10fb52ea442..6b5af568f3d5 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1943,9 +1943,11 @@ static int __init amd_iommu_init_pci(void)
 
 	for_each_iommu(iommu) {
 		ret = iommu_init_pci(iommu);
-		if (ret)
-			break;
-
+		if (ret) {
+			pr_err("IOMMU%d: Failed to initialize IOMMU Hardware (error=%d)!\n",
+			       iommu->index, ret);
+			goto out;
+		}
 		/* Need to setup range after PCI init */
 		iommu_set_cwwb_range(iommu);
 	}
@@ -1961,6 +1963,11 @@ static int __init amd_iommu_init_pci(void)
 	 * active.
 	 */
 	ret = amd_iommu_init_api();
+	if (ret) {
+		pr_err("IOMMU: Failed to initialize IOMMU-API interface (error=%d)!\n",
+		       ret);
+		goto out;
+	}
 
 	init_device_table_dma();
 
@@ -1970,6 +1977,7 @@ static int __init amd_iommu_init_pci(void)
 	if (!ret)
 		print_iommu_info();
 
+out:
 	return ret;
 }
 
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
