Return-Path: <SRS0=qe9F=AK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5041C433E0
	for <iommu@archiver.kernel.org>; Mon, 29 Jun 2020 15:41:27 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DB27253BB
	for <iommu@archiver.kernel.org>; Mon, 29 Jun 2020 15:41:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DB27253BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 1EB2E203E0;
	Mon, 29 Jun 2020 15:41:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3uk-18Hn-upv; Mon, 29 Jun 2020 15:41:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 0FCF3203C2;
	Mon, 29 Jun 2020 15:41:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E98DDC07FF;
	Mon, 29 Jun 2020 15:41:23 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C35E5C016E
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 15:41:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id B2DD6875F8
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 15:41:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I-JHznd4RfGc for <iommu@lists.linux-foundation.org>;
 Mon, 29 Jun 2020 15:41:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id AA9A1875EA
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 15:41:21 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3E111516;
 Mon, 29 Jun 2020 08:41:20 -0700 (PDT)
Received: from [10.57.21.32] (unknown [10.57.21.32])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD4A13F73C;
 Mon, 29 Jun 2020 08:41:18 -0700 (PDT)
Subject: Re: [PATCH net] xsk: remove cheap_dma optimization
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
 Christoph Hellwig <hch@lst.de>, Daniel Borkmann <daniel@iogearbox.net>
References: <20200626134358.90122-1-bjorn.topel@gmail.com>
 <c60dfb5a-2bf3-20bd-74b3-6b5e215f73f8@iogearbox.net>
 <20200627070406.GB11854@lst.de>
 <88d27e1b-dbda-301c-64ba-2391092e3236@intel.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <878626a2-6663-0d75-6339-7b3608aa4e42@arm.com>
Date: Mon, 29 Jun 2020 16:41:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <88d27e1b-dbda-301c-64ba-2391092e3236@intel.com>
Content-Language: en-GB
Cc: maximmi@mellanox.com, konrad.wilk@oracle.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jonathan.lemon@gmail.com, bpf@vger.kernel.org, davem@davemloft.net,
 magnus.karlsson@intel.com
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

