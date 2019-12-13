Return-Path: <SRS0=hFKH=2D=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F89C43603
	for <iommu@archiver.kernel.org>; Fri, 13 Dec 2019 02:13:49 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C96B7227BF
	for <iommu@archiver.kernel.org>; Fri, 13 Dec 2019 02:13:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C96B7227BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9C0278849D;
	Fri, 13 Dec 2019 02:13:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AhHP9ByU9p4w; Fri, 13 Dec 2019 02:13:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id BE76D88491;
	Fri, 13 Dec 2019 02:13:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B1FA6C1796;
	Fri, 13 Dec 2019 02:13:46 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A51D4C0881
 for <iommu@lists.linux-foundation.org>; Fri, 13 Dec 2019 02:13:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 9EBC488A64
 for <iommu@lists.linux-foundation.org>; Fri, 13 Dec 2019 02:13:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F5e6bhjAXTbI for <iommu@lists.linux-foundation.org>;
 Fri, 13 Dec 2019 02:13:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by hemlock.osuosl.org (Postfix) with ESMTPS id B2FF888A5E
 for <iommu@lists.linux-foundation.org>; Fri, 13 Dec 2019 02:13:44 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Dec 2019 18:13:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,308,1571727600"; d="scan'208";a="226146129"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
 ([10.239.159.136])
 by orsmga002.jf.intel.com with ESMTP; 12 Dec 2019 18:13:41 -0800
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix dmar pte read access not set error
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>,
 ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20191211014015.7898-1-baolu.lu@linux.intel.com>
 <20191212014952.vlrmxrk2cebwxjnp@cantor>
 <6f3bcad9-b9b3-b349-fdad-ce53a79a665b@linux.intel.com>
 <20191213003013.gc3zg3fpzpjntnzg@cantor>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <7d58da5b-3f55-72b2-0638-ae561446d207@linux.intel.com>
Date: Fri, 13 Dec 2019 10:12:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191213003013.gc3zg3fpzpjntnzg@cantor>
Content-Language: en-US
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

