Return-Path: <SRS0=A6MP=2O=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B643C2D0D2
	for <iommu@archiver.kernel.org>; Tue, 24 Dec 2019 06:27:17 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8596206CB
	for <iommu@archiver.kernel.org>; Tue, 24 Dec 2019 06:27:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8596206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B71F68778E;
	Tue, 24 Dec 2019 06:27:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u1EFkacGay5B; Tue, 24 Dec 2019 06:27:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id EBB9587627;
	Tue, 24 Dec 2019 06:27:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DCECDC1D80;
	Tue, 24 Dec 2019 06:27:15 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 05D97C0881
 for <iommu@lists.linux-foundation.org>; Tue, 24 Dec 2019 06:27:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 022A987627
 for <iommu@lists.linux-foundation.org>; Tue, 24 Dec 2019 06:27:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k5-gN8DZES0L for <iommu@lists.linux-foundation.org>;
 Tue, 24 Dec 2019 06:27:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 33CC987582
 for <iommu@lists.linux-foundation.org>; Tue, 24 Dec 2019 06:27:14 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 23 Dec 2019 22:27:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,350,1571727600"; d="scan'208";a="367253756"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.215.56])
 ([10.254.215.56])
 by orsmga004.jf.intel.com with ESMTP; 23 Dec 2019 22:27:12 -0800
Subject: =?UTF-8?B?UmU6IOetlOWkjTog562U5aSNOiBbUEFUQ0hdIGlvbW11L3Z0LWQ6IERv?=
 =?UTF-8?Q?n=27t_reject_nvme_host_due_to_scope_mismatch?=
To: "Jim,Yan" <jimyan@baidu.com>, Jerry Snitselaar <jsnitsel@redhat.com>
References: <4b77511069cb4fbc982eebaad941cd23@baidu.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <149a454d-96ea-1e25-74d1-04a08f8b261e@linux.intel.com>
Date: Tue, 24 Dec 2019 14:27:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <4b77511069cb4fbc982eebaad941cd23@baidu.com>
Content-Language: en-US
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

