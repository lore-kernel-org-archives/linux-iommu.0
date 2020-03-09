Return-Path: <SRS0=J+1i=42=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCEDC10F27
	for <iommu@archiver.kernel.org>; Mon,  9 Mar 2020 15:22:12 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5BE52067C
	for <iommu@archiver.kernel.org>; Mon,  9 Mar 2020 15:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=allegrodvt.com header.i=@allegrodvt.com header.b="L2KNPXeR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5BE52067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=allegrodvt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9D3F2886C5;
	Mon,  9 Mar 2020 15:22:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5ZkrkF9qLuWj; Mon,  9 Mar 2020 15:22:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9B21B87AFE;
	Mon,  9 Mar 2020 15:22:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8B183C1D74;
	Mon,  9 Mar 2020 15:22:10 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1AA53C0177
 for <iommu@lists.linux-foundation.org>; Mon,  9 Mar 2020 15:22:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 15CB387244
 for <iommu@lists.linux-foundation.org>; Mon,  9 Mar 2020 15:22:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4Zg6SY011kMa for <iommu@lists.linux-foundation.org>;
 Mon,  9 Mar 2020 15:22:08 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from FRA01-MR2-obe.outbound.protection.outlook.com
 (mail-eopbgr90123.outbound.protection.outlook.com [40.107.9.123])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 869918723F
 for <iommu@lists.linux-foundation.org>; Mon,  9 Mar 2020 15:22:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VFZ1UX2EcNhDuSRsM2pI8R00lgrhBm96uOBQvS1m8cREnQFVx+9CyP1WIL+RuMo3BDobvjBl1vvTXduZGlBtG25wmcin3j10R+h75msDdTsAsqI3wcGpcXmumPAgp9lWzDABATHQgFCFg74KhLWkZFIk3UWyF/RSw9XJ6Zg1s03AdGRAQcnxgR3DcOACcz4Ey9PBs6Uw4SPx8UQaVFCphQADdtTLLpd5bHV2jJ2AgXtK+h1kNqUF164KkFu+XjiHr7n6GpC4+KWortYqfEIg27R0qNfyOpJvsNK6y3HIoqiOjC6u2eivdT1x6PmM6GsC+agiJCr6kb0pPJ3nbyW/0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYZzkpxQkN4apC9cYt1aduJBwSGIZfgFb3t16SHOSoo=;
 b=X3HxGWDdL5jMDAaGA5aOE0FXRFdno9vfy+UKu6XbfdPrWfs5xYoogpiNdlsKx042R5XkBYI/5XVs2YH8E3PXH/4kgQX1Si22O9WSYwVe0WvuyQLGUwSSnsmSNyraA6taDwmiG9Y7YxE9vboSO4mgo/F7zCXiRMP8vMA8BI4DyoWKPIOYJIoygRpcIvPEzLOx/nM04iSeewTySUuFVLvCmyzgiTN6lRy9SFbcEesGt1JfQZ3zi0nU/kysYWQCTnPHxErHBz/3bbxPClG+rJekQJl2MU16ysOpq9noJ8x7OaQpQjLc6r16A1J2eT0b9lnCKNjE11kyBPmBtXRaXOj9Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=allegrodvt.com; dmarc=pass action=none
 header.from=allegrodvt.com; dkim=pass header.d=allegrodvt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=allegrodvt.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYZzkpxQkN4apC9cYt1aduJBwSGIZfgFb3t16SHOSoo=;
 b=L2KNPXeRYpOx6KlKBRBfMtDG53o2FciB7/RzuDwPV88eeGzomMM5VG+MKiLVsEfU0+5/mE8ImB0rPZ55Gu9GujAyYSl1jf3wkWTBtyV/98Ug0HgGmUmhKpBqpxmeGSzWuhkiooPvXQL0ZEXbbvENtybdTk5kfCwxYosvNf0RSNnadidPGq487Qgt5ZAoWYe6+5C/tosK+yoyZo7qzhkqzKe/0Oi6zPdej4BIopqAgobKp1hmDooX32InHSnsBDQ1e1ryaglT6Lxc2ug7nrYrDiEBTfJjsRSZjznOjT2mPuot3tyO31ft5vWhLJTGnTs05DG10ZlzVbSghAw8+EVP0w==
Received: from MRXP264MB0584.FRAP264.PROD.OUTLOOK.COM (52.134.49.145) by
 MRXP264MB0053.FRAP264.PROD.OUTLOOK.COM (52.134.50.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Mon, 9 Mar 2020 15:22:05 +0000
Received: from MRXP264MB0584.FRAP264.PROD.OUTLOOK.COM
 ([fe80::84af:fd44:26b8:7b02]) by MRXP264MB0584.FRAP264.PROD.OUTLOOK.COM
 ([fe80::84af:fd44:26b8:7b02%5]) with mapi id 15.20.2793.013; Mon, 9 Mar 2020
 15:22:05 +0000
Received: from localhost.localdomain (185.223.150.134) by
 PR3P189CA0031.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:53::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.11 via Frontend Transport; Mon, 9 Mar 2020 15:22:04 +0000
From: Kevin Grandemange <kevin.grandemange@allegrodvt.com>
To: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2] [dma-coherent] Fix integer overflow in the reserved-memory
 dma allocation
