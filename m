Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 445EFC433FE
	for <iommu@archiver.kernel.org>; Fri, 22 Apr 2022 16:29:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EA6C740AD6;
	Fri, 22 Apr 2022 16:29:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PnQreOsv0N8c; Fri, 22 Apr 2022 16:29:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CD6F740AD8;
	Fri, 22 Apr 2022 16:29:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A2C4DC0039;
	Fri, 22 Apr 2022 16:29:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3B57CC002D
 for <iommu@lists.linux-foundation.org>; Fri, 22 Apr 2022 16:29:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2973B4036A
 for <iommu@lists.linux-foundation.org>; Fri, 22 Apr 2022 16:29:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gmzw4FjBn-2X for <iommu@lists.linux-foundation.org>;
 Fri, 22 Apr 2022 16:29:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4B03A408DC
 for <iommu@lists.linux-foundation.org>; Fri, 22 Apr 2022 16:29:43 +0000 (UTC)
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KlKYl3pGzz6892X;
 Sat, 23 Apr 2022 00:27:07 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 22 Apr 2022 18:29:40 +0200
Received: from A2006125610.china.huawei.com (10.202.227.178) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 22 Apr 2022 17:29:32 +0100
To: <linux-arm-kernel@lists.infradead.org>, <linux-acpi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
Subject: [PATCH v11 1/9] iommu: Introduce a callback to struct
 iommu_resv_region
