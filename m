Return-Path: <SRS0=lDjG=O4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65C4C433EF
	for <iommu@archiver.kernel.org>; Fri,  8 Oct 2021 02:47:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 537A8610CC
	for <iommu@archiver.kernel.org>; Fri,  8 Oct 2021 02:47:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 537A8610CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0BF03607CF;
	Fri,  8 Oct 2021 02:47:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UvP9G62TDKM0; Fri,  8 Oct 2021 02:47:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D639660800;
	Fri,  8 Oct 2021 02:47:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AB943C0011;
	Fri,  8 Oct 2021 02:47:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 17624C000D
 for <iommu@lists.linux-foundation.org>; Fri,  8 Oct 2021 02:47:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EBA8084024
 for <iommu@lists.linux-foundation.org>; Fri,  8 Oct 2021 02:47:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M_x1XUCDVN4b for <iommu@lists.linux-foundation.org>;
 Fri,  8 Oct 2021 02:47:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3D66B83BF1
 for <iommu@lists.linux-foundation.org>; Fri,  8 Oct 2021 02:47:42 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10130"; a="226372205"
X-IronPort-AV: E=Sophos;i="5.85,356,1624345200"; d="scan'208";a="226372205"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2021 19:47:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,356,1624345200"; d="scan'208";a="478812854"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga007.jf.intel.com with ESMTP; 07 Oct 2021 19:47:39 -0700
Subject: Re: [PATCH v3 2/2] iommu/vt-d: avoid duplicated removing in
 __domain_mapping
To: "Longpeng(Mike)" <longpeng2@huawei.com>, dwmw2@infradead.org,
 will@kernel.org, joro@8bytes.org
References: <20211008000433.1115-1-longpeng2@huawei.com>
 <20211008000433.1115-3-longpeng2@huawei.com>
 <54cf3663-85e0-3e63-9112-385e9d6eeceb@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <1e83751f-5731-5786-c7d7-899542d7c2b7@linux.intel.com>
Date: Fri, 8 Oct 2021 10:43:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <54cf3663-85e0-3e63-9112-385e9d6eeceb@linux.intel.com>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org, arei.gonglei@huawei.com,
 linux-kernel@vger.kernel.org
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

