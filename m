Return-Path: <SRS0=nChL=KW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=1.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00DAC47089
	for <iommu@archiver.kernel.org>; Thu, 27 May 2021 02:48:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D7C7613CC
	for <iommu@archiver.kernel.org>; Thu, 27 May 2021 02:48:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D7C7613CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 06B14402A4;
	Thu, 27 May 2021 02:48:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DnH6GkjRhdaY; Thu, 27 May 2021 02:48:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id A3DFA40259;
	Thu, 27 May 2021 02:48:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70CCCC000E;
	Thu, 27 May 2021 02:48:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4A951C0001
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 02:48:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2454760717
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 02:48:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wf5TsKq1YZsD for <iommu@lists.linux-foundation.org>;
 Thu, 27 May 2021 02:48:11 +0000 (UTC)
X-Greylist: delayed 00:09:53 by SQLgrey-1.8.0
Received: from smtphy.263.net (va-smtp01.263.net [54.88.144.211])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 41AA260733
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 02:48:11 +0000 (UTC)
Received: from vipthree.263.net (unknown [211.157.147.162])
 by smtphy.263.net (Postfix) with ESMTPS id CDF20120026
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 10:38:16 +0800 (CST)
Received: from vipregular2.263.net (unknown [192.168.165.177])
 by vipthree.263.net (Postfix) with ESMTP id 58BB426E
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 10:37:47 +0800 (CST)
Received: from vipregular1.263.net (unknown [192.168.165.162])
 by vipregular2.263.net (Postfix) with ESMTP id 49B3C191
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 10:37:38 +0800 (CST)
Received: from localhost (unknown [192.168.167.235])
 by vipregular1.263.net (Postfix) with ESMTP id 2B502C98;
 Thu, 27 May 2021 10:37:32 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from desktop-7uo2irf (unknown [58.22.7.114])
 by smtp.263.net (postfix) whith ESMTP id
 P31747T140095115986688S1622083051355302_; 
 Thu, 27 May 2021 10:37:31 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <4fe6567fd536a59e612fff8b32aeeca6>
X-RL-SENDER: xxm@rock-chips.com
X-SENDER: xxm@rock-chips.com
X-LOGIN-NAME: xxm@rock-chips.com
X-FST-TO: robin.murphy@arm.com
X-RCPT-COUNT: 6
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
Date: Thu, 27 May 2021 10:37:32 +0800
From: "xxm@rock-chips.com" <xxm@rock-chips.com>
To: robin.murphy <robin.murphy@arm.com>, hch <hch@lst.de>, 
 joro <joro@8bytes.org>, will <will@kernel.org>
Subject: Different type iommus integrated in a SoC
X-Priority: 3
X-Has-Attach: no
X-Mailer: Foxmail 7.2.16.188[cn]
Mime-Version: 1.0
Message-ID: <2021052710373173260118@rock-chips.com>
Cc: linux-rockchip <linux-rockchip@lists.infradead.org>,
 iommu <iommu@lists.linux-foundation.org>
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
Content-Type: multipart/mixed; boundary="===============8685753940723373131=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

This is a multi-part message in MIME format.

--===============8685753940723373131==
Content-Type: multipart/alternative;
	boundary="----=_001_NextPart340720075514_=----"

This is a multi-part message in MIME format.

------=_001_NextPart340720075514_=----
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: base64

SGkgYWxsLA0KDQpJIGhhdmUgYSBTb0MgaW50ZWdyYXRlIHdpdGggdHdvIGRpZmZlcmVudCB0eXBl
cyBvZiBpb21tdXMsIG9uZSBpcyBBUk0gU01NVSwgc2VydmVzIHRoZSBQQ0llL1NBVEEvVVNCLA0K
dGhlIG90aGVycyBhcmUgdmVuZG9yIHNwZWNpZmljIGlvbW11cywgc2VydmVzIGRpc3BsYXkgZGV2
aWNlIGFuZCBtdWx0aW1lZGlhIGRldmljZS4NCg0KSW4gdGhlIGN1cnJlbnQgbGludXgga2VybmVs
LCB0aGUgaW9tbXUgZnJhbWV3b3JrIHNlZW1zIG9ubHkgc3VwcG9ydCBvbmUgdHlwZSBpb21tdSBh
dCBydW50aW1lLCBpZiBlbmFibGUgYm90aCB0eXBlcyBpb21tdSwgb25seSBvbmUgdHlwZSBjYW4g
d29yay4NCklzIHRoZXJlIGFueSB3YXkgdG8gc3VwcG9ydCB0aGlzIGtpbmQgb2YgU29DPyANCg0K
DQpTaW1vbg0KDQoNCg==

------=_001_NextPart340720075514_=----
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charse=
t=3Dus-ascii"><style>body { line-height: 1.5; }body { font-size: 10.5pt; f=
ont-family: 'Microsoft YaHei UI'; color: rgb(0, 0, 0); line-height: 1.5; }=
</style></head><body>=0A<div><span></span>Hi all,</div><div><br></div><div=
>I&nbsp;have&nbsp;a&nbsp;SoC&nbsp;integrate&nbsp;with&nbsp;two&nbsp;differ=
ent&nbsp;types&nbsp;of&nbsp;iommus,&nbsp;one&nbsp;is&nbsp;ARM&nbsp;SMMU,&n=
bsp;serves&nbsp;the&nbsp;PCIe/SATA/USB,<br>the&nbsp;others&nbsp;are&nbsp;v=
endor&nbsp;specific&nbsp;iommus,&nbsp;serves&nbsp;display&nbsp;device&nbsp=
;and&nbsp;multimedia&nbsp;device.<br><br>In&nbsp;the&nbsp;current&nbsp;lin=
ux&nbsp;kernel,&nbsp;the&nbsp;iommu&nbsp;framework&nbsp;seems&nbsp;only&nb=
sp;support&nbsp;one&nbsp;type&nbsp;iommu&nbsp;at&nbsp;runtime,&nbsp;if&nbs=
p;enable&nbsp;both&nbsp;types&nbsp;iommu,&nbsp;only&nbsp;one&nbsp;type&nbs=
p;can&nbsp;work.<br>Is&nbsp;there&nbsp;any&nbsp;way&nbsp;to&nbsp;support&n=
bsp;this&nbsp;kind&nbsp;of&nbsp;SoC?&nbsp;</div><div><br></div><div><br></=
div>=0A<div>Simon</div><hr style=3D"WIDTH: 210px; HEIGHT: 1px" color=3D"#b=
5c4df" size=3D"1" align=3D"left">=0A<div><span></span></div>=0A</body></ht=
ml>
------=_001_NextPart340720075514_=------




--===============8685753940723373131==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============8685753940723373131==--



