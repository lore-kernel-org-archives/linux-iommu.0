Return-Path: <SRS0=hFKH=2D=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9314CC43603
	for <iommu@archiver.kernel.org>; Fri, 13 Dec 2019 05:02:22 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 601EB22527
	for <iommu@archiver.kernel.org>; Fri, 13 Dec 2019 05:02:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 601EB22527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2C968879A7;
	Fri, 13 Dec 2019 05:02:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hIqHdJBypEI0; Fri, 13 Dec 2019 05:02:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id EC8C281B64;
	Fri, 13 Dec 2019 05:02:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C166BC1D7F;
	Fri, 13 Dec 2019 05:02:20 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74C82C0881
 for <iommu@lists.linux-foundation.org>; Fri, 13 Dec 2019 05:02:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 634E88705B
 for <iommu@lists.linux-foundation.org>; Fri, 13 Dec 2019 05:02:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sXhAy5XXG0oC for <iommu@lists.linux-foundation.org>;
 Fri, 13 Dec 2019 05:02:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 95BE886F55
 for <iommu@lists.linux-foundation.org>; Fri, 13 Dec 2019 05:02:18 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Dec 2019 21:02:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,308,1571727600"; d="scan'208";a="226175771"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
 ([10.239.159.136])
 by orsmga002.jf.intel.com with ESMTP; 12 Dec 2019 21:02:15 -0800
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix dmar pte read access not set error
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>,
 ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20191211014015.7898-1-baolu.lu@linux.intel.com>
 <20191212014952.vlrmxrk2cebwxjnp@cantor>
 <6f3bcad9-b9b3-b349-fdad-ce53a79a665b@linux.intel.com>
 <20191213003013.gc3zg3fpzpjntnzg@cantor>
 <7d58da5b-3f55-72b2-0638-ae561446d207@linux.intel.com>
 <20191213025159.kwf6f6zjmcjecamp@cantor>
 <20191213031633.zxccz5t5yyillxsb@cantor>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <0492b96f-6f57-b4f4-3862-07d9c23fdef9@linux.intel.com>
Date: Fri, 13 Dec 2019 13:01:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191213031633.zxccz5t5yyillxsb@cantor>
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

