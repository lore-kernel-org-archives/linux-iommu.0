Return-Path: <SRS0=KoUT=IC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45F1C433DB
	for <iommu@archiver.kernel.org>; Thu,  4 Mar 2021 17:03:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E91764F5E
	for <iommu@archiver.kernel.org>; Thu,  4 Mar 2021 17:03:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E91764F5E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 000504B2D7;
	Thu,  4 Mar 2021 17:03:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O9gT69gMq06J; Thu,  4 Mar 2021 17:03:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 62BDF4EBE9;
	Thu,  4 Mar 2021 17:03:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1BC51C000E;
	Thu,  4 Mar 2021 17:03:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62514C000B
 for <iommu@lists.linux-foundation.org>; Thu,  4 Mar 2021 17:03:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5998A4B2D7
 for <iommu@lists.linux-foundation.org>; Thu,  4 Mar 2021 17:03:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n0NgxI4tVqXI for <iommu@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 17:03:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9438C4EBE9
 for <iommu@lists.linux-foundation.org>; Thu,  4 Mar 2021 17:03:06 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2B9731B;
 Thu,  4 Mar 2021 09:03:05 -0800 (PST)
Received: from [10.57.48.219] (unknown [10.57.48.219])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 775E63F7D7;
 Thu,  4 Mar 2021 09:03:03 -0800 (PST)
Subject: Re: CAAM: kernel BUG at drivers/crypto/caam/jr.c:230! (and
 dma-coherent query)
To: =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>,
 Sascha Hauer <sha@pengutronix.de>
References: <20210301152231.GC5549@pengutronix.de>
 <a52e0a0f-a784-2430-4b37-fb9fdcf3692b@nxp.com>
 <20210303145656.GL5549@pengutronix.de>
 <0103a43a-382d-0d71-a6ea-ead3d7ab7041@nxp.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <fe6faa24-d8f7-d18f-adfa-44fa0caa1598@arm.com>
