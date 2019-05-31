Return-Path: <SRS0=mJb0=T7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071E6C04AB6
	for <iommu@archiver.kernel.org>; Fri, 31 May 2019 10:44:18 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4E96267A7
	for <iommu@archiver.kernel.org>; Fri, 31 May 2019 10:44:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4E96267A7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 76762FF8;
	Fri, 31 May 2019 10:44:17 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D95C7FE0
	for <iommu@lists.linux-foundation.org>;
	Fri, 31 May 2019 10:43:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 31C246C5
	for <iommu@lists.linux-foundation.org>;
	Fri, 31 May 2019 10:43:13 +0000 (UTC)
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
	by Forcepoint Email with ESMTP id 9228C33A72539724796A;
	Fri, 31 May 2019 18:43:10 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS409-HUB.china.huawei.com
	(10.3.19.209) with Microsoft SMTP Server id 14.3.439.0;
	Fri, 31 May 2019 18:42:59 +0800
Subject: Re: [PATCH v8 1/7] iommu: enhance IOMMU default DMA mode build options
To: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>, "Jean-Philippe
	Brucker" <jean-philippe.brucker@arm.com>, Robin Murphy
	<robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Joerg Roedel
	<joro@8bytes.org>, "Jonathan Corbet" <corbet@lwn.net>, linux-doc
	<linux-doc@vger.kernel.org>, Sebastian Ott <sebott@linux.ibm.com>, Gerald
	Schaefer <gerald.schaefer@de.ibm.com>, "Martin Schwidefsky"
	<schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
	<paulus@samba.org>, "Michael Ellerman" <mpe@ellerman.id.au>, Tony Luck
	<tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, David Woodhouse
	<dwmw2@infradead.org>, iommu <iommu@lists.linux-foundation.org>,
	linux-kernel
	<linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, x86 <x86@kernel.org>,
	linux-ia64 <linux-ia64@vger.kernel.org>
References: <20190530034831.4184-1-thunder.leizhen@huawei.com>
	<20190530034831.4184-2-thunder.leizhen@huawei.com>
	<645bd526-4eb0-4a36-2dda-023f009247ab@huawei.com>
	<030bafab-58f5-8bb1-0533-2977d6e138b2@huawei.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <55d0e30c-5bca-41fc-5bf0-4366dc387afd@huawei.com>
Date: Fri, 31 May 2019 11:42:45 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
	Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <030bafab-58f5-8bb1-0533-2977d6e138b2@huawei.com>
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Cc: Linuxarm <linuxarm@huawei.com>, Hanjun Guo <guohanjun@huawei.com>
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

