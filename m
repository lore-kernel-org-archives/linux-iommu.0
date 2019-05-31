Return-Path: <SRS0=mJb0=T7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FBAC04AB6
	for <iommu@archiver.kernel.org>; Fri, 31 May 2019 10:04:12 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B77A826748
	for <iommu@archiver.kernel.org>; Fri, 31 May 2019 10:04:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B77A826748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6E349F89;
	Fri, 31 May 2019 10:04:12 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 5C7A1F85
	for <iommu@lists.linux-foundation.org>;
	Fri, 31 May 2019 10:03:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 56E336C5
	for <iommu@lists.linux-foundation.org>;
	Fri, 31 May 2019 10:03:39 +0000 (UTC)
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
	by Forcepoint Email with ESMTP id 9BBDB1EFB9AB272BF3AF;
	Fri, 31 May 2019 18:03:36 +0800 (CST)
Received: from [127.0.0.1] (10.133.215.186) by DGGEMS414-HUB.china.huawei.com
	(10.3.19.214) with Microsoft SMTP Server id 14.3.439.0;
	Fri, 31 May 2019 18:03:29 +0800
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
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <030bafab-58f5-8bb1-0533-2977d6e138b2@huawei.com>
Date: Fri, 31 May 2019 18:03:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <645bd526-4eb0-4a36-2dda-023f009247ab@huawei.com>
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

