Return-Path: <SRS0=xT8t=45=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFE8C10DCE
	for <iommu@archiver.kernel.org>; Thu, 12 Mar 2020 10:33:20 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C999A206BE
	for <iommu@archiver.kernel.org>; Thu, 12 Mar 2020 10:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="P4ySLXby"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C999A206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 777D789409;
	Thu, 12 Mar 2020 10:33:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rm7ZHWGgiNcK; Thu, 12 Mar 2020 10:33:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 74A49892A3;
	Thu, 12 Mar 2020 10:33:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 59AE4C089F;
	Thu, 12 Mar 2020 10:33:18 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 289E6C0177
 for <iommu@lists.linux-foundation.org>; Thu, 12 Mar 2020 10:33:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 20660858D3
 for <iommu@lists.linux-foundation.org>; Thu, 12 Mar 2020 10:33:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a9VceMtuNDqF for <iommu@lists.linux-foundation.org>;
 Thu, 12 Mar 2020 10:33:16 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 6560B857D8
 for <iommu@lists.linux-foundation.org>; Thu, 12 Mar 2020 10:33:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDZt+iHHio6cWFe34nWTGsOAk6v4QZopK722UgTKnvlA9jv+B+gtmPQEcqN4NcgXIG7Ej+p1BxHJ0epU3GSjmHHf+X+5BwikvcakC9EvFfpWTsAoqoum/HMaMJrF3c9Gq2Mw+WuympMdbmfX7+ZOrHWay73heeNyBp/e9ZqVxlXlkxpWO0GkpZ7CUsCa/2BinVpZ3k27G+E1qBLgjcPp2J7JdnL9TqvQF9c0fhCIOiyztHUDL+gh/n1SLEX5P06dNN9jdvPB8rXU9oOJZRIqoqBr54r3QXWd3OyZzBkr93KvWkvbYw71TFlBQz9vnSn35HE9jP+iJMnvnV8ocTwuEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fA+fA4u5rLgi/wHClXRJSeW2LEF3HFtXLtUbdXmLOYg=;
 b=nsTWcNESiDxL5S2w8HAgFMkjUrHSe9oDMfN0abNCyhqiELC34gGlSrZa1iHEETPc+RSCvgVIBlek2D35UKVmwCTEuV9wTCDHbyCZ9eKyhb0sKR/d+ODhTk1HF8dFN+wRDHAvqQCQyQ1qLl2zg6YncVkyYsvx7cuM9n/tPuCw8dV9C7F2gXk1k2d83ZLGzpGvpqmko8E7bA0G8Yjr0ng9RCGZYkCb8NBqCXY1pPlReJcU4X/upPQjkeIiITSuh39tbm7AsXEKN5N8RwbhUTPSvBFVKQLkdtldW/BXgY3xrpxsAsds5wum07hcCYm4xI25uHD6zKxN+MvWNqOy3sDULA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fA+fA4u5rLgi/wHClXRJSeW2LEF3HFtXLtUbdXmLOYg=;
 b=P4ySLXbyP+EKzz8wOL2cQJg4uAdR5kJcX4XMzLN+Nj5tc/gYbt8pLek0DG9sYRZ+b+Q3T+92OxpnxBGfDpF2fConkraVzicOq/EF/k0edupMtkQYONn7g78mfyWE6BKZdDrORkFEEriTjSCRdZm7Ay/lmoCg3mF2UMYpvyivuCo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
Received: from DM6PR12MB3865.namprd12.prod.outlook.com (2603:10b6:5:1c4::14)
 by DM6PR12MB2985.namprd12.prod.outlook.com (2603:10b6:5:116::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.13; Thu, 12 Mar
 2020 10:18:54 +0000
Received: from DM6PR12MB3865.namprd12.prod.outlook.com
 ([fe80::2d84:ed9d:cba4:dcfd]) by DM6PR12MB3865.namprd12.prod.outlook.com
 ([fe80::2d84:ed9d:cba4:dcfd%3]) with mapi id 15.20.2793.018; Thu, 12 Mar 2020
 10:18:54 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH] iommu/amd: Fix IOMMU AVIC not properly update the is_run bit
 in IRTE
