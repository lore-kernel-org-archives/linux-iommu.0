Return-Path: <SRS0=J567=KB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 391BEC433B4
	for <iommu@archiver.kernel.org>; Thu,  6 May 2021 15:17:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A91FC60233
	for <iommu@archiver.kernel.org>; Thu,  6 May 2021 15:17:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A91FC60233
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 63B1D405B3;
	Thu,  6 May 2021 15:17:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y1vqc010YnGW; Thu,  6 May 2021 15:17:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 03CB04059C;
	Thu,  6 May 2021 15:17:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D0A2CC000D;
	Thu,  6 May 2021 15:17:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2B1FBC0001
 for <iommu@lists.linux-foundation.org>; Thu,  6 May 2021 15:17:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 18C75405B3
 for <iommu@lists.linux-foundation.org>; Thu,  6 May 2021 15:17:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NBxWJd2R3Dec for <iommu@lists.linux-foundation.org>;
 Thu,  6 May 2021 15:17:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id A46C44059C
 for <iommu@lists.linux-foundation.org>; Thu,  6 May 2021 15:17:19 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B63731B;
 Thu,  6 May 2021 08:17:18 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C72573F718;
 Thu,  6 May 2021 08:17:16 -0700 (PDT)
From: Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v3 09/10] iommu/arm-smmu: Get associated RMR info and
 install bypass SMR
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org
References: <20210420082751.1829-1-shameerali.kolothum.thodi@huawei.com>
 <20210420082751.1829-10-shameerali.kolothum.thodi@huawei.com>
Message-ID: <501cd986-7f9c-9aa7-b4e9-f2ef98fb7a95@arm.com>
Date: Thu, 6 May 2021 16:17:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210420082751.1829-10-shameerali.kolothum.thodi@huawei.com>
Content-Language: en-GB
Cc: jon@solid-run.com, linuxarm@huawei.com, guohanjun@huawei.com,
 Sami.Mujawar@arm.com, robin.murphy@arm.com, wanghuiqiang@huawei.com
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

