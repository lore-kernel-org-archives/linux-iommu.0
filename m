Return-Path: <SRS0=mWFx=7O=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0658C433DF
	for <iommu@archiver.kernel.org>; Mon,  1 Jun 2020 02:48:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42E15207D5
	for <iommu@archiver.kernel.org>; Mon,  1 Jun 2020 02:48:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42E15207D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id DCF9120343;
	Mon,  1 Jun 2020 02:48:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xhgaaz0tIuD0; Mon,  1 Jun 2020 02:48:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 8B6C520336;
	Mon,  1 Jun 2020 02:48:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6E6CCC088C;
	Mon,  1 Jun 2020 02:48:08 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AF471C0176
 for <iommu@lists.linux-foundation.org>; Mon,  1 Jun 2020 02:48:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 96FBC87A43
 for <iommu@lists.linux-foundation.org>; Mon,  1 Jun 2020 02:48:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nVDvJEJ-Qyxi for <iommu@lists.linux-foundation.org>;
 Mon,  1 Jun 2020 02:48:05 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C300387A12
 for <iommu@lists.linux-foundation.org>; Mon,  1 Jun 2020 02:48:04 +0000 (UTC)
Received: from [192.168.178.35] (unknown [94.134.88.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id BF0D82002EE14;
 Mon,  1 Jun 2020 04:48:01 +0200 (CEST)
Subject: Re: [PATCH] iommu/amd: Fix event counter availability check
To: Alexander Monakov <amonakov@ispras.ru>, linux-kernel@vger.kernel.org
References: <20200529200738.1923-1-amonakov@ispras.ru>
 <alpine.LNX.2.20.13.2005311014450.16067@monopod.intra.ispras.ru>
From: Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <1b2652e9-903e-c02f-8393-2775ae60f0b4@molgen.mpg.de>
Date: Mon, 1 Jun 2020 04:48:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.20.13.2005311014450.16067@monopod.intra.ispras.ru>
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

RGVhciBBbGV4YW5kZXIsCgoKVGhhbmsgeW91IHZlcnkgbXVjaCBmb3IgdGhlIHBhdGNoLgoKCkFt
IDMxLjA1LjIwIHVtIDA5OjIyIHNjaHJpZWIgQWxleGFuZGVyIE1vbmFrb3Y6Cgo+IEFkZGluZyBT
aHVhaCBLaGFuIHRvIENjOiBJJ3ZlIG5vdGljZWQgeW91J3ZlIHNlZW4gdGhpcyBpc3N1ZSBvbiBS
eXplbiAyNDAwR0U7Cj4gY2FuIHlvdSBoYXZlIGEgbG9vayBhdCB0aGUgcGF0Y2g/IFdvdWxkIGJl
IG5pY2UgdG8ga25vdyBpZiBpdCBmaXhlcyB0aGUKPiBwcm9ibGVtIGZvciB5b3UgdG9vLgoKPiBP
biBGcmksIDI5IE1heSAyMDIwLCBBbGV4YW5kZXIgTW9uYWtvdiB3cm90ZToKPiAKPj4gVGhlIGRy
aXZlciBwZXJmb3JtcyBhbiBleHRyYSBjaGVjayBpZiB0aGUgSU9NTVUncyBjYXBhYmlsaXRpZXMg
YWR2ZXJ0aXNlCj4+IHByZXNlbmNlIG9mIHBlcmZvcm1hbmNlIGNvdW50ZXJzOiBpdCB2ZXJpZmll
cyB0aGF0IGNvdW50ZXJzIGFyZSB3cml0YWJsZQo+PiBieSB3cml0aW5nIGEgaGFyZC1jb2RlZCB2
YWx1ZSB0byBhIGNvdW50ZXIgYW5kIHRlc3RpbmcgdGhhdCByZWFkaW5nIHRoYXQKPj4gY291bnRl
ciBnaXZlcyBiYWNrIHRoZSBzYW1lIHZhbHVlLgo+Pgo+PiBVbmZvcnR1bmF0ZWx5IGl0IGRvZXMg
c28gcXVpdGUgZWFybHksIGV2ZW4gYmVmb3JlIHBjaV9lbmFibGVfZGV2aWNlIGlzCj4+IGNhbGxl
ZCBmb3IgdGhlIElPTU1VLCBpLmUuIHdoZW4gYWNjZXNzaW5nIGl0cyBNTUlPIHNwYWNlIGlzIG5v
dAo+PiBndWFyYW50ZWVkIHRvIHdvcmsuIE9uIFJ5emVuIDQ1MDBVIENQVSwgdGhpcyBhY3R1YWxs
eSBicmVha3MgdGhlIHRlc3Q6Cj4+IHRoZSBkcml2ZXIgYXNzdW1lcyB0aGUgY291bnRlcnMgYXJl
IG5vdCB3cml0YWJsZSwgYW5kIGRpc2FibGVzIHRoZQo+PiBmdW5jdGlvbmFsaXR5Lgo+Pgo+PiBN
b3ZpbmcgaW5pdF9pb21tdV9wZXJmX2N0ciBqdXN0IGFmdGVyIGlvbW11X2ZsdXNoX2FsbF9jYWNo
ZXMgcmVzb2x2ZXMKPj4gdGhlIGlzc3VlLiBUaGlzIGlzIHRoZSBlYXJsaWVzdCBwb2ludCBpbiBh
bWRfaW9tbXVfaW5pdF9wY2kgd2hlcmUgdGhlCj4+IGNhbGwgc3VjY2VlZHMgb24gbXkgbGFwdG9w
Lgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBBbGV4YW5kZXIgTW9uYWtvdiA8YW1vbmFrb3ZAaXNwcmFz
LnJ1Pgo+PiBDYzogSm9lcmcgUm9lZGVsIDxqb3JvQDhieXRlcy5vcmc+Cj4+IENjOiBTdXJhdmVl
IFN1dGhpa3VscGFuaXQgPHN1cmF2ZWUuc3V0aGlrdWxwYW5pdEBhbWQuY29tPgo+PiBDYzogaW9t
bXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKPj4gLS0tCj4+Cj4+IFBTLiBJJ20gc2VlaW5n
IGFub3RoZXIgaGljY3VwIHdpdGggSU9NTVUgcHJvYmluZyBvbiBteSBzeXN0ZW06Cj4+IHBjaSAw
MDAwOjAwOjAwLjI6IGNhbid0IGRlcml2ZSByb3V0aW5nIGZvciBQQ0kgSU5UIEEKPj4gcGNpIDAw
MDA6MDA6MDAuMjogUENJIElOVCBBOiBub3QgY29ubmVjdGVkCj4+Cj4+IEhvcGVmdWxseSBJIGNh
biBmaWd1cmUgaXQgb3V0LCBidXQgSSdkIGFwcHJlY2lhdGUgaGludHMuCgpJIGd1ZXNzIGl04oCZ
cyBhIGZpcm13YXJlIGJ1ZywgYnV0IEkgY29udGFjdGVkIHRoZSBsaW51eC1wY2kgZm9sa3MgWzFd
LgoKPj4gICBkcml2ZXJzL2lvbW11L2FtZF9pb21tdV9pbml0LmMgfCA2ICsrKy0tLQo+PiAgIDEg
ZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2lvbW11L2FtZF9pb21tdV9pbml0LmMgYi9kcml2ZXJzL2lvbW11L2Ft
ZF9pb21tdV9pbml0LmMKPj4gaW5kZXggNWI4MWZkMTZmNWZhLi4xYjdlYzZiNmEyODIgMTAwNjQ0
Cj4+IC0tLSBhL2RyaXZlcnMvaW9tbXUvYW1kX2lvbW11X2luaXQuYwo+PiArKysgYi9kcml2ZXJz
L2lvbW11L2FtZF9pb21tdV9pbml0LmMKPj4gQEAgLTE3ODgsOCArMTc4OCw2IEBAIHN0YXRpYyBp
bnQgX19pbml0IGlvbW11X2luaXRfcGNpKHN0cnVjdCBhbWRfaW9tbXUgKmlvbW11KQo+PiAgIAlp
ZiAoaW9tbXUtPmNhcCAmICgxVUwgPDwgSU9NTVVfQ0FQX05QQ0FDSEUpKQo+PiAgIAkJYW1kX2lv
bW11X25wX2NhY2hlID0gdHJ1ZTsKPj4gICAKPj4gLQlpbml0X2lvbW11X3BlcmZfY3RyKGlvbW11
KTsKPj4gLQo+PiAgIAlpZiAoaXNfcmQ4OTBfaW9tbXUoaW9tbXUtPmRldikpIHsKPj4gICAJCWlu
dCBpLCBqOwo+PiAgIAo+PiBAQCAtMTg5MSw4ICsxODg5LDEwIEBAIHN0YXRpYyBpbnQgX19pbml0
IGFtZF9pb21tdV9pbml0X3BjaSh2b2lkKQo+PiAgIAo+PiAgIAlpbml0X2RldmljZV90YWJsZV9k
bWEoKTsKPj4gICAKPj4gLQlmb3JfZWFjaF9pb21tdShpb21tdSkKPj4gKwlmb3JfZWFjaF9pb21t
dShpb21tdSkgewo+PiAgIAkJaW9tbXVfZmx1c2hfYWxsX2NhY2hlcyhpb21tdSk7Cj4+ICsJCWlu
aXRfaW9tbXVfcGVyZl9jdHIoaW9tbXUpOwo+PiArCX0KPj4gICAKPj4gICAJaWYgKCFyZXQpCj4+
ICAgCQlwcmludF9pb21tdV9pbmZvKCk7Cj4+Cj4+IGJhc2UtY29tbWl0OiA3NWNhZjMxMGQxNmNj
NWUyZjg1MWMwNDhjZDU5N2Y1NDM3MDEzMzY4CgpUaGFuayB5b3UgdmVyeSBtdWNoIGZvciBmaXhp
bmcgdGhpcyBpc3N1ZSwgd2hpY2ggaXMgYWxtb3N0IHR3byB5ZWFycyBvbGQgCmZvciBtZS4KClRl
c3RlZC1ieTogUGF1bCBNZW56ZWwgPHBtZW56ZWxAbW9sZ2VuLm1wZy5kZT4KTVNJIE1TSSBNUy03
QTM3L0IzNTBNIE1PUlRBUiB3aXRoIEFNRCBSeXplbiAzIDIyMDBHCkxpbms6IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2xpbnV4LWlvbW11LzIwMTgwNzI3MTAyNzEwLkdBNjczOEA4Ynl0ZXMub3Jn
LwoKCktpbmQgcmVnYXJkcywKClBhdWwKCgpbMV06IApodHRwczovL2xvcmUua2VybmVsLm9yZy9s
aW51eC1wY2kvODU3OWJkMTQtZTM2OS0xMTQxLTkxN2ItMjA0ZDIwY2ZmNTI4QG1vbGdlbi5tcGcu
ZGUvCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11
IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
