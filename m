Return-Path: <SRS0=J+1i=42=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC7EC10F27
	for <iommu@archiver.kernel.org>; Mon,  9 Mar 2020 14:01:14 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDC2820848
	for <iommu@archiver.kernel.org>; Mon,  9 Mar 2020 14:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=allegrodvt.com header.i=@allegrodvt.com header.b="NNefryjh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDC2820848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=allegrodvt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 577A088424;
	Mon,  9 Mar 2020 14:01:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GJCfXJbIotrz; Mon,  9 Mar 2020 14:01:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B631788304;
	Mon,  9 Mar 2020 14:01:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9DBDCC1D74;
	Mon,  9 Mar 2020 14:01:11 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 163C0C0177
 for <iommu@lists.linux-foundation.org>; Mon,  9 Mar 2020 11:35:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 007E7204F1
 for <iommu@lists.linux-foundation.org>; Mon,  9 Mar 2020 11:35:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b69c2navdKXh for <iommu@lists.linux-foundation.org>;
 Mon,  9 Mar 2020 11:35:40 +0000 (UTC)
X-Greylist: delayed 00:33:35 by SQLgrey-1.7.6
Received: from FRA01-PR2-obe.outbound.protection.outlook.com
 (mail-eopbgr120130.outbound.protection.outlook.com [40.107.12.130])
 by silver.osuosl.org (Postfix) with ESMTPS id E9BFB2044A
 for <iommu@lists.linux-foundation.org>; Mon,  9 Mar 2020 11:35:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FFwOQX81qJbmvkjK9tI3+S8+Sb0Y5i84LzkyWLnn1ehbNRyEHJBktNusSmIy9MMLYvSDjs2mRNUbnIaudfnLMC5JbKkuN+hAw/p1IBrCsh0Bce+ZsRcLTB6UHVpXbeKmtxXb/P7u3HptvxKZLKg5jhoICtGDeGFZMm8kFhP/MQtnsVotpU97J7SBowt9TRtb7MMB05xr7i0LmtGlLIy/ACMCCPFcjT7Cc1Dj3hGuxYX8QWYF5I5ydVXn/etZWP1+TfsheS8y9ZDYj1U5e7NYPqxVtpN9nWWyC+oc7G5Uj21I8pmgZ81Ac5o6HIkeR+ex+kraudmK6atfIAjKlNeXtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKPan/O3hVtiHwEXslEimju9CC00fad6uM7mLTK/lGw=;
 b=VvnAqVqlhPGgCqC6gP574vLEmyEb3l0+kp3RCaTPQ6zE+c3vo0pQ180ha7fZfYCMiO8WfbKnTBBpbPW5R2GS3y2XtAmdao528bBlZJBxOMgvZmXX+Z82Iansb3mPqV+JXkNjxk2k2GwBSy0y01dFRAA4p8WUJJDeIMY5I94mBBt+rF8ULTg7eaFD936HAoBmuPkX0GTeMbS2WRYo87PL0fDWvOh+t/qfuHOT5X+1+nnqHZfTXM38vv/Nt+QBwUuOO1740Ot3BD2aRlb1AFb0+bNNdCzjcOOGOLJfX3RMNOEnKju0dxlT6wQqoozMvN8fBbk0gJESwwLlAqpd2ssajQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=allegrodvt.com; dmarc=pass action=none
 header.from=allegrodvt.com; dkim=pass header.d=allegrodvt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=allegrodvt.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKPan/O3hVtiHwEXslEimju9CC00fad6uM7mLTK/lGw=;
 b=NNefryjhSXXNmmJkwyWSfdDbKvcESmIc0ybdPMnNcXcNXY0BC3Vars2W2Nn9QyxQncefsFF4DDUW+PyxqNT3IeMGx+EvfN5uMeySsrcNfJOjdaKOuEh3MxlymnXcYb/aA6cF1U5LAhcwsAswk0fnpUa6fiVbD3nYrbLwYTBYxy8dUa9xr8SpTSVAIH39ThOkEt6L/+szlPWGDx8bODqNmq35l69AU7ivZ/fmFafufO9O5SnvfgA9A3+TZeQmmcYihRo/Q6+JvglqQBJABFzFZxN4wPzGh2sd1kaX6d6u2ksIVdFEG3Sg7agCPeJRsm08PqVI88eF3Gi7HhHZJqd8Fw==
