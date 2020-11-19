Return-Path: <SRS0=wYjh=EZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CCDC388F9
	for <iommu@archiver.kernel.org>; Thu, 19 Nov 2020 12:13:20 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF5F2206D5
	for <iommu@archiver.kernel.org>; Thu, 19 Nov 2020 12:13:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF5F2206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7A495272BB;
	Thu, 19 Nov 2020 12:13:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q2l6-B-XLb6X; Thu, 19 Nov 2020 12:13:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 565DB204E6;
	Thu, 19 Nov 2020 12:13:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4335AC0891;
	Thu, 19 Nov 2020 12:13:18 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 43C43C0891
 for <iommu@lists.linux-foundation.org>; Thu, 19 Nov 2020 12:13:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 327A286B01
 for <iommu@lists.linux-foundation.org>; Thu, 19 Nov 2020 12:13:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PVRs5jEwbdmi for <iommu@lists.linux-foundation.org>;
 Thu, 19 Nov 2020 12:13:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 8F65E85F85
 for <iommu@lists.linux-foundation.org>; Thu, 19 Nov 2020 12:13:13 +0000 (UTC)
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CcJV00Bwhzhd20;
 Thu, 19 Nov 2020 20:12:56 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.210.168.73) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Thu, 19 Nov 2020 20:13:02 +0800
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <linux-arm-kernel@lists.infradead.org>, <linux-acpi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>, <devel@acpica.org>
Subject: [RFC PATCH v2 7/8] iommu/arm-smmu-v3: Get associated RMR info and
 install bypass STE