SGksCgpPbiAxMi8xMy8xOSA4OjMwIEFNLCBKZXJyeSBTbml0c2VsYWFyIHdyb3RlOgo+IE9uIFRo
dSBEZWMgMTIgMTksIEx1IEJhb2x1IHdyb3RlOgo+PiBIaSwKPj4KPj4gT24gMTIvMTIvMTkgOTo0
OSBBTSwgSmVycnkgU25pdHNlbGFhciB3cm90ZToKPj4+IE9uIFdlZCBEZWMgMTEgMTksIEx1IEJh
b2x1IHdyb3RlOgo+Pj4+IElmIHRoZSBkZWZhdWx0IERNQSBkb21haW4gb2YgYSBncm91cCBkb2Vz
bid0IGZpdCBhIGRldmljZSwgaXQKPj4+PiB3aWxsIHN0aWxsIHNpdCBpbiB0aGUgZ3JvdXAgYnV0
IHVzZSBhIHByaXZhdGUgaWRlbnRpdHkgZG9tYWluLgo+Pj4+IFdoZW4gbWFwL3VubWFwL2lvdmFf
dG9fcGh5cyBjb21lIHRocm91Z2ggaW9tbXUgQVBJLCB0aGUgZHJpdmVyCj4+Pj4gc2hvdWxkIHN0
aWxsIHNlcnZlIHRoZW0sIG90aGVyd2lzZSwgb3RoZXIgZGV2aWNlcyBpbiB0aGUgc2FtZQo+Pj4+
IGdyb3VwIHdpbGwgYmUgaW1wYWN0ZWQuIFNpbmNlIGlkZW50aXR5IGRvbWFpbiBoYXMgYmVlbiBt
YXBwZWQKPj4+PiB3aXRoIHRoZSB3aG9sZSBhdmFpbGFibGUgbWVtb3J5IHNwYWNlIGFuZCBSTVJS
cywgd2UgZG9uJ3QgbmVlZAo+Pj4+IHRvIHdvcnJ5IGFib3V0IHRoZSBpbXBhY3Qgb24gaXQuCj4+
Pj4KPj4+PiBMaW5rOiBodHRwczovL3d3dy5zcGluaWNzLm5ldC9saXN0cy9pb21tdS9tc2c0MDQx
Ni5odG1sCj4+Pj4gQ2M6IEplcnJ5IFNuaXRzZWxhYXIgPGpzbml0c2VsQHJlZGhhdC5jb20+Cj4+
Pj4gUmVwb3J0ZWQtYnk6IEplcnJ5IFNuaXRzZWxhYXIgPGpzbml0c2VsQHJlZGhhdC5jb20+Cj4+
Pj4gRml4ZXM6IDk0MjA2N2YxYjZiOTcgKCJpb21tdS92dC1kOiBJZGVudGlmeSBkZWZhdWx0IGRv
bWFpbnMgcmVwbGFjZWQgCj4+Pj4gd2l0aCBwcml2YXRlIikKPj4+PiBDYzogc3RhYmxlQHZnZXIu
a2VybmVsLm9yZyAjIHY1LjMrCj4+Pj4gU2lnbmVkLW9mZi1ieTogTHUgQmFvbHUgPGJhb2x1Lmx1
QGxpbnV4LmludGVsLmNvbT4KPj4+Cj4+PiBSZXZpZXdlZC1ieTogSmVycnkgU25pdHNlbGFhciA8
anNuaXRzZWxAcmVkaGF0LmNvbT4KPj4KPj4gQ2FuIHlvdSBwbGVhc2UgdHJ5IHRoaXMgZml4IGFu
ZCBjaGVjayB3aGV0aGVyIGl0IGNhbiBmaXggeW91ciBwcm9ibGVtPwo+PiBJZiBpdCBoZWxwcywg
ZG8geW91IG1pbmQgYWRkaW5nIGEgVGVzdGVkLWJ5Pwo+Pgo+PiBCZXN0IHJlZ2FyZHMsCj4+IGJh
b2x1Cj4+Cj4gCj4gSSdtIHRlc3Rpbmcgd2l0aCB0aGlzIHBhdGNoLCBteSBwYXRjaCB0aGF0IG1v
dmVzIHRoZSBkaXJlY3QgbWFwcGluZyBjYWxsLAo+IGFuZCBBbGV4J3MgcGF0Y2ggZm9yIHRoZSBJ
U0EgYnJpZGdlLiBJdCBzb2x2ZWQgdGhlIDIgaW9tbXUgbWFwcGluZyBlcnJvcnMKPiBJIHdhcyBz
ZWVpbmcgd2l0aCBkZWZhdWx0IHBhc3N0aHJvdWdoLCBJIG5vIGxvbmdlciBzZWUgYWxsIHRoZSBk
bWFyIHB0ZQo+IHJlYWQgYWNjZXNzIGVycm9ycywgYW5kIHRoZSBzeXN0ZW0gYm9vdHMgYWxsb3dp
bmcgbWUgdG8gbG9naW4uIEknbSB0cmFja2luZwo+IGRvd24gMiBpc3N1ZXMgYXQgdGhlIG1vbWVu
dC4gV2l0aCBwYXNzdGhyb3VnaCBJIHNlZSBhIHByb2JsZW0gd2l0aCAwMTowMC40Cj4gdGhhdCBJ
IG1lbnRpb25lZCBpbiB0aGUgZWFybGllciBlbWFpbDoKPiAKPiBbwqDCoCA3OC45Nzg1NzNdIHVo
Y2lfaGNkOiBVU0IgVW5pdmVyc2FsIEhvc3QgQ29udHJvbGxlciBJbnRlcmZhY2UgZHJpdmVyCj4g
W8KgwqAgNzguOTgwODQyXSB1aGNpX2hjZCAwMDAwOjAxOjAwLjQ6IFVIQ0kgSG9zdCBDb250cm9s
bGVyCj4gW8KgwqAgNzguOTgyNzM4XSB1aGNpX2hjZCAwMDAwOjAxOjAwLjQ6IG5ldyBVU0IgYnVz
IHJlZ2lzdGVyZWQsIGFzc2lnbmVkIAo+IGJ1cyBudW1iZXIgMwo+IFvCoMKgIDc4Ljk4NTIyMl0g
dWhjaV9oY2QgMDAwMDowMTowMC40OiBkZXRlY3RlZCA4IHBvcnRzCj4gW8KgwqAgNzguOTg2OTA3
XSB1aGNpX2hjZCAwMDAwOjAxOjAwLjQ6IHBvcnQgY291bnQgbWlzZGV0ZWN0ZWQ/IGZvcmNpbmcg
dG8gCj4gMiBwb3J0cwo+IFvCoMKgIDc4Ljk4OTMxNl0gdWhjaV9oY2QgMDAwMDowMTowMC40OiBp
cnEgMTYsIGlvIGJhc2UgMHgwMDAwM2MwMAo+IFvCoMKgIDc4Ljk5NDYzNF0gdWhjaV9oY2QgMDAw
MDowMTowMC40OiBETUFSOiAzMmJpdCBETUEgdXNlcyBub24taWRlbnRpdHkgCj4gbWFwcGluZwo+
IFvCoMKgIDcgMDAwMDowMTowMC40OiB1bmFibGUgdG8gYWxsb2NhdGUgY29uc2lzdGVudCBtZW1v
cnkgZm9yIGZyYW1lIGxpc3QKPiBbwqDCoCA3OS40OTk4OTFdIHVoY2lfaGNkIDAwMDA6MDE6MDAu
NDogc3RhcnR1cCBlcnJvciAtMTYKPiBbwqDCoCA3OS41MDE1ODhdIHVoY2lfaGNkIDAwMDA6MDE6
MDAuNDogVVNCIGJ1cyAzIGRlcmVnaXN0ZXJlZAo+IFvCoMKgIDc5LjUwMzQ5NF0gdWhjaV9oY2Qg
MDAwMDowMTowMC40OiBpbml0IDAwMDA6MDE6MDAuNCBmYWlsLCAtMTYKPiBbwqDCoCA3OS41MDU0
OTddIHVoY2lfaGNkOiBwcm9iZSBvZiAwMDAwOjAxOjAwLjQgZmFpbGVkIHdpdGggZXJyb3IgLTE2
Cj4gCj4gSWYgSSBib290IHRoZSBzeXN0ZW0gd2l0aCBpb21tdT1ub3B0IEkgc2VlIGFuIGlvbW11
IG1hcCBmYWlsdXJlIGR1ZSB0bwo+IHRoZSBwcm90IGNoZWNrIGluIF9fZG9tYWluX21hcHBpbmc6
Cj4gCj4gW8KgwqAgNDAuOTQwNTg5XSBwY2kgMDAwMDowMDoxZi4wOiBpb21tdV9ncm91cF9hZGRf
ZGV2aWNlOiBjYWxsaW5nIAo+IGlvbW11X2dyb3VwX2NyZWF0ZV9kaXJlY3RfbWFwcGluZ3MKPiBb
wqDCoCA0MC45NDM1NThdIHBjaSAwMDAwOjAwOjFmLjA6IGlvbW11X2dyb3VwX2NyZWF0ZV9kaXJl
Y3RfbWFwcGluZ3M6IAo+IGl0ZXJhdGluZyB0aHJvdWdoIG1hcHBpbmdzCj4gW8KgwqAgNDAuOTQ2
NDAyXSBwY2kgMDAwMDowMDoxZi4wOiBpb21tdV9ncm91cF9jcmVhdGVfZGlyZWN0X21hcHBpbmdz
OiAKPiBjYWxsaW5nIGFwcGx5X3Jlc3ZfcmVnaW9uCj4gW8KgwqAgNDAuOTQ5MTg0XSBwY2kgMDAw
MDowMDoxZi4wOiBpb21tdV9ncm91cF9jcmVhdGVfZGlyZWN0X21hcHBpbmdzOiAKPiBlbnRyeSB0
eXBlIGlzIGRpcmVjdAo+IFvCoMKgIDQwLjk1MTgxOV0gRE1BUjogaW50ZWxfaW9tbXVfbWFwOiBl
bnRlcgo+IFvCoMKgIDQwLjk1MzEyOF0gRE1BUjogX19kb21haW5fbWFwcGluZzogcHJvdCAmIAo+
IChETUFfUFRFX1JFQUR8RE1BX1BURV9XUklURSkgPT0gMAo+IFvCoMKgIDQwLjk1NTQ4Nl0gRE1B
UjogZG9tYWluX21hcHBpbmc6IF9fZG9tYWluX21hcHBpbmcgZmFpbGVkCj4gW8KgwqAgNDAuOTU3
MzQ4XSBETUFSOiBpbnRlbF9pb21tdV9tYXA6IGRvbWFpbl9wZm5fbWFwcGluZyByZXR1cm5lZCAt
MjIKPiBbwqDCoCA0MC45NTk0NjZdIERNQVI6IGludGVsX2lvbW11X21hcDogbGVhdmUKPiBbwqDC
oCA0MC45NTk0NjhdIGlvbW11OiBpb21tdV9tYXA6IG9wcy0+bWFwIGZhaWxlZCBpb3ZhIDB4MCBw
YSAKPiAweDAwMDAwMDAwMDAwMDAwMDAgcGdzaXplIDB4MTAwMAo+IFvCoMKgIDQwLjk2MzUxMV0g
cGNpIDAwMDA6MDA6MWYuMDogaW9tbXVfZ3JvdXBfY3JlYXRlX2RpcmVjdF9tYXBwaW5nczogCj4g
aW9tbXVfbWFwIGZhaWxlZAo+IFvCoMKgIDQwLjk2NjAyNl0gcGNpIDAwMDA6MDA6MWYuMDogaW9t
bXVfZ3JvdXBfY3JlYXRlX2RpcmVjdF9tYXBwaW5nczogCj4gbGVhdmluZyBmdW5jCj4gW8KgwqAg
NDAuOTY4NDg3XSBwY2kgMDAwMDowMDoxZi4wOiBpb21tdV9ncm91cF9hZGRfZGV2aWNlOiBjYWxs
aW5nIAo+IF9faW9tbXVfYXR0YWNoX2RldmljZQo+IFvCoMKgIDQwLjk3MTAxNl0gcGNpIDAwMDA6
MDA6MWYuMDogQWRkaW5nIHRvIGlvbW11IGdyb3VwIDE5Cj4gW8KgwqAgNDAuOTcyNzMxXSBwY2kg
MDAwMDowMDoxZi4wOiBETUFSOiBkb21haW4tPnR5cGUgaXMgZG1hCj4gCj4gL3N5cy9rZXJuZWwv
aW9tbXVfZ3JvdXBzLzE5Cj4gW3Jvb3RAaHAtZGwzODhnOC0wNyAxOV0jIGNhdCByZXNlcnZlZF9y
ZWdpb25zIDB4MDAwMDAwMDAwMDAwMDAwMCAKPiAweDAwMDAwMDAwMDBmZmZmZmYgZGlyZWN0Cj4g
MHgwMDAwMDAwMGJkZjZlMDAwIDB4MDAwMDAwMDBiZGY4NGZmZiBkaXJlY3QKPiAweDAwMDAwMDAw
ZmVlMDAwMDAgMHgwMDAwMDAwMGZlZWZmZmZmIG1zaQo+IAo+IDAwOjFmLjAgSVNBIGJyaWRnZTog
SW50ZWwgQ29ycG9yYXRpb24gQzYwMC9YNzkgc2VyaWVzIGNoaXBzZXQgTFBDIAo+IENvbnRyb2xs
ZXIKClRoaXMgc2VlbXMgdG8gYmUgYW5vdGhlciBpc3N1ZT8KCkJlc3QgcmVnYXJkcywKYmFvbHUK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFp
bGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
