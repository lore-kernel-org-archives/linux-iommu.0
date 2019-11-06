Return-Path: <SRS0=/wjm=Y6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE248C5DF64
	for <iommu@archiver.kernel.org>; Wed,  6 Nov 2019 14:09:38 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93DBA2067B
	for <iommu@archiver.kernel.org>; Wed,  6 Nov 2019 14:09:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93DBA2067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 3FF11CCE;
	Wed,  6 Nov 2019 14:09:38 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C34A3CA8
	for <iommu@lists.linux-foundation.org>;
	Wed,  6 Nov 2019 14:09:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id F22698B8
	for <iommu@lists.linux-foundation.org>;
	Wed,  6 Nov 2019 14:09:33 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 106DC30E;
	Wed,  6 Nov 2019 06:09:32 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 346943F6C4;
	Wed,  6 Nov 2019 06:09:31 -0800 (PST)
Subject: Re: Bug 205201 - overflow of DMA mask and bus mask
To: Christoph Hellwig <hch@lst.de>, Christian Zigotzky <chzigotzky@xenosoft.de>
References: <20181213112511.GA4574@lst.de>
	<e109de27-f4af-147d-dc0e-067c8bafb29b@xenosoft.de>
	<ad5a5a8a-d232-d523-a6f7-e9377fc3857b@xenosoft.de>
	<e60d6ca3-860c-f01d-8860-c5e022ec7179@xenosoft.de>
	<008c981e-bdd2-21a7-f5f7-c57e4850ae9a@xenosoft.de>
	<20190103073622.GA24323@lst.de>
	<71A251A5-FA06-4019-B324-7AED32F7B714@xenosoft.de>
	<1b0c5c21-2761-d3a3-651b-3687bb6ae694@xenosoft.de>
	<3504ee70-02de-049e-6402-2d530bf55a84@xenosoft.de>
	<46025f1b-db20-ac23-7dcd-10bc43bbb6ee@xenosoft.de>
	<20191105162856.GA15402@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <8b239ba6-29f3-9483-8696-ddfba2a49a49@arm.com>
Date: Wed, 6 Nov 2019 14:09:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
	Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191105162856.GA15402@lst.de>
Content-Language: en-GB
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

