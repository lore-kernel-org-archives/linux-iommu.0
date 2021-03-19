Return-Path: <SRS0=1/OX=IR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD84C433DB
	for <iommu@archiver.kernel.org>; Fri, 19 Mar 2021 17:00:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FFEF61959
	for <iommu@archiver.kernel.org>; Fri, 19 Mar 2021 17:00:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FFEF61959
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EB5E060758;
	Fri, 19 Mar 2021 17:00:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F2lrwBdVyrjZ; Fri, 19 Mar 2021 17:00:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 722E8605F9;
	Fri, 19 Mar 2021 17:00:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 323CDC000B;
	Fri, 19 Mar 2021 17:00:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D6A3C0001
 for <iommu@lists.linux-foundation.org>; Fri, 19 Mar 2021 17:00:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 77B294E90F
 for <iommu@lists.linux-foundation.org>; Fri, 19 Mar 2021 17:00:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nVqSTfsp7MsI for <iommu@lists.linux-foundation.org>;
 Fri, 19 Mar 2021 17:00:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E80864AEF5
 for <iommu@lists.linux-foundation.org>; Fri, 19 Mar 2021 17:00:32 +0000 (UTC)
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4F290Z17N6z680K7;
 Sat, 20 Mar 2021 00:51:58 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 19 Mar 2021 18:00:29 +0100
Received: from [10.47.10.104] (10.47.10.104) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 19 Mar
 2021 17:00:28 +0000
Subject: Re: [PATCH 1/6] iommu: Move IOVA power-of-2 roundup into allocator
To: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>, 
 <jejb@linux.ibm.com>, <martin.petersen@oracle.com>, <hch@lst.de>,
 <m.szyprowski@samsung.com>
References: <1616160348-29451-1-git-send-email-john.garry@huawei.com>
 <1616160348-29451-2-git-send-email-john.garry@huawei.com>
 <ee935a6d-a94c-313e-f0ed-e14cc6dac055@arm.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <73d459de-b5cc-e2f5-bcd7-2ee23c8d5075@huawei.com>
Date: Fri, 19 Mar 2021 16:58:17 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <ee935a6d-a94c-313e-f0ed-e14cc6dac055@arm.com>
Content-Language: en-US
X-Originating-IP: [10.47.10.104]
X-ClientProxiedBy: lhreml717-chm.china.huawei.com (10.201.108.68) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-scsi@vger.kernel.org, linuxarm@huawei.com
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

