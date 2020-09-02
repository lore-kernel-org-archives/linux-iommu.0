Return-Path: <SRS0=BMay=CL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8A3C433E2
	for <iommu@archiver.kernel.org>; Wed,  2 Sep 2020 08:24:37 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8087B20709
	for <iommu@archiver.kernel.org>; Wed,  2 Sep 2020 08:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JTpZYrbl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8087B20709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 396BE854DB;
	Wed,  2 Sep 2020 08:24:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MWN7uyDvawTJ; Wed,  2 Sep 2020 08:24:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C1BB284A6C;
	Wed,  2 Sep 2020 08:24:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A40EFC0052;
	Wed,  2 Sep 2020 08:24:36 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 83459C0051
 for <iommu@lists.linux-foundation.org>; Wed,  2 Sep 2020 08:24:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6AF7C854DB
 for <iommu@lists.linux-foundation.org>; Wed,  2 Sep 2020 08:24:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bj3lRX0DooQt for <iommu@lists.linux-foundation.org>;
 Wed,  2 Sep 2020 08:24:33 +0000 (UTC)
X-Greylist: delayed 01:00:26 by SQLgrey-1.7.6
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 71BD984A6C
 for <iommu@lists.linux-foundation.org>; Wed,  2 Sep 2020 08:24:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMPv11IlkoQvfXZ82Z/GkiMh2khqKSOtXi7GVA9y6VzOSGBBENdAjMNIKhnB5tkCW925Rl21FQBW+hBbzgf01S/8Vz1i0c4sFavddP9fc2Iai0iE+zz63UwcwZffcx7wsSrRI24CbxrPV/kwrtK8bCQqujtP+Dbc+1vdThsuCSXl+ZxNPjMtBNQzo1Raafy58GBJAsQv52Hc/38MdHsWmzp3tVcPfZH+2/LbF7xL6vvF13TyhiMytPBDpx985vrMSndfnm6a8a2CWpnsByhhS9cCj6UNkGUPKdhjp6wguJNrpDW/v+znCdTU+ItY0tb5UiofpZfNaLaklvlhhwYmTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VaGkcZzHqPvl2U+JcPXmfVtH2Cww0YaKnBZ7Z2/wDg0=;
 b=ZMwSynQFUtIYJRuH9UVsmmXrmtqDwMiw5UGoJK6K0Kn8xsxRE6iHULR2dTpLpDyvujF+X008XTnGgXDpg/cRdKc6rQk5gcnsFPe/A0t1EEVHbyh9sT+hzfQp+TKGRoecQuqDHMTVTyiKmxzM/T29d0oJ5R4RY04pUtBiCu0XR5ob+ereNiQGbqI8qFJPHbHbBwlpTUb8CdyrmG2w/x+LF+QCgjXVQZ1bUx37Y8LomSFPfWRp52vQi0f9fv0lyUhNX62OaIhToxMSSbpDHgv3ebdxCHdMTKW0VaHSOhnsfCDsm+XbDT3mheC52P0Q2fm8vfK7xfUAqw6dya64UuguWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VaGkcZzHqPvl2U+JcPXmfVtH2Cww0YaKnBZ7Z2/wDg0=;
 b=JTpZYrbl8dJ1mFxsANEhYhsiJY+UJOsE5I/HJTFv04By04pDczbhRC5UZM7J1rkt7jUobhvFOUKgJMRyQrN/eGelIcEe8BUE5BdCFoXNq95af25WsWoof6H/XUA+LOe25LjxEBERGSgrb87YHk5wpntftI7TAicpO/SQs4YgrCY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM6PR12MB2795.namprd12.prod.outlook.com (2603:10b6:5:41::32) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15; Wed, 2 Sep 2020 04:49:47 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::cc8d:7537:ec56:108e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::cc8d:7537:ec56:108e%11]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 04:49:47 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH 0/2] iommu: amd: Fix intremap IO_PAGE_FAULT for VMs
