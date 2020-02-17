Return-Path: <SRS0=vxCL=4F=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67EAAC761A6
	for <iommu@archiver.kernel.org>; Mon, 17 Feb 2020 13:08:27 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40249206E2
	for <iommu@archiver.kernel.org>; Mon, 17 Feb 2020 13:08:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40249206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2250F20437;
	Mon, 17 Feb 2020 13:08:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m1bT3AfXCQ4p; Mon, 17 Feb 2020 13:08:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 50C55203D1;
	Mon, 17 Feb 2020 13:08:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4BCFDC08A0;
	Mon, 17 Feb 2020 13:08:25 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 79264C013E
 for <iommu@lists.linux-foundation.org>; Mon, 17 Feb 2020 13:08:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 720BB872E8
 for <iommu@lists.linux-foundation.org>; Mon, 17 Feb 2020 13:08:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2gXci7UMSR5I for <iommu@lists.linux-foundation.org>;
 Mon, 17 Feb 2020 13:08:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id D074F85B3C
 for <iommu@lists.linux-foundation.org>; Mon, 17 Feb 2020 13:08:21 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B31630E;
 Mon, 17 Feb 2020 05:08:21 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C96F83F703;
 Mon, 17 Feb 2020 05:08:20 -0800 (PST)
Subject: Re: arm-smmu.1.auto: Unhandled context fault starting with 5.4-rc1
To: Jerry Snitselaar <jsnitsel@redhat.com>
References: <20200214201353.qlbqcvpztcx55qud@cantor>
 <7c9a234e-78b1-2385-84b8-50744b9c4066@arm.com>
 <20200216221110.zie3o5opbvarir3h@cantor>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <efb6da9c-51a3-c35c-1bbf-ae6808006beb@arm.com>
Date: Mon, 17 Feb 2020 13:08:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200216221110.zie3o5opbvarir3h@cantor>
Content-Language: en-GB
Cc: iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>
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

