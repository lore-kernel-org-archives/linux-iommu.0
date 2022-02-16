Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3D87C433EF
	for <iommu@archiver.kernel.org>; Wed, 16 Feb 2022 09:35:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9D95782A0B;
	Wed, 16 Feb 2022 09:35:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LrLVHe2bloTr; Wed, 16 Feb 2022 09:35:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5AC5F828F8;
	Wed, 16 Feb 2022 09:35:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2FF94C001A;
	Wed, 16 Feb 2022 09:35:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4DD9BC000B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Feb 2022 09:35:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 42DBE400FB
 for <iommu@lists.linux-foundation.org>; Wed, 16 Feb 2022 09:35:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fEC6ckcJo_9F for <iommu@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 09:35:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5A2FC4002B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Feb 2022 09:35:29 +0000 (UTC)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4JzCQs6kvHz8wj1;
 Wed, 16 Feb 2022 17:32:05 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Feb 2022 17:35:24 +0800
Subject: Re: [PATCH v3 8/8] iommu/arm-smmu-v3: Make default domain type of
 HiSilicon PTT device to identity
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
References: <20220124131118.17887-1-yangyicong@hisilicon.com>
 <20220124131118.17887-9-yangyicong@hisilicon.com>
 <e58888c1-5448-77c7-7f6c-f5db999a888f@huawei.com>
 <20220215130044.GA7154@willie-the-truck>
 <9018a1d9-4d42-3a99-dbc6-c55139abcb1e@arm.com>
 <20220215134232.GA7592@willie-the-truck>
 <161e5005-ea12-fde4-0e31-ec871d2fe591@arm.com>
