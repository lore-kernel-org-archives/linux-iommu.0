Return-Path: <SRS0=1PsK=4P=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E051C4BA24
	for <iommu@archiver.kernel.org>; Thu, 27 Feb 2020 11:38:49 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E155D24690
	for <iommu@archiver.kernel.org>; Thu, 27 Feb 2020 11:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AiRnlgiy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E155D24690
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id C593087EAD;
	Thu, 27 Feb 2020 11:38:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IxrFuXggpPT4; Thu, 27 Feb 2020 11:38:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1764A862B2;
	Thu, 27 Feb 2020 11:38:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 06F2DC1D80;
	Thu, 27 Feb 2020 11:38:48 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4C5F6C0177
 for <iommu@lists.linux-foundation.org>; Thu, 27 Feb 2020 11:38:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3AB3987EA7
 for <iommu@lists.linux-foundation.org>; Thu, 27 Feb 2020 11:38:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ti5ORKYk61F9 for <iommu@lists.linux-foundation.org>;
 Thu, 27 Feb 2020 11:38:45 +0000 (UTC)
X-Greylist: delayed 01:32:46 by SQLgrey-1.7.6
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-eopbgr60072.outbound.protection.outlook.com [40.107.6.72])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 33898862B2
 for <iommu@lists.linux-foundation.org>; Thu, 27 Feb 2020 11:38:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dyMcx0wpMI0LXTSsQHgn1lnQcY3wpH91vvWr9JFLkLfQklc6zLyp6b7ko9wknh7GTPaVbQIILANqVUiAMR+/yU1Ph5jPCT0P1txDoDZR8naw6V2eGtSJpJZxQjSreneA5lCmb1Zy8e+jNw92xFSOiYL9rCynNf/EXNm6yPDRtvyxn7dAFNnDXLB6iehbu5jL3RLkPMbqBKbsy59C2kzxN3+Ip7hmZISnAWtz81z4pOKOEDyeXq50n8iIjqum+Jp26RhmP+F0xkqHadUJp85qqtBDU26xGw9lHgdu9JvxTlxJ+t5FeOLCP1gnWKtkn58218BNawYwgVug3PEH1jPrIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vp/LTPAvf0JpbewNnY3iEKWLkz04nuBGdl0Sv924GmI=;
 b=jYtVXecQsXzxR5T8WC8NkONalt6AKe4jPfQ7gu/8YAkTLSqNxy3KboaXducA4tlLF2Q4n3ouooklP1+Iot2vn2Cijn3rDvX+4fPqyE0uqRN6fzMoFMOShUbaRMtlzYdiPUz3YBIWeuZSBPRoISiBNOhfhQnlKaIGlSOsyC966ozTUEpnHwaAZXXqmhtuQ8IRdKk9CKnsTxB/Mu7CSfYzAqaRxoEB6/HlAASDgeQov835A8mtukfv3TLQvm9uTrE9EwtHLKKhRt3PD6zo5Nkrd6Fyb1Vwb3PEYoKLnDWwGHcJJ43pisTs2c2ASLcs6InEiSWZNPYNDSfZKqfi3VbiFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vp/LTPAvf0JpbewNnY3iEKWLkz04nuBGdl0Sv924GmI=;
 b=AiRnlgiyOIRGHjbeR4yLnOUIoZZuK5L3RFuWOh6xlrCkEhsUcYdNfz424Rvgby9xlSpTSUDlai2DHXg3k5OVIIPXHkElT13LpB+EMxtGMxpJZM+VJMpGCFFkD3/OPjWCmD8LzjwrqISAczpp8fTjZLspuCYoynYLiyOEuERm5rY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