Cj4+PiAtY29uZmlnIElPTU1VX0RFRkFVTFRfUEFTU1RIUk9VR0gKPj4+IC0gICAgYm9vbCAiSU9N
TVUgcGFzc3Rocm91Z2ggYnkgZGVmYXVsdCIKPj4+ICtjaG9pY2UKPj4+ICsgICAgcHJvbXB0ICJJ
T01NVSBkZWZhdWx0IERNQSBtb2RlIgo+Pj4gICAgICBkZXBlbmRzIG9uIElPTU1VX0FQSQo+Pj4g
LSAgICAgICAgaGVscAo+Pj4gLSAgICAgIEVuYWJsZSBwYXNzdGhyb3VnaCBieSBkZWZhdWx0LCBy
ZW1vdmluZyB0aGUgbmVlZCB0byBwYXNzIGluCj4+PiAtICAgICAgaW9tbXUucGFzc3Rocm91Z2g9
b24gb3IgaW9tbXU9cHQgdGhyb3VnaCBjb21tYW5kIGxpbmUuIElmIHRoaXMKPj4+IC0gICAgICBp
cyBlbmFibGVkLCB5b3UgY2FuIHN0aWxsIGRpc2FibGUgd2l0aCBpb21tdS5wYXNzdGhyb3VnaD1v
ZmYKPj4+IC0gICAgICBvciBpb21tdT1ub3B0IGRlcGVuZGluZyBvbiB0aGUgYXJjaGl0ZWN0dXJl
Lgo+Pj4gKyAgICBkZWZhdWx0IElPTU1VX0RFRkFVTFRfU1RSSUNUCj4+PiArICAgIGhlbHAKPj4+
ICsgICAgICBUaGlzIG9wdGlvbiBhbGxvd3MgSU9NTVUgRE1BIG1vZGUgdG8gYmUgY2hvc2UgYXQg
YnVpbGQgdGltZSwgdG8KPj4KPj4gQXMgYmVmb3JlOgo+PiAvcy9jaG9zZS9jaG9zZW4vLCAvcy9h
bGxvd3MgSU9NTVUvYWxsb3dzIGFuIElPTU1VLwo+IEknbSBzb3JyeSB0aGF0IHRoZSBwcmV2aW91
cyB2ZXJzaW9uIHdhcyBub3QgbW9kaWZpZWQuCj4KPj4KPj4+ICsgICAgICBvdmVycmlkZSB0aGUg
ZGVmYXVsdCBETUEgbW9kZSBvZiBlYWNoIEFSQ0hzLCByZW1vdmluZyB0aGUgbmVlZCB0bwo+Pgo+
PiBBZ2FpbiwgYXMgYmVmb3JlOgo+PiBBUkNIcyBzaG91bGQgYmUgc2luZ3VsYXIKPiBPSwo+Cj4+
Cj4+PiArICAgICAgcGFzcyBpbiBrZXJuZWwgcGFyYW1ldGVycyB0aHJvdWdoIGNvbW1hbmQgbGlu
ZS4gWW91IGNhbiBzdGlsbCB1c2UKPj4+ICsgICAgICBBUkNIcyBzcGVjaWZpYyBib290IG9wdGlv
bnMgdG8gb3ZlcnJpZGUgdGhpcyBvcHRpb24gYWdhaW4uCgoqCgo+Pj4gKwo+Pj4gK2NvbmZpZyBJ
T01NVV9ERUZBVUxUX1BBU1NUSFJPVUdICj4+PiArICAgIGJvb2wgInBhc3N0aHJvdWdoIgo+Pj4g
KyAgICBoZWxwCj4+PiArICAgICAgSW4gdGhpcyBtb2RlLCB0aGUgRE1BIGFjY2VzcyB0aHJvdWdo
IElPTU1VIHdpdGhvdXQgYW55IGFkZHJlc3Nlcwo+Pj4gKyAgICAgIHRyYW5zbGF0aW9uLiBUaGF0
IG1lYW5zLCB0aGUgd3Jvbmcgb3IgaWxsZWdhbCBETUEgYWNjZXNzIGNhbiBub3QKPj4+ICsgICAg
ICBiZSBjYXVnaHQsIG5vIGVycm9yIGluZm9ybWF0aW9uIHdpbGwgYmUgcmVwb3J0ZWQuCj4+Pgo+
Pj4gICAgICAgIElmIHVuc3VyZSwgc2F5IE4gaGVyZS4KPj4+Cj4+PiArY29uZmlnIElPTU1VX0RF
RkFVTFRfTEFaWQo+Pj4gKyAgICBib29sICJsYXp5Igo+Pj4gKyAgICBoZWxwCj4+PiArICAgICAg
U3VwcG9ydCBsYXp5IG1vZGUsIHdoZXJlIGZvciBldmVyeSBJT01NVSBETUEgdW5tYXAgb3BlcmF0
aW9uLCB0aGUKPj4+ICsgICAgICBmbHVzaCBvcGVyYXRpb24gb2YgSU9UTEIgYW5kIHRoZSBmcmVl
IG9wZXJhdGlvbiBvZiBJT1ZBIGFyZSBkZWZlcnJlZC4KPj4+ICsgICAgICBUaGV5IGFyZSBvbmx5
IGd1YXJhbnRlZWQgdG8gYmUgZG9uZSBiZWZvcmUgdGhlIHJlbGF0ZWQgSU9WQSB3aWxsIGJlCj4+
PiArICAgICAgcmV1c2VkLgo+Pgo+PiB3aHkgbm8gYWR2aXNvcnkgb24gaG93IHRvIHNldCBpZiB1
bnN1cmU/Cj4gQmVjYXVzZSB0aGUgTEFaWSBhbmQgU1RSSUNUIGhhdmUgdGhlaXIgb3duIGFkdmFu
dGFnZXMgYW5kIGRpc2FkdmFudGFnZXMuCj4KPiBTaG91bGQgSSBzYXk6IElmIHVuc3VyZSwga2Vl
cCB0aGUgZGVmYXVsdOOAggoKTWF5YmUuIFNvIHlvdSBjb3VsZCBwdXQgdGhpcyBpbiB0aGUgaGVs
cCBmb3IgdGhlIGNob2ljZSwgKiBhYm92ZSwgYW5kIApyZW1vdmUgdGhlIGFkdmlzb3J5IG9uIElP
TU1VX0RFRkFVTFRfUEFTU1RIUk9VR0guCgpIb3dldmVyIHRoZSBtYWludGFpbmVyIG1heSBoYXZl
IGEgZGlmZmVyZW50IHZpZXcuCgpUaGFua3MsCkpvaG4KCj4KPj4KPj4+ICsKPj4+ICtjb25maWcg
SU9NTVVfREVGQVVMVF9TVFJJQ1QKPj4+ICsgICAgYm9vbCAic3RyaWN0Igo+Pj4gKyAgICBoZWxw
Cj4+PiArICAgICAgRm9yIGV2ZXJ5IElPTU1VIERNQSB1bm1hcCBvcGVyYXRpb24sIHRoZSBmbHVz
aCBvcGVyYXRpb24gb2YgSU9UTEIgYW5kCj4+PiArICAgICAgdGhlIGZyZWUgb3BlcmF0aW9uIG9m
IElPVkEgYXJlIGd1YXJhbnRlZWQgdG8gYmUgZG9uZSBpbiB0aGUgdW5tYXAKPj4+ICsgICAgICBm
dW5jdGlvbi4KPj4+ICsKPj4+ICsgICAgICBUaGlzIG1vZGUgaXMgc2FmZXIgdGhhbiB0aGUgdHdv
IGFib3ZlLCBidXQgaXQgbWF5YmUgc2xvd2VyIGluIHNvbWUKPj4+ICsgICAgICBoaWdoIHBlcmZv
cm1hY2Ugc2NlbmFyaW9zLgo+Pgo+PiBhbmQgaGVyZT8KCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby9pb21tdQ==
