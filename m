Return-Path: <SRS0=sVNY=6G=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0942C54FCB
	for <iommu@archiver.kernel.org>; Wed, 22 Apr 2020 13:44:40 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DD232073A
	for <iommu@archiver.kernel.org>; Wed, 22 Apr 2020 13:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BC0xXelZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DD232073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 4CA962261A;
	Wed, 22 Apr 2020 13:44:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6Q5tZz5pUn0X; Wed, 22 Apr 2020 13:44:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 4DE8E2035B;
	Wed, 22 Apr 2020 13:44:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 412F4C1797;
	Wed, 22 Apr 2020 13:44:39 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 09728C0175
 for <iommu@lists.linux-foundation.org>; Wed, 22 Apr 2020 13:44:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 0470286352
 for <iommu@lists.linux-foundation.org>; Wed, 22 Apr 2020 13:44:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y-SBnxzCMm3T for <iommu@lists.linux-foundation.org>;
 Wed, 22 Apr 2020 13:44:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id BFEB085DC0
 for <iommu@lists.linux-foundation.org>; Wed, 22 Apr 2020 13:44:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KciQNjJBWlfka1S+OGOxGSraTHZfR53DjCY8j+SW2Jz3p2+PN2YqiC6ZPLvOxUDg/PskEJngGjEBwrpI2/CdJaG2hjEt0Ao49Po3scQZ2h70faMGs/Yrj2SYwWigEm2axUXgcNVvsz9B4gvx3TYL8v+EbRz9dYMi0fVjj3BbI9jnubdi/yT63QBoDByffwhVA2qNWL+gnLutnHrcjQV0Ud6kKwF4tkNYexdMfGqmUoDCW25e7oGXS3mXBiquvsuJik1lyxxFCOPMzbWNiG7HKtgHtebw4w/FBbG1JX5IYSzG4Q0AXu1PAITxTP375KMb+xa4JShL7Cw+nC84bhffNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V31GxiFPWZsqN79XtI09jbj6RG9h2k1H0HTVVbq1ZpU=;
 b=lH/6jRiMoKWWZOAXMs56vGig3TT5dkkBLZ1actR2/Kdlsh1FHBC6xO+f5kzaj+IezftMzVJRXdADf9fB08ekBvfDF5gUz1cc6J2sQG4act/wJzFOpv+qswAVcRwPifn7c4Smmz4fQEnrcchWYLJrvP3INRmOEpK0nOpgfVZic1Bq0bwm+IlV+fWQRKWFjswiPx3mZcpn7IkXMu1YlEB3vKHXD+dyw6e89dNAvfRX4GUbNefrkIFu1XRQjKzWSeKSNO4Rbm0Fj0FtL73pf39LjFm4gRw7vo8Ho8I1fbKOjClOnsODn8DWUXNbRi9gsV+8PpVTWfg3vgaX5LtUajfkyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V31GxiFPWZsqN79XtI09jbj6RG9h2k1H0HTVVbq1ZpU=;
 b=BC0xXelZXhDkEfL6rsbpH7wfOLeRilee5mgYkbAWq5oPkKmDZk8pvbMmqqqAE3II10VXbIOEHqFc5VV3KS8MfYhcV1nBEs36oXcWy/PRBfTqd1B2tYk23B9DKE+LsLx2hnSzO2fu4HwGRrIPNsGxJ3sOiY/rwTF6kt7pq8csgfA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM5PR12MB2485.namprd12.prod.outlook.com (2603:10b6:4:bb::29) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.29; Wed, 22 Apr 2020 13:30:20 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::d061:4c5:954e:4744]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::d061:4c5:954e:4744%4]) with mapi id 15.20.2921.030; Wed, 22 Apr 2020
 13:30:20 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH] iommu/amd: Fix legacy interrupt remapping for x2APIC-enabled
 system
