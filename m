Return-Path: <SRS0=56b4=IQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB6FC433E0
	for <iommu@archiver.kernel.org>; Thu, 18 Mar 2021 11:41:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D8E964F33
	for <iommu@archiver.kernel.org>; Thu, 18 Mar 2021 11:41:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D8E964F33
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BBEFE6F9C9;
	Thu, 18 Mar 2021 11:41:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w4SwDM_jJqTs; Thu, 18 Mar 2021 11:41:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 88C3B606B0;
	Thu, 18 Mar 2021 11:41:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6A6A8C000A;
	Thu, 18 Mar 2021 11:41:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9C8CEC0001
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 11:41:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7B1E684272
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 11:41:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mq-DyVxQAu25 for <iommu@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 11:41:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E5FC08425B
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 11:41:02 +0000 (UTC)
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4F1Q0z6vdJz6804r;
 Thu, 18 Mar 2021 19:34:43 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 18 Mar 2021 12:40:59 +0100
Received: from [10.47.0.142] (10.47.0.142) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 18 Mar
 2021 11:40:58 +0000
Subject: Re: [PATCH 2/2] iommu/iova: Improve restart logic
From: John Garry <john.garry@huawei.com>
To: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>
References: <03931d86c0ad71f44b29394e3a8d38bfc32349cd.1614962123.git.robin.murphy@arm.com>
 <076b3484d1e5057b95d8c387c894bd6ad2514043.1614962123.git.robin.murphy@arm.com>
 <c1181e3b-cdf3-c658-1c57-8ec86d034f4b@huawei.com>
 <d8e80756-a628-3a0d-77ac-1e9df734f1c5@huawei.com>
Message-ID: <6cea11f9-e98d-98cb-6789-93abd8833fa0@huawei.com>
Date: Thu, 18 Mar 2021 11:38:49 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <d8e80756-a628-3a0d-77ac-1e9df734f1c5@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.47.0.142]
X-ClientProxiedBy: lhreml730-chm.china.huawei.com (10.201.108.81) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: vjitta@codeaurora.org, iommu@lists.linux-foundation.org,
 Linuxarm <linuxarm@huawei.com>, linux-kernel@vger.kernel.org
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

