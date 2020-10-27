Return-Path: <SRS0=PKzM=EC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0229C55179
	for <iommu@archiver.kernel.org>; Tue, 27 Oct 2020 11:28:25 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 186ED2072D
	for <iommu@archiver.kernel.org>; Tue, 27 Oct 2020 11:28:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 186ED2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C8168866D6;
	Tue, 27 Oct 2020 11:28:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 65W4-y6YLYnz; Tue, 27 Oct 2020 11:28:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C141B866B9;
	Tue, 27 Oct 2020 11:28:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BA8EAC0859;
	Tue, 27 Oct 2020 11:28:22 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2C418C0051
 for <iommu@lists.linux-foundation.org>; Tue, 27 Oct 2020 11:28:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 25C5F20497
 for <iommu@lists.linux-foundation.org>; Tue, 27 Oct 2020 11:28:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DOmU7oPQnsfw for <iommu@lists.linux-foundation.org>;
 Tue, 27 Oct 2020 11:28:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by silver.osuosl.org (Postfix) with ESMTPS id F142B203DF
 for <iommu@lists.linux-foundation.org>; Tue, 27 Oct 2020 11:28:18 +0000 (UTC)
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CL8b36LVczkZs1;
 Tue, 27 Oct 2020 19:28:15 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.47.24.15) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Tue, 27 Oct 2020 19:28:05 +0800
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <linux-arm-kernel@lists.infradead.org>, <linux-acpi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>, <devel@acpica.org>
Subject: [RFC PATCH 3/4] ACPI/IORT: Add RMR memory regions reservation helper
Date: Tue, 27 Oct 2020 11:26:45 +0000
Message-ID: <20201027112646.44680-4-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20201027112646.44680-1-shameerali.kolothum.thodi@huawei.com>
References: <20201027112646.44680-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.47.24.15]
X-CFilter-Loop: Reflected
Cc: linuxarm@huawei.com, guohanjun@huawei.com, robin.murphy@arm.com,
 wanghuiqiang@huawei.com
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

