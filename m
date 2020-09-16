Return-Path: <SRS0=cHis=CZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F5AC2D0E3
	for <iommu@archiver.kernel.org>; Wed, 16 Sep 2020 13:53:14 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FF142224E
	for <iommu@archiver.kernel.org>; Wed, 16 Sep 2020 13:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kYizlq+q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FF142224E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7DFED8735C;
	Wed, 16 Sep 2020 13:53:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XMm51mQtyKx0; Wed, 16 Sep 2020 13:53:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D94A98735E;
	Wed, 16 Sep 2020 13:53:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C23F6C0888;
	Wed, 16 Sep 2020 13:53:13 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2F2D1C0051
 for <iommu@lists.linux-foundation.org>; Wed, 16 Sep 2020 13:53:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 29C062041C
 for <iommu@lists.linux-foundation.org>; Wed, 16 Sep 2020 13:53:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XOm8dCy1ru57 for <iommu@lists.linux-foundation.org>;
 Wed, 16 Sep 2020 13:53:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
 by silver.osuosl.org (Postfix) with ESMTPS id 70E16273CF
 for <iommu@lists.linux-foundation.org>; Wed, 16 Sep 2020 13:53:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f7ohVx84CZqGnQd9ZNg8kSQ4FI+57pnVXXQpNmaje6QQ/MKb95A2Sd9/zMo5k/NVXwq1DXRO6lFjAvY9DPNrePS0MyJm5QnjpEXmFsfN18FYkNvHLBgGDD2EvGeO9QT8ZnxcpKIW97xvtLa6wbE7cg3q+oDQi2rWU4TszABgTyv2O+nlI1Mxkoxs72AlewXooVtPmolfJfikD/fnaBBGYVg4+3nQh52XlFi/8bJzEbeEuUQkFi47dtX/8Pr/+caXNRECXndW76akUD3RTjXEJpJ9yQdRFlrFMfzGlVAbDWuqo0JLXy7LxmF9TiEbuV+NOZpOTTc8AT6UBsDjT6k0aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smE8+AIfqauQ4YA7bahAZF1oKXyQW6Pvf5YxuIURUbA=;
 b=hCJ/QwOlmFEr56ua6oPlWp9bIwrsGNeKtY5gW0ezferXk+kGeXvnmtUo67XyIs+W3DTFDC78ZD1tAh+KtO2lt7ZtOiuZPqPPBuzPOw8EB/odOU2VVHsSCTcfnOQVMbmJ9CDIMV+Vni7QKA1dFYFtZ+L5SMJTW6/BIJQx3KJgWK4UiDoG/TnPLz4FXNdhvQFGpJQomQWd6fIrIL3j0I8SEIZc4HzSG6mKHaZNSIA5/W2uFY8tppjqbessZDwxazJtqRJjXe0MMluaQwcH9n+HkiHoAjXRoinbjl5xSux5Yt9kBHSWBiPwEfiG4gRKtqMLeROT4AXGuSRUqHEYFVGSew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smE8+AIfqauQ4YA7bahAZF1oKXyQW6Pvf5YxuIURUbA=;
 b=kYizlq+qAFFpS8BiYM1equma820W1O+DPedn0//FvHTJrgp8dRj4PHjplpydH8i1O/3CPtzjUa1TjJ3SsOkcm+yTyo1tj6+bDUoYeZxlm6xGDlqN00AE3prQA1e9+qhHIB8jNrtR0K2eaSBsT4++Yh6E7w4jguwK+wRA5kPqN4M=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (10.168.240.18) by
 DM5PR1201MB0123.namprd12.prod.outlook.com (10.174.104.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11; Wed, 16 Sep 2020 13:53:08 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e%5]) with mapi id 15.20.3370.019; Wed, 16 Sep 2020
 13:53:08 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH 3/3] iommu: amd: Re-purpose Exclusion range registers to
 support SNP CWWB
