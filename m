Return-Path: <SRS0=6I1K=SK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65CBC282DD
	for <iommu@archiver.kernel.org>; Mon,  8 Apr 2019 02:49:21 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADA4320863
	for <iommu@archiver.kernel.org>; Mon,  8 Apr 2019 02:49:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADA4320863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 701DDAD1;
	Mon,  8 Apr 2019 02:49:21 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 8A458ACD
	for <iommu@lists.linux-foundation.org>;
	Mon,  8 Apr 2019 02:49:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id BC724623
	for <iommu@lists.linux-foundation.org>;
	Mon,  8 Apr 2019 02:49:18 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
	by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	07 Apr 2019 19:49:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,323,1549958400"; d="scan'208";a="129433562"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
	([10.239.159.136])
	by orsmga007.jf.intel.com with ESMTP; 07 Apr 2019 19:49:16 -0700
Subject: Re: [PATCH v2 3/7] iommu/vt-d: Expose ISA direct mapping region via
	iommu_get_resv_regions
To: James Sewart <jamessewart@arista.com>
References: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
	<83B82113-8AE5-4B0C-A079-F389520525BD@arista.com>
	<F531CABB-FFDA-4E0A-A3D5-095FF338DD5A@arista.com>
	<b6b3dda7-31e3-c1e8-16cb-07feb7d5431d@linux.intel.com>
	<A489539F-4DD4-438A-AD9A-1A2F50404DB9@arista.com>
	<fb1565dc-d991-acf9-e275-c0090f69f47e@linux.intel.com>
	<445F31EA-20F3-481C-B1DF-8B163791FF8C@arista.com>
	<cf43d26b-f1ee-8469-c17a-e5c412dcfeab@linux.intel.com>
	<6C211BF1-B5A0-4821-AB42-092B573DE667@arista.com>
	<8B1FC0C7-9BAC-498D-B1F0-0138EACF75C2@arista.com>
	<ddcaa472-7bff-ddd3-0518-f2ba694b3279@linux.intel.com>
	<9AECB54A-2DA7-4ABD-A9B5-0549E108D1AF@arista.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <ea8b4315-4db2-00c9-66f7-fee6a4cd1a8c@linux.intel.com>
Date: Mon, 8 Apr 2019 10:43:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <9AECB54A-2DA7-4ABD-A9B5-0549E108D1AF@arista.com>
Content-Language: en-US
Cc: Dmitry Safonov <dima@arista.com>, Tom Murphy <tmurphy@arista.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190408024324.EGlKT7mc6SyYyvvIxU8ppGweOyvE6nhAmGWotidqcrE@z>