QWRkIGEgaGVscGVyIGZ1bmN0aW9uIHRoYXQgcmV0cmlldmVzIFJNUiBtZW1vcnkgZGVzY3JpcHRv
cnMKYXNzb2NpYXRlZCB3aXRoIGEgZ2l2ZW4gZW5kcG9pbnQgZGV2LiBUaGVzZSBtZW1vcnkgcmVn
aW9ucwpzaG91bGQgaGF2ZSBhIHVuaXR5wqBtYXBwaW5nIGluIHRoZSBTTU1VLiBTbyByZXNlcnZl
IHRoZW0gYXMKSU9NTVVfUkVTVl9ESVJFQ1QuCgpTaWduZWQtb2ZmLWJ5OiBTaGFtZWVyIEtvbG90
aHVtIDxzaGFtZWVyYWxpLmtvbG90aHVtLnRob2RpQGh1YXdlaS5jb20+Ci0tLQogZHJpdmVycy9h
Y3BpL2FybTY0L2lvcnQuYyB8IDU2ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKwogaW5jbHVkZS9saW51eC9hY3BpX2lvcnQuaCB8ICA0ICsrKwogMiBmaWxlcyBjaGFuZ2Vk
LCA2MCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL2FybTY0L2lvcnQu
YyBiL2RyaXZlcnMvYWNwaS9hcm02NC9pb3J0LmMKaW5kZXggYjMyY2Q1M2NjYTA4Li5jMDcwMDE0
OWU2MGIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvYWNwaS9hcm02NC9pb3J0LmMKKysrIGIvZHJpdmVy
cy9hY3BpL2FybTY0L2lvcnQuYwpAQCAtODQyLDYgKzg0Miw2MCBAQCBzdGF0aWMgaW5saW5lIGlu
dCBpb3J0X2FkZF9kZXZpY2VfcmVwbGF5KHN0cnVjdCBkZXZpY2UgKmRldikKIAlyZXR1cm4gZXJy
OwogfQogCitzdGF0aWMgYm9vbCBpb3J0X2Rldl9oYXNfcm1yKHN0cnVjdCBkZXZpY2UgKmRldiwg
c3RydWN0IGlvcnRfcm1yX2VudHJ5ICplKQoreworCXN0cnVjdCBpb21tdV9md3NwZWMgKmZ3c3Bl
YyA9IGRldl9pb21tdV9md3NwZWNfZ2V0KGRldik7CisJc3RydWN0IGFjcGlfaW9ydF9ub2RlICpp
b21tdTsKKwlzdHJ1Y3QgaW9ydF9ybXJfaWQgKnJtcl9pZHMgPSBlLT5ybXJfaWRzOworCWludCBp
LCBqOworCisJaW9tbXUgPSBpb3J0X2dldF9pb3J0X25vZGUoZndzcGVjLT5pb21tdV9md25vZGUp
OworCisJZm9yIChpID0gMDsgaSA8IGUtPnJtcl9pZHNfbnVtOyBpKyssIHJtcl9pZHMrKykgewor
CQlmb3IgKGogPSAwOyBqIDwgZndzcGVjLT5udW1faWRzOyBqKyspIHsKKwkJCWlmIChybXJfaWRz
LT5zaWQgPT0gZndzcGVjLT5pZHNbal0gJiYKKwkJCSAgICBybXJfaWRzLT5zbW11ID09IGlvbW11
KQorCQkJCXJldHVybiB0cnVlOworCQl9CisJfQorCisJcmV0dXJuIGZhbHNlOworfQorCisvKioK
KyAqIGlvcnRfZGV2X3Jtcl9nZXRfcmVzdl9yZWdpb25zIC0gUk1SIFJlc2VydmVkIHJlZ2lvbiBk
cml2ZXIgaGVscGVyCisgKiBAZGV2OiBEZXZpY2UgZnJvbSBpb21tdV9nZXRfcmVzdl9yZWdpb25z
KCkKKyAqIEBoZWFkOiBSZXNlcnZlZCByZWdpb24gbGlzdCBmcm9tIGlvbW11X2dldF9yZXN2X3Jl
Z2lvbnMoKQorICoKKyAqIFJldHVybnM6IDAgb24gc3VjY2VzcywgPDAgZmFpbHVyZQorICovCitp
bnQgaW9ydF9kZXZfcm1yX2dldF9yZXN2X3JlZ2lvbnMoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1
Y3QgbGlzdF9oZWFkICpoZWFkKQoreworCXN0cnVjdCBpb3J0X3Jtcl9lbnRyeSAqZTsKKworCWxp
c3RfZm9yX2VhY2hfZW50cnkoZSwgJmlvcnRfcm1yX2xpc3QsIGxpc3QpIHsKKwkJc3RydWN0IGlv
bW11X3Jlc3ZfcmVnaW9uICpyZWdpb247CisJCXN0cnVjdCBhY3BpX2lvcnRfcm1yX2Rlc2MgKnJt
cjsKKwkJaW50IHByb3QgPSBJT01NVV9SRUFEIHwgSU9NTVVfV1JJVEUgfAorCQkJICAgSU9NTVVf
Tk9FWEVDIHwgSU9NTVVfTU1JTzsKKworCQlpZiAoIWlvcnRfZGV2X2hhc19ybXIoZGV2LCBlKSkK
KwkJCWNvbnRpbnVlOworCisJCXJtciA9IGUtPnJtcl9kZXNjOworCQlyZWdpb24gPSBpb21tdV9h
bGxvY19yZXN2X3JlZ2lvbihybXItPmJhc2VfYWRkcmVzcywKKwkJCQkJCSBybXItPmxlbmd0aCwg
cHJvdCwKKwkJCQkJCSBJT01NVV9SRVNWX0RJUkVDVCk7CisJCWlmICghcmVnaW9uKSB7CisJCQlk
ZXZfZXJyKGRldiwgIk91dCBvZiBtZW1vcnkgYWxsb2NhdGluZyBSTVIgcmVnaW9uc1xuIik7CisJ
CQlyZXR1cm4gLUVOT01FTTsKKwkJfQorCQlsaXN0X2FkZF90YWlsKCZyZWdpb24tPmxpc3QsIGhl
YWQpOworCX0KKworCXJldHVybiAwOworfQorCiAvKioKICAqIGlvcnRfaW9tbXVfbXNpX2dldF9y
ZXN2X3JlZ2lvbnMgLSBSZXNlcnZlZCByZWdpb24gZHJpdmVyIGhlbHBlcgogICogQGRldjogRGV2
aWNlIGZyb20gaW9tbXVfZ2V0X3Jlc3ZfcmVnaW9ucygpCkBAIC0xMTEyLDYgKzExNjYsOCBAQCBp
bnQgaW9ydF9pb21tdV9tc2lfZ2V0X3Jlc3ZfcmVnaW9ucyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0
cnVjdCBsaXN0X2hlYWQgKmhlYWQpCiBjb25zdCBzdHJ1Y3QgaW9tbXVfb3BzICppb3J0X2lvbW11
X2NvbmZpZ3VyZV9pZChzdHJ1Y3QgZGV2aWNlICpkZXYsCiAJCQkJCQljb25zdCB1MzIgKmlucHV0
X2lkKQogeyByZXR1cm4gTlVMTDsgfQoraW50IGlvcnRfZGV2X3Jtcl9nZXRfcmVzdl9yZWdpb25z
KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGxpc3RfaGVhZCAqaGVhZCkKK3sgcmV0dXJuIDA7
IH0KICNlbmRpZgogCiBzdGF0aWMgaW50IG5jX2RtYV9nZXRfcmFuZ2Uoc3RydWN0IGRldmljZSAq
ZGV2LCB1NjQgKnNpemUpCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2FjcGlfaW9ydC5oIGIv
aW5jbHVkZS9saW51eC9hY3BpX2lvcnQuaAppbmRleCAyMGEzMjEyMGJiODguLjZkZDg5ZmFmMzQw
YyAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9hY3BpX2lvcnQuaAorKysgYi9pbmNsdWRlL2xp
bnV4L2FjcGlfaW9ydC5oCkBAIC0zOCw2ICszOCw3IEBAIHZvaWQgaW9ydF9kbWFfc2V0dXAoc3Ry
dWN0IGRldmljZSAqZGV2LCB1NjQgKmRtYV9hZGRyLCB1NjQgKnNpemUpOwogY29uc3Qgc3RydWN0
IGlvbW11X29wcyAqaW9ydF9pb21tdV9jb25maWd1cmVfaWQoc3RydWN0IGRldmljZSAqZGV2LAog
CQkJCQkJY29uc3QgdTMyICppZF9pbik7CiBpbnQgaW9ydF9pb21tdV9tc2lfZ2V0X3Jlc3ZfcmVn
aW9ucyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBsaXN0X2hlYWQgKmhlYWQpOworaW50IGlv
cnRfZGV2X3Jtcl9nZXRfcmVzdl9yZWdpb25zKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGxp
c3RfaGVhZCAqaGVhZCk7CiAjZWxzZQogc3RhdGljIGlubGluZSB2b2lkIGFjcGlfaW9ydF9pbml0
KHZvaWQpIHsgfQogc3RhdGljIGlubGluZSB1MzIgaW9ydF9tc2lfbWFwX2lkKHN0cnVjdCBkZXZp
Y2UgKmRldiwgdTMyIGlkKQpAQCAtNTUsNiArNTYsOSBAQCBzdGF0aWMgaW5saW5lIGNvbnN0IHN0
cnVjdCBpb21tdV9vcHMgKmlvcnRfaW9tbXVfY29uZmlndXJlX2lkKAogc3RhdGljIGlubGluZQog
aW50IGlvcnRfaW9tbXVfbXNpX2dldF9yZXN2X3JlZ2lvbnMoc3RydWN0IGRldmljZSAqZGV2LCBz
dHJ1Y3QgbGlzdF9oZWFkICpoZWFkKQogeyByZXR1cm4gMDsgfQorc3RhdGljIGlubGluZQoraW50
IGlvcnRfZGV2X3Jtcl9nZXRfcmVzdl9yZWdpb25zKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0
IGxpc3RfaGVhZCAqaGVhZCkKK3sgcmV0dXJuIDA7IH0KICNlbmRpZgogCiAjZW5kaWYgLyogX19B
Q1BJX0lPUlRfSF9fICovCi0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby9pb21tdQ==
