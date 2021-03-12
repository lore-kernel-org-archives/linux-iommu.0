Return-Path: <SRS0=dgoC=IK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07234C433E0
	for <iommu@archiver.kernel.org>; Fri, 12 Mar 2021 08:55:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C093B64FE5
	for <iommu@archiver.kernel.org>; Fri, 12 Mar 2021 08:55:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C093B64FE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3941F84540;
	Fri, 12 Mar 2021 08:55:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 64bJInHcOJVf; Fri, 12 Mar 2021 08:55:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id E5CAB8451D;
	Fri, 12 Mar 2021 08:55:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 998FBC0013;
	Fri, 12 Mar 2021 08:55:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 494BFC0016
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 08:55:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2AE546F9BC
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 08:55:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eyuY8YADaIa0 for <iommu@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 08:55:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D40E96F9BA
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 08:55:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lvk7HnFEq9GBMjSZqywnNjyxOKqIpncJqGbD/ADDrdYrF+NGquLXLAa1ZGg67PHOhyvPrwX522aATZZqoLtNzC2XTiHsHhvBkIOy3dsH1lw3N2HvhcfNPsPzRzeYhskXUiM3WLRrYcEgTWryDceQiSSxXvBYIFnW3ULwc9JHpX/2WHKqKHoFDavAfothAmPwUiUGWzvmXNQpN0w5wvTVchc9kEC45mTFL0XEqXcjJ0aqTlseeSS222tBbk0ohVXGDrSXOF7H2nMLbmBxfIrSRVFmhFDsFkB/zf3OS834gHW+8lGvoA8jEr9HBq5OSXJXCbA1ksRaGViSKS/sbtr0uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4b8VKmbQOO0AMtOUNb7VBhBl8Q9uSptIkRTuFgcq8U=;
 b=NreDGXaPsnVtOIUP/Q1sxiuRZnCdoRQi1ymqJqPpiyEhDzZ/L8m+tkFCN9LER6H3hHJ/qHqOlPbkXJ9tzqR1hxS7jQ4saW3GCi02oMtwyTPLLyzl9u/eWXvqlOipubb2q2Z6YTvOJPMPP6qn6r5WLz1uIO8r3PNA1hwDzYwob92ElVw+05pzSbqvB1GhhKOrzbn2xmnYGWHs4r4Rsk7PRUFZcDjgfXVgjc7B7KBK8D/FTeVz0TX8sPPkC8zMRLsSIAVSKhCaWp+m2Egftsh+VEAM2cJbpoPmvAsrjet7TqPKiiWjl99Xti3qeUtj/HSdGQ/JO5s3S4e16v1BUlV5Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4b8VKmbQOO0AMtOUNb7VBhBl8Q9uSptIkRTuFgcq8U=;
 b=tbgj1tnG1I+HYgbrYxTOH888c2jpTvqOkMn+K+9ovmwVKf9YEA2SAI1TZ+IF24bilNAnoXrKawymIgbcAsK6TFx44Ht+SxfqznJBwdpwLmvMEuduq/nDZHwnhVlLYQCEwOAW8VjWlzfN7IzTy3vMDPq+1B7Scrgx3NOx+DyYCqI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
 by BYAPR12MB3144.namprd12.prod.outlook.com (2603:10b6:a03:d6::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Fri, 12 Mar
 2021 08:55:16 +0000
Received: from BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::a95a:7202:81db:1972]) by BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::a95a:7202:81db:1972%7]) with mapi id 15.20.3912.031; Fri, 12 Mar 2021
 08:55:16 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [RFC PATCH 3/7] iommu/amd: Decouple the logic to enable PPR and GT
