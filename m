Return-Path: <SRS0=eAvY=NW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB69C19F3A
	for <iommu@archiver.kernel.org>; Tue, 31 Aug 2021 03:07:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D0AD61027
	for <iommu@archiver.kernel.org>; Tue, 31 Aug 2021 03:07:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5D0AD61027
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3958481D72;
	Tue, 31 Aug 2021 03:07:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 803mYdGeJYe9; Tue, 31 Aug 2021 03:07:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E8A5E81CFE;
	Tue, 31 Aug 2021 03:07:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D27F5C001A;
	Tue, 31 Aug 2021 03:07:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6E81CC0023
 for <iommu@lists.linux-foundation.org>; Tue, 31 Aug 2021 03:07:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 512CF404EB
 for <iommu@lists.linux-foundation.org>; Tue, 31 Aug 2021 03:07:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CRCRqj19gR57 for <iommu@lists.linux-foundation.org>;
 Tue, 31 Aug 2021 03:07:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C1C6A40505
 for <iommu@lists.linux-foundation.org>; Tue, 31 Aug 2021 03:07:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lRAjFHtIiLAtceqKY9vQeR1QXUQikKsuG6cI3yM2QDna/TJOKDVPK6276DVpgyzdNg/UxfAizyJ5HONwqVgHDfaZvT2bUxAE8w/lUGB6q4hJF3+8QkkxGDnIHlG+aiGeZ5Ow/BSv91QmQRblvOmRRRBR3QFk8HstJCVqHCDZUmDote9MAyrSScbsrq6jJhaAjSpC9L8EsIo+sXsG02tlizT14BlmCTxCwvPzrO2Om1qSwl1pClhukc4QtYf5JNaSLKGp7bQZmPkUahnQrwX3otPWsLtgsnwyYP8qHGGkwxJSI//KMfXT3v4izeAuHhxpZ+yLR6mZdOt96KLMdYBRWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rsd/aOCmTv7NJzSefqxt+kl1bPhMXkxHqLxaSkyIUSs=;
 b=REcGsND0JMzWrcMZtNLNSVUl962U6NyBsP6AOAWjlCwDXQrRseOQHusR+BvRXSOkoyFEiHEj0SKjR/qiv6tN6ro2pa9WpteEmc0Hwu8A3AVrEe6CXk1nRZkC6ISrhojPf5ifhYRhB96WjG87GQw9SAviWpC8r9Pa3qfC6a4riQ161gA7Xuxx56p+91D+bWG2ZxX0XkkmbiXM+SJD3ztS2/Amn3QTeTjgQ6oz5wFlvCP9V/IqESRipbsucaWIPPcT2JXmf5YXyE46da6yr0NFST3qW5KpJUbK6aocyNwfK5nJ+XP0lKpfX+IbLHS1SBfnK+oVaZwcvLLzvEUoIJsABw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com; 
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rsd/aOCmTv7NJzSefqxt+kl1bPhMXkxHqLxaSkyIUSs=;
 b=KVJvE/3WDPj9BPKyCpU3oUWdCSniSGKFFlDd6PtCfFkl2w0p43aqqBflXNB+aaPfQD/g+F1PUrhkSXd4EQpC+XH41FRWOFt/0/1pBfi9Z4KJy4u+9pr3dE7noFEfrCRVIdrEwg4S773rOkfT82Ucwiz5pl/tYnEaXPUXJb5KaQw+IBBMOgovbXSuTEByRVu3dIEW6cT1wd6lsS2oc7skXubggc3kKDqS53dW5/k6Myh8WL1xYJYH6c1tS0Ip17KV/GjiSbEBTkdV77L+c7/u3FQ9tFHYlJFjrWioI+f/oFCPk/7gDoig32he+8+nfa5lKEBY0Ul5H5Fe6EoTwMn2mQ==
