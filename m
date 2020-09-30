Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67917C4727F
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 05:59:23 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0759E206DB
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 05:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="SRir953u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0759E206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id AB04686031;
	Wed, 30 Sep 2020 05:59:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7kPrdFoec1lL; Wed, 30 Sep 2020 05:59:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0D46D83468;
	Wed, 30 Sep 2020 05:59:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 06E9FC0889;
	Wed, 30 Sep 2020 05:59:22 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 56359C0051
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 05:59:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 3F7C120365
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 05:59:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jVXGKddqC0Us for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 05:59:20 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from m42-4.mailgun.net (m42-4.mailgun.net [69.72.42.4])
 by silver.osuosl.org (Postfix) with ESMTPS id 2F7902034C
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 05:59:20 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1601445560; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: References: Cc: To: From:
 Subject: Sender; bh=Z7oAfbjIbqFuJZ2OPG4jTiveLuRD86cSV3+ivLnS8Yw=;
 b=SRir953uVPCmbSgTjJpy/jdQC8/IiRtpD6be/F6Qq4Z5fooUxknnTCATqcvFG4xe/KNoqkBa
 1kxk/hkoMe87C697R9HOo25+uJiZ+qZWvtkJkZ6i+rWN0EW6T4Td+w5yBfUjde1BX4j5qvmj
 F4v2cuXkQTLREZOroGfCTaof54s=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5f741eb7be59ebabf3c29b5e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 30 Sep 2020 05:59:19
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 78485C43382; Wed, 30 Sep 2020 05:59:18 +0000 (UTC)
Received: from [192.168.0.101] (unknown [103.248.210.206])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: vjitta)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 76B32C433F1;
 Wed, 30 Sep 2020 05:59:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 76B32C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=fail smtp.mailfrom=vjitta@codeaurora.org
Subject: Re: [PATCH v2 2/2] iommu/iova: Free global iova rcache on iova alloc
 failure
From: Vijayanand Jitta <vjitta@codeaurora.org>
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <1597927761-24441-1-git-send-email-vjitta@codeaurora.org>
 <1597927761-24441-2-git-send-email-vjitta@codeaurora.org>
 <2f20160a-b9da-4fa3-3796-ed90c6175ebe@arm.com>
 <9dac89a4-553a-efe2-08a1-6a3a5fbc97a8@codeaurora.org>
Message-ID: <bb4c4fe4-50b6-5218-0cb5-43bcba9e9bff@codeaurora.org>
Date: Wed, 30 Sep 2020 11:29:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <9dac89a4-553a-efe2-08a1-6a3a5fbc97a8@codeaurora.org>
Content-Language: en-GB
Cc: vinmenon@codeaurora.org, kernel-team@android.com
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

