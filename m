Return-Path: <SRS0=qGVY=DL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30747C4727E
	for <iommu@archiver.kernel.org>; Sun,  4 Oct 2020 01:42:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8182206A5
	for <iommu@archiver.kernel.org>; Sun,  4 Oct 2020 01:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AClIH8dV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8182206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2123C85533;
	Sun,  4 Oct 2020 01:42:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Bx-qRw7kSh6c; Sun,  4 Oct 2020 01:42:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6CCE5854AF;
	Sun,  4 Oct 2020 01:42:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4C3D9C0890;
	Sun,  4 Oct 2020 01:42:03 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 750F6C0051
 for <iommu@lists.linux-foundation.org>; Sun,  4 Oct 2020 01:42:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 61B912033B
 for <iommu@lists.linux-foundation.org>; Sun,  4 Oct 2020 01:42:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y+XlwFiYz6mX for <iommu@lists.linux-foundation.org>;
 Sun,  4 Oct 2020 01:42:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
 by silver.osuosl.org (Postfix) with ESMTPS id D0C312035E
 for <iommu@lists.linux-foundation.org>; Sun,  4 Oct 2020 01:41:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+LS95/v5k+1hELGpYSIi5qc8Oqhr7igPUNCjsGNZRaebqePJZs9ckSHsO6er5r7vEAxRDmfmHt/Rb/Bmika/fBRS9aRP8YkDE/W53bDvqNEX3J2g6MyLHTgEz9deW9OkqJzhnKjJ7uDCkW/wgCCr9HXNNycJMm58e1YLsJKK4XhEGNvB2lQk52d2fbpAqqMG3sbRcz1/vN68iTXphyeBTUBfpFBRPovLY+yzk7Z7IxqHzfqvM+NtSQ/K4w4wdGX+b3V+NTZpRsIGpOB3JyO4Bi3scTFgGwVkQOcuYP/6Yz1Kr3blAkjn+Q/YZTAfVq+BaJuFPFsN4sH/F3vCiIalQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+zW/xvPYjDNZCv/jSHE7EVl8OCOJYb0r2lxaobKDek=;
 b=cq6rWel4LMWy2Rb2fuZauCDLOyVPgqtEKRT9hHqH61/Pkpk/UkGEdJhNZiuZHmDBaz8EaL9QjYnfYQKYlng64F6MjpaBzzdl+I7jDmQ1CjigwrY6Ti+qIZw2ZfKGv6McHLj49nI7PJKr5Rbk35PwO7HQBsYSEYq8bwCAlRDYPQ9uivTl+tdCE0P4DMrvaa0ECxdJfRkQqGC4Dt31IKxvrJEmfyQjQCqBb2HWW7b1CRCZ+2cpXDEkRv4dDxJBtRbRP4e9Ni1Du+22H+IYzdGsDU9xRc3G6Y2jafjfOjPXyEczJBpwrf1cquzKgZRrulcCDkX9RYKZHRIK1lcdnUpKYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+zW/xvPYjDNZCv/jSHE7EVl8OCOJYb0r2lxaobKDek=;
 b=AClIH8dVzFEZCDFgP5PCSxVAC7pcqoKDoVdZneqUWazhTYZSK6KowvYhrY+NO+NoJ2Kag4tyKy+xpSU2L5u+GDX3g+d+BztZe2pCHVkwgLbe48+sKy9ypJ/xdf0LaZmNvKaWbEOodd/3THRw4UjShIfR7NgH6wDmZK5sd70ra/c=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM5PR12MB1451.namprd12.prod.outlook.com (2603:10b6:4:d::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.39; Sun, 4 Oct 2020 01:41:54 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e%5]) with mapi id 15.20.3433.042; Sun, 4 Oct 2020
 01:41:53 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH v3 00/14] iommu/amd: Add Generic IO Page Table Framework
 Support
