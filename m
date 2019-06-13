Return-Path: <SRS0=dZmg=UM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81067C31E45
	for <iommu@archiver.kernel.org>; Thu, 13 Jun 2019 08:30:24 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B8F920B7C
	for <iommu@archiver.kernel.org>; Thu, 13 Jun 2019 08:30:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B8F920B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 5CFF6130B;
	Thu, 13 Jun 2019 08:30:23 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id BB1B412F3
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 08:30:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id F3C44174
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 08:30:21 +0000 (UTC)
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
	by Forcepoint Email with ESMTP id 2AE1F7854A4A77E18E06;
	Thu, 13 Jun 2019 16:30:18 +0800 (CST)
Received: from [127.0.0.1] (10.133.215.186) by DGGEMS411-HUB.china.huawei.com
	(10.3.19.211) with Microsoft SMTP Server id 14.3.439.0;
	Thu, 13 Jun 2019 16:30:11 +0800
Subject: Re: [PATCH v8 1/7] iommu: enhance IOMMU default DMA mode build options
To: John Garry <john.garry@huawei.com>, Jean-Philippe Brucker
	<jean-philippe.brucker@arm.com>, Robin Murphy <robin.murphy@arm.com>, "Will
	Deacon" <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, Jonathan
	Corbet <corbet@lwn.net>, linux-doc <linux-doc@vger.kernel.org>,
	Sebastian Ott
	<sebott@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>,
	"Martin Schwidefsky" <schwidefsky@de.ibm.com>, Heiko Carstens
	<heiko.carstens@de.ibm.com>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "Michael
	Ellerman" <mpe@ellerman.id.au>, Tony Luck <tony.luck@intel.com>, Fenghua Yu
	<fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin"
	<hpa@zytor.com>, David Woodhouse <dwmw2@infradead.org>, iommu
	<iommu@lists.linux-foundation.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, x86 <x86@kernel.org>,
	linux-ia64 <linux-ia64@vger.kernel.org>
References: <20190530034831.4184-1-thunder.leizhen@huawei.com>
	<20190530034831.4184-2-thunder.leizhen@huawei.com>
	<645bd526-4eb0-4a36-2dda-023f009247ab@huawei.com>
	<030bafab-58f5-8bb1-0533-2977d6e138b2@huawei.com>
	<55d0e30c-5bca-41fc-5bf0-4366dc387afd@huawei.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <7d3727e3-a455-3a26-1104-5b85c196bbdf@huawei.com>
Date: Thu, 13 Jun 2019 16:30:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <55d0e30c-5bca-41fc-5bf0-4366dc387afd@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.133.215.186]
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

