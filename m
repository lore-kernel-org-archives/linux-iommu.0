Return-Path: <SRS0=i+j8=MG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E43EC1B08C
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 21:02:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3D34613D3
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 21:02:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3D34613D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9BF58826C1;
	Wed, 14 Jul 2021 21:02:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LAmX6HRS-igX; Wed, 14 Jul 2021 21:02:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 77EFC826C2;
	Wed, 14 Jul 2021 21:02:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 330C5C001A;
	Wed, 14 Jul 2021 21:02:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 79310C000E
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 21:02:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 67AE240655
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 21:02:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x62AZUm0AwTK for <iommu@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 21:02:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::624])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6940E4060F
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 21:02:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/MgmXOoKy8pLKEus6vFMx6/k0BxZkv0DEsGQkum7V7EdLT2hDgw8UQoWOj2PxQ0psD52ZJfBkHjb0z8JL4ElcaY9psiwPpz25Eyp1R8SHaQCPyAg+D6zKoi9tHiXCsVzfEPayr5aD/+VRpaVUgjrhTasZrLzQ5uPmAwJWqcG2S3zPIUovim7DYEBR2+J2zAVMHJx8h14m3/cSG+0sYajvBHfemP5HVOh3JBZ/ofKL4iAg1CwPXEvWd/06dS1FLQ2pOlMlb62wkhXeXdlcSi/Ejw4XT09AG6/fN4n717gDbxnWm3pu3OSiFoyp3wRdjXXJG+hpdSKfXTc2nTwmP4OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2sVUSxBSw7NXzEoxZ4SjvwEi7eNilNqaOfZO/dIXgBM=;
 b=eoM8ImbK2yN4QKZ4Xd1vG9k8IIoxoCgF93UGQZUnabR8QRnvS8NAxJP24qWT7HOIVIVwOt7wTXpTVI0mqOJcRGZfDEdrY0qYNDMKjKoxbps/bEq2V/T+U6suEyK+t8HGPsOvOKOA1H1dPCGNWph01MUCxFg9rnFr3Jf5GslLifIDFYRHvd//vt4KBfMfC0pPqQ3TlDI4zaDVb4JjMs/JXtlp6OGN8rHqS8PWIUs6lB8Vrp0sVUsnWBN4Z448L7bNpKmyMzpkDLfQVlZVo3mD7LFpWpzDch005j+79JJWlr2YYip+dhWtTj04wKIAMcMy0/94N6D/W9uP6sOlGD1FgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2sVUSxBSw7NXzEoxZ4SjvwEi7eNilNqaOfZO/dIXgBM=;
 b=FaidqpvWxZ5o1zaK4b7oi9HOP0hkQV5+XvVK53qjgTDPMYiDIoQ/4uOQLQWqypHJu6qi+z5P3s1sP83JgEjeeS2EMivdBkTGu+YniswovYEvRqwmSxt5DO6jfgg5MhZrfZA5CSo1rfBvHAXcWJTq7aoMEg9Uc1++n+18bBNuMuU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 DM6PR12MB5533.namprd12.prod.outlook.com (2603:10b6:5:1bc::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.22; Wed, 14 Jul 2021 21:02:30 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::b098:ccab:f79:9461]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::b098:ccab:f79:9461%5]) with mapi id 15.20.4331.023; Wed, 14 Jul 2021
 21:02:30 +0000
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH] MAINTAINERS: Add Suravee Suthikulpanit as Reviewer for AMD
 IOMMU (AMD-Vi)