T24gMTYvMDIvMjAyMCAxMDoxMSBwbSwgSmVycnkgU25pdHNlbGFhciB3cm90ZToKPiBPbiBGcmkg
RmViIDE0IDIwLCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4+IEhpIEplcnJ5LAo+Pgo+PiBPbiAyMDIw
LTAyLTE0IDg6MTMgcG0sIEplcnJ5IFNuaXRzZWxhYXIgd3JvdGU6Cj4+PiBIaSBXaWxsLAo+Pj4K
Pj4+IE9uIGEgZ2lnYWJ5dGUgc3lzdGVtIHdpdGggQ2F2aXVtIENOOHh4LCB3aGVuIGRvaW5nIGEg
ZmlvIHRlc3QgYWdhaW5zdAo+Pj4gYW4gbnZtZSBkcml2ZSB3ZSBhcmUgc2VlaW5nIHRoZSBmb2xs
b3dpbmc6Cj4+Pgo+Pj4gW8KgIDYzNy4xNjExOTRdIGFybS1zbW11IGFybS1zbW11LjEuYXV0bzog
VW5oYW5kbGVkIGNvbnRleHQgZmF1bHQ6IAo+Pj4gZnNyPTB4ODAwMDA0MDIsIGlvdmE9MHg4MDEw
MDAzZjYwMDAsIGZzeW5yPTB4NzAwOTEsIGNiZnJzeW5yYT0weDkwMDAsIAo+Pj4gY2I9Nwo+Pj4g
W8KgIDYzNy4xNzQzMjldIGFybS1zbW11IGFybS1zbW11LjEuYXV0bzogVW5oYW5kbGVkIGNvbnRl
eHQgZmF1bHQ6IAo+Pj4gZnNyPTB4ODAwMDA0MDIsIGlvdmE9MHg4MDEwMDAwMzYwMDAsIGZzeW5y
PTB4NzAwOTEsIGNiZnJzeW5yYT0weDkwMDAsIAo+Pj4gY2I9Nwo+Pj4gW8KgIDYzNy4xODY4ODdd
IGFybS1zbW11IGFybS1zbW11LjEuYXV0bzogVW5oYW5kbGVkIGNvbnRleHQgZmF1bHQ6IAo+Pj4g
ZnNyPTB4ODAwMDA0MDIsIGlvdmE9MHg4MDEwMDAyZWUwMDAsIGZzeW5yPTB4NzAwOTEsIGNiZnJz
eW5yYT0weDkwMDAsIAo+Pj4gY2I9Nwo+Pj4gW8KgIDYzNy4xOTkyNzVdIGFybS1zbW11IGFybS1z
bW11LjEuYXV0bzogVW5oYW5kbGVkIGNvbnRleHQgZmF1bHQ6IAo+Pj4gZnNyPTB4ODAwMDA0MDIs
IGlvdmE9MHg4MDEwMDAzYzcwMDAsIGZzeW5yPTB4NzAwOTEsIGNiZnJzeW5yYT0weDkwMDAsIAo+
Pj4gY2I9Nwo+Pj4gW8KgIDYzNy4yMTE4ODVdIGFybS1zbW11IGFybS1zbW11LjEuYXV0bzogVW5o
YW5kbGVkIGNvbnRleHQgZmF1bHQ6IAo+Pj4gZnNyPTB4ODAwMDA0MDIsIGlvdmE9MHg4MDEwMDAz
OTIwMDAsIGZzeW5yPTB4NzAwOTEsIGNiZnJzeW5yYT0weDkwMDAsIAo+Pj4gY2I9Nwo+Pj4gW8Kg
IDYzNy4yMjQ1ODBdIGFybS1zbW11IGFybS1zbW11LjEuYXV0bzogVW5oYW5kbGVkIGNvbnRleHQg
ZmF1bHQ6IAo+Pj4gZnNyPTB4ODAwMDA0MDIsIGlvdmE9MHg4MDEwMDAwMTgwMDAsIGZzeW5yPTB4
NzAwOTEsIGNiZnJzeW5yYT0weDkwMDAsIAo+Pj4gY2I9Nwo+Pj4gW8KgIDYzNy4yMzcyNDFdIGFy
bS1zbW11IGFybS1zbW11LjEuYXV0bzogVW5oYW5kbGVkIGNvbnRleHQgZmF1bHQ6IAo+Pj4gZnNy
PTB4ODAwMDA0MDIsIGlvdmE9MHg4MDEwMDAzNjAwMDAsIGZzeW5yPTB4NzAwOTEsIGNiZnJzeW5y
YT0weDkwMDAsIAo+Pj4gY2I9Nwo+Pj4gW8KgIDYzNy4yNDk2NTddIGFybS1zbW11IGFybS1zbW11
LjEuYXV0bzogVW5oYW5kbGVkIGNvbnRleHQgZmF1bHQ6IAo+Pj4gZnNyPTB4ODAwMDA0MDIsIGlv
dmE9MHg4MDEwMDAwYmEwMDAsIGZzeW5yPTB4NzAwOTEsIGNiZnJzeW5yYT0weDkwMDAsIAo+Pj4g
Y2I9Nwo+Pj4gW8KgIDYzNy4yNjIxMjBdIGFybS1zbW11IGFybS1zbW11LjEuYXV0bzogVW5oYW5k
bGVkIGNvbnRleHQgZmF1bHQ6IAo+Pj4gZnNyPTB4ODAwMDA0MDIsIGlvdmE9MHg4MDEwMDAwM2Uw
MDAsIGZzeW5yPTB4NzAwOTEsIGNiZnJzeW5yYT0weDkwMDAsIAo+Pj4gY2I9Nwo+Pj4gW8KgIDYz
Ny4yNzQ0NjhdIGFybS1zbW11IGFybS1zbW11LjEuYXV0bzogVW5oYW5kbGVkIGNvbnRleHQgZmF1
bHQ6IAo+Pj4gZnNyPTB4ODAwMDA0MDIsIGlvdmE9MHg4MDEwMDAzMDQwMDAsIGZzeW5yPTB4NzAw
OTEsIGNiZnJzeW5yYT0weDkwMDAsIAo+Pj4gY2I9Nwo+Pgo+PiBUaG9zZSAiSU9WQXMiIGRvbid0
IGxvb2sgbXVjaCBsaWtlIElPVkFzIGZyb20gdGhlIERNQSBhbGxvY2F0b3IgLSBpZiAKPj4gdGhl
eSB3ZXJlIHBoeXNpY2FsIGFkZHJlc3Nlcywgd291bGQgdGhleSBjb3JyZXNwb25kIHRvIGFuIGV4
cGVjdGVkIAo+PiByZWdpb24gb2YgdGhlIHBoeXNpY2FsIG1lbW9yeSBtYXA/Cj4+Cj4+IEkgd291
bGQgc3VzcGVjdCB0aGF0IHRoaXMgaXMgbW9zdCBsaWtlbHkgbWlzYmVoYXZpb3VyIGluIHRoZSBO
Vk1lIAo+PiBkcml2ZXIgKGlzc3VpbmcgYSB3cml0ZSB0byBhIG5vbi1ETUEtbWFwcGVkIGFkZHJl
c3MpLCBhbmQgdGhlIFNNTVUgaXMgCj4+IGp1c3QgZG9pbmcgaXRzIGpvYiBpbiBibG9ja2luZyBh
bmQgcmVwb3J0aW5nIGl0Lgo+Pgo+Pj4gSSBhbHNvIHJlcHJvZHVjZWQgd2l0aCA1LjUtcmM3LCBh
bmQgd2lsbCBjaGVjayA1LjYtcmMxIGxhdGVyIHRvZGF5LiBJIAo+Pj4gY291bGRuJ3QgbmFycm93
IGl0IGRvd24gZnVydGhlciBpbnRvIDUuNC1yYzEuCj4+PiBJIGRvbid0IGtub3cgc21tdSBvciB0
aGUgY29kZSB3ZWxsLCBhbnkgdGhvdWdodHMgb24gd2hlcmUgdG8gc3RhcnQgCj4+PiBkaWdnaW5n
IGludG8gdGhpcz8KPj4+Cj4+PiBmaW8gdGVzdCB0aGF0IGlzIGJlaW5nIHJ1biBpczoKPj4+Cj4+
PiAjZmlvIC1maWxlbmFtZT0vZGV2L252bWUwbjEgLWlvZGVwdGg9NjQgLXRocmVhZCAtcnc9cmFu
ZHdyaXRlIAo+Pj4gLWlvZW5naW5lPWxpYmFpbyAtYnM9NGsgLXJ1bnRpbWU9NDMyMDAgLXNpemU9
LWdyb3VwX3JlcG9ydGluZyAKPj4+IC1uYW1lPW15dGVzdCAtbnVtam9icz0zMgo+Pgo+PiBKdXN0
IHRvIGNsYXJpZnksIGRvIG90aGVyIHRlc3RzIHdvcmsgT0sgb24gdGhlIHNhbWUgZGV2aWNlPwo+
Pgo+PiBUaGFua3MsCj4+IFJvYmluLgo+Pgo+IAo+IEkgd2FzIGFibGUgdG8gZ2V0IGJhY2sgb24g
dGhlIHN5c3RlbSB0b2RheS4gSSB0aGluayBJIGtub3cgd2hhdCB0aGUgCj4gcHJvYmxlbSBpczoK
PiAKPiBbwqDCoMKgIDAuMDM2MTg5XSBpb21tdTogR2lnYWJ5dGUgUjEyMC1UMzQtMDAgZGV0ZWN0
ZWQsIGZvcmNlIGlvbW11IAo+IHBhc3N0aHJvdWdoIG1vZGUKPiBbwqDCoMKgIDYuMzI0MjgyXSBp
b21tdTogRGVmYXVsdCBkb21haW4gdHlwZTogVHJhbnNsYXRlZAo+IAo+IFNvIHRoZSBuZXcgZGVm
YXVsdCBkb21haW4gY29kZSBpbiA1LjQgb3ZlcnJpZGVzIHRoZSBpb21tdSBxdWlyayBjb2RlIAo+
IHNldHRpbmcgZGVmYXVsdAo+IHBhc3N0aHJvdWdoLiBUZXN0aW5nIGEgcXVpY2sgcGF0Y2ggdGhh
dCB0cmFja3Mgd2hldGhlciB0aGUgZGVmYXVsdCAKPiBkb21haW4gd2FzIHNldAo+IGluIHRoZSBx
dWlyayBjb2RlLCBhbmQgbGVhdmVzIGl0IGFsb25lIGlmIGl0IHdhcy4gU28gZmFyIGl0IHNlZW1z
IHRvIGJlIAo+IHdvcmtpbmcuCgpBaCwgT0suIENvdWxkIHlvdSBwb2ludCBtZSBhdCB0aGF0IHF1
aXJrIGNvZGU/IEkgY2FuJ3Qgc2VlbSB0byB0cmFjayBpdCAKZG93biBpbiBtYWlubGluZSwgYW5k
IHNlZWluZyB0aGlzIG11Y2ggbGVhdmVzIG1lIGR1YmlvdXMgdGhhdCBpdCdzIGV2ZW4gCmNvcnJl
Y3QgLSBtYXRjaGluZyBhIHBhcnRpY3VsYXIgYm9hcmQgaW1wbGllcyB0aGF0IGl0J3MgYSBmaXJt
d2FyZSBpc3N1ZSAKKGFzIGZhciBhcyBJJ20gYXdhcmUgdGhlIFNNTVVzIGluIENOODh4eCBTb0Nz
IGFyZSB1c2FibGUgaW4gZ2VuZXJhbCksIApidXQgaWYgdGhlIGZpcm13YXJlIGRlc2NyaXB0aW9u
IGlzIHdyb25nIHRvIHRoZSBwb2ludCB0aGF0IERNQSBvcHMgCnRyYW5zbGF0aW9uIGRvZXNuJ3Qg
d29yaywgdGhlbiBubyBvdGhlciB0cmFuc2xhdGlvbiAoZS5nLiBWRklPKSBpcyAKbGlrZWx5IHRv
IHdvcmsgZWl0aGVyLiBJbiB0aGF0IGNhc2UgaXQncyBzaW1wbHkgbm90IHNhZmUgdG8gZW5hYmxl
IHRoZSAKU01NVSBhdCBhbGwsIGFuZCBmdWRnaW5nIHRoZSBkZWZhdWx0IGRvbWFpbiB0eXBlIG1l
cmVseSBoaWRlcyBvbmUgCnN5bXB0b20gb2YgdGhlIHByb2JsZW0uCgpSb2Jpbi4KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0
CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
