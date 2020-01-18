Return-Path: <SRS0=Kz9i=3H=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A536CC33CB1
	for <iommu@archiver.kernel.org>; Sat, 18 Jan 2020 12:35:31 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A4E624697
	for <iommu@archiver.kernel.org>; Sat, 18 Jan 2020 12:35:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A4E624697
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cambricon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 20C7787F0C;
	Sat, 18 Jan 2020 12:35:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e1BImrnLl3cD; Sat, 18 Jan 2020 12:35:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C256B87E8F;
	Sat, 18 Jan 2020 12:35:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 99869C1D81;
	Sat, 18 Jan 2020 12:35:28 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 53DE6C077D
 for <iommu@lists.linux-foundation.org>; Sat, 18 Jan 2020 04:26:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 4B9D686886
 for <iommu@lists.linux-foundation.org>; Sat, 18 Jan 2020 04:26:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8QdLfM2rFrUP for <iommu@lists.linux-foundation.org>;
 Sat, 18 Jan 2020 04:26:23 +0000 (UTC)
X-Greylist: delayed 00:07:16 by SQLgrey-1.7.6
Received: from cambricon.cn (unknown [117.119.69.60])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 47A1286881
 for <iommu@lists.linux-foundation.org>; Sat, 18 Jan 2020 04:26:20 +0000 (UTC)
Received: by ajax-webmail-cambricon-mail (Coremail) ; Sat, 18 Jan 2020
 12:18:46 +0800 (GMT+08:00)
X-Originating-IP: [172.10.80.150]
Date: Sat, 18 Jan 2020 12:18:46 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5ZGo5YWJ6L+q?= <zhouguangdi@cambricon.com>
To: iommu@lists.linux-foundation.org
Subject: intel iommu pasid question
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.8 build 20180929(7a9be5e8)
 Copyright (c) 2002-2020 www.mailtech.cn cambricon.com
MIME-Version: 1.0
Message-ID: <2419db41.2662.16fb6dfed52.Coremail.zhouguangdi@cambricon.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwCnJhwnhyJeU3wYAA--.7356W
X-CM-SenderInfo: 52kr3wpxdqwv3l6ftz5eulu03qof0z/1tbiAQABDVwbQIIf4AABs2
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
 CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
 daVFxhVjvjDU=
X-Mailman-Approved-At: Sat, 18 Jan 2020 12:35:26 +0000
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
Content-Type: multipart/mixed; boundary="===============3397239600888833405=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============3397239600888833405==
Content-Type: multipart/alternative; 
	boundary="----=_Part_31650_1373761662.1579321126202"

------=_Part_31650_1373761662.1579321126202
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

SGkgYWxs77yMICAKCgpJIGFtIGN1cnJlbnRseSBkZXZlbG9waW5nIGEgcGNpZSBkZXZpY2UgZHJp
dmVyIG9uIExpbnV4IGtlcm5lbCA0LjQgb3IgbGF0ZXIuIEkgd2FudCB0byB1c2UgcGFzaWQgdG8g
ZGlyZWN0bHkgYWNjZXNzIHVzZXItbW9kZSBtZW1vcnkuIEJ1dCBJIGZvdW5kIHRoYXQgdGhlIGlv
bW11IG9mIG15IGRldmVsb3BtZW50IG1hY2hpbmUgZG9lcyBub3Qgc3VwcG9ydCBwYXNpZC5wYXNp
ZF9lbmFibGVkKGlvbW11KSBvciBwYXNpZF9zdXBwb3J0ZWQoaW9tbXUpIHJldHVybiBmYWxzZS4K
CgpJIHdhbnQgdG8ga25vdyBob3cgdG8gZW5hYmxlIHRoZSBwYXNpZCBmdW5jdGlvbiBvZiBpbnRl
bCBpb21tde+8jElzIHRoZXJlIGEgc2VwYXJhdGUgc3dpdGNoIHRvIGVuYWJsZSB0aGUgaW9tbXUg
cGFzaWQgZnVuY3Rpb24gb3IgdGhlIGlvbW11IGhhcmR3YXJlIGltcGxlbWVudGF0aW9uIGhhcyBk
ZWNpZGVkIHdoZXRoZXIgdG8gc3VwcG9ydCBQQVNJRCBhbmQgdGhlIHNvZnR3YXJlIGNhbm5vdCBj
b25maWd1cmUgaXTvvJ8KCgpIb3cgY2FuIEkgY2hlY2sgd2hpY2ggdmVyc2lvbiBvZiBpbnRlbCB2
dC1kIGlzIGltcGxlbWVudGVkIGJ5IGlvbW11IG9uIG15IHBsYXRmb3JtP0RvZXMgdGhlIHZhbHVl
IG9mIGlvbW11J3MgVmVyc2lvbiBSZWdpc3RlciByZXByZXNlbnQgdGhlIHZ0LWQgdmVyc2lvbj8g
CnRoZSBpb21tdSB2ZXJzaW9uIHJlZ2lzdGVyIG9mIG15IGludGVsIHhlb24gZ29sZCA1MTE4IHBs
YXRmb3JtIHNlcnZlciBpcyAxLjAKCgoKCgoKCgoK
------=_Part_31650_1373761662.1579321126202
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: base64

