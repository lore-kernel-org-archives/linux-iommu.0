Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E05ADC433F5
	for <iommu@archiver.kernel.org>; Tue,  3 May 2022 16:34:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B0FA483295;
	Tue,  3 May 2022 16:34:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LglzrYWrT53E; Tue,  3 May 2022 16:34:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9640282735;
	Tue,  3 May 2022 16:34:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C2C4C0032;
	Tue,  3 May 2022 16:34:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 46D05C002D
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 16:34:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 42B5E405D8
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 16:34:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id znrpQiPM0ZBV for <iommu@lists.linux-foundation.org>;
 Tue,  3 May 2022 16:34:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5C48940528
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 16:34:25 +0000 (UTC)
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Kt57x2Dcyz67y8S;
 Wed,  4 May 2022 00:31:41 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Tue, 3 May 2022 18:34:22 +0200
Received: from A2006125610.china.huawei.com (10.202.227.178) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 3 May 2022 17:34:15 +0100
To: <linux-arm-kernel@lists.infradead.org>, <linux-acpi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
Subject: [PATCH v12 1/9] iommu: Introduce a callback to struct
 iommu_resv_region
Date: Tue, 3 May 2022 17:33:22 +0100
Message-ID: <20220503163330.509-2-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20220503163330.509-1-shameerali.kolothum.thodi@huawei.com>
References: <20220503163330.509-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.202.227.178]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Cc: robin.murphy@arm.com, jon@solid-run.com, linuxarm@huawei.com,
 steven.price@arm.com, hch@infradead.org, guohanjun@huawei.com,
 Sami.Mujawar@arm.com, will@kernel.org, wanghuiqiang@huawei.com
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
From: Shameer Kolothum via iommu <iommu@lists.linux-foundation.org>
Reply-To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

