Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93244C433EF
	for <iommu@archiver.kernel.org>; Thu, 23 Jun 2022 08:38:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 28BE960758;
	Thu, 23 Jun 2022 08:38:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 28BE960758
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0Em3loXBtDvA; Thu, 23 Jun 2022 08:38:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B946A60E66;
	Thu, 23 Jun 2022 08:38:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B946A60E66
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5D44AC0032;
	Thu, 23 Jun 2022 08:38:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E3C79C002D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 08:38:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B584560E66
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 08:38:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B584560E66
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2fMO1abpHi01 for <iommu@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 08:38:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C23AE60758
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C23AE60758
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 08:38:10 +0000 (UTC)
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LTD9f6t10z67wtW;
 Thu, 23 Jun 2022 16:36:06 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Thu, 23 Jun 2022 10:38:07 +0200
Received: from [10.195.245.183] (10.195.245.183) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2375.24; Thu, 23 Jun 2022 09:38:06 +0100
Message-ID: <ebe0ce98-4a02-1e94-d21b-ccb010abfd2d@huawei.com>
Date: Thu, 23 Jun 2022 09:38:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3 2/4] dma-iommu: Add iommu_dma_opt_mapping_size()
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>
References: <1654507822-168026-1-git-send-email-john.garry@huawei.com>
 <1654507822-168026-3-git-send-email-john.garry@huawei.com>
 <4a3ab043-f609-22cb-895f-e67c8dd8f6ab@huawei.com>