T24gMTAvOC8yMSAxMDowNyBBTSwgTHUgQmFvbHUgd3JvdGU6Cj4gT24gMTAvOC8yMSA4OjA0IEFN
LCBMb25ncGVuZyhNaWtlKSB3cm90ZToKPj4gX19kb21haW5fbWFwcGluZygpIGFsd2F5cyByZW1v
dmVzIHRoZSBwYWdlcyBpbiB0aGUgcmFuZ2UgZnJvbQo+PiAnaW92X3BmbicgdG8gJ2VuZF9wZm4n
LCBidXQgdGhlICdlbmRfcGZuJyBpcyBhbHdheXMgdGhlIGxhc3QgcGZuCj4+IG9mIHRoZSByYW5n
ZSB0aGF0IHRoZSBjYWxsZXIgd2FudHMgdG8gbWFwLgo+Pgo+PiBUaGlzIHdvdWxkIGludHJvZHVj
ZSB0b28gbWFueSBkdXBsaWNhdGVkIHJlbW92aW5nIGFuZCBsZWFkcyB0aGUKPj4gbWFwIG9wZXJh
dGlvbiB0YWtlIHRvbyBsb25nLCBmb3IgZXhhbXBsZToKPj4KPj4gwqDCoCBNYXAgaW92YT0weDEw
MDAwMCxucl9wYWdlcz0weDdkNjE4MDAKPj4gwqDCoMKgwqAgaW92X3BmbjogMHgxMDAwMDAsIGVu
ZF9wZm46IDB4N2U2MTdmZgo+PiDCoMKgwqDCoCBpb3ZfcGZuOiAweDE0MDAwMCwgZW5kX3Bmbjog
MHg3ZTYxN2ZmCj4+IMKgwqDCoMKgIGlvdl9wZm46IDB4MTgwMDAwLCBlbmRfcGZuOiAweDdlNjE3
ZmYKPj4gwqDCoMKgwqAgaW92X3BmbjogMHgxYzAwMDAsIGVuZF9wZm46IDB4N2U2MTdmZgo+PiDC
oMKgwqDCoCBpb3ZfcGZuOiAweDIwMDAwMCwgZW5kX3BmbjogMHg3ZTYxN2ZmCj4+IMKgwqDCoMKg
IC4uLgo+PiDCoMKgIGl0IHRha2VzIGFib3V0IDUwbXMgaW4gdG90YWwuCj4+Cj4+IFdlIGNhbiBy
ZWR1Y2UgdGhlIGNvc3QgYnkgcmVjYWxjdWxhdGUgdGhlICdlbmRfcGZuJyBhbmQgbGltaXQgaXQK
Pj4gdG8gdGhlIGJvdW5kYXJ5IG9mIHRoZSBlbmQgb2YgdGhpcyBwdGUgcGFnZS4KPj4KPj4gwqDC
oCBNYXAgaW92YT0weDEwMDAwMCxucl9wYWdlcz0weDdkNjE4MDAKPj4gwqDCoMKgwqAgaW92X3Bm
bjogMHgxMDAwMDAsIGVuZF9wZm46IDB4MTNmZmZmCj4+IMKgwqDCoMKgIGlvdl9wZm46IDB4MTQw
MDAwLCBlbmRfcGZuOiAweDE3ZmZmZgo+PiDCoMKgwqDCoCBpb3ZfcGZuOiAweDE4MDAwMCwgZW5k
X3BmbjogMHgxYmZmZmYKPj4gwqDCoMKgwqAgaW92X3BmbjogMHgxYzAwMDAsIGVuZF9wZm46IDB4
MWZmZmZmCj4+IMKgwqDCoMKgIGlvdl9wZm46IDB4MjAwMDAwLCBlbmRfcGZuOiAweDIzZmZmZgo+
PiDCoMKgwqDCoCAuLi4KPj4gwqDCoCBpdCBvbmx5IG5lZWQgOW1zIG5vdy4KPj4KPj4gU2lnbmVk
LW9mZi1ieTogTG9uZ3BlbmcoTWlrZSkgPGxvbmdwZW5nMkBodWF3ZWkuY29tPgo+PiAtLS0KPj4g
wqAgZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5jIHwgMTEgKysrKysrLS0tLS0KPj4gwqAgaW5j
bHVkZS9saW51eC9pbnRlbC1pb21tdS5oIHzCoCA2ICsrKysrKwo+PiDCoCAyIGZpbGVzIGNoYW5n
ZWQsIDEyIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMgYi9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMK
Pj4gaW5kZXggZDc1ZjU5YS4uNDZlZGFlNiAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9pb21tdS9p
bnRlbC9pb21tdS5jCj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYwo+PiBAQCAt
MjM1NCwxMiArMjM1NCwxNyBAQCBzdGF0aWMgdm9pZCBzd2l0Y2hfdG9fc3VwZXJfcGFnZShzdHJ1
Y3QgCj4+IGRtYXJfZG9tYWluICpkb21haW4sCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgcmV0dXJuIC1FTk9NRU07Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZp
cnN0X3B0ZSA9IHB0ZTsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbHZsX3BhZ2VzID0gbHZs
X3RvX25yX3BhZ2VzKGxhcmdlcGFnZV9sdmwpOwo+PiArCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIC8qIEl0IGlzIGxhcmdlIHBhZ2UqLwo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBpZiAobGFyZ2VwYWdlX2x2bCA+IDEpIHsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB1bnNpZ25lZCBsb25nIGVuZF9wZm47Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgdW5zaWduZWQgbG9uZyBwYWdlc190b19yZW1vdmU7Cj4+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgcHRldmFsIHw9IERNQV9QVEVfTEFSR0VfUEFHRTsKPj4gLcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlbmRfcGZuID0gKChpb3ZfcGZuICsgbnJfcGFn
ZXMpICYgCj4+IGxldmVsX21hc2sobGFyZ2VwYWdlX2x2bCkpIC0gMTsKPj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBwYWdlc190b19yZW1vdmUgPSBtaW5fdCh1bnNpZ25lZCBsb25n
LCBucl9wYWdlcywKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBucl9wdGVfdG9fbmV4dF9wYWdlKHB0ZSkgKiBsdmxfcGFnZXMpOwo+PiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVuZF9wZm4gPSBpb3ZfcGZuICsgcGFnZXNf
dG9fcmVtb3ZlIC0gMTsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzd2l0
Y2hfdG9fc3VwZXJfcGFnZShkb21haW4sIGlvdl9wZm4sIGVuZF9wZm4sIAo+PiBsYXJnZXBhZ2Vf
bHZsKTsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfSBlbHNlIHsKPj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwdGV2YWwgJj0gfih1aW50NjRfdClETUFfUFRFX0xB
UkdFX1BBR0U7Cj4+IEBAIC0yMzgxLDEwICsyMzg2LDYgQEAgc3RhdGljIHZvaWQgc3dpdGNoX3Rv
X3N1cGVyX3BhZ2Uoc3RydWN0IAo+PiBkbWFyX2RvbWFpbiAqZG9tYWluLAo+PiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBXQVJOX09OKDEpOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+PiAt
wqDCoMKgwqDCoMKgwqAgbHZsX3BhZ2VzID0gbHZsX3RvX25yX3BhZ2VzKGxhcmdlcGFnZV9sdmwp
Owo+PiAtCj4+IC3CoMKgwqDCoMKgwqDCoCBCVUdfT04obnJfcGFnZXMgPCBsdmxfcGFnZXMpOwo+
PiAtCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBucl9wYWdlcyAtPSBsdmxfcGFnZXM7Cj4+IMKgwqDC
oMKgwqDCoMKgwqDCoCBpb3ZfcGZuICs9IGx2bF9wYWdlczsKPj4gwqDCoMKgwqDCoMKgwqDCoMKg
IHBoeXNfcGZuICs9IGx2bF9wYWdlczsKPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvaW50
ZWwtaW9tbXUuaCBiL2luY2x1ZGUvbGludXgvaW50ZWwtaW9tbXUuaAo+PiBpbmRleCA5YmNhYmM3
Li5iMjliMmEzIDEwMDY0NAo+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L2ludGVsLWlvbW11LmgKPj4g
KysrIGIvaW5jbHVkZS9saW51eC9pbnRlbC1pb21tdS5oCj4+IEBAIC03MTMsNiArNzEzLDEyIEBA
IHN0YXRpYyBpbmxpbmUgYm9vbCBmaXJzdF9wdGVfaW5fcGFnZShzdHJ1Y3QgCj4+IGRtYV9wdGUg
KnB0ZSkKPj4gwqDCoMKgwqDCoCByZXR1cm4gSVNfQUxJR05FRCgodW5zaWduZWQgbG9uZylwdGUs
IFZURF9QQUdFX1NJWkUpOwo+PiDCoCB9Cj4+ICtzdGF0aWMgaW5saW5lIGludCBucl9wdGVfdG9f
bmV4dF9wYWdlKHN0cnVjdCBkbWFfcHRlICpwdGUpCj4+ICt7Cj4+ICvCoMKgwqAgcmV0dXJuIGZp
cnN0X3B0ZV9pbl9wYWdlKHB0ZSkgPyBCSVRfVUxMKFZURF9TVFJJREVfU0hJRlQpIDoKPj4gK8Kg
wqDCoMKgwqDCoMKgIChzdHJ1Y3QgZG1hX3B0ZSAqKUFMSUdOKCh1bnNpZ25lZCBsb25nKXB0ZSwg
VlREX1BBR0VfU0laRSkgLSAKPj4gcHRlOwo+IAo+IFdlIHNob3VsZCBtYWtlIGl0IGxpa2UgdGhp
cyB0byBhdm9pZCB0aGUgMGRheSB3YXJuaW5nOgo+IAo+ICDCoMKgwqDCoChzdHJ1Y3QgZG1hX3B0
ZSAqKSh1aW50cHRyX3QpVlREX1BBR0VfQUxJR04oKHVuc2lnbmVkIGxvbmcpcHRlKSAtIHB0ZTsK
PiAKPiBDYW4geW91IHBsZWFzZSB0ZXN0IHRoaXMgbGluZSBvZiBjaGFuZ2U/IE5vIG5lZWQgdG8g
c2VuZCBhIG5ldyB2ZXJzaW9uLgo+IEkgd2lsbCBoYW5kbGUgaXQgaWYgaXQgcGFzc2VzIHlvdXIg
dGVzdC4KCkp1c3QgcmVhbGl6ZWQgdGhhdCBBTElHTigpIGhhcyBhbHJlYWR5IGRvbmUgdGhlIHR5
cGUgY2FzdC4gUGxlYXNlIGlnbm9yZQphYm92ZSBjb21tZW50LiBTb3JyeSBmb3IgdGhlIG5vaXNl
LgoKQmVzdCByZWdhcmRzLApiYW9sdQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vaW9tbXU=
