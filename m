Return-Path: <SRS0=xVSy=SS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D511C10F12
	for <iommu@archiver.kernel.org>; Tue, 16 Apr 2019 02:24:58 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64B2420656
	for <iommu@archiver.kernel.org>; Tue, 16 Apr 2019 02:24:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64B2420656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 24955AD1;
	Tue, 16 Apr 2019 02:24:58 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A89EFAD0
	for <iommu@lists.linux-foundation.org>;
	Tue, 16 Apr 2019 02:24:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 9C3C85E4
	for <iommu@lists.linux-foundation.org>;
	Tue, 16 Apr 2019 02:24:55 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
	by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	15 Apr 2019 19:24:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,355,1549958400"; d="scan'208";a="131706467"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
	([10.239.159.136])
	by orsmga007.jf.intel.com with ESMTP; 15 Apr 2019 19:24:52 -0700
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
	<abbfecda-8990-315c-ac7a-7f571e86aba2@linux.intel.com>
	<1D51CB31-089A-4D71-A9C1-E54E50A56C46@arista.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <1b7d37da-5660-f635-cd2f-619e5573d35a@linux.intel.com>
Date: Tue, 16 Apr 2019 10:18:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1D51CB31-089A-4D71-A9C1-E54E50A56C46@arista.com>
Content-Language: en-US
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
	Dmitry Safonov <dima@arista.com>,
	Tom Murphy <tmurphy@arista.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
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
Message-ID: <20190416021851.sOFoMnrYG3MUxbVyZ4hUJB6NkFZonPCqMaMVHbdvJDU@z>

