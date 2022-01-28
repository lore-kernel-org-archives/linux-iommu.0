Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0506EC433EF
	for <iommu@archiver.kernel.org>; Fri, 28 Jan 2022 02:02:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 69FA640298;
	Fri, 28 Jan 2022 02:02:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id svfdnbGuSzNR; Fri, 28 Jan 2022 02:02:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A365340019;
	Fri, 28 Jan 2022 02:02:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63BC0C0011;
	Fri, 28 Jan 2022 02:02:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14425C000B
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 01:16:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0A66484D4B
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 01:16:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=yandex.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EqYFBCiPR8zL for <iommu@lists.linux-foundation.org>;
 Fri, 28 Jan 2022 01:16:54 +0000 (UTC)
X-Greylist: delayed 00:07:47 by SQLgrey-1.8.0
Received: from forward104j.mail.yandex.net (forward104j.mail.yandex.net
 [5.45.198.247])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4EDA38316F
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 01:16:54 +0000 (UTC)
Received: from forward102q.mail.yandex.net (forward102q.mail.yandex.net
 [IPv6:2a02:6b8:c0e:1ba:0:640:516:4e7d])
 by forward104j.mail.yandex.net (Yandex) with ESMTP id C07452F98374;
 Fri, 28 Jan 2022 04:09:00 +0300 (MSK)
Received: from vla1-85d2a0988c40.qloud-c.yandex.net
 (vla1-85d2a0988c40.qloud-c.yandex.net
 [IPv6:2a02:6b8:c0d:511a:0:640:85d2:a098])
 by forward102q.mail.yandex.net (Yandex) with ESMTP id BB9C4BF00002;
 Fri, 28 Jan 2022 04:09:00 +0300 (MSK)
Received: from 2a02:6b8:c0d:1686:0:640:2375:e02e
 (2a02:6b8:c0d:1686:0:640:2375:e02e [2a02:6b8:c0d:1686:0:640:2375:e02e])
 by vla1-85d2a0988c40.qloud-c.yandex.net (mxback/Yandex) with HTTP id
 r8BDLf0cfKo1-90cmxu6G; Fri, 28 Jan 2022 04:09:00 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.com; s=mail;
 t=1643332140; bh=usrA3nlvYA7cg1Id1Zg98Js3Uxn8sedcOQX6bqj2G5Y=;
 h=Message-Id:Date:Subject:To:From;
 b=oz/10J/Sc+w1WoEVyfpC81hoRqDjUz7rlC6qyEsjDeYczwQMEZSmRVTM7eEwmu8M9
 z37V28NyJ/fqyFJCS7Pq/297qM75uVLU/SHqUp+ZDFqSyIwevF16wFn3euXpdtncom
 1OLM7mFWeYk0XoFChSb96vHxBY7X/nJN1O1LjqKo=
Authentication-Results: vla1-85d2a0988c40.qloud-c.yandex.net;
 dkim=pass header.i=@yandex.com
Received: by vla1-2375e02e97a8.qloud-c.yandex.net with HTTP;
 Fri, 28 Jan 2022 04:09:00 +0300
From: Will Trives <wilsonyan@yandex.com>
Envelope-From: wilsonyan@yandex.com
To: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: amd iommu / xhci  bug
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Fri, 28 Jan 2022 12:09:00 +1100
Message-Id: <1591643331610@mail.yandex.com>
X-Mailman-Approved-At: Fri, 28 Jan 2022 02:02:38 +0000
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
Content-Type: multipart/mixed; boundary="===============5813184706083757918=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============5813184706083757918==
Content-Transfer-Encoding: base64
Content-Type: text/html; charset=utf-8