Received: from AM6PR04MB5878.eurprd04.prod.outlook.com (20.179.0.89) by
 AM6PR04MB4312.eurprd04.prod.outlook.com (52.135.165.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Thu, 27 Feb 2020 10:05:53 +0000
Received: from AM6PR04MB5878.eurprd04.prod.outlook.com
 ([fe80::bcef:1c59:7d27:d0e]) by AM6PR04MB5878.eurprd04.prod.outlook.com
 ([fe80::bcef:1c59:7d27:d0e%6]) with mapi id 15.20.2750.021; Thu, 27 Feb 2020
 10:05:53 +0000
From: laurentiu.tudor@nxp.com
To: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Subject: [RFC PATCH 1/4] bus: fsl-mc: add custom .dma_configure implementation
Date: Thu, 27 Feb 2020 12:05:39 +0200
Message-Id: <20200227100542.13819-1-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: AM6P192CA0056.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:82::33) To AM6PR04MB5878.eurprd04.prod.outlook.com
 (2603:10a6:20b:a2::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-101.ea.freescale.net (89.37.124.34) by
 AM6P192CA0056.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:82::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Thu, 27 Feb 2020 10:05:51 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [89.37.124.34]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7a84ab2c-a46d-4f98-a345-08d7bb6ca0fd
X-MS-TrafficTypeDiagnostic: AM6PR04MB4312:|AM6PR04MB4312:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB43129C1D33F2ED76B03C4D35ECEB0@AM6PR04MB4312.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 03264AEA72
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(346002)(136003)(366004)(376002)(199004)(189003)(66476007)(1076003)(66946007)(478600001)(52116002)(6486002)(5660300002)(66556008)(4326008)(7416002)(6666004)(2906002)(8936002)(6506007)(16526019)(86362001)(26005)(9686003)(36756003)(8676002)(186003)(6512007)(316002)(2616005)(81156014)(81166006)(956004)(142923001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR04MB4312;
 H:AM6PR04MB5878.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UsWi/zKS+FmNEMPuo7Io1USJz0q6K3qP+Y3v8mK3rLnaYzMISrq0dFn1D4svCi3QpDPIKVho8olOMSwQo2KWot8KMmx8IMTz4kAIDzitgyvR1mEj8a0lKYCK4Wt4nAFVbHx8J3ddEKkoG+QNbl18d4fJe/vh63ygiJUMZDNh82sqnFqZBKgWs9xUvFhicq0Z2Q4mypv0CoNThaqf2eHMg+i30DZDR/R6huMYRJZ+D+FV2FyEKTfNdGNJIcP2RRqSJd1gbw72GIPQ+bGn3PWW9UmEsDnyU4FDA154a/xpxbr3jNvqP6wJXJwYFm6sSJtjC3XL8yaYrqh1IMyKBnHkSjdlfQW7/Bpci66A52Tk72scT+tHwQ3N1BGHAhyeNVRPjeBJt0wI9o+cajXO4fzckqWDMVVZPIL0Q963ziMAJvAGuzvPdNLuTD6SgVuIIlbK/Y8qgDE400KUMidW6am3q6EZ4AtGUyl0RbhUbKUkQ+WjRl0b1IWl/du4xCoVhpjo
X-MS-Exchange-AntiSpam-MessageData: PuJHmMkcQMRYDsFrr2TEsmbhMVieRqg4tbJwAogPxTIz6XX/TfRY3xK/AQtaA2FxmxOrnTkkBtbDn+Oy3LxT1Qki0GhUfsx33W4qTCX6wWNlTqYn6WKMzmG9KIlIyIFLrXz0VbP4Bwdt3jWrgbmJVg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a84ab2c-a46d-4f98-a345-08d7bb6ca0fd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 10:05:53.0132 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pWpb5+TxiL+gjXLio7s/z96Pk59A9p7TCGNoeFsQ6V/oXOKl/LI9fTDGJaRdzfZeWRjgHTeD5HMyDwILvA4tQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4312
Cc: calvin.johnson@nxp.com, ard.biesheuvel@linaro.org, maz@kernel.org,
 pankaj.bansal@nxp.com, diana.craciun@oss.nxp.com, jon@solid-run.com,
 jeremy.linton@arm.com, makarand.pawagi@nxp.com, cristian.sovaiala@nxp.com,
 V.Sethi@nxp.com, ioana.ciornei@nxp.com, tglx@linutronix.de,
 robin.murphy@arm.com, jason@lakedaemon.net, Stuart.Yoder@arm.com
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

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

The devices on this bus are not discovered by way of device tree
but by queries to the firmware. It makes little sense to trick the
generic of layer into thinking that these devices are of related so
that we can get our dma configuration. Instead of doing that, add
our custom dma configuration implementation.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 36eb25f82c8e..eafaa0e0b906 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -132,11 +132,40 @@ static int fsl_mc_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
 static int fsl_mc_dma_configure(struct device *dev)
 {
 	struct device *dma_dev = dev;
+	struct iommu_fwspec *fwspec;
+	const struct iommu_ops *iommu_ops;
+	struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
+	int ret;
+	u32 icid;
 
 	while (dev_is_fsl_mc(dma_dev))
 		dma_dev = dma_dev->parent;
 
-	return of_dma_configure(dev, dma_dev->of_node, 0);
+	fwspec = dev_iommu_fwspec_get(dma_dev);
+	if (!fwspec)
+		return -ENODEV;
+	iommu_ops = iommu_ops_from_fwnode(fwspec->iommu_fwnode);
+	if (!iommu_ops)
+		return -ENODEV;
+
+	ret = iommu_fwspec_init(dev, fwspec->iommu_fwnode, iommu_ops);
+	if (ret)
+		return ret;
+
+	icid = mc_dev->icid;
+	ret = iommu_fwspec_add_ids(dev, &icid, 1);
+	if (ret)
+		return ret;
+
+	if (!device_iommu_mapped(dev)) {
+		ret = iommu_probe_device(dev);
+		if (ret)
+			return ret;
+	}
+
+	arch_setup_dma_ops(dev, 0, *dma_dev->dma_mask + 1, iommu_ops, true);
+
+	return 0;
 }
 
 static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