T24gMTAvMDMvMjAyMSAxNzo0NywgSm9obiBHYXJyeSB3cm90ZToKPiBPbiAwOS8wMy8yMDIxIDE1
OjU1LCBKb2huIEdhcnJ5IHdyb3RlOgo+PiBPbiAwNS8wMy8yMDIxIDE2OjM1LCBSb2JpbiBNdXJw
aHkgd3JvdGU6Cj4+Cj4+IEhpIFJvYmluLAo+Pgo+Pj4gV2hlbiByZXN0YXJ0aW5nIGFmdGVyIHNl
YXJjaGluZyBiZWxvdyB0aGUgY2FjaGVkIG5vZGUgZmFpbHMsIHJlc2V0dGluZwo+Pj4gdGhlIHN0
YXJ0IHBvaW50IHRvIHRoZSBhbmNob3Igbm9kZSBpcyBvZnRlbiBvdmVybHkgcGVzc2ltaXN0aWMu
IElmCj4+PiBhbGxvY2F0aW9ucyBhcmUgbWFkZSB3aXRoIG1peGVkIGxpbWl0cyAtIHBhcnRpY3Vs
YXJseSBpbiB0aGUgY2FzZSBvZiB0aGUKPj4+IG9wcG9ydHVuaXN0aWMgMzItYml0IGFsbG9jYXRp
b24gZm9yIFBDSSBkZXZpY2VzIC0gdGhpcyBjb3VsZCBtZWFuCj4+PiBzaWduaWZpY2FudCB0aW1l
IHdhc3RlZCB3YWxraW5nIHRocm91Z2ggdGhlIHdob2xlIHBvcHVsYXRlZCB1cHBlciByYW5nZQo+
Pj4ganVzdCB0byByZWFjaCB0aGUgaW5pdGlhbCBsaW1pdC4gCj4+Cj4+IFJpZ2h0Cj4+Cj4+PiBX
ZSBjYW4gaW1wcm92ZSBvbiB0aGF0IGJ5IGltcGxlbWVudGluZwo+Pj4gYSBwcm9wZXIgdHJlZSB0
cmF2ZXJzYWwgdG8gZmluZCB0aGUgZmlyc3Qgbm9kZSBhYm92ZSB0aGUgcmVsZXZhbnQgbGltaXQs
Cj4+PiBhbmQgc2V0IHRoZSBleGFjdCBzdGFydCBwb2ludC4KPj4KPj4gVGhhbmtzIGZvciB0aGlz
LiBIb3dldmVyLCBhcyBtZW50aW9uZWQgaW4gdGhlIG90aGVyIHRocmVhZCwgdGhpcyBkb2VzIAo+
PiBub3QgaGVscCBvdXIgcGVyZm9ybWFuY2UgcmVncmVzc2lvbiBSZTogY29tbWl0IDRlODlkY2U3
MjUyMS4KPj4KPj4gQW5kIG1lbnRpb25pbmcgdGhpcyAicmV0cnkiIGFwcHJvYWNoIGFnYWluLCBp
biBjYXNlIGl0IHdhcyBtaXNzZWQsIAo+PiBmcm9tIG15IGV4cGVyaW1lbnQgb24gdGhlIGFmZmVj
dGVkIEhXLCBpdCBhbHNvIGhhcyBnZW5lcmFsbHkgYSAKPj4gZHJlYWRmdWxseSBsb3cgc3VjY2Vz
cyByYXRlIC0gbGVzcyB0aGFuIDElIGZvciB0aGUgMzJiIHJhbmdlIHJldHJ5LiAKPj4gUmV0cnkg
cmF0ZSBpcyBhYm91dCAyMCUuIFNvIEkgYW0gc2F5aW5nIGZyb20gdGhpcyAyMCUsIGxlc3MgdGhh
biAxJSBvZiAKPj4gdGhvc2Ugc3VjY2VlZC4KPj4KPiAKPiBTbyBzaW5jZSB0aGUgcmV0cnkgbWVh
bnMgdGhhdCB3ZSBzZWFyY2ggdGhyb3VnaCB0aGUgY29tcGxldGUgcGZuIHJhbmdlIAo+IG1vc3Qg
b2YgdGhlIHRpbWUgKGR1ZSB0byBwb29yIHN1Y2Nlc3MgcmF0ZSksIHdlIHNob3VsZCBiZSBhYmxl
IHRvIGRvIGEgCj4gYmV0dGVyIGpvYiBhdCBtYWludGFpbmluZyBhbiBhY2N1cmF0ZSBtYXggYWxs
b2Mgc2l6ZSwgYnkgY2FsY3VsYXRpbmcgaXQgCj4gZnJvbSB0aGUgcmFuZ2Ugc2VhcmNoLCBhbmQg
bm90IHJlbHlpbmcgb24gbWF4IGFsbG9jIGZhaWxlZCBvciByZXNldHRpbmcgCj4gaXQgZnJlcXVl
bnRseS4gSG9wZWZ1bGx5IHRoYXQgd291bGQgbWVhbiB0aGF0IHdlJ3JlIHNtYXJ0ZXIgYWJvdXQg
bm90IAo+IHRyeWluZyB0aGUgYWxsb2NhdGlvbi4KClNvIEkgdHJpZWQgdGhhdCBvdXQgYW5kIHdl
IHNlZW0gdG8gYmUgYWJsZSB0byBzY3JhcCBiYWNrIGFuIGFwcHJlY2lhYmxlIAphbW91bnQgb2Yg
cGVyZm9ybWFuY2UuIE1heWJlIDgwJSBvZiBvcmlnaW5hbCwgd2l0aCB3aXRoIGFub3RoZXIgY2hh
bmdlLCAKYmVsb3cuCgpUaGFua3MsCkpvaG4KCj4gCj4gCj4+Cj4+Pgo+Pj4gU2lnbmVkLW9mZi1i
eTogUm9iaW4gTXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT4KPj4+IC0tLQo+Pj4gwqAgZHJp
dmVycy9pb21tdS9pb3ZhLmMgfCAzOSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKy0KPj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAzOCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
KC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvaW92YS5jIGIvZHJpdmVycy9p
b21tdS9pb3ZhLmMKPj4+IGluZGV4IGMyODAwM2UxZDJlZS4uNDcxYzQ4ZGQ3MWU3IDEwMDY0NAo+
Pj4gLS0tIGEvZHJpdmVycy9pb21tdS9pb3ZhLmMKPj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvaW92
YS5jCj4+PiBAQCAtMTU0LDYgKzE1NCw0MyBAQCBfX2NhY2hlZF9yYm5vZGVfZGVsZXRlX3VwZGF0
ZShzdHJ1Y3QgaW92YV9kb21haW4gCj4+PiAqaW92YWQsIHN0cnVjdCBpb3ZhICpmcmVlKQo+Pj4g
wqDCoMKgwqDCoMKgwqDCoMKgIGlvdmFkLT5jYWNoZWRfbm9kZSA9IHJiX25leHQoJmZyZWUtPm5v
ZGUpOwo+Pj4gwqAgfQo+Pj4gK3N0YXRpYyBzdHJ1Y3QgcmJfbm9kZSAqaW92YV9maW5kX2xpbWl0
KHN0cnVjdCBpb3ZhX2RvbWFpbiAqaW92YWQsIAo+Pj4gdW5zaWduZWQgbG9uZyBsaW1pdF9wZm4p
Cj4+PiArewo+Pj4gK8KgwqDCoCBzdHJ1Y3QgcmJfbm9kZSAqbm9kZSwgKm5leHQ7Cj4+PiArwqDC
oMKgIC8qCj4+PiArwqDCoMKgwqAgKiBJZGVhbGx5IHdoYXQgd2UnZCBsaWtlIHRvIGp1ZGdlIGhl
cmUgaXMgd2hldGhlciBsaW1pdF9wZm4gaXMgCj4+PiBjbG9zZQo+Pj4gK8KgwqDCoMKgICogZW5v
dWdoIHRvIHRoZSBoaWdoZXN0LWFsbG9jYXRlZCBJT1ZBIHRoYXQgc3RhcnRpbmcgdGhlIAo+Pj4g
YWxsb2NhdGlvbgo+Pj4gK8KgwqDCoMKgICogd2FsayBmcm9tIHRoZSBhbmNob3Igbm9kZSB3aWxs
IGJlIHF1aWNrZXIgdGhhbiB0aGlzIGluaXRpYWwgCj4+PiB3b3JrIHRvCj4+PiArwqDCoMKgwqAg
KiBmaW5kIGFuIGV4YWN0IHN0YXJ0aW5nIHBvaW50IChlc3BlY2lhbGx5IGlmIHRoYXQgZW5kcyB1
cCAKPj4+IGJlaW5nIHRoZQo+Pj4gK8KgwqDCoMKgICogYW5jaG9yIG5vZGUgYW55d2F5KS4gVGhp
cyBpcyBhbiBpbmNyZWRpYmx5IGNydWRlIAo+Pj4gYXBwcm94aW1hdGlvbiB3aGljaAo+Pj4gK8Kg
wqDCoMKgICogb25seSByZWFsbHkgaGVscHMgdGhlIG1vc3QgbGlrZWx5IGNhc2UsIGJ1dCBpcyBh
dCBsZWFzdCAKPj4+IHRyaXZpYWxseSBlYXN5Lgo+Pj4gK8KgwqDCoMKgICovCj4+PiArwqDCoMKg
IGlmIChsaW1pdF9wZm4gPiBpb3ZhZC0+ZG1hXzMyYml0X3BmbikKPj4+ICvCoMKgwqDCoMKgwqDC
oCByZXR1cm4gJmlvdmFkLT5hbmNob3Iubm9kZTsKPj4+ICsKPj4+ICvCoMKgwqAgbm9kZSA9IGlv
dmFkLT5yYnJvb3QucmJfbm9kZTsKPj4+ICvCoMKgwqAgd2hpbGUgKHRvX2lvdmEobm9kZSktPnBm
bl9oaSA8IGxpbWl0X3BmbikKPj4+ICvCoMKgwqDCoMKgwqDCoCBub2RlID0gbm9kZS0+cmJfcmln
aHQ7Cj4+PiArCj4+PiArc2VhcmNoX2xlZnQ6Cj4+PiArwqDCoMKgIHdoaWxlIChub2RlLT5yYl9s
ZWZ0ICYmIHRvX2lvdmEobm9kZS0+cmJfbGVmdCktPnBmbl9sbyA+PSAKPj4+IGxpbWl0X3BmbikK
Pj4+ICvCoMKgwqDCoMKgwqDCoCBub2RlID0gbm9kZS0+cmJfbGVmdDsKPj4+ICsKPj4+ICvCoMKg
wqAgaWYgKCFub2RlLT5yYl9sZWZ0KQo+Pj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiBub2RlOwo+
Pj4gKwo+Pj4gK8KgwqDCoCBuZXh0ID0gbm9kZS0+cmJfbGVmdDsKPj4+ICvCoMKgwqAgd2hpbGUg
KG5leHQtPnJiX3JpZ2h0KSB7Cj4+PiArwqDCoMKgwqDCoMKgwqAgbmV4dCA9IG5leHQtPnJiX3Jp
Z2h0Owo+Pj4gK8KgwqDCoMKgwqDCoMKgIGlmICh0b19pb3ZhKG5leHQpLT5wZm5fbG8gPj0gbGlt
aXRfcGZuKSB7Cj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBub2RlID0gbmV4dDsKPj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gc2VhcmNoX2xlZnQ7Cj4+PiArwqDCoMKgwqDCoMKg
wqAgfQo+Pj4gK8KgwqDCoCB9Cj4+PiArCj4+PiArwqDCoMKgIHJldHVybiBub2RlOwo+Pj4gK30K
Pj4+ICsKPj4+IMKgIC8qIEluc2VydCB0aGUgaW92YSBpbnRvIGRvbWFpbiByYnRyZWUgYnkgaG9s
ZGluZyB3cml0ZXIgbG9jayAqLwo+Pj4gwqAgc3RhdGljIHZvaWQKPj4+IMKgIGlvdmFfaW5zZXJ0
X3JidHJlZShzdHJ1Y3QgcmJfcm9vdCAqcm9vdCwgc3RydWN0IGlvdmEgKmlvdmEsCj4+PiBAQCAt
MjE5LDcgKzI1Niw3IEBAIHN0YXRpYyBpbnQgX19hbGxvY19hbmRfaW5zZXJ0X2lvdmFfcmFuZ2Uo
c3RydWN0IAo+Pj4gaW92YV9kb21haW4gKmlvdmFkLAo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIGlm
IChsb3dfcGZuID09IGlvdmFkLT5zdGFydF9wZm4gJiYgcmV0cnlfcGZuIDwgbGltaXRfcGZuKSB7
Cj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBoaWdoX3BmbiA9IGxpbWl0X3BmbjsKPj4+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGxvd19wZm4gPSByZXRyeV9wZm47Cj4+PiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBjdXJyID0gJmlvdmFkLT5hbmNob3Iubm9kZTsKPj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGN1cnIgPSBpb3ZhX2ZpbmRfbGltaXQoaW92YWQsIGxpbWl0X3Bm
bik7CgoKSSBzZWUgdGhhdCBpdCBpcyBub3cgYXBwbGllZC4gSG93ZXZlciwgYWx0ZXJuYXRpdmVs
eSBjb3VsZCB3ZSBqdXN0IGFkZCBhIAp6ZXJvLWxlbmd0aCAzMmIgYm91bmRhcnkgbWFya2VyIG5v
ZGUgZm9yIHRoZSAzMmIgcGZuIHJlc3RhcnQgcG9pbnQ/Cgo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgY3Vycl9pb3ZhID0gdG9faW92YShjdXJyKTsKPj4+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGdvdG8gcmV0cnk7Cj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+Pj4KPj4KPj4g
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPj4gaW9tbXUg
bWFpbGluZyBsaXN0Cj4+IGlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCj4+IGh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11Cj4+IC4K
PiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11
IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