SGkgSmltLAoKT24gMjAxOS8xMi8yNCAxMToyNCwgSmltLFlhbiB3cm90ZToKPj4gLS0tLS3pgq7k
u7bljp/ku7YtLS0tLQo+PiDlj5Hku7bkuro6IEx1IEJhb2x1IFttYWlsdG86YmFvbHUubHVAbGlu
dXguaW50ZWwuY29tXQo+PiDlj5HpgIHml7bpl7Q6IDIwMTnlubQxMuaciDIz5pelIDIxOjA1Cj4+
IOaUtuS7tuS6ujogSmltLFlhbiA8amlteWFuQGJhaWR1LmNvbT47IEplcnJ5IFNuaXRzZWxhYXIg
PGpzbml0c2VsQHJlZGhhdC5jb20+Cj4+IOaKhOmAgTogaW9tbXVAbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcKPj4g5Li76aKYOiBSZTog562U
5aSNOiBbUEFUQ0hdIGlvbW11L3Z0LWQ6IERvbid0IHJlamVjdCBudm1lIGhvc3QgZHVlIHRvIHNj
b3BlCj4+IG1pc21hdGNoCj4+Cj4+IEhpLAo+Pgo+PiBPbiAyMDE5LzEyLzIzIDE1OjU5LCBKaW0s
WWFuIHdyb3RlOgo+Pj4+IC0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0KPj4+PiDlj5Hku7bkuro6IEpl
cnJ5IFNuaXRzZWxhYXIgW21haWx0bzpqc25pdHNlbEByZWRoYXQuY29tXQo+Pj4+IOWPkemAgeaX
tumXtDogMjAxOeW5tDEy5pyIMjDml6UgMTc6MjMKPj4+PiDmlLbku7bkuro6IEppbSxZYW4gPGpp
bXlhbkBiYWlkdS5jb20+Cj4+Pj4g5oqE6YCBOiBqb3JvQDhieXRlcy5vcmc7IGlvbW11QGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnOwo+Pj4+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcK
Pj4+PiDkuLvpopg6IFJlOiBbUEFUQ0hdIGlvbW11L3Z0LWQ6IERvbid0IHJlamVjdCBudm1lIGhv
c3QgZHVlIHRvIHNjb3BlCj4+Pj4gbWlzbWF0Y2gKPj4+Pgo+Pj4+IE9uIEZyaSBEZWMgMjAgMTks
IGppbXlhbiB3cm90ZToKPj4+Pj4gT24gYSBzeXN0ZW0gd2l0aCBhbiBJbnRlbCBQQ0llIHBvcnQg
Y29uZmlndXJlZCBhcyBhIG52bWUgaG9zdAo+Pj4+PiBkZXZpY2UsIGlvbW11IGluaXRpYWxpemF0
aW9uIGZhaWxzIHdpdGgKPj4+Pj4KPj4+Pj4gICAgICBETUFSOiBEZXZpY2Ugc2NvcGUgdHlwZSBk
b2VzIG5vdCBtYXRjaCBmb3IgMDAwMDo4MDowMC4wCj4+Pj4+Cj4+Pj4+IFRoaXMgaXMgYmVjYXVz
ZSB0aGUgRE1BUiB0YWJsZSByZXBvcnRzIHRoaXMgZGV2aWNlIGFzIGhhdmluZyBzY29wZSAyCj4+
Pj4+IChBQ1BJX0RNQVJfU0NPUEVfVFlQRV9CUklER0UpOgo+Pj4+Pgo+Pj4+Cj4+Pj4gSXNuJ3Qg
dGhhdCBhIHByb2JsZW0gdG8gYmUgZml4ZWQgaW4gdGhlIERNQVIgdGFibGUgdGhlbj8KPj4+Pgo+
Pj4+PiBidXQgdGhlIGRldmljZSBoYXMgYSB0eXBlIDAgUENJIGhlYWRlcjoKPj4+Pj4gODA6MDAu
MCBDbGFzcyAwNjAwOiBEZXZpY2UgODA4NjoyMDIwIChyZXYgMDYpCj4+Pj4+IDAwOiA4NiA4MCAy
MCAyMCA0NyAwNSAxMCAwMCAwNiAwMCAwMCAwNiAxMCAwMCAwMCAwMAo+Pj4+PiAxMDogMDAgMDAg
MDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAKPj4+Pj4gMjA6IDAwIDAw
IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDg2IDgwIDAwIDAwCj4+Pj4+IDMwOiAwMCAw
MCAwMCAwMCA5MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMSAwMCAwMAo+Pj4+Pgo+Pj4+PiBW
VC1kIHdvcmtzIHBlcmZlY3RseSBvbiB0aGlzIHN5c3RlbSwgc28gdGhlcmUncyBubyByZWFzb24g
dG8gYmFpbAo+Pj4+PiBvdXQgb24gaW5pdGlhbGl6YXRpb24gZHVlIHRvIHRoaXMgYXBwYXJlbnQg
c2NvcGUgbWlzbWF0Y2guIEFkZCB0aGUKPj4+Pj4gY2xhc3MKPj4+Pj4gMHg2MDAgKCJQQ0lfQ0xB
U1NfQlJJREdFX0hPU1QiKSBhcyBhIGhldXJpc3RpYyBmb3IgYWxsb3dpbmcgRE1BUgo+Pj4+PiBp
bml0aWFsaXphdGlvbiBmb3Igbm9uLWJyaWRnZSBQQ0kgZGV2aWNlcyBsaXN0ZWQgd2l0aCBzY29w
ZSBicmlkZ2UuCj4+Pj4+Cj4+Pj4+IFNpZ25lZC1vZmYtYnk6IGppbXlhbiA8amlteWFuQGJhaWR1
LmNvbT4KPj4+Pj4gLS0tCj4+Pj4+IGRyaXZlcnMvaW9tbXUvZG1hci5jIHwgMSArCj4+Pj4+IDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQo+Pj4+Pgo+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9pb21tdS9kbWFyLmMgYi9kcml2ZXJzL2lvbW11L2RtYXIuYyBpbmRleAo+Pj4+PiBlZWNk
NmE0MjE2NjcuLjlmYWYyZjBlMDIzNyAxMDA2NDQKPj4+Pj4gLS0tIGEvZHJpdmVycy9pb21tdS9k
bWFyLmMKPj4+Pj4gKysrIGIvZHJpdmVycy9pb21tdS9kbWFyLmMKPj4+Pj4gQEAgLTI0NCw2ICsy
NDQsNyBAQCBpbnQgZG1hcl9pbnNlcnRfZGV2X3Njb3BlKHN0cnVjdAo+Pj4+IGRtYXJfcGNpX25v
dGlmeV9pbmZvICppbmZvLAo+Pj4+PiAJCSAgICAgaW5mby0+ZGV2LT5oZHJfdHlwZSAhPSBQQ0lf
SEVBREVSX1RZUEVfTk9STUFMKSB8fAo+Pj4+PiAJCSAgICAoc2NvcGUtPmVudHJ5X3R5cGUgPT0g
QUNQSV9ETUFSX1NDT1BFX1RZUEVfQlJJREdFCj4+ICYmCj4+Pj4+IAkJICAgICAoaW5mby0+ZGV2
LT5oZHJfdHlwZSA9PSBQQ0lfSEVBREVSX1RZUEVfTk9STUFMICYmCj4+Pj4+ICsJCQkgIGluZm8t
PmRldi0+Y2xhc3MgPj4gOCAhPSBQQ0lfQ0xBU1NfQlJJREdFX0hPU1QgJiYKPj4+Pj4gCQkgICAg
ICBpbmZvLT5kZXYtPmNsYXNzID4+IDggIT0gUENJX0NMQVNTX0JSSURHRV9PVEhFUikpKSB7Cj4+
Pj4+IAkJCXByX3dhcm4oIkRldmljZSBzY29wZSB0eXBlIGRvZXMgbm90IG1hdGNoIGZvciAlc1xu
IiwKPj4+Pj4gCQkJCXBjaV9uYW1lKGluZm8tPmRldikpOwo+Pj4+PiAtLQo+Pj4+PiAyLjExLjAK
Pj4+Pj4KPj4+Pj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KPj4+Pj4gaW9tbXUgbWFpbGluZyBsaXN0Cj4+Pj4+IGlvbW11QGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCj4+Pj4+IGh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2lvbW11Cj4+Pj4+Cj4+PiBBY3R1YWxseSB0aGlzIHBhdGNoIGlzIHNpbWlsYXIg
dG8gdGhlIGNvbW1pdDogZmZiMmQxZWI4OGMzKCJpb21tdS92dC1kOiBEb24ndAo+PiByZWplY3Qg
TlRCIGRldmljZXMgZHVlIHRvIHNjb3BlIG1pc21hdGNoIikuIEJlc2lkZXMsIG1vZGlmeWluZyBE
TUFSIHRhYmxlCj4+IG5lZWQgT0VNIHVwZGF0ZSBCSU9TLiBJdCBpcyBoYXJkIHRvIGltcGxlbWVu
dC4KPj4+Cj4+Cj4+IEZvciBib3RoIGNhc2VzLCBhIHF1aXJrIGZsYWcgc2VlbXMgdG8gYmUgbW9y
ZSByZWFzb25hYmxlLCBzbyB0aGF0IHVucmVsYXRlZAo+PiBkZXZpY2VzIHdpbGwgbm90IGJlIGlt
cGFjdGVkLgo+Pgo+PiBCZXN0IHJlZ2FyZHMsCj4+IGJhb2x1Cj4gCj4gSGkgQmFvbHUsCj4gCVRo
YW5rcyBmb3IgeW91ciBhZHZpY2UuIEFuZCBJIG1vZGlmeSB0aGUgcGF0Y2ggYXMgZm9sbG93LgoK
SSBqdXN0IHBvc3RlZCBhIHBhdGNoIGZvciBib3RoIE5URyBhbmQgTlZNRSBjYXNlcy4gQ2FuIHlv
dSBwbGVhc2UgdGFrZSBhCmxvb2s/IERvZXMgaXQgd29yayBmb3IgeW91PwoKQmVzdCByZWdhcmRz
LApiYW9sdQoKPiAKPiAgICAgIE9uIGEgc3lzdGVtIHdpdGggYW4gSW50ZWwgUENJZSBwb3J0IGNv
bmZpZ3VyZWQgYXMgYSBudm1lIGhvc3QgZGV2aWNlLCBpb21tdQo+ICAgICAgaW5pdGlhbGl6YXRp
b24gZmFpbHMgd2l0aAo+ICAgICAgCj4gICAgICAgICAgRE1BUjogRGV2aWNlIHNjb3BlIHR5cGUg
ZG9lcyBub3QgbWF0Y2ggZm9yIDAwMDA6ODA6MDAuMAo+ICAgICAgCj4gICAgICBUaGlzIGlzIGJl
Y2F1c2UgdGhlIERNQVIgdGFibGUgcmVwb3J0cyB0aGlzIGRldmljZSBhcyBoYXZpbmcgc2NvcGUg
Mgo+ICAgICAgKEFDUElfRE1BUl9TQ09QRV9UWVBFX0JSSURHRSk6Cj4gICAgICAKPiAgICAgIGJ1
dCB0aGUgZGV2aWNlIGhhcyBhIHR5cGUgMCBQQ0kgaGVhZGVyOgo+ICAgICAgODA6MDAuMCBDbGFz
cyAwNjAwOiBEZXZpY2UgODA4NjoyMDIwIChyZXYgMDYpCj4gICAgICAwMDogODYgODAgMjAgMjAg
NDcgMDUgMTAgMDAgMDYgMDAgMDAgMDYgMTAgMDAgMDAgMDAKPiAgICAgIDEwOiAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMAo+ICAgICAgMjA6IDAwIDAwIDAw
IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDg2IDgwIDAwIDAwCj4gICAgICAzMDogMDAgMDAg
MDAgMDAgOTAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDEgMDAgMDAKPiAgICAgIAo+ICAgICAg
VlQtZCB3b3JrcyBwZXJmZWN0bHkgb24gdGhpcyBzeXN0ZW0sIHNvIHRoZXJlJ3Mgbm8gcmVhc29u
IHRvIGJhaWwgb3V0Cj4gICAgICBvbiBpbml0aWFsaXphdGlvbiBkdWUgdG8gdGhpcyBhcHBhcmVu
dCBzY29wZSBtaXNtYXRjaC4gQWRkIHRoZSBjbGFzcwo+ICAgICAgMHgwNiAoIlBDSV9CQVNFX0NM
QVNTX0JSSURHRSIpIGFzIGEgaGV1cmlzdGljIGZvciBhbGxvd2luZyBETUFSCj4gICAgICBpbml0
aWFsaXphdGlvbiBmb3Igbm9uLWJyaWRnZSBQQ0kgZGV2aWNlcyBsaXN0ZWQgd2l0aCBzY29wZSBi
cmlkZ2UuCj4gICAgICAKPiAgICAgIFNpZ25lZC1vZmYtYnk6IGppbXlhbiA8amlteWFuQGJhaWR1
LmNvbT4KPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9kbWFyLmMgYi9kcml2ZXJzL2lv
bW11L2RtYXIuYwo+IGluZGV4IGVlY2Q2YTQyMTY2Ny4uNTBjOTJlYjIzZWU0IDEwMDY0NAo+IC0t
LSBhL2RyaXZlcnMvaW9tbXUvZG1hci5jCj4gKysrIGIvZHJpdmVycy9pb21tdS9kbWFyLmMKPiBA
QCAtMjQ0LDcgKzI0NCw3IEBAIGludCBkbWFyX2luc2VydF9kZXZfc2NvcGUoc3RydWN0IGRtYXJf
cGNpX25vdGlmeV9pbmZvICppbmZvLAo+ICAgICAgICAgICAgICAgICAgICAgICBpbmZvLT5kZXYt
Pmhkcl90eXBlICE9IFBDSV9IRUFERVJfVFlQRV9OT1JNQUwpIHx8Cj4gICAgICAgICAgICAgICAg
ICAgICAgKHNjb3BlLT5lbnRyeV90eXBlID09IEFDUElfRE1BUl9TQ09QRV9UWVBFX0JSSURHRSAm
Jgo+ICAgICAgICAgICAgICAgICAgICAgICAoaW5mby0+ZGV2LT5oZHJfdHlwZSA9PSBQQ0lfSEVB
REVSX1RZUEVfTk9STUFMICYmCj4gLSAgICAgICAgICAgICAgICAgICAgIGluZm8tPmRldi0+Y2xh
c3MgPj4gOCAhPSBQQ0lfQ0xBU1NfQlJJREdFX09USEVSKSkpIHsKPiArICAgICAgICAgICAgICAg
ICAgICAgaW5mby0+ZGV2LT5jbGFzcyA+PiAxNiAhPSBQQ0lfQkFTRV9DTEFTU19CUklER0UpKSkg
ewo+ICAgICAgICAgICAgICAgICAgICAgICAgICBwcl93YXJuKCJEZXZpY2Ugc2NvcGUgdHlwZSBk
b2VzIG5vdCBtYXRjaCBmb3IgJXNcbiIsCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgcGNpX25hbWUoaW5mby0+ZGV2KSk7Cj4gICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVy
biAtRUlOVkFMOwo+IAo+IAo+IEppbQo+IApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vaW9tbXU=