Message-ID: <ab91cc5b-625e-c90b-7ab8-a0144a9b1a92@huawei.com>
Date: Wed, 16 Feb 2022 17:35:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <161e5005-ea12-fde4-0e31-ec871d2fe591@arm.com>
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
Cc: mark.rutland@arm.com, prime.zeng@huawei.com,
 alexander.shishkin@linux.intel.com, linux-pci@vger.kernel.org,
 linuxarm@huawei.com, yangyicong@hisilicon.com, daniel.thompson@linaro.org,
 peterz@infradead.org, mingo@redhat.com, helgaas@kernel.org,
 liuqi115@huawei.com, mike.leach@linaro.org, suzuki.poulose@arm.com,
 coresight@lists.linaro.org, acme@kernel.org, zhangshaokun@hisilicon.com,
 linux-arm-kernel@lists.infradead.org, mathieu.poirier@linaro.org,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, iommu@lists.linux-foundation.org,
 leo.yan@linaro.org
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
From: Yicong Yang via iommu <iommu@lists.linux-foundation.org>
Reply-To: Yicong Yang <yangyicong@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gMjAyMi8yLzE1IDIyOjI5LCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4gT24gMjAyMi0wMi0xNSAx
Mzo0MiwgV2lsbCBEZWFjb24gd3JvdGU6Cj4+IE9uIFR1ZSwgRmViIDE1LCAyMDIyIGF0IDAxOjMw
OjI2UE0gKzAwMDAsIFJvYmluIE11cnBoeSB3cm90ZToKPj4+IE9uIDIwMjItMDItMTUgMTM6MDAs
IFdpbGwgRGVhY29uIHdyb3RlOgo+Pj4+IE9uIE1vbiwgRmViIDE0LCAyMDIyIGF0IDA4OjU1OjIw
UE0gKzA4MDAsIFlpY29uZyBZYW5nIHdyb3RlOgo+Pj4+PiBPbiAyMDIyLzEvMjQgMjE6MTEsIFlp
Y29uZyBZYW5nIHdyb3RlOgo+Pj4+Pj4gVGhlIERNQSBvZiBIaVNpbGljb24gUFRUIGRldmljZSBj
YW4gb25seSB3b3JrIHdpdGggaWRlbnRpY2FsCj4+Pj4+PiBtYXBwaW5nLiBTbyBhZGQgYSBxdWly
ayBmb3IgdGhlIGRldmljZSB0byBmb3JjZSB0aGUgZG9tYWluCj4+Pj4+PiBwYXNzdGhyb3VnaC4K
Pj4+Pj4+Cj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBZaWNvbmcgWWFuZyA8eWFuZ3lpY29uZ0BoaXNp
bGljb24uY29tPgo+Pj4+Pj4gLS0tCj4+Pj4+PiDCoMKgIGRyaXZlcnMvaW9tbXUvYXJtL2FybS1z
bW11LXYzL2FybS1zbW11LXYzLmMgfCAxNiArKysrKysrKysrKysrKysrCj4+Pj4+PiDCoMKgIDEg
ZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspCj4+Pj4+Pgo+Pj4+Pj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLmMgYi9kcml2ZXJzL2lv
bW11L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12My5jCj4+Pj4+PiBpbmRleCA2ZGM2ZDhiNmIz
NjguLjZmNjdhMmIxZGQyNyAxMDA2NDQKPj4+Pj4+IC0tLSBhL2RyaXZlcnMvaW9tbXUvYXJtL2Fy
bS1zbW11LXYzL2FybS1zbW11LXYzLmMKPj4+Pj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvYXJtL2Fy
bS1zbW11LXYzL2FybS1zbW11LXYzLmMKPj4+Pj4+IEBAIC0yODM4LDYgKzI4MzgsMjEgQEAgc3Rh
dGljIGludCBhcm1fc21tdV9kZXZfZGlzYWJsZV9mZWF0dXJlKHN0cnVjdCBkZXZpY2UgKmRldiwK
Pj4+Pj4+IMKgwqDCoMKgwqDCoCB9Cj4+Pj4+PiDCoMKgIH0KPj4+Pj4+ICsjZGVmaW5lIElTX0hJ
U0lfUFRUX0RFVklDRShwZGV2KcKgwqDCoCAoKHBkZXYpLT52ZW5kb3IgPT0gUENJX1ZFTkRPUl9J
RF9IVUFXRUkgJiYgXAo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgKHBkZXYpLT5kZXZpY2UgPT0gMHhhMTJlKQo+Pj4+Pj4gKwo+Pj4+Pj4gK3N0YXRpYyBp
bnQgYXJtX3NtbXVfZGVmX2RvbWFpbl90eXBlKHN0cnVjdCBkZXZpY2UgKmRldikKPj4+Pj4+ICt7
Cj4+Pj4+PiArwqDCoMKgIGlmIChkZXZfaXNfcGNpKGRldikpIHsKPj4+Pj4+ICvCoMKgwqDCoMKg
wqDCoCBzdHJ1Y3QgcGNpX2RldiAqcGRldiA9IHRvX3BjaV9kZXYoZGV2KTsKPj4+Pj4+ICsKPj4+
Pj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoSVNfSElTSV9QVFRfREVWSUNFKHBkZXYpKQo+Pj4+Pj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIElPTU1VX0RPTUFJTl9JREVOVElUWTsKPj4+
Pj4+ICvCoMKgwqAgfQo+Pj4+Pj4gKwo+Pj4+Pj4gK8KgwqDCoCByZXR1cm4gMDsKPj4+Pj4+ICt9
Cj4+Pj4+PiArCj4+Pj4+PiDCoMKgIHN0YXRpYyBzdHJ1Y3QgaW9tbXVfb3BzIGFybV9zbW11X29w
cyA9IHsKPj4+Pj4+IMKgwqDCoMKgwqDCoCAuY2FwYWJsZcKgwqDCoMKgwqDCoMKgID0gYXJtX3Nt
bXVfY2FwYWJsZSwKPj4+Pj4+IMKgwqDCoMKgwqDCoCAuZG9tYWluX2FsbG9jwqDCoMKgwqDCoMKg
wqAgPSBhcm1fc21tdV9kb21haW5fYWxsb2MsCj4+Pj4+PiBAQCAtMjg2Myw2ICsyODc4LDcgQEAg
c3RhdGljIHN0cnVjdCBpb21tdV9vcHMgYXJtX3NtbXVfb3BzID0gewo+Pj4+Pj4gwqDCoMKgwqDC
oMKgIC5zdmFfdW5iaW5kwqDCoMKgwqDCoMKgwqAgPSBhcm1fc21tdV9zdmFfdW5iaW5kLAo+Pj4+
Pj4gwqDCoMKgwqDCoMKgIC5zdmFfZ2V0X3Bhc2lkwqDCoMKgwqDCoMKgwqAgPSBhcm1fc21tdV9z
dmFfZ2V0X3Bhc2lkLAo+Pj4+Pj4gwqDCoMKgwqDCoMKgIC5wYWdlX3Jlc3BvbnNlwqDCoMKgwqDC
oMKgwqAgPSBhcm1fc21tdV9wYWdlX3Jlc3BvbnNlLAo+Pj4+Pj4gK8KgwqDCoCAuZGVmX2RvbWFp
bl90eXBlwqDCoMKgID0gYXJtX3NtbXVfZGVmX2RvbWFpbl90eXBlLAo+Pj4+Pj4gwqDCoMKgwqDC
oMKgIC5wZ3NpemVfYml0bWFwwqDCoMKgwqDCoMKgwqAgPSAtMVVMLCAvKiBSZXN0cmljdGVkIGR1
cmluZyBkZXZpY2UgYXR0YWNoICovCj4+Pj4+PiDCoMKgwqDCoMKgwqAgLm93bmVywqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCA9IFRISVNfTU9EVUxFLAo+Pj4+Pj4gwqDCoCB9Owo+Pj4+Pj4KPj4+Pj4K
Pj4+Pj4gSXMgdGhpcyBxdWlyayBvayB3aXRoIHRoZSBTTU1VIHYzIGRyaXZlcj8gSnVzdCB3YW50
IHRvIGNvbmZpcm0gdGhhdCBJJ20gb24gdGhlCj4+Pj4+IHJpZ2h0IHdheSB0byBkZWFsaW5nIHdp
dGggdGhlIGlzc3VlIG9mIG91ciBkZXZpY2UuCj4+Pj4KPj4+PiBJIGRvbid0IHRoaW5rIHRoZSBx
dWlyayBzaG91bGQgYmUgaW4gdGhlIFNNTVV2MyBkcml2ZXIuIEFzc3VtZWRseSwgeW91IHdvdWxk
Cj4+Pj4gaGF2ZSB0aGUgZXhhY3Qgc2FtZSBwcm9ibGVtIGlmIHlvdSBzdHVjayB0aGUgUFRUIGRl
dmljZSBiZWhpbmQgYSBkaWZmZXJlbnQKPj4+PiB0eXBlIG9mIElPTU1VLCBhbmQgc28gdGhlIHF1
aXJrIHNob3VsZCBiZSBoYW5kbGVkIGJ5IGEgaGlnaGVyIGxldmVsIG9mIHRoZQo+Pj4+IHN0YWNr
Lgo+Pj4KPj4+IENvbmNlcHR1YWxseSwgeWVzLCBidXQgSSdtIGluY2xpbmVkIHRvIGJlIHByYWdt
YXRpYyBoZXJlLiBEZWZhdWx0IGRvbWFpbgo+Pj4gcXVpcmtzIGNvdWxkIG9ubHkgbW92ZSBvdXQg
YXMgZmFyIGFzIHRoZSBvdGhlciBlbmQgb2YgdGhlIGNhbGwgZnJvbQo+Pj4gaW9tbXVfZ2V0X2Rl
Zl9kb21haW5fdHlwZSgpIC0gaXQncyBub3QgbGlrZSB3ZSBjb3VsZCByZWx5IG9uIHNvbWUgZmxh
ZyBpbiBhCj4+PiBkcml2ZXIgd2hpY2ggbWF5IG5vdCBldmVuIGJlIGxvYWRlZCB5ZXQsIGxldCBh
bG9uZSBtYXRjaGVkIHRvIHRoZSBkZXZpY2UuCj4+PiBBbmQgZXZlbiB0aGVuIHRoZXJlJ3MgYW4g
ZXF1YWwgYW5kIG9wcG9zaXRlIGFyZ3VtZW50IGZvciB3aHkgdGhlIGNvcmUgY29kZQo+Pj4gc2hv
dWxkIGhhdmUgdG8gbWFpbnRhaW4gYSBsaXN0IG9mIHBsYXRmb3JtLXNwZWNpZmljIHF1aXJrcyBy
YXRoZXIgdGhhbiBjb2RlCj4+PiBzcGVjaWZpYyB0byB0aGUgcmVsZXZhbnQgcGxhdGZvcm1zLiBU
aGUgZmFjdCBpcyB0aGF0IGEgSGlTaWxpY29uIFJDaUVQIGlzCj4+PiBub3QgZ29pbmcgdG8gZW5k
IHVwIGJlaGluZCBhbnl0aGluZyBvdGhlciB0aGFuIGEgSGlTaWxpY29uIElPTU1VLCBhbmQgaWYK
Pj4+IHRob3NlIGV2ZXIgc3RvcCBiZWluZyBTTU1VdjMgKmFuZCogc3VjaCBhIHF1aXJrIHN0aWxs
IGV4aXN0cyB3ZSBjYW4gd29ycnkKPj4+IGFib3V0IGl0IHRoZW4uCj4+CgpUaGF0J3MgdHJ1ZSB0
aGF0IHRoaXMgUkNpRVAgb25seSBhcHBlYXJzIGJlaGluZCB0aGUgSGlTaWxpY29uJ3MgSU9NTVUg
d2hpY2ggdXNpbmcKU01NVSB2MyBkcml2ZXIuCgo+PiBQZXJoYXBzLCBidXQgeW91IGtub3cgdGhh
dCBieSBhZGRpbmcgdGhpcyBob29rIGl0J3Mgb25seSBhIG1hdHRlciBvZiB0aW1lCj4+IGJlZm9y
ZSB3ZSBnZXQgcmFuZG9tIGNvbXBhdGlibGUgc3RyaW5nIG1hdGNoZXMgaW4gdGhlcmUsIHNvIEkn
ZCByYXRoZXIga2VlcAo+PiB0aGUgZmxvb2QgZ2F0ZXMgY2xvc2VkIGFzIGxvbmcgYXMgd2UgY2Fu
Lgo+Pgo+PiBHaXZlbiB0aGF0IHRoaXMgaXMgYSBQQ0kgZGV2aWNlLCB3aHkgY2FuJ3Qgd2UgaGF2
ZSBhIFBDSSBxdWlyayBmb3IgZGV2aWNlcwo+PiB3aGljaCByZXF1aXJlIGFuIGlkZW50aXR5IG1h
cHBpbmcgYW5kIHRoZW4gaGFuZGxlIHRoYXQgaW4gdGhlIElPTU1VIGNvcmU/Cj4gCgpBcyBSb2Jp
biBtZW50aW9uZWQgYmVsb3csIG5vdCBvbmx5IFBDSSBkZXZpY2VzIGJ1dCBzb21lIHBsYXRmb3Jt
IGRldmljZXMgYWxzbyB3YW50CnRvIHBhc3N0aHJvdWdoIHRoZSBJT01NVS4gSSBub3RpY2VkIHRo
ZXJlJ3JlIGFscmVhZHkgc29tZSBmaWVsZHMgZGVzY3JpYmUgdGhlIGRldmljZSdzCkRNQSBpbmZv
cm1hdGlvbiBpbiBzdHJ1Y3QgZGV2aWNlLCBzbyBmb2xsb3cgeW91ciBwb2ludCBjYW4gaXQgZ28g
dGhlcmUgaWYgd2UncmUgZ29pbmcKdG8gbWFrZSBpdCBtb3JlIGdlbmVyaWM/CgpBbnl3YXkgaWYg
d2UncmUgZ29pbmcgdG8gbWFrZSBhbGwgdGhlc2UgcXVpcmtzIGluIGEgbW9yZSBnZW5lcmljIHBs
YWNlLCBJJ2xsIHdpbGxpbmcKdG8gYWRkIHRoaXMgZGV2aWNlIHRoZXJlIGFuZCBoYXZlIGEgdGVz
dC4KCj4gT2gsIGRvbid0IHRoaW5rIEkgKmxpa2UqIGhhdmluZyBxdWlya3MgaW4gdGhlIGRyaXZl
ciwgaXQganVzdCBzZWVtcyBsaWtlIHRoZSBsZWFzdC13b3JzdCBjaG9pY2UgZnJvbSBhIGJhZCBi
dW5jaC4gQWxsIG9mIHRoZSBkZWZhdWx0IGRvbWFpbiBxdWlya3Mgc28gZmFyIChpbmNsdWRpbmcg
dGhpcyBvbmUpIGV4aXN0IGZvciBpbnRlZ3JhdGVkIGRldmljZXMgYW5kL29yIGRvZGd5IGZpcm13
YXJlIHNldHVwcyBzdWNoIHRoYXQgdGhleSBhcmUgcGxhdGZvcm0tc3BlY2lmaWMsIHNvIHRoZXJl
IGlzIG5vIHRlY2huaWNhbCByZWFzb24gZm9yIHRyeWluZyB0byBzcGxpdCAqc29tZSogb2YgdGhl
bSBvZmYgaW50byBhIGdlbmVyaWMgbWVjaGFuaXNtIHdoZW4gdGhlIGRyaXZlci1iYXNlZCBwbGF0
Zm9ybS1zcGVjaWZpYyBtZWNoYW5pc20gc3RpbGwgbmVlZHMgdG8gZXhpc3QgYW55d2F5IChzb21l
IG9mIHRoZW0gZG8gZGVwZW5kIG9uIGRyaXZlciBzdGF0ZSBhcyB3ZWxsKS4KPiAKPiBGZWVsIGZy
ZWUgdG8gdGVzdCB0aGUgd2F0ZXJzIHdpdGggYSBwYXRjaCBwdW50aW5nIHFjb21fc21tdV9kZWZf
ZG9tYWluX3R5cGUoKSB0byBjb3JlIGNvZGUsIGJ1dCBJIHRoaW5rIHlvdSdsbCBzdHJ1Z2dsZSB0
byBmaW5kIGEgcmVhc29uIHRvIGdpdmUgaW4gdGhlIGNvbW1pdCBtZXNzYWdlIG90aGVyIHRoYW4g
IkkgZG9uJ3QgbGlrZSBpdCIuCj4gCj4+PiBVZ2x5IGFzIGl0IGlzLCB0aGlzIGlzIHRoZSBzdGF0
dXMgcXVvLiBJIGRvbid0IHJlY2FsbCBhbnlvbmUgZXZlciBhcmd1aW5nCj4+PiB0aGF0IHRoZSBl
cXVpdmFsZW50IHF1aXJrcyBmb3IgSW50ZWwgaW50ZWdyYXRlZCBncmFwaGljcyBzaG91bGQgYmUg
bWFkZQo+Pj4gZ2VuZXJpYyA7KQo+Pgo+PiBJIGRvbid0IGtub3cgYW55dGhpbmcgYWJvdXQgSW50
ZWwgaW50ZWdyYXRlZCBncmFwaGljcy4gSGF2ZSB0aGV5IHNvbHZlZCB0aGlzCj4+IHByb2JsZW0g
aW4gYSBiZXR0ZXIgd2F5LCBvciBjb3VsZCB0aGV5IGVxdWFsbHkgbWFrZSB1c2Ugb2YgYSBnZW5l
cmljIHF1aXJrPwo+IAo+IFNlZSBpbnRlbC1pb21tdSdzIGRldmljZV9kZWZfZG9tYWluX3R5cGUo
KSBpbXBsZW1lbnRhdGlvbi4gVGhlIHNoYXBlIG9mIGl0IG1heSBzZWVtIHF1aXRlIGZhbWlsaWFy
Li4uCj4gCgpZZXMgSW50ZWwncyBJT01NVSBwYXNzdGhyb3VnaCBzb21lIFBDSSBkZXZpY2VzIGlu
IHRoaXMgd2F5IGFuZCB0aGlzIHBhdGNoIGltaXRhdGVzIHRoYXQuCmh0dHBzOi8vZ2l0aHViLmNv
bS90b3J2YWxkcy9saW51eC9ibG9iL21hc3Rlci9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMj
TDI5NTkKCmJ0dyBXaWxsLCBtdWNoIGFwcHJlY2lhdGVkIGlmIHlvdSBjb3VsZCBoYXZlIGEgbG9v
ayBhdCB0aGUgcGVyZiBhbmQgUE1VIHBhcnQgb2YgdGhpcyBkcml2ZXIuOikKClRoYW5rcywKWWlj
b25nCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21t
dSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
