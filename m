Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E50C433FE
	for <iommu@archiver.kernel.org>; Fri, 28 Jan 2022 02:02:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9666E84E57;
	Fri, 28 Jan 2022 02:02:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2xUdaySEONem; Fri, 28 Jan 2022 02:02:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4733C84E54;
	Fri, 28 Jan 2022 02:02:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B576DC0039;
	Fri, 28 Jan 2022 02:02:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 13233C000B
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 01:22:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E5E18400D9
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 01:22:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=yandex.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id POjp9lpACRws for <iommu@lists.linux-foundation.org>;
 Fri, 28 Jan 2022 01:22:53 +0000 (UTC)
X-Greylist: delayed 00:06:59 by SQLgrey-1.8.0
Received: from forward500o.mail.yandex.net (forward500o.mail.yandex.net
 [37.140.190.195])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CC26041608
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 01:22:52 +0000 (UTC)
Received: from vla1-ae662a693c21.qloud-c.yandex.net
 (vla1-ae662a693c21.qloud-c.yandex.net
 [IPv6:2a02:6b8:c0d:2915:0:640:ae66:2a69])
 by forward500o.mail.yandex.net (Yandex) with ESMTP id 164F994114F;
 Fri, 28 Jan 2022 04:15:50 +0300 (MSK)
Received: from 2a02:6b8:c0d:4d20:0:640:560:d235
 (2a02:6b8:c0d:4d20:0:640:560:d235 [2a02:6b8:c0d:4d20:0:640:560:d235])
 by vla1-ae662a693c21.qloud-c.yandex.net (mxback/Yandex) with HTTP id
 iFB04g0d6Os1-FndGOcIo; Fri, 28 Jan 2022 04:15:49 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.com; s=mail;
 t=1643332549; bh=bLMsithCdWvmeuCQl3UlhpB+4FzYP69GvS1fS7hEKmo=;
 h=References:Date:Message-Id:Subject:In-Reply-To:To:From;
 b=gqx9o6zwDsHl/SLTy0V0B9Q+1AZjVK/KBD3ZoHpwAnVgds3vHT7SohDFu9pLldKEA
 GrrAjFsDkWs1VNjae62yMfFcmn6X+GOXBcrNENkUloHWUJvLiyUZMlKN60wxRtMu7N
 VwR2YRUbpnU56qixGNqkkw81JPHl7TxtSz6RllEE=
Authentication-Results: vla1-ae662a693c21.qloud-c.yandex.net;
 dkim=pass header.i=@yandex.com
Received: by vla1-0560d23566d3.qloud-c.yandex.net with HTTP;
 Fri, 28 Jan 2022 04:15:49 +0300
From: Will Trives <wilsonyan@yandex.com>
Envelope-From: wilsonyan@yandex.com
To: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
In-Reply-To: <1591643331610@mail.yandex.com>
References: <1591643331610@mail.yandex.com>
Subject: Re: amd iommu / xhci  bug
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Fri, 28 Jan 2022 12:15:49 +1100
Message-Id: <232521643332461@mail.yandex.com>
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
Content-Type: multipart/mixed; boundary="===============1507626886642465604=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============1507626886642465604==
Content-Transfer-Encoding: base64
Content-Type: text/html; charset=utf-8