Received: from BN9P222CA0015.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::20)
 by CH2PR12MB4152.namprd12.prod.outlook.com (2603:10b6:610:a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18; Tue, 31 Aug
 2021 03:07:34 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10c:cafe::11) by BN9P222CA0015.outlook.office365.com
 (2603:10b6:408:10c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20 via Frontend
 Transport; Tue, 31 Aug 2021 03:07:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; 8bytes.org; dkim=none (message not signed)
 header.d=none;8bytes.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4457.17 via Frontend Transport; Tue, 31 Aug 2021 03:07:33 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 31 Aug
 2021 03:07:31 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 31 Aug
 2021 03:07:31 +0000
Received: from Asurada-Nvidia.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 31 Aug 2021 03:07:31 +0000
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
 <alex.williamson@redhat.com>, <cohuck@redhat.com>, <corbet@lwn.net>
Subject: [RFC][PATCH v2 06/13] vfio/type1: Set/get VMID to/from iommu driver
Date: Mon, 30 Aug 2021 19:59:16 -0700
Message-ID: <20210831025923.15812-7-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210831025923.15812-1-nicolinc@nvidia.com>
References: <20210831025923.15812-1-nicolinc@nvidia.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a09877aa-f991-4d6e-689f-08d96c2c7a8c
X-MS-TrafficTypeDiagnostic: CH2PR12MB4152:
X-Microsoft-Antispam-PRVS: <CH2PR12MB41523517FAADA6BE750F473CABCC9@CH2PR12MB4152.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: losxrnb1ekjzvMX1p/nQBRzyaVtmXHCz6HJYGXufWjDWyAXYZjyLZ/I9Qz74auwBiYobFq4+xfJEQ9FgGiFupz8mYcu5EIJYEYF094waFOzVDeQRtVWCa1e5hpc7Cp6Kqx+4J0QYgljAh/laruVqdMbKdqynwuemZLfiGXVnxMptGdMdE4KMJzHpFNsc5V+DaTIKH1vafacqZNcS7mq9H0squDtY/WSj6FkJkIy6CzX35jn/YLUUhPb5GXbEA0Jh1zS0274J38TNzkeuyIm3GgCc/gIWw6vVRNRYt3nh3NpdXp+0G0GGfQQnaWTIW9LIP09OxIcFUbWQWg/yPfIsfFYT2ML6jQO036I3mINMI09uk0J04t48J4gBMdUNUjemX2fkj7wfcpQNUvY9XWSvXbv5kf0AaTDkFvWbXnx16OmnaJn/AuYqFd/TLV7WO2rrknlsqUTwE39O+KULMFNj5Ewo7gKmtt7xwZvKtJRxhEs68Amyq3M9diggQue/LQ+hLonhSlMxqnVpw4gBMxUBk4pBQyQXwqIvMGe3IbvN3VytF/X7Yk033796DObUplkcJ3C3MR0Oa9zBUNO6DxXab203IlNJUMt1QzUjT+Ej4Qzae0ReUbhSyKBkoQE+ksGwiMUF3CIZ5W2KxEDbkF06urvHzltCFUA69mKMMOiVG/0yv+D/1htBW00uAan6RGa/3Gflh82PbpRLtNbj2UWL7odJ7UwdGhqWgKV/VPthhsM=
X-Forefront-Antispam-Report: CIP:216.228.112.35; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid04.nvidia.com; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(396003)(376002)(136003)(36840700001)(46966006)(5660300002)(2616005)(82310400003)(7416002)(26005)(6666004)(186003)(336012)(1076003)(426003)(8936002)(8676002)(478600001)(7636003)(82740400003)(70206006)(36906005)(356005)(36756003)(110136005)(36860700001)(54906003)(2906002)(316002)(4326008)(47076005)(86362001)(7696005)(70586007)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2021 03:07:33.8349 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a09877aa-f991-4d6e-689f-08d96c2c7a8c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.35];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4152
Cc: jean-philippe@linaro.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 thierry.reding@gmail.com, linux-tegra@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
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
From: Nicolin Chen via iommu <iommu@lists.linux-foundation.org>
Reply-To: Nicolin Chen <nicolinc@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

This patch adds a pair of callbacks of iommu_set_nesting_vmid() and
iommu_get_nesting_vmid() to exchange VMID with the IOMMU core (then
an IOMMU driver).

As a VMID is generated in an IOMMU driver, which is called from the
vfio_iommu_attach_group() function call, add iommu_get_nesting_vmid
right after it creates a VMID and add iommu_set_nesting_vmid before
it to let IOMMU driver reuse it.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/vfio/vfio_iommu_type1.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index bb5d949bc1af..9e72d74dedcd 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -2322,12 +2322,24 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 		ret = iommu_enable_nesting(domain->domain);
 		if (ret)
 			goto out_domain;
+
+		if (iommu->vmid != VFIO_IOMMU_VMID_INVALID) {
+			ret = iommu_set_nesting_vmid(domain->domain, iommu->vmid);
+			if (ret)
+				goto out_domain;
+		}
 	}
 
 	ret = vfio_iommu_attach_group(domain, group);
 	if (ret)
 		goto out_domain;
 
+	if (iommu->nesting && iommu->vmid == VFIO_IOMMU_VMID_INVALID) {
+		ret = iommu_get_nesting_vmid(domain->domain, &iommu->vmid);
+		if (ret)
+			goto out_domain;
+	}
+
 	/* Get aperture info */
 	geo = &domain->domain->geometry;
 	if (vfio_iommu_aper_conflict(iommu, geo->aperture_start,
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
