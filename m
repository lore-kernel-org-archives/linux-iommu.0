Return-Path: <SRS0=WS+C=HX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DAFC433DB
	for <iommu@archiver.kernel.org>; Sun, 21 Feb 2021 13:44:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C31E64D99
	for <iommu@archiver.kernel.org>; Sun, 21 Feb 2021 13:44:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C31E64D99
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0FC866ED68
	for <iommu@archiver.kernel.org>; Sun, 21 Feb 2021 13:44:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YL1-ANFPQ2T7 for <iommu@archiver.kernel.org>;
	Sun, 21 Feb 2021 13:44:49 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
	id 3E0146F47A; Sun, 21 Feb 2021 13:44:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 04E80605C9;
	Sun, 21 Feb 2021 13:44:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DBB44C000B;
	Sun, 21 Feb 2021 13:44:43 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5037BC0001
 for <iommu@lists.linux-foundation.org>; Sun, 21 Feb 2021 13:44:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3F2DE87094
 for <iommu@lists.linux-foundation.org>; Sun, 21 Feb 2021 13:44:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L1eLxxFlZ8MC for <iommu@lists.linux-foundation.org>;
 Sun, 21 Feb 2021 13:44:39 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 7488187092
 for <iommu@lists.linux-foundation.org>; Sun, 21 Feb 2021 13:44:39 +0000 (UTC)