QSBjYWxsYmFjayBpcyBpbnRyb2R1Y2VkIHRvIHN0cnVjdCBpb21tdV9yZXN2X3JlZ2lvbiB0byBm
cmVlIG1lbW9yeQphbGxvY2F0aW9ucyBhc3NvY2lhdGVkwqB3aXRoIHRoZcKgcmVzZXJ2ZWQgcmVn
aW9uLiBUaGlzIHdpbGwgYmUgdXNlZnVsCndoZW4gd2UgaW50cm9kdWNlIHN1cHBvcnQgZm9yIElP
UlQgUk1SIGJhc2VkIHJlc2VydmVkIHJlZ2lvbnMuCgpSZXZpZXdlZC1ieTogQ2hyaXN0b3BoIEhl
bGx3aWcgPGhjaEBsc3QuZGU+ClRlc3RlZC1ieTogU3RldmVuIFByaWNlIDxzdGV2ZW4ucHJpY2VA
YXJtLmNvbT4KU2lnbmVkLW9mZi1ieTogU2hhbWVlciBLb2xvdGh1bSA8c2hhbWVlcmFsaS5rb2xv
dGh1bS50aG9kaUBodWF3ZWkuY29tPgotLS0KIGRyaXZlcnMvaW9tbXUvaW9tbXUuYyB8IDE2ICsr
KysrKysrKysrLS0tLS0KIGluY2x1ZGUvbGludXgvaW9tbXUuaCB8ICAyICsrCiAyIGZpbGVzIGNo
YW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9pb21tdS9pb21tdS5jIGIvZHJpdmVycy9pb21tdS9pb21tdS5jCmluZGV4IGYyYzQ1Yjg1
YjlmYy4uZmZjZmE2ODRlODBjIDEwMDY0NAotLS0gYS9kcml2ZXJzL2lvbW11L2lvbW11LmMKKysr
IGIvZHJpdmVycy9pb21tdS9pb21tdS5jCkBAIC0yNTk3LDE2ICsyNTk3LDIyIEBAIHZvaWQgaW9t
bXVfcHV0X3Jlc3ZfcmVnaW9ucyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBsaXN0X2hlYWQg
Kmxpc3QpCiAgKiBAbGlzdDogcmVzZXJ2ZWQgcmVnaW9uIGxpc3QgZm9yIGRldmljZQogICoKICAq
IElPTU1VIGRyaXZlcnMgY2FuIHVzZSB0aGlzIHRvIGltcGxlbWVudCB0aGVpciAucHV0X3Jlc3Zf
cmVnaW9ucygpIGNhbGxiYWNrCi0gKiBmb3Igc2ltcGxlIHJlc2VydmF0aW9ucy4gTWVtb3J5IGFs
bG9jYXRlZCBmb3IgZWFjaCByZXNlcnZlZCByZWdpb24gd2lsbCBiZQotICogZnJlZWQuIElmIGFu
IElPTU1VIGRyaXZlciBhbGxvY2F0ZXMgYWRkaXRpb25hbCByZXNvdXJjZXMgcGVyIHJlZ2lvbiwg
aXQgaXMKLSAqIGdvaW5nIHRvIGhhdmUgdG8gaW1wbGVtZW50IGEgY3VzdG9tIGNhbGxiYWNrLgor
ICogZm9yIHNpbXBsZSByZXNlcnZhdGlvbnMuIElmIGEgcGVyIHJlZ2lvbiBjYWxsYmFjayBpcyBw
cm92aWRlZCB0aGF0IHdpbGwgYmUKKyAqIHVzZWQgdG8gZnJlZSBhbGwgbWVtb3J5IGFsbG9jYXRp
b25zIGFzc29jaWF0ZWQgd2l0aCB0aGUgcmVzZXJ2ZWQgcmVnaW9uIG9yCisgKiBlbHNlIGp1c3Qg
ZnJlZSB1cCB0aGUgbWVtb3J5IGZvciB0aGUgcmVnaW9ucy4gSWYgYW4gSU9NTVUgZHJpdmVyIGFs
bG9jYXRlcworICogYWRkaXRpb25hbCByZXNvdXJjZXMgcGVyIHJlZ2lvbiwgaXQgaXMgZ29pbmcg
dG8gaGF2ZSB0byBpbXBsZW1lbnQgYSBjdXN0b20KKyAqIGNhbGxiYWNrLgogICovCiB2b2lkIGdl
bmVyaWNfaW9tbXVfcHV0X3Jlc3ZfcmVnaW9ucyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBs
aXN0X2hlYWQgKmxpc3QpCiB7CiAJc3RydWN0IGlvbW11X3Jlc3ZfcmVnaW9uICplbnRyeSwgKm5l
eHQ7CiAKLQlsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUoZW50cnksIG5leHQsIGxpc3QsIGxpc3Qp
Ci0JCWtmcmVlKGVudHJ5KTsKKwlsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUoZW50cnksIG5leHQs
IGxpc3QsIGxpc3QpIHsKKwkJaWYgKGVudHJ5LT5mcmVlKQorCQkJZW50cnktPmZyZWUoZGV2LCBl
bnRyeSk7CisJCWVsc2UKKwkJCWtmcmVlKGVudHJ5KTsKKwl9CiB9CiBFWFBPUlRfU1lNQk9MKGdl
bmVyaWNfaW9tbXVfcHV0X3Jlc3ZfcmVnaW9ucyk7CiAKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGlu
dXgvaW9tbXUuaCBiL2luY2x1ZGUvbGludXgvaW9tbXUuaAppbmRleCA5MjA4ZWNhNGIwZDEuLjY4
YmNmYjNhMDZkNyAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9pb21tdS5oCisrKyBiL2luY2x1
ZGUvbGludXgvaW9tbXUuaApAQCAtMTM0LDYgKzEzNCw3IEBAIGVudW0gaW9tbXVfcmVzdl90eXBl
IHsKICAqIEBsZW5ndGg6IExlbmd0aCBvZiB0aGUgcmVnaW9uIGluIGJ5dGVzCiAgKiBAcHJvdDog
SU9NTVUgUHJvdGVjdGlvbiBmbGFncyAoUkVBRC9XUklURS8uLi4pCiAgKiBAdHlwZTogVHlwZSBv
ZiB0aGUgcmVzZXJ2ZWQgcmVnaW9uCisgKiBAZnJlZTogQ2FsbGJhY2sgdG8gZnJlZSBhc3NvY2lh
dGVkIG1lbW9yeSBhbGxvY2F0aW9ucwogICovCiBzdHJ1Y3QgaW9tbXVfcmVzdl9yZWdpb24gewog
CXN0cnVjdCBsaXN0X2hlYWQJbGlzdDsKQEAgLTE0MSw2ICsxNDIsNyBAQCBzdHJ1Y3QgaW9tbXVf
cmVzdl9yZWdpb24gewogCXNpemVfdAkJCWxlbmd0aDsKIAlpbnQJCQlwcm90OwogCWVudW0gaW9t
bXVfcmVzdl90eXBlCXR5cGU7CisJdm9pZCAoKmZyZWUpKHN0cnVjdCBkZXZpY2UgKmRldiwgc3Ry
dWN0IGlvbW11X3Jlc3ZfcmVnaW9uICpyZWdpb24pOwogfTsKIAogLyoqCi0tIAoyLjE3LjEKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxp
bmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
