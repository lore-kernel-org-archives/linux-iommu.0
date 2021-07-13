Return-Path: <SRS0=kZfo=MF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,URIBL_RED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7B3C07E96
	for <iommu@archiver.kernel.org>; Tue, 13 Jul 2021 18:25:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B08B601FC
	for <iommu@archiver.kernel.org>; Tue, 13 Jul 2021 18:25:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B08B601FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C2D8C60768;
	Tue, 13 Jul 2021 18:25:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DzHvQwVJJbul; Tue, 13 Jul 2021 18:25:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A126760655;
	Tue, 13 Jul 2021 18:25:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 81F56C0010;
	Tue, 13 Jul 2021 18:25:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D8A4C000E
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 18:25:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 08C6A401B1
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 18:25:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zNLxo35x_av6 for <iommu@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 18:25:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 056904012A
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 18:25:30 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A6661FB;
 Tue, 13 Jul 2021 11:25:30 -0700 (PDT)
Received: from [10.57.36.240] (unknown [10.57.36.240])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB8883F7D8;
 Tue, 13 Jul 2021 11:25:28 -0700 (PDT)
Subject: Re: [PATCH v5 4/7] iommu: Factor iommu_iotlb_gather_is_disjoint() out
To: Nadav Amit <nadav.amit@gmail.com>, Joerg Roedel <joro@8bytes.org>
References: <20210713094151.652597-1-namit@vmware.com>
 <20210713094151.652597-5-namit@vmware.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <618969ce-c220-a1bd-1e0e-33a22338e718@arm.com>
Date: Tue, 13 Jul 2021 19:25:18 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210713094151.652597-5-namit@vmware.com>
Content-Language: en-GB
Cc: Nadav Amit <namit@vmware.com>, iommu@lists.linux-foundation.org,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 Jiajun Cao <caojiajun@vmware.com>
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

