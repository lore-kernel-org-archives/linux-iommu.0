Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D8EAC433EF
	for <iommu@archiver.kernel.org>; Mon, 13 Jun 2022 01:25:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D8171405C1;
	Mon, 13 Jun 2022 01:25:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DePRKkHZppf2; Mon, 13 Jun 2022 01:25:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 84DB64010D;
	Mon, 13 Jun 2022 01:25:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 50897C0039;
	Mon, 13 Jun 2022 01:25:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D47F9C002D
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jun 2022 01:25:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CB04182DE6
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jun 2022 01:25:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HX8qAehRVYxc for <iommu@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 01:25:30 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::626])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 79E2082C3C
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jun 2022 01:25:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cV9m3hL1QZzwEcLoqePxz+/e1iWfQPRWZKrqxLsFaU8CUU8dx+r1NHpI0As31RTmSkB+afxK1c0IAyhv0Fl5mC41Ky6wFt+vF3iXDONDeVrkb5Lau9O41XhngPbwUseOGnCnpIyiX96zMgW+LOK6C6ziWHaPfh7ifM1uGw65PknjJX2hs35qM8npeajcNjqlMwYhUNhrSQDrsYjlZ3pVGR3/oKwE9jM1nRJBsIfGOB5cNrKWHv+Qwsol+NO7CUU9NUkH/Ws5FG05bpaIvFEj7sN9m3hzb18QIOVcepl6/wHGgb34HjOMLNJvsUxpsN1TUPZstZbyBts8QaCNqbVUVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jBsqyfMxkxv4qVxEkBG8h1vIvYlJqzwigAxpkJK1Le4=;
 b=JVo5Zp0GhNHw+C0cgwDnIBzRtOUZ+vt1UMgqJkvFuXp5cI2HB9h/gDGQFotoQT2i4LeFfza8syJzw5jS9/gtfsPcgNv7wQ5mN2DMA+tpV04Ag8X5XmpcDpBA8tpLYozi4L5JlyPqKrOUb8tV9LTEKGRJEPD0hteD8sIiKfPdNXBeicw8bvLyE3Tw3oGRGM86GDFqc+aPieyjIdqzvlZWWKckr1m/MkLYBxeIXY2wjSu1yfXfB7OZbPkAoEDChgsUQ8U/w6Z1yNOstiXo+IoTbeSXdaKR8twIFSyPP2Yspw0OyERxVDw0krC4mzY2esMxkAJblDHzlLCpwD60ibpXKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBsqyfMxkxv4qVxEkBG8h1vIvYlJqzwigAxpkJK1Le4=;
 b=vm/R8U6N7KpX8MLQJ8PdnH5s2fDclmMIhT5IbZ3H2Em2nv0yTcsdKSD8M5XtWlkt6lNftRRvbQVx2qYNSfEBOL5x0sR9SikblC6chtxiRsGo8hIKbvtBKUTZwEhMSsU/RatkTMBs719gnaNRWqJTk3FNDq+xUT+KSgUKEZCUclk=
Received: from CO2PR04CA0074.namprd04.prod.outlook.com (2603:10b6:102:1::42)
 by BL1PR12MB5125.namprd12.prod.outlook.com (2603:10b6:208:309::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Mon, 13 Jun
 2022 01:25:26 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:102:1:cafe::a7) by CO2PR04CA0074.outlook.office365.com
 (2603:10b6:102:1::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13 via Frontend
 Transport; Mon, 13 Jun 2022 01:25:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Mon, 13 Jun 2022 01:25:25 +0000
Received: from sp5-759chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sun, 12 Jun
 2022 20:25:18 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH 0/7] iommu/amd: Enforce IOMMU restrictions for SNP-enabled
 system
