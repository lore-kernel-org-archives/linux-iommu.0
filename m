Return-Path: <SRS0=mWFx=7O=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9495C433E0
	for <iommu@archiver.kernel.org>; Mon,  1 Jun 2020 05:58:20 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3EA8206C3
	for <iommu@archiver.kernel.org>; Mon,  1 Jun 2020 05:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dB/C9Zjc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3EA8206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 58D8089572;
	Mon,  1 Jun 2020 05:58:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0+rvdLmJHr2D; Mon,  1 Jun 2020 05:58:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9708189566;
	Mon,  1 Jun 2020 05:58:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 896D9C0178;
	Mon,  1 Jun 2020 05:58:17 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6D868C0176
 for <iommu@lists.linux-foundation.org>; Mon,  1 Jun 2020 05:58:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 4F1D52637D
 for <iommu@lists.linux-foundation.org>; Mon,  1 Jun 2020 05:58:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B8g6EiLgW2PO for <iommu@lists.linux-foundation.org>;
 Mon,  1 Jun 2020 05:58:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
 by silver.osuosl.org (Postfix) with ESMTPS id 15DB724D71
 for <iommu@lists.linux-foundation.org>; Mon,  1 Jun 2020 05:58:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IiLNBR69NkEaHSyloncVFgkO0YsJunEzezWLcr5lWJ+fV5kIir4jwB6aHZ/AR10z0Jtg57wzvQGfSTjuwlMV1HAAwM1eV6RVuzhuQ4Io9xQKlb9lS+uIEPUjDsi5APwjXasvDBm+pdZCOYHvMZ220q60XknGGb/aAbCN9TktVa8VS5A0YuDzDnkgvTyaAdIvACA3COEFpgTM6HU9MQSXtvg0ddTUNsYZo4E5NRGC/U1xQ5BfrqPjiWwbj0LLo3xjIef4w0MNgt2JuAaDeolhxY3U6Spj6PD6p3WYZX1eoDDp4BzOjKQ3ZAxPJ5E/nnGieX6Pw9Ho6MEZx/rVXkQa9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejrhjoBHAdhARXPkLTr4VMCW8/StXZ0D8pBTcvNId1Q=;
 b=gBa8DPQKrjLpY/TJV1P6wSU0WpepoERvl2+77i5r1Dgstt3qHaGO+Le5pGv2vZ8v6c3Dtzw7lDXBs6mdjnPMkuEPU41BiMfWEx0s+aYIUYA/xOYJ/nlR4Vh+gwhqSQuiUxRXpEbokoiblYvF7dAdUXWPLwM9ua0j2Wm2g05R80pYgc9CPYRoPv+roQ0tcJ84NZZsBuSfyn9Xuy0JHp44NRoep0iq1iFjnmBpS8mUQLdPhdxdnjddxtEfgz+3vBnPfbSN+5uCWpQpqWgIUonu7FAnyorLeNpaeBkSd16l5oKCKV4XjCgy0RV6pWK3mvw2uV5Q+eOn6zYOzzNBFLZNKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejrhjoBHAdhARXPkLTr4VMCW8/StXZ0D8pBTcvNId1Q=;
 b=dB/C9Zjc8NQukerJ7TvbSeLbkGh0+N+f1Nqw+lR7to6hdGJGcp/qjNExltwB1qfgqF0mO2p0r4EJtLdqTqOzNIbNqQgnWH3KVwLwaVbUcMPkQnAyOFLGSbtgbxKHeQdsCq7uAtTKbzsyT1BEaxR80qsV8F5q8TzILUTm6rbaYo0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM5PR12MB2567.namprd12.prod.outlook.com (2603:10b6:4:b2::27) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.22; Mon, 1 Jun 2020 05:42:56 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::d061:4c5:954e:4744]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::d061:4c5:954e:4744%4]) with mapi id 15.20.3045.024; Mon, 1 Jun 2020
 05:42:56 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH] iommu: amd: Fix IO_PAGE_FAULT due to __unmap_single() size
 overflow