T24gMjAvMDQvMjAyMSAwOToyNywgU2hhbWVlciBLb2xvdGh1bSB3cm90ZToKPiBGcm9tOiBKb24g
TmV0dGxldG9uIDxqb25Ac29saWQtcnVuLmNvbT4KPiAKPiBDaGVjayBpZiB0aGVyZSBpcyBhbnkg
Uk1SIGluZm8gYXNzb2NpYXRlZMKgd2l0aCB0aGUgZGV2aWNlcyBiZWhpbmQKPiB0aGUgU01NVSBh
bmQgaWYgYW55LCBpbnN0YWxsIGJ5cGFzcyBTTVJzIGZvciB0aGVtLiBUaGlzIGlzIHRvCj4ga2Vl
cCBhbnkgb25nb2luZyB0cmFmZmljIGFzc29jaWF0ZWQgd2l0aCB0aGVzZSBkZXZpY2VzIGFsaXZl
Cj4gd2hlbiB3ZSBlbmFibGUvcmVzZXQgU01NVSBkdXJpbmcgcHJvYmUoKS4KPiAKPiBTaWduZWQt
b2ZmLWJ5OiBKb24gTmV0dGxldG9uIDxqb25Ac29saWQtcnVuLmNvbT4KPiBTaWduZWQtb2ZmLWJ5
OiBTaGFtZWVyIEtvbG90aHVtIDxzaGFtZWVyYWxpLmtvbG90aHVtLnRob2RpQGh1YXdlaS5jb20+
Cj4gLS0tCj4gICBkcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS9hcm0tc21tdS5jIHwgNDIgKysr
KysrKysrKysrKysrKysrKysrKysrKysrCj4gICBkcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS9h
cm0tc21tdS5oIHwgIDIgKysKPiAgIDIgZmlsZXMgY2hhbmdlZCwgNDQgaW5zZXJ0aW9ucygrKQo+
IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS9hcm0tc21tdS5jIGIv
ZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUvYXJtLXNtbXUuYwo+IGluZGV4IGQ4YzZiZmRlNmE2
MS4uNGQyZjkxNjI2ZDg3IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11
L2FybS1zbW11LmMKPiArKysgYi9kcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS9hcm0tc21tdS5j
Cj4gQEAgLTIxMDIsNiArMjEwMiw0MyBAQCBlcnJfcmVzZXRfcGxhdGZvcm1fb3BzOiBfX21heWJl
X3VudXNlZDsKPiAgIAlyZXR1cm4gZXJyOwo+ICAgfQo+ICAgCj4gK3N0YXRpYyB2b2lkIGFybV9z
bW11X3Jtcl9pbnN0YWxsX2J5cGFzc19zbXIoc3RydWN0IGFybV9zbW11X2RldmljZSAqc21tdSkK
PiArewo+ICsJc3RydWN0IGlvbW11X3JtciAqZTsKPiArCWludCBpLCBjbnQgPSAwOwo+ICsJdTMy
IHNtcjsKPiArCj4gKwlmb3IgKGkgPSAwOyBpIDwgc21tdS0+bnVtX21hcHBpbmdfZ3JvdXBzOyBp
KyspIHsKPiArCQlzbXIgPSBhcm1fc21tdV9ncjBfcmVhZChzbW11LCBBUk1fU01NVV9HUjBfU01S
KGkpKTsKPiArCQlpZiAoIUZJRUxEX0dFVChBUk1fU01NVV9TTVJfVkFMSUQsIHNtcikpCj4gKwkJ
CWNvbnRpbnVlOwo+ICsKPiArCQlsaXN0X2Zvcl9lYWNoX2VudHJ5KGUsICZzbW11LT5ybXJfbGlz
dCwgbGlzdCkgewo+ICsJCQlpZiAoRklFTERfR0VUKEFSTV9TTU1VX1NNUl9JRCwgc21yKSAhPSBl
LT5zaWQpCj4gKwkJCQljb250aW51ZTsKPiArCj4gKwkJCXNtbXUtPnNtcnNbaV0uaWQgPSBGSUVM
RF9HRVQoQVJNX1NNTVVfU01SX0lELCBzbXIpOwo+ICsJCQlzbW11LT5zbXJzW2ldLm1hc2sgPSBG
SUVMRF9HRVQoQVJNX1NNTVVfU01SX01BU0ssIHNtcik7Cj4gKwkJCXNtbXUtPnNtcnNbaV0udmFs
aWQgPSB0cnVlOwo+ICsKPiArCQkJc21tdS0+czJjcnNbaV0udHlwZSA9IFMyQ1JfVFlQRV9CWVBB
U1M7Cj4gKwkJCXNtbXUtPnMyY3JzW2ldLnByaXZjZmcgPSBTMkNSX1BSSVZDRkdfREVGQVVMVDsK
PiArCQkJc21tdS0+czJjcnNbaV0uY2JuZHggPSAweGZmOwo+ICsKPiArCQkJY250Kys7Cj4gKwkJ
fQo+ICsJfQoKSWYgSSB1bmRlcnN0YW5kIHRoaXMgY29ycmVjdGx5IC0gdGhpcyBpcyBsb29raW5n
IGF0IHRoZSBjdXJyZW50CihoYXJkd2FyZSkgY29uZmlndXJhdGlvbiBvZiB0aGUgU01NVSBhbmQg
YXR0ZW1wdGluZyB0byBwcmVzZXJ2ZSBhbnkKYnlwYXNzIFNNUnMuIEhvd2V2ZXIgZnJvbSB3aGF0
IEkgY2FuIHRlbGwgaXQgc3VmZmVycyBmcm9tIHRoZSBmb2xsb3dpbmcKdHdvIHByb2JsZW1zOgoK
ICAoYSkgT25seSB0aGUgSUQgb2YgdGhlIFNNUiBpcyBiZWluZyBjaGVja2VkLCBub3QgdGhlIE1B
U0suIFNvIGlmIHRoZQpmaXJtd2FyZSBoYXMgc2V0dXAgYW4gU01SIG1hdGNoaW5nIGEgbnVtYmVy
IG9mIHN0cmVhbXMgdGhpcyB3aWxsIGJyZWFrLgoKICAoYikgVGhlIFNNTVUgbWlnaHQgbm90IGJl
IGVuYWJsZWQgYXQgYWxsIChDTElFTlRQRD09MSkgb3IgYnlwYXNzCmVuYWJsZWQgZm9yIHVubWF0
Y2hlZCBzdHJlYW1zIChVU0ZDRkc9PTApLgoKQ2VydGFpbmx5IGluIG15IHRlc3Qgc2V0dXAgY2Fz
ZSAoYikgYXBwbGllcyBhbmQgc28gdGhpcyBkb2Vzbid0IHdvcmsuClBlcmhhcHMgc29tZXRoaW5n
IGxpa2UgdGhlIGJlbG93IHdvdWxkIHdvcmsgYmV0dGVyPyAoSXQgd29ya3MgaW4gdGhlCmNhc2Ug
b2YgdGhlIFNNTVUgbm90IGVuYWJsZWQgLSBJJ3ZlIG5vdCB0ZXN0ZWQgY2FzZSAoYSkpLgoKU3Rl
dmUKCi0tLS04PC0tLS0Kc3RhdGljIHZvaWQgYXJtX3NtbXVfcm1yX2luc3RhbGxfYnlwYXNzX3Nt
cihzdHJ1Y3QgYXJtX3NtbXVfZGV2aWNlICpzbW11KQp7CglzdHJ1Y3QgaW9tbXVfcm1yICplOwoJ
aW50IGksIGNudCA9IDA7Cgl1MzIgc21yOwoJdTMyIHJlZzsKCglyZWcgPSBhcm1fc21tdV9ncjBf
cmVhZChzbW11LCBBUk1fU01NVV9HUjBfc0NSMCk7CgoJaWYgKChyZWcgJiBBUk1fU01NVV9zQ1Iw
X1VTRkNGRykgJiYgIShyZWcgJiBBUk1fU01NVV9zQ1IwX0NMSUVOVFBEKSkgewoJCS8qCgkJICog
U01NVSBpcyBhbHJlYWR5IGVuYWJsZWQgYW5kIGRpc2FsbG93aW5nIGJ5cGFzcywgc28gcHJlc2Vy
dmUKCQkgKiB0aGUgZXhpc3RpbmcgU01ScwoJCSAqLwoJCWZvciAoaSA9IDA7IGkgPCBzbW11LT5u
dW1fbWFwcGluZ19ncm91cHM7IGkrKykgewoJCQlzbXIgPSBhcm1fc21tdV9ncjBfcmVhZChzbW11
LCBBUk1fU01NVV9HUjBfU01SKGkpKTsKCQkJaWYgKCFGSUVMRF9HRVQoQVJNX1NNTVVfU01SX1ZB
TElELCBzbXIpKQoJCQkJY29udGludWU7CgkJCXNtbXUtPnNtcnNbaV0uaWQgPSBGSUVMRF9HRVQo
QVJNX1NNTVVfU01SX0lELCBzbXIpOwoJCQlzbW11LT5zbXJzW2ldLm1hc2sgPSBGSUVMRF9HRVQo
QVJNX1NNTVVfU01SX01BU0ssIHNtcik7CgkJCXNtbXUtPnNtcnNbaV0udmFsaWQgPSB0cnVlOwoJ
CX0KCX0KCglsaXN0X2Zvcl9lYWNoX2VudHJ5KGUsICZzbW11LT5ybXJfbGlzdCwgbGlzdCkgewoJ
CXUzMiBzaWQgPSBlLT5zaWQ7CgoJCWkgPSBhcm1fc21tdV9maW5kX3NtZShzbW11LCBzaWQsIH4w
KTsKCQlpZiAoaSA8IDApCgkJCWNvbnRpbnVlOwoJCWlmIChzbW11LT5zMmNyc1tpXS5jb3VudCA9
PSAwKSB7CgkJCXNtbXUtPnNtcnNbaV0uaWQgPSBzaWQ7CgkJCXNtbXUtPnNtcnNbaV0ubWFzayA9
IH4wOwoJCQlzbW11LT5zbXJzW2ldLnZhbGlkID0gdHJ1ZTsKCQl9CgkJc21tdS0+czJjcnNbaV0u
Y291bnQrKzsKCQlzbW11LT5zMmNyc1tpXS50eXBlID0gUzJDUl9UWVBFX0JZUEFTUzsKCQlzbW11
LT5zMmNyc1tpXS5wcml2Y2ZnID0gUzJDUl9QUklWQ0ZHX0RFRkFVTFQ7CgkJc21tdS0+czJjcnNb
aV0uY2JuZHggPSAweGZmOwoKCQljbnQrKzsKCX0KCglpZiAoKHJlZyAmIEFSTV9TTU1VX3NDUjBf
VVNGQ0ZHKSAmJiAhKHJlZyAmIEFSTV9TTU1VX3NDUjBfQ0xJRU5UUEQpKSB7CgkJLyogUmVtb3Zl
IHRoZSB2YWxpZCBiaXQgZm9yIHVudXNlZCBTTVJzICovCgkJZm9yIChpID0gMDsgaSA8IHNtbXUt
Pm51bV9tYXBwaW5nX2dyb3VwczsgaSsrKSB7CgkJCWlmIChzbW11LT5zMmNyc1tpXS5jb3VudCA9
PSAwKQoJCQkJc21tdS0+c21yc1tpXS52YWxpZCA9IGZhbHNlOwoJCX0KCX0KCglkZXZfbm90aWNl
KHNtbXUtPmRldiwgIlx0cHJlc2VydmVkICVkIGJvb3QgbWFwcGluZyVzXG4iLCBjbnQsCgkJICAg
Y250ID09IDEgPyAiIiA6ICJzIik7Cn0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2lvbW11