PHNwYW4gc3R5bGU9ImZvbnQtZmFtaWx5OlNpbVN1bjsiPkhpIGFsbO+8jCZuYnNwOyZuYnNwOzwv
c3Bhbj48YnI+CjxzcGFuIHN0eWxlPSJmb250LWZhbWlseTpTaW1TdW47Ij48YnI+Cjwvc3Bhbj48
YnI+CjxzcGFuIHN0eWxlPSJmb250LWZhbWlseTpTaW1TdW47Ij5JIGFtIGN1cnJlbnRseSBkZXZl
bG9waW5nIGEgcGNpZSBkZXZpY2UgZHJpdmVyIG9uIExpbnV4IGtlcm5lbCA0LjQgb3IgbGF0ZXIu
IEkgd2FudCB0byB1c2UgcGFzaWQgdG8gZGlyZWN0bHkgYWNjZXNzIHVzZXItbW9kZSBtZW1vcnku
IEJ1dCBJIGZvdW5kIHRoYXQgdGhlIGlvbW11IG9mIG15IGRldmVsb3BtZW50IG1hY2hpbmUgZG9l
cyBub3Qgc3VwcG9ydCBwYXNpZC5wYXNpZF9lbmFibGVkKGlvbW11KSBvciBwYXNpZF9zdXBwb3J0
ZWQoaW9tbXUpIHJldHVybiBmYWxzZS48L3NwYW4+PGJyPgo8c3BhbiBzdHlsZT0iZm9udC1mYW1p
bHk6U2ltU3VuOyI+PGJyPgo8L3NwYW4+PGJyPgo8c3BhbiBzdHlsZT0iZm9udC1mYW1pbHk6U2lt
U3VuOyI+SSB3YW50IHRvIGtub3cgaG93IHRvIGVuYWJsZSB0aGUgcGFzaWQgZnVuY3Rpb24gb2Yg
aW50ZWwgaW9tbXXvvIxJcyB0aGVyZSBhIHNlcGFyYXRlIHN3aXRjaCB0byBlbmFibGUgdGhlIGlv
bW11IHBhc2lkIGZ1bmN0aW9uIG9yIHRoZSBpb21tdSBoYXJkd2FyZSBpbXBsZW1lbnRhdGlvbiBo
YXMgZGVjaWRlZCB3aGV0aGVyIHRvIHN1cHBvcnQgUEFTSUQgYW5kIHRoZSBzb2Z0d2FyZSBjYW5u
b3QgY29uZmlndXJlIGl077yfPC9zcGFuPjxicj4KPHNwYW4gc3R5bGU9ImZvbnQtZmFtaWx5OlNp
bVN1bjsiPjxicj4KPC9zcGFuPjxicj4KPHNwYW4gc3R5bGU9ImZvbnQtZmFtaWx5OlNpbVN1bjsi
PkhvdyBjYW4gSSBjaGVjayB3aGljaCB2ZXJzaW9uIG9mIGludGVsIHZ0LWQgaXMgaW1wbGVtZW50
ZWQgYnkgaW9tbXUgb24gbXkgcGxhdGZvcm0/RG9lcyB0aGUgdmFsdWUgb2YgaW9tbXUncyBWZXJz
aW9uIFJlZ2lzdGVyIHJlcHJlc2VudCB0aGUgdnQtZCB2ZXJzaW9uPyZuYnNwOzwvc3Bhbj48YnI+
CjxzcGFuIHN0eWxlPSJmb250LWZhbWlseTpTaW1TdW47Ij50aGUgaW9tbXUgdmVyc2lvbiByZWdp
c3RlciBvZiBteSBpbnRlbCB4ZW9uIGdvbGQgNTExOCBwbGF0Zm9ybSBzZXJ2ZXIgaXMgMS4wPC9z
cGFuPjxicj4KPHAgc3R5bGU9ImZvbnQtZmFtaWx5OlNpbVN1bjt3aGl0ZS1zcGFjZTpub3dyYXA7
Ij4KCTxicj4KPC9wPgo8cCBzdHlsZT0iZm9udC1mYW1pbHk6U2ltU3VuO3doaXRlLXNwYWNlOm5v
d3JhcDsiPgoJPGJyPgo8L3A+CjxwIHN0eWxlPSJmb250LWZhbWlseTpTaW1TdW47d2hpdGUtc3Bh
Y2U6bm93cmFwOyI+Cgk8YnI+CjwvcD4=
------=_Part_31650_1373761662.1579321126202--


--===============3397239600888833405==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============3397239600888833405==--

