Return-Path: <SRS0=nNEG=IB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A791C433DB
	for <iommu@archiver.kernel.org>; Wed,  3 Mar 2021 15:43:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A639464EDB
	for <iommu@archiver.kernel.org>; Wed,  3 Mar 2021 15:43:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A639464EDB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4B52247121;
	Wed,  3 Mar 2021 15:43:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ckedZ5l_U-QW; Wed,  3 Mar 2021 15:43:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id E2B364711B;
	Wed,  3 Mar 2021 15:43:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB00DC000A;
	Wed,  3 Mar 2021 15:43:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 761DEC0001
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 14:57:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 954874AE76
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 14:57:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B1dX_K_w41K1 for <iommu@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 14:57:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [85.220.165.71])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2E3674AC6E
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 14:57:07 +0000 (UTC)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <sha@pengutronix.de>)
 id 1lHSvq-00062H-C8; Wed, 03 Mar 2021 15:56:58 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
 (envelope-from <sha@pengutronix.de>)
 id 1lHSvo-0000GX-Gc; Wed, 03 Mar 2021 15:56:56 +0100
Date: Wed, 3 Mar 2021 15:56:56 +0100
From: Sascha Hauer <sha@pengutronix.de>
To: Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>
Subject: Re: CAAM: kernel BUG at drivers/crypto/caam/jr.c:230! (and
 dma-coherent query)
Message-ID: <20210303145656.GL5549@pengutronix.de>
References: <20210301152231.GC5549@pengutronix.de>
 <a52e0a0f-a784-2430-4b37-fb9fdcf3692b@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a52e0a0f-a784-2430-4b37-fb9fdcf3692b@nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-IRC: #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 15:38:04 up 13 days, 18:01, 77 users,  load average: 0.09, 0.12, 0.14
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: iommu@lists.linux-foundation.org
X-Mailman-Approved-At: Wed, 03 Mar 2021 15:43:09 +0000
Cc: Aymen Sghaier <aymen.sghaier@nxp.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Greg Ungerer <gerg@linux-m68k.org>, Russell King <rmk+kernel@armlinux.org.uk>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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