Date: Thu, 12 Mar 2020 05:18:39 -0500
Message-Id: <1584008319-13594-1-git-send-email-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 1.8.3.1
X-ClientProxiedBy: SN1PR12CA0077.namprd12.prod.outlook.com
 (2603:10b6:802:20::48) To DM6PR12MB3865.namprd12.prod.outlook.com
 (2603:10b6:5:1c4::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ssuthiku-rhel7-ssp.amd.com (165.204.78.2) by
 SN1PR12CA0077.namprd12.prod.outlook.com (2603:10b6:802:20::48) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.16 via Frontend Transport; Thu, 12 Mar 2020 10:18:53 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5f2f9951-3c51-4782-d67c-08d7c66ec470
X-MS-TrafficTypeDiagnostic: DM6PR12MB2985:|DM6PR12MB2985:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB29850A8ABBA38023F83E1014F3FD0@DM6PR12MB2985.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0340850FCD
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(199004)(2906002)(316002)(16526019)(81166006)(186003)(2616005)(81156014)(8676002)(8936002)(5660300002)(956004)(26005)(36756003)(44832011)(478600001)(7696005)(86362001)(4326008)(66476007)(66556008)(6666004)(6486002)(66946007)(15650500001)(52116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2985;
 H:DM6PR12MB3865.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 18jrOmPxwG4GMrA4VhXsRA6t0rvekoyNTMd0hghyEbRgogCmeH24yCV2vlfffyN0S7Kt+xyjWZY3rBW/Q2JrMmEYYwumreZ3fAMqP3/5joGJO55fhya5GosNiLj9BI6nhr+D3AIdNngcgpYWWvpj9BW0CgShuPxMLtiHp11/I1Nwn/a7LBny86kAuHCq3nTqTimgJKvZuWxI5MKPGzYnUTprfOmFNOWQRnPwiM/EOYGTEEGTO/1QGTFv6SA6hF/WnER3/rsRYOKl4Q9guPPaj4M8u6bWfQvzm1JCxounCr6pxgtuh4i8Mz67nFMyAeX/wmpj3NI6DsWamyu34p2MnzXuF5EiFknkcemdIH5SkekgPqR2c1sZnvVVQe/B1sZd7Ld1nO7zugBmIQLcSnC1sWnoG2+plsZAqw/icnYDuEITx8lMQn/HEbHHjtAC3LKL
X-MS-Exchange-AntiSpam-MessageData: AxoO+uL6KgJ4U81MdLNOb7YkMmvjkGeMBPV14fAp9VImEd3wAn6Kc9lSMBBOCK+XLsXXq5Ko9sY4b0h/qnxVBD9d7JT5Hx9YTp4mdGvdjYrZcdg94+Uja8inpdwGZ3tOLNvL0b0I1wCdFntdHEpJ8g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f2f9951-3c51-4782-d67c-08d7c66ec470
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2020 10:18:54.3354 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ulmzhlrdfOHj5V3cs4GFh5Va2lIX5BcAjmhPrRS3eJWjnO53Jz/s9Mdow+ZpgxmZXNoKScLwhPvFyGx9nCN5QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2985
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Commit b9c6ff94e43a ("iommu/amd: Re-factor guest virtual APIC
(de-)activation code") accidentally left out the ir_data pointer when
calling modity_irte_ga(), which causes the function amd_iommu_update_ga()
to return prematurely due to struct amd_ir_data.ref is NULL and
the "is_run" bit of IRTE does not get updated properly.

This results in bad I/O performance since IOMMU AVIC always generate GA Log
entry and notify IOMMU driver and KVM when it receives interrupt from the
PCI pass-through device instead of directly inject interrupt to the vCPU.

Fixes by passing ir_data when calling modify_irte_ga() as done previously.

Fixes: b9c6ff94e43a ("iommu/amd: Re-factor guest virtual APIC (de-)activation code")
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd_iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index aac132b..20cce36 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3826,7 +3826,7 @@ int amd_iommu_activate_guest_mode(void *data)
 	entry->lo.fields_vapic.ga_tag      = ir_data->ga_tag;
 
 	return modify_irte_ga(ir_data->irq_2_irte.devid,
-			      ir_data->irq_2_irte.index, entry, NULL);
+			      ir_data->irq_2_irte.index, entry, ir_data);
 }
 EXPORT_SYMBOL(amd_iommu_activate_guest_mode);
 
@@ -3852,7 +3852,7 @@ int amd_iommu_deactivate_guest_mode(void *data)
 				APICID_TO_IRTE_DEST_HI(cfg->dest_apicid);
 
 	return modify_irte_ga(ir_data->irq_2_irte.devid,
-			      ir_data->irq_2_irte.index, entry, NULL);
+			      ir_data->irq_2_irte.index, entry, ir_data);
 }
 EXPORT_SYMBOL(amd_iommu_deactivate_guest_mode);
 
-- 
1.8.3.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