Date: Mon,  1 Jun 2020 05:42:40 +0000
Message-Id: <20200601054240.237477-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: SN4PR0401CA0007.namprd04.prod.outlook.com
 (2603:10b6:803:21::17) To DM5PR12MB1163.namprd12.prod.outlook.com
 (2603:10b6:3:7a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx5673host.amd.com (165.204.78.2) by
 SN4PR0401CA0007.namprd04.prod.outlook.com (2603:10b6:803:21::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19 via Frontend
 Transport; Mon, 1 Jun 2020 05:42:55 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7ee19977-5089-4537-0251-08d805eea270
X-MS-TrafficTypeDiagnostic: DM5PR12MB2567:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2567D0B6CDA4E800D63291B9F38A0@DM5PR12MB2567.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:478;
X-Forefront-PRVS: 0421BF7135
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pLIEe3pW5psXYA3w/5dNGGGVI4VeWX0jWz+qNAWAR7BcFWW55/yfy2CGn8TEX81hE98X+gm+SIeEBgQfVEqtOFtLSE4VFyTRpzjgeYP1N1v5lQWayKJNQJ2YmhxkDIP6KKo3BwvYJoij79jye+g5NVWT0G6XM+A866oEhYngK+mzBQlZAApHPN6YspKj7EtYbULedIhou8RSRubganL5UCAK9kyR2h+RI3EZpvfxL10lzwq3elbebtNF56OfrN/6YF1e1m4SORoHcfPsmouQvqIqksBBwAeB2uc7vOTJmsSTTYL9gS0pqCCcJ8sqF2yiNW3LsDMwaPnOmkqquHuFOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1163.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(366004)(39860400002)(376002)(346002)(2906002)(36756003)(26005)(6486002)(478600001)(83380400001)(86362001)(2616005)(956004)(66946007)(1076003)(6666004)(8676002)(16526019)(5660300002)(186003)(66556008)(66476007)(8936002)(4326008)(52116002)(7696005)(316002)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: hoBSlxhFq/vs6NpqkD04e1BJKRxlvZbJKQBxxERn9dVehHYGxG788mwtB6v0GEclqj8cVIpMWQjIpV23GlIplfl88IBwqZIPaOMKuURSDFdou5fmh1TgrJHkh2vgE1pz5Yu6fM86if5zcRGWUyF9YTf4UM1ChkGNL/gMmR8K8/3SC1tznazNRcNTGrecZz8W5LMjEYWsfJ4kU9yeFXyB4vDqf/DauIWz7Uh6nmeficnk7nOEg2E2Q2bOnm/MjeZ7Qt20h4lxGrjY0bPiS2bT9UEiXZ4mVQl0WIRgEE+mLnr0TpLEbrpxFDT3hSOQDpi7Tl1+rFPd7lPLxVSBF6NCsT2lYe5Ul68HXSZOj3rcWEvU5X9VjBTekfYzxvyn4EV/XWC/me7DhmyLl/Asm5hZaJdm20GID4bmRbV7kOGnEdmLSO4THyhFnRLgbESeNIct9YoDk7WDXbZP3SlXyWNiycRYMGX8P2F809qbszdUEI8=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ee19977-5089-4537-0251-08d805eea270
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2020 05:42:56.2288 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aiMtiBcQuFWYahCb/hKlvyL9Vy2AVoMYoPFP9ccmki8cdrgOroUFrH3la9bgOcj41GwK+Ks/FCglEBhOo8AisQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2567
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

Currently, an integer is used to specify the size in unmap_sg().
With 2GB worth of pages (512k 4k pages), it requires 31 bits
(i.e. (1 << 19) << 12), which overflows the integer, and ends up
unmapping more pages than intended. Subsequently, this results in
IO_PAGE_FAULT.

Uses size_t instead of int to pass parameter to __unmap_single().

Reported-by: Robert Lippert <rlippert@google.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
Note: This patch is intended for stable tree prior 5.5 due to commit
be62dbf554c5 ("iommu/amd: Convert AMD iommu driver to the dma-iommu api"),
where the function unmap_sg() was removed.

 drivers/iommu/amd_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 32de8e7bb8b4..7adc021932b8 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2670,7 +2670,7 @@ static void unmap_sg(struct device *dev, struct scatterlist *sglist,
 	struct protection_domain *domain;
 	struct dma_ops_domain *dma_dom;
 	unsigned long startaddr;
-	int npages;
+	size_t npages;
 
 	domain = get_domain(dev);
 	if (IS_ERR(domain))
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
