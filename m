Return-Path: <SRS0=R7pc=2N=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB89C2D0C0
	for <iommu@archiver.kernel.org>; Mon, 23 Dec 2019 08:15:34 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E698220715
	for <iommu@archiver.kernel.org>; Mon, 23 Dec 2019 08:15:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E698220715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baidu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9CEFE85230;
	Mon, 23 Dec 2019 08:15:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F3DlAYEOOriB; Mon, 23 Dec 2019 08:15:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 47B9884AE7;
	Mon, 23 Dec 2019 08:15:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3ED76C1D80;
	Mon, 23 Dec 2019 08:15:31 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11ABAC0881
 for <iommu@lists.linux-foundation.org>; Mon, 23 Dec 2019 08:15:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id CCC4F85EC1
 for <iommu@lists.linux-foundation.org>; Mon, 23 Dec 2019 08:15:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ohf5V01lX3fR for <iommu@lists.linux-foundation.org>;
 Mon, 23 Dec 2019 08:15:27 +0000 (UTC)
X-Greylist: delayed 00:16:12 by SQLgrey-1.7.6
Received: from baidu.com (mx20.baidu.com [111.202.115.85])
 by hemlock.osuosl.org (Postfix) with ESMTP id CB2558586F
 for <iommu@lists.linux-foundation.org>; Mon, 23 Dec 2019 08:15:26 +0000 (UTC)
Received: from BC-Mail-EX02.internal.baidu.com (unknown [172.31.51.42])
 by Forcepoint Email with ESMTPS id 114912F4CE9E590E9B21;
 Mon, 23 Dec 2019 15:59:12 +0800 (CST)
Received: from BC-Mail-Ex03.internal.baidu.com (172.31.51.43) by
 BC-Mail-EX02.internal.baidu.com (172.31.51.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1531.3; Mon, 23 Dec 2019 15:59:11 +0800
Received: from BC-Mail-Ex03.internal.baidu.com ([100.100.100.102]) by
 BC-Mail-Ex03.internal.baidu.com ([100.100.100.102]) with mapi id
 15.01.1531.010; Mon, 23 Dec 2019 15:59:11 +0800
From: "Jim,Yan" <jimyan@baidu.com>
To: Jerry Snitselaar <jsnitsel@redhat.com>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIGlvbW11L3Z0LWQ6IERvbid0IHJlamVjdCBudm1l?=
 =?utf-8?Q?_host_due_to_scope_mismatch?=
Thread-Topic: [PATCH] iommu/vt-d: Don't reject nvme host due to scope mismatch
Thread-Index: AQHVtwQzqYN7wsrm/0GpGcDkRO8H3qfCOiCAgAUlYIA=
Date: Mon, 23 Dec 2019 07:59:11 +0000
Message-ID: <606767b54ad4410abbdd9d053552074a@baidu.com>
References: <1576825674-18022-1-git-send-email-jimyan@baidu.com>
 <20191220092327.do34gtk3lcafzr6q@cantor>
In-Reply-To: <20191220092327.do34gtk3lcafzr6q@cantor>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.200.92]
x-baidu-bdmsfe-datecheck: 1_BC-Mail-EX02_2019-12-23 15:59:12:061
x-baidu-bdmsfe-viruscheck: BC-Mail-EX02_GRAY_Inside_WithoutAtta_2019-12-23
 15:59:12:045
MIME-Version: 1.0
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

PiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogSmVycnkgU25pdHNlbGFhciBb
bWFpbHRvOmpzbml0c2VsQHJlZGhhdC5jb21dDQo+IOWPkemAgeaXtumXtDogMjAxOeW5tDEy5pyI
MjDml6UgMTc6MjMNCj4g5pS25Lu25Lq6OiBKaW0sWWFuIDxqaW15YW5AYmFpZHUuY29tPg0KPiDm
ioTpgIE6IGpvcm9AOGJ5dGVzLm9yZzsgaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc7
DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4g5Li76aKYOiBSZTogW1BBVENIXSBp
b21tdS92dC1kOiBEb24ndCByZWplY3QgbnZtZSBob3N0IGR1ZSB0byBzY29wZSBtaXNtYXRjaA0K
PiANCj4gT24gRnJpIERlYyAyMCAxOSwgamlteWFuIHdyb3RlOg0KPiA+T24gYSBzeXN0ZW0gd2l0
aCBhbiBJbnRlbCBQQ0llIHBvcnQgY29uZmlndXJlZCBhcyBhIG52bWUgaG9zdCBkZXZpY2UsDQo+
ID5pb21tdSBpbml0aWFsaXphdGlvbiBmYWlscyB3aXRoDQo+ID4NCj4gPiAgICBETUFSOiBEZXZp
Y2Ugc2NvcGUgdHlwZSBkb2VzIG5vdCBtYXRjaCBmb3IgMDAwMDo4MDowMC4wDQo+ID4NCj4gPlRo
aXMgaXMgYmVjYXVzZSB0aGUgRE1BUiB0YWJsZSByZXBvcnRzIHRoaXMgZGV2aWNlIGFzIGhhdmlu
ZyBzY29wZSAyDQo+ID4oQUNQSV9ETUFSX1NDT1BFX1RZUEVfQlJJREdFKToNCj4gPg0KPiANCj4g
SXNuJ3QgdGhhdCBhIHByb2JsZW0gdG8gYmUgZml4ZWQgaW4gdGhlIERNQVIgdGFibGUgdGhlbj8N
Cj4gDQo+ID5idXQgdGhlIGRldmljZSBoYXMgYSB0eXBlIDAgUENJIGhlYWRlcjoNCj4gPjgwOjAw
LjAgQ2xhc3MgMDYwMDogRGV2aWNlIDgwODY6MjAyMCAocmV2IDA2KQ0KPiA+MDA6IDg2IDgwIDIw
IDIwIDQ3IDA1IDEwIDAwIDA2IDAwIDAwIDA2IDEwIDAwIDAwIDAwDQo+ID4xMDogMDAgMDAgMDAg
MDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDANCj4gPjIwOiAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCA4NiA4MCAwMCAwMA0KPiA+MzA6IDAwIDAwIDAwIDAw
IDkwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAxIDAwIDAwDQo+ID4NCj4gPlZULWQgd29ya3Mg
cGVyZmVjdGx5IG9uIHRoaXMgc3lzdGVtLCBzbyB0aGVyZSdzIG5vIHJlYXNvbiB0byBiYWlsIG91
dA0KPiA+b24gaW5pdGlhbGl6YXRpb24gZHVlIHRvIHRoaXMgYXBwYXJlbnQgc2NvcGUgbWlzbWF0
Y2guIEFkZCB0aGUgY2xhc3MNCj4gPjB4NjAwICgiUENJX0NMQVNTX0JSSURHRV9IT1NUIikgYXMg
YSBoZXVyaXN0aWMgZm9yIGFsbG93aW5nIERNQVINCj4gPmluaXRpYWxpemF0aW9uIGZvciBub24t
YnJpZGdlIFBDSSBkZXZpY2VzIGxpc3RlZCB3aXRoIHNjb3BlIGJyaWRnZS4NCj4gPg0KPiA+U2ln
bmVkLW9mZi1ieTogamlteWFuIDxqaW15YW5AYmFpZHUuY29tPg0KPiA+LS0tDQo+ID4gZHJpdmVy
cy9pb21tdS9kbWFyLmMgfCAxICsNCj4gPiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykN
Cj4gPg0KPiA+ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvZG1hci5jIGIvZHJpdmVycy9pb21t
dS9kbWFyLmMgaW5kZXgNCj4gPmVlY2Q2YTQyMTY2Ny4uOWZhZjJmMGUwMjM3IDEwMDY0NA0KPiA+
LS0tIGEvZHJpdmVycy9pb21tdS9kbWFyLmMNCj4gPisrKyBiL2RyaXZlcnMvaW9tbXUvZG1hci5j
DQo+ID5AQCAtMjQ0LDYgKzI0NCw3IEBAIGludCBkbWFyX2luc2VydF9kZXZfc2NvcGUoc3RydWN0
DQo+IGRtYXJfcGNpX25vdGlmeV9pbmZvICppbmZvLA0KPiA+IAkJICAgICBpbmZvLT5kZXYtPmhk
cl90eXBlICE9IFBDSV9IRUFERVJfVFlQRV9OT1JNQUwpIHx8DQo+ID4gCQkgICAgKHNjb3BlLT5l
bnRyeV90eXBlID09IEFDUElfRE1BUl9TQ09QRV9UWVBFX0JSSURHRSAmJg0KPiA+IAkJICAgICAo
aW5mby0+ZGV2LT5oZHJfdHlwZSA9PSBQQ0lfSEVBREVSX1RZUEVfTk9STUFMICYmDQo+ID4rCQkJ
ICBpbmZvLT5kZXYtPmNsYXNzID4+IDggIT0gUENJX0NMQVNTX0JSSURHRV9IT1NUICYmDQo+ID4g
CQkgICAgICBpbmZvLT5kZXYtPmNsYXNzID4+IDggIT0gUENJX0NMQVNTX0JSSURHRV9PVEhFUikp
KSB7DQo+ID4gCQkJcHJfd2FybigiRGV2aWNlIHNjb3BlIHR5cGUgZG9lcyBub3QgbWF0Y2ggZm9y
ICVzXG4iLA0KPiA+IAkJCQlwY2lfbmFtZShpbmZvLT5kZXYpKTsNCj4gPi0tDQo+ID4yLjExLjAN
Cj4gPg0KPiA+X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18N
Cj4gPmlvbW11IG1haWxpbmcgbGlzdA0KPiA+aW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcNCj4gPmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2lvbW11DQo+ID4NCkFjdHVhbGx5IHRoaXMgcGF0Y2ggaXMgc2ltaWxhciB0byB0aGUgY29tbWl0
OiBmZmIyZDFlYjg4YzMoImlvbW11L3Z0LWQ6IERvbid0IHJlamVjdCBOVEIgZGV2aWNlcyBkdWUg
dG8gc2NvcGUgbWlzbWF0Y2giKS4gQmVzaWRlcywgbW9kaWZ5aW5nIERNQVIgdGFibGUgbmVlZCBP
RU0gdXBkYXRlIEJJT1MuIEl0IGlzIGhhcmQgdG8gaW1wbGVtZW50Lg0KDQpKaW0NCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlz
dAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