T24gMTkvMDMvMjAyMSAxNjoxMywgUm9iaW4gTXVycGh5IHdyb3RlOgo+IE9uIDIwMjEtMDMtMTkg
MTM6MjUsIEpvaG4gR2Fycnkgd3JvdGU6Cj4+IE1vdmUgdGhlIElPVkEgc2l6ZSBwb3dlci1vZi0y
IHJjYWNoZSByb3VuZHVwIGludG8gdGhlIElPVkEgYWxsb2NhdG9yLgo+Pgo+PiBUaGlzIGlzIHRv
IGV2ZW50dWFsbHkgbWFrZSBpdCBwb3NzaWJsZSB0byBiZSBhYmxlIHRvIGNvbmZpZ3VyZSB0aGUg
dXBwZXIKPj4gbGltaXQgb2YgdGhlIElPVkEgcmNhY2hlIHJhbmdlLgo+Pgo+PiBTaWduZWQtb2Zm
LWJ5OiBKb2huIEdhcnJ5IDxqb2huLmdhcnJ5QGh1YXdlaS5jb20+Cj4+IC0tLQo+PiDCoCBkcml2
ZXJzL2lvbW11L2RtYS1pb21tdS5jIHzCoCA4IC0tLS0tLQo+PiDCoCBkcml2ZXJzL2lvbW11L2lv
dmEuY8KgwqDCoMKgwqAgfCA1MSArKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0t
LS0KPj4gwqAgMiBmaWxlcyBjaGFuZ2VkLCAzNCBpbnNlcnRpb25zKCspLCAyNSBkZWxldGlvbnMo
LSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvZG1hLWlvbW11LmMgYi9kcml2ZXJz
L2lvbW11L2RtYS1pb21tdS5jCj4+IGluZGV4IGFmNzY1YzgxM2NjOC4uMTViNzI3MGE1YzJhIDEw
MDY0NAo+PiAtLS0gYS9kcml2ZXJzL2lvbW11L2RtYS1pb21tdS5jCj4+ICsrKyBiL2RyaXZlcnMv
aW9tbXUvZG1hLWlvbW11LmMKPj4gQEAgLTQyOSwxNCArNDI5LDYgQEAgc3RhdGljIGRtYV9hZGRy
X3QgaW9tbXVfZG1hX2FsbG9jX2lvdmEoc3RydWN0IAo+PiBpb21tdV9kb21haW4gKmRvbWFpbiwK
Pj4gwqDCoMKgwqDCoCBzaGlmdCA9IGlvdmFfc2hpZnQoaW92YWQpOwo+PiDCoMKgwqDCoMKgIGlv
dmFfbGVuID0gc2l6ZSA+PiBzaGlmdDsKPj4gLcKgwqDCoCAvKgo+PiAtwqDCoMKgwqAgKiBGcmVl
aW5nIG5vbi1wb3dlci1vZi10d28tc2l6ZWQgYWxsb2NhdGlvbnMgYmFjayBpbnRvIHRoZSBJT1ZB
IAo+PiBjYWNoZXMKPj4gLcKgwqDCoMKgICogd2lsbCBjb21lIGJhY2sgdG8gYml0ZSB1cyBiYWRs
eSwgc28gd2UgaGF2ZSB0byB3YXN0ZSBhIGJpdCBvZiAKPj4gc3BhY2UKPj4gLcKgwqDCoMKgICog
cm91bmRpbmcgdXAgYW55dGhpbmcgY2FjaGVhYmxlIHRvIG1ha2Ugc3VyZSB0aGF0IGNhbid0IGhh
cHBlbi4gCj4+IFRoZQo+PiAtwqDCoMKgwqAgKiBvcmRlciBvZiB0aGUgdW5hZGp1c3RlZCBzaXpl
IHdpbGwgc3RpbGwgbWF0Y2ggdXBvbiBmcmVlaW5nLgo+PiAtwqDCoMKgwqAgKi8KPj4gLcKgwqDC
oCBpZiAoaW92YV9sZW4gPCAoMSA8PCAoSU9WQV9SQU5HRV9DQUNIRV9NQVhfU0laRSAtIDEpKSkK
Pj4gLcKgwqDCoMKgwqDCoMKgIGlvdmFfbGVuID0gcm91bmR1cF9wb3dfb2ZfdHdvKGlvdmFfbGVu
KTsKPj4gwqDCoMKgwqDCoCBkbWFfbGltaXQgPSBtaW5fbm90X3plcm8oZG1hX2xpbWl0LCBkZXYt
PmJ1c19kbWFfbGltaXQpOwo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pb3ZhLmMgYi9k
cml2ZXJzL2lvbW11L2lvdmEuYwo+PiBpbmRleCBlNmUyZmE4NTI3MWMuLmU2MmU5ZTMwYjMwYyAx
MDA2NDQKPj4gLS0tIGEvZHJpdmVycy9pb21tdS9pb3ZhLmMKPj4gKysrIGIvZHJpdmVycy9pb21t
dS9pb3ZhLmMKPj4gQEAgLTE3OSw3ICsxNzksNyBAQCBpb3ZhX2luc2VydF9yYnRyZWUoc3RydWN0
IHJiX3Jvb3QgKnJvb3QsIHN0cnVjdCAKPj4gaW92YSAqaW92YSwKPj4gwqAgc3RhdGljIGludCBf
X2FsbG9jX2FuZF9pbnNlcnRfaW92YV9yYW5nZShzdHJ1Y3QgaW92YV9kb21haW4gKmlvdmFkLAo+
PiDCoMKgwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgbG9uZyBzaXplLCB1bnNpZ25lZCBsb25nIGxp
bWl0X3BmbiwKPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGlvdmEgKm5ldywgYm9v
bCBzaXplX2FsaWduZWQpCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBpb3ZhICpu
ZXcsIGJvb2wgc2l6ZV9hbGlnbmVkLCBib29sIGZhc3QpCj4+IMKgIHsKPj4gwqDCoMKgwqDCoCBz
dHJ1Y3QgcmJfbm9kZSAqY3VyciwgKnByZXY7Cj4+IMKgwqDCoMKgwqAgc3RydWN0IGlvdmEgKmN1
cnJfaW92YTsKPj4gQEAgLTE4OCw2ICsxODgsMTUgQEAgc3RhdGljIGludCBfX2FsbG9jX2FuZF9p
bnNlcnRfaW92YV9yYW5nZShzdHJ1Y3QgCj4+IGlvdmFfZG9tYWluICppb3ZhZCwKPj4gwqDCoMKg
wqDCoCB1bnNpZ25lZCBsb25nIGFsaWduX21hc2sgPSB+MFVMOwo+PiDCoMKgwqDCoMKgIHVuc2ln
bmVkIGxvbmcgaGlnaF9wZm4gPSBsaW1pdF9wZm4sIGxvd19wZm4gPSBpb3ZhZC0+c3RhcnRfcGZu
Owo+PiArwqDCoMKgIC8qCj4+ICvCoMKgwqDCoCAqIEZyZWVpbmcgbm9uLXBvd2VyLW9mLXR3by1z
aXplZCBhbGxvY2F0aW9ucyBiYWNrIGludG8gdGhlIElPVkEgCj4+IGNhY2hlcwo+PiArwqDCoMKg
wqAgKiB3aWxsIGNvbWUgYmFjayB0byBiaXRlIHVzIGJhZGx5LCBzbyB3ZSBoYXZlIHRvIHdhc3Rl
IGEgYml0IG9mIAo+PiBzcGFjZQo+PiArwqDCoMKgwqAgKiByb3VuZGluZyB1cCBhbnl0aGluZyBj
YWNoZWFibGUgdG8gbWFrZSBzdXJlIHRoYXQgY2FuJ3QgaGFwcGVuLiAKPj4gVGhlCj4+ICvCoMKg
wqDCoCAqIG9yZGVyIG9mIHRoZSB1bmFkanVzdGVkIHNpemUgd2lsbCBzdGlsbCBtYXRjaCB1cG9u
IGZyZWVpbmcuCj4+ICvCoMKgwqDCoCAqLwo+PiArwqDCoMKgIGlmIChmYXN0ICYmIHNpemUgPCAo
MSA8PCAoSU9WQV9SQU5HRV9DQUNIRV9NQVhfU0laRSAtIDEpKSkKPj4gK8KgwqDCoMKgwqDCoMKg
IHNpemUgPSByb3VuZHVwX3Bvd19vZl90d28oc2l6ZSk7Cj4gCj4gSWYgdGhpcyB0cmFuc2Zvcm1h
dGlvbiBpcyBvbmx5IHJlbGV2YW50IHRvIGFsbG9jX2lvdmFfZmFzdCgpLCBhbmQgd2UgCj4gaGF2
ZSB0byBhZGQgYSBzcGVjaWFsIHBhcmFtZXRlciBoZXJlIHRvIHRlbGwgd2hldGhlciB3ZSB3ZXJl
IGNhbGxlZCBmcm9tIAo+IGFsbG9jX2lvdmFfZmFzdCgpLCBkb2Vzbid0IGl0IHNlZW0gbW9yZSBz
ZW5zaWJsZSB0byBqdXN0IGRvIGl0IGluIAo+IGFsbG9jX2lvdmFfZmFzdCgpIHJhdGhlciB0aGFu
IGhlcmU/CgpXZSBoYXZlIHRoZSByZXN0cmljdGlvbiB0aGF0IGFueXRoaW5nIHdlIHB1dCBpbiB0
aGUgcmNhY2hlIG5lZWRzIGJlIGEgCnBvd2VyLW9mLTIuCgpTbyB0aGVuIHdlIGhhdmUgdGhlIGlz
c3VlIG9mIGhvdyB0byBkeW5hbWljYWxseSBpbmNyZWFzZSB0aGlzIHJjYWNoZSAKdGhyZXNob2xk
LiBUaGUgcHJvYmxlbSBpcyB0aGF0IHdlIG1heSBoYXZlIG1hbnkgZGV2aWNlcyBhc3NvY2lhdGVk
IHdpdGggCnRoZSBzYW1lIGRvbWFpbi4gU28sIGluIHRoZW9yeSwgd2UgY2FuJ3QgYXNzdW1lIHRo
YXQgd2hlbiB3ZSBpbmNyZWFzZSAKdGhlIHRocmVzaG9sZCB0aGF0IHNvbWUgb3RoZXIgZGV2aWNl
IHdpbGwgdHJ5IHRvIGZhc3QgZnJlZSBhbiBJT1ZBIHdoaWNoIAp3YXMgYWxsb2NhdGVkIHByaW9y
IHRvIHRoZSBpbmNyZWFzZSBhbmQgd2FzIG5vdCByb3VuZGVkIHVwLgoKSSdtIHZlcnkgb3BlbiB0
byBiZXR0ZXIgKG9yIGxlc3MgYmFkKSBzdWdnZXN0aW9ucyBvbiBob3cgdG8gZG8gdGhpcyAuLi4K
CkkgY291bGQgc2F5IHRoYXQgd2Ugb25seSBhbGxvdyB0aGlzIGZvciBhIGdyb3VwIHdpdGggYSBz
aW5nbGUgZGV2aWNlLCBzbyAKdGhlc2Ugc29ydCBvZiB0aGluZ3MgZG9uJ3QgaGF2ZSB0byBiZSB3
b3JyaWVkIGFib3V0LCBidXQgZXZlbiB0aGVuIHRoZSAKaW9tbXVfZ3JvdXAgaW50ZXJuYWxzIGFy
ZSBub3QgcmVhZGlseSBhY2Nlc3NpYmxlIGhlcmUuCgo+IAo+IEJ1dCB0aGVuIHRoZSBBUEkgaXRz
ZWxmIGhhcyBubyBzdHJpY3QgcmVxdWlyZW1lbnQgdGhhdCBhIHBmbiBwYXNzZWQgdG8gCj4gZnJl
ZV9pb3ZhX2Zhc3QoKSB3YXNuJ3Qgb3JpZ2luYWxseSBhbGxvY2F0ZWQgd2l0aCBhbGxvY19pb3Zh
KCksIHNvIAo+IGFyZ3VhYmx5IGhpZGluZyB0aGUgYWRqdXN0bWVudCBhd2F5IG1ha2VzIGl0IGxl
c3MgY2xlYXIgdGhhdCB0aGUgCj4gcmVzcG9uc2liaWxpdHkgaXMgcmVhbGx5IG9uIGFueSBjYWxs
ZXIgb2YgZnJlZV9pb3ZhX2Zhc3QoKSB0byBtYWtlIHN1cmUgCj4gdGhleSBkb24ndCBnZXQgdGhp
bmdzIHdyb25nLgo+IAoKYWxsb2NfaW92YSgpIGRvZXNuJ3Qgcm91bmR1cCB0byBwb3ctb2YtMiwg
c28gd291bGRuJ3QgaXQgYmUgYnJva2VuIHRvIGRvIAp0aGF0PwoKQ2hlZXJzLApKb2huCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcg
bGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