Date: Wed, 22 Apr 2020 08:30:02 -0500
Message-Id: <1587562202-14183-1-git-send-email-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 1.8.3.1
X-ClientProxiedBy: SN6PR2101CA0013.namprd21.prod.outlook.com
 (2603:10b6:805:106::23) To DM5PR12MB1163.namprd12.prod.outlook.com
 (2603:10b6:3:7a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ssuthiku-rhel7-ssp.amd.com (165.204.78.2) by
 SN6PR2101CA0013.namprd21.prod.outlook.com (2603:10b6:805:106::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.3 via Frontend
 Transport; Wed, 22 Apr 2020 13:30:19 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 19b3f61e-84cb-4f42-8cb8-08d7e6c14dba
X-MS-TrafficTypeDiagnostic: DM5PR12MB2485:|DM5PR12MB2485:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2485DE1C40DA1B667D8BCAE3F3D20@DM5PR12MB2485.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 03818C953D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1163.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(376002)(366004)(39860400002)(396003)(346002)(186003)(4326008)(66476007)(66946007)(2616005)(956004)(66556008)(6486002)(2906002)(26005)(5660300002)(316002)(478600001)(8936002)(81156014)(44832011)(86362001)(8676002)(36756003)(6666004)(7696005)(52116002)(16526019);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fSSy2BvDFOUDinS8LPL6wKrZj6JLjaAQLsKQ3eEIhrdVRgIqYabP8U3wdgTV2G77GidVXVQ/CkAXDGalRuGWmp3CSvXdP9Kp6aciFQfkDNVYcR4G6lDbJnQ6ArfDeelBBdJrqmQh6TieIww38eI7xxZL2aSzsMe0yxTG3SQncJ03BUPDDAYNL2lSH+sXi9fYatQ5jvOO9+scVgm+k94jDLHEWu9GX278IUk90isKojtzUO1IWngrT3gfWaZtIGIoNPnZ7RP/O+5KQQEe3BO9i1uR1dI9JYAMZNE1hsM+YTn/w91nkeSzBDkslbLEkwOPEkwW9jrmrmCtrimlDIR/9nj1WV0r3D2eh2oYdGSdFmfx+mhqD5dfaoElEltsJ7URqJ9V+nq3xvNOTU0v/F1fwE3jdhWBN8DBv/vRblFPY02ZpmoW9bdB8YifYUe+RNhM
X-MS-Exchange-AntiSpam-MessageData: gmN6ocTJtJUvKn1Eh6BSeW7/2e34rU5UKc/Nsq8xGVNIcmVlKGpLyTxIDTxLUBpjhhuJ1w8Gu0KXaG3UUULYHfnS0RwnQzb36UBZTOmSVty7V+ZM3LiDyzQSh0LHEPqN36d8QJ+Bi5eAln8PuAYJng==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19b3f61e-84cb-4f42-8cb8-08d7e6c14dba
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 13:30:20.6581 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IDrQGklYE6NyHIzx7XEnjEjMveA8kPe73M38bWqhjxzSSrQqCl1WhUe+UEg6ijsWHcXJgDFF1CEuGIJUj/RuQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2485
Cc: jon.grimm@amd.com
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

Currently, system fails to boot because the legacy interrupt remapping
mode does not enable 128-bit IRTE (GA), which is required for x2APIC
support.

Fix by using AMD_IOMMU_GUEST_IR_LEGACY_GA mode when booting with
kernel option amd_iommu_intr=legacy instead. The initialization
logic will check GASup and automatically fallback to using
AMD_IOMMU_GUEST_IR_LEGACY if GA mode is not supported.

Fixes: 3928aa3f5775 ("iommu/amd: Detect and enable guest vAPIC support")
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd_iommu_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 6be3853..2b9a67e 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -2936,7 +2936,7 @@ static int __init parse_amd_iommu_intr(char *str)
 {
 	for (; *str; ++str) {
 		if (strncmp(str, "legacy", 6) == 0) {
-			amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY;
+			amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY_GA;
 			break;
 		}
 		if (strncmp(str, "vapic", 5) == 0) {
-- 
1.8.3.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
