Return-Path: <SRS0=wTTv=AV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A36ABC433E3
	for <iommu@archiver.kernel.org>; Fri, 10 Jul 2020 12:56:30 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C3E320720
	for <iommu@archiver.kernel.org>; Fri, 10 Jul 2020 12:56:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C3E320720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 686F5896FF;
	Fri, 10 Jul 2020 12:56:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kCr4zeYJKEQ4; Fri, 10 Jul 2020 12:56:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D560C89741;
	Fri, 10 Jul 2020 12:56:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BCF3CC077B;
	Fri, 10 Jul 2020 12:56:29 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 33FCDC016F
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 12:56:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2FD7C89741
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 12:56:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3HBzHmifkgAM for <iommu@lists.linux-foundation.org>;
 Fri, 10 Jul 2020 12:56:26 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A7794896FF
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 12:56:26 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 9CA1B20C; Fri, 10 Jul 2020 14:56:24 +0200 (CEST)
Date: Fri, 10 Jul 2020 14:56:23 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Alex Shi <alex.shi@linux.alibaba.com>, Robin Murphy <robin.murphy@arm.com>
Subject: Re: a question of split_huge_page
Message-ID: <20200710125623.GH27672@8bytes.org>
References: <df2597f6-af21-5547-d39c-94c02ad17adb@linux.alibaba.com>
 <20200709155002.GF12769@casper.infradead.org>
 <20200709160750.utl46xvavceuvnom@box>
 <f761007f-4663-f72e-b0da-fc3ce9486b4b@linux.alibaba.com>
 <441ebbeb-0408-e22e-20f4-1be571c4a18e@nextfour.com>
 <50113530-fae5-bb36-56c2-5b5c4f90426d@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <50113530-fae5-bb36-56c2-5b5c4f90426d@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Hugh Dickins <hughd@google.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Linux-MM <linux-mm@kvack.org>,
 iommu@lists.linux-foundation.org,
 Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila@nextfour.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 "Kirill A. Shutemov" <kirill@shutemov.name>
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

