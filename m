Return-Path: <SRS0=FWOh=HO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C2AC433E0
	for <iommu@archiver.kernel.org>; Fri, 12 Feb 2021 16:38:49 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78A3064E79
	for <iommu@archiver.kernel.org>; Fri, 12 Feb 2021 16:38:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78A3064E79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2712E8755E;
	Fri, 12 Feb 2021 16:38:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m6FkxMUS4ViX; Fri, 12 Feb 2021 16:38:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5794F873D2;
	Fri, 12 Feb 2021 16:38:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3B38EC0174;
	Fri, 12 Feb 2021 16:38:46 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E0D55C013A
 for <iommu@lists.linux-foundation.org>; Fri, 12 Feb 2021 16:38:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D4C9E860D6
 for <iommu@lists.linux-foundation.org>; Fri, 12 Feb 2021 16:38:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rp55c-JWsEa1 for <iommu@lists.linux-foundation.org>;
 Fri, 12 Feb 2021 16:38:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id 04292864CB
 for <iommu@lists.linux-foundation.org>; Fri, 12 Feb 2021 16:38:41 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 111971063;
 Fri, 12 Feb 2021 08:38:41 -0800 (PST)
Received: from [10.57.49.26] (unknown [10.57.49.26])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B16743F73B;
 Fri, 12 Feb 2021 08:38:39 -0800 (PST)
Subject: Re: [PATCH v2] iommu: Check dev->iommu in iommu_dev_xxx functions
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
References: <c82f6d0cced74c43947714e7de576d5a@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <d541ebeb-5b89-7a9d-50a2-3867f9cf78b3@arm.com>
Date: Fri, 12 Feb 2021 16:38:33 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <c82f6d0cced74c43947714e7de576d5a@huawei.com>
Content-Language: en-GB
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "will@kernel.org" <will@kernel.org>,
 "linuxarm@openeuler.org" <linuxarm@openeuler.org>,
 "Zengtao \(B\)" <prime.zeng@hisilicon.com>
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