CgpPbiAyMDE5LzUvMzAgMjA6MjAsIEpvaG4gR2Fycnkgd3JvdGU6Cj4gT24gMzAvMDUvMjAxOSAw
NDo0OCwgWmhlbiBMZWkgd3JvdGU6Cj4+IEZpcnN0LCBhZGQgYnVpbGQgb3B0aW9uIElPTU1VX0RF
RkFVTFRfe0xBWll8U1RSSUNUfSwgc28gdGhhdCB3ZSBoYXZlIHRoZQo+PiBvcHBvcnR1bml0eSB0
byBzZXQge2xhenl8c3RyaWN0fSBtb2RlIGFzIGRlZmF1bHQgYXQgYnVpbGQgdGltZS4gVGhlbiBw
dXQKPj4gdGhlIHRocmVlIGNvbmZpZyBvcHRpb25zIGluIGFuIGNob2ljZSwgbWFrZSBwZW9wbGUg
Y2FuIG9ubHkgY2hvb3NlIG9uZSBvZgo+PiB0aGUgdGhyZWUgYXQgYSB0aW1lLgo+Pgo+IAo+IFNp
bmNlIHRoaXMgd2FzIG5vdCBwaWNrZWQgdXAsIGJ1dCBtb2R1bG8gKHNvbXRpbWVzIHNhbWUpIGNv
bW1lbnRzIGJlbG93Ogo+IAo+IFJldmlld2VkLWJ5OiBKb2huIEdhcnJ5IDxqb2huLmdhcnJ5QGh1
YXdlaS5jb20+Cj4gCj4+IFNpZ25lZC1vZmYtYnk6IFpoZW4gTGVpIDx0aHVuZGVyLmxlaXpoZW5A
aHVhd2VpLmNvbT4KPj4gLS0tCj4+IMKgZHJpdmVycy9pb21tdS9LY29uZmlnIHwgNDIgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tCj4+IMKgZHJpdmVycy9pb21tdS9p
b21tdS5jIHzCoCAzICsrLQo+PiDCoDIgZmlsZXMgY2hhbmdlZCwgMzcgaW5zZXJ0aW9ucygrKSwg
OCBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvS2NvbmZpZyBi
L2RyaXZlcnMvaW9tbXUvS2NvbmZpZwo+PiBpbmRleCA4MzY2NGRiNTIyMWRmMDIuLmQ2YTFhNDVm
ODBmZmJmNSAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9pb21tdS9LY29uZmlnCj4+ICsrKyBiL2Ry
aXZlcnMvaW9tbXUvS2NvbmZpZwo+PiBAQCAtNzUsMTcgKzc1LDQ1IEBAIGNvbmZpZyBJT01NVV9E
RUJVR0ZTCj4+IMKgwqDCoMKgwqDCoCBkZWJ1Zy9pb21tdSBkaXJlY3RvcnksIGFuZCB0aGVuIHBv
cHVsYXRlIGEgc3ViZGlyZWN0b3J5IHdpdGgKPj4gwqDCoMKgwqDCoMKgIGVudHJpZXMgYXMgcmVx
dWlyZWQuCj4+Cj4+IC1jb25maWcgSU9NTVVfREVGQVVMVF9QQVNTVEhST1VHSAo+PiAtwqDCoMKg
IGJvb2wgIklPTU1VIHBhc3N0aHJvdWdoIGJ5IGRlZmF1bHQiCj4+ICtjaG9pY2UKPj4gK8KgwqDC
oCBwcm9tcHQgIklPTU1VIGRlZmF1bHQgRE1BIG1vZGUiCj4+IMKgwqDCoMKgIGRlcGVuZHMgb24g
SU9NTVVfQVBJCj4+IC3CoMKgwqDCoMKgwqDCoCBoZWxwCj4+IC3CoMKgwqDCoMKgIEVuYWJsZSBw
YXNzdGhyb3VnaCBieSBkZWZhdWx0LCByZW1vdmluZyB0aGUgbmVlZCB0byBwYXNzIGluCj4+IC3C
oMKgwqDCoMKgIGlvbW11LnBhc3N0aHJvdWdoPW9uIG9yIGlvbW11PXB0IHRocm91Z2ggY29tbWFu
ZCBsaW5lLiBJZiB0aGlzCj4+IC3CoMKgwqDCoMKgIGlzIGVuYWJsZWQsIHlvdSBjYW4gc3RpbGwg
ZGlzYWJsZSB3aXRoIGlvbW11LnBhc3N0aHJvdWdoPW9mZgo+PiAtwqDCoMKgwqDCoCBvciBpb21t
dT1ub3B0IGRlcGVuZGluZyBvbiB0aGUgYXJjaGl0ZWN0dXJlLgo+PiArwqDCoMKgIGRlZmF1bHQg
SU9NTVVfREVGQVVMVF9TVFJJQ1QKPj4gK8KgwqDCoCBoZWxwCj4+ICvCoMKgwqDCoMKgIFRoaXMg
b3B0aW9uIGFsbG93cyBJT01NVSBETUEgbW9kZSB0byBiZSBjaG9zZSBhdCBidWlsZCB0aW1lLCB0
bwo+IAo+IEFzIGJlZm9yZToKPiAvcy9jaG9zZS9jaG9zZW4vLCAvcy9hbGxvd3MgSU9NTVUvYWxs
b3dzIGFuIElPTU1VLwpJJ20gc29ycnkgdGhhdCB0aGUgcHJldmlvdXMgdmVyc2lvbiB3YXMgbm90
IG1vZGlmaWVkLgoKPiAKPj4gK8KgwqDCoMKgwqAgb3ZlcnJpZGUgdGhlIGRlZmF1bHQgRE1BIG1v
ZGUgb2YgZWFjaCBBUkNIcywgcmVtb3ZpbmcgdGhlIG5lZWQgdG8KPiAKPiBBZ2FpbiwgYXMgYmVm
b3JlOgo+IEFSQ0hzIHNob3VsZCBiZSBzaW5ndWxhcgpPSwoKPiAKPj4gK8KgwqDCoMKgwqAgcGFz
cyBpbiBrZXJuZWwgcGFyYW1ldGVycyB0aHJvdWdoIGNvbW1hbmQgbGluZS4gWW91IGNhbiBzdGls
bCB1c2UKPj4gK8KgwqDCoMKgwqAgQVJDSHMgc3BlY2lmaWMgYm9vdCBvcHRpb25zIHRvIG92ZXJy
aWRlIHRoaXMgb3B0aW9uIGFnYWluLgo+PiArCj4+ICtjb25maWcgSU9NTVVfREVGQVVMVF9QQVNT
VEhST1VHSAo+PiArwqDCoMKgIGJvb2wgInBhc3N0aHJvdWdoIgo+PiArwqDCoMKgIGhlbHAKPj4g
K8KgwqDCoMKgwqAgSW4gdGhpcyBtb2RlLCB0aGUgRE1BIGFjY2VzcyB0aHJvdWdoIElPTU1VIHdp
dGhvdXQgYW55IGFkZHJlc3Nlcwo+PiArwqDCoMKgwqDCoCB0cmFuc2xhdGlvbi4gVGhhdCBtZWFu
cywgdGhlIHdyb25nIG9yIGlsbGVnYWwgRE1BIGFjY2VzcyBjYW4gbm90Cj4+ICvCoMKgwqDCoMKg
IGJlIGNhdWdodCwgbm8gZXJyb3IgaW5mb3JtYXRpb24gd2lsbCBiZSByZXBvcnRlZC4KPj4KPj4g
wqDCoMKgwqDCoMKgIElmIHVuc3VyZSwgc2F5IE4gaGVyZS4KPj4KPj4gK2NvbmZpZyBJT01NVV9E
RUZBVUxUX0xBWlkKPj4gK8KgwqDCoCBib29sICJsYXp5Igo+PiArwqDCoMKgIGhlbHAKPj4gK8Kg
wqDCoMKgwqAgU3VwcG9ydCBsYXp5IG1vZGUsIHdoZXJlIGZvciBldmVyeSBJT01NVSBETUEgdW5t
YXAgb3BlcmF0aW9uLCB0aGUKPj4gK8KgwqDCoMKgwqAgZmx1c2ggb3BlcmF0aW9uIG9mIElPVExC
IGFuZCB0aGUgZnJlZSBvcGVyYXRpb24gb2YgSU9WQSBhcmUgZGVmZXJyZWQuCj4+ICvCoMKgwqDC
oMKgIFRoZXkgYXJlIG9ubHkgZ3VhcmFudGVlZCB0byBiZSBkb25lIGJlZm9yZSB0aGUgcmVsYXRl
ZCBJT1ZBIHdpbGwgYmUKPj4gK8KgwqDCoMKgwqAgcmV1c2VkLgo+IAo+IHdoeSBubyBhZHZpc29y
eSBvbiBob3cgdG8gc2V0IGlmIHVuc3VyZT8KQmVjYXVzZSB0aGUgTEFaWSBhbmQgU1RSSUNUIGhh
dmUgdGhlaXIgb3duIGFkdmFudGFnZXMgYW5kIGRpc2FkdmFudGFnZXMuCgpTaG91bGQgSSBzYXk6
IElmIHVuc3VyZSwga2VlcCB0aGUgZGVmYXVsdOOAggoKPiAKPj4gKwo+PiArY29uZmlnIElPTU1V
X0RFRkFVTFRfU1RSSUNUCj4+ICvCoMKgwqAgYm9vbCAic3RyaWN0Igo+PiArwqDCoMKgIGhlbHAK
Pj4gK8KgwqDCoMKgwqAgRm9yIGV2ZXJ5IElPTU1VIERNQSB1bm1hcCBvcGVyYXRpb24sIHRoZSBm
bHVzaCBvcGVyYXRpb24gb2YgSU9UTEIgYW5kCj4+ICvCoMKgwqDCoMKgIHRoZSBmcmVlIG9wZXJh
dGlvbiBvZiBJT1ZBIGFyZSBndWFyYW50ZWVkIHRvIGJlIGRvbmUgaW4gdGhlIHVubWFwCj4+ICvC
oMKgwqDCoMKgIGZ1bmN0aW9uLgo+PiArCj4+ICvCoMKgwqDCoMKgIFRoaXMgbW9kZSBpcyBzYWZl
ciB0aGFuIHRoZSB0d28gYWJvdmUsIGJ1dCBpdCBtYXliZSBzbG93ZXIgaW4gc29tZQo+PiArwqDC
oMKgwqDCoCBoaWdoIHBlcmZvcm1hY2Ugc2NlbmFyaW9zLgo+IAo+IGFuZCBoZXJlPwo+IAo+PiAr
Cj4+ICtlbmRjaG9pY2UKPj4gKwo+PiDCoGNvbmZpZyBPRl9JT01NVQo+PiDCoMKgwqDCoMKgwqDC
oCBkZWZfYm9vbCB5Cj4+IMKgwqDCoMKgwqDCoMKgIGRlcGVuZHMgb24gT0YgJiYgSU9NTVVfQVBJ
Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2lvbW11LmMgYi9kcml2ZXJzL2lvbW11L2lv
bW11LmMKPj4gaW5kZXggNjdlZTY2MjNmOWIyYTRkLi41NmJjZTIyMTI4NWIxNWYgMTAwNjQ0Cj4+
IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW9tbXUuYwo+PiArKysgYi9kcml2ZXJzL2lvbW11L2lvbW11
LmMKPj4gQEAgLTQzLDcgKzQzLDggQEAKPj4gwqAjZWxzZQo+PiDCoHN0YXRpYyB1bnNpZ25lZCBp
bnQgaW9tbXVfZGVmX2RvbWFpbl90eXBlID0gSU9NTVVfRE9NQUlOX0RNQTsKPj4gwqAjZW5kaWYK
Pj4gLXN0YXRpYyBib29sIGlvbW11X2RtYV9zdHJpY3QgX19yZWFkX21vc3RseSA9IHRydWU7Cj4+
ICtzdGF0aWMgYm9vbCBpb21tdV9kbWFfc3RyaWN0IF9fcmVhZF9tb3N0bHkgPQo+PiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBJU19FTkFCTEVEKENPTkZJR19JT01NVV9ERUZBVUxUX1NUUklDVCk7
Cj4+Cj4+IMKgc3RydWN0IGlvbW11X2dyb3VwIHsKPj4gwqDCoMKgwqAgc3RydWN0IGtvYmplY3Qg
a29iajsKPj4KPiAKPiAKPiAKPiAuCj4gCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vaW9tbXU=