Date: Wed,  2 Sep 2020 04:51:08 +0000
Message-Id: <20200902045110.4679-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: SN1PR12CA0093.namprd12.prod.outlook.com
 (2603:10b6:802:21::28) To DM5PR12MB1163.namprd12.prod.outlook.com
 (2603:10b6:3:7a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 SN1PR12CA0093.namprd12.prod.outlook.com (2603:10b6:802:21::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Wed, 2 Sep 2020 04:49:46 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 018f5fb0-f49f-4ed2-bdcf-08d84efb9e40
X-MS-TrafficTypeDiagnostic: DM6PR12MB2795:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB279527E667B4F7AB490BB744F32F0@DM6PR12MB2795.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U3w1vuW3zY9ecjCYwdDrXyyk8xCJa3fGM8HWvFKd79+9J06fpbCr57lllDJGqVQb6pvxUneRZfR0ntxZNZZ4JGM3OThwr72IjO/r8eg/jpsCRFAqfAsSOLxbHjiXZVZo1Rv0AiYUJN7lTzBvlXFew6V17WcvJyFdRGmrmbjRCzcv355lOh2lxHHAxq5whsyIigCzc/RZazivkiQVg3e8o5LiUgdOFc0rbT2Ae/irTfT19ttif0HvB5HMjcG0vcBzDHrDt+PPRGtQGigay6eUdOc4JhYSk6b0JEBtM0x73cJ/iQ/D6eZsKT8bxLXadb9i
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1163.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(83380400001)(4326008)(8936002)(2616005)(956004)(86362001)(478600001)(26005)(16576012)(44832011)(8676002)(2906002)(5660300002)(36756003)(66556008)(316002)(66476007)(66946007)(186003)(6666004)(1076003)(6486002)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: /6zPGhZAlGhrZxT2NcTBK2a2xwuNof/H7+0nxDSUpL4uL+ho5Sp4hwbW/AhO7IsBAs0IXVbiGvQLQPtB7cL3FoB4MT9firAIWHw1USeNNRhZDAXBGJXpk80jIjiGmP8uK1P4x4nooEehZeaU94VJHmLkdVmheWM19OZGxG1Vh3cDRq8Kn0GLnLSgatxR/nXaX5mhsLdEMzj5rELCdFQW6r0zIC2xGNHW5bOAJfG+GfkSSg0S4IZNiKDJ5d4QmJLezYJzimTofvjmmffj/Blx3mcWZYGhWEp0SJSdIedGgzhtVg61B+JqujY6LDU7H9zJYpvbMe3E1e9JKQ7f8Z5ECBod2xnVqXH2/WwU3lqCFEzRkoViEOrky6dcuChtlI6HPdVcSlz/hKOa7sdpZbUcX7h5T1WuRSj3rWJqRCMQ6w5Q/i167uBGX2Xn4ABvkVhzYyBSAB2sdnYpmbOZKeuvDfaiocK0l3shh7PCAeUhk9PXjguugfI6tQ5aocqtWhXRfyvwqDZz3k3JkYGtg1EnH3GE1D/1XwBZjcS0SB4aCOg+EbZrqu+zG0RSiNFk7oR3QSTGGTr6vd5ALHKrmjk7UPgPnECY+pSOap0RguBqW/VraY5Bor7PipnU/Hgq37f6Ca556sswEfZqmK9ED6K2aA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 018f5fb0-f49f-4ed2-bdcf-08d84efb9e40
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 04:49:47.4374 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bMazvi3mGjGxuvcwp52ACBEyFyNo268banjAHAIlzbPDhXei+VZVTlsn/3fQLrWUSw7paaLA1SGHf3ZTIERNnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2795
Cc: jon.grimm@amd.com, james.puthukattukaran@oracle.com,
 boris.ostrovsky@oracle.com, joao.m.martins@oracle.com,
 sean.m.osborne@oracle.com
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

Interrupt remapping IO_PAGE_FAULT has been observed under system w/
large number of VMs w/ pass-through devices. This can be reproduced with
64 VMs + 64 pass-through VFs of Mellanox MT28800 Family [ConnectX-5 Ex],
where each VM runs small-packet netperf test via the pass-through device
to the netserver running on the host. All VMs are running in reboot loop,
to trigger IRTE updates.

In addition, to accelerate the failure, irqbalance is triggered periodically
(e.g. 1-5 sec), which should generate large amount of updates to IRTE.
This setup generally triggers IO_PAGE_FAULT within 3-4 hours.

Investigation has shown that the issue is in the code to update IRTE
while remapping is enabled. Please see patch 2/2 for detail discussion.

This serires has been tested running in the setup mentioned above
upto 96 hours w/o seeing issues.

Thanks,
Suravee

Suravee Suthikulpanit (2):
  iommu: amd: Restore IRTE.RemapEn bit after programming IRTE
  iommu: amd: Use cmpxchg_double() when updating 128-bit IRTE

 drivers/iommu/amd/Kconfig |  2 +-
 drivers/iommu/amd/init.c  | 21 +++++++++++++++++++--
 drivers/iommu/amd/iommu.c | 19 +++++++++++++++----
 3 files changed, 35 insertions(+), 7 deletions(-)

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