T24gV2VkLCBNYXIgMDMsIDIwMjEgYXQgMTI6MjY6MzJQTSArMDIwMCwgSG9yaWEgR2VhbnTEgyB3
cm90ZToKPiBBZGRpbmcgc29tZSBwZW9wbGUgaW4gdGhlIGxvb3AsIG1heWJlIHRoZXkgY291bGQg
aGVscCBpbiB1bmRlcnN0YW5kaW5nCj4gd2h5IGxhY2sgb2YgImRtYS1jb2hlcmVudCIgcHJvcGVy
dHkgZm9yIGEgSFctY29oZXJlbnQgZGV2aWNlIGNvdWxkIGxlYWQgdG8KPiB1bmV4cGVjdGVkIC8g
c3RyYW5nZSBzaWRlIGVmZmVjdHMuCj4gCj4gT24gMy8xLzIwMjEgNToyMiBQTSwgU2FzY2hhIEhh
dWVyIHdyb3RlOgo+ID4gSGkgQWxsLAo+ID4gCj4gPiBJIGFtIG9uIGEgTGF5ZXJzY2FwZSBMUzEw
NDZhIHVzaW5nIExpbnV4LTUuMTEuIFRoZSBDQUFNIGRyaXZlciBzb21ldGltZXMKPiA+IGNyYXNo
ZXMgZHVyaW5nIHRoZSBydW4tdGltZSBzZWxmIHRlc3RzIHdpdGg6Cj4gPiAKPiA+PiBrZXJuZWwg
QlVHIGF0IGRyaXZlcnMvY3J5cHRvL2NhYW0vanIuYzoyNDchCj4gPj4gSW50ZXJuYWwgZXJyb3I6
IE9vcHMgLSBCVUc6IDAgWyMxXSBQUkVFTVBUIFNNUAo+ID4+IE1vZHVsZXMgbGlua2VkIGluOgo+
ID4+IENQVTogMCBQSUQ6IDAgQ29tbTogc3dhcHBlci8wIE5vdCB0YWludGVkIDUuMTEuMC0yMDIx
MDIyNS0zLTAwMDM5LWc0MzQyMTU5Njg4MTYtZGlydHkgIzEyCj4gPj4gSGFyZHdhcmUgbmFtZTog
VFEgVFFNTFMxMDQ2QSBTb00gb24gQXJrb25hIEFUMTEzMCAoQzMwMCkgYm9hcmQgKERUKQo+ID4+
IHBzdGF0ZTogNjAwMDAwMDUgKG5aQ3YgZGFpZiAtUEFOIC1VQU8gLVRDTyBCVFlQRT0tLSkKPiA+
PiBwYyA6IGNhYW1fanJfZGVxdWV1ZSsweDk4LzB4NTdjCj4gPj4gbHIgOiBjYWFtX2pyX2RlcXVl
dWUrMHg5OC8weDU3Ywo+ID4+IHNwIDogZmZmZjgwMDAxMDAwM2Q1MAo+ID4+IHgyOTogZmZmZjgw
MDAxMDAwM2Q1MCB4Mjg6IGZmZmY4MDAwMTE4ZDQwMDAKPiA+PiB4Mjc6IGZmZmY4MDAwMTE4ZDQz
MjggeDI2OiAwMDAwMDAwMDAwMDAwMWYwCj4gPj4geDI1OiBmZmZmMDAwODAyMmJlNDgwIHgyNDog
ZmZmZjAwMDgwMjJjNjQxMAo+ID4+IHgyMzogMDAwMDAwMDAwMDAwMDFmMSB4MjI6IGZmZmY4MDAw
MTE4ZDQzMjkKPiA+PiB4MjE6IDAwMDAwMDAwMDAwMDRkODAgeDIwOiAwMDAwMDAwMDAwMDAwMWYx
Cj4gPj4geDE5OiAwMDAwMDAwMDAwMDAwMDAxIHgxODogMDAwMDAwMDAwMDAwMDAyMAo+ID4+IHgx
NzogMDAwMDAwMDAwMDAwMDAwMCB4MTY6IDAwMDAwMDAwMDAwMDAwMTUKPiA+PiB4MTU6IGZmZmY4
MDAwMTE2OTAyMzAgeDE0OiAyZTJlMmUyZTJlMmUyZTJlCj4gPj4geDEzOiAyZTJlMmUyZTJlMmUy
MDIwIHgxMjogMzAzMDMwMzAzMDMwMzAzMAo+ID4+IHgxMTogZmZmZjgwMDAxMTcwMGEzOCB4MTA6
IDAwMDAwMDAwZmZmZmYwMDAKPiA+PiB4OSA6IGZmZmY4MDAwMTAwYWRhMzAgeDggOiBmZmZmODAw
MDExNmE4YTM4Cj4gPj4geDcgOiAwMDAwMDAwMDAwMDAwMDAxIHg2IDogMDAwMDAwMDAwMDAwMDAw
MAo+ID4+IHg1IDogMDAwMDAwMDAwMDAwMDAwMCB4NCA6IDAwMDAwMDAwMDAwMDAwMDAKPiA+PiB4
MyA6IDAwMDAwMDAwZmZmZmZmZmYgeDIgOiAwMDAwMDAwMDAwMDAwMDAwCj4gPj4geDEgOiAwMDAw
MDAwMDAwMDAwMDAwIHgwIDogMDAwMDAwMDAwMDAwMTgwMAo+ID4+IENhbGwgdHJhY2U6Cj4gPj4g
IGNhYW1fanJfZGVxdWV1ZSsweDk4LzB4NTdjCj4gPj4gIHRhc2tsZXRfYWN0aW9uX2NvbW1vbi5j
b25zdHByb3AuMCsweDE2NC8weDE4Ywo+ID4+ICB0YXNrbGV0X2FjdGlvbisweDQ0LzB4NTQKPiA+
PiAgX19kb19zb2Z0aXJxKzB4MTYwLzB4NDU0Cj4gPj4gIF9faXJxX2V4aXRfcmN1KzB4MTY0LzB4
MTZjCj4gPj4gIGlycV9leGl0KzB4MWMvMHgzMAo+ID4+ICBfX2hhbmRsZV9kb21haW5faXJxKzB4
YzAvMHgxM2MKPiA+PiAgZ2ljX2hhbmRsZV9pcnErMHg1Yy8weGYwCj4gPj4gIGVsMV9pcnErMHhi
NC8weDE4MAo+ID4+ICBhcmNoX2NwdV9pZGxlKzB4MTgvMHgzMAo+ID4+ICBkZWZhdWx0X2lkbGVf
Y2FsbCsweDNjLzB4MWMwCj4gPj4gIGRvX2lkbGUrMHgyM2MvMHgyNzQKPiA+PiAgY3B1X3N0YXJ0
dXBfZW50cnkrMHgzNC8weDcwCj4gPj4gIHJlc3RfaW5pdCsweGRjLzB4ZWMKPiA+PiAgYXJjaF9j
YWxsX3Jlc3RfaW5pdCsweDFjLzB4MjgKPiA+PiAgc3RhcnRfa2VybmVsKzB4NGFjLzB4NGU0Cj4g
Pj4gQ29kZTogOTEzOTIwMjEgOTEyYzIwMDAgZDM3N2Q4YzYgOTdmMjRkOTYgKGQ0MjEwMDAwKQo+
ID4gCj4gPiBUaGUgZHJpdmVyIGl0ZXJhdGVzIG92ZXIgdGhlIGRlc2NyaXB0b3JzIGluIHRoZSBv
dXRwdXQgcmluZyBhbmQgbWF0Y2hlcyB0aGVtCj4gPiB3aXRoIHRoZSBvbmVzIGl0IGhhcyBwcmV2
aW91c2x5IHF1ZXVlZC4gSWYgaXQgZG9lc24ndCBmaW5kIGEgbWF0Y2hpbmcKPiA+IGRlc2NyaXB0
b3IgaXQgY29tcGxhaW5zIHdpdGggdGhlIEJVR19PTigpIHNlZW4gYWJvdmUuIFdoYXQgSSBzZWUg
c29tZXRpbWVzIGlzCj4gPiB0aGF0IHRoZSBhZGRyZXNzIGluIHRoZSBvdXRwdXQgcmluZyBpcyAw
eDAsIHRoZSBqb2Igc3RhdHVzIGluIHRoaXMgY2FzZSBpcwo+ID4gMHg0MDAwMDAwNiAobWVhbmlu
ZyBERUNPIEludmFsaWQgS0VZIGNvbW1hbmQpLiBJdCBzZWVtcyB0aGF0IHRoZSBDQUFNIGRvZXNu
J3QKPiA+IHdyaXRlIHRoZSBkZXNjcmlwdG9yIGFkZHJlc3MgdG8gdGhlIG91dHB1dCByaW5nIGF0
IGxlYXN0IGluIHNvbWUgZXJyb3IgY2FzZXMuCj4gPiBXaGVuIHdlIGRvbid0IGhhdmUgdGhlIGRl
c2NyaXB0b3IgYWRkcmVzcyBvZiB0aGUgZmFpbGVkIGRlc2NyaXB0b3Igd2UgaGF2ZSBubwo+ID4g
d2F5IHRvIGZpbmQgaXQgaW4gdGhlIGxpc3Qgb2YgcXVldWVkIGRlc2NyaXB0b3JzLCB0aHVzIHdl
IGFsc28gY2FuJ3QgZmluZCB0aGUKPiA+IGNhbGxiYWNrIGZvciB0aGF0IGRlc2NyaXB0b3IuIFRo
aXMgbG9va3MgdmVyeSB1bmZvcnR1bmF0ZSwgYW55b25lIGVsc2Ugc2Vlbgo+ID4gdGhpcyBvciBo
YXMgYW4gaWRlYSB3aGF0IHRvIGRvIGFib3V0IGl0Pwo+ID4gCj4gPiBJIGhhdmVuJ3QgaW52ZXN0
aWdhdGVkIHlldCB3aGljaCBqb2IgYWN0dWFsbHkgZmFpbHMgYW5kIHdoeS4gT2YgY291cnNlIHRo
YXQgd291bGQKPiA+IGJlIG15IHVsdGltYXRlIGdvYWwgdG8gZmluZCB0aGF0IG91dC4KPiA+IAo+
IFRoaXMgbG9va3MgdmVyeSBzaW1pbGFyIHRvIGFuIGVhcmxpZXIgcmVwb3J0IGZyb20gR3JlZy4K
PiBIZSBjb25maXJtZWQgdGhhdCBhZGRpbmcgImRtYS1jb2hlcmVudCIgcHJvcGVydHkgdG8gdGhl
ICJjcnlwdG8iIERUIG5vZGUKPiBmaXhlcyB0aGUgaXNzdWU6Cj4gaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvbGludXgtY3J5cHRvLzc0ZjY2NGY1LTU0MzMtZDMyMi00Nzg5LTNjNzhiZGI4MTRkOEBr
ZXJuZWwub3JnCj4gUGF0Y2ggcmViYXNlZCBvbiB2NS4xMSBpcyBhdCB0aGUgYm90dG9tLiBEb2Vz
IGl0IHdvcmsgZm9yIHlvdSB0b28/CgpJbmRlZWQgdGhpcyBzZWVtcyB0byBzb2x2ZSBpdCBmb3Ig
bWUgYXMgd2VsbCwgeW91IGNhbiBhZGQgbXkKClRlc3RlZC1ieTogU2FzY2hhIEhhdWVyIDxzLmhh
dWVyQHBlbmd1dHJvbml4LmRlPgoKSG93ZXZlciwgdGhlcmUgc2VlbSB0byBiZSB0d28gcHJvYmxl
bXM6IEZpcnN0IHRoYXQgIkRFQ08gSW52YWxpZCBLRVkKY29tbWFuZCIgYWN0dWFsbHkgb2NjdXJz
IGFuZCBzZWNvbmQgdGhhdCB0aGUgZGVxZXVldWUgY29kZSBjdXJyZW50bHkKY2FuJ3QgaGFuZGxl
IGEgTlVMTCBwb2ludGVyIGluIHRoZSBvdXRwdXQgcmluZy4KRG8geW91IHRoaW5rIHRoYXQgdGhl
IG9jY3VyZW5jZSBvZiBhIE5VTEwgcG9pbnRlciBpcyBhbHNvIGEgY29oZXJlbmN5Cmlzc3VlPwoK
U2FzY2hhCgotLSAKUGVuZ3V0cm9uaXggZS5LLiAgICAgICAgICAgICAgICAgICAgICAgICAgIHwg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwKU3RldWVyd2FsZGVyIFN0ci4gMjEgICAgICAg
ICAgICAgICAgICAgICAgIHwgaHR0cDovL3d3dy5wZW5ndXRyb25peC5kZS8gIHwKMzExMzcgSGls
ZGVzaGVpbSwgR2VybWFueSAgICAgICAgICAgICAgICAgIHwgUGhvbmU6ICs0OS01MTIxLTIwNjkx
Ny0wICAgIHwKQW10c2dlcmljaHQgSGlsZGVzaGVpbSwgSFJBIDI2ODYgICAgICAgICAgIHwgRmF4
OiAgICs0OS01MTIxLTIwNjkxNy01NTU1IHwKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2lvbW11