Date: Fri, 12 Mar 2021 03:04:07 -0600
Message-Id: <20210312090411.6030-4-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210312090411.6030-1-suravee.suthikulpanit@amd.com>
References: <20210312090411.6030-1-suravee.suthikulpanit@amd.com>
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SN7PR04CA0040.namprd04.prod.outlook.com
 (2603:10b6:806:120::15) To BYAPR12MB4597.namprd12.prod.outlook.com
 (2603:10b6:a03:10b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx5673host.amd.com (165.204.78.2) by
 SN7PR04CA0040.namprd04.prod.outlook.com (2603:10b6:806:120::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.18 via Frontend
 Transport; Fri, 12 Mar 2021 08:55:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0a014e17-56f0-4418-1cd8-08d8e5348e65
X-MS-TrafficTypeDiagnostic: BYAPR12MB3144:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3144A34C8EE3AA9F6854F43BF36F9@BYAPR12MB3144.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HPbiIAzCnsP+DhDsp+A7zVlJsu7Ii40LLvG8dqpuM9YRpMN0CkxEj/fEI8gRNyP2cWqyZ+3VQJ2GGVPEin455HEiTMc1JafX+xrX0weSBGVLgoo+hHd/mHeKDm6Sg2g9WajbA4qFixOvPcTOaH0QbKlWThP3cmIwP9v+65mXYoEhjAgFwzw0ZpSl6zLDnCf1tkxMyHsfuAQrLYlFVJ8Y1qNgP4t0X1FAQ40THoeZBJl4OHS3OdBekfMivli09isJikoDdHmychJj9nNTPAL4g2T5lpDpTtRSDXUYq99WbbSPDgnUc8ARlUkNEpn+l2AFy/pm3CmxPFgQr10gCTJ2Vm79NCa1xBTQ0+SFjphRBzwUc7uETbVCPXsikQwXhXZ3/GsSnUkQqIJGIGw9bIA4Yo90lywmCdKPzoDk808mT8ph4psijTAloI8xdAMBjUCEXbool9AAY4pjgJotbD2m/4ESCYf6OEHbjhSV2B8xy6wtBFgn7BEWlAnu5AC87P5+y2RTZpsDi8+UsTKrlYVSZb/TU+CSelRx+8K9Kc0Wq7stohwtYd5gXu5zl6XT3E3P
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4597.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(366004)(396003)(376002)(346002)(6486002)(6666004)(316002)(7696005)(8676002)(16526019)(1076003)(5660300002)(956004)(66556008)(86362001)(52116002)(478600001)(44832011)(2616005)(8936002)(66946007)(36756003)(4326008)(26005)(2906002)(66476007)(186003)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?qO+O/JhQiuKA+NmMj/flQX2BTmyZ0FSZyuzlwGuUNraN4gI3O2I4Pk+6NdtI?=
 =?us-ascii?Q?2yxYqhOk3akoXmmGIj+kPa0IFYy4dsiT0uL7XGAMoEzUc0+7qW9LdoHF6MSp?=
 =?us-ascii?Q?W/DhlSZEU7VLelBJ1VQTNd+x3V6ypAKZP/YnOFvD1G5E4pMdMaJ573ASmsyM?=
 =?us-ascii?Q?9TKKVtLBP9IcoR2My4rHgo+tGGh3R/HgwdIQYwpvOXpMxKGkiIAPewq+K1rS?=
 =?us-ascii?Q?SpAdKXjNuhQrniubGf8Y3VgPzqewYzBe856+5s2KpccDh9q8LWsJyqgqvlkj?=
 =?us-ascii?Q?EHTx5MWMYlv0w69reX52EQth9eol1o9kNw1gFYelv91R26biBO11FieHJUlt?=
 =?us-ascii?Q?72acfvcLVlGKXU9W7/1h/ZSCKNnnJrQFfdiTTp+d/kLb/AK+nDkzQRbvPqSA?=
 =?us-ascii?Q?+UdeANG+y1F3Jr6ekVZYGU228A7PY6nJDV8YxHihwHQ4hEDgVtyrslmlWOvr?=
 =?us-ascii?Q?1CJ1BDpHspABNsITdefrl9jKGPBoA/79PVktangPs/uE7XuxKgD1iUDFja1K?=
 =?us-ascii?Q?UYBs57nwChko5ddfJgezTrEXXKXWXLFjWCziNxKd3yR8pc0opFuAtj9z/+BX?=
 =?us-ascii?Q?r2YD62plDRI9Zi0HFln1RSi/cUEsT/xIcjkkvO9r3bJjGvKpPnKez51g2vM6?=
 =?us-ascii?Q?65WNDlmN4xo8XVw9EdL74AayFf6Ge8pCsU9ENQB2phb2CopRwxOWoV0Dd+Lt?=
 =?us-ascii?Q?HCPZZ+j8Oq8jiSXIYMxXX4dpNI1eSX57Khyql2nAo+v01eQx5bk/TGYgbGho?=
 =?us-ascii?Q?6Wd+7SPmYO8O9Khi+5k28V0LOmhAV70aQYVhqiMnqBWo8twXI3wgAfXSNWi4?=
 =?us-ascii?Q?2RZu9zkWQt9+uD2FmG3W+fCDu3OkfgW2EvvL2EwPTWhIGabypAKELYix5qUH?=
 =?us-ascii?Q?V2RkzQkh9rj9hN8S+7q9WnEsyX59Dhd6pZg3DQrggq58he4lB+2tDI0yBD1X?=
 =?us-ascii?Q?UZfV6KiQ1O2iiU/Icfcfsonr8eNpfBlCoawW2+lRBanZyQu/aSO9fHIVhSUS?=
 =?us-ascii?Q?Ri7sx35tJTdUkSkvmXi50BnjrXTbai52yUfe+EEjag10UunN/vAs4/AD14mI?=
 =?us-ascii?Q?O+EMRW27wp1xCLORznqAohJLx3XOfzMm+n04AZmuuVYthwH0CW527er6xFQ2?=
 =?us-ascii?Q?C8SfNQiTpignBl3QnvPUlVlGCAFeys8nuoGFvoZvEI3s3/6xdX3oGt4JO/Mr?=
 =?us-ascii?Q?cBY/iPdCR1Fh8/mcLZMnQVi0hu6vpt6YDla8WfGsmYso8/fqJ1Q8Tbt9kVDB?=
 =?us-ascii?Q?P8+5C7+otX4n7UIvN3zJKphXGia+8q8jQHKhvR5ZTJEyWvI5BZB5oW7Va9QE?=
 =?us-ascii?Q?/C6BSZ9qZRkiYPZuCPv2unRM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a014e17-56f0-4418-1cd8-08d8e5348e65
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4597.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 08:55:16.5814 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O2cFDulIGjXuSfB/vBvpl0+Pm6IStNw+glNN2xHocyUD1VTM0vH1QiO3iEgPsBQzStPlP3CWX8f8/w3kI5xaQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3144
Cc: Jon.Grimm@amd.com, Wei.Huang2@amd.com
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

Currently, the function to enable iommu v2 (GT) assumes PPR log
must also be enabled. This is no longer the case since the IOMMU
v2 page table can be enabled without PRR support (for DMA-API
use case).

Therefore, separate the enabling logic for PPR and GT.
There is no functional change.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/init.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 9126efcbaf2c..5def566de6f6 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -898,14 +898,6 @@ static void iommu_enable_xt(struct amd_iommu *iommu)
 #endif /* CONFIG_IRQ_REMAP */
 }
 
-static void iommu_enable_gt(struct amd_iommu *iommu)
-{
-	if (!iommu_feature(iommu, FEATURE_GT))
-		return;
-
-	iommu_feature_enable(iommu, CONTROL_GT_EN);
-}
-
 /* sets a specific bit in the device table entry. */
 static void set_dev_entry_bit(u16 devid, u8 bit)
 {
@@ -1882,6 +1874,7 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 			amd_iommu_max_glx_val = glxval;
 		else
 			amd_iommu_max_glx_val = min(amd_iommu_max_glx_val, glxval);
+		iommu_feature_enable(iommu, CONTROL_GT_EN);
 	}
 
 	if (iommu_feature(iommu, FEATURE_GT) &&
@@ -2530,21 +2523,19 @@ static void early_enable_iommus(void)
 #endif
 }
 
-static void enable_iommus_v2(void)
+static void enable_iommus_ppr(void)
 {
 	struct amd_iommu *iommu;
 
-	for_each_iommu(iommu) {
+	for_each_iommu(iommu)
 		iommu_enable_ppr_log(iommu);
-		iommu_enable_gt(iommu);
-	}
 }
 
 static void enable_iommus(void)
 {
 	early_enable_iommus();
 
-	enable_iommus_v2();
+	enable_iommus_ppr();
 }
 
 static void disable_iommus(void)
@@ -2935,7 +2926,7 @@ static int __init state_next(void)
 		register_syscore_ops(&amd_iommu_syscore_ops);
 		ret = amd_iommu_init_pci();
 		init_state = ret ? IOMMU_INIT_ERROR : IOMMU_PCI_INIT;
-		enable_iommus_v2();
+		enable_iommus_ppr();
 		break;
 	case IOMMU_PCI_INIT:
 		ret = amd_iommu_enable_interrupts();
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
