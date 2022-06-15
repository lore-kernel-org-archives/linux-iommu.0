Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B58AC433EF
	for <iommu@archiver.kernel.org>; Wed, 15 Jun 2022 10:11:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B64CB40BE6;
	Wed, 15 Jun 2022 10:11:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JWHv2r36rM7V; Wed, 15 Jun 2022 10:11:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7640E40BC8;
	Wed, 15 Jun 2022 10:11:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3A4ADC0083;
	Wed, 15 Jun 2022 10:11:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 25A23C002D
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 10:11:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6E38D41976
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 10:11:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sFYxMaJ03udZ for <iommu@lists.linux-foundation.org>;
 Wed, 15 Jun 2022 10:11:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 455F241952
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 10:11:44 +0000 (UTC)
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LNLdn0Chwz6H7ll;
 Wed, 15 Jun 2022 18:10:05 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 15 Jun 2022 12:11:41 +0200
Received: from A2006125610.china.huawei.com (10.202.227.178) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 15 Jun 2022 11:11:34 +0100
To: <linux-arm-kernel@lists.infradead.org>, <linux-acpi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
Subject: [PATCH v13 1/9] iommu: Introduce a callback to struct
 iommu_resv_region
Date: Wed, 15 Jun 2022 11:10:36 +0100
Message-ID: <20220615101044.1972-2-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20220615101044.1972-1-shameerali.kolothum.thodi@huawei.com>
References: <20220615101044.1972-1-shameerali.kolothum.thodi@huawei.com>
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
YXJtLmNvbT4KVGVzdGVkLWJ5OiBMYXVyZW50aXUgVHVkb3IgPGxhdXJlbnRpdS50dWRvckBueHAu
Y29tPgpUZXN0ZWQtYnk6IEhhbmp1biBHdW8gPGd1b2hhbmp1bkBodWF3ZWkuY29tPgpTaWduZWQt
b2ZmLWJ5OiBTaGFtZWVyIEtvbG90aHVtIDxzaGFtZWVyYWxpLmtvbG90aHVtLnRob2RpQGh1YXdl
aS5jb20+Ci0tLQogZHJpdmVycy9pb21tdS9pb21tdS5jIHwgMTYgKysrKysrKysrKystLS0tLQog
aW5jbHVkZS9saW51eC9pb21tdS5oIHwgIDIgKysKIDIgZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0
aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2lvbW11
LmMgYi9kcml2ZXJzL2lvbW11L2lvbW11LmMKaW5kZXggODQ3YWQ0N2EyZGZkLi4yOThhOGMwNjA2
OTggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvaW9tbXUvaW9tbXUuYworKysgYi9kcml2ZXJzL2lvbW11
L2lvbW11LmMKQEAgLTI1OTAsMTYgKzI1OTAsMjIgQEAgdm9pZCBpb21tdV9wdXRfcmVzdl9yZWdp
b25zKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGxpc3RfaGVhZCAqbGlzdCkKICAqIEBsaXN0
OiByZXNlcnZlZCByZWdpb24gbGlzdCBmb3IgZGV2aWNlCiAgKgogICogSU9NTVUgZHJpdmVycyBj
YW4gdXNlIHRoaXMgdG8gaW1wbGVtZW50IHRoZWlyIC5wdXRfcmVzdl9yZWdpb25zKCkgY2FsbGJh
Y2sKLSAqIGZvciBzaW1wbGUgcmVzZXJ2YXRpb25zLiBNZW1vcnkgYWxsb2NhdGVkIGZvciBlYWNo
IHJlc2VydmVkIHJlZ2lvbiB3aWxsIGJlCi0gKiBmcmVlZC4gSWYgYW4gSU9NTVUgZHJpdmVyIGFs
bG9jYXRlcyBhZGRpdGlvbmFsIHJlc291cmNlcyBwZXIgcmVnaW9uLCBpdCBpcwotICogZ29pbmcg
dG8gaGF2ZSB0byBpbXBsZW1lbnQgYSBjdXN0b20gY2FsbGJhY2suCisgKiBmb3Igc2ltcGxlIHJl
c2VydmF0aW9ucy4gSWYgYSBwZXIgcmVnaW9uIGNhbGxiYWNrIGlzIHByb3ZpZGVkIHRoYXQgd2ls
bCBiZQorICogdXNlZCB0byBmcmVlIGFsbCBtZW1vcnkgYWxsb2NhdGlvbnMgYXNzb2NpYXRlZCB3
aXRoIHRoZSByZXNlcnZlZCByZWdpb24gb3IKKyAqIGVsc2UganVzdCBmcmVlIHVwIHRoZSBtZW1v
cnkgZm9yIHRoZSByZWdpb25zLiBJZiBhbiBJT01NVSBkcml2ZXIgYWxsb2NhdGVzCisgKiBhZGRp
dGlvbmFsIHJlc291cmNlcyBwZXIgcmVnaW9uLCBpdCBpcyBnb2luZyB0byBoYXZlIHRvIGltcGxl
bWVudCBhIGN1c3RvbQorICogY2FsbGJhY2suCiAgKi8KIHZvaWQgZ2VuZXJpY19pb21tdV9wdXRf
cmVzdl9yZWdpb25zKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGxpc3RfaGVhZCAqbGlzdCkK
IHsKIAlzdHJ1Y3QgaW9tbXVfcmVzdl9yZWdpb24gKmVudHJ5LCAqbmV4dDsKIAotCWxpc3RfZm9y
X2VhY2hfZW50cnlfc2FmZShlbnRyeSwgbmV4dCwgbGlzdCwgbGlzdCkKLQkJa2ZyZWUoZW50cnkp
OworCWxpc3RfZm9yX2VhY2hfZW50cnlfc2FmZShlbnRyeSwgbmV4dCwgbGlzdCwgbGlzdCkgewor
CQlpZiAoZW50cnktPmZyZWUpCisJCQllbnRyeS0+ZnJlZShkZXYsIGVudHJ5KTsKKwkJZWxzZQor
CQkJa2ZyZWUoZW50cnkpOworCX0KIH0KIEVYUE9SVF9TWU1CT0woZ2VuZXJpY19pb21tdV9wdXRf
cmVzdl9yZWdpb25zKTsKIApkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9pb21tdS5oIGIvaW5j
bHVkZS9saW51eC9pb21tdS5oCmluZGV4IDVlMWFmZTE2OTU0OS4uYjIyZmZhNmJjNGE5IDEwMDY0
NAotLS0gYS9pbmNsdWRlL2xpbnV4L2lvbW11LmgKKysrIGIvaW5jbHVkZS9saW51eC9pb21tdS5o
CkBAIC0xMzUsNiArMTM1LDcgQEAgZW51bSBpb21tdV9yZXN2X3R5cGUgewogICogQGxlbmd0aDog
TGVuZ3RoIG9mIHRoZSByZWdpb24gaW4gYnl0ZXMKICAqIEBwcm90OiBJT01NVSBQcm90ZWN0aW9u
IGZsYWdzIChSRUFEL1dSSVRFLy4uLikKICAqIEB0eXBlOiBUeXBlIG9mIHRoZSByZXNlcnZlZCBy
ZWdpb24KKyAqIEBmcmVlOiBDYWxsYmFjayB0byBmcmVlIGFzc29jaWF0ZWQgbWVtb3J5IGFsbG9j
YXRpb25zCiAgKi8KIHN0cnVjdCBpb21tdV9yZXN2X3JlZ2lvbiB7CiAJc3RydWN0IGxpc3RfaGVh
ZAlsaXN0OwpAQCAtMTQyLDYgKzE0Myw3IEBAIHN0cnVjdCBpb21tdV9yZXN2X3JlZ2lvbiB7CiAJ
c2l6ZV90CQkJbGVuZ3RoOwogCWludAkJCXByb3Q7CiAJZW51bSBpb21tdV9yZXN2X3R5cGUJdHlw
ZTsKKwl2b2lkICgqZnJlZSkoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgaW9tbXVfcmVzdl9y
ZWdpb24gKnJlZ2lvbik7CiB9OwogCiAvKioKLS0gCjIuMjUuMQoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