Date: Sun,  4 Oct 2020 01:45:35 +0000
Message-Id: <20201004014549.16065-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SN4PR0701CA0004.namprd07.prod.outlook.com
 (2603:10b6:803:28::14) To DM5PR12MB1163.namprd12.prod.outlook.com
 (2603:10b6:3:7a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx5673host.amd.com (165.204.78.2) by
 SN4PR0701CA0004.namprd07.prod.outlook.com (2603:10b6:803:28::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34 via Frontend
 Transport; Sun, 4 Oct 2020 01:41:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f85b60f1-2e06-4289-bd74-08d86806abef
X-MS-TrafficTypeDiagnostic: DM5PR12MB1451:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB145102949E2C8E5217D0AAD7F30F0@DM5PR12MB1451.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ete+GNiP6dP+VSdOTs3J2TLJP+9GDXulnGDJKsT+MZffQ5xux0WG5NZQmNpwjEJNusshJR3qPfXBRqTvFGvHr2QZ4FT5DcG7FaxGjy3yV/db7SrbTIy/VGTeM6VB3QYokQmhD1T2OmXZzrAZGmRSTmEkO84meUAbUbHtkd1SBgNM3ddrl6Me+rXTRKlMHrPgOl1sSAn6WznMD8+Tq6rINnWd0QmHrdStPF9CS9OEVLJzVsaA8dg8A+FK0CPavQADYec/CmRmpfB8sv9W62IO5fc1tRSlpKnmU4ZAzp44w4S0yr1mgg7GFf4XYMAb6ulRBYlOXRQehiZh+JoBTA4ZEbj5GMpClURweeiW+jcTTVYEhsuXkjVGwYC3mCa/DIgr+hFJ4NyKtTvtOthfwL0y3Y3W6v9+er1eEYLtfkXfsVu7UcZ4t5DmwP6Y3BrUQHIzlMgoNZI+yhxO5j6F1e2CEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1163.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(136003)(366004)(39850400004)(2616005)(956004)(83080400001)(6486002)(316002)(66946007)(66476007)(66556008)(6666004)(478600001)(44832011)(1076003)(5660300002)(86362001)(8936002)(7696005)(52116002)(2906002)(36756003)(16526019)(26005)(186003)(4326008)(83380400001)(8676002)(41533002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: MYOAGaC5yyeeQud2jGMkievsU8+3hO/CsyU+z541lZsA8RJqBqtE6XXCERs2c0x2YGPphU8a6ZCvEYHuVu3SQtD+kS4zDJVY6XFjH6KvUAjeUgmDtXb28492+CxfEHt4QxcxqyWC8XQt9Mkp+vPY9x0SFMkMZ34yjYWdKkzJZJUd3rfPKl2QbAPmpuc1FKpGyME/mPafCMaAlF21A+0LhHy8AnxwjOcmxxfZ7NNJs2bHImHSu3sVudMSVwJ8rbxohOdqlbDeb+Quio5NnUv4BsLEw2O2cW8q7nBfsHQBPEIwi1rf+k3m9IKwbGozX38mt9N7zG+7tMN4/9WvPBoPeY+s+nBFZolJHmm35iQteYWGHUG1qO7o2aBq+abVwzli55EA+S6wxGzTaKypd+RXDdXI8rNP/x66/vMCEXu//nSVEJSlYd7n3qXxep0IIzqRiYJaJZqmopCyT9NnVYQ7fgD2uSZAzKTCnRA33xD9BG9oD66QR3i3AxCsj3cmjntYcboTUlKoEzp1Srh625Icx7t5Mkru74bYeSf6xMbfCSiv2lkXIxHv0ELkp2hSxUutxG3u8SqKCTb3ema2mHpH8anysdA9q6v8QE6wPl9fR5iPNBt9Y8xAZYYogeQkTZXr+00WRlYsbqZjSrgBKoq/5w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f85b60f1-2e06-4289-bd74-08d86806abef
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2020 01:41:53.8382 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MxL9e7NmAaolmAjISKQzUtRCW57T2ZD1TbTnaP2weRw3WEVT60AhtnYobs7ykNbRFwl/eElWaqlIAXdBEb08dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1451
Cc: robin.murphy@arm.com
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

The framework allows callable implementation of IO page table.
This allows AMD IOMMU driver to switch between different types
of AMD IOMMU page tables (e.g. v1 vs. v2).

This series refactors the current implementation of AMD IOMMU v1 page table
to adopt the framework. There should be no functional change.
Subsequent series will introduce support for the AMD IOMMU v2 page table.

Thanks,
Suravee

Change from V2 (https://lore.kernel.org/lkml/835c0d46-ed96-9fbe-856a-777dcffac967@amd.com/T/#t)
  - Patch 2/14: Introduce helper function io_pgtable_cfg_to_data.
  - Patch 13/14: Put back the struct iommu_flush_ops since patch v2 would run into
    NULL pointer bug when calling free_io_pgtable_ops if not defined.

Change from V1 (https://lkml.org/lkml/2020/9/23/251)
  - Do not specify struct io_pgtable_cfg.coherent_walk, since it is
    not currently used. (per Robin)
  - Remove unused struct iommu_flush_ops.  (patch 2/13)
  - Move amd_iommu_setup_io_pgtable_ops to iommu.c instead of io_pgtable.c
    patch 13/13)

Suravee Suthikulpanit (14):
  iommu/amd: Re-define amd_iommu_domain_encode_pgtable as inline
  iommu/amd: Prepare for generic IO page table framework
  iommu/amd: Move pt_root to to struct amd_io_pgtable
  iommu/amd: Convert to using amd_io_pgtable
  iommu/amd: Declare functions as extern
  iommu/amd: Move IO page table related functions
  iommu/amd: Restructure code for freeing page table
  iommu/amd: Remove amd_iommu_domain_get_pgtable
  iommu/amd: Rename variables to be consistent with struct
    io_pgtable_ops
  iommu/amd: Refactor fetch_pte to use struct amd_io_pgtable
  iommu/amd: Introduce iommu_v1_iova_to_phys
  iommu/amd: Introduce iommu_v1_map_page and iommu_v1_unmap_page
  iommu/amd: Introduce IOMMU flush callbacks
  iommu/amd: Adopt IO page table framework

 drivers/iommu/amd/Kconfig           |   1 +
 drivers/iommu/amd/Makefile          |   2 +-
 drivers/iommu/amd/amd_iommu.h       |  22 +
 drivers/iommu/amd/amd_iommu_types.h |  43 +-
 drivers/iommu/amd/io_pgtable.c      | 564 ++++++++++++++++++++++++
 drivers/iommu/amd/iommu.c           | 646 +++-------------------------
 drivers/iommu/io-pgtable.c          |   3 +
 include/linux/io-pgtable.h          |   2 +
 8 files changed, 691 insertions(+), 592 deletions(-)
 create mode 100644 drivers/iommu/amd/io_pgtable.c

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