T24gMjAyMC0wNi0yOCAxODoxNiwgQmrDtnJuIFTDtnBlbCB3cm90ZToKPiAKPiBPbiAyMDIwLTA2
LTI3IDA5OjA0LCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPj4gT24gU2F0LCBKdW4gMjcsIDIw
MjAgYXQgMDE6MDA6MTlBTSArMDIwMCwgRGFuaWVsIEJvcmttYW5uIHdyb3RlOgo+Pj4gR2l2ZW4g
dGhlcmUgaXMgcm91Z2hseSBhIH41IHdlZWtzIHdpbmRvdyBhdCBtYXggd2hlcmUgdGhpcyByZW1v
dmFsIGNvdWxkCj4+PiBzdGlsbCBiZSBhcHBsaWVkIGluIHRoZSB3b3JzdCBjYXNlLCBjb3VsZCB3
ZSBjb21lIHVwIHdpdGggYSBmaXggLyAKPj4+IHByb3Bvc2FsCj4+PiBmaXJzdCB0aGF0IG1vdmVz
IHRoaXMgaW50byB0aGUgRE1BIG1hcHBpbmcgY29yZT8gSWYgdGhlcmUgaXMgCj4+PiBzb21ldGhp
bmcgdGhhdAo+Pj4gY2FuIGJlIGFncmVlZCB1cG9uIGJ5IGFsbCBwYXJ0aWVzLCB0aGVuIHdlIGNv
dWxkIGF2b2lkIHJlLWFkZGluZyB0aGUgOSUKPj4+IHNsb3dkb3duLiA6Lwo+Pgo+PiBJJ2QgcmF0
aGVyIHR1cm4gaXQgdXBzaWRlIGRvd24gLSB0aGlzIGFidXNlIG9mIHRoZSBpbnRlcm5hbHMgYmxv
Y2tzIHdvcmsKPj4gdGhhdCBoYXMgYmFzaWNhbGx5IGp1c3QgbWlzc2VkIHRoZSBwcmV2aW91cyB3
aW5kb3cgYW5kIEknbSBub3QgZ29pbmcKPj4gdG8gd2FpdCB3ZWVrcyB0byBzb3J0IG91dCB0aGUg
QVBJIG1pc3VzZS7CoCBCdXQgd2UgY2FuIGFkZCBvcHRpbWl6YXRpb25zCj4+IGJhY2sgbGF0ZXIg
aWYgd2UgZmluZCBhIHNhbmUgd2F5Lgo+Pgo+IAo+IEknbSBub3Qgc3VwZXIgZXhjaXRlZCBhYm91
dCB0aGUgcGVyZm9ybWFuY2UgbG9zcywgYnV0IEkgZG8gZ2V0Cj4gQ2hyaXN0b3BoJ3MgZnJ1c3Ry
YXRpb24gYWJvdXQgZ3V0dGluZyB0aGUgRE1BIEFQSSBtYWtpbmcgaXQgaGFyZGVyIGZvcgo+IERN
QSBwZW9wbGUgdG8gZ2V0IHdvcmsgZG9uZS4gTGV0cyB0cnkgdG8gc29sdmUgdGhpcyBwcm9wZXJs
eSB1c2luZwo+IHByb3BlciBETUEgQVBJcy4KPiAKPiAKPj4gVGhhdCBiZWluZyBzYWlkIEkgcmVh
bGx5IGNhbid0IHNlZSBob3cgdGhpcyB3b3VsZCBtYWtlIHNvIG11Y2ggb2YgYQo+PiBkaWZmZXJl
bmNlLsKgIFdoYXQgYXJjaGl0ZWN0dXJlIGFuZCB3aGF0IGRtYV9vcHMgYXJlIHlvdSB1c2luZyBm
b3IKPj4gdGhvc2UgbWVhc3VyZW1lbnRzP8KgIFdoYXQgaXMgdGhlIHdvcmtsb2FkPwo+Pgo+IAo+
IFRoZSA5JSBpcyBmb3IgYW4gQUZfWERQIChGYXN0IHJhdyBFdGhlcm5ldCBzb2NrZXQuIFRoaW5r
IEFGX1BBQ0tFVCwgYnV0IAo+IGZhc3Rlci4pIGJlbmNobWFyazogcmVjZWl2ZSB0aGUgcGFja2V0
IGZyb20gdGhlIE5JQywgYW5kIGRyb3AgaXQuIFRoZSAKPiBETUEgc3luY3Mgc3RhbmQgb3V0IGlu
IHRoZSBwZXJmIHRvcDoKPiAKPiAgwqAgMjguNjMlwqAgW2tlcm5lbF3CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgW2tdIGk0MGVfY2xlYW5fcnhfaXJxX3pjCj4gIMKgIDE3LjEy
JcKgIFtrZXJuZWxdwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFtrXSB4cF9h
bGxvYwo+ICDCoMKgIDguODAlwqAgW2tlcm5lbF3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgW2tdIF9feHNrX3Jjdl96Ywo+ICDCoMKgIDcuNjklwqAgW2tlcm5lbF3CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgW2tdIHhkcF9kb19yZWRpcmVjdAo+ICDCoMKg
IDUuMzUlwqAgYnBmX3Byb2dfOTkyZDlkZGM4MzVlNTYyOcKgIFtrXSBicGZfcHJvZ185OTJkOWRk
YzgzNWU1NjI5Cj4gIMKgwqAgNC43NyXCoCBba2VybmVsXcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBba10geHNrX3Jjdi5wYXJ0LjAKPiAgwqDCoCA0LjA3JcKgIFtrZXJuZWxd
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFtrXSBfX3hza19tYXBfcmVkaXJl
Y3QKPiAgwqDCoCAzLjgwJcKgIFtrZXJuZWxdwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIFtrXSBkbWFfZGlyZWN0X3N5bmNfc2luZ2xlX2Zvcl9jcHUKPiAgwqDCoCAzLjAzJcKg
IFtrZXJuZWxdwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFtrXSBkbWFfZGly
ZWN0X3N5bmNfc2luZ2xlX2Zvcl9kZXZpY2UKPiAgwqDCoCAyLjc2JcKgIFtrZXJuZWxdwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFtrXSBpNDBlX2FsbG9jX3J4X2J1ZmZlcnNf
emMKPiAgwqDCoCAxLjgzJcKgIFtrZXJuZWxdwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIFtrXSB4c2tfZmx1c2gKPiAuLi4KPiAKPiBGb3IgdGhpcyBiZW5jaG1hcmsgdGhlIGRt
YV9vcHMgYXJlIE5VTEwgKGRtYV9pc19kaXJlY3QoKSA9PSB0cnVlKSwgYW5kCj4gdGhlIG1haW4g
aXNzdWUgaXMgdGhhdCBTV0lPVExCIGlzIG5vdyB1bmNvbmRpdGlvbmFsbHkgZW5hYmxlZCBbMV0g
Zm9yCj4geDg2LCBhbmQgZm9yIGVhY2ggc3luYyB3ZSBoYXZlIHRvIGNoZWNrIHRoYXQgaWYgaXNf
c3dpb3RsYl9idWZmZXIoKQo+IHdoaWNoIGludm9sdmVzIGEgc29tZSBjb3N0bHkgaW5kaXJlY3Rp
b24uCj4gCj4gVGhhdCB3YXMgcHJldHR5IG11Y2ggd2hhdCBteSBoYWNrIGF2b2lkZWQuIEluc3Rl
YWQgd2UgZGlkIGFsbCB0aGUgY2hlY2tzCj4gdXBmcm9udCwgc2luY2UgQUZfWERQIGhhcyBsb25n
LXRlcm0gRE1BIG1hcHBpbmdzLCBhbmQganVzdCBzZXQgYSBmbGFnCj4gZm9yIHRoYXQuCj4gCj4g
QXZvaWRpbmcgdGhlIHdob2xlICJpcyB0aGlzIGFkZHJlc3Mgc3dpb3RsYiIgaW4KPiBkbWFfZGly
ZWN0X3N5bmNfc2luZ2xlX2Zvcl97Y3B1LCBkZXZpY2VdKCkgcGVyLXBhY2tldAo+IHdvdWxkIGhl
bHAgYSBsb3QuCgpJJ20gcHJldHR5IHN1cmUgdGhhdCdzIG9uZSBvZiB0aGUgdGhpbmdzIHdlIGhv
cGUgdG8gYWNoaWV2ZSB3aXRoIHRoZSAKZ2VuZXJpYyBieXBhc3MgZmxhZyA6KQoKPiBTb21ld2hh
dCByZWxhdGVkIHRvIHRoZSBETUEgQVBJOyBJdCB3b3VsZCBoYXZlIHBlcmZvcm1hbmNlIGJlbmVm
aXRzIGZvcgo+IEFGX1hEUCBpZiB0aGUgRE1BIHJhbmdlIG9mIHRoZSBtYXBwZWQgbWVtb3J5IHdh
cyBsaW5lYXIsIGkuZS4gYnkgSU9NTVUKPiB1dGlsaXphdGlvbi4gSSd2ZSBzdGFydGVkIGhhY2tp
bmcgYSB0aGluZyBhIGxpdHRsZSBiaXQsIGJ1dCBpdCB3b3VsZCBiZQo+IG5pY2UgaWYgc3VjaCBB
UEkgd2FzIHBhcnQgb2YgdGhlIG1hcHBpbmcgY29yZS4KPiAKPiBJbnB1dDogYXJyYXkgb2YgcGFn
ZXMgT3V0cHV0OiBhcnJheSBvZiBkbWEgYWRkcnMgKGFuZCBvYnZpb3VzbHkgZGV2LAo+IGZsYWdz
IGFuZCBzdWNoKQo+IAo+IEZvciBub24tSU9NTVUgbGVuKGFycmF5IG9mIHBhZ2VzKSA9PSBsZW4o
YXJyYXkgb2YgZG1hIGFkZHJzKQo+IEZvciBiZXN0LWNhc2UgSU9NTVUgbGVuKGFycmF5IG9mIGRt
YSBhZGRycykgPT0gMSAobGFyZ2UgbGluZWFyIHNwYWNlKQo+IAo+IEJ1dCB0aGF0J3MgZm9yIGxh
dGVyLiA6LSkKCkZXSVcgeW91IHdpbGwgdHlwaWNhbGx5IGdldCB0aGF0IGJlaGF2aW91ciBmcm9t
IElPTU1VLWJhc2VkIAppbXBsZW1lbnRhdGlvbnMgb2YgZG1hX21hcF9zZygpIHJpZ2h0IG5vdywg
YWx0aG91Z2ggaXQncyBub3Qgc3RyaWN0bHkgCmd1YXJhbnRlZWQuIElmIHlvdSBjYW4gd2VhdGhl
ciBzb21lIGFkZGl0aW9uYWwgc2V0dXAgY29zdCBvZiBjYWxsaW5nIApzZ19hbGxvY190YWJsZV9m
cm9tX3BhZ2VzKCkgcGx1cyB3YWxraW5nIHRoZSBsaXN0IGFmdGVyIG1hcHBpbmcgdG8gdGVzdCAK
d2hldGhlciB5b3UgZGlkIGdldCBhIGNvbnRpZ3VvdXMgcmVzdWx0LCB5b3UgY291bGQgc3RhcnQg
dGFraW5nIAphZHZhbnRhZ2Ugb2YgaXQgYXMgc29tZSBvZiB0aGUgZG1hLWJ1ZiBjb2RlIGluIERS
TSBhbmQgdjRsMiBkb2VzIGFscmVhZHkgCihhbHRob3VnaCB0aG9zZSBjYXNlcyBhY3R1YWxseSB0
cmVhdCBpdCBhcyBhIHN0cmljdCBkZXBlbmRlbmN5IHJhdGhlciAKdGhhbiBhbiBvcHRpbWlzYXRp
b24pLgoKSSdtIGluY2xpbmVkIHRvIGFncmVlIHRoYXQgaWYgd2UncmUgZ29pbmcgdG8gc2VlIG1v
cmUgb2YgdGhlc2UgY2FzZXMsIGEgCm5ldyBBUEkgY2FsbCB0aGF0IGRpZCBmb3JtYWxseSBndWFy
YW50ZWUgYSBETUEtY29udGlndW91cyBtYXBwaW5nIAooZWl0aGVyIHZpYSBJT01NVSBvciBib3Vu
Y2UgYnVmZmVyaW5nKSBvciBmYWlsdXJlIG1pZ2h0IGluZGVlZCBiZSBoYW5keS4KClJvYmluLgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWls
aW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