Date: Fri, 22 Apr 2022 17:28:59 +0100
Message-ID: <20220422162907.1276-2-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20220422162907.1276-1-shameerali.kolothum.thodi@huawei.com>
References: <20220422162907.1276-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.202.227.178]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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
UlQgUk1SIGJhc2VkIHJlc2VydmVkIHJlZ2lvbnMuCgpTaWduZWQtb2ZmLWJ5OiBTaGFtZWVyIEtv
bG90aHVtIDxzaGFtZWVyYWxpLmtvbG90aHVtLnRob2RpQGh1YXdlaS5jb20+Ci0tLQogZHJpdmVy
cy9pb21tdS9pb21tdS5jIHwgMTYgKysrKysrKysrKystLS0tLQogaW5jbHVkZS9saW51eC9pb21t
dS5oIHwgIDIgKysKIDIgZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2lvbW11LmMgYi9kcml2ZXJzL2lvbW11
L2lvbW11LmMKaW5kZXggZjJjNDViODViOWZjLi5mZmNmYTY4NGU4MGMgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvaW9tbXUvaW9tbXUuYworKysgYi9kcml2ZXJzL2lvbW11L2lvbW11LmMKQEAgLTI1OTcs
MTYgKzI1OTcsMjIgQEAgdm9pZCBpb21tdV9wdXRfcmVzdl9yZWdpb25zKHN0cnVjdCBkZXZpY2Ug
KmRldiwgc3RydWN0IGxpc3RfaGVhZCAqbGlzdCkKICAqIEBsaXN0OiByZXNlcnZlZCByZWdpb24g
bGlzdCBmb3IgZGV2aWNlCiAgKgogICogSU9NTVUgZHJpdmVycyBjYW4gdXNlIHRoaXMgdG8gaW1w
bGVtZW50IHRoZWlyIC5wdXRfcmVzdl9yZWdpb25zKCkgY2FsbGJhY2sKLSAqIGZvciBzaW1wbGUg
cmVzZXJ2YXRpb25zLiBNZW1vcnkgYWxsb2NhdGVkIGZvciBlYWNoIHJlc2VydmVkIHJlZ2lvbiB3
aWxsIGJlCi0gKiBmcmVlZC4gSWYgYW4gSU9NTVUgZHJpdmVyIGFsbG9jYXRlcyBhZGRpdGlvbmFs
IHJlc291cmNlcyBwZXIgcmVnaW9uLCBpdCBpcwotICogZ29pbmcgdG8gaGF2ZSB0byBpbXBsZW1l
bnQgYSBjdXN0b20gY2FsbGJhY2suCisgKiBmb3Igc2ltcGxlIHJlc2VydmF0aW9ucy4gSWYgYSBw
ZXIgcmVnaW9uIGNhbGxiYWNrIGlzIHByb3ZpZGVkIHRoYXQgd2lsbCBiZQorICogdXNlZCB0byBm
cmVlIGFsbCBtZW1vcnkgYWxsb2NhdGlvbnMgYXNzb2NpYXRlZCB3aXRoIHRoZSByZXNlcnZlZCBy
ZWdpb24gb3IKKyAqIGVsc2UganVzdCBmcmVlIHVwIHRoZSBtZW1vcnkgZm9yIHRoZSByZWdpb25z
LiBJZiBhbiBJT01NVSBkcml2ZXIgYWxsb2NhdGVzCisgKiBhZGRpdGlvbmFsIHJlc291cmNlcyBw
ZXIgcmVnaW9uLCBpdCBpcyBnb2luZyB0byBoYXZlIHRvIGltcGxlbWVudCBhIGN1c3RvbQorICog
Y2FsbGJhY2suCiAgKi8KIHZvaWQgZ2VuZXJpY19pb21tdV9wdXRfcmVzdl9yZWdpb25zKHN0cnVj
dCBkZXZpY2UgKmRldiwgc3RydWN0IGxpc3RfaGVhZCAqbGlzdCkKIHsKIAlzdHJ1Y3QgaW9tbXVf
cmVzdl9yZWdpb24gKmVudHJ5LCAqbmV4dDsKIAotCWxpc3RfZm9yX2VhY2hfZW50cnlfc2FmZShl
bnRyeSwgbmV4dCwgbGlzdCwgbGlzdCkKLQkJa2ZyZWUoZW50cnkpOworCWxpc3RfZm9yX2VhY2hf
ZW50cnlfc2FmZShlbnRyeSwgbmV4dCwgbGlzdCwgbGlzdCkgeworCQlpZiAoZW50cnktPmZyZWUp
CisJCQllbnRyeS0+ZnJlZShkZXYsIGVudHJ5KTsKKwkJZWxzZQorCQkJa2ZyZWUoZW50cnkpOwor
CX0KIH0KIEVYUE9SVF9TWU1CT0woZ2VuZXJpY19pb21tdV9wdXRfcmVzdl9yZWdpb25zKTsKIApk
aWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9pb21tdS5oIGIvaW5jbHVkZS9saW51eC9pb21tdS5o
CmluZGV4IDkyMDhlY2E0YjBkMS4uNjhiY2ZiM2EwNmQ3IDEwMDY0NAotLS0gYS9pbmNsdWRlL2xp
bnV4L2lvbW11LmgKKysrIGIvaW5jbHVkZS9saW51eC9pb21tdS5oCkBAIC0xMzQsNiArMTM0LDcg
QEAgZW51bSBpb21tdV9yZXN2X3R5cGUgewogICogQGxlbmd0aDogTGVuZ3RoIG9mIHRoZSByZWdp
b24gaW4gYnl0ZXMKICAqIEBwcm90OiBJT01NVSBQcm90ZWN0aW9uIGZsYWdzIChSRUFEL1dSSVRF
Ly4uLikKICAqIEB0eXBlOiBUeXBlIG9mIHRoZSByZXNlcnZlZCByZWdpb24KKyAqIEBmcmVlOiBD
YWxsYmFjayB0byBmcmVlIGFzc29jaWF0ZWQgbWVtb3J5IGFsbG9jYXRpb25zCiAgKi8KIHN0cnVj
dCBpb21tdV9yZXN2X3JlZ2lvbiB7CiAJc3RydWN0IGxpc3RfaGVhZAlsaXN0OwpAQCAtMTQxLDYg
KzE0Miw3IEBAIHN0cnVjdCBpb21tdV9yZXN2X3JlZ2lvbiB7CiAJc2l6ZV90CQkJbGVuZ3RoOwog
CWludAkJCXByb3Q7CiAJZW51bSBpb21tdV9yZXN2X3R5cGUJdHlwZTsKKwl2b2lkICgqZnJlZSko
c3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgaW9tbXVfcmVzdl9yZWdpb24gKnJlZ2lvbik7CiB9
OwogCiAvKioKLS0gCjIuMTcuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2lvbW11