SGkgSmFtZXMsCgpPbiA0LzE1LzE5IDEwOjE2IFBNLCBKYW1lcyBTZXdhcnQgd3JvdGU6Cj4gSGV5
IEx1LAo+IAo+PiBPbiAxMCBBcHIgMjAxOSwgYXQgMDY6MjIsIEx1IEJhb2x1IDxiYW9sdS5sdUBs
aW51eC5pbnRlbC5jb20+IHdyb3RlOgo+Pgo+PiBIaSBKYW1lcywKPj4KPj4gT24gNC82LzE5IDI6
MDIgQU0sIEphbWVzIFNld2FydCB3cm90ZToKPj4+IEhleSBMdSwKPj4+IE15IGJhZCwgZGlkIHNv
bWUgZGVidWdnaW5nIG9uIG15IGVuZC4gVGhlIGlzc3VlIHdhcyBzd2FwcGluZyBvdXQKPj4+IGZp
bmRfZG9tYWluIGZvciBpb21tdV9nZXRfZG9tYWluX2Zvcl9kZXYuIEl0IHNlZW1zIGluIHNvbWUg
c2l0dWF0aW9ucyB0aGUKPj4+IGRvbWFpbiBpcyBub3QgYXR0YWNoZWQgdG8gdGhlIGdyb3VwIGJ1
dCB0aGUgZGV2aWNlIGlzIGV4cGVjdGVkIHRvIGhhdmUgdGhlCj4+PiBkb21haW4gc3RpbGwgc3Rv
cmVkIGluIGl0cyBhcmNoZGF0YS4KPj4+IEnigJl2ZSBhdHRhY2hlZCB0aGUgZmluYWwgcGF0Y2gg
d2l0aCBmaW5kX2RvbWFpbiB1bnJlbW92ZWQgd2hpY2ggc2VlbXMgdG8KPj4+IHdvcmsgaW4gbXkg
dGVzdGluZy4KPj4KPj4gSnVzdCBsb29rZWQgaW50byB5b3VyIHYzIHBhdGNoIHNldCBhbmQgc29t
ZSB0aG91Z2h0cyBmcm9tIG15IGVuZCBwb3N0ZWQKPj4gaGVyZSBqdXN0IGZvciB5b3VyIGluZm9y
bWF0aW9uLgo+Pgo+PiBMZXQgbWUgcG9zdCB0aGUgcHJvYmxlbXMgd2Ugd2FudCB0byBhZGRyZXNz
Lgo+Pgo+PiAxLiBXaGVuIGFsbG9jYXRpbmcgYSBuZXcgZ3JvdXAgZm9yIGEgZGV2aWNlLCBob3cg
c2hvdWxkIHdlIGRldGVybWluZSB0aGUKPj4gdHlwZSBvZiB0aGUgZGVmYXVsdCBkb21haW4/Cj4+
Cj4+IDIuIElmIHdlIG5lZWQgdG8gcHV0IGEgZGV2aWNlIGludG8gYW4gZXhpc3RpbmcgZ3JvdXAg
d2hpY2ggdXNlcyBhCj4+IGRpZmZlcmVudCB0eXBlIG9mIGRvbWFpbiBmcm9tIHdoYXQgdGhlIGRl
dmljZSBkZXNpcmVzIHRvIHVzZSwgd2UgbWlnaHQKPj4gYnJlYWsgdGhlIGZ1bmN0aW9uYWxpdHkg
b2YgdGhlIGRldmljZS4KPj4KPj4gTXkgbmV3IHRob3VnaHQgaXMgbGV0dGluZyB0aGUgaW9tbXUg
Z2VuZXJpYyBjb2RlIHRvIGRldGVybWluZSB0aGUKPj4gZGVmYXVsdCBkb21haW4gdHlwZSAoaGVu
Y2UgbXkgcHJvcG9zZWQgdmVuZG9yIHNwZWNpZmljIGRlZmF1bHQgZG9tYWluCj4+IHR5cGUgcGF0
Y2hlcyBjb3VsZCBiZSBkcm9wcGVkKS4KPj4KPj4gSWYgdGhlIGRlZmF1bHQgZG9tYWluIHR5cGUg
aXMgZHluYW1pY2FsIG1hcHBpbmcsIGFuZCBsYXRlciBpbiBpb21tdV9ub19tYXBwaW5nKCksIHdl
IGRldGVybWluZXMgdGhhdCB3ZSBtdXN0IHVzZSBhbiBpZGVudGl0eSBkb21haW4sCj4+IHdlIHRo
ZW4gY2FsbCBpb21tdV9yZXF1ZXN0X2RtX2Zvcl9kZXYoZGV2KS4KPj4KPj4gSWYgdGhlIGRlZmF1
bHQgZG9tYWluIHR5cGUgaXMgaWRlbnRpdHkgbWFwcGluZywgYW5kIGxhdGVyIGluCj4+IGlvbW11
X25vX21hcHBpbmcoKSwgd2UgZGV0ZXJtaW5lZCB0aGF0IHdlIG11c3QgdXNlIGEgZHluYW1pY2Fs
IGRvbWFpbiwKPj4gd2UgdGhlbiBjYWxsIGlvbW11X3JlcXVlc3RfZG1hX2RvbWFpbl9mb3JfZGV2
KGRldikuCj4+Cj4+IFdlIGFscmVhZHkgaGF2ZSBpb21tdV9yZXF1ZXN0X2RtX2Zvcl9kZXYoKSBp
biBpb21tdS5jLiBXZSBvbmx5IG5lZWQgdG8KPj4gaW1wbGVtZW50IGlvbW11X3JlcXVlc3RfZG1h
X2RvbWFpbl9mb3JfZGV2KCkuCj4+Cj4+IFdpdGggdGhpcyBkb25lLCB5b3VyIHBhdGNoIHRpdGxl
ZCAiQ3JlYXRlIGFuIElPTU1VIGdyb3VwIGZvciBkZXZpY2VzCj4+IHRoYXQgcmVxdWlyZSBhbiBp
ZGVudGl0eSBtYXAiIGNvdWxkIGFsc28gYmUgZHJvcHBlZC4KPj4KPj4gQW55IHRob3VnaHRzPwo+
IAo+IFRoZXJlcyBhIGNvdXBsZSBpc3N1ZXMgSSBjYW4gdGhpbmsgb2YuIGlvbW11X3JlcXVlc3Rf
ZG1fZm9yX2RldiBjaGFuZ2VzCj4gdGhlIGRvbWFpbiBmb3IgYWxsIGRldmljZXMgd2l0aGluIHRo
ZSBkZXZpY2VzIGdyb3VwLCBpZiB3ZSBtYXkgaGF2ZQo+IGRldmljZXMgd2l0aCBkaWZmZXJlbnQg
ZG9tYWluIHJlcXVpcmVtZW50cyBpbiB0aGUgc2FtZSBncm91cCB0aGVuIG9ubHkgdGhlCj4gbGFz
dCBpbml0aWFsaXNlZCBkZXZpY2Ugd2lsbCBnZXQgdGhlIGRvbWFpbiBpdCB3YW50cy4gSWYgd2Ug
d2FudCB0byBhZGQKPiBpb21tdV9yZXF1ZXN0X2RtYV9kb21haW5fZm9yX2RldiB0aGVuIHdlIHdv
dWxkIHN0aWxsIG5lZWQgYW5vdGhlciBJT01NVQo+IGdyb3VwIGZvciBpZGVudGl0eSBkb21haW4g
ZGV2aWNlcy4KCkN1cnJlbnQgc29sdXRpb24gKGEuay5hLiB2MykgZm9yIHRoaXMgaXMgdG8gYXNz
aWduIGEgbmV3IGdyb3VwIHRvIHRoZQpkZXZpY2Ugd2hpY2ggcmVxdWlyZXMgYW4gaWRlbnRpdHkg
bWFwcGVkIGRvbWFpbi4gVGhpcyB3aWxsIGJyZWFrIHRoZQpmdW5jdGlvbmFsaXR5IG9mIGRldmlj
ZSBkaXJlY3QgcGFzcy10aHJvdWdoICh0byB1c2VyIGxldmVsKS4gVGhlIGlvbW11Cmdyb3VwIHJl
cHJlc2VudHMgdGhlIG1pbmltdW0gZ3JhbnVsYXJpdHkgb2YgaW9tbXUgaXNvbGF0aW9uIGFuZApw
cm90ZWN0aW9uLiBUaGUgcmVxdWlyZW1lbnQgb2YgaWRlbnRpdHkgbWFwcGVkIGRvbWFpbiBzaG91
bGQgbm90IGJlIGEKZmFjdG9yIGZvciBhIG5ldyBncm91cC4KCkJvdGggaW9tbV9yZXF1ZXN0X2Rt
YV9kb21haW5fZm9yX2RldigpIG9yIGlvbW11X3JlcXVlc3RfZG1fZm9yX2RldigpCm9ubHkgc3Vw
cG9ydCBncm91cHMgd2l0aCBhIHNpbmdsZSBkZXZpY2UgaW4gaXQuCgpUaGUgdXNlcnMgY291bGQg
Y2hvb3NlIGJldHdlZW4gZG9tYWlucyBvZiBETUEgdHlwZSBvciBJREVOVElUWSB0eXBlIGZvcgph
IGdyb3VwLiBJZiBtdWx0aXBsZSBkZXZpY2VzIHNoYXJlIGEgc2luZ2xlIGdyb3VwIGFuZCBib3Ro
IGRvbid0IHdvcmsKZm9yIHRoZW0sIHRoZXkgaGF2ZSB0byBkaXNhYmxlIHRoZSBJT01NVS4gVGhp
cyBpc24ndCBhIHZhbGlkCmNvbmZpZ3VyYXRpb24gZnJvbSBJT01NVSdzIHBvaW50IG9mIHZpZXcu
Cgo+IAo+IEJvdGggd2l0aCB2MyBhbmQgdGhlIHByb3Bvc2VkIG1ldGhvZCBoZXJlLCBpb21tdV9z
aG91bGRfaWRlbnRpdHlfbWFwIGlzCj4gZGV0ZXJtaW5pbmcgd2hldGhlciB0aGUgZGV2aWNlIHJl
cXVpcmVzIGFuIGlkZW50aXR5IG1hcC4gSW4gdjMgdGhpcyBpcwo+IGNhbGxlZCBvbmNlIHVwIGZy
b250IGJ5IHRoZSBnZW5lcmljIGNvZGUgdG8gZGV0ZXJtaW5lIGZvciB0aGUgSU9NTVUgZ3JvdXAK
PiB3aGljaCBkb21haW4gdHlwZSB0byB1c2UuIEluIHRoZSBwcm9wb3NlZCBtZXRob2QgSSB0aGlu
ayB0aGlzIHdvdWxkIGhhcHBlbgo+IGFmdGVyIGluaXRpYWwgZG9tYWluIGFsbG9jYXRpb24gYW5k
IHdvdWxkIHRyaWdnZXIgdGhlIGRvbWFpbiB0byBiZQo+IHJlcGxhY2VkIHdpdGggYSBkaWZmZXJl
bnQgZG9tYWluLgo+IAo+IEkgcHJlZmVyIHRoZSBzb2x1dGlvbiBpbiB2My4gV2hhdCBkbyB5b3Ug
dGhpbms/CgpUaGUgb25seSBjb25jZXJuIG9mIHNvbHV0aW9uIGluIHYzIGZyb20gbXkgcG9pbnQg
b2YgdmlldyBpcyBzb21lIGtpbmQgb2YKZHVwbGljYXRpb24uIEV2ZW4gd2UgY2FuIGFzayB0aGUg
SW50ZWwgSU9NTVUgZHJpdmVyIHRvIHRlbGwgdGhlIGRlZmF1bHQKZG9tYWluIHR5cGUsIHdlIG1p
Z2h0IGNoYW5nZSBpdCBhZnRlciBib290IHVwLiBGb3IgZXhhbXBsZSwgZm9yIDMyLWJpdApwY2kg
ZGV2aWNlcywgd2UgZG9uJ3Qga25vdyB3aGV0aGVyIGl0J3MgNjQtYml0IG9yIDMyLWJpdCBjYXBh
YmxlIGR1cmluZwpJT01NVSBpbml0aWFsaXphdGlvbiwgc28gd2UgbWlnaHQgdGVsbCBpb21tdS5j
IHRvIHVzZSBpZGVudGl0eSBtYXBwZWQKZG9tYWluLiBBZnRlciBib290IHVwLCB3ZSBjaGVjayBp
dCBhZ2FpbiwgYW5kIGZpbmQgb3V0IHRoYXQgaXQncyBvbmx5CjMyLWJpdCBjYXBhYmxlIChoZW5j
ZSBvbmx5IGNhbiBhY2Nlc3MgcGh5c2ljYWwgbWVtb3J5IGJlbG93IDRHKSBhbmQgdGhlCmRlZmF1
bHQgaWRlbnRpdHkgZG9tYWluIGRvZXNuJ3Qgd29yay4gQW5kIHdlIGhhdmUgdG8gY2hhbmdlIGl0
IHRvIERNQQpkb21haW4gdmlhIGlvbW11X3JlcXVlc3RfZG1hX2RvbWFpbl9mb3JfZGV2KCkuCgpT
byB0byBtYWtlIGl0IHNpbXBsZSBhbmQgc3RyYWlnaHQtZm9yd2FyZCwgd2UgY2FuIGp1c3QgbGV0
IGlvbW11LmMgdG8KZGV0ZXJtaW5lIHRoZSBkZWZhdWx0IGRvbWFpbiB0eXBlIGFuZCBhZnRlciB0
aGF0IHRoZSBJbnRlbCBJT01NVSBkcml2ZXIKY291bGQgdHdlYWsgaXQgYWNjb3JkaW5nIHRvIHRo
ZSBxdWlyayBiaXRzIGluIHRoZSBkcml2ZXIuCgpCZXN0IHJlZ2FyZHMsCkx1IEJhb2x1Cl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcg
bGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