CgpPbiA5LzI4LzIwMjAgNjoxMSBQTSwgVmlqYXlhbmFuZCBKaXR0YSB3cm90ZToKPiAKPiAKPiBP
biA5LzE4LzIwMjAgODoxMSBQTSwgUm9iaW4gTXVycGh5IHdyb3RlOgo+PiBPbiAyMDIwLTA4LTIw
IDEzOjQ5LCB2aml0dGFAY29kZWF1cm9yYS5vcmcgd3JvdGU6Cj4+PiBGcm9tOiBWaWpheWFuYW5k
IEppdHRhIDx2aml0dGFAY29kZWF1cm9yYS5vcmc+Cj4+Pgo+Pj4gV2hlbiBldmVyIGFuIGlvdmEg
YWxsb2MgcmVxdWVzdCBmYWlscyB3ZSBmcmVlIHRoZSBpb3ZhCj4+PiByYW5nZXMgcHJlc2VudCBp
biB0aGUgcGVyY3B1IGlvdmEgcmNhY2hlcyBhbmQgdGhlbiByZXRyeQo+Pj4gYnV0IHRoZSBnbG9i
YWwgaW92YSByY2FjaGUgaXMgbm90IGZyZWVkIGFzIGEgcmVzdWx0IHdlIGNvdWxkCj4+PiBzdGls
bCBzZWUgaW92YSBhbGxvYyBmYWlsdXJlIGV2ZW4gYWZ0ZXIgcmV0cnkgYXMgZ2xvYmFsCj4+PiBy
Y2FjaGUgaXMgaG9sZGluZyB0aGUgaW92YSdzIHdoaWNoIGNhbiBjYXVzZSBmcmFnbWVudGF0aW9u
Lgo+Pj4gU28sIGZyZWUgdGhlIGdsb2JhbCBpb3ZhIHJjYWNoZSBhcyB3ZWxsIGFuZCB0aGVuIGdv
IGZvciB0aGUKPj4+IHJldHJ5Lgo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IFZpamF5YW5hbmQgSml0
dGEgPHZqaXR0YUBjb2RlYXVyb3JhLm9yZz4KPj4+IC0tLQo+Pj4gwqAgZHJpdmVycy9pb21tdS9p
b3ZhLmMgfCAyMyArKysrKysrKysrKysrKysrKysrKysrKwo+Pj4gwqAgaW5jbHVkZS9saW51eC9p
b3ZhLmggfMKgIDYgKysrKysrCj4+PiDCoCAyIGZpbGVzIGNoYW5nZWQsIDI5IGluc2VydGlvbnMo
KykKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pb3ZhLmMgYi9kcml2ZXJzL2lv
bW11L2lvdmEuYwo+Pj4gaW5kZXggNGU3NzExNi4uNTgzNmM4NyAxMDA2NDQKPj4+IC0tLSBhL2Ry
aXZlcnMvaW9tbXUvaW92YS5jCj4+PiArKysgYi9kcml2ZXJzL2lvbW11L2lvdmEuYwo+Pj4gQEAg
LTQ0Miw2ICs0NDIsNyBAQCBzdHJ1Y3QgaW92YSAqZmluZF9pb3ZhKHN0cnVjdCBpb3ZhX2RvbWFp
biAqaW92YWQsCj4+PiB1bnNpZ25lZCBsb25nIHBmbikKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBm
bHVzaF9yY2FjaGUgPSBmYWxzZTsKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBmb3JfZWFjaF9vbmxp
bmVfY3B1KGNwdSkKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZyZWVfY3B1X2NhY2hl
ZF9pb3ZhcyhjcHUsIGlvdmFkKTsKPj4+ICvCoMKgwqDCoMKgwqDCoCBmcmVlX2dsb2JhbF9jYWNo
ZWRfaW92YXMoaW92YWQpOwo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gcmV0cnk7Cj4+PiDC
oMKgwqDCoMKgIH0KPj4+IMKgIEBAIC0xMDU1LDUgKzEwNTYsMjcgQEAgdm9pZCBmcmVlX2NwdV9j
YWNoZWRfaW92YXModW5zaWduZWQgaW50IGNwdSwKPj4+IHN0cnVjdCBpb3ZhX2RvbWFpbiAqaW92
YWQpCj4+PiDCoMKgwqDCoMKgIH0KPj4+IMKgIH0KPj4+IMKgICsvKgo+Pj4gKyAqIGZyZWUgYWxs
IHRoZSBJT1ZBIHJhbmdlcyBvZiBnbG9iYWwgY2FjaGUKPj4+ICsgKi8KPj4+ICt2b2lkIGZyZWVf
Z2xvYmFsX2NhY2hlZF9pb3ZhcyhzdHJ1Y3QgaW92YV9kb21haW4gKmlvdmFkKQo+Pgo+PiBBcyBK
b2huIHBvaW50ZWQgb3V0IGxhc3QgdGltZSwgdGhpcyBzaG91bGQgYmUgc3RhdGljIGFuZCB0aGUg
aGVhZGVyCj4+IGNoYW5nZXMgZHJvcHBlZC4KPj4KPj4gKFRCSCB3ZSBzaG91bGQgcHJvYmFibHkg
cmVnaXN0ZXIgb3VyIG93biBob3RwbHVnIG5vdGlmaWVyIGluc3RhbmNlIGZvciBhCj4+IGZsdXNo
IHF1ZXVlLCBzbyB0aGF0IGV4dGVybmFsIGNvZGUgaGFzIG5vIG5lZWQgdG8gcG9rZSBhdCB0aGUg
cGVyLUNQVQo+PiBjYWNoZXMgZWl0aGVyKQo+Pgo+PiBSb2Jpbi4KPj4KPiAKPiBSaWdodCwgSSBo
YXZlIG1hZGUgaXQgc3RhdGljIGFuZCBkcm9wcGVkIGhlYWRlciBjaGFuZ2VzIGluIHYzLgo+IGNh
biB5b3UgcGxlYXNlIHJldmlldyB0aGF0Lgo+IAo+IFRoYW5rcywKPiBWaWpheQoKUGxlYXNlIHJl
dmlldyB2NCBpbnN0ZWFkIG9mIHYzLCBJIGhhdmUgdXBkYXRlZCBvdGhlciBwYXRjaCBhcyB3ZWxs
IGluIHY0LgoKVGhhbmtzLApWaWpheQo+Pj4gK3sKPj4+ICvCoMKgwqAgc3RydWN0IGlvdmFfcmNh
Y2hlICpyY2FjaGU7Cj4+PiArwqDCoMKgIHVuc2lnbmVkIGxvbmcgZmxhZ3M7Cj4+PiArwqDCoMKg
IGludCBpLCBqOwo+Pj4gKwo+Pj4gK8KgwqDCoCBmb3IgKGkgPSAwOyBpIDwgSU9WQV9SQU5HRV9D
QUNIRV9NQVhfU0laRTsgKytpKSB7Cj4+PiArwqDCoMKgwqDCoMKgwqAgcmNhY2hlID0gJmlvdmFk
LT5yY2FjaGVzW2ldOwo+Pj4gK8KgwqDCoMKgwqDCoMKgIHNwaW5fbG9ja19pcnFzYXZlKCZyY2Fj
aGUtPmxvY2ssIGZsYWdzKTsKPj4+ICvCoMKgwqDCoMKgwqDCoCBmb3IgKGogPSAwOyBqIDwgcmNh
Y2hlLT5kZXBvdF9zaXplOyArK2opIHsKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlvdmFf
bWFnYXppbmVfZnJlZV9wZm5zKHJjYWNoZS0+ZGVwb3Rbal0sIGlvdmFkKTsKPj4+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGlvdmFfbWFnYXppbmVfZnJlZShyY2FjaGUtPmRlcG90W2pdKTsKPj4+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJjYWNoZS0+ZGVwb3Rbal0gPSBOVUxMOwo+Pj4gK8Kg
wqDCoMKgwqDCoMKgIH0KPj4+ICvCoMKgwqDCoMKgwqDCoCByY2FjaGUtPmRlcG90X3NpemUgPSAw
Owo+Pj4gK8KgwqDCoMKgwqDCoMKgIHNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJnJjYWNoZS0+bG9j
aywgZmxhZ3MpOwo+Pj4gK8KgwqDCoCB9Cj4+PiArfQo+Pj4gKwo+Pj4gwqAgTU9EVUxFX0FVVEhP
UigiQW5pbCBTIEtlc2hhdmFtdXJ0aHkgPGFuaWwucy5rZXNoYXZhbXVydGh5QGludGVsLmNvbT4i
KTsKPj4+IMKgIE1PRFVMRV9MSUNFTlNFKCJHUEwiKTsKPj4+IGRpZmYgLS1naXQgYS9pbmNsdWRl
L2xpbnV4L2lvdmEuaCBiL2luY2x1ZGUvbGludXgvaW92YS5oCj4+PiBpbmRleCBhMDYzN2FiLi5h
OTA1NzI2IDEwMDY0NAo+Pj4gLS0tIGEvaW5jbHVkZS9saW51eC9pb3ZhLmgKPj4+ICsrKyBiL2lu
Y2x1ZGUvbGludXgvaW92YS5oCj4+PiBAQCAtMTYzLDYgKzE2Myw3IEBAIGludCBpbml0X2lvdmFf
Zmx1c2hfcXVldWUoc3RydWN0IGlvdmFfZG9tYWluICppb3ZhZCwKPj4+IMKgIHN0cnVjdCBpb3Zh
ICpzcGxpdF9hbmRfcmVtb3ZlX2lvdmEoc3RydWN0IGlvdmFfZG9tYWluICppb3ZhZCwKPj4+IMKg
wqDCoMKgwqAgc3RydWN0IGlvdmEgKmlvdmEsIHVuc2lnbmVkIGxvbmcgcGZuX2xvLCB1bnNpZ25l
ZCBsb25nIHBmbl9oaSk7Cj4+PiDCoCB2b2lkIGZyZWVfY3B1X2NhY2hlZF9pb3Zhcyh1bnNpZ25l
ZCBpbnQgY3B1LCBzdHJ1Y3QgaW92YV9kb21haW4KPj4+ICppb3ZhZCk7Cj4+PiArdm9pZCBmcmVl
X2dsb2JhbF9jYWNoZWRfaW92YXMoc3RydWN0IGlvdmFfZG9tYWluICppb3ZhZCk7Cj4+PiDCoCAj
ZWxzZQo+Pj4gwqAgc3RhdGljIGlubGluZSBpbnQgaW92YV9jYWNoZV9nZXQodm9pZCkKPj4+IMKg
IHsKPj4+IEBAIC0yNzAsNiArMjcxLDExIEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBmcmVlX2NwdV9j
YWNoZWRfaW92YXModW5zaWduZWQKPj4+IGludCBjcHUsCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgaW92YV9kb21haW4gKmlvdmFkKQo+Pj4g
wqAgewo+Pj4gwqAgfQo+Pj4gKwo+Pj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBmcmVlX2dsb2JhbF9j
YWNoZWRfaW92YXMoc3RydWN0IGlvdmFfZG9tYWluICppb3ZhZCkKPj4+ICt7Cj4+PiArfQo+Pj4g
Kwo+Pj4gwqAgI2VuZGlmCj4+PiDCoCDCoCAjZW5kaWYKPj4+Cj4gCgotLSAKUVVBTENPTU0gSU5E
SUEsIG9uIGJlaGFsZiBvZiBRdWFsY29tbSBJbm5vdmF0aW9uIENlbnRlciwgSW5jLiBpcyBhCm1l
bWJlciBvZiBDb2RlIEF1cm9yYSBGb3J1bSwgaG9zdGVkIGJ5IFRoZSBMaW51eCBGb3VuZGF0aW9u
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1h
aWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