In-Reply-To: <4a3ab043-f609-22cb-895f-e67c8dd8f6ab@huawei.com>
X-Originating-IP: [10.195.245.183]
X-ClientProxiedBy: lhreml705-chm.china.huawei.com (10.201.108.54) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 linux-doc@vger.kernel.org, liyihang6@hisilicon.com,
 damien.lemoal@opensource.wdc.com, linux-kernel@vger.kernel.org, hch@lst.de,
 linux-ide@vger.kernel.org, iommu@lists.linux-foundation.org,
 jejb@linux.ibm.com
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
From: John Garry via iommu <iommu@lists.linux-foundation.org>
Reply-To: John Garry <john.garry@huawei.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gMTQvMDYvMjAyMiAxNDoxMiwgSm9obiBHYXJyeSB3cm90ZToKPiBPbiAwNi8wNi8yMDIyIDEw
OjMwLCBKb2huIEdhcnJ5IHdyb3RlOgo+PiBBZGQgdGhlIElPTU1VIGNhbGxiYWNrIGZvciBETUEg
bWFwcGluZyBBUEkgZG1hX29wdF9tYXBwaW5nX3NpemUoKSwgd2hpY2gKPj4gYWxsb3dzIHRoZSBk
cml2ZXJzIHRvIGtub3cgdGhlIG9wdGltYWwgbWFwcGluZyBsaW1pdCBhbmQgdGh1cyBsaW1pdCB0
aGUKPj4gcmVxdWVzdGVkIElPVkEgbGVuZ3Rocy4KPj4KPj4gVGhpcyB2YWx1ZSBpcyBiYXNlZCBv
biB0aGUgSU9WQSByY2FjaGUgcmFuZ2UgbGltaXQsIGFzIElPVkFzIGFsbG9jYXRlZAo+PiBhYm92
ZSB0aGlzIGxpbWl0IG11c3QgYWx3YXlzIGJlIG5ld2x5IGFsbG9jYXRlZCwgd2hpY2ggbWF5IGJl
IHF1aXRlIHNsb3cuCj4+Cj4gCj4gQ2FuIEkgcGxlYXNlIGdldCBzb21lIHNvcnQgb2YgYWNrIGZy
b20gdGhlIElPTU1VIHBlb3BsZSBvbiB0aGlzIG9uZT8KPiAKCkFub3RoZXIgcmVxdWVzdCBmb3Ig
YW4gYWNrIHBsZWFzZS4KClRoYW5rcywKam9obgoKPiAKPj4gU2lnbmVkLW9mZi1ieTogSm9obiBH
YXJyeSA8am9obi5nYXJyeUBodWF3ZWkuY29tPgo+PiBSZXZpZXdlZC1ieTogRGFtaWVuIExlIE1v
YWwgPGRhbWllbi5sZW1vYWxAb3BlbnNvdXJjZS53ZGMuY29tPgo+PiAtLS0KPj4gwqAgZHJpdmVy
cy9pb21tdS9kbWEtaW9tbXUuYyB8IDYgKysrKysrCj4+IMKgIGRyaXZlcnMvaW9tbXUvaW92YS5j
wqDCoMKgwqDCoCB8IDUgKysrKysKPj4gwqAgaW5jbHVkZS9saW51eC9pb3ZhLmjCoMKgwqDCoMKg
IHwgMiArKwo+PiDCoCAzIGZpbGVzIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKykKPj4KPj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvZG1hLWlvbW11LmMgYi9kcml2ZXJzL2lvbW11L2RtYS1p
b21tdS5jCj4+IGluZGV4IGY5MDI1MTU3MmE1ZC4uOWUxNTg2NDQ3ZWU4IDEwMDY0NAo+PiAtLS0g
YS9kcml2ZXJzL2lvbW11L2RtYS1pb21tdS5jCj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvZG1hLWlv
bW11LmMKPj4gQEAgLTE0NTksNiArMTQ1OSwxMSBAQCBzdGF0aWMgdW5zaWduZWQgbG9uZyAKPj4g
aW9tbXVfZG1hX2dldF9tZXJnZV9ib3VuZGFyeShzdHJ1Y3QgZGV2aWNlICpkZXYpCj4+IMKgwqDC
oMKgwqAgcmV0dXJuICgxVUwgPDwgX19mZnMoZG9tYWluLT5wZ3NpemVfYml0bWFwKSkgLSAxOwo+
PiDCoCB9Cj4+ICtzdGF0aWMgc2l6ZV90IGlvbW11X2RtYV9vcHRfbWFwcGluZ19zaXplKHZvaWQp
Cj4+ICt7Cj4+ICvCoMKgwqAgcmV0dXJuIGlvdmFfcmNhY2hlX3JhbmdlKCk7Cj4+ICt9Cj4+ICsK
Pj4gwqAgc3RhdGljIGNvbnN0IHN0cnVjdCBkbWFfbWFwX29wcyBpb21tdV9kbWFfb3BzID0gewo+
PiDCoMKgwqDCoMKgIC5hbGxvY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgPSBpb21tdV9kbWFfYWxs
b2MsCj4+IMKgwqDCoMKgwqAgLmZyZWXCoMKgwqDCoMKgwqDCoMKgwqDCoMKgID0gaW9tbXVfZG1h
X2ZyZWUsCj4+IEBAIC0xNDc5LDYgKzE0ODQsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGRtYV9t
YXBfb3BzIGlvbW11X2RtYV9vcHMgPSB7Cj4+IMKgwqDCoMKgwqAgLm1hcF9yZXNvdXJjZcKgwqDC
oMKgwqDCoMKgID0gaW9tbXVfZG1hX21hcF9yZXNvdXJjZSwKPj4gwqDCoMKgwqDCoCAudW5tYXBf
cmVzb3VyY2XCoMKgwqDCoMKgwqDCoCA9IGlvbW11X2RtYV91bm1hcF9yZXNvdXJjZSwKPj4gwqDC
oMKgwqDCoCAuZ2V0X21lcmdlX2JvdW5kYXJ5wqDCoMKgID0gaW9tbXVfZG1hX2dldF9tZXJnZV9i
b3VuZGFyeSwKPj4gK8KgwqDCoCAub3B0X21hcHBpbmdfc2l6ZcKgwqDCoCA9IGlvbW11X2RtYV9v
cHRfbWFwcGluZ19zaXplLAo+PiDCoCB9Owo+PiDCoCAvKgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9pb21tdS9pb3ZhLmMgYi9kcml2ZXJzL2lvbW11L2lvdmEuYwo+PiBpbmRleCBkYjc3YWE2NzUx
NDUuLjlmMDBiNThkNTQ2ZSAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9pb21tdS9pb3ZhLmMKPj4g
KysrIGIvZHJpdmVycy9pb21tdS9pb3ZhLmMKPj4gQEAgLTI2LDYgKzI2LDExIEBAIHN0YXRpYyB1
bnNpZ25lZCBsb25nIGlvdmFfcmNhY2hlX2dldChzdHJ1Y3QgCj4+IGlvdmFfZG9tYWluICppb3Zh
ZCwKPj4gwqAgc3RhdGljIHZvaWQgZnJlZV9jcHVfY2FjaGVkX2lvdmFzKHVuc2lnbmVkIGludCBj
cHUsIHN0cnVjdCAKPj4gaW92YV9kb21haW4gKmlvdmFkKTsKPj4gwqAgc3RhdGljIHZvaWQgZnJl
ZV9pb3ZhX3JjYWNoZXMoc3RydWN0IGlvdmFfZG9tYWluICppb3ZhZCk7Cj4+ICt1bnNpZ25lZCBs
b25nIGlvdmFfcmNhY2hlX3JhbmdlKHZvaWQpCj4+ICt7Cj4+ICvCoMKgwqAgcmV0dXJuIFBBR0Vf
U0laRSA8PCAoSU9WQV9SQU5HRV9DQUNIRV9NQVhfU0laRSAtIDEpOwo+PiArfQo+PiArCj4+IMKg
IHN0YXRpYyBpbnQgaW92YV9jcHVocF9kZWFkKHVuc2lnbmVkIGludCBjcHUsIHN0cnVjdCBobGlz
dF9ub2RlICpub2RlKQo+PiDCoCB7Cj4+IMKgwqDCoMKgwqAgc3RydWN0IGlvdmFfZG9tYWluICpp
b3ZhZDsKPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvaW92YS5oIGIvaW5jbHVkZS9saW51
eC9pb3ZhLmgKPj4gaW5kZXggMzIwYTcwZTQwMjMzLi5jNmJhNmQ5NWQ3OWMgMTAwNjQ0Cj4+IC0t
LSBhL2luY2x1ZGUvbGludXgvaW92YS5oCj4+ICsrKyBiL2luY2x1ZGUvbGludXgvaW92YS5oCj4+
IEBAIC03OSw2ICs3OSw4IEBAIHN0YXRpYyBpbmxpbmUgdW5zaWduZWQgbG9uZyBpb3ZhX3Bmbihz
dHJ1Y3QgCj4+IGlvdmFfZG9tYWluICppb3ZhZCwgZG1hX2FkZHJfdCBpb3ZhKQo+PiDCoCBpbnQg
aW92YV9jYWNoZV9nZXQodm9pZCk7Cj4+IMKgIHZvaWQgaW92YV9jYWNoZV9wdXQodm9pZCk7Cj4+
ICt1bnNpZ25lZCBsb25nIGlvdmFfcmNhY2hlX3JhbmdlKHZvaWQpOwo+PiArCj4+IMKgIHZvaWQg
ZnJlZV9pb3ZhKHN0cnVjdCBpb3ZhX2RvbWFpbiAqaW92YWQsIHVuc2lnbmVkIGxvbmcgcGZuKTsK
Pj4gwqAgdm9pZCBfX2ZyZWVfaW92YShzdHJ1Y3QgaW92YV9kb21haW4gKmlvdmFkLCBzdHJ1Y3Qg
aW92YSAqaW92YSk7Cj4+IMKgIHN0cnVjdCBpb3ZhICphbGxvY19pb3ZhKHN0cnVjdCBpb3ZhX2Rv
bWFpbiAqaW92YWQsIHVuc2lnbmVkIGxvbmcgc2l6ZSwKPiAKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby9pb21tdQ==