T24gMDUvMTEvMjAxOSAxNjoyOCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4gT24gVHVlLCBO
b3YgMDUsIDIwMTkgYXQgMDg6NTY6MjdBTSArMDEwMCwgQ2hyaXN0aWFuIFppZ290emt5IHdyb3Rl
Ogo+PiBIaSBBbGwsCj4+Cj4+IFdlIHN0aWxsIGhhdmUgRE1BIHByb2JsZW1zIHdpdGggc29tZSBQ
Q0kgZGV2aWNlcy4gU2luY2UgdGhlIFBvd2VyUEMgdXBkYXRlcwo+PiA0LjIxLTEgWzFdIHdlIG5l
ZWQgdG8gZGVjcmVhc2UgdGhlIFJBTSB0byAzNTAwTUIgKG1lbT0zNTAwTSkgaWYgd2Ugd2FudCB0
bwo+PiB3b3JrIHdpdGggb3VyIFBDSSBkZXZpY2VzLiBUaGUgRlNMIFA1MDIwIGFuZCBQNTA0MCBo
YXZlIHRoZXNlIHByb2JsZW1zCj4+IGN1cnJlbnRseS4KPj4KPj4gRXJyb3IgbWVzc2FnZToKPj4K
Pj4gW8KgwqAgMjUuNjU0ODUyXSBidHR2IDEwMDA6MDQ6MDUuMDogb3ZlcmZsb3cgMHgwMDAwMDAw
MGZlMDc3MDAwKzQwOTYgb2YgRE1BCj4+IG1hc2sgZmZmZmZmZmYgYnVzIG1hc2sgZGYwMDAwMDAK
CkhtbSwgdGhhdCBidXMgbWFzayBsb29rcyBwcmV0dHkgd2Fja3kgLSBhcmUgeW91IGFibGUgdG8g
ZmlndXJlIG91dCB3aGVyZSAKdGhhdCdzIGNvbWluZyBmcm9tPwoKUm9iaW4uCgo+PiBBbGwgNS54
IExpbnV4IGtlcm5lbHMgY2FuJ3QgaW5pdGlhbGl6ZSBhIFNDU0kgUENJIGNhcmQgYW55bW9yZSBz
byBib290aW5nCj4+IG9mIGEgTGludXggdXNlcmxhbmQgaXNuJ3QgcG9zc2libGUuCj4+Cj4+IFBM
RUFTRSBjaGVjayB0aGUgRE1BIGNoYW5nZXMgaW4gdGhlIFBvd2VyUEMgdXBkYXRlcyA0LjIxLTEg
WzFdLiBUaGUga2VybmVsCj4+IDQuMjAgd29ya3Mgd2l0aCBhbGwgUENJIGRldmljZXMgd2l0aG91
dCBsaW1pdGF0aW9uIG9mIFJBTS4KPiAKPiBDYW4geW91IHNlbmQgbWUgdGhlIC5jb25maWcgYW5k
IGEgZG1lc2c/ICBBbmQgaW4gdGhlIG1lYW50aW1lIHRyeSB0aGUKPiBwYXRjaCBiZWxvdz8KPiAK
PiAtLS0KPiAgRnJvbSA0ZDY1OWI3MzExYmQ0MTQxZmRkM2VlZWI4MGZhMmQ3NjAyZWEwMWQ0IE1v
biBTZXAgMTcgMDA6MDA6MDAgMjAwMQo+IEZyb206IE5pY29sYXMgU2FlbnogSnVsaWVubmUgPG5z
YWVuemp1bGllbm5lQHN1c2UuZGU+Cj4gRGF0ZTogRnJpLCAxOCBPY3QgMjAxOSAxMzowMDo0MyAr
MDIwMAo+IFN1YmplY3Q6IGRtYS1kaXJlY3Q6IGNoZWNrIGZvciBvdmVyZmxvd3Mgb24gMzIgYml0
IERNQSBhZGRyZXNzZXMKPiAKPiBBcyBzZWVuIG9uIHRoZSBuZXcgUmFzcGJlcnJ5IFBpIDQgYW5k
IHN0YTJ4MTEncyBETUEgaW1wbGVtZW50YXRpb24gaXQgaXMKPiBwb3NzaWJsZSBmb3IgYSBkZXZp
Y2UgY29uZmlndXJlZCB3aXRoIDMyIGJpdCBETUEgYWRkcmVzc2VzIGFuZCBhIHBhcnRpYWwKPiBE
TUEgbWFwcGluZyBsb2NhdGVkIGF0IHRoZSBlbmQgb2YgdGhlIGFkZHJlc3Mgc3BhY2UgdG8gb3Zl
cmZsb3cuIEl0Cj4gaGFwcGVucyB3aGVuIGEgaGlnaGVyIHBoeXNpY2FsIGFkZHJlc3MsIG5vdCBE
TUFhYmxlLCBpcyB0cmFuc2xhdGVkIHRvCj4gaXQncyBETUEgY291bnRlcnBhcnQuCj4gCj4gRm9y
IGV4YW1wbGUgdGhlIFJhc3BiZXJyeSBQaSA0LCBjb25maWd1cmFibGUgdXAgdG8gNCBHQiBvZiBt
ZW1vcnksIGhhcwo+IGFuIGludGVyY29ubmVjdCBjYXBhYmxlIG9mIGFkZHJlc3NpbmcgdGhlIGxv
d2VyIDEgR0Igb2YgcGh5c2ljYWwgbWVtb3J5Cj4gd2l0aCBhIERNQSBvZmZzZXQgb2YgMHhjMDAw
MDAwMC4gSXQgdHJhbnNwaXJlcyB0aGF0LCBhbnkgYXR0ZW1wdCB0bwo+IHRyYW5zbGF0ZSBwaHlz
aWNhbCBhZGRyZXNzZXMgaGlnaGVyIHRoYW4gdGhlIGZpcnN0IEdCIHdpbGwgcmVzdWx0IGluIGFu
Cj4gb3ZlcmZsb3cgd2hpY2ggZG1hX2NhcGFibGUoKSBjYW4ndCBkZXRlY3QgYXMgaXQgb25seSBj
aGVja3MgZm9yCj4gYWRkcmVzc2VzIGJpZ2dlciB0aGVuIHRoZSBtYXhpbXVtIGFsbG93ZWQgRE1B
IGFkZHJlc3MuCj4gCj4gRml4IHRoaXMgYnkgdmVyaWZ5aW5nIGluIGRtYV9jYXBhYmxlKCkgaWYg
dGhlIERNQSBhZGRyZXNzIHJhbmdlIHByb3ZpZGVkCj4gaXMgYXQgYW55IHBvaW50IGxvd2VyIHRo
YW4gdGhlIG1pbmltdW0gcG9zc2libGUgRE1BIGFkZHJlc3Mgb24gdGhlIGJ1cy4KPiAKPiBTaWdu
ZWQtb2ZmLWJ5OiBOaWNvbGFzIFNhZW56IEp1bGllbm5lIDxuc2FlbnpqdWxpZW5uZUBzdXNlLmRl
Pgo+IC0tLQo+ICAgaW5jbHVkZS9saW51eC9kbWEtZGlyZWN0LmggfCA4ICsrKysrKysrCj4gICAx
IGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspCj4gCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUv
bGludXgvZG1hLWRpcmVjdC5oIGIvaW5jbHVkZS9saW51eC9kbWEtZGlyZWN0LmgKPiBpbmRleCBh
ZGY5OTNhM2JkNTguLjZhZDllOWVhNzU2NCAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2xpbnV4L2Rt
YS1kaXJlY3QuaAo+ICsrKyBiL2luY2x1ZGUvbGludXgvZG1hLWRpcmVjdC5oCj4gQEAgLTMsNiAr
Myw3IEBACj4gICAjZGVmaW5lIF9MSU5VWF9ETUFfRElSRUNUX0ggMQo+ICAgCj4gICAjaW5jbHVk
ZSA8bGludXgvZG1hLW1hcHBpbmcuaD4KPiArI2luY2x1ZGUgPGxpbnV4L21lbWJsb2NrLmg+IC8q
IGZvciBtaW5fbG93X3BmbiAqLwo+ICAgI2luY2x1ZGUgPGxpbnV4L21lbV9lbmNyeXB0Lmg+Cj4g
ICAKPiAgICNpZmRlZiBDT05GSUdfQVJDSF9IQVNfUEhZU19UT19ETUEKPiBAQCAtMjcsNiArMjgs
MTMgQEAgc3RhdGljIGlubGluZSBib29sIGRtYV9jYXBhYmxlKHN0cnVjdCBkZXZpY2UgKmRldiwg
ZG1hX2FkZHJfdCBhZGRyLCBzaXplX3Qgc2l6ZSkKPiAgIAlpZiAoIWRldi0+ZG1hX21hc2spCj4g
ICAJCXJldHVybiBmYWxzZTsKPiAgIAo+ICsjaWZuZGVmIENPTkZJR19BUkNIX0RNQV9BRERSX1Rf
NjRCSVQKPiArCS8qIENoZWNrIGlmIERNQSBhZGRyZXNzIG92ZXJmbG93ZWQgKi8KPiArCWlmICht
aW4oYWRkciwgYWRkciArIHNpemUgLSAxKSA8Cj4gKwkJX19waHlzX3RvX2RtYShkZXYsIChwaHlz
X2FkZHJfdCkobWluX2xvd19wZm4gPDwgUEFHRV9TSElGVCkpKQo+ICsJCXJldHVybiBmYWxzZTsK
PiArI2VuZGlmCj4gKwo+ICAgCXJldHVybiBhZGRyICsgc2l6ZSAtIDEgPD0KPiAgIAkJbWluX25v
dF96ZXJvKCpkZXYtPmRtYV9tYXNrLCBkZXYtPmJ1c19kbWFfbWFzayk7Cj4gICB9Cj4gCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcg
bGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