Date: Wed, 16 Sep 2020 13:55:49 +0000
Message-Id: <20200916135549.146468-4-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200916135549.146468-1-suravee.suthikulpanit@amd.com>
References: <20200916135549.146468-1-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: SA9PR10CA0011.namprd10.prod.outlook.com
 (2603:10b6:806:a7::16) To DM5PR12MB1163.namprd12.prod.outlook.com
 (2603:10b6:3:7a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx5673host.amd.com (165.204.78.2) by
 SA9PR10CA0011.namprd10.prod.outlook.com (2603:10b6:806:a7::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16 via Frontend Transport; Wed, 16 Sep 2020 13:53:07 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e35077a1-5002-48e2-9b48-08d85a47d7ba
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0123:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB01237E2D690BB8997941BD55F3210@DM5PR1201MB0123.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bZKOXM6VX8Fg314Pp/UVXFVMueXRJAYgeqMfTi1l/ibj6u5PZoz+G3ySBdR+zWzufBSM+9dnSMOhYhu432VolL6p6qeMI0wN5gc5Ky7JZiP8a8STEZHgaaKWTnm4I52lIaP66RHx0WiXIKyaH2WRCmbkEoR6LOHFDFGYLGo2kaRbhpC0XWAopt6uMmWRPad1CXHxWyrpXcemM1w+MgO8Y2t2HfjD3/F1ah2AHtUi7EAcEK3iJ4jXDuv8nUFInCrjvqaOe+MxSHRU74aFdzLAuogWV1R/MN4mPbXa9pFU1cVxfrRGgvQkkxARowH6GvjqyZ06qcHYUlx3t5HWsxzsJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1163.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(186003)(956004)(2616005)(478600001)(44832011)(83380400001)(26005)(16526019)(6666004)(4326008)(8936002)(6486002)(316002)(86362001)(66946007)(52116002)(5660300002)(66476007)(66556008)(7696005)(36756003)(2906002)(8676002)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: HGrX1FVhbvwUe5C0FgVJXOK+p+dt6dLj0pQROjBkwgwujJlp/cxJiGZ4Z+qJItA3fCWXUQUuslz46wESXz1Ir+h4DgAWD7WzKZ6hwJAx0Ym8Qf2lSGIHu7LheeXbpMrYPXkfuuvM34xecQFXbJCinqL5ereirPnPE2k42Josb8gMLJmN4JUdrTlSVXr8j8ewm2LLowmCaG/g+iFs463uVOsqfXz1UvS+i+HUZv0jxluf0Dr5ujr/KcFjCpfwq59Sj0a00oGgOQarBYgAZR50Ygm/CVaGd6wiHSK6L40BYwMkjdq0adi6XsCT1fEmcbJCFSvvhzVoe/TZLL+DHwd9MyZdMoLDfVQZZa8Pm/PtlvhQgtqHSyMSKPTALXGB3KNAU0Agx/TgsI3ftX4sCVFRG15VjasJPik7MIUtt877TXnMSpibB5Q9JY7cE19c4tu3S7fRENjkJsN+QE0kKhqA7KRGjvxCr0vIkgsCSmXRjVuVEYpuVWa/fhPwlLbNOpuVOHSzitOjrqoMfTZVWWlG1l3gwQz1Z0QdB9cmB7VXf6wG67f+thQPmwFK1QWLxqpnEFWTo+KTGvuxRT8gu4qRbtyiZi4hbiK5cM7jHBT/uax4yx1ylas+gb6rU63wWvXaFFCSlo+1I49oQx5AwvQXYQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e35077a1-5002-48e2-9b48-08d85a47d7ba
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 13:53:08.6451 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SkloeaZGXCRS/2YFFF0Ldtvc1S8iLU3TYtQKgAXRX/FJKuTuHz6ZeT3ZRzIdq49jaeFZdBcVOyklxBspLLI3Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0123
Cc: Jon.Grimm@amd.com, brijesh.singh@amd.com
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

When the IOMMU SNP support bit is set in the IOMMU Extended Features
register, hardware re-purposes the following registers:

1. IOMMU Exclusion Base register (MMIO offset 0020h) to
   Completion Wait Write-Back (CWWB) Base register

2. IOMMU Exclusion Range Limit (MMIO offset 0028h) to
   Completion Wait Write-Back (CWWB) Range Limit register

and requires the IOMMU CWWB semaphore base and range to be programmed
in the register offset 0020h and 0028h accordingly.

Cc: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  1 +
 drivers/iommu/amd/init.c            | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 1e7966c73707..f696ac7c5f89 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -93,6 +93,7 @@
 #define FEATURE_PC		(1ULL<<9)
 #define FEATURE_GAM_VAPIC	(1ULL<<21)
 #define FEATURE_EPHSUP		(1ULL<<50)
+#define FEATURE_SNP		(1ULL<<63)
 
 #define FEATURE_PASID_SHIFT	32
 #define FEATURE_PASID_MASK	(0x1fULL << FEATURE_PASID_SHIFT)
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index febc072f2717..c55df4347487 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -359,6 +359,29 @@ static void iommu_set_exclusion_range(struct amd_iommu *iommu)
 			&entry, sizeof(entry));
 }
 
+static void iommu_set_cwwb_range(struct amd_iommu *iommu)
+{
+	u64 start = iommu_virt_to_phys((void *)iommu->cmd_sem);
+	u64 entry = start & PM_ADDR_MASK;
+
+	if (!iommu_feature(iommu, FEATURE_SNP))
+		return;
+
+	/* Note:
+	 * Re-purpose Exclusion base/limit registers for Completion wait
+	 * write-back base/limit.
+	 */
+	memcpy_toio(iommu->mmio_base + MMIO_EXCL_BASE_OFFSET,
+		    &entry, sizeof(entry));
+
+	/* Note:
+	 * Default to 4 Kbytes, which can be specified by setting base
+	 * address equal to the limit address.
+	 */
+	memcpy_toio(iommu->mmio_base + MMIO_EXCL_LIMIT_OFFSET,
+		    &entry, sizeof(entry));
+}
+
 /* Programs the physical address of the device table into the IOMMU hardware */
 static void iommu_set_device_table(struct amd_iommu *iommu)
 {
@@ -1901,6 +1924,9 @@ static int __init amd_iommu_init_pci(void)
 		ret = iommu_init_pci(iommu);
 		if (ret)
 			break;
+
+		/* Need to setup range after PCI init */
+		iommu_set_cwwb_range(iommu);
 	}
 
 	/*
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
