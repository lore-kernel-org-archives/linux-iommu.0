Return-Path: <SRS0=ckUw=NL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBCDC432BE
	for <iommu@archiver.kernel.org>; Fri, 20 Aug 2021 20:08:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 298D2601FF
	for <iommu@archiver.kernel.org>; Fri, 20 Aug 2021 20:08:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 298D2601FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 06F164254B;
	Fri, 20 Aug 2021 20:08:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Aj1Z-tg94zxs; Fri, 20 Aug 2021 20:08:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 960C04255F;
	Fri, 20 Aug 2021 20:08:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 993B1C0027;
	Fri, 20 Aug 2021 20:08:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A185FC000E
 for <iommu@lists.linux-foundation.org>; Fri, 20 Aug 2021 20:08:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 91FC94250D
 for <iommu@lists.linux-foundation.org>; Fri, 20 Aug 2021 20:08:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id syvaw6ReK6s1 for <iommu@lists.linux-foundation.org>;
 Fri, 20 Aug 2021 20:08:48 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2071.outbound.protection.outlook.com [40.107.101.71])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9C5DD42547
 for <iommu@lists.linux-foundation.org>; Fri, 20 Aug 2021 20:08:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ROB0V9VIWpNXHO2e8T+1nFuxrD2P/8ao28XAaXAekp0ArKexAiiIY6nu+gmzSaiO6y8Y8AoR/9RDpPAUvbPCObgLLsPeN15j0AMD1/SFby+37oCgP4KGKUFvE7dMNZbY9pU/UiMrk3S7rWNuuRV3dK5KXtVq84s6Ss06ufl5XjALk8kIXEK653VRdxB+1q/4YLUxICrOiANxr6iCkSMT7eZOttALgbbLRPQW4hQ4ZxK4sWNoqQWl6dBefRCH30I3fudwGe0olYv/gbEJv2c6psFZck++ClH30vuznAMQ0MwLx534JwU/YY02aXNwhwFMbuvkp78TcehL4UJ7/j3bRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDJmWkN6tIqm3Ad61Fjm3/+JJVy/5lNTf0uXkd3klgk=;
 b=KITj0jk+GMLqC9X2OhflSgLvNVEmvb5I3BmFjLZXDnu3DunmaS57VCK1tVcLts0pCWZEKzw4u6uiQsZQLQAbW/A20K1gkCpUCJEt8vrnZGFrNu4r6oFhmsBUGqqydoPUxYGZlEPRCgyuM3Su9eKGeIT6DRJiNOkZyq/stRJFXglTRfXn5iUmNhjzQ8h4Zm0SiySw5e+6c+vU5BbWR0qHZrLEXqxd3NHl63qSDePO8edFjgcwy8WRcxDzeHAo2OTn+NCKqGJaX/9j5bKfkG5GyokHwN+XT4xorI34GdQskide/8/lzoz/6Z5LgtyWdNmkJwl+/a4LKdS+110NU45yEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDJmWkN6tIqm3Ad61Fjm3/+JJVy/5lNTf0uXkd3klgk=;
 b=KSjVsYWewavS0mewdlPBY56QdntNqBESx5K6whFixXsdufLeOMLn2OYXibn6AppvugCWe17gUa31tNqPD5FyLM4+qGkQYR/7RtKtSGpJyosFATAlqeyKF5AAj8Uc0ZR3W0SNlvoYlYwrnY1iQ/mDddDjzB4V18gTsCxfniPNUzg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 DM8PR12MB5429.namprd12.prod.outlook.com (2603:10b6:8:29::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19; Fri, 20 Aug 2021 20:08:47 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::1dbc:947c:2913:449b]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::1dbc:947c:2913:449b%3]) with mapi id 15.20.4436.019; Fri, 20 Aug 2021
 20:08:47 +0000
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH 2/3] iommu/amd: Relocate GAMSup check to early_enable_iommus
Date: Fri, 20 Aug 2021 15:29:56 -0500
Message-Id: <20210820202957.187572-3-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210820202957.187572-1-suravee.suthikulpanit@amd.com>
References: <20210820202957.187572-1-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: BN6PR1401CA0021.namprd14.prod.outlook.com
 (2603:10b6:405:4b::31) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx5673host.amd.com (165.204.184.1) by
 BN6PR1401CA0021.namprd14.prod.outlook.com (2603:10b6:405:4b::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Fri, 20 Aug 2021 20:08:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f6b124c-e34d-4d34-19dc-08d9641651d9
X-MS-TrafficTypeDiagnostic: DM8PR12MB5429:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB542969E3EEEF7F3DC4B43F93F3C19@DM8PR12MB5429.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8dM6v1c+r7H9PDcU4+nn1Iio7YbzS1S86fHLu4HvELfABzBnakDVSBoUb2YK9VEiR2YZtIEgw+FxrWrtQyIRHHIB6EvY5sut8xmOVsIWkULprXKejjodF34lGK6vsKHiDxhZYqXYAXrrPWzk+XKxUf4dF4hoc1Vcc3l9MZhz0Kdr12gSgSUhVBcnXm0po80zQmfDjEXDSRXUU5iSQj0JLp+6JHt0Y1EkQowIyrucC9LU3F8ytNvt3SIsLoC93vLrmQff7gEh6Wa3N1nWVlvZbqu6mP+89ZpE2Vpa9dfhqBw1LQsspUhnNq0jzZLQyiDwixAnw2LvZcthIxqhqgBj/bOTjXO056WwHUxQkpZFizgVNkpquY9gh47F/MWP4gU7DCBaud2Iwu1pDRpwOvxn9uhu3qYS6K+BxsBj3DgApSKQ0LNgcLdgwkiuJQpPqROBU6KIEpHJZ3VvG/Jp2N55cR1egyVAOw4w/kSwZufbK08zRNVCxvdxvB780fJUzjaH7uM2fd4h1gbhaY4OgqrKCT1nyeaNUNCYSZ4SQQj+ML/QL47OaoBH+XAyPjioISExE7gH3zeiReNGTWeF1kgBsCuCH51I6mBQyStUwSku386lyqcgXS9FjUny/yy49KE1Mqp+v0omqkeJ5YxY6ZKZi4pAhXSL6Vv/QaFbkvIF6RKlwQC9UVYTecbmqEnO5/QqqHwiM4r5hzrzLg8+0UtjzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5445.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(366004)(376002)(346002)(2616005)(52116002)(478600001)(7696005)(44832011)(38100700002)(38350700002)(956004)(316002)(1076003)(66946007)(5660300002)(6486002)(6666004)(36756003)(2906002)(83380400001)(4326008)(26005)(86362001)(8676002)(186003)(66476007)(66556008)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CJ3p6lWAnkl8rc+ANUl7iaXM9cW0PU/pl8+WxY07o0K3MNEd8+0iBEqHa2sA?=
 =?us-ascii?Q?L5OTrFG0+E/zLdqzDC8Ai63zWR77iR4XWcVx3/EK+j3WPHnqWW+xIakP4RTO?=
 =?us-ascii?Q?dsknAfHG6itkL3G+pya49Z72eL/1MegdQaeycEGWd9wmkRl95Gft2O7hfS+M?=
 =?us-ascii?Q?dXIuXqKN8sJ//neHgveZanJ0lYLZCa3OeQqU1w8hjwLZwLh4AoDmGWXnn03D?=
 =?us-ascii?Q?QTO93icfj9zWJ8YN6/2P8K2XKOQss0zqXdh0mskaZjNt/4MHR2KrGJDHpxo7?=
 =?us-ascii?Q?fkMT9yHp0aQYaXaDMp/SEeYm/H4Eqt2lk3eqWjzRBAHKmwNwShIMJS6uh7An?=
 =?us-ascii?Q?Tez4kcPKOfuyM001A1rzI1Dkh+pAQoTgmQ+Kmdono3g/XVHmrBskurndxPXK?=
 =?us-ascii?Q?zInslihaZbDYIBPe701yDI4VHq8UmCN8IwcdMyL9ICb9pxCur2Ayi63sRjpq?=
 =?us-ascii?Q?NYIZ8YO+IPhb7eyzrK0SXLJrV0/dCt485d3VEnIErl7aM+YR95u3AL7l38gj?=
 =?us-ascii?Q?fMgHq9WOqYNQB85b0PjsQ6nX4ATslCaFRyQTGDnjq8RVdV2R/bTGHDwXzdsu?=
 =?us-ascii?Q?lRI3yiuuf78n86Hti6Vkbzeji6fb7ezo+miDAhpAiNuU2TnbelDYG0lHYtMB?=
 =?us-ascii?Q?N14hstGiiWsiqA5+gGm+oJHWzvH6CE+ReTBbZU0Fi+1Ts3uHiBcWq/SPeImp?=
 =?us-ascii?Q?iVu4/jFf8FIMsJQaUdkCg9IGpgeM+ho6F9AP2K3wswttKUY3ajAejDp/hyDS?=
 =?us-ascii?Q?0xSaAeryisJGeBBOBOdqGc4MCLlL2gJxd6sjQ9QUkQZX+9JJ5mXJxxQAEoxk?=
 =?us-ascii?Q?sYvq0qzy6brPIr8JB5mq9RHV1LZqKTU5fvZ+wqNRL5b3IRMf632cOGFeDmeK?=
 =?us-ascii?Q?ASdh7b5quqa8EW5d1dCChSVpjQWknXDEtf9JQmpkE+I6eCs1UAJpGoij2FG3?=
 =?us-ascii?Q?ZHA+5oMq7KyqQb98jeORB1rwaR4BugeF6EVvflcMiUIPU8vho0enMhFNSzFJ?=
 =?us-ascii?Q?B1TpRQFdjgVSaMK8NbJbsHvHbC6k3890dOwu28CEsL783y4Jw3ivcEG4SYhy?=
 =?us-ascii?Q?7RBOVUc2Qf/50sS7Gm1a3zgN23/M9lTEOvbA1aluAUvkmpu/bQtJhx+hXi4e?=
 =?us-ascii?Q?PCjHjypeB4T2r/bfC4g7VXnD3tieI2vq77wciHZ2tfy6CR2DjBcFRo1hyXVG?=
 =?us-ascii?Q?4Iim8tXrQSQsPJpDy8HJGREp0UsEsN9nOaPpgPJmsniZn30Y/MWiao1H/in9?=
 =?us-ascii?Q?5HmkFkovQsjkKCq3A48ZzQ+eIWBvR0aWy+RflsN0r8SPUT7ZOGVghrqXjhye?=
 =?us-ascii?Q?KVo7pt7ZJKW4GahWYwprripT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f6b124c-e34d-4d34-19dc-08d9641651d9
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 20:08:47.6220 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qfnN38U+eLDTLIPKcB9uFpofrTZXq8CItMR/QCrN4cdGlO+owjso0GZ8bQG9m2qbpZhNksdO5UFwpznMf6q6sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5429
Cc: Jon.Grimm@amd.com, wei.huang2@amd.com
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
From: Suravee Suthikulpanit via iommu <iommu@lists.linux-foundation.org>
Reply-To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Wei Huang <wei.huang2@amd.com>

Currently, iommu_init_ga() checks and disables IOMMU VAPIC support
(i.e. AMD AVIC support in IOMMU) when GAMSup feature bit is not set.
However it forgets to clear IRQ_POSTING_CAP from the previously set
amd_iommu_irq_ops.capability.

This triggers an invalid page fault bug during guest VM warm reboot
if AVIC is enabled since the irq_remapping_cap(IRQ_POSTING_CAP) is
incorrectly set, and crash the system with the following kernel trace.

    BUG: unable to handle page fault for address: 0000000000400dd8
    RIP: 0010:amd_iommu_deactivate_guest_mode+0x19/0xbc
    Call Trace:
     svm_set_pi_irte_mode+0x8a/0xc0 [kvm_amd]
     ? kvm_make_all_cpus_request_except+0x50/0x70 [kvm]
     kvm_request_apicv_update+0x10c/0x150 [kvm]
     svm_toggle_avic_for_irq_window+0x52/0x90 [kvm_amd]
     svm_enable_irq_window+0x26/0xa0 [kvm_amd]
     vcpu_enter_guest+0xbbe/0x1560 [kvm]
     ? avic_vcpu_load+0xd5/0x120 [kvm_amd]
     ? kvm_arch_vcpu_load+0x76/0x240 [kvm]
     ? svm_get_segment_base+0xa/0x10 [kvm_amd]
     kvm_arch_vcpu_ioctl_run+0x103/0x590 [kvm]
     kvm_vcpu_ioctl+0x22a/0x5d0 [kvm]
     __x64_sys_ioctl+0x84/0xc0
     do_syscall_64+0x33/0x40
     entry_SYSCALL_64_after_hwframe+0x44/0xae

Fixes by moving the initializing of AMD IOMMU interrupt remapping mode
(amd_iommu_guest_ir) earlier before setting up the
amd_iommu_irq_ops.capability with appropriate IRQ_POSTING_CAP flag.

Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/init.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index c97961451ac5..ea3330ed545d 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -867,13 +867,6 @@ static int iommu_init_ga(struct amd_iommu *iommu)
 	int ret = 0;
 
 #ifdef CONFIG_IRQ_REMAP
-	/* Note: We have already checked GASup from IVRS table.
-	 *       Now, we need to make sure that GAMSup is set.
-	 */
-	if (AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) &&
-	    !iommu_feature(iommu, FEATURE_GAM_VAPIC))
-		amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY_GA;
-
 	ret = iommu_init_ga_log(iommu);
 #endif /* CONFIG_IRQ_REMAP */
 
@@ -2490,6 +2483,14 @@ static void early_enable_iommus(void)
 	}
 
 #ifdef CONFIG_IRQ_REMAP
+	/*
+	 * Note: We have already checked GASup from IVRS table.
+	 *       Now, we need to make sure that GAMSup is set.
+	 */
+	if (AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) &&
+	    !check_feature_on_all_iommus(FEATURE_GAM_VAPIC))
+		amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY_GA;
+
 	if (AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir))
 		amd_iommu_irq_ops.capability |= (1 << IRQ_POSTING_CAP);
 #endif
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