SGksCgpPbiA0LzYvMTkgMjowMiBBTSwgSmFtZXMgU2V3YXJ0IHdyb3RlOgo+IEhleSBMdSwKPiAK
PiBNeSBiYWQsIGRpZCBzb21lIGRlYnVnZ2luZyBvbiBteSBlbmQuIFRoZSBpc3N1ZSB3YXMgc3dh
cHBpbmcgb3V0Cj4gZmluZF9kb21haW4gZm9yIGlvbW11X2dldF9kb21haW5fZm9yX2Rldi4gSXQg
c2VlbXMgaW4gc29tZSBzaXR1YXRpb25zIHRoZQo+IGRvbWFpbiBpcyBub3QgYXR0YWNoZWQgdG8g
dGhlIGdyb3VwIGJ1dCB0aGUgZGV2aWNlIGlzIGV4cGVjdGVkIHRvIGhhdmUgdGhlCj4gZG9tYWlu
IHN0aWxsIHN0b3JlZCBpbiBpdHMgYXJjaGRhdGEuCj4gCj4gSeKAmXZlIGF0dGFjaGVkIHRoZSBm
aW5hbCBwYXRjaCB3aXRoIGZpbmRfZG9tYWluIHVucmVtb3ZlZCB3aGljaCBzZWVtcyB0bwo+IHdv
cmsgaW4gbXkgdGVzdGluZy4KClRoaXMgdmVyc2lvbiB3b3JrcyBmb3IgbWUgbm93LgoKPiAKPiBD
aGVlcnMsCj4gSmFtZXMuCgpCZXN0IHJlZ2FyZHMsCkx1IEJhb2x1Cgo+IAo+IAo+IAo+IAo+IAo+
PiBPbiA0IEFwciAyMDE5LCBhdCAwNzo0OSwgTHUgQmFvbHUgPGJhb2x1Lmx1QGxpbnV4LmludGVs
LmNvbT4gd3JvdGU6Cj4+Cj4+IEhpIEphbWVzLAo+Pgo+PiBJIGRpZCBhIHNhbml0eSB0ZXN0IGZy
b20gbXkgZW5kLiBUaGUgdGVzdCBtYWNoaW5lIGZhaWxzIHRvIGJvb3QuIEkKPj4gaGF2ZW4ndCBz
ZWVuIGFueSB2YWx1YWJsZSBrZXJuZWwgbG9nLiBJdCByZXN1bHRzIGluIGEgcHVycGxlIHNjcmVl
bi4KPj4KPj4gQmVzdCByZWdhcmRzLAo+PiBMdSBCYW9sdQo+Pgo+PiBPbiAzLzI5LzE5IDExOjI2
IFBNLCBKYW1lcyBTZXdhcnQgd3JvdGU6Cj4+PiBIZXkgTHUsCj4+PiBJ4oCZdmUgYXR0YWNoZWQg
YSBwcmVsaW1pbmFyeSB2MywgaWYgeW91IGNvdWxkIHRha2UgYSBsb29rIGFuZCBydW4gc29tZSB0
ZXN0cwo+Pj4gdGhhdCB3b3VsZCBiZSBncmVhdC4KPj4+IFNpbmNlIHYyIGnigJl2ZSBhZGRlZCB5
b3VyIGRlZmF1bHQgZG9tYWluIHR5cGUgcGF0Y2hlcywgdGhlIG5ldyBkZXZpY2VfZ3JvdXAKPj4+
IGhhbmRsZXIsIGFuZCBpbmNvcnBvcmF0ZWQgSmFjb2LigJlzIGZlZWRiYWNrLgo+Pj4+IE9uIDI4
IE1hciAyMDE5LCBhdCAxODozNywgSmFtZXMgU2V3YXJ0IDxqYW1lc3Nld2FydEBhcmlzdGEuY29t
PiB3cm90ZToKPj4+Pgo+Pj4+IEhleSBMdSwKPj4+Pgo+Pj4+PiBPbiAyNiBNYXIgMjAxOSwgYXQg
MDE6MjQsIEx1IEJhb2x1IDxiYW9sdS5sdUBsaW51eC5pbnRlbC5jb20+IHdyb3RlOgo+Pj4+Pgo+
Pj4+PiBIaSBKYW1lcywKPj4+Pj4KPj4+Pj4gT24gMy8yNS8xOSA4OjU3IFBNLCBKYW1lcyBTZXdh
cnQgd3JvdGU6Cj4+Pj4+Pj4+IFRoZXJlcyBhbiBpc3N1ZSB0aGF0IGlmIHdlIGNob29zZSB0byBh
bGxvYyBhIG5ldyByZXN2X3JlZ2lvbiB3aXRoIHR5cGUKPj4+Pj4+Pj4gSU9NTVVfUkVTVl9ESVJF
Q1QsIHdlIHdpbGwgbmVlZCB0byByZWZhY3RvciBpbnRlbF9pb21tdV9wdXRfcmVzdl9yZWdpb25z
Cj4+Pj4+Pj4+IHRvIGZyZWUgdGhpcyBlbnRyeSB0eXBlIHdoaWNoIG1lYW5zIHJlZmFjdG9yaW5n
IHRoZSBybXJyIHJlZ2lvbnMgaW4KPj4+Pj4+Pj4gZ2V0X3Jlc3ZfcmVnaW9ucy4gU2hvdWxkIHRo
aXMgd29yayBiZSBpbiB0aGlzIHBhdGNoc2V0Pwo+Pj4+Pj4+IERvIHlvdSBtZWFuIHRoZSBybXJy
IHJlZ2lvbnMgYXJlIG5vdCBhbGxvY2F0ZWQgaW4gZ2V0X3Jlc3ZfcmVnaW9ucywgYnV0Cj4+Pj4+
Pj4gYXJlIGZyZWVkIGluIHB1dF9yZXN2X3JlZ2lvbnM/IEkgdGhpbmsgd2Ugc2hvdWxkIGZpeCB0
aGlzIGluIHRoaXMgcGF0Y2gKPj4+Pj4+PiBzZXQgc2luY2UgdGhpcyBtaWdodCBpbXBhY3QgdGhl
IGRldmljZSBwYXNzdGhyb3VnaCBpZiB3ZSBkb24ndCBkbyBpdC4KPj4+Pj4+IFRoZXnigJlyZSBu
b3QgYWxsb2NhdGVkIGFuZCBub3QgZnJlZWQgY3VycmVudGx5LCBvbmx5IHR5cGUgSU9NTVVfUkVT
Vl9NU0kgaXMKPj4+Pj4+IGZyZWVkIGluIHB1dF9yZXN2X3JlZ2lvbnMuIElmIHdlIGFsbG9jYXRl
IGEgbmV3IHJlc3ZfcmVnaW9uIHdpdGggdHlwZQo+Pj4+Pj4gSU9NTVVfUkVTVl9ESVJFQ1QgZm9y
IHRoZSBpc2EgcmVnaW9uLCB0aGVuIGl0IHdvbuKAmXQgYmUgZnJlZWQuIElmIHdlIG1vZGlmeQo+
Pj4+Pj4gcHV0X3Jlc3ZfcmVnaW9ucyB0byBmcmVlIHR5cGUgSU9NTVVfUkVTVl9ESVJFQ1QsIHRo
ZW4gd2Ugd2lsbCB0cnkgdG8gZnJlZQo+Pj4+Pj4gdGhlIHN0YXRpYyBSTVJSIHJlZ2lvbnMuCj4+
Pj4+PiBFaXRoZXIgdGhlIElTQSByZWdpb24gaXMgc3RhdGljIGFuZCBub3QgZnJlZWQgYXMgd2l0
aCBteSBpbXBsZW1lbnRhdGlvbiwKPj4+Pj4+IG9yIHRoZSBSTVJSIHJlZ2lvbnMgYXJlIGNvbnZl
cnRlZCB0byBiZSBhbGxvY2F0ZWQgb24gZWFjaCBjYWxsIHRvCj4+Pj4+PiBnZXRfcmVzdl9yZWdp
b25zIGFuZCBmcmVlZCBpbiBwdXRfcmVzdl9yZWdpb25zLgo+Pj4+Pgo+Pj4+PiBCeSB0aGUgd2F5
LCB0aGVyZSdzIGFub3RoZXIgd2F5IGluIG15IG1pbmQuIExldCdzIGFkZCBhIG5ldyByZWdpb24g
dHlwZQo+Pj4+PiBmb3IgTFBDIGRldmljZXMsIGUueC4gSU9NTVVfUkVTVl9MUEMsIGFuZCB0aGVu
IGhhbmRsZSBpdCBpbiB0aGUgc2FtZSB3YXkKPj4+Pj4gYXMgdGhvc2UgTVNJIHJlZ2lvbnMuIEp1
c3QgRllJLgo+Pj4+Cj4+Pj4gVGhpcyBzb2x1dGlvbiB3b3VsZCByZXF1aXJlIGFkZGluZyBzb21l
IGV4dHJhIGNvZGUgdG8KPj4+PiBpb21tdV9ncm91cF9jcmVhdGVfZGlyZWN0X21hcHBpbmdzIGFz
IGN1cnJlbnRseSBvbmx5IHR5cGUKPj4+PiBJT01NVV9SRVNWX0RJUkVDVCBpcyBpZGVudGl0eSBt
YXBwZWQsIG90aGVyIHR5cGVzIGFyZSBvbmx5IHJlc2VydmVkLgo+Pj4+Cj4+Pj4KPj4+Pj4KPj4+
Pj4gQmVzdCByZWdhcmRzLAo+Pj4+PiBMdSBCYW9sdQo+Pj4+Cj4+Pj4gQ2hlZXJzLAo+Pj4+IEph
bWVzLgo+Pj4gQ2hlZXJzLAo+Pj4gSmFtZXMuCj4gCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby9pb21tdQ==