T24gMjAyMS0wNy0xMyAxMDo0MSwgTmFkYXYgQW1pdCB3cm90ZToKPiBGcm9tOiBOYWRhdiBBbWl0
IDxuYW1pdEB2bXdhcmUuY29tPgo+IAo+IFJlZmFjdG9yIGlvbW11X2lvdGxiX2dhdGhlcl9hZGRf
cGFnZSgpIGFuZCBmYWN0b3Igb3V0IHRoZSBsb2dpYyB0aGF0Cj4gZGV0ZWN0cyB3aGV0aGVyIElP
VExCIGdhdGhlciByYW5nZSBhbmQgYSBuZXcgcmFuZ2UgYXJlIGRpc2pvaW50LiBUbyBiZQo+IHVz
ZWQgYnkgdGhlIG5leHQgcGF0Y2ggdGhhdCBpbXBsZW1lbnRzIGRpZmZlcmVudCBnYXRoZXJpbmcg
bG9naWMgZm9yCj4gQU1ELgo+IAo+IE5vdGUgdGhhdCB1cGRhdGluZyBnYXRoZXItPnBnc2l6ZSB1
bmNvbmRpdGlvbmFsbHkgZG9lcyBub3QgYWZmZWN0Cj4gY29ycmVjdG5lc3MgYXMgdGhlIGZ1bmN0
aW9uIGhhZCAoYW5kIGhhcykgYW4gaW52YXJpYW50LCBpbiB3aGljaAo+IGdhdGhlci0+cGdzaXpl
IGFsd2F5cyByZXByZXNlbnRzIHRoZSBmbHVzaGluZyBncmFudWxhcml0eSBvZiBpdHMgcmFuZ2Uu
Cj4gQXJndWFibHksIOKAnHNpemUiIHNob3VsZCBuZXZlciBiZSB6ZXJvLCBidXQgbGV0cyBhc3N1
bWUgZm9yIHRoZSBtYXR0ZXIgb2YKPiBkaXNjdXNzaW9uIHRoYXQgaXQgbWlnaHQuCj4gCj4gSWYg
InNpemUiIGVxdWFscyB0byAiZ2F0aGVyLT5wZ3NpemUiLCB0aGVuIHRoZSBhc3NpZ25tZW50IGlu
IHF1ZXN0aW9uCj4gaGFzIG5vIGltcGFjdC4KPiAKPiBPdGhlcndpc2UsIGlmICJzaXplIiBpcyBu
b24temVybywgdGhlbiBpb21tdV9pb3RsYl9zeW5jKCkgd291bGQKPiBpbml0aWFsaXplIHRoZSBz
aXplIGFuZCByYW5nZSAoc2VlIGlvbW11X2lvdGxiX2dhdGhlcl9pbml0KCkpLCBhbmQgdGhlCj4g
aW52YXJpYW50IGlzIGtlcHQuCj4gCj4gT3RoZXJ3aXNlLCAic2l6ZSIgaXMgemVybywgYW5kICJn
YXRoZXIiIGFscmVhZHkgaG9sZHMgYSByYW5nZSwgc28KPiBnYXRoZXItPnBnc2l6ZSBpcyBub24t
emVybyBhbmQgKGdhdGhlci0+cGdzaXplICYmIGdhdGhlci0+cGdzaXplICE9Cj4gc2l6ZSkgaXMg
dHJ1ZS4gVGhlcmVmb3JlLCBhZ2FpbiwgaW9tbXVfaW90bGJfc3luYygpIHdvdWxkIGJlIGNhbGxl
ZCBhbmQKPiBpbml0aWFsaXplIHRoZSBzaXplLgoKV2l0aCB0aGUgY2F2ZWF0IG9mIG9uZSBjb21t
ZW50IG9uIHRoZSBuZXh0IHBhdGNoLi4uCgpSZXZpZXdlZC1ieTogUm9iaW4gTXVycGh5IDxyb2Jp
bi5tdXJwaHlAYXJtLmNvbT4KCj4gQ2M6IEpvZXJnIFJvZWRlbCA8am9yb0A4Ynl0ZXMub3JnPgo+
IENjOiBKaWFqdW4gQ2FvIDxjYW9qaWFqdW5Adm13YXJlLmNvbT4KPiBDYzogUm9iaW4gTXVycGh5
IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT4KPiBDYzogTHUgQmFvbHUgPGJhb2x1Lmx1QGxpbnV4Lmlu
dGVsLmNvbT4KPiBDYzogaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKPiBDYzogbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZz4KPiBBY2tlZC1ieTogV2lsbCBEZWFjb24gPHdpbGxA
a2VybmVsLm9yZz4KPiBTaWduZWQtb2ZmLWJ5OiBOYWRhdiBBbWl0IDxuYW1pdEB2bXdhcmUuY29t
Pgo+IC0tLQo+ICAgaW5jbHVkZS9saW51eC9pb21tdS5oIHwgMzQgKysrKysrKysrKysrKysrKysr
KysrKysrKystLS0tLS0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKyksIDgg
ZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvaW9tbXUuaCBiL2lu
Y2x1ZGUvbGludXgvaW9tbXUuaAo+IGluZGV4IGU1NTQ4NzFkYjQ2Zi4uOTc5YTVjZWVlYTU1IDEw
MDY0NAo+IC0tLSBhL2luY2x1ZGUvbGludXgvaW9tbXUuaAo+ICsrKyBiL2luY2x1ZGUvbGludXgv
aW9tbXUuaAo+IEBAIC00OTcsNiArNDk3LDI4IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBpb21tdV9p
b3RsYl9zeW5jKHN0cnVjdCBpb21tdV9kb21haW4gKmRvbWFpbiwKPiAgIAlpb21tdV9pb3RsYl9n
YXRoZXJfaW5pdChpb3RsYl9nYXRoZXIpOwo+ICAgfQo+ICAgCj4gKy8qKgo+ICsgKiBpb21tdV9p
b3RsYl9nYXRoZXJfaXNfZGlzam9pbnQgLSBDaGVja3Mgd2hldGhlciBhIG5ldyByYW5nZSBpcyBk
aXNqb2ludAo+ICsgKgo+ICsgKiBAZ2F0aGVyOiBUTEIgZ2F0aGVyIGRhdGEKPiArICogQGlvdmE6
IHN0YXJ0IG9mIHBhZ2UgdG8gaW52YWxpZGF0ZQo+ICsgKiBAc2l6ZTogc2l6ZSBvZiBwYWdlIHRv
IGludmFsaWRhdGUKPiArICoKPiArICogSGVscGVyIGZvciBJT01NVSBkcml2ZXJzIHRvIGNoZWNr
IHdoZXRoZXIgYSBuZXcgcmFuZ2UgYW5kIHRoZSBnYXRoZXJlZCByYW5nZQo+ICsgKiBhcmUgZGlz
am9pbnQuIEZvciBtYW55IElPTU1VcywgZmx1c2hpbmcgdGhlIElPTU1VIGluIHRoaXMgY2FzZSBp
cyBiZXR0ZXIKPiArICogdGhhbiBtZXJnaW5nIHRoZSB0d28sIHdoaWNoIG1pZ2h0IGxlYWQgdG8g
dW5uZWNlc3NhcnkgaW52YWxpZGF0aW9ucy4KPiArICovCj4gK3N0YXRpYyBpbmxpbmUKPiArYm9v
bCBpb21tdV9pb3RsYl9nYXRoZXJfaXNfZGlzam9pbnQoc3RydWN0IGlvbW11X2lvdGxiX2dhdGhl
ciAqZ2F0aGVyLAo+ICsJCQkJICAgIHVuc2lnbmVkIGxvbmcgaW92YSwgc2l6ZV90IHNpemUpCj4g
K3sKPiArCXVuc2lnbmVkIGxvbmcgc3RhcnQgPSBpb3ZhLCBlbmQgPSBzdGFydCArIHNpemUgLSAx
Owo+ICsKPiArCXJldHVybiBnYXRoZXItPmVuZCAhPSAwICYmCj4gKwkJKGVuZCArIDEgPCBnYXRo
ZXItPnN0YXJ0IHx8IHN0YXJ0ID4gZ2F0aGVyLT5lbmQgKyAxKTsKPiArfQo+ICsKPiArCj4gICAv
KioKPiAgICAqIGlvbW11X2lvdGxiX2dhdGhlcl9hZGRfcmFuZ2UgLSBHYXRoZXIgZm9yIGFkZHJl
c3MtYmFzZWQgVExCIGludmFsaWRhdGlvbgo+ICAgICogQGdhdGhlcjogVExCIGdhdGhlciBkYXRh
Cj4gQEAgLTUzMywyMCArNTU1LDE2IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBpb21tdV9pb3RsYl9n
YXRoZXJfYWRkX3BhZ2Uoc3RydWN0IGlvbW11X2RvbWFpbiAqZG9tYWluLAo+ICAgCQkJCQkgICAg
ICAgc3RydWN0IGlvbW11X2lvdGxiX2dhdGhlciAqZ2F0aGVyLAo+ICAgCQkJCQkgICAgICAgdW5z
aWduZWQgbG9uZyBpb3ZhLCBzaXplX3Qgc2l6ZSkKPiAgIHsKPiAtCXVuc2lnbmVkIGxvbmcgc3Rh
cnQgPSBpb3ZhLCBlbmQgPSBzdGFydCArIHNpemUgLSAxOwo+IC0KPiAgIAkvKgo+ICAgCSAqIElm
IHRoZSBuZXcgcGFnZSBpcyBkaXNqb2ludCBmcm9tIHRoZSBjdXJyZW50IHJhbmdlIG9yIGlzIG1h
cHBlZCBhdAo+ICAgCSAqIGEgZGlmZmVyZW50IGdyYW51bGFyaXR5LCB0aGVuIHN5bmMgdGhlIFRM
QiBzbyB0aGF0IHRoZSBnYXRoZXIKPiAgIAkgKiBzdHJ1Y3R1cmUgY2FuIGJlIHJld3JpdHRlbi4K
PiAgIAkgKi8KPiAtCWlmIChnYXRoZXItPnBnc2l6ZSAhPSBzaXplIHx8Cj4gLQkgICAgZW5kICsg
MSA8IGdhdGhlci0+c3RhcnQgfHwgc3RhcnQgPiBnYXRoZXItPmVuZCArIDEpIHsKPiAtCQlpZiAo
Z2F0aGVyLT5wZ3NpemUpCj4gLQkJCWlvbW11X2lvdGxiX3N5bmMoZG9tYWluLCBnYXRoZXIpOwo+
IC0JCWdhdGhlci0+cGdzaXplID0gc2l6ZTsKPiAtCX0KPiArCWlmICgoZ2F0aGVyLT5wZ3NpemUg
JiYgZ2F0aGVyLT5wZ3NpemUgIT0gc2l6ZSkgfHwKPiArCSAgICBpb21tdV9pb3RsYl9nYXRoZXJf
aXNfZGlzam9pbnQoZ2F0aGVyLCBpb3ZhLCBzaXplKSkKPiArCQlpb21tdV9pb3RsYl9zeW5jKGRv
bWFpbiwgZ2F0aGVyKTsKPiAgIAo+ICsJZ2F0aGVyLT5wZ3NpemUgPSBzaXplOwo+ICAgCWlvbW11
X2lvdGxiX2dhdGhlcl9hZGRfcmFuZ2UoZ2F0aGVyLCBpb3ZhLCBzaXplKTsKPiAgIH0KPiAgIAo+
IApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBt
YWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
