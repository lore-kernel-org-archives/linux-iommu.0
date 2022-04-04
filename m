Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE31C433F5
	for <iommu@archiver.kernel.org>; Mon,  4 Apr 2022 16:47:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9622C8289B;
	Mon,  4 Apr 2022 16:47:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zSPG0LEJxf0j; Mon,  4 Apr 2022 16:47:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 75B51828A5;
	Mon,  4 Apr 2022 16:47:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 32561C001D;
	Mon,  4 Apr 2022 16:47:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EBC2CC0012
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 16:47:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C616C60BD7
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 16:47:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 03oaS6l3_mRb for <iommu@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 16:47:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::605])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A9E0960672
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 16:47:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QfzNfsFxyTgkYz4mCp0kYUL5jQXzA34/Uu449ruGff3J2h11/nc1FqsHW8EuxFIQyNifOrcLe2iknJSPQztBI/9VILeR5nyKq80C4MtoXTPCWfwPvVfBDSLNwiKOF0ZBpECeUPnHiYjhA6tSkFGX997syRS2zQbT+xXqEgG6Qwsn3Vgzks64BKvwvzWcUrCk3TmmJDGQBIzYEHEd6DKPpWo8wsG1T44xQGirUPgImKMVYPS9L+E6LZP9ZqBBCH3Rhh45+MzqkG3hzPWoDo0ct/kBX+nDTy3C4gZKOcbc7Au0eS+SPw0YUbpgpgZ6SifDi9cd1MSEqToWjLNt9kZL2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eEd8QmK3Y1nSAMnzZe3OZ627GVk9DCTl1dw4qnU8vPY=;
 b=kUGAv8F9mbt83FL2QujwDN9tBK2+8IEcdSWShsrRdieQ5l9HjFcIJtW5O+4hJvKnuTdLESJCW0YwddTOAoSCy+utuCLIOfNkWCl22e6GmVXNbdRrDANS0Gfu5QeHr2luUnby9J94WOpcZA2iaEnczqU2hvrA1YslwTPBhyIDLpy89LyR2JJKX9fey8nxwdOyBl98k1/r8zzeVa9dgscxTyJfEHze+Lctd5BdXxWCQQCzO0m05Brc1DCt/RVMjW68XwwajfUE3c7x7fur2M6oIabt6cdTeyLN+G3+PqVQD1Stg0nYbl63hMvCUfkUEFXDIa25Gp2hR12EEqi9SNBCEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eEd8QmK3Y1nSAMnzZe3OZ627GVk9DCTl1dw4qnU8vPY=;
 b=WWnL2Bqxjo65DzLOz0f9Cbm7M5DMJ5QLysjnLlaac3wGmvZzBtgycCwqVULGpNLsmAw0+t5agQBheSF3ptEB6dvSpDpemR5V/0T9Xe2vueB8UnvtjIpOgaqatuKWE9c57Qg5YkfNJywl0VTJLxmlCR8RYhecSF4gzS6+WvK3q1k=
Received: from BN6PR19CA0079.namprd19.prod.outlook.com (2603:10b6:404:133::17)
 by MW3PR12MB4396.namprd12.prod.outlook.com (2603:10b6:303:59::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 16:47:29 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:133:cafe::90) by BN6PR19CA0079.outlook.office365.com
 (2603:10b6:404:133::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Mon, 4 Apr 2022 16:47:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Mon, 4 Apr 2022 16:47:28 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Apr
 2022 11:47:25 -0500
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Subject: [PATCH 0/2] Fix issues with untrusted devices and AMD IOMMU
Date: Mon, 4 Apr 2022 11:47:05 -0500
Message-ID: <20220404164707.1128-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b94de659-901d-46eb-fa7a-08da165acdfd
X-MS-TrafficTypeDiagnostic: MW3PR12MB4396:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB4396BFA0D52BFDBE12E913EFE2E59@MW3PR12MB4396.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UrBsskV5TlLTwbiLExPPZhjngvNOjkxVCaCR6xgtnjauw00x22xTFKZniozO6eEcVSmTSYuudHreXur/07El7GwN1tU4YHGQaoaHoNPwoGa9uA1Ru6NXoyljcosFw6tv3YOOaMH6QJD3gtugzU4FmexfTIusMixq77melQmKN57anrFFqZfONFquERhqAIsskGkerFI9lIllwSx2F0ugLcYN6ncAsMe9Sd1yyTa55E3uHUr3clVNWuG279lVtuTXukxYpCP48eeWzRl87PZ0qktRx9WncFM0+yKdimWHcZ4WgufKGmMPZRlm4bUfLLJ11rRYSqrwWuzaoi3m4zU6o7DLUGmx9OBfJ0C15FSjez1jsh3IApyOo4uLUtNwHzO3Aw0FQj9LudMvgjhPjYX2ZqDWSFbwKx9Z7ubuVZlnQ4K69zzggYh75Ujq/tdjmiO0BNTiJ/zziCHuSreJQw6WFqdoAEbe/cIchFge3h+120+9ub2EU9nO74DSP/02whN4hkLa/41SdtX3CtKCm/K2EAy50OaaL3FQKSfndve38iV4q+56LGfmDWaZCtNVTQlIBdLnw9aR0oLobeuQaWAmwWgZnXHmfb4ii5iyPBfkPg5RfazS1nVbSjKyAwNWFV/tGFiO55Nyj6kUiH3jEypohG78zeX/4hqLZ0FxK6+6BBDaZefRbWNikJx7WuwiEX0OCtR7y+zWjVdLqYQa06zhzQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(2616005)(1076003)(110136005)(36860700001)(44832011)(82310400004)(54906003)(316002)(83380400001)(356005)(2906002)(8676002)(26005)(4326008)(186003)(47076005)(16526019)(70586007)(70206006)(426003)(7696005)(508600001)(36756003)(81166007)(336012)(6666004)(8936002)(40460700003)(5660300002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 16:47:28.4563 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b94de659-901d-46eb-fa7a-08da165acdfd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4396
Cc: Hegde Vasant <Vasant.Hegde@amd.com>, open
 list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Robin Murphy <robin.murphy@arm.com>
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
From: Mario Limonciello via iommu <iommu@lists.linux-foundation.org>
Reply-To: Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

It's been observed that plugging in a TBT3 NVME device to a port marked
with ExternalFacingPort that some DMA transactions occur that are not a
full page and so the DMA API attempts to use software bounce buffers
instead of relying upon the IOMMU translation.

This doesn't work and leads to messaging like:

swiotlb buffer is full (sz: 4096 bytes), total 0 (slots), used 0 (slots)

The bounce buffers were originally set up, but torn down during
the boot process.
* This happens because as part of IOMMU initialization
  `amd_iommu_init_dma_ops` gets called and resets the global swiotlb to 0.
* When late_init gets called `pci_swiotlb_late_init` `swiotlb_exit` is
  called and the buffers are torn down.

This can be observed in the logs:
```
[    0.407286] AMD-Vi: Extended features (0x246577efa2254afa): PPR NX GT [5] IA GA PC GA_vAPIC
[    0.407291] AMD-Vi: Interrupt remapping enabled
[    0.407292] AMD-Vi: Virtual APIC enabled
[    0.407872] software IO TLB: tearing down default memory pool
```

This series adds some better messaging in case something like this comes
up again and also adds checks that swiotlb really is active before
trying to use it.

Mario Limonciello (2):
  swiotlb: Check that slabs have been allocated when requested
  iommu: Don't use swiotlb unless it's active

 drivers/iommu/dma-iommu.c | 3 ++-
 kernel/dma/swiotlb.c      | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

-- 
2.34.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