Date: Thu, 19 Nov 2020 12:11:49 +0000
Message-ID: <20201119121150.3316-8-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20201119121150.3316-1-shameerali.kolothum.thodi@huawei.com>
References: <20201119121150.3316-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.210.168.73]
X-CFilter-Loop: Reflected
Cc: linuxarm@huawei.com, steven.price@arm.com, guohanjun@huawei.com,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Q2hlY2sgaWYgdGhlcmUgaXMgYW55IFJNUiBpbmZvIGFzc29jaWF0ZWTCoHdpdGggdGhlIGRldmlj
ZXMgYmVoaW5kCnRoZSBTTU1VdjMgYW5kIGlmIGFueSwgaW5zdGFsbCBieXBhc3MgU1RFcyBmb3Ig
dGhlbS4gVGhpcyBpcyB0bwprZWVwIGFueSBvbmdvaW5nIHRyYWZmaWMgYXNzb2NpYXRlZCB3aXRo
IHRoZXNlIGRldmljZXMgYWxpdmUKd2hlbiB3ZSBlbmFibGUvcmVzZXQgU01NVXYzIGR1cmluZyBw
cm9iZSgpLgoKU2lnbmVkLW9mZi1ieTogU2hhbWVlciBLb2xvdGh1bSA8c2hhbWVlcmFsaS5rb2xv
dGh1bS50aG9kaUBodWF3ZWkuY29tPgotLS0KIGRyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYz
L2FybS1zbW11LXYzLmMgfCA0MCArKysrKysrKysrKysrKysrKysrKysKIGRyaXZlcnMvaW9tbXUv
YXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLmggfCAgMiArKwogMiBmaWxlcyBjaGFuZ2VkLCA0
MiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUt
djMvYXJtLXNtbXUtdjMuYyBiL2RyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11
LXYzLmMKaW5kZXggNWYzNjZkNWE5ZWJmLi45N2RmMWRmMDAxYzkgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLmMKKysrIGIvZHJpdmVycy9pb21t
dS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMuYwpAQCAtMzQ4Niw2ICszNDg2LDQyIEBAIHN0
YXRpYyB2b2lkIF9faW9tZW0gKmFybV9zbW11X2lvcmVtYXAoc3RydWN0IGRldmljZSAqZGV2LCBy
ZXNvdXJjZV9zaXplX3Qgc3RhcnQsCiAJcmV0dXJuIGRldm1faW9yZW1hcF9yZXNvdXJjZShkZXYs
ICZyZXMpOwogfQogCitzdGF0aWMgdm9pZCBhcm1fc21tdV9ybXJfaW5zdGFsbF9ieXBhc3Nfc3Rl
KHN0cnVjdCBhcm1fc21tdV9kZXZpY2UgKnNtbXUpCit7CisJc3RydWN0IGlvbW11X3JtciAqZTsK
KwlpbnQgaSwgcmV0OworCisJLyoKKwkgKiBTaW5jZSwgd2UgZG9uJ3QgaGF2ZSBhIG1lY2hhbmlz
bSB0byBkaWZmZXJlbnRpYXRlIHRoZSBSTVIKKwkgKiBTSURzIHRoYXQgaGFzIGFuIG9uZ29pbmcg
bGl2ZSBzdHJlYW0sIGluc3RhbGwgYnlwYXNzIFNURXMKKwkgKiBmb3IgYWxsIHRoZSByZXBvcnRl
ZCBvbmVzLsKgCisJICogRml4TWU6IEF2b2lkIGR1cGxpY2F0ZSBTSURzIGluIHRoZSBsaXN0IGFz
IG9uZSBzaWQgbWF5CisJICogICAgICAgIGFzc29jaWF0ZSB3aXRoIG11bHRpcGxlIFJNUnMuCisJ
ICovCisJbGlzdF9mb3JfZWFjaF9lbnRyeShlLCAmc21tdS0+cm1yX2xpc3QsIGxpc3QpIHsKKwkJ
Zm9yIChpID0gMDsgaSA8IGUtPm51bV9pZHM7IGkrKykgeworCQkJX19sZTY0ICpzdGVwOworCQkJ
dTMyIHNpZCA9IGUtPmlkc1tpXTsKKworCQkJcmV0ID0gYXJtX3NtbXVfaW5pdF9zaWRfc3RydGFi
KHNtbXUsIHNpZCk7CisJCQlpZiAocmV0KSB7CisJCQkJZGV2X2VycihzbW11LT5kZXYsICJSTVIg
YnlwYXNzKDB4JXgpIGZhaWxlZFxuIiwKKwkJCQkJc2lkKTsKKwkJCQljb250aW51ZTsKKwkJCX0K
KworCQkJc3RlcCA9IGFybV9zbW11X2dldF9zdGVwX2Zvcl9zaWQoc21tdSwgc2lkKTsKKwkJCWFy
bV9zbW11X3dyaXRlX3N0cnRhYl9lbnQoTlVMTCwgc2lkLCBzdGVwLCB0cnVlKTsKKwkJfQorCX0K
K30KKworc3RhdGljIGludCBhcm1fc21tdV9nZXRfcm1yKHN0cnVjdCBhcm1fc21tdV9kZXZpY2Ug
KnNtbXUpCit7CisJSU5JVF9MSVNUX0hFQUQoJnNtbXUtPnJtcl9saXN0KTsKKwlyZXR1cm4gaW9t
bXVfZG1hX2dldF9ybXJzKGRldl9md25vZGUoc21tdS0+ZGV2KSwgJnNtbXUtPnJtcl9saXN0KTsK
K30KKwogc3RhdGljIGludCBhcm1fc21tdV9kZXZpY2VfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rl
dmljZSAqcGRldikKIHsKIAlpbnQgaXJxLCByZXQ7CkBAIC0zNTY5LDYgKzM2MDUsMTAgQEAgc3Rh
dGljIGludCBhcm1fc21tdV9kZXZpY2VfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRl
dikKIAkvKiBSZWNvcmQgb3VyIHByaXZhdGUgZGV2aWNlIHN0cnVjdHVyZSAqLwogCXBsYXRmb3Jt
X3NldF9kcnZkYXRhKHBkZXYsIHNtbXUpOwogCisJLyogQ2hlY2sgZm9yIFJNUnMgYW5kIGluc3Rh
bGwgYnlwYXNzIFNURXMgaWYgYW55ICovCisJaWYgKCFhcm1fc21tdV9nZXRfcm1yKHNtbXUpKQor
CQlhcm1fc21tdV9ybXJfaW5zdGFsbF9ieXBhc3Nfc3RlKHNtbXUpOworCiAJLyogUmVzZXQgdGhl
IGRldmljZSAqLwogCXJldCA9IGFybV9zbW11X2RldmljZV9yZXNldChzbW11LCBieXBhc3MpOwog
CWlmIChyZXQpCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0t
c21tdS12My5oIGIvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMuaApp
bmRleCBkNGI3ZjQwY2NiMDIuLjE3YjUxN2RkZWNlZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9pb21t
dS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMuaAorKysgYi9kcml2ZXJzL2lvbW11L2FybS9h
cm0tc21tdS12My9hcm0tc21tdS12My5oCkBAIC02MzYsNiArNjM2LDggQEAgc3RydWN0IGFybV9z
bW11X2RldmljZSB7CiAKIAkvKiBJT01NVSBjb3JlIGNvZGUgaGFuZGxlICovCiAJc3RydWN0IGlv
bW11X2RldmljZQkJaW9tbXU7CisKKwlzdHJ1Y3QgbGlzdF9oZWFkCQlybXJfbGlzdDsKIH07CiAK
IC8qIFNNTVUgcHJpdmF0ZSBkYXRhIGZvciBlYWNoIG1hc3RlciAqLwotLSAKMi4xNy4xCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5n
IGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