SGksCgpPbiAxMi8xMy8xOSAxMToxNiBBTSwgSmVycnkgU25pdHNlbGFhciB3cm90ZToKPiBPbiBU
aHUgRGVjIDEyIDE5LCBKZXJyeSBTbml0c2VsYWFyIHdyb3RlOgo+PiBPbiBGcmkgRGVjIDEzIDE5
LCBMdSBCYW9sdSB3cm90ZToKPj4+IEhpLAo+Pj4KPj4+IE9uIDEyLzEzLzE5IDg6MzAgQU0sIEpl
cnJ5IFNuaXRzZWxhYXIgd3JvdGU6Cj4+Pj4gT24gVGh1IERlYyAxMiAxOSwgTHUgQmFvbHUgd3Jv
dGU6Cj4+Pj4+IEhpLAo+Pj4+Pgo+Pj4+PiBPbiAxMi8xMi8xOSA5OjQ5IEFNLCBKZXJyeSBTbml0
c2VsYWFyIHdyb3RlOgo+Pj4+Pj4gT24gV2VkIERlYyAxMSAxOSwgTHUgQmFvbHUgd3JvdGU6Cj4+
Pj4+Pj4gSWYgdGhlIGRlZmF1bHQgRE1BIGRvbWFpbiBvZiBhIGdyb3VwIGRvZXNuJ3QgZml0IGEg
ZGV2aWNlLCBpdAo+Pj4+Pj4+IHdpbGwgc3RpbGwgc2l0IGluIHRoZSBncm91cCBidXQgdXNlIGEg
cHJpdmF0ZSBpZGVudGl0eSBkb21haW4uCj4+Pj4+Pj4gV2hlbiBtYXAvdW5tYXAvaW92YV90b19w
aHlzIGNvbWUgdGhyb3VnaCBpb21tdSBBUEksIHRoZSBkcml2ZXIKPj4+Pj4+PiBzaG91bGQgc3Rp
bGwgc2VydmUgdGhlbSwgb3RoZXJ3aXNlLCBvdGhlciBkZXZpY2VzIGluIHRoZSBzYW1lCj4+Pj4+
Pj4gZ3JvdXAgd2lsbCBiZSBpbXBhY3RlZC4gU2luY2UgaWRlbnRpdHkgZG9tYWluIGhhcyBiZWVu
IG1hcHBlZAo+Pj4+Pj4+IHdpdGggdGhlIHdob2xlIGF2YWlsYWJsZSBtZW1vcnkgc3BhY2UgYW5k
IFJNUlJzLCB3ZSBkb24ndCBuZWVkCj4+Pj4+Pj4gdG8gd29ycnkgYWJvdXQgdGhlIGltcGFjdCBv
biBpdC4KPj4+Pj4+Pgo+Pj4+Pj4+IExpbms6IGh0dHBzOi8vd3d3LnNwaW5pY3MubmV0L2xpc3Rz
L2lvbW11L21zZzQwNDE2Lmh0bWwKPj4+Pj4+PiBDYzogSmVycnkgU25pdHNlbGFhciA8anNuaXRz
ZWxAcmVkaGF0LmNvbT4KPj4+Pj4+PiBSZXBvcnRlZC1ieTogSmVycnkgU25pdHNlbGFhciA8anNu
aXRzZWxAcmVkaGF0LmNvbT4KPj4+Pj4+PiBGaXhlczogOTQyMDY3ZjFiNmI5NyAoImlvbW11L3Z0
LWQ6IElkZW50aWZ5IGRlZmF1bHQgZG9tYWlucyAKPj4+Pj4+PiByZXBsYWNlZCB3aXRoIHByaXZh
dGUiKQo+Pj4+Pj4+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnICMgdjUuMysKPj4+Pj4+PiBT
aWduZWQtb2ZmLWJ5OiBMdSBCYW9sdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPgo+Pj4+Pj4K
Pj4+Pj4+IFJldmlld2VkLWJ5OiBKZXJyeSBTbml0c2VsYWFyIDxqc25pdHNlbEByZWRoYXQuY29t
Pgo+Pj4+Pgo+Pj4+PiBDYW4geW91IHBsZWFzZSB0cnkgdGhpcyBmaXggYW5kIGNoZWNrIHdoZXRo
ZXIgaXQgY2FuIGZpeCB5b3VyIHByb2JsZW0/Cj4+Pj4+IElmIGl0IGhlbHBzLCBkbyB5b3UgbWlu
ZCBhZGRpbmcgYSBUZXN0ZWQtYnk/Cj4+Pj4+Cj4+Pj4+IEJlc3QgcmVnYXJkcywKPj4+Pj4gYmFv
bHUKPj4+Pj4KPj4+Pgo+Pj4+IEknbSB0ZXN0aW5nIHdpdGggdGhpcyBwYXRjaCwgbXkgcGF0Y2gg
dGhhdCBtb3ZlcyB0aGUgZGlyZWN0IG1hcHBpbmcgCj4+Pj4gY2FsbCwKPj4+PiBhbmQgQWxleCdz
IHBhdGNoIGZvciB0aGUgSVNBIGJyaWRnZS4gSXQgc29sdmVkIHRoZSAyIGlvbW11IG1hcHBpbmcg
Cj4+Pj4gZXJyb3JzCj4+Pj4gSSB3YXMgc2VlaW5nIHdpdGggZGVmYXVsdCBwYXNzdGhyb3VnaCwg
SSBubyBsb25nZXIgc2VlIGFsbCB0aGUgZG1hciBwdGUKPj4+PiByZWFkIGFjY2VzcyBlcnJvcnMs
IGFuZCB0aGUgc3lzdGVtIGJvb3RzIGFsbG93aW5nIG1lIHRvIGxvZ2luLiBJJ20gCj4+Pj4gdHJh
Y2tpbmcKPj4+PiBkb3duIDIgaXNzdWVzIGF0IHRoZSBtb21lbnQuIFdpdGggcGFzc3Rocm91Z2gg
SSBzZWUgYSBwcm9ibGVtIHdpdGggCj4+Pj4gMDE6MDAuNAo+Pj4+IHRoYXQgSSBtZW50aW9uZWQg
aW4gdGhlIGVhcmxpZXIgZW1haWw6Cj4+Pj4KPj4+PiBbwqDCoCA3OC45Nzg1NzNdIHVoY2lfaGNk
OiBVU0IgVW5pdmVyc2FsIEhvc3QgQ29udHJvbGxlciBJbnRlcmZhY2UgZHJpdmVyCj4+Pj4gW8Kg
wqAgNzguOTgwODQyXSB1aGNpX2hjZCAwMDAwOjAxOjAwLjQ6IFVIQ0kgSG9zdCBDb250cm9sbGVy
Cj4+Pj4gW8KgwqAgNzguOTgyNzM4XSB1aGNpX2hjZCAwMDAwOjAxOjAwLjQ6IG5ldyBVU0IgYnVz
IHJlZ2lzdGVyZWQsIAo+Pj4+IGFzc2lnbmVkIGJ1cyBudW1iZXIgMwo+Pj4+IFvCoMKgIDc4Ljk4
NTIyMl0gdWhjaV9oY2QgMDAwMDowMTowMC40OiBkZXRlY3RlZCA4IHBvcnRzCj4+Pj4gW8KgwqAg
NzguOTg2OTA3XSB1aGNpX2hjZCAwMDAwOjAxOjAwLjQ6IHBvcnQgY291bnQgbWlzZGV0ZWN0ZWQ/
IAo+Pj4+IGZvcmNpbmcgdG8gMiBwb3J0cwo+Pj4+IFvCoMKgIDc4Ljk4OTMxNl0gdWhjaV9oY2Qg
MDAwMDowMTowMC40OiBpcnEgMTYsIGlvIGJhc2UgMHgwMDAwM2MwMAo+Pj4+IFvCoMKgIDc4Ljk5
NDYzNF0gdWhjaV9oY2QgMDAwMDowMTowMC40OiBETUFSOiAzMmJpdCBETUEgdXNlcyAKPj4+PiBu
b24taWRlbnRpdHkgbWFwcGluZwo+Pj4+IFvCoMKgIDcgMDAwMDowMTowMC40OiB1bmFibGUgdG8g
YWxsb2NhdGUgY29uc2lzdGVudCBtZW1vcnkgZm9yIGZyYW1lIGxpc3QKPj4+PiBbwqDCoCA3OS40
OTk4OTFdIHVoY2lfaGNkIDAwMDA6MDE6MDAuNDogc3RhcnR1cCBlcnJvciAtMTYKPj4+PiBbwqDC
oCA3OS41MDE1ODhdIHVoY2lfaGNkIDAwMDA6MDE6MDAuNDogVVNCIGJ1cyAzIGRlcmVnaXN0ZXJl
ZAo+Pj4+IFvCoMKgIDc5LjUwMzQ5NF0gdWhjaV9oY2QgMDAwMDowMTowMC40OiBpbml0IDAwMDA6
MDE6MDAuNCBmYWlsLCAtMTYKPj4+PiBbwqDCoCA3OS41MDU0OTddIHVoY2lfaGNkOiBwcm9iZSBv
ZiAwMDAwOjAxOjAwLjQgZmFpbGVkIHdpdGggZXJyb3IgLTE2Cj4+Pj4KPj4+PiBJZiBJIGJvb3Qg
dGhlIHN5c3RlbSB3aXRoIGlvbW11PW5vcHQgSSBzZWUgYW4gaW9tbXUgbWFwIGZhaWx1cmUgZHVl
IHRvCj4+Pj4gdGhlIHByb3QgY2hlY2sgaW4gX19kb21haW5fbWFwcGluZzoKPj4+Pgo+Pj4+IFvC
oMKgIDQwLjk0MDU4OV0gcGNpIDAwMDA6MDA6MWYuMDogaW9tbXVfZ3JvdXBfYWRkX2RldmljZTog
Y2FsbGluZyAKPj4+PiBpb21tdV9ncm91cF9jcmVhdGVfZGlyZWN0X21hcHBpbmdzCj4+Pj4gW8Kg
wqAgNDAuOTQzNTU4XSBwY2kgMDAwMDowMDoxZi4wOiBpb21tdV9ncm91cF9jcmVhdGVfZGlyZWN0
X21hcHBpbmdzOiAKPj4+PiBpdGVyYXRpbmcgdGhyb3VnaCBtYXBwaW5ncwo+Pj4+IFvCoMKgIDQw
Ljk0NjQwMl0gcGNpIDAwMDA6MDA6MWYuMDogaW9tbXVfZ3JvdXBfY3JlYXRlX2RpcmVjdF9tYXBw
aW5nczogCj4+Pj4gY2FsbGluZyBhcHBseV9yZXN2X3JlZ2lvbgo+Pj4+IFvCoMKgIDQwLjk0OTE4
NF0gcGNpIDAwMDA6MDA6MWYuMDogaW9tbXVfZ3JvdXBfY3JlYXRlX2RpcmVjdF9tYXBwaW5nczog
Cj4+Pj4gZW50cnkgdHlwZSBpcyBkaXJlY3QKPj4+PiBbwqDCoCA0MC45NTE4MTldIERNQVI6IGlu
dGVsX2lvbW11X21hcDogZW50ZXIKPj4+PiBbwqDCoCA0MC45NTMxMjhdIERNQVI6IF9fZG9tYWlu
X21hcHBpbmc6IHByb3QgJiAKPj4+PiAoRE1BX1BURV9SRUFEfERNQV9QVEVfV1JJVEUpID09IDAK
Pj4+PiBbwqDCoCA0MC45NTU0ODZdIERNQVI6IGRvbWFpbl9tYXBwaW5nOiBfX2RvbWFpbl9tYXBw
aW5nIGZhaWxlZAo+Pj4+IFvCoMKgIDQwLjk1NzM0OF0gRE1BUjogaW50ZWxfaW9tbXVfbWFwOiBk
b21haW5fcGZuX21hcHBpbmcgcmV0dXJuZWQgLTIyCj4+Pj4gW8KgwqAgNDAuOTU5NDY2XSBETUFS
OiBpbnRlbF9pb21tdV9tYXA6IGxlYXZlCj4+Pj4gW8KgwqAgNDAuOTU5NDY4XSBpb21tdTogaW9t
bXVfbWFwOiBvcHMtPm1hcCBmYWlsZWQgaW92YSAweDAgcGEgCj4+Pj4gMHgwMDAwMDAwMDAwMDAw
MDAwIHBnc2l6ZSAweDEwMDAKPj4+PiBbwqDCoCA0MC45NjM1MTFdIHBjaSAwMDAwOjAwOjFmLjA6
IGlvbW11X2dyb3VwX2NyZWF0ZV9kaXJlY3RfbWFwcGluZ3M6IAo+Pj4+IGlvbW11X21hcCBmYWls
ZWQKPj4+PiBbwqDCoCA0MC45NjYwMjZdIHBjaSAwMDAwOjAwOjFmLjA6IGlvbW11X2dyb3VwX2Ny
ZWF0ZV9kaXJlY3RfbWFwcGluZ3M6IAo+Pj4+IGxlYXZpbmcgZnVuYwo+Pj4+IFvCoMKgIDQwLjk2
ODQ4N10gcGNpIDAwMDA6MDA6MWYuMDogaW9tbXVfZ3JvdXBfYWRkX2RldmljZTogY2FsbGluZyAK
Pj4+PiBfX2lvbW11X2F0dGFjaF9kZXZpY2UKPj4+PiBbwqDCoCA0MC45NzEwMTZdIHBjaSAwMDAw
OjAwOjFmLjA6IEFkZGluZyB0byBpb21tdSBncm91cCAxOQo+Pj4+IFvCoMKgIDQwLjk3MjczMV0g
cGNpIDAwMDA6MDA6MWYuMDogRE1BUjogZG9tYWluLT50eXBlIGlzIGRtYQo+Pj4+Cj4+Pj4gL3N5
cy9rZXJuZWwvaW9tbXVfZ3JvdXBzLzE5Cj4+Pj4gW3Jvb3RAaHAtZGwzODhnOC0wNyAxOV0jIGNh
dCByZXNlcnZlZF9yZWdpb25zIDB4MDAwMDAwMDAwMDAwMDAwMCAKPj4+PiAweDAwMDAwMDAwMDBm
ZmZmZmYgZGlyZWN0Cj4+Pj4gMHgwMDAwMDAwMGJkZjZlMDAwIDB4MDAwMDAwMDBiZGY4NGZmZiBk
aXJlY3QKPj4+PiAweDAwMDAwMDAwZmVlMDAwMDAgMHgwMDAwMDAwMGZlZWZmZmZmIG1zaQo+Pj4+
Cj4+Pj4gMDA6MWYuMCBJU0EgYnJpZGdlOiBJbnRlbCBDb3Jwb3JhdGlvbiBDNjAwL1g3OSBzZXJp
ZXMgY2hpcHNldCBMUEMgCj4+Pj4gQ29udHJvbGxlcgo+Pj4KPj4+IFRoaXMgc2VlbXMgdG8gYmUg
YW5vdGhlciBpc3N1ZT8KPj4+Cj4+PiBCZXN0IHJlZ2FyZHMsCj4+PiBiYW9sdQo+Pgo+PiBJbiBp
bnRlbF9pb21tdV9nZXRfcmVzdl9yZWdpb25zIHRoaXMgaW9tbXVfYWxsb2NfcmVzdl9yZWdpb24g
aXMgY2FsbGVkCj4+IHdpdGggcHJvdCBzZXQgdG8gMDoKPj4KPj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBpZiAoKHBkZXYtPmNsYXNzID4+IDgpID09IFBDSV9DTEFTU19CUklER0VfSVNB
KSB7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJlZyA9
IGlvbW11X2FsbG9jX3Jlc3ZfcmVnaW9uKDAsIDFVTCA8PCAyNCwgMCwKPj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKPj4gSU9NTVVfUkVTVl9E
SVJFQ1RfUkVMQVhBQkxFKTsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgaWYgKHJlZykKPj4KPiAKPiBMb29raW5nIGF0IHRoZSBvbGRlciBjb2RlIGZvciB0
aGUgSVNBIGJyaWRnZSBpdCBsb29rcyBsaWtlIGl0IGNhbGxlZAo+IGlvbW11X3ByZXBhcmVfaWRl
bnRpdHlfbWFwIC0+IGRvbWFpbl9wcmVwYXJlX2lkZW50aXR5X21hcCAtPgo+IGlvbW11X2RvbWFp
bl9pZGVudGl0eV9tYXAgLT4gYW5kIGZpbmFsbHkgX19kb21haW5fbWFwcGluZyB3aXRoIAo+IERN
QV9QVEVfUkVBRHxETUFfUFRFX1dSSVRFPwoKWWVzLiBSZXR1cm5pbmcgYSByZXNlcnZlZCByZWdp
b24gd2l0aG91dCBhbnkgYWNjZXNzIHBlcm1pc3Npb24gbWFrZXMgbm8Kc2Vuc2UuIENhbiB5b3Ug
cGxlYXNlIHBvc3QgYSBmaXggZm9yIHRoaXM/CgpCZXN0IHJlZ2FyZHMsCmJhb2x1Cl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlz
dAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