PGRpdj5IZWxsbyw8L2Rpdj48ZGl2PsKgPC9kaXY+PGRpdj48ZGl2Pls1MTc3Ny41MjkwNDJdIHI4
MTUyIDYtMjoxLjAgZW5wNHMwZjR1MjogY2FycmllciBvZmY8L2Rpdj48ZGl2Pls4NjQ5My40NDU3
NzZdIHhoY2lfaGNkIDAwMDA6MDQ6MDAuMzogV0FSTiBTdWNjZXNzZnVsIGNvbXBsZXRpb24gb24g
c2hvcnQgVFg8L2Rpdj48ZGl2Pls4NjQ5My40OTE3OTldIHhoY2lfaGNkIDAwMDA6MDQ6MDAuMzog
QU1ELVZpOiBFdmVudCBsb2dnZWQgW0lPX1BBR0VfRkFVTFQgZG9tYWluPTB4MDAwYyBhZGRyZXNz
PTB4YmZhZmUwMDAgZmxhZ3M9MHgwMDIwXTwvZGl2PjxkaXY+Wzg2NTUzLjY1MjAxOV0gc2QgNjow
OjA6MTogW3NkY10gdGFnIzI1IHVhc19laF9hYm9ydF9oYW5kbGVyIDAgdWFzLXRhZyAyIGluZmxp
Z2h0OiBDTUQgSU7CoDwvZGl2PjxkaXY+Wzg2NTUzLjY1MjAyNV0gc2QgNjowOjA6MTogW3NkY10g
dGFnIzI1IENEQjogQVRBIGNvbW1hbmQgcGFzcyB0aHJvdWdoKDE2KSA4NSAwOCAwZSAwMCBkMCAw
MCAwMSAwMCAwMCAwMCA0ZiAwMCBjMiAwMCBiMCAwMDwvZGl2PjxkaXY+Wzg2NTU4Ljc2MDk5MF0g
eGhjaV9oY2QgMDAwMDowNDowMC4zOiB4SENJIGhvc3Qgbm90IHJlc3BvbmRpbmcgdG8gc3RvcCBl
bmRwb2ludCBjb21tYW5kLjwvZGl2PjxkaXY+Wzg2NTU4Ljc2MDk5Nl0geGhjaV9oY2QgMDAwMDow
NDowMC4zOiBVU0JTVFM6IEhDSGFsdGVkIEhTRTwvZGl2PjxkaXY+Wzg2NTU4Ljc2MTAwMV0geGhj
aV9oY2QgMDAwMDowNDowMC4zOiB4SENJIGhvc3QgY29udHJvbGxlciBub3QgcmVzcG9uZGluZywg
YXNzdW1lIGRlYWQ8L2Rpdj48ZGl2Pls4NjU1OC43NjEwMTZdIHhoY2lfaGNkIDAwMDA6MDQ6MDAu
MzogSEMgZGllZDsgY2xlYW5pbmcgdXA8L2Rpdj48ZGl2Pls4NjU1OC43NjEwNjRdIHVzYiAzLTE6
IFVTQiBkaXNjb25uZWN0LCBkZXZpY2UgbnVtYmVyIDI8L2Rpdj48ZGl2Pls4NjU1OC43NjEwOTBd
IHNkIDY6MDowOjE6IFtzZGNdIHRhZyM1IHVhc19laF9hYm9ydF9oYW5kbGVyIDAgdWFzLXRhZyAx
IGluZmxpZ2h0OiBDTUTCoDwvZGl2PjxkaXY+Wzg2NTU4Ljc2MTA5NF0gc2QgNjowOjA6MTogW3Nk
Y10gdGFnIzUgQ0RCOiBBVEEgY29tbWFuZCBwYXNzIHRocm91Z2goMTYpIDg1IDA4IDBlIDAwIGQw
IDAwIDAxIDAwIDAwIDAwIDRmIDAwIGMyIDAwIGIwIDAwPC9kaXY+PGRpdj5bODY1NTguNzYxNDAz
XSB1c2IgNC0xOiBVU0IgZGlzY29ubmVjdCwgZGV2aWNlIG51bWJlciAyPC9kaXY+PGRpdj5bODY1
NTguNzYxNTk1XSB1c2IgNC0yOiBVU0IgZGlzY29ubmVjdCwgZGV2aWNlIG51bWJlciAzPC9kaXY+
PGRpdj5bODY1NTguNzY5Nzg5XSBzY3NpIGhvc3Q2OiB1YXNfZWhfZGV2aWNlX3Jlc2V0X2hhbmRs
ZXIgRkFJTEVEIHRvIGdldCBsb2NrIGVyciAtMTk8L2Rpdj48ZGl2Pls4NjU1OC43Njk3OTRdIHNk
IDY6MDowOjE6IERldmljZSBvZmZsaW5lZCAtIG5vdCByZWFkeSBhZnRlciBlcnJvciByZWNvdmVy
eTwvZGl2PjxkaXY+Wzg2NTU4Ljc2OTc5Nl0gc2QgNjowOjA6MTogRGV2aWNlIG9mZmxpbmVkIC0g
bm90IHJlYWR5IGFmdGVyIGVycm9yIHJlY292ZXJ5PC9kaXY+PGRpdj7CoDwvZGl2PjxkaXY+VGhl
cmUgc2VlbXMgdG8gYmUgc29tZSBraW5kIG9mIGJ1ZyB3aXRoIGlvbW11IGFuZCBwb3NzaWJseSB4
aGNpIGRyaXZlci4gSSBsZWF2ZSBteSBjb21wdXRlciB1bmF0dGVuZGVkIGF0IG5pZ2h0LCBkaXNj
b25uZWN0aW5nIHRoZSBldGhlcm5ldCBjb25uZWN0aW9uLiBXaGVuIEkgY29tZSBiYWNrIGluIHRo
ZSBtb3JuaW5nIEkgY2FuJ3QgYWNjZXNzIG15IHN0b3JhZ2UgZGV2aWNlcyBjb25uZWN0ZWQgdmlh
IGEgNSBiYXkgb3JpY28gdXNiIGRvY2ssIHJlbG9hZGluZyB0aGUgeGhjaV9wY2kgYW5kIHhoY2lf
aGNkIG1vZHVsZXMgYWxsb3dzIG1lIHRvIGFjY2VzcyB0aGUgc3RvcmFnZSBhZ2FpbiB3aXRob3V0
IHJlYm9vdGluZyBidXQgSSB0aGVuIGhhdmUgdG8gc2V0IHVwIHRoZSB1c2IgbmV0d29ya2luZyBh
Z2FpbiAoZGhjcGNkIGV0YykuIEN1cmlvdXMgdGhhdCB0aGlzIHNlZW1zIHRvIGhhcHBlbiBvbmx5
IHdoZW4gdGhlIGNvbXB1dGVyIGlzIHVuYXR0ZW5kZWQsIHNvbWUga2luZCBvZiBwb3dlciBzYXZp
bmcgaXNzdWUgd2l0aCB0aGUgZG9jayA/PC9kaXY+PGRpdj7CoDwvZGl2PjxkaXY+wqA8L2Rpdj48
ZGl2PlNvbWV0aW1lcyB3aGVuIGJvb3RpbmcgdGhlIGRldmljZXMgYWxzbyBhcmVuJ3QgZGV0ZWN0
ZWQgYW5kIEkgaGF2ZSB0byBzd2l0Y2ggdGhlIHBvd2VyIHRvIHRoZSBkcml2ZSBiYXkgb2ZmIGFu
ZCBiYWNrIG9uLjwvZGl2PjxkaXY+wqA8L2Rpdj48ZGl2Pk1vdGhlcmJvYXJkOiBHaWdhYnl0ZSBB
b3J1cyBCNTUwTSBQcm8tUCDCoCDCoCDCoCAoQjU1ME0gY2hpcHNldCk8L2Rpdj48ZGl2PsKgPC9k
aXY+PGRpdj7CoDwvZGl2PjxkaXY+wqA8L2Rpdj48ZGl2PlJlZ2FyZHMsPC9kaXY+PGRpdj7CoDwv
ZGl2PjxkaXY+V2lsbCBUcml2ZXM8L2Rpdj48L2Rpdj4=

--===============5813184706083757918==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============5813184706083757918==--