QWRkaW5nIFJvYmluLgoKT24gRnJpLCBKdWwgMTAsIDIwMjAgYXQgMDU6MzQ6NTJQTSArMDgwMCwg
QWxleCBTaGkgd3JvdGU6Cj4g5ZyoIDIwMjAvNy8xMCDkuIvljYgxOjI4LCBNaWthIFBlbnR0aWzD
pCDlhpnpgZM6Cj4gPiAKPiA+IAo+ID4gT24gMTAuNy4yMDIwIDcuNTEsIEFsZXggU2hpIHdyb3Rl
Ogo+ID4+Cj4gPj4g5ZyoIDIwMjAvNy8xMCDkuIrljYgxMjowNywgS2lyaWxsIEEuIFNodXRlbW92
IOWGmemBkzoKPiA+Pj4gT24gVGh1LCBKdWwgMDksIDIwMjAgYXQgMDQ6NTA6MDJQTSArMDEwMCwg
TWF0dGhldyBXaWxjb3ggd3JvdGU6Cj4gPj4+PiBPbiBUaHUsIEp1bCAwOSwgMjAyMCBhdCAxMTox
MToxMVBNICswODAwLCBBbGV4IFNoaSB3cm90ZToKPiA+Pj4+PiBIaSBLaXJpbGwgJiBNYXR0aGV3
LAo+ID4+Pj4+Cj4gPj4+Pj4gSW4gdGhlIGZ1bmMgY2FsbCBjaGFpbiwgZnJvbSBzcGxpdF9odWdl
X3BhZ2UoKSB0byBscnVfYWRkX3BhZ2VfdGFpbCgpLAo+ID4+Pj4+IFNlZW1zIHRhaWwgcGFnZXMg
YXJlIGFkZGVkIHRvIGxydSBsaXN0IGF0IGxpbmUgOTYzLCBidXQgaW4gdGhpcyBzY2VuYXJpbwo+
ID4+Pj4+IHRoZSBoZWFkIHBhZ2UgaGFzIG5vIGxydSBiaXQgYW5kIGlzbid0IHNldCB0aGUgYml0
IGxhdGVyLiBXaHkgd2UgZG8gdGhpcz8KPiA+Pj4+PiBvciBkbyBJIG1pc3Mgc3RoPwo+ID4+Pj4g
SSBkb24ndCB1bmRlcnN0YW5kIGhvdyB3ZSBnZXQgdG8gc3BsaXRfaHVnZV9wYWdlKCkgd2l0aCBh
IHBhZ2UgdGhhdCdzCj4gPj4+PiBub3Qgb24gYW4gTFJVIGxpc3QuICBCb3RoIGFub255bW91cyBh
bmQgcGFnZSBjYWNoZSBwYWdlcyBzaG91bGQgYmUgb24KPiA+Pj4+IGFuIExSVSBsaXN0LiAgV2hh
dCBhbSBJIG1pc3Npbmc/PiAKPiA+Pgo+ID4+IFRoYW5rcyBhIGxvdCBmb3IgcXVpY2sgcmVwbHkh
Cj4gPj4gV2hhdCBJIGFtIGNvbmZ1c2luZyBpcyB0aGUgY2FsbCBjaGFpbjogX19pb21tdV9kbWFf
YWxsb2NfcGFnZXMoKQo+ID4+IHRvIHNwbGl0X2h1Z2VfcGFnZSgpLCBpbiB0aGUgZnVuYywgc3Bs
aXRlZCBwYWdlLAo+ID4+IAlwYWdlID0gYWxsb2NfcGFnZXNfbm9kZShuaWQsIGFsbG9jX2ZsYWdz
LCBvcmRlcik7Cj4gPj4gQW5kIGlmIHRoZSBwYWdlcyB3ZXJlIGFkZGVkIGludG8gbHJ1LCB0aGV5
IG1heWJlIHJlY2xhaW1lZCBhbmQgbG9zdCwKPiA+PiB0aGF0IHdvdWxkIGJlIGEgcGFuaWMgYnVn
LiBCdXQgaW4gZmFjdCwgdGhpcyBuZXZlciBoYXBwZW5lZCBmb3IgbG9uZyB0aW1lLgo+ID4+IEFs
c28gSSBwdXQgYSBCVUcoKSBhdCB0aGUgbGluZSwgaXQncyBuZXZyZSB0cmlnZ2VyZWQgaW4gbHRw
LCBhbmQgcnVuX3ZtdGVzdHMKPiA+IAo+ID4gCj4gPiBJbsKgIF9faW9tbXVfZG1hX2FsbG9jX3Bh
Z2VzLCBhZnRlciBzcGxpdF9odWdlX3BhZ2UoKSzCoCB3aG8gaXMgdGFraW5nIGEKPiA+IHJlZmVy
ZW5jZSBvbiB0YWlsIHBhZ2VzPyBTZWVtcyB0YWlsIHBhZ2VzIGFyZSBmcmVlZCBhbmQgdGhlIGZ1
bmN0aW9uCj4gPiBlcnJvcm5vdXNseSByZXR1cm5zIHRoZW0gaW4gcGFnZXNbXSBhcnJheSBmb3Ig
dXNlPwo+ID4gCj4gCj4gQ0MgSm9lcmcgYW5kIGlvbW11IGxpc3QsCj4gCj4gVGhhdCdzIGEgZ29v
ZCBxdWVzdGlvbi4gc2VlbXMgdGhlIHNwbGl0X2h1Z2VfcGFnZSB3YXMgbmV2ZXIgdHJpZ2dlcmVk
IGhlcmUsCj4gc2luY2UgdGhlIGZ1bmMgd291bGQgY2hlY2sgdGhlIFBhZ2VMb2NrIGZpcnN0LiBh
bmQgaGF2ZSBwYWdlLT5tYXBwaW5nIGFuZCBQYWdlQW5vbgo+IGNoZWNrLCBhbnkgb2YgdGhlbSBj
b3VsZG4ndCBiZSBtYXRjaGVkIGZvciB0aGUgYWxsb2NlZCBwYWdlLgo+IAo+IEhpIEpvZXJnLAo+
IHdvdWxkIHlvdSBsaWtlIGxvb2sgaW50byB0aGlzPyBkbyB3ZSBzdGlsbCBuZWVkIHRoZSBzcGxp
dF9odWdlX3BhZ2UoKSBoZXJlPwo+IAo+IFRoYW5rcwo+IEFsZXgKPiAKPiBpbnQgc3BsaXRfaHVn
ZV9wYWdlX3RvX2xpc3Qoc3RydWN0IHBhZ2UgKnBhZ2UsIHN0cnVjdCBsaXN0X2hlYWQgKmxpc3Qp
Cj4gewo+ICAgICAgICAgc3RydWN0IHBhZ2UgKmhlYWQgPSBjb21wb3VuZF9oZWFkKHBhZ2UpOwo+
ICAgICAgICAgc3RydWN0IGRlZmVycmVkX3NwbGl0ICpkc19xdWV1ZSA9IGdldF9kZWZlcnJlZF9z
cGxpdF9xdWV1ZShoZWFkKTsKPiAgICAgICAgIHN0cnVjdCBhbm9uX3ZtYSAqYW5vbl92bWEgPSBO
VUxMOwo+ICAgICAgICAgc3RydWN0IGFkZHJlc3Nfc3BhY2UgKm1hcHBpbmcgPSBOVUxMOwo+ICAg
ICAgICAgaW50IGNvdW50LCBtYXBjb3VudCwgZXh0cmFfcGlucywgcmV0Owo+ICAgICAgICAgcGdv
ZmZfdCBlbmQ7Cj4gCj4gICAgICAgICBWTV9CVUdfT05fUEFHRShpc19odWdlX3plcm9fcGFnZSho
ZWFkKSwgaGVhZCk7Cj4gICAgICAgICBWTV9CVUdfT05fUEFHRSghUGFnZUxvY2tlZChoZWFkKSwg
aGVhZCk7CTw9PQo+ID4gCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21t
dQ==
