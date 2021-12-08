Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35BADC433EF
	for <iommu@archiver.kernel.org>; Wed,  8 Dec 2021 10:18:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B92C04013A;
	Wed,  8 Dec 2021 10:18:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3AyofI2hQsam; Wed,  8 Dec 2021 10:18:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 809A840207;
	Wed,  8 Dec 2021 10:18:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 227DCC001E;
	Wed,  8 Dec 2021 10:18:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9F64BC0012
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 10:18:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8216D84B6B
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 10:18:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=fail (2048-bit key) reason="fail (bad RSA signature)"
 header.d=collabora.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7zGgDuvU_cE4 for <iommu@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 10:18:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0DC7484B6A
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 10:18:28 +0000 (UTC)
Received: from [IPv6:2a00:c281:1230:3700:51d0:7039:5913:64d3] (unknown
 [IPv6:2a00:c281:1230:3700:51d0:7039:5913:64d3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: dafna)
 by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 3C3151F45B78;
 Wed,  8 Dec 2021 10:18:26 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
 t=1638958707; bh=XIp6xgTjTz1fumiAWczWcdggIWQ+LeHxsFc60JWF7Ps=;
 h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
 b=CvB+lbSI8KGOkVe64pC7KSWOPjGy2HdhiLNHkl8TISiHEF5zVr2bYafItXVKu4HiC
 CyGvWKkh0Z1vpcQ7rbvwLCWVKEreJeB9vSNXZtAOXsiwTtRxsLMLeek41jmJvdIi6N
 T9+BQaVRSlxyGH0CSO56/mEMoS0XtkvZBhoAXEz2V2LFfYHEFdrYCQQQtbxS4pEKv1
 gZWDUknmpbI0OlylsTkD2Yed/YvxSoiZM4yUagxUkzZgZRcW1PSslyruTlkMoXvdpF
 4sSNPaRkg4nYga3W0JhF8L1mIhk4Ds0hUTcotdo9U50WEI//Cec9Osuw0ftD54roJo
 A/3OMDOcAMhMg==
Subject: Re: [PATCH 1/2] iommu/mediatek: Always tlb_flush_all when each PM
 resume
From: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To: Yong Wu <yong.wu@mediatek.com>
References: <20211122104400.4160-1-dafna.hirschfeld@collabora.com>
 <20211122104400.4160-2-dafna.hirschfeld@collabora.com>
 <6abef78f6447c626b737fd35688f421c29871f43.camel@mediatek.com>
 <d30438bf-9add-7904-bad0-0764e3602263@collabora.com>
 <35d53ea0-68db-a516-9e9c-272e8f0ed082@collabora.com>
Message-ID: <b246cd23-f19e-e3d9-a19e-2f598b6d1425@collabora.com>
Date: Wed, 8 Dec 2021 12:18:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <35d53ea0-68db-a516-9e9c-272e8f0ed082@collabora.com>
Content-Language: en-US
Cc: open list <linux-kernel@vger.kernel.org>, sebastian.reichel@collabora.com,
 iommu@lists.linux-foundation.org,
 "moderated list:MEDIATEK IOMMU DRIVER" <linux-mediatek@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, kernel@collabora.com,
 Will Deacon <will@kernel.org>, "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>, linux-media@vger.kernel.org
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

CgpPbiAwOC4xMi4yMSAxMTo1MCwgRGFmbmEgSGlyc2NoZmVsZCB3cm90ZToKPiAKPiAKPiBPbiAw
Ny4xMi4yMSAxMDozMSwgRGFmbmEgSGlyc2NoZmVsZCB3cm90ZToKPj4KPj4KPj4gT24gMjcuMTEu
MjEgMDQ6NDYsIFlvbmcgV3Ugd3JvdGU6Cj4+PiBIaSBEYWZuYSwKPj4+Cj4+PiBTb3JyeSBmb3Ig
cmVwbHkgbGF0ZS4KPj4+Cj4+PiBPbiBNb24sIDIwMjEtMTEtMjIgYXQgMTI6NDMgKzAyMDAsIERh
Zm5hIEhpcnNjaGZlbGQgd3JvdGU6Cj4+Pj4gRnJvbTogWW9uZyBXdSA8eW9uZy53dUBtZWRpYXRl
ay5jb20+Cj4+Pj4KPj4+PiBQcmVwYXJlIGZvciAyIEhXcyB0aGF0IHNoYXJpbmcgcGd0YWJsZSBp
biBkaWZmZXJlbnQgcG93ZXItZG9tYWlucy4KPj4+Pgo+Pj4+IFdoZW4gdGhlcmUgYXJlIDIgTTRV
IEhXcywgaXQgbWF5IGhhcyBwcm9ibGVtIGluIHRoZSBmbHVzaF9yYW5nZSBpbgo+Pj4+IHdoaWNo
Cj4+Pj4gd2UgZ2V0IHRoZSBwbV9zdGF0dXMgdmlhIHRoZSBtNHUgZGV2LCBCVVQgdGhhdCBmdW5j
dGlvbiBkb24ndCByZWZsZWN0Cj4+Pj4gdGhlCj4+Pj4gcmVhbCBwb3dlci1kb21haW4gc3RhdHVz
IG9mIHRoZSBIVyBzaW5jZSB0aGVyZSBtYXkgYmUgb3RoZXIgSFcgYWxzbwo+Pj4+IHVzZQo+Pj4+
IHRoYXQgcG93ZXItZG9tYWluLgo+Pj4+Cj4+Pj4gVGhlIGZ1bmN0aW9uIGRtYV9hbGxvY19hdHRy
cyBoZWxwIGFsbG9jYXRlIHRoZSBpb21tdSBidWZmZXIgd2hpY2gKPj4+PiBuZWVkIHRoZSBjb3Jy
ZXNwb25kaW5nIHBvd2VyIGRvbWFpbiBzaW5jZSB0bGIgZmx1c2ggaXMgbmVlZGVkIHdoZW4KPj4+
PiBwcmVwYXJpbmcgaW92YS4gQlVUIHRoaXMgZnVuY3Rpb24gb25seSBpcyBmb3IgYWxsb2NhdGlu
ZyBidWZmZXIsCj4+Pj4gd2UgaGF2ZSBubyBnb29kIHJlYXNvbiB0byByZXF1ZXN0IHRoZSB1c2Vy
IGFsd2F5cyBjYWxsIHBtX3J1bnRpbWVfZ2V0Cj4+Pj4gYmVmb3JlIGNhbGxpbmcgZG1hX2FsbG9j
X3h4eC4gVGhlcmVmb3JlLCB3ZSBhZGQgYSB0bGJfZmx1c2hfYWxsCj4+Pj4gaW4gdGhlIHBtX3J1
bnRpbWVfcmVzdW1lIHRvIG1ha2Ugc3VyZSB0aGUgdGxiIGFsd2F5cyBpcyBjbGVhbi4KPj4+Pgo+
Pj4+IEFub3RoZXIgc29sdXRpb24gaXMgYWx3YXlzIGNhbGwgcG1fcnVudGltZV9nZXQgaW4gdGhl
Cj4+Pj4gdGxiX2ZsdXNoX3JhbmdlLgo+Pj4+IFRoaXMgd2lsbCB0cmlnZ2VyIHBtIHJ1bnRpbWUg
cmVzdW1lL2JhY2t1cCBzbyBvZnRlbiB3aGVuIHRoZSBpb21tdQo+Pj4+IHBvd2VyIGlzIG5vdCBh
Y3RpdmUgYXQgc29tZSB0aW1lKG1lYW5zIHVzZXIgZG9uJ3QgY2FsbCBwbV9ydW50aW1lX2dldAo+
Pj4+IGJlZm9yZSBjYWxsaW5nIGRtYV9hbGxvY194eHgpLCBUaGlzIG1heSBjYXVzZSB0aGUgcGVy
Zm9ybWFuY2UgZHJvcC4KPj4+PiB0aHVzIHdlIGRvbid0IHVzZSB0aGlzLgo+Pj4+Cj4+Pj4gSW4g
b3RoZXIgY2FzZSwgdGhlIGlvbW11J3MgcG93ZXIgc2hvdWxkIGFsd2F5cyBiZSBhY3RpdmUgdmlh
IGRldmljZQo+Pj4+IGxpbmsgd2l0aCBzbWkuCj4+Pj4KPj4+PiBUaGUgcHJldmlvdXMgU29DIGRv
bid0IGhhdmUgUE0gZXhjZXB0IG10ODE5Mi4gdGhlIG10ODE5MiBJT01NVSBpcwo+Pj4+IGRpc3Bs
YXkncwo+Pj4+IHBvd2VyLWRvbWFpbiB3aGljaCBuZWFybHkgYWx3YXlzIGlzIGVuYWJsZWQuIHRo
dXMgbm8gbmVlZCBmaXggdGFncwo+Pj4+IGhlcmUuCj4+Pj4gUHJlcGFyZSBmb3IgbXQ4MTk1Lgo+
Pj4KPj4+IEluIHRoaXMgcGF0Y2hzZXQsIHRoaXMgbWVzc2FnZSBzaG91bGQgYmUgbm90IHByb3Bl
ci4gSSB0aGluayB5b3UgY291bGQKPj4+IGFkZCB0aGUgY29tbWVudCB3aHkgdGhpcyBwYXRjaCBp
cyBuZWVkZWQgaW4gbXQ4MTczLgo+Pj4KPj4+Pgo+Pj4+IFNpZ25lZC1vZmYtYnk6IFlvbmcgV3Ug
PHlvbmcud3VAbWVkaWF0ZWsuY29tPgo+Pj4+IFtpbXBvcnZpZSBpbmxpbmUgZG9jXQo+Pj4+IFNp
Z25lZC1vZmYtYnk6IERhZm5hIEhpcnNjaGZlbGQgPGRhZm5hLmhpcnNjaGZlbGRAY29sbGFib3Jh
LmNvbT4KPj4+PiAtLS0KPj4+PiDCoCBkcml2ZXJzL2lvbW11L210a19pb21tdS5jIHwgNyArKysr
KysrCj4+Pj4gwqAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQo+Pj4+Cj4+Pj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMgYi9kcml2ZXJzL2lvbW11L210a19p
b21tdS5jCj4+Pj4gaW5kZXggMjViODM0MTA0NzkwLi4yOGRjNGI5NWI2ZDkgMTAwNjQ0Cj4+Pj4g
LS0tIGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYwo+Pj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUv
bXRrX2lvbW11LmMKPj4+PiBAQCAtOTY0LDYgKzk2NCwxMyBAQCBzdGF0aWMgaW50IF9fbWF5YmVf
dW51c2VkCj4+Pj4gbXRrX2lvbW11X3J1bnRpbWVfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikK
Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHJldDsKPj4+PiDCoMKgwqDCoMKgIH0KPj4+
PiArwqDCoMKgIC8qCj4+Pj4gK8KgwqDCoMKgICogVXNlcnMgbWF5IGFsbG9jYXRlIGRtYSBidWZm
ZXIgYmVmb3JlIHRoZXkgY2FsbAo+Pj4+IHBtX3J1bnRpbWVfZ2V0LAo+Pj4+ICvCoMKgwqDCoCAq
IGluIHdoaWNoIGNhc2UgaXQgd2lsbCBsYWNrIHRoZSBuZWNlc3NhcnkgdGxiIGZsdXNoLgo+Pj4+
ICvCoMKgwqDCoCAqIFRodXMsIG1ha2Ugc3VyZSB0byB1cGRhdGUgdGhlIHRsYiBhZnRlciBlYWNo
IFBNIHJlc3VtZS4KPj4+PiArwqDCoMKgwqAgKi8KPj4+PiArwqDCoMKgIG10a19pb21tdV90bGJf
Zmx1c2hfYWxsKGRhdGEpOwo+Pj4KPj4+IFRoaXMgc2hvdWxkIG5vdCB3b3JrLiBzaW5jZSBjdXJy
ZW50IHRoZSAqX3RsYl9mbHVzaF9hbGwgY2FsbAo+Pj4gcG1fcnVudGltZV9nZXRfaWZfaW5fdXNl
IHdoaWNoIHdpbGwgYWx3YXlzIHJldHVybiAwIHdoZW4gaXQgY2FsbGVkIGZyb20KPj4+IHRoaXMg
cnVudGltZV9jYiBpbiBteSB0ZXN0LiB0aHVzLCBJdCB3b24ndCBkbyB0aGUgdGxiX2ZsdXNoX2Fs
bAo+Pj4gYWN0dWFsbHkuCj4gCj4gSGUsIGluZGVlZCwgbXkgbWlzdGFrZSwgYWx0aG91Z2ggdGhl
IGVuY29kZXIgd29ya3MgbW9yZSBvciBsZXNzIGZpbmUgZXZlbgo+IHdpdGhvdXQgdGhlIGZ1bGwg
Zmx1c2ggc28gSSBkaWRuJ3QgY2F0Y2ggdGhhdC4KPiAKPj4+Cj4+PiBJIGd1ZXNzIHRoaXMgYWxz
byBkZXBlbmQgb24gdGhlc2UgdHdvIHBhdGNoZXMgb2YgbXQ4MTk1IHYzLgo+Pj4gW1BBVENIIHYz
IDA5LzMzXSBpb21tdS9tZWRpYXRlazogUmVtb3ZlIGZvcl9lYWNoX200dSBpbiB0bGJfc3luY19h
bGwKPj4+IFtQQVRDSCB2MyAxMC8zM10gaW9tbXUvbWVkaWF0ZWs6IEFkZCB0bGJfbG9jayBpbiB0
bGJfZmx1c2hfYWxsCj4gCj4gSSdsbCBhZGQgdGhvc2UgdHdvCj4gCj4+Pgo+Pj4gbGlrZSBpbiBb
MTAvMzNdLCBJIGFkZGVkIGEgbXRrX2lvbW11X3RsYl9kb19mbHVzaF9hbGwgd2hpY2ggZG9uJ3Qg
aGF2ZQo+Pj4gdGhlIHBtIG9wZXJhdGlvbi4KPiAKPiB5ZXMsIEkgbmVlZCB0byByZW1vdmUgdGhl
IHBtX3J1bnRpbWVfZ2V0X2lmX2luX3VzZSBjYWxsIGluIHRoZSAnZmx1c2hfYWxsJyBmdW5jCj4g
SSBzZWUgdGhlcmUgaXMgYWxzbyBhIHBhdGNoIGZvciB0aGF0IGluIHRoZSBtdDgxOTUgdjMgc2Vy
aWVzICJbUEFUQ0ggdjMgMTMvMzNdIGlvbW11L21lZGlhdGVrOiBSZW1vdmUgdGhlIHBvd2VyIHN0
YXR1cyBjaGVja2luZyBpbiB0bGIgZmx1c2ggYWxsIgo+IAo+IFNvIEknbGwgc2VuZCB2MiwgYWRk
aW5nIGFsbCB0aG9zZSAzIHBhdGNoZXMsIGJ1dCBJIHRoaW5rIGFkZGluZyBtdGtfaW9tbXVfdGxi
X2RvX2ZsdXNoX2FsbAo+IG9uIHBhdGNoIDkgYW5kIHJlbW92aW5nIGl0IGFnYWluIG9uIHBhdGNo
IDEzIGlzIGNvbmZ1c2luZyBzbyBJJ2xsIGF2b2lkIHRoYXQuCj4gCgpJbiBhZGRpdGlvbiwgdGhl
IGNhbGwgdG8gbXRrX2lvbW11X3RsYl9mbHVzaF9hbGwgZnJvbSBtdGtfaW9tbXVfcnVudGltZV9y
ZXN1bWUgc2hvdWxkIG1vdmUgdG8gdGhlIGJvdHRvbSBvZiB0aGUgZnVuY3Rpb24KYWZ0ZXIgYWxs
IHZhbHVlcyBhcmUgdXBkYXRlZAoKPiBUaGFua3MsCj4gRGFmbmEKPiAKPiAKPiAKPj4+Cj4+PiBU
aGlzIGxvb2tzIGhhcyBhIGRlcGVuZGVuY2UuIExldCBtZSBrbm93IGlmIEkgY2FuIGhlbHAgdGhp
cy4KPj4KPj4gSXQgZGlkIHdvcmsgZm9yIG1lLCB0ZXN0aW5nIG9uIGVsbSBkZXZpY2UuIEknbGwg
Y2hlY2sgdGhhdCBhZ2Fpbi4KPj4KPj4KPj4+Cj4+Pj4gKwo+Pj4+IMKgwqDCoMKgwqAgLyoKPj4+
PiDCoMKgwqDCoMKgwqAgKiBVcHBvbiBmaXJzdCByZXN1bWUsIG9ubHkgZW5hYmxlIHRoZSBjbGsg
YW5kIHJldHVybiwgc2luY2UKPj4+PiB0aGUgdmFsdWVzIG9mIHRoZQo+Pj4+IMKgwqDCoMKgwqDC
oCAqIHJlZ2lzdGVycyBhcmUgbm90IHlldCBzZXQuCj4+Cl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby9pb21tdQ==