CgpPbiAyMDE5LzUvMzEgMTg6NDIsIEpvaG4gR2Fycnkgd3JvdGU6Cj4gCj4+Pj4gLWNvbmZpZyBJ
T01NVV9ERUZBVUxUX1BBU1NUSFJPVUdICj4+Pj4gLcKgwqDCoCBib29sICJJT01NVSBwYXNzdGhy
b3VnaCBieSBkZWZhdWx0Igo+Pj4+ICtjaG9pY2UKPj4+PiArwqDCoMKgIHByb21wdCAiSU9NTVUg
ZGVmYXVsdCBETUEgbW9kZSIKPj4+PiDCoMKgwqDCoCBkZXBlbmRzIG9uIElPTU1VX0FQSQo+Pj4+
IC3CoMKgwqDCoMKgwqDCoCBoZWxwCj4+Pj4gLcKgwqDCoMKgwqAgRW5hYmxlIHBhc3N0aHJvdWdo
IGJ5IGRlZmF1bHQsIHJlbW92aW5nIHRoZSBuZWVkIHRvIHBhc3MgaW4KPj4+PiAtwqDCoMKgwqDC
oCBpb21tdS5wYXNzdGhyb3VnaD1vbiBvciBpb21tdT1wdCB0aHJvdWdoIGNvbW1hbmQgbGluZS4g
SWYgdGhpcwo+Pj4+IC3CoMKgwqDCoMKgIGlzIGVuYWJsZWQsIHlvdSBjYW4gc3RpbGwgZGlzYWJs
ZSB3aXRoIGlvbW11LnBhc3N0aHJvdWdoPW9mZgo+Pj4+IC3CoMKgwqDCoMKgIG9yIGlvbW11PW5v
cHQgZGVwZW5kaW5nIG9uIHRoZSBhcmNoaXRlY3R1cmUuCj4+Pj4gK8KgwqDCoCBkZWZhdWx0IElP
TU1VX0RFRkFVTFRfU1RSSUNUCj4+Pj4gK8KgwqDCoCBoZWxwCj4+Pj4gK8KgwqDCoMKgwqAgVGhp
cyBvcHRpb24gYWxsb3dzIElPTU1VIERNQSBtb2RlIHRvIGJlIGNob3NlIGF0IGJ1aWxkIHRpbWUs
IHRvCj4+Pgo+Pj4gQXMgYmVmb3JlOgo+Pj4gL3MvY2hvc2UvY2hvc2VuLywgL3MvYWxsb3dzIElP
TU1VL2FsbG93cyBhbiBJT01NVS8KPj4gSSdtIHNvcnJ5IHRoYXQgdGhlIHByZXZpb3VzIHZlcnNp
b24gd2FzIG5vdCBtb2RpZmllZC4KPj4KPj4+Cj4+Pj4gK8KgwqDCoMKgwqAgb3ZlcnJpZGUgdGhl
IGRlZmF1bHQgRE1BIG1vZGUgb2YgZWFjaCBBUkNIcywgcmVtb3ZpbmcgdGhlIG5lZWQgdG8KPj4+
Cj4+PiBBZ2FpbiwgYXMgYmVmb3JlOgo+Pj4gQVJDSHMgc2hvdWxkIGJlIHNpbmd1bGFyCj4+IE9L
Cj4+Cj4+Pgo+Pj4+ICvCoMKgwqDCoMKgIHBhc3MgaW4ga2VybmVsIHBhcmFtZXRlcnMgdGhyb3Vn
aCBjb21tYW5kIGxpbmUuIFlvdSBjYW4gc3RpbGwgdXNlCj4+Pj4gK8KgwqDCoMKgwqAgQVJDSHMg
c3BlY2lmaWMgYm9vdCBvcHRpb25zIHRvIG92ZXJyaWRlIHRoaXMgb3B0aW9uIGFnYWluLgo+IAo+
ICoKPiAKPj4+PiArCj4+Pj4gK2NvbmZpZyBJT01NVV9ERUZBVUxUX1BBU1NUSFJPVUdICj4+Pj4g
K8KgwqDCoCBib29sICJwYXNzdGhyb3VnaCIKPj4+PiArwqDCoMKgIGhlbHAKPj4+PiArwqDCoMKg
wqDCoCBJbiB0aGlzIG1vZGUsIHRoZSBETUEgYWNjZXNzIHRocm91Z2ggSU9NTVUgd2l0aG91dCBh
bnkgYWRkcmVzc2VzCj4+Pj4gK8KgwqDCoMKgwqAgdHJhbnNsYXRpb24uIFRoYXQgbWVhbnMsIHRo
ZSB3cm9uZyBvciBpbGxlZ2FsIERNQSBhY2Nlc3MgY2FuIG5vdAo+Pj4+ICvCoMKgwqDCoMKgIGJl
IGNhdWdodCwgbm8gZXJyb3IgaW5mb3JtYXRpb24gd2lsbCBiZSByZXBvcnRlZC4KPj4+Pgo+Pj4+
IMKgwqDCoMKgwqDCoCBJZiB1bnN1cmUsIHNheSBOIGhlcmUuCj4+Pj4KPj4+PiArY29uZmlnIElP
TU1VX0RFRkFVTFRfTEFaWQo+Pj4+ICvCoMKgwqAgYm9vbCAibGF6eSIKPj4+PiArwqDCoMKgIGhl
bHAKPj4+PiArwqDCoMKgwqDCoCBTdXBwb3J0IGxhenkgbW9kZSwgd2hlcmUgZm9yIGV2ZXJ5IElP
TU1VIERNQSB1bm1hcCBvcGVyYXRpb24sIHRoZQo+Pj4+ICvCoMKgwqDCoMKgIGZsdXNoIG9wZXJh
dGlvbiBvZiBJT1RMQiBhbmQgdGhlIGZyZWUgb3BlcmF0aW9uIG9mIElPVkEgYXJlIGRlZmVycmVk
Lgo+Pj4+ICvCoMKgwqDCoMKgIFRoZXkgYXJlIG9ubHkgZ3VhcmFudGVlZCB0byBiZSBkb25lIGJl
Zm9yZSB0aGUgcmVsYXRlZCBJT1ZBIHdpbGwgYmUKPj4+PiArwqDCoMKgwqDCoCByZXVzZWQuCj4+
Pgo+Pj4gd2h5IG5vIGFkdmlzb3J5IG9uIGhvdyB0byBzZXQgaWYgdW5zdXJlPwo+PiBCZWNhdXNl
IHRoZSBMQVpZIGFuZCBTVFJJQ1QgaGF2ZSB0aGVpciBvd24gYWR2YW50YWdlcyBhbmQgZGlzYWR2
YW50YWdlcy4KPj4KPj4gU2hvdWxkIEkgc2F5OiBJZiB1bnN1cmUsIGtlZXAgdGhlIGRlZmF1bHTj
gIIKPiAKPiBNYXliZS4gU28geW91IGNvdWxkIHB1dCB0aGlzIGluIHRoZSBoZWxwIGZvciB0aGUg
Y2hvaWNlLCAqIGFib3ZlLCBhbmQgcmVtb3ZlIHRoZSBhZHZpc29yeSBvbiBJT01NVV9ERUZBVUxU
X1BBU1NUSFJPVUdILgoKT0ssIEknbGwgcmV2aXNlIGl0IGFjY29yZGluZyB0byB0aGlzIGlkZWEg
aW4gdjkuCgo+IAo+IEhvd2V2ZXIgdGhlIG1haW50YWluZXIgbWF5IGhhdmUgYSBkaWZmZXJlbnQg
dmlldy4KPiAKPiBUaGFua3MsCj4gSm9obgo+IAo+Pgo+Pj4KPj4+PiArCj4+Pj4gK2NvbmZpZyBJ
T01NVV9ERUZBVUxUX1NUUklDVAo+Pj4+ICvCoMKgwqAgYm9vbCAic3RyaWN0Igo+Pj4+ICvCoMKg
wqAgaGVscAo+Pj4+ICvCoMKgwqDCoMKgIEZvciBldmVyeSBJT01NVSBETUEgdW5tYXAgb3BlcmF0
aW9uLCB0aGUgZmx1c2ggb3BlcmF0aW9uIG9mIElPVExCIGFuZAo+Pj4+ICvCoMKgwqDCoMKgIHRo
ZSBmcmVlIG9wZXJhdGlvbiBvZiBJT1ZBIGFyZSBndWFyYW50ZWVkIHRvIGJlIGRvbmUgaW4gdGhl
IHVubWFwCj4+Pj4gK8KgwqDCoMKgwqAgZnVuY3Rpb24uCj4+Pj4gKwo+Pj4+ICvCoMKgwqDCoMKg
IFRoaXMgbW9kZSBpcyBzYWZlciB0aGFuIHRoZSB0d28gYWJvdmUsIGJ1dCBpdCBtYXliZSBzbG93
ZXIgaW4gc29tZQo+Pj4+ICvCoMKgwqDCoMKgIGhpZ2ggcGVyZm9ybWFjZSBzY2VuYXJpb3MuCj4+
Pgo+Pj4gYW5kIGhlcmU/Cj4gCj4gCj4gLgo+IAoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2lvbW11
