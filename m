Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D44FDC433F5
	for <iommu@archiver.kernel.org>; Tue,  1 Mar 2022 08:58:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9372140614;
	Tue,  1 Mar 2022 08:58:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u9Lxn2rZm0_t; Tue,  1 Mar 2022 08:58:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 29D38400F6;
	Tue,  1 Mar 2022 08:58:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12EB8C0033;
	Tue,  1 Mar 2022 08:58:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8BEDDC001A
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 08:58:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6D90181A58
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 08:58:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y9UKh4_qFGp6 for <iommu@lists.linux-foundation.org>;
 Tue,  1 Mar 2022 08:57:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::62b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3E1F881A0D
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 08:57:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZkLtqby6BgdQ+1HxesXSv5hMv77aGtEfvUXN/yYyXW36kVVZFwAlJKMccYdS9G6sv8kE6EL4y6ndjnnGH8mizojc2D5IemMOxyRhPHdzdM2K+idLpkGummvrbtpDiluldUNdRkIjdya8I/YxnjI/60qxtHqLjcXnVUj620pno5OBPlVNJpGpBlOVuHHSFgx3e/0xBtuDUYAQqSyppKcCop4xmVSTRM4jH+ybZn/KkR6TeG6n2GC40vQjMwGXguvmdlbnY0PL/plR/rjqThFaodlYKZi4fEn7xg6qs7dj3dSzwU66z3qwOkmeZiH/pB1RnsuZ+WydcCCFRT2FF+nQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QGv3mt6hDqH1o6ob5wPGBukKPCmhjCR6wVnIHcMiuvE=;
 b=KXYy0iMM50loKyc+EF1ml5BCtwAb+mPriwVemshCQCeIWP/vhTl5KRRdZ5jjFXAPYlaRa+FewthmxLBILI1nS63AQr/ULB2Rtzadlb/IIEVe60ZeotevAHNd8j4iuQcp+y2S0mQpGAn9BaQ6V7HGk9yu3TX/ToPqe3UAAa04ZCSvGr/fgfYrRzMVtk0J4/ITm3dhXHK147Etzn5GPZ+HYwpr06MTytSvm/SaqIE9aG8HoGFp7+/9xBFzsvtZGEdFNz4A8LP3n8yc6MZSXsLBU7qgl6RfTTje0ttONvrQcsLiiqRGc/WonD0tQPQSmL0Gm0WnJKzq6hEWQAylXhOInQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGv3mt6hDqH1o6ob5wPGBukKPCmhjCR6wVnIHcMiuvE=;
 b=1gL22qmd66dLhjCuR+0od/p76UdJAsZ2l9MDFleCM8yKbDja1DliltQac5sBIUA+Nuhl15J3sTQmxFBPlN7EDzlGwnGTUwmtP2Q8rQ/7B5hcrxOpII6xFMtBx4OsA0MtFNAsWOJ4LUBsvcoZToELyJSI75B7ynfKA/dyryRyx6A=
Received: from MWHPR14CA0008.namprd14.prod.outlook.com (2603:10b6:300:ae::18)
 by DM6PR12MB4251.namprd12.prod.outlook.com (2603:10b6:5:21e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Tue, 1 Mar
 2022 08:57:56 +0000
Received: from CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ae:cafe::3a) by MWHPR14CA0008.outlook.office365.com
 (2603:10b6:300:ae::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.13 via Frontend
 Transport; Tue, 1 Mar 2022 08:57:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT021.mail.protection.outlook.com (10.13.175.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Tue, 1 Mar 2022 08:57:54 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 1 Mar
 2022 02:57:52 -0600
To: <joro@8bytes.org>, <iommu@lists.linux-foundation.org>
Subject: [PATCH v2 4/5] iommu/amd: Remove unused struct fault.devid
Date: Tue, 1 Mar 2022 14:26:25 +0530
Message-ID: <20220301085626.87680-5-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220301085626.87680-1-vasant.hegde@amd.com>
References: <20220301085626.87680-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5678c5f0-f250-43c6-69d7-08d9fb61932f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4251:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4251EE8CA9D0B387FD3BB83287029@DM6PR12MB4251.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xeoIG5p1Gg4OtirMPFw3d/lHpIp1+5PJJZwMVwIqhsOk8CYVh/2n5zJsbonCCANenXdx8EsoHFjTY3ShnIidr6dTtAZuiGW+kgHjW+1OIi1+/Sf6oWv/EJviRB3/8I8pv6asyCnjxY2qkl+p2dA2F5QoUH3+8IQ1+7Y1IfGXW4JOBQBnh4ca3+y+RoTtFn9mvwsGe0HQFk3lbIyrwkXDMGcNrn+ZVdY1RdNT9Mr9qtrGRTg+nL8up0cegoSxkFhgcqNxl3mtjV5ptfh3Jm+Lorj9IGarrbPuNBVvSAg+2RZWqBkDjwY9yvvG+zBE4Jak1pBr+4hK15gQtVn2nonzxQQwQ2pq8YrC667CQTC19Mn5uhyODuf+Ty4L/ARIvMqM1JFE2TCRbeRGFzY0HiT6Ow5vIGS6tvxb4/sYKO2bQvLwWDGrVdeCoiODbCZUHremaZ06SH3CHPaPP+77EJODu+8xNcC0UvrODvsZTHv+/QPrYzlNKSzPJQfpnummJ6QU5eCeH2elZTPMSLI6BoFEEZIgZ4sWmp3tpYSMxy2t6qatyTXdEKo/YusgIDa7dozGn+9rgc8xBQNY4J1CuxmOgFPanLuTuTXJ4nB0qEqeDLMbfUbBOD3pJZ5Ivd6pTDibHH6CRIZefIqQCNSsRFcqD//GxL6FD7wctf/goZuwpe2GDP/EQeeYB5hcE8Qx3ZLMEMms+rpUsdEQM8dAqIWDcg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(6666004)(8676002)(16526019)(36860700001)(316002)(83380400001)(54906003)(70586007)(70206006)(8936002)(47076005)(4326008)(44832011)(5660300002)(2906002)(86362001)(40460700003)(82310400004)(36756003)(4744005)(81166007)(356005)(508600001)(426003)(1076003)(336012)(2616005)(26005)(186003)(110136005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 08:57:54.7518 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5678c5f0-f250-43c6-69d7-08d9fb61932f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4251
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

This variable has not been used since it was introduced.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu_v2.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
index 58da08cc3d01..2daf37c21b85 100644
--- a/drivers/iommu/amd/iommu_v2.c
+++ b/drivers/iommu/amd/iommu_v2.c
@@ -71,7 +71,6 @@ struct fault {
 	struct pasid_state *state;
 	struct mm_struct *mm;
 	u64 address;
-	u16 devid;
 	u32 pasid;
 	u16 tag;
 	u16 finish;
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