Date: Sun, 12 Jun 2022 20:24:55 -0500
Message-ID: <20220613012502.109918-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5bb5a961-95cc-4c08-9c75-08da4cdb97cf
X-MS-TrafficTypeDiagnostic: BL1PR12MB5125:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5125E8B18902B6AA3034236FF3AB9@BL1PR12MB5125.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: woKLRF6H2roqQSoRCbrlErqgcEcFse015Um4NesiuAYEcjavA7U/5L31wYyZ8zMEvzGXoTaZ+QeF5LshZv+vqshHhtnOzkGjddtJAWiNj6uKkSmvPi2IH+GKkgp60FZXpbqxiBCPXmEJ0J6nccumxV3LR8PQMih9rGCl31rUhL6PmRmSbPCnmO2FiigUGgNA/+19pGM6XJJtiWOO3F81khlJ+wwtse6QbLgjhV/elU51Rike0Woa2zWmkQYkRvgUOCL3fuaauPTuvN+9asnY5vmE6QebuWsF6Fc+w2YHfGYltT59aM8+vVk+Y1TtechUZAil6UwL5/OQU4iL5rj0nipScXTITBBdKMQ93e+v/KnJA6xwCnoOF86wVQZ8OviAuotnU2c/CbPbtJWbDDtrxNZHv++PFJ76MNb4MQHB6EcL5lsMS/9E6CUO0Pcty7Axs/oiZ8nw+SdN+FHW+3qz1JIcE2ET9JkKU/dj8oD2z7P1cRrMORPfkeydBMyfs/oms5t4yNFTmnZdQ//6+CPhW2l8h4frdTUb9kn2dY+HcG2TgubmzLJc0gkaYPWsE5dmpaF3ylh+sSchnY7Jh8EGDvKffhcd7WtompxWNxBwPBEkBaO2d0Pb/hPsNzueRg8QSGreqPNQmF5aLY0pW311gkNVur6S5zg5PrjySYAmjj1HYupvmgSH5mTLuc5j2yCGZbZuHMWeb1LeaC8riWBBo1JY+PS8TWGXA7yHO8XnSUdefnp6j1WWNYShS0y2PQxIYqoOOZ8jJ/76k+3VLXIJMCnoTUEaQ34fVqeB0wvo8d4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(40470700004)(46966006)(36840700001)(70206006)(70586007)(8676002)(4326008)(6666004)(2906002)(6916009)(8936002)(508600001)(44832011)(5660300002)(966005)(40460700003)(26005)(86362001)(7696005)(316002)(36756003)(36860700001)(54906003)(81166007)(356005)(47076005)(426003)(336012)(2616005)(82310400005)(16526019)(1076003)(186003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 01:25:25.2986 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bb5a961-95cc-4c08-9c75-08da4cdb97cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5125
Cc: robin.murphy@arm.com, ashish.kalra@amd.com, vasant.hegde@amd.com
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

SNP-enabled system requires IOMMU v1 page table to be configured with
non-zero DTE[Mode] for DMA-capable devices. This effects a number of
usecases such as IOMMU pass-through mode and AMD IOMMUv2 APIs for
binding/unbinding pasid.

The series introduce a global variable to check SNP-enabled state
during driver initialization, and use it to enforce the SNP restrictions
during runtime.

Also, for non-DMA-capable devices such as IOAPIC, the recommendation
is to set DTE[TV] and DTE[Mode] to zero on SNP-enabled system.
Therefore, additinal checks is added before setting DTE[TV].

Testing:
  - Tested booting and verify dmesg.
  - Tested booting with iommu=pt
  - Tested loading amd_iommu_v2 driver
  - Tested changing the iommu domain at runtime
  - Tested booting SEV/SNP-enabled guest

Pre-requisite:
  - [PATCH v3 00/35] iommu/amd: Add multiple PCI segments support
    https://lore.kernel.org/linux-iommu/20220511072141.15485-29-vasant.hegde@amd.com/T/

Note:
  - Previously discussed on here:
    [PATCH v2] iommu/amd: Set translation valid bit only when IO page tables are in used
    https://www.spinics.net/lists/kernel/msg4351005.html

Best Regards,
Suravee

Brijesh Singh (1):
  iommu/amd: Introduce function to check SEV-SNP support

Suravee Suthikulpanit (6):
  iommu/amd: Process all IVHDs before enabling IOMMU features
  iommu/amd: Introduce a global variable for tracking SNP enable status
  iommu/amd: Set translation valid bit only when IO page tables are in
    use
  iommu: Add domain_type_supported() callback in iommu_ops
  iommu/amd: Do not support IOMMU_DOMAIN_IDENTITY when SNP is enabled
  iommu/amd: Do not support IOMMUv2 APIs when SNP is enabled

 drivers/iommu/amd/amd_iommu_types.h |  11 +++
 drivers/iommu/amd/init.c            | 111 +++++++++++++++++++++++-----
 drivers/iommu/amd/iommu.c           |  31 +++++++-
 drivers/iommu/iommu.c               |  13 +++-
 include/linux/iommu.h               |  11 +++
 5 files changed, 153 insertions(+), 24 deletions(-)

-- 
2.32.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