Received: from MRXP264MB0584.FRAP264.PROD.OUTLOOK.COM (52.134.49.145) by
 MRXP264MB0775.FRAP264.PROD.OUTLOOK.COM (52.134.50.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.15; Mon, 9 Mar 2020 11:02:01 +0000
Received: from MRXP264MB0584.FRAP264.PROD.OUTLOOK.COM
 ([fe80::84af:fd44:26b8:7b02]) by MRXP264MB0584.FRAP264.PROD.OUTLOOK.COM
 ([fe80::84af:fd44:26b8:7b02%5]) with mapi id 15.20.2793.013; Mon, 9 Mar 2020
 11:02:01 +0000
Received: from localhost.localdomain (185.223.150.134) by
 PR1PR01CA0009.eurprd01.prod.exchangelabs.com (2603:10a6:102::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14 via Frontend
 Transport; Mon, 9 Mar 2020 11:02:00 +0000
From: Kevin Grandemange <kevin.grandemange@allegrodvt.com>
To: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] [dma-coherent] Fix integer overflow in the reserved-memory
 dma allocation
Thread-Topic: [PATCH] [dma-coherent] Fix integer overflow in the
 reserved-memory dma allocation
Thread-Index: AQHV9gIojfo28FidqUKDX3pC8DIbLw==
Date: Mon, 9 Mar 2020 11:02:01 +0000
Message-ID: <20200309110134.7672-1-kevin.grandemange@allegrodvt.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR1PR01CA0009.eurprd01.prod.exchangelabs.com
 (2603:10a6:102::22) To MRXP264MB0584.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:23::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kevin.grandemange@allegrodvt.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [185.223.150.134]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0dce2dd0-144b-4d57-f51d-08d7c4194b3d
x-ms-traffictypediagnostic: MRXP264MB0775:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MRXP264MB07754502FB70CD7D5A83750387FE0@MRXP264MB0775.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0337AFFE9A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(396003)(136003)(346002)(39830400003)(189003)(199004)(6486002)(81156014)(8676002)(6512007)(8936002)(81166006)(52116002)(2906002)(71200400001)(316002)(54906003)(5660300002)(66446008)(508600001)(107886003)(66556008)(64756008)(4326008)(1076003)(36756003)(6506007)(66476007)(6916009)(66946007)(44832011)(86362001)(69590400007)(26005)(186003)(956004)(16526019)(2616005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MRXP264MB0775;
 H:MRXP264MB0584.FRAP264.PROD.OUTLOOK.COM; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: allegrodvt.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JaKkOF55p9jmT3yMiMb7wsWeF1Prt54lqUVw+U9+Jw3BrY+08XzFhmUv9MvsELDHJBlGFSV4AObI/eq4vijI4g7XzuJmLCWxyXcYz4kRul5/t99P43snWMcFCVSulxXXBF6yrYlUKGMLP+IDnyvpHAI1Ckh7XriufSQGEhzAl8B/DuTv40EVp1h5UEna6z5QW7fc15le3gxU8t/JFp+OOruzh/IwR2QI9aMEtVXO/jv4lCzGuh1Xwv14JxrghRWS4BtL+zN9zFcdzhmp0963C1lhCvSySpg8GrPK0i1nMU5Xun97SkXuJsSHsuJQJvVjnUx7actSPap08s2EjxQPEN7XyFi73OzHOSRfJWCJLrTKqoo06e95yJIOF1gMTRGVPqjfitozguSLQ6MbR7Ftuz8oQCNP/7nx1DzmKtxdJWC6xzApIIoz3Wh9cdVzOEzgU3OogIce7vvWwX+TBKL1aSsB7R/x7Qa7zGfomRxA1Hy16DmezZ4d0Bd36TUGcnsa
x-ms-exchange-antispam-messagedata: cWFkmgbVlzhm1kVSQYlCS8+9Dr1TZ7bg9Ob45ZUhlnn+6N0mw77fGEgDHlXKCP5RNx/MYHpLbSl0S9DDqeMOTwNk8wyr0KoAkeTpDd9u1ZgiNiE7fWeWEDXpD3gnHIo2qDTbjIitZR2Zalf1gg+23w==
MIME-Version: 1.0
X-OriginatorOrg: allegrodvt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dce2dd0-144b-4d57-f51d-08d7c4194b3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2020 11:02:01.2732 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6c7a5ec0-2d92-465a-a3e1-9e3f1e9fd917
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kgd+1kWKUcvbjsikHRqVhibEaywBRU2GyvuYQwwTteFN4c948jd26IBK3HI5gHHAfxi1bmSyDjwe8R1u7X9/aXI/9rHWyKjKydpFcPZ0Xd6ap7vRbwaTVDUyWtd1n2Eb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRXP264MB0775
X-Mailman-Approved-At: Mon, 09 Mar 2020 14:01:10 +0000
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Kevin Grandemange <kevin.grandemange@allegrodvt.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

pageno is an int and the PAGE_SHIFT shift is done on an int,
overflowing if the memory is bigger than 2G

This can be reproduced using for example a reserved-memory of 4G

reserved-memory {
		    #address-cells = <2>;
		    #size-cells = <2>;
		    ranges;

		    reserved_dma: buffer@0 {
		        compatible = "shared-dma-pool";
		        no-map;
		        reg = <0x5 0x00000000 0x4 0x0>;
        };
};

Signed-off-by: Kevin Grandemange <kevin.grandemange@allegrodvt.com>
---
 kernel/dma/coherent.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index 551b0eb7028a..c20c6c0635b7 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -130,6 +130,7 @@ static void *__dma_alloc_from_coherent(struct device *dev,
 	int order = get_order(size);
 	unsigned long flags;
 	int pageno;
+	ssize_t mem_offset;
 	void *ret;
 
 	spin_lock_irqsave(&mem->spinlock, flags);
@@ -144,8 +145,9 @@ static void *__dma_alloc_from_coherent(struct device *dev,
 	/*
 	 * Memory was found in the coherent area.
 	 */
-	*dma_handle = dma_get_device_base(dev, mem) + (pageno << PAGE_SHIFT);
-	ret = mem->virt_base + (pageno << PAGE_SHIFT);
+	mem_offset = (ssize_t)pageno << PAGE_SHIFT;
+	*dma_handle = dma_get_device_base(dev, mem) + mem_offset;
+	ret = mem->virt_base + mem_offset;
 	spin_unlock_irqrestore(&mem->spinlock, flags);
 	memset(ret, 0, size);
 	return ret;
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