T24gMjAyMS0wMi0xMiAxNDo1NCwgU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaSB3cm90ZToKPiBI
aSBSb2Jpbi9Kb2VyZywKPiAKPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KPj4gRnJvbTog
U2hhbWVlciBLb2xvdGh1bSBbbWFpbHRvOnNoYW1lZXJhbGkua29sb3RodW0udGhvZGlAaHVhd2Vp
LmNvbV0KPj4gU2VudDogMDEgRmVicnVhcnkgMjAyMSAxMjo0MQo+PiBUbzogbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsgaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKPj4gQ2M6
IGpvcm9AOGJ5dGVzLm9yZzsgcm9iaW4ubXVycGh5QGFybS5jb207IGplYW4tcGhpbGlwcGVAbGlu
YXJvLm9yZzsKPj4gd2lsbEBrZXJuZWwub3JnOyBaZW5ndGFvIChCKSA8cHJpbWUuemVuZ0BoaXNp
bGljb24uY29tPjsKPj4gbGludXhhcm1Ab3BlbmV1bGVyLm9yZwo+PiBTdWJqZWN0OiBbTGludXhh
cm1dIFtQQVRDSCB2Ml0gaW9tbXU6IENoZWNrIGRldi0+aW9tbXUgaW4gaW9tbXVfZGV2X3h4eAo+
PiBmdW5jdGlvbnMKPj4KPj4gVGhlIGRldmljZSBpb21tdSBwcm9iZS9hdHRhY2ggbWlnaHQgaGF2
ZSBmYWlsZWQgbGVhdmluZyBkZXYtPmlvbW11Cj4+IHRvIE5VTEwgYW5kIGRldmljZSBkcml2ZXJz
IG1heSBzdGlsbCBpbnZva2UgdGhlc2UgZnVuY3Rpb25zIHJlc3VsdGluZwo+PiBpbiBhIGNyYXNo
IGluIGlvbW11IHZlbmRvciBkcml2ZXIgY29kZS4gSGVuY2UgbWFrZSBzdXJlIHdlIGNoZWNrIHRo
YXQuCj4+Cj4+IEFsc28gYWRkZWQgaW9tbXVfb3BzIHRvIHRoZSAic3RydWN0IGRldl9pb21tdSIg
YW5kIHNldCBpdCBpZiB0aGUgZGV2Cj4+IGlzIHN1Y2Nlc3NmdWxseSBhc3NvY2lhdGVkIHdpdGgg
YW4gaW9tbXUuCj4+Cj4+IEZpeGVzOsKgYTNhMTk1OTI5ZDQwICgiaW9tbXU6IEFkZCBBUElzIGZv
ciBtdWx0aXBsZSBkb21haW5zIHBlciBkZXZpY2UiKQo+PiBTaWduZWQtb2ZmLWJ5OiBTaGFtZWVy
IEtvbG90aHVtIDxzaGFtZWVyYWxpLmtvbG90aHVtLnRob2RpQGh1YXdlaS5jb20+Cj4+IC0tLQo+
PiB2MSAtLT4gdjI6Cj4+ICAgLUFkZGVkIGlvbW11X29wcyB0byBzdHJ1Y3QgZGV2X2lvbW11IGJh
c2VkIG9uIHRoZSBkaXNjdXNzaW9uIHdpdGggUm9iaW4uCj4+ICAgLVJlYmFzZWQgYWdhaW5zdCBp
b21tdS10cmVlIGNvcmUgYnJhbmNoLgo+IAo+IEEgZ2VudGxlIHBpbmcgb24gdGhpcy4uLgoKSXMg
dGhlcmUgYSBjb252aW5jaW5nIGp1c3RpZmljYXRpb24gZm9yIG1haW50YWluaW5nIHlldCBhbm90
aGVyIGNvcHkgb2YgCnRoZSBvcHMgcG9pbnRlciByYXRoZXIgdGhhbiBzaW1wbHkgZGVyZWZlcmVu
Y2luZyBpb21tdV9kZXYtPm9wcyBhdCBwb2ludCAKb2YgdXNlPwoKUm9iaW4uCgo+IFRoYW5rcywK
PiBTaGFtZWVyCj4gCj4+IC0tLQo+PiAgIGRyaXZlcnMvaW9tbXUvaW9tbXUuYyB8IDE5ICsrKysr
KystLS0tLS0tLS0tLS0KPj4gICBpbmNsdWRlL2xpbnV4L2lvbW11LmggfCAgMiArKwo+PiAgIDIg
ZmlsZXMgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkKPj4KPj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvaW9tbXUuYwo+
PiBpbmRleCBmZDc2ZTJmNTc5ZmUuLjYwMjNkMGI3YzU0MiAxMDA2NDQKPj4gLS0tIGEvZHJpdmVy
cy9pb21tdS9pb21tdS5jCj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvaW9tbXUuYwo+PiBAQCAtMjE3
LDYgKzIxNyw3IEBAIHN0YXRpYyBpbnQgX19pb21tdV9wcm9iZV9kZXZpY2Uoc3RydWN0IGRldmlj
ZSAqZGV2LAo+PiBzdHJ1Y3QgbGlzdF9oZWFkICpncm91cF9saXN0Cj4+ICAgCX0KPj4KPj4gICAJ
ZGV2LT5pb21tdS0+aW9tbXVfZGV2ID0gaW9tbXVfZGV2Owo+PiArCWRldi0+aW9tbXUtPm9wcyA9
IGlvbW11X2Rldi0+b3BzOwo+Pgo+PiAgIAlncm91cCA9IGlvbW11X2dyb3VwX2dldF9mb3JfZGV2
KGRldik7Cj4+ICAgCWlmIChJU19FUlIoZ3JvdXApKSB7Cj4+IEBAIC0yODY1LDEwICsyODY2LDgg
QEAgRVhQT1JUX1NZTUJPTF9HUEwoaW9tbXVfZndzcGVjX2FkZF9pZHMpOwo+PiAgICAqLwo+PiAg
IGludCBpb21tdV9kZXZfZW5hYmxlX2ZlYXR1cmUoc3RydWN0IGRldmljZSAqZGV2LCBlbnVtCj4+
IGlvbW11X2Rldl9mZWF0dXJlcyBmZWF0KQo+PiAgIHsKPj4gLQljb25zdCBzdHJ1Y3QgaW9tbXVf
b3BzICpvcHMgPSBkZXYtPmJ1cy0+aW9tbXVfb3BzOwo+PiAtCj4+IC0JaWYgKG9wcyAmJiBvcHMt
PmRldl9lbmFibGVfZmVhdCkKPj4gLQkJcmV0dXJuIG9wcy0+ZGV2X2VuYWJsZV9mZWF0KGRldiwg
ZmVhdCk7Cj4+ICsJaWYgKGRldi0+aW9tbXUgJiYgZGV2LT5pb21tdS0+b3BzLT5kZXZfZW5hYmxl
X2ZlYXQpCj4+ICsJCXJldHVybiBkZXYtPmlvbW11LT5vcHMtPmRldl9lbmFibGVfZmVhdChkZXYs
IGZlYXQpOwo+Pgo+PiAgIAlyZXR1cm4gLUVOT0RFVjsKPj4gICB9Cj4+IEBAIC0yODgxLDEwICsy
ODgwLDggQEAKPj4gRVhQT1JUX1NZTUJPTF9HUEwoaW9tbXVfZGV2X2VuYWJsZV9mZWF0dXJlKTsK
Pj4gICAgKi8KPj4gICBpbnQgaW9tbXVfZGV2X2Rpc2FibGVfZmVhdHVyZShzdHJ1Y3QgZGV2aWNl
ICpkZXYsIGVudW0KPj4gaW9tbXVfZGV2X2ZlYXR1cmVzIGZlYXQpCj4+ICAgewo+PiAtCWNvbnN0
IHN0cnVjdCBpb21tdV9vcHMgKm9wcyA9IGRldi0+YnVzLT5pb21tdV9vcHM7Cj4+IC0KPj4gLQlp
ZiAob3BzICYmIG9wcy0+ZGV2X2Rpc2FibGVfZmVhdCkKPj4gLQkJcmV0dXJuIG9wcy0+ZGV2X2Rp
c2FibGVfZmVhdChkZXYsIGZlYXQpOwo+PiArCWlmIChkZXYtPmlvbW11ICYmIGRldi0+aW9tbXUt
Pm9wcy0+ZGV2X2Rpc2FibGVfZmVhdCkKPj4gKwkJcmV0dXJuIGRldi0+aW9tbXUtPm9wcy0+ZGV2
X2Rpc2FibGVfZmVhdChkZXYsIGZlYXQpOwo+Pgo+PiAgIAlyZXR1cm4gLUVCVVNZOwo+PiAgIH0K
Pj4gQEAgLTI4OTIsMTAgKzI4ODksOCBAQAo+PiBFWFBPUlRfU1lNQk9MX0dQTChpb21tdV9kZXZf
ZGlzYWJsZV9mZWF0dXJlKTsKPj4KPj4gICBib29sIGlvbW11X2Rldl9mZWF0dXJlX2VuYWJsZWQo
c3RydWN0IGRldmljZSAqZGV2LCBlbnVtCj4+IGlvbW11X2Rldl9mZWF0dXJlcyBmZWF0KQo+PiAg
IHsKPj4gLQljb25zdCBzdHJ1Y3QgaW9tbXVfb3BzICpvcHMgPSBkZXYtPmJ1cy0+aW9tbXVfb3Bz
Owo+PiAtCj4+IC0JaWYgKG9wcyAmJiBvcHMtPmRldl9mZWF0X2VuYWJsZWQpCj4+IC0JCXJldHVy
biBvcHMtPmRldl9mZWF0X2VuYWJsZWQoZGV2LCBmZWF0KTsKPj4gKwlpZiAoZGV2LT5pb21tdSAm
JiBkZXYtPmlvbW11LT5vcHMtPmRldl9mZWF0X2VuYWJsZWQpCj4+ICsJCXJldHVybiBkZXYtPmlv
bW11LT5vcHMtPmRldl9mZWF0X2VuYWJsZWQoZGV2LCBmZWF0KTsKPj4KPj4gICAJcmV0dXJuIGZh
bHNlOwo+PiAgIH0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvaW9tbXUuaCBiL2luY2x1
ZGUvbGludXgvaW9tbXUuaAo+PiBpbmRleCA1MjRmZmMyZmY2NGYuLmZmMGM3NmJkZmI2NyAxMDA2
NDQKPj4gLS0tIGEvaW5jbHVkZS9saW51eC9pb21tdS5oCj4+ICsrKyBiL2luY2x1ZGUvbGludXgv
aW9tbXUuaAo+PiBAQCAtMzU0LDYgKzM1NCw3IEBAIHN0cnVjdCBpb21tdV9mYXVsdF9wYXJhbSB7
Cj4+ICAgICogQGZhdWx0X3BhcmFtOiBJT01NVSBkZXRlY3RlZCBkZXZpY2UgZmF1bHQgcmVwb3J0
aW5nIGRhdGEKPj4gICAgKiBAZndzcGVjOgkgSU9NTVUgZndzcGVjIGRhdGEKPj4gICAgKiBAaW9t
bXVfZGV2OgkgSU9NTVUgZGV2aWNlIHRoaXMgZGV2aWNlIGlzIGxpbmtlZCB0bwo+PiArICogQG9w
czoJIGlvbW11LW9wcyBmb3IgdGFsa2luZyB0byB0aGUgaW9tbXVfZGV2Cj4+ICAgICogQHByaXY6
CSBJT01NVSBEcml2ZXIgcHJpdmF0ZSBkYXRhCj4+ICAgICoKPj4gICAgKiBUT0RPOiBtaWdyYXRl
IG90aGVyIHBlciBkZXZpY2UgZGF0YSBwb2ludGVycyB1bmRlciBpb21tdV9kZXZfZGF0YSwKPj4g
ZS5nLgo+PiBAQCAtMzY0LDYgKzM2NSw3IEBAIHN0cnVjdCBkZXZfaW9tbXUgewo+PiAgIAlzdHJ1
Y3QgaW9tbXVfZmF1bHRfcGFyYW0JKmZhdWx0X3BhcmFtOwo+PiAgIAlzdHJ1Y3QgaW9tbXVfZndz
cGVjCQkqZndzcGVjOwo+PiAgIAlzdHJ1Y3QgaW9tbXVfZGV2aWNlCQkqaW9tbXVfZGV2Owo+PiAr
CWNvbnN0IHN0cnVjdCBpb21tdV9vcHMJCSpvcHM7Cj4+ICAgCXZvaWQJCQkJKnByaXY7Cj4+ICAg
fTsKPj4KPj4gLS0KPj4gMi4xNy4xCj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCj4+IExpbnV4YXJtIG1haWxpbmcgbGlzdCAtLSBsaW51eGFybUBvcGVu
ZXVsZXIub3JnCj4+IFRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXhhcm0tbGVh
dmVAb3BlbmV1bGVyLm9yZwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9t
bXU=