Thread-Topic: [PATCH v2] [dma-coherent] Fix integer overflow in the
 reserved-memory dma allocation
Thread-Index: AQHV9iZ93JWtc6wtXkm879Kcf+rYTw==
Date: Mon, 9 Mar 2020 15:22:05 +0000
Message-ID: <20200309152054.12066-1-kevin.grandemange@allegrodvt.com>
References: <6b2b656c-33ee-4e02-e687-c71ff43de584@arm.com>
In-Reply-To: <6b2b656c-33ee-4e02-e687-c71ff43de584@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR3P189CA0031.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:53::6) To MRXP264MB0584.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:23::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kevin.grandemange@allegrodvt.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [185.223.150.134]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 69eef80b-ef89-4c18-e660-08d7c43d9fd8
x-ms-traffictypediagnostic: MRXP264MB0053:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MRXP264MB00532B15B4A9F15F35C55EEC87FE0@MRXP264MB0053.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0337AFFE9A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(136003)(396003)(39830400003)(346002)(376002)(199004)(189003)(2906002)(2616005)(956004)(44832011)(6916009)(5660300002)(26005)(186003)(1076003)(16526019)(69590400007)(52116002)(6506007)(71200400001)(4326008)(107886003)(54906003)(6512007)(8936002)(86362001)(81156014)(508600001)(81166006)(66446008)(64756008)(66556008)(66946007)(8676002)(316002)(36756003)(6486002)(66476007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MRXP264MB0053;
 H:MRXP264MB0584.FRAP264.PROD.OUTLOOK.COM; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: allegrodvt.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KxfqS4SMWGiSvlB27trsOCLzaM54T9IrmCMYTk1TEmiedSPSBoCgi3VE5xmfnjUdtcdo51jGjGsJVxJZ7jBD/bAIuFtB1yt7kd++QVV8fl75UpN6QIw4Gx0h8E5SHOMRDhjv2AicGDJXOll9RmFtDjP+rdF++Nl8gaSKjiXjJVGieCsQapX1lk5EdLDtTkYEjajA4gkhN2ow0n29SAre00H2Pk5Oo7JA9q3zbyKKz/QN0aBNjHAdTfShyyecTyXFY2VbgB5CHLCaAvCuSCOGrSJto4fbkorQzLjGw0dzrbaVDxrscLCPBrFRsK7VcAqBlkZsLEviMg6nGeLm/VwSD5ph18OKNDaF7gnuK4RmZfbEgHiZ4w1zrsBG+lQxAujoDTmk8MHF1oSZsLBbyEmDkRVWaB+apWY4s4usCsFzY0/233DZ3Ei8vKbTyM9LWqIpL7teFhDdL1kp4EGj5ZLUASg7ZWTcaRPhm6gleYzppG4ikef3SnkCyTNDUb4Th8VC
x-ms-exchange-antispam-messagedata: C94Ap80OAZsXL8bkjjJ/cDzddV5zB/IJ5pOWRKftrl+0ctkRdzMJkEZNkebzNj2d3sjLS/hX22zeWVkfLQFxpiomevb2TNk9k+HtZtmxdjlsdD6RcBy7qYffLA7tP26ZO10t41IRVgL0QeAlimAT+Q==
MIME-Version: 1.0
X-OriginatorOrg: allegrodvt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69eef80b-ef89-4c18-e660-08d7c43d9fd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2020 15:22:05.1564 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6c7a5ec0-2d92-465a-a3e1-9e3f1e9fd917
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XQpczzLQl/FoQCsduJ+xNmPhS2PP6xcD33e8Wbgpi2ICkd1cXNw42wiIe/w1TutP6EfssrIBkIx5pD27c2sUGRP7LqcF6QbvmastUFoecEy8n3PqRZsOC77KAj2VDWb0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRXP264MB0053
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
		        reg = <0x5 0x00000000 0x1 0x0>;
        };
};

Signed-off-by: Kevin Grandemange <kevin.grandemange@allegrodvt.com>
---
Changes v1 -> v2:
  - removed mem_offset tmp variable
  - use dma_addr_t instead of ssize_t
  - Fix reserved-memory size in the dts example

 kernel/dma/coherent.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index 551b0eb7028a..b8e4fa441493 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -144,8 +144,8 @@ static void *__dma_alloc_from_coherent(struct device *dev,
 	/*
 	 * Memory was found in the coherent area.
 	 */
-	*dma_handle = dma_get_device_base(dev, mem) + (pageno << PAGE_SHIFT);
-	ret = mem->virt_base + (pageno << PAGE_SHIFT);
+	*dma_handle = dma_get_device_base(dev, mem) + ((dma_addr_t)pageno << PAGE_SHIFT);
+	ret = mem->virt_base + ((dma_addr_t)pageno << PAGE_SHIFT);
 	spin_unlock_irqrestore(&mem->spinlock, flags);
 	memset(ret, 0, size);
 	return ret;
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