PGRpdj5JIGZvcmdvdCB0byBtZW50aW9uIHRoaXMgaXMgd2l0aCBrZXJuZWwgNS4xNy1yYzEgYW5k
IGhhcyBiZWVuIGFzIGlzc3VlIGZvciBhIHdoaWxlIGF0IGxlYXN0IHNpbmNlIDUuMTYsIG1heWJl
IGFsd2F5cy48L2Rpdj48ZGl2PsKgPC9kaXY+PGRpdj4yOC4wMS4yMDIyLCAxMjowOSwgIldpbGwg
VHJpdmVzIiAmbHQ7d2lsc29ueWFuQHlhbmRleC5jb20mZ3Q7OjwvZGl2PjxibG9ja3F1b3RlPjxk
aXY+SGVsbG8sPC9kaXY+PGRpdj7CoDwvZGl2PjxkaXY+PGRpdj5bNTE3NzcuNTI5MDQyXSByODE1
MiA2LTI6MS4wIGVucDRzMGY0dTI6IGNhcnJpZXIgb2ZmPC9kaXY+PGRpdj5bODY0OTMuNDQ1Nzc2
XSB4aGNpX2hjZCAwMDAwOjA0OjAwLjM6IFdBUk4gU3VjY2Vzc2Z1bCBjb21wbGV0aW9uIG9uIHNo
b3J0IFRYPC9kaXY+PGRpdj5bODY0OTMuNDkxNzk5XSB4aGNpX2hjZCAwMDAwOjA0OjAwLjM6IEFN
RC1WaTogRXZlbnQgbG9nZ2VkIFtJT19QQUdFX0ZBVUxUIGRvbWFpbj0weDAwMGMgYWRkcmVzcz0w
eGJmYWZlMDAwIGZsYWdzPTB4MDAyMF08L2Rpdj48ZGl2Pls4NjU1My42NTIwMTldIHNkIDY6MDow
OjE6IFtzZGNdIHRhZyMyNSB1YXNfZWhfYWJvcnRfaGFuZGxlciAwIHVhcy10YWcgMiBpbmZsaWdo
dDogQ01EIElOwqA8L2Rpdj48ZGl2Pls4NjU1My42NTIwMjVdIHNkIDY6MDowOjE6IFtzZGNdIHRh
ZyMyNSBDREI6IEFUQSBjb21tYW5kIHBhc3MgdGhyb3VnaCgxNikgODUgMDggMGUgMDAgZDAgMDAg
MDEgMDAgMDAgMDAgNGYgMDAgYzIgMDAgYjAgMDA8L2Rpdj48ZGl2Pls4NjU1OC43NjA5OTBdIHho
Y2lfaGNkIDAwMDA6MDQ6MDAuMzogeEhDSSBob3N0IG5vdCByZXNwb25kaW5nIHRvIHN0b3AgZW5k
cG9pbnQgY29tbWFuZC48L2Rpdj48ZGl2Pls4NjU1OC43NjA5OTZdIHhoY2lfaGNkIDAwMDA6MDQ6
MDAuMzogVVNCU1RTOiBIQ0hhbHRlZCBIU0U8L2Rpdj48ZGl2Pls4NjU1OC43NjEwMDFdIHhoY2lf
aGNkIDAwMDA6MDQ6MDAuMzogeEhDSSBob3N0IGNvbnRyb2xsZXIgbm90IHJlc3BvbmRpbmcsIGFz
c3VtZSBkZWFkPC9kaXY+PGRpdj5bODY1NTguNzYxMDE2XSB4aGNpX2hjZCAwMDAwOjA0OjAwLjM6
IEhDIGRpZWQ7IGNsZWFuaW5nIHVwPC9kaXY+PGRpdj5bODY1NTguNzYxMDY0XSB1c2IgMy0xOiBV
U0IgZGlzY29ubmVjdCwgZGV2aWNlIG51bWJlciAyPC9kaXY+PGRpdj5bODY1NTguNzYxMDkwXSBz
ZCA2OjA6MDoxOiBbc2RjXSB0YWcjNSB1YXNfZWhfYWJvcnRfaGFuZGxlciAwIHVhcy10YWcgMSBp
bmZsaWdodDogQ01EwqA8L2Rpdj48ZGl2Pls4NjU1OC43NjEwOTRdIHNkIDY6MDowOjE6IFtzZGNd
IHRhZyM1IENEQjogQVRBIGNvbW1hbmQgcGFzcyB0aHJvdWdoKDE2KSA4NSAwOCAwZSAwMCBkMCAw
MCAwMSAwMCAwMCAwMCA0ZiAwMCBjMiAwMCBiMCAwMDwvZGl2PjxkaXY+Wzg2NTU4Ljc2MTQwM10g
dXNiIDQtMTogVVNCIGRpc2Nvbm5lY3QsIGRldmljZSBudW1iZXIgMjwvZGl2PjxkaXY+Wzg2NTU4
Ljc2MTU5NV0gdXNiIDQtMjogVVNCIGRpc2Nvbm5lY3QsIGRldmljZSBudW1iZXIgMzwvZGl2Pjxk
aXY+Wzg2NTU4Ljc2OTc4OV0gc2NzaSBob3N0NjogdWFzX2VoX2RldmljZV9yZXNldF9oYW5kbGVy
IEZBSUxFRCB0byBnZXQgbG9jayBlcnIgLTE5PC9kaXY+PGRpdj5bODY1NTguNzY5Nzk0XSBzZCA2
OjA6MDoxOiBEZXZpY2Ugb2ZmbGluZWQgLSBub3QgcmVhZHkgYWZ0ZXIgZXJyb3IgcmVjb3Zlcnk8
L2Rpdj48ZGl2Pls4NjU1OC43Njk3OTZdIHNkIDY6MDowOjE6IERldmljZSBvZmZsaW5lZCAtIG5v
dCByZWFkeSBhZnRlciBlcnJvciByZWNvdmVyeTwvZGl2PjxkaXY+wqA8L2Rpdj48ZGl2PlRoZXJl
IHNlZW1zIHRvIGJlIHNvbWUga2luZCBvZiBidWcgd2l0aCBpb21tdSBhbmQgcG9zc2libHkgeGhj
aSBkcml2ZXIuIEkgbGVhdmUgbXkgY29tcHV0ZXIgdW5hdHRlbmRlZCBhdCBuaWdodCwgZGlzY29u
bmVjdGluZyB0aGUgZXRoZXJuZXQgY29ubmVjdGlvbi4gV2hlbiBJIGNvbWUgYmFjayBpbiB0aGUg
bW9ybmluZyBJIGNhbid0IGFjY2VzcyBteSBzdG9yYWdlIGRldmljZXMgY29ubmVjdGVkIHZpYSBh
IDUgYmF5IG9yaWNvIHVzYiBkb2NrLCByZWxvYWRpbmcgdGhlIHhoY2lfcGNpIGFuZCB4aGNpX2hj
ZCBtb2R1bGVzIGFsbG93cyBtZSB0byBhY2Nlc3MgdGhlIHN0b3JhZ2UgYWdhaW4gd2l0aG91dCBy
ZWJvb3RpbmcgYnV0IEkgdGhlbiBoYXZlIHRvIHNldCB1cCB0aGUgdXNiIG5ldHdvcmtpbmcgYWdh
aW4gKGRoY3BjZCBldGMpLiBDdXJpb3VzIHRoYXQgdGhpcyBzZWVtcyB0byBoYXBwZW4gb25seSB3
aGVuIHRoZSBjb21wdXRlciBpcyB1bmF0dGVuZGVkLCBzb21lIGtpbmQgb2YgcG93ZXIgc2F2aW5n
IGlzc3VlIHdpdGggdGhlIGRvY2sgPzwvZGl2PjxkaXY+wqA8L2Rpdj48ZGl2PsKgPC9kaXY+PGRp
dj5Tb21ldGltZXMgd2hlbiBib290aW5nIHRoZSBkZXZpY2VzIGFsc28gYXJlbid0IGRldGVjdGVk
IGFuZCBJIGhhdmUgdG8gc3dpdGNoIHRoZSBwb3dlciB0byB0aGUgZHJpdmUgYmF5IG9mZiBhbmQg
YmFjayBvbi48L2Rpdj48ZGl2PsKgPC9kaXY+PGRpdj5Nb3RoZXJib2FyZDogR2lnYWJ5dGUgQW9y
dXMgQjU1ME0gUHJvLVAgwqAgwqAgwqAgKEI1NTBNIGNoaXBzZXQpPC9kaXY+PGRpdj7CoDwvZGl2
PjxkaXY+wqA8L2Rpdj48ZGl2PsKgPC9kaXY+PGRpdj5SZWdhcmRzLDwvZGl2PjxkaXY+wqA8L2Rp
dj48ZGl2PldpbGwgVHJpdmVzPC9kaXY+PC9kaXY+PC9ibG9ja3F1b3RlPg==

--===============1507626886642465604==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============1507626886642465604==--
