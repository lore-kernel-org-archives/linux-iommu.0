Return-Path: <SRS0=7g3a=6M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5EEDC83000
	for <iommu@archiver.kernel.org>; Tue, 28 Apr 2020 10:15:53 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B1FE206C0
	for <iommu@archiver.kernel.org>; Tue, 28 Apr 2020 10:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fBYvXLKC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B1FE206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 64FF086D96;
	Tue, 28 Apr 2020 10:15:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5l2cXL8S2xVq; Tue, 28 Apr 2020 10:15:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id CC56884B36;
	Tue, 28 Apr 2020 10:15:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BFC2BC0864;
	Tue, 28 Apr 2020 10:15:52 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D38E7C0172
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 10:15:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id BF94286D96
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 10:15:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lTe1TP42DE-5 for <iommu@lists.linux-foundation.org>;
 Tue, 28 Apr 2020 10:15:50 +0000 (UTC)
X-Greylist: delayed 02:33:13 by SQLgrey-1.7.6
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr20042.outbound.protection.outlook.com [40.107.2.42])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1AD6784B36
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 10:15:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lE3TeS5dkRT/u0hmCvM+eWzPLB/At1kA+AJHv7vlEVoZiahHi7TWvqFJ3CW+B0Pp1C+TCZ44qLrF4MVPE9qXIdzJINB9q3tO00NRdgpLQr8bq7tAscdeJouVx8pS0bA5X/avp4D+v8jE7qLZZA8suanrSGetQPS/b96cmd5tiC8PvC6p+HUlXp+SqlfJY58WR8+fOtqZZDLtToObqmkaOOduNMrJtitkBqyGw+kVPaCiCRYl7DrjtBYJI3sC5z+lmETLEp2QJP2ycdcejjREtA38gK6eDH2uGQtrlKMjwV+cbJ7YnRUNE3LO4GnqiJwsEDa2WxdmYLKmVdfi/iFt2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ghtKKDlC9f/+o/B0RxHJt1RlPJtIYobSgYs1yRAo1cI=;
 b=SZ5d5zWMRofV6V/kqtNluQH1KQcezb7683XBFwPvv3701E1+ud47gZVj7qAY1lLmsoZ+1YqNXPkiNP1UhljelUCAd4V7vCe2Ia+IcYC6um/87jxNfNP+YXLfyQRwdiaMX+RpdMHNTLyYp9gQ5c1aX+uS+Uk9s3+wCLe6AVrb2uM0QyV2psNsGGyM0TJ9cQ2C3mFISoObM/RVTi5rB/NbSxw9WdHg1prWdF58ELlUFRUECmIZLiLogeoeCrDME3UBh2wRv3lL4h6gb/52GaPkc473XTJ9Vu4sXzyUSKJBthJqo8slD3O6AodAuujSfFqXWgmKaEynfL6SdtA9hqFuTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ghtKKDlC9f/+o/B0RxHJt1RlPJtIYobSgYs1yRAo1cI=;
 b=fBYvXLKCy2zEG7eiAYyVyOngVT1E4RUUXYhQiz0AqIH6J67vbSM5ozgw757p1HrBl5edY3pGoRE1n8YTTKyQ7Fi9fnpuiTWOL04UMxa/TrNS99QNLKV8Itg4J1oc5J8QZzo/PEBhqrH+OIVkVRmxGttUOQ8L7QVOCWPCNBSObV4=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2775.eurprd04.prod.outlook.com (2603:10a6:4:99::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Tue, 28 Apr
 2020 07:42:33 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.2937.023; Tue, 28 Apr 2020
 07:42:33 +0000
From: peng.fan@nxp.com
To: konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, jgross@suse.com,
 sstabellini@kernel.org
Subject: [PATCH] xen/swiotlb: correct the check for
 xen_destroy_contiguous_region
Date: Tue, 28 Apr 2020 15:33:45 +0800
Message-Id: <1588059225-11245-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: SG2PR0601CA0010.apcprd06.prod.outlook.com (2603:1096:3::20)
 To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by
 SG2PR0601CA0010.apcprd06.prod.outlook.com (2603:1096:3::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2937.13 via Frontend Transport; Tue, 28 Apr 2020 07:42:30 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 88a53fa9-b69f-49ae-8dbf-08d7eb47b69b
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2775:|DB6PR0402MB2775:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0402MB27757FDEE7409ECED1B91F8188AC0@DB6PR0402MB2775.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-Forefront-PRVS: 0387D64A71
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB6PR0402MB2760.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(396003)(39860400002)(136003)(376002)(186003)(26005)(5660300002)(69590400007)(86362001)(478600001)(66946007)(6512007)(66476007)(66556008)(956004)(9686003)(45080400002)(6506007)(6666004)(36756003)(2616005)(4326008)(8936002)(8676002)(52116002)(16526019)(2906002)(81156014)(6486002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VKLdp/orntAdGjO+9DyQ4iWLhiOQ6BgNDkN1hq0yxTdn7Qnp+7uxxsKph9uTzfaBd7DhDH2G28HIPcbi/kk+r0R+Ns54lJbHPaz3rBRfhIDg/aXvMwzWcoU/YCRsS9JJ4BVifM/FPfFajNKlHcKVlo+fmXuvLiAP5cibm70lFz0TQIt210nVAbdTOEYwPvQoWIuI13njpa+EQ119648x8k+ZCoaFjo8UQ0uDeYlDeb3sH8ZJMuVqy2Lj61E7v1QtYA9wF0mcMsOwl/qoj20WdZ0QpaOA0kSMFQx2lrww1F6lIV9DDcAGTPKkJWHtTb+BDM3hmPXN3dtGxOCmq4YnENpX6dR+9t36ZyXr670vIQFQkASFzwGEhWf92kbEZqEXR4AE0nUM3TdoSaK9gvamJFYmGkDxj/kbicEmQwvIDDr7WzZOgpit7KruZ3VbCE0zxCB/NmhDyCcZcsYJMMqeQYdZooUOmFcABAHQ2bnRUeWP21YGxZ6Sti+V9Hoxc9cG
X-MS-Exchange-AntiSpam-MessageData: Zk7f7i+o2viB7Jgl5mrSR1/CCHr1NRenCZXGkkc/I+9xeNir+x4bIyepOt+yyoBzeLU4aXh0vNk+quNbMS/Ia8ojfThG/bghsfrsNVBgC+/RrqxZaC2/nSbu4Ut72DIAhgFN+3bbta4YlnHkg2W+qTk2BaVm771muo/SDeTw8YVkV3cxyQ28p6+d8D3lkXfSYDeGi7JYIIWbSxJg4lCZm7+JRabwjUEpFAv9NdqmSnuIJEz8b2X/kdurSUGSn4+hVhuzTLisSJYbfSbBmz2rK7gHbLjZxECqI5Xjv8AC3iasGI+RVF8FBp6Ca3ee+CsagUFdL8McUvHdMoORbYWMcN32yiBUDGAXY7lVLe2Ia6tGyMKRQShoKfiLnEPwZsBdRziqtiSP60N78vj12q81hAuN2OtN/eV6WTkzcm6GweOhENmyQ9dv30LQCVOzr6HTfYRJoyRcy0q/tTdNMdGn1upXdtgHiP3v0ohyjwcPkDtGqUWm2huXcgjO7bCaJ9/V1kkNDSzfEOCuIts643/JeA6GM86lGVRYjGP7Awn7pcHmXOGgk0htVDBlZyvdX7NfVYOcD0AU55ER7U2ALt0br1SoRxasbEjom/NUPU3PICzdFomFXM9jWeK9pivCLhW6BvQ7fUTEKKU7q5HTU5avpdaOn1nxM0l6Felzo8Yrv+GkIGiRw6lKS5rga6FaSdJ2FYloKDNClLDgwO+jy4IoiHaXl1zojySo9Om5PLllJCz0sbOLB2cCL1obBJwcciVPL6z0nF7uzchcL4Ym9wIpd9q0Chn8bz74XlrGZXOgGFI=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88a53fa9-b69f-49ae-8dbf-08d7eb47b69b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2020 07:42:33.7546 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gpAo6zFgx2yanelGIdZXEjn9aRuVxqn9rP/bKhZp507od0M+GKbRuN5wF0Oov1eF4dgWG1zimXqHquqgOPdhmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2775
Cc: xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
 Peng Fan <peng.fan@nxp.com>, linux-kernel@vger.kernel.org, linux-imx@nxp.com
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

From: Peng Fan <peng.fan@nxp.com>

When booting xen on i.MX8QM, met:
"
[    3.602128] Unable to handle kernel paging request at virtual address 0000000000272d40
[    3.610804] Mem abort info:
[    3.613905]   ESR = 0x96000004
[    3.617332]   EC = 0x25: DABT (current EL), IL = 32 bits
[    3.623211]   SET = 0, FnV = 0
[    3.626628]   EA = 0, S1PTW = 0
[    3.630128] Data abort info:
[    3.633362]   ISV = 0, ISS = 0x00000004
[    3.637630]   CM = 0, WnR = 0
[    3.640955] [0000000000272d40] user address but active_mm is swapper
[    3.647983] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[    3.654137] Modules linked in:
[    3.677285] Hardware name: Freescale i.MX8QM MEK (DT)
[    3.677302] Workqueue: events deferred_probe_work_func
[    3.684253] imx6q-pcie 5f000000.pcie: PCI host bridge to bus 0000:00
[    3.688297] pstate: 60000005 (nZCv daif -PAN -UAO)
[    3.688310] pc : xen_swiotlb_free_coherent+0x180/0x1c0
[    3.693993] pci_bus 0000:00: root bus resource [bus 00-ff]
[    3.701002] lr : xen_swiotlb_free_coherent+0x44/0x1c0
"

In xen_swiotlb_alloc_coherent, if !(dev_addr + size - 1 <= dma_mask) or
range_straddles_page_boundary(phys, size) are true, it will
create contiguous region. So when free, we need to free contiguous
region use upper check condition.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/xen/swiotlb-xen.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index b6d27762c6f8..ab96e468584f 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -346,8 +346,8 @@ xen_swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
 	/* Convert the size to actually allocated. */
 	size = 1UL << (order + XEN_PAGE_SHIFT);
 
-	if (!WARN_ON((dev_addr + size - 1 > dma_mask) ||
-		     range_straddles_page_boundary(phys, size)) &&
+	if (((dev_addr + size - 1 > dma_mask) ||
+	    range_straddles_page_boundary(phys, size)) &&
 	    TestClearPageXenRemapped(virt_to_page(vaddr)))
 		xen_destroy_contiguous_region(phys, order);
 
-- 
2.16.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