Date: Thu, 4 Mar 2021 17:02:57 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <0103a43a-382d-0d71-a6ea-ead3d7ab7041@nxp.com>
Content-Language: en-GB
Cc: Aymen Sghaier <aymen.sghaier@nxp.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Greg Ungerer <gerg@linux-m68k.org>, Russell King <rmk+kernel@armlinux.org.uk>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Christoph Hellwig <hch@lst.de>,
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gMjAyMS0wMy0wMyAxNjo0MCwgSG9yaWEgR2VhbnTEgyB3cm90ZToKPiBPbiAzLzMvMjAyMSA0
OjU3IFBNLCBTYXNjaGEgSGF1ZXIgd3JvdGU6Cj4+IE9uIFdlZCwgTWFyIDAzLCAyMDIxIGF0IDEy
OjI2OjMyUE0gKzAyMDAsIEhvcmlhIEdlYW50xIMgd3JvdGU6Cj4+PiBBZGRpbmcgc29tZSBwZW9w
bGUgaW4gdGhlIGxvb3AsIG1heWJlIHRoZXkgY291bGQgaGVscCBpbiB1bmRlcnN0YW5kaW5nCj4+
PiB3aHkgbGFjayBvZiAiZG1hLWNvaGVyZW50IiBwcm9wZXJ0eSBmb3IgYSBIVy1jb2hlcmVudCBk
ZXZpY2UgY291bGQgbGVhZCB0bwo+Pj4gdW5leHBlY3RlZCAvIHN0cmFuZ2Ugc2lkZSBlZmZlY3Rz
Lgo+Pj4KPj4+IE9uIDMvMS8yMDIxIDU6MjIgUE0sIFNhc2NoYSBIYXVlciB3cm90ZToKPj4+PiBI
aSBBbGwsCj4+Pj4KPj4+PiBJIGFtIG9uIGEgTGF5ZXJzY2FwZSBMUzEwNDZhIHVzaW5nIExpbnV4
LTUuMTEuIFRoZSBDQUFNIGRyaXZlciBzb21ldGltZXMKPj4+PiBjcmFzaGVzIGR1cmluZyB0aGUg
cnVuLXRpbWUgc2VsZiB0ZXN0cyB3aXRoOgo+Pj4+Cj4+Pj4+IGtlcm5lbCBCVUcgYXQgZHJpdmVy
cy9jcnlwdG8vY2FhbS9qci5jOjI0NyEKPj4+Pj4gSW50ZXJuYWwgZXJyb3I6IE9vcHMgLSBCVUc6
IDAgWyMxXSBQUkVFTVBUIFNNUAo+Pj4+PiBNb2R1bGVzIGxpbmtlZCBpbjoKPj4+Pj4gQ1BVOiAw
IFBJRDogMCBDb21tOiBzd2FwcGVyLzAgTm90IHRhaW50ZWQgNS4xMS4wLTIwMjEwMjI1LTMtMDAw
MzktZzQzNDIxNTk2ODgxNi1kaXJ0eSAjMTIKPj4+Pj4gSGFyZHdhcmUgbmFtZTogVFEgVFFNTFMx
MDQ2QSBTb00gb24gQXJrb25hIEFUMTEzMCAoQzMwMCkgYm9hcmQgKERUKQo+Pj4+PiBwc3RhdGU6
IDYwMDAwMDA1IChuWkN2IGRhaWYgLVBBTiAtVUFPIC1UQ08gQlRZUEU9LS0pCj4+Pj4+IHBjIDog
Y2FhbV9qcl9kZXF1ZXVlKzB4OTgvMHg1N2MKPj4+Pj4gbHIgOiBjYWFtX2pyX2RlcXVldWUrMHg5
OC8weDU3Ywo+Pj4+PiBzcCA6IGZmZmY4MDAwMTAwMDNkNTAKPj4+Pj4geDI5OiBmZmZmODAwMDEw
MDAzZDUwIHgyODogZmZmZjgwMDAxMThkNDAwMAo+Pj4+PiB4Mjc6IGZmZmY4MDAwMTE4ZDQzMjgg
eDI2OiAwMDAwMDAwMDAwMDAwMWYwCj4+Pj4+IHgyNTogZmZmZjAwMDgwMjJiZTQ4MCB4MjQ6IGZm
ZmYwMDA4MDIyYzY0MTAKPj4+Pj4geDIzOiAwMDAwMDAwMDAwMDAwMWYxIHgyMjogZmZmZjgwMDAx
MThkNDMyOQo+Pj4+PiB4MjE6IDAwMDAwMDAwMDAwMDRkODAgeDIwOiAwMDAwMDAwMDAwMDAwMWYx
Cj4+Pj4+IHgxOTogMDAwMDAwMDAwMDAwMDAwMSB4MTg6IDAwMDAwMDAwMDAwMDAwMjAKPj4+Pj4g
eDE3OiAwMDAwMDAwMDAwMDAwMDAwIHgxNjogMDAwMDAwMDAwMDAwMDAxNQo+Pj4+PiB4MTU6IGZm
ZmY4MDAwMTE2OTAyMzAgeDE0OiAyZTJlMmUyZTJlMmUyZTJlCj4+Pj4+IHgxMzogMmUyZTJlMmUy
ZTJlMjAyMCB4MTI6IDMwMzAzMDMwMzAzMDMwMzAKPj4+Pj4geDExOiBmZmZmODAwMDExNzAwYTM4
IHgxMDogMDAwMDAwMDBmZmZmZjAwMAo+Pj4+PiB4OSA6IGZmZmY4MDAwMTAwYWRhMzAgeDggOiBm
ZmZmODAwMDExNmE4YTM4Cj4+Pj4+IHg3IDogMDAwMDAwMDAwMDAwMDAwMSB4NiA6IDAwMDAwMDAw
MDAwMDAwMDAKPj4+Pj4geDUgOiAwMDAwMDAwMDAwMDAwMDAwIHg0IDogMDAwMDAwMDAwMDAwMDAw
MAo+Pj4+PiB4MyA6IDAwMDAwMDAwZmZmZmZmZmYgeDIgOiAwMDAwMDAwMDAwMDAwMDAwCj4+Pj4+
IHgxIDogMDAwMDAwMDAwMDAwMDAwMCB4MCA6IDAwMDAwMDAwMDAwMDE4MDAKPj4+Pj4gQ2FsbCB0
cmFjZToKPj4+Pj4gICBjYWFtX2pyX2RlcXVldWUrMHg5OC8weDU3Ywo+Pj4+PiAgIHRhc2tsZXRf
YWN0aW9uX2NvbW1vbi5jb25zdHByb3AuMCsweDE2NC8weDE4Ywo+Pj4+PiAgIHRhc2tsZXRfYWN0
aW9uKzB4NDQvMHg1NAo+Pj4+PiAgIF9fZG9fc29mdGlycSsweDE2MC8weDQ1NAo+Pj4+PiAgIF9f
aXJxX2V4aXRfcmN1KzB4MTY0LzB4MTZjCj4+Pj4+ICAgaXJxX2V4aXQrMHgxYy8weDMwCj4+Pj4+
ICAgX19oYW5kbGVfZG9tYWluX2lycSsweGMwLzB4MTNjCj4+Pj4+ICAgZ2ljX2hhbmRsZV9pcnEr
MHg1Yy8weGYwCj4+Pj4+ICAgZWwxX2lycSsweGI0LzB4MTgwCj4+Pj4+ICAgYXJjaF9jcHVfaWRs
ZSsweDE4LzB4MzAKPj4+Pj4gICBkZWZhdWx0X2lkbGVfY2FsbCsweDNjLzB4MWMwCj4+Pj4+ICAg
ZG9faWRsZSsweDIzYy8weDI3NAo+Pj4+PiAgIGNwdV9zdGFydHVwX2VudHJ5KzB4MzQvMHg3MAo+
Pj4+PiAgIHJlc3RfaW5pdCsweGRjLzB4ZWMKPj4+Pj4gICBhcmNoX2NhbGxfcmVzdF9pbml0KzB4
MWMvMHgyOAo+Pj4+PiAgIHN0YXJ0X2tlcm5lbCsweDRhYy8weDRlNAo+Pj4+PiBDb2RlOiA5MTM5
MjAyMSA5MTJjMjAwMCBkMzc3ZDhjNiA5N2YyNGQ5NiAoZDQyMTAwMDApCj4+Pj4KPj4+PiBUaGUg
ZHJpdmVyIGl0ZXJhdGVzIG92ZXIgdGhlIGRlc2NyaXB0b3JzIGluIHRoZSBvdXRwdXQgcmluZyBh
bmQgbWF0Y2hlcyB0aGVtCj4+Pj4gd2l0aCB0aGUgb25lcyBpdCBoYXMgcHJldmlvdXNseSBxdWV1
ZWQuIElmIGl0IGRvZXNuJ3QgZmluZCBhIG1hdGNoaW5nCj4+Pj4gZGVzY3JpcHRvciBpdCBjb21w
bGFpbnMgd2l0aCB0aGUgQlVHX09OKCkgc2VlbiBhYm92ZS4gV2hhdCBJIHNlZSBzb21ldGltZXMg
aXMKPj4+PiB0aGF0IHRoZSBhZGRyZXNzIGluIHRoZSBvdXRwdXQgcmluZyBpcyAweDAsIHRoZSBq
b2Igc3RhdHVzIGluIHRoaXMgY2FzZSBpcwo+Pj4+IDB4NDAwMDAwMDYgKG1lYW5pbmcgREVDTyBJ
bnZhbGlkIEtFWSBjb21tYW5kKS4gSXQgc2VlbXMgdGhhdCB0aGUgQ0FBTSBkb2Vzbid0Cj4+Pj4g
d3JpdGUgdGhlIGRlc2NyaXB0b3IgYWRkcmVzcyB0byB0aGUgb3V0cHV0IHJpbmcgYXQgbGVhc3Qg
aW4gc29tZSBlcnJvciBjYXNlcy4KPj4+PiBXaGVuIHdlIGRvbid0IGhhdmUgdGhlIGRlc2NyaXB0
b3IgYWRkcmVzcyBvZiB0aGUgZmFpbGVkIGRlc2NyaXB0b3Igd2UgaGF2ZSBubwo+Pj4+IHdheSB0
byBmaW5kIGl0IGluIHRoZSBsaXN0IG9mIHF1ZXVlZCBkZXNjcmlwdG9ycywgdGh1cyB3ZSBhbHNv
IGNhbid0IGZpbmQgdGhlCj4+Pj4gY2FsbGJhY2sgZm9yIHRoYXQgZGVzY3JpcHRvci4gVGhpcyBs
b29rcyB2ZXJ5IHVuZm9ydHVuYXRlLCBhbnlvbmUgZWxzZSBzZWVuCj4+Pj4gdGhpcyBvciBoYXMg
YW4gaWRlYSB3aGF0IHRvIGRvIGFib3V0IGl0Pwo+Pj4+Cj4+Pj4gSSBoYXZlbid0IGludmVzdGln
YXRlZCB5ZXQgd2hpY2ggam9iIGFjdHVhbGx5IGZhaWxzIGFuZCB3aHkuIE9mIGNvdXJzZSB0aGF0
IHdvdWxkCj4+Pj4gYmUgbXkgdWx0aW1hdGUgZ29hbCB0byBmaW5kIHRoYXQgb3V0Lgo+Pj4+Cj4+
PiBUaGlzIGxvb2tzIHZlcnkgc2ltaWxhciB0byBhbiBlYXJsaWVyIHJlcG9ydCBmcm9tIEdyZWcu
Cj4+PiBIZSBjb25maXJtZWQgdGhhdCBhZGRpbmcgImRtYS1jb2hlcmVudCIgcHJvcGVydHkgdG8g
dGhlICJjcnlwdG8iIERUIG5vZGUKPj4+IGZpeGVzIHRoZSBpc3N1ZToKPj4+IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2xpbnV4LWNyeXB0by83NGY2NjRmNS01NDMzLWQzMjItNDc4OS0zYzc4YmRi
ODE0ZDhAa2VybmVsLm9yZwo+Pj4gUGF0Y2ggcmViYXNlZCBvbiB2NS4xMSBpcyBhdCB0aGUgYm90
dG9tLiBEb2VzIGl0IHdvcmsgZm9yIHlvdSB0b28/Cj4+Cj4+IEluZGVlZCB0aGlzIHNlZW1zIHRv
IHNvbHZlIGl0IGZvciBtZSBhcyB3ZWxsLCB5b3UgY2FuIGFkZCBteQo+Pgo+PiBUZXN0ZWQtYnk6
IFNhc2NoYSBIYXVlciA8cy5oYXVlckBwZW5ndXRyb25peC5kZT4KPj4KPiBUaGFua3MhCj4gSSds
bCBhcHBlbmQgdGhlIHRhZyB0byB0aGUgZm9ybWFsbHkgc3VibWl0dGVkIHBhdGNoLgo+IAo+PiBI
b3dldmVyLCB0aGVyZSBzZWVtIHRvIGJlIHR3byBwcm9ibGVtczogRmlyc3QgdGhhdCAiREVDTyBJ
bnZhbGlkIEtFWQo+PiBjb21tYW5kIiBhY3R1YWxseSBvY2N1cnMgYW5kIHNlY29uZCB0aGF0IHRo
ZSBkZXFldWV1ZSBjb2RlIGN1cnJlbnRseQo+PiBjYW4ndCBoYW5kbGUgYSBOVUxMIHBvaW50ZXIg
aW4gdGhlIG91dHB1dCByaW5nLgo+IEN1cnJlbnRseSB0aGUgZGVxdWV1ZSBjb2RlIEJVR3Mgbm90
IG9ubHkgZm9yICJOVUxMIHBvaW50ZXIiLCBidXQgZm9yIGFueQo+IElPVkEgaW4gdGhlIG91dHB1
dCByaW5nIHRoYXQgaXMgbm90IG1hdGNoZWQgd2l0aCBhbiBlbnRyeSBpbiB0aGUgInNoYWRvdyIK
PiAoU1cpIHJpbmcuCj4gSGVyZSB0aGUgQlVHX09OKCkgc2hvdWxkIGJlIHJlcGxhY2VkIHdpdGgg
V0FSTl9PTiBzaW5jZSBub3QgZmluZGluZyBhIG1hdGNoCj4gbWVhbnMgZHJpdmVyIGNhbid0IGdv
IHRvIHRoZSAiU1cgY29udGV4dCIgYW5kIGV2ZW50dWFsbHkgY2FsbCBjb21wbGV0ZSgpCj4gdG8g
d2FrZSB1cCB0aGUgY3J5cHRvIEFQSSB1c2VyLiBJbiBtYW55IGNhc2VzIHRoZSB1c2VyIHJlbGll
cyBvbgo+IGNyeXB0b193YWl0X3JlcSgpLCB3aGljaCBkb2VzIG5vdCB0aW1lIG91dCBhbmQgaXMg
bm90IGtpbGxhYmxlLgo+IAo+PiBEbyB5b3UgdGhpbmsgdGhhdCB0aGUgb2NjdXJlbmNlIG9mIGEg
TlVMTCBwb2ludGVyIGlzIGFsc28gYSBjb2hlcmVuY3kKPj4gaXNzdWU/Cj4+Cj4gSSBzdHJvbmds
eSBiZWxpZXZlIHRoZXJlJ3MgYSBzaW5nbGUgcHJvYmxlbSBiZWNhdXNlIHRoZSBpc3N1ZSBnb2Vz
IGF3YXkKPiB3aGVuIHRoZSBwYXRjaCBpcyBhcHBsaWVkLCBldmVuIHRob3VnaCBJIGhhdmVuJ3Qg
ZmlndXJlZCBvdXQgd2hhdCBpcwo+IHRoZSBleGFjdCBwbGFjZSAvIGRhdGEgc3RydWN0dXJlIHRo
YXQgZ2V0cyBjb3JydXB0ZWQuCj4gCj4gT25lIHRoZW9yeSBpcyB0aGF0IGNvcnJ1cHRpb24gb2Nj
dXJzIGluIHRoZSBpbnB1dCByaW5nOgo+IC1DUFUgc2V0cyB1cCBjb3JyZWN0bHkgdGhlIGlucHV0
IHJpbmcgZW50cnkKPiAtZGV2aWNlIGRvZXNuJ3Qgc2VlIHRoZSAiZnJlc2giIGRhdGEsIHJlYWRp
bmcgMHgwIGZvciB0aGUgZGVzY3JpcHRvciBhZGRyZXNzCj4gLWRldmljZSByZWFkcyB0aGUgZGVz
Y3JpcHRvciBjb21tYW5kcyBmcm9tIGFkZHJlc3MgMHgwIGFuZCBpc3N1ZXMKPiAiREVDTyBpbnZh
bGlkIEtFWSBjb21tYW5kIiAobm90ZSB0aGF0IEtFWSBjb21tYW5kIG9wY29kZSBpcyBiJzAwMDAw
LCBzbyByZWFkaW5nCj4gYWxsIHplcm9zIGZyb20gYWRkcmVzcyAweDAgd291bGQgbGVhZCB0byB0
aGlzIGVycm9yKQo+IAo+IEJ1dCB0aGVuIHRoZSBpbnB1dCAmIG91dHB1dCByaW5ncyBhcmUgYWxs
b2NhdGVkIHVzaW5nIGRtYV9hbGxvY19jb2hlcmVudCgpLAo+IHNvIEknbGwgbmVlZCB0byBjaGVj
ayBpZiBsYWNrIG9mICJkbWEtY29oZXJlbnQiIERUIHByb3BlcnR5IGhhcyB0aGUgc2FtZQo+IGVm
ZmVjdCBvbiBjb25zaXN0ZW50IERNQSBtYXBwaW5ncyBhcyBvbiBzdHJlYW1pbmcgRE1BIG1hcHBp
bmdzLgoKSXQgY2VydGFpbmx5IGNhbiwgYXQgbGVhc3Qgb24gYXJtNjQgd2hlcmUgY29oZXJlbnQg
YnVmZmVycyBhcmUgcmVtYXBwZWQgCmluIHZtYWxsb2MgcmF0aGVyIHRoYW4gY2hhbmdpbmcgdGhl
IGxpbmVhciBtYXAgYXR0cmlidXRlcyBpbi1wbGFjZS4gSW4gCnRoYXQgY2FzZSB0aGUgZG1hX2Fs
bG9jX2NvaGVyZW50KCkgZmxvdyBsb29rcyBsaWtlIHRoaXM6CgoxOiBjbGVhbiBhbmQgaW52YWxp
ZGF0ZSBwYWdlcyBieSAoY2FjaGVhYmxlKSBsaW5lYXIgbWFwIGFkZHJlc3MKMjogc2V0IHVwIG5v
bi1jYWNoZWFibGUgcmVtYXAKMzogd3JpdGUgemVyb3MgdmlhIG5vbi1jYWNoZWFibGUgbWFwcGlu
ZwouLi4KNDogQ1BVIHdyaXRlcyBkZXNjcmlwdG9yIHZpYSBub24tY2FjaGVhYmxlIG1hcHBpbmcK
Li4uCjU6IGRldmljZSByZWFkcyBkZXNjcmlwdG9yCgpJZiB0aGUgY2FjaGVhYmxlIGFsaWFzIGlz
IHByZWZldGNoZWQgYmFjayBpbiBiZXR3ZWVuIHN0ZXBzIDEgYW5kIDQgKGUuZy4gCmZyb20gYW5v
dGhlciB0aHJlYWQgYWNjZXNzaW5nIGFuIGFkamFjZW50IHBhZ2UgYnkgbGluZWFyIG1hcCBhZGRy
ZXNzKSwgCnRoZSBDUFUgd3JpdGVzIHdpbGwgKHVzdWFsbHkpIHN0aWxsIGJ5cGFzcyB0aGUgY2Fj
aGVzIGFuZCBnbyBzdHJhaWdodCB0byAKRFJBTSwgc28gaWYgdGhlIGRldmljZSByZWFkIHVuZXhw
ZWN0ZWRseSBzbm9vcHMgaXQgY2FuIHJldHVybiB0aGUgb2xkZXIgCmRhdGEgZnJvbSB0aGUgY2Fj
aGUuIFRoaXMgd2lsbCBub3JtYWxseSBiZSB0aGUgemVyb3MgZnJvbSBzdGVwIDMsIHVubGVzcyAK
eW91J3JlIGV4dHJlbWVseSB1bmx1Y2t5IGFuZCB0aGUgcHJlZmV0Y2ggaGFwcGVuZWQgZXZlbiBi
ZWZvcmUgdGhhdC4gQXMgCkkgbWVudGlvbmVkLCB0aGlzIGlzIGV4YWN0bHkgd2hhdCB3ZSB3ZXJl
IGhpdHRpbmcgd2l0aCBQYW5mcm9zdCB3aGVyZSAKR1BVIGNvaGVyZW5jeSB3YXNuJ3QgZGVzY3Jp
YmVkLgoKUm9iaW4uCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