Received: from [192.168.1.176]
 (dynamic-078-055-128-098.78.55.pool.telefonica.de [78.55.128.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5723A2064792E;
 Sun, 21 Feb 2021 14:44:36 +0100 (CET)
Subject: Re: [PATCH] iommu/amd: Fix event counter availability check
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: Alexander Monakov <amonakov@ispras.ru>, linux-kernel@vger.kernel.org
References: <20200529200738.1923-1-amonakov@ispras.ru>
 <alpine.LNX.2.20.13.2005311014450.16067@monopod.intra.ispras.ru>
 <1b2652e9-903e-c02f-8393-2775ae60f0b4@molgen.mpg.de>
Message-ID: <90b556ae-abdc-ffe7-e473-15ff1488f572@molgen.mpg.de>
Date: Sun, 21 Feb 2021 14:44:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1b2652e9-903e-c02f-8393-2775ae60f0b4@molgen.mpg.de>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org, Shuah Khan <skhan@linuxfoundation.org>
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

RGVhciBBbGV4YW5kZXIsCgoKQW0gMDEuMDYuMjAgdW0gMDQ6NDggc2NocmllYiBQYXVsIE1lbnpl
bDoKClvigKZdCgo+IEFtIDMxLjA1LjIwIHVtIDA5OjIyIHNjaHJpZWIgQWxleGFuZGVyIE1vbmFr
b3Y6Cj4gCj4+IEFkZGluZyBTaHVhaCBLaGFuIHRvIENjOiBJJ3ZlIG5vdGljZWQgeW91J3ZlIHNl
ZW4gdGhpcyBpc3N1ZSBvbiBSeXplbiAyNDAwR0U7Cj4+IGNhbiB5b3UgaGF2ZSBhIGxvb2sgYXQg
dGhlIHBhdGNoPyBXb3VsZCBiZSBuaWNlIHRvIGtub3cgaWYgaXQgZml4ZXMgdGhlCj4+IHByb2Js
ZW0gZm9yIHlvdSB0b28uCj4gCj4+IE9uIEZyaSwgMjkgTWF5IDIwMjAsIEFsZXhhbmRlciBNb25h
a292IHdyb3RlOgo+Pgo+Pj4gVGhlIGRyaXZlciBwZXJmb3JtcyBhbiBleHRyYSBjaGVjayBpZiB0
aGUgSU9NTVUncyBjYXBhYmlsaXRpZXMgYWR2ZXJ0aXNlCj4+PiBwcmVzZW5jZSBvZiBwZXJmb3Jt
YW5jZSBjb3VudGVyczogaXQgdmVyaWZpZXMgdGhhdCBjb3VudGVycyBhcmUgd3JpdGFibGUKPj4+
IGJ5IHdyaXRpbmcgYSBoYXJkLWNvZGVkIHZhbHVlIHRvIGEgY291bnRlciBhbmQgdGVzdGluZyB0
aGF0IHJlYWRpbmcgdGhhdAo+Pj4gY291bnRlciBnaXZlcyBiYWNrIHRoZSBzYW1lIHZhbHVlLgo+
Pj4KPj4+IFVuZm9ydHVuYXRlbHkgaXQgZG9lcyBzbyBxdWl0ZSBlYXJseSwgZXZlbiBiZWZvcmUg
cGNpX2VuYWJsZV9kZXZpY2UgaXMKPj4+IGNhbGxlZCBmb3IgdGhlIElPTU1VLCBpLmUuIHdoZW4g
YWNjZXNzaW5nIGl0cyBNTUlPIHNwYWNlIGlzIG5vdAo+Pj4gZ3VhcmFudGVlZCB0byB3b3JrLiBP
biBSeXplbiA0NTAwVSBDUFUsIHRoaXMgYWN0dWFsbHkgYnJlYWtzIHRoZSB0ZXN0Ogo+Pj4gdGhl
IGRyaXZlciBhc3N1bWVzIHRoZSBjb3VudGVycyBhcmUgbm90IHdyaXRhYmxlLCBhbmQgZGlzYWJs
ZXMgdGhlCj4+PiBmdW5jdGlvbmFsaXR5Lgo+Pj4KPj4+IE1vdmluZyBpbml0X2lvbW11X3BlcmZf
Y3RyIGp1c3QgYWZ0ZXIgaW9tbXVfZmx1c2hfYWxsX2NhY2hlcyByZXNvbHZlcwo+Pj4gdGhlIGlz
c3VlLiBUaGlzIGlzIHRoZSBlYXJsaWVzdCBwb2ludCBpbiBhbWRfaW9tbXVfaW5pdF9wY2kgd2hl
cmUgdGhlCj4+PiBjYWxsIHN1Y2NlZWRzIG9uIG15IGxhcHRvcC4KPj4+Cj4+PiBTaWduZWQtb2Zm
LWJ5OiBBbGV4YW5kZXIgTW9uYWtvdiA8YW1vbmFrb3ZAaXNwcmFzLnJ1Pgo+Pj4gQ2M6IEpvZXJn
IFJvZWRlbCA8am9yb0A4Ynl0ZXMub3JnPgo+Pj4gQ2M6IFN1cmF2ZWUgU3V0aGlrdWxwYW5pdCA8
c3VyYXZlZS5zdXRoaWt1bHBhbml0QGFtZC5jb20+Cj4+PiBDYzogaW9tbXVAbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKPj4+IC0tLQo+Pj4KPj4+IFBTLiBJJ20gc2VlaW5nIGFub3RoZXIgaGlj
Y3VwIHdpdGggSU9NTVUgcHJvYmluZyBvbiBteSBzeXN0ZW06Cj4+PiBwY2kgMDAwMDowMDowMC4y
OiBjYW4ndCBkZXJpdmUgcm91dGluZyBmb3IgUENJIElOVCBBCj4+PiBwY2kgMDAwMDowMDowMC4y
OiBQQ0kgSU5UIEE6IG5vdCBjb25uZWN0ZWQKPj4+Cj4+PiBIb3BlZnVsbHkgSSBjYW4gZmlndXJl
IGl0IG91dCwgYnV0IEknZCBhcHByZWNpYXRlIGhpbnRzLgo+IAo+IEkgZ3Vlc3MgaXTigJlzIGEg
ZmlybXdhcmUgYnVnLCBidXQgSSBjb250YWN0ZWQgdGhlIGxpbnV4LXBjaSBmb2xrcyBbMV0uCgpV
bmZvcnR1bmF0ZWx5LCBpdOKAmXMgc3RpbGwgcHJlc2VudCBpbiBMaW51eCA1LjExLgoKPj4+IMKg
IGRyaXZlcnMvaW9tbXUvYW1kX2lvbW11X2luaXQuYyB8IDYgKysrLS0tCj4+PiDCoCAxIGZpbGUg
Y2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+Pj4KPj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2lvbW11L2FtZF9pb21tdV9pbml0LmMgCj4+PiBiL2RyaXZlcnMvaW9tbXUv
YW1kX2lvbW11X2luaXQuYwo+Pj4gaW5kZXggNWI4MWZkMTZmNWZhLi4xYjdlYzZiNmEyODIgMTAw
NjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL2lvbW11L2FtZF9pb21tdV9pbml0LmMKPj4+ICsrKyBiL2Ry
aXZlcnMvaW9tbXUvYW1kX2lvbW11X2luaXQuYwo+Pj4gQEAgLTE3ODgsOCArMTc4OCw2IEBAIHN0
YXRpYyBpbnQgX19pbml0IGlvbW11X2luaXRfcGNpKHN0cnVjdCAKPj4+IGFtZF9pb21tdSAqaW9t
bXUpCj4+PiDCoMKgwqDCoMKgIGlmIChpb21tdS0+Y2FwICYgKDFVTCA8PCBJT01NVV9DQVBfTlBD
QUNIRSkpCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgYW1kX2lvbW11X25wX2NhY2hlID0gdHJ1ZTsK
Pj4+IC3CoMKgwqAgaW5pdF9pb21tdV9wZXJmX2N0cihpb21tdSk7Cj4+PiAtCj4+PiDCoMKgwqDC
oMKgIGlmIChpc19yZDg5MF9pb21tdShpb21tdS0+ZGV2KSkgewo+Pj4gwqDCoMKgwqDCoMKgwqDC
oMKgIGludCBpLCBqOwo+Pj4gQEAgLTE4OTEsOCArMTg4OSwxMCBAQCBzdGF0aWMgaW50IF9faW5p
dCBhbWRfaW9tbXVfaW5pdF9wY2kodm9pZCkKPj4+IMKgwqDCoMKgwqAgaW5pdF9kZXZpY2VfdGFi
bGVfZG1hKCk7Cj4+PiAtwqDCoMKgIGZvcl9lYWNoX2lvbW11KGlvbW11KQo+Pj4gK8KgwqDCoCBm
b3JfZWFjaF9pb21tdShpb21tdSkgewo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIGlvbW11X2ZsdXNo
X2FsbF9jYWNoZXMoaW9tbXUpOwo+Pj4gK8KgwqDCoMKgwqDCoMKgIGluaXRfaW9tbXVfcGVyZl9j
dHIoaW9tbXUpOwo+Pj4gK8KgwqDCoCB9Cj4+PiDCoMKgwqDCoMKgIGlmICghcmV0KQo+Pj4gwqDC
oMKgwqDCoMKgwqDCoMKgIHByaW50X2lvbW11X2luZm8oKTsKPj4+Cj4+PiBiYXNlLWNvbW1pdDog
NzVjYWYzMTBkMTZjYzVlMmY4NTFjMDQ4Y2Q1OTdmNTQzNzAxMzM2OAo+IAo+IFRoYW5rIHlvdSB2
ZXJ5IG11Y2ggZm9yIGZpeGluZyB0aGlzIGlzc3VlLCB3aGljaCBpcyBhbG1vc3QgdHdvIHllYXJz
IG9sZCAKPiBmb3IgbWUuCj4gCj4gVGVzdGVkLWJ5OiBQYXVsIE1lbnplbCA8cG1lbnplbEBtb2xn
ZW4ubXBnLmRlPgo+IE1TSSBNU0kgTVMtN0EzNy9CMzUwTSBNT1JUQVIgd2l0aCBBTUQgUnl6ZW4g
MyAyMjAwRwo+IExpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWlvbW11LzIwMTgw
NzI3MTAyNzEwLkdBNjczOEA4Ynl0ZXMub3JnLwoKSnVzdCBhIHNtYWxsIG5vdGUsIHRoYXQgSSBh
bSBhcHBseWluZyB5b3VyIHBhdGNoLCBidXQgaXQgbG9va3MgbGlrZSAKdGhlcmUgaXMgc3RpbGwg
c29tZSB0aW1pbmcgaXNzdWUuIEF0IGxlYXN0IHRvZGF5LCBJIG5vdGljZWQgaXQgZHVyaW5nIApv
bmUgYm9vdCB3aXRoIExpbnV4IDUuMTEuIChCZWZvcmUgSSBuZXZlciBub3RpY2VkIGl0IGFnYWlu
IGluIHRoZSAKc2V2ZXJhbCB5ZWFycywgYnV0IEkgYW0gbm90IGFsd2F5cyBwYXlpbmcgYXR0ZW50
aW9uIGFuZCBkbyBub3Qgc2F2ZSB0aGUgCmxvZ3MuKQoKCktpbmQgcmVnYXJkcywKClBhdWwKCgo+
IFsxXTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtcGNpLzg1NzliZDE0LWUzNjktMTE0
MS05MTdiLTIwNGQyMGNmZjUyOEBtb2xnZW4ubXBnLmRlLwpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vaW9tbXU=