Date: Thu, 15 Jul 2021 04:02:22 +0700
Message-Id: <1626296542-30454-1-git-send-email-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 1.8.3.1
X-ClientProxiedBy: BL0PR01CA0016.prod.exchangelabs.com (2603:10b6:208:71::29)
 To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanol696bhost.amd.com (165.204.184.1) by
 BL0PR01CA0016.prod.exchangelabs.com (2603:10b6:208:71::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.21 via Frontend Transport; Wed, 14 Jul 2021 21:02:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89fc717e-0637-4ddb-2e3c-08d9470ab14d
X-MS-TrafficTypeDiagnostic: DM6PR12MB5533:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB5533BBBFDEB5DCDD99AB6387F3139@DM6PR12MB5533.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:361;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: glpyrdXcMXj8ghAMgR4R8Hv70VWhN1yxO9tS8Yx5VSd/Bu+tL9nUIEkr2GxGH9vSE6PL2p17LQlMSUCxTLSRULOslcLbPMgFyEuFyAMk9rLfnNDRdyWPzLyIThA1Tsfj6RYkIgJx6kUGMoiaZIaaOm6oAaQLoO87LBj4T28KA7xCC9rvEMKmqaIDLlXT8izbsOfdAesD6jWmJvJOfWljPJ8CEvtgDfVcYXqGkqhElS/v56LXRFP12gwaYuuCcG5aUHr5vC2SJ0aJg4nYfB+f8vXNXt/iM03euoAHSkYJJztisl1+lciQcPbfyMsN9+rsO0n7uPz8QWv791gGo8Gp2vc1+itkIQO1Dxli08vLqRXR2HMNltR0+Z7yuIJV/W/8DbfyMf9l2Kv3HpKVi1aT8NCLka4zHzZuBgf6QzWOT+ysmaQR+lwtK4dJrUBJK9yShnBDRN74oTbFzCAmpM6+CB2nQJm3LrHP4TeiQsnMwCLKydJnauppUF05lI8ZDMiGIn2a6M47dtlCcdWScQCG9JiwieW2X2q+oxO72SKEIa/OMJYOiNJXdePxC11m1RWcxC22fjxVv83EPMCSPF1ecG/dyZ9j91bmN7czJdM2mUp9jH5Ov7nKOPVuX6WGJqRrY1tXhAGBkuKM0eZVBUVGVxWACX+JgbvWujvJx/q4hID0QCTVWwkxEbkeUYo85D8ruMt7+Ax+FlnUt+6Z1QmSYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5445.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(4744005)(5660300002)(6666004)(2906002)(4326008)(316002)(44832011)(38100700002)(2616005)(956004)(38350700002)(8936002)(7696005)(52116002)(8676002)(6486002)(26005)(66476007)(66946007)(478600001)(66556008)(36756003)(86362001)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MZD2QF7bsbivAIM/cvBxS1RiAe8f+z6HrSCSlb4AeQLTXeMCL9pQzNtmxQFS?=
 =?us-ascii?Q?7T0AcSURxmAz5PGQkMOTUAPStBOTTgbbVx76t5BoQzzaKQ2Km4rY6C8zH2Ex?=
 =?us-ascii?Q?6wtwJV5cav9I3mwpi4uFkV9769TItsdnjXUhAj8ikZvMnp5ziPHOY1IkHE68?=
 =?us-ascii?Q?FgenCT7hDV6ltXzK785vv9Bp9DY0vVf8+0x4ZD3nGYxmeusZO7f0KTvNUJqB?=
 =?us-ascii?Q?RM44b3/S7ha4u5/KCrYzbceH3leZINtpaD4r6wKZHuh5rb4ZGBG1DO3proW9?=
 =?us-ascii?Q?WLsBNyQHjd+AF1834mxnKdcpNk7d2BN73cZZvPWMm2R4Cb2AxtpTWVldWAZo?=
 =?us-ascii?Q?E3RTPSBVJliN+fGODwCK46g2TjH/VZVZLfQ2iwyhTSh0pABOrnDed4XqYMzB?=
 =?us-ascii?Q?o22Nb3zppgmjuBktqIO+PUeUDHGKURAy8bmNj0nTC+RpMt147RMNFxIaTovs?=
 =?us-ascii?Q?K4ALTml+ghgh3ODkdQ6k81pT7q/pQCuipgUK7c/66VWc2Dki8SVen05/65jz?=
 =?us-ascii?Q?b0lpBf+d7lik2+UyxUZZfP7zWk8hxG1rmMIoBWUoImj+lfMK41hMhwq1OSnp?=
 =?us-ascii?Q?04RJ7XT+gQ71k7e+8KFEtD6eY5fgLZ/CX3HaacnS17Oun1XbsBfpSnXzgBKQ?=
 =?us-ascii?Q?PL0dN/eeg99tKSCxr9I7KPxemlcobWNos0/paUqKzFnVryYe4ZFvmyYJ+t5J?=
 =?us-ascii?Q?1UfsrOVd8BZvdixDyFgc6scXNPaMZtqAay6f9UTO93dn9IWNo3GVaOP+PqBI?=
 =?us-ascii?Q?Jr8FXLn07ECks6D2oIAYT+ttI4VKLrt5c0Qs7FwW4kv+ow5DAUtXRlExT/Kh?=
 =?us-ascii?Q?yEdVDiCP5NO6FzI7VxtcACnOFw5kD+FvhrJ+cRJKSGuBB2Gi/WJ7mDAfsLiL?=
 =?us-ascii?Q?IB7diunOsKgE3Yxca9LkswG7fu+JYVrT7X4RU3EYlxIPSMf01UjPz78mRl/z?=
 =?us-ascii?Q?I/D6g4PhrvVgZH9sSP4VMfu11XVuLCtRlKFc47miRA9CMc5iYKJnnVJCsUgD?=
 =?us-ascii?Q?vbRqX5kGOEwgimRpEL7iYVIKpvSVWP1wTHiaHf7WbrYXVW8FlYvSrYbCK/KX?=
 =?us-ascii?Q?2kEFH/3SDvTcwgKnyg9mZipt9MJIhUtNfSZ4aT31s5I2fXVx30v6WDb6JX7G?=
 =?us-ascii?Q?MD/e7xWd+RuCFnqSJhmgNw4AAHRI3DBCl9EMu/wA4oBVX2nLvlZWiqZRw1+B?=
 =?us-ascii?Q?LeJkrEg7eC7DD7sC1/vJ+Tela9IC5hYgo2Og2IRp9qq564fzPJAft0tfyZnV?=
 =?us-ascii?Q?pRsx1JEqt9z77a3M8exUB48ePEJa+S36cxEO1AEzBys3Bcu5gsLBmpaqO1yC?=
 =?us-ascii?Q?y5TRIuZ6eG2PHq2U6XODJs2h?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89fc717e-0637-4ddb-2e3c-08d9470ab14d
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 21:02:30.1616 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YX7okb2Y9iy4jyqD2q3znd4dcWJhAvI2yk77fq7CJ78vWIZPRISdyiYbhQ6d3/D+G+I1KnPuDsAAyALaXUDuLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5533
Cc: thomas.lendacky@amd.com, jon.grimm@amd.com, mlevitsk@redhat.com
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

To help review changes related to AMD IOMMU.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b80e6f7..8022dbd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -933,6 +933,7 @@ F:	drivers/video/fbdev/geode/
 
 AMD IOMMU (AMD-VI)
 M:	Joerg Roedel <joro@8bytes.org>
+R:	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
 L:	iommu@lists.linux-foundation.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
-- 
1.8.3.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
