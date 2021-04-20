Return-Path: <SRS0=gpU2=JR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE926C433ED
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 09:29:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72FAA61090
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 09:29:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72FAA61090
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 134574033E;
	Tue, 20 Apr 2021 09:29:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6lzG2dvi1JMv; Tue, 20 Apr 2021 09:29:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id A364840308;
	Tue, 20 Apr 2021 09:29:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8B933C000E;
	Tue, 20 Apr 2021 09:29:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 840A4C000B
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 09:29:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8000E40308
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 09:29:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x5j4wNzNjZ4u for <iommu@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 09:29:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4F02D4033E
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 09:29:09 +0000 (UTC)
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FPdc54Q90zrffL;
 Tue, 20 Apr 2021 17:26:45 +0800 (CST)
Received: from A2006125610.china.huawei.com (10.47.83.26) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Tue, 20 Apr 2021 17:28:57 +0800
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <linux-arm-kernel@lists.infradead.org>, <linux-acpi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
Subject: [PATCH v3 09/10] iommu/arm-smmu: Get associated RMR info and install
 bypass SMR
Date: Tue, 20 Apr 2021 10:27:50 +0200
Message-ID: <20210420082751.1829-10-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20210420082751.1829-1-shameerali.kolothum.thodi@huawei.com>
References: <20210420082751.1829-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.47.83.26]
X-CFilter-Loop: Reflected
Cc: jon@solid-run.com, linuxarm@huawei.com, steven.price@arm.com,
 guohanjun@huawei.com, Sami.Mujawar@arm.com, robin.murphy@arm.com,
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

RnJvbTogSm9uIE5ldHRsZXRvbiA8am9uQHNvbGlkLXJ1bi5jb20+CgpDaGVjayBpZiB0aGVyZSBp
cyBhbnkgUk1SIGluZm8gYXNzb2NpYXRlZMKgd2l0aCB0aGUgZGV2aWNlcyBiZWhpbmQKdGhlIFNN
TVUgYW5kIGlmIGFueSwgaW5zdGFsbCBieXBhc3MgU01ScyBmb3IgdGhlbS4gVGhpcyBpcyB0bwpr
ZWVwIGFueSBvbmdvaW5nIHRyYWZmaWMgYXNzb2NpYXRlZCB3aXRoIHRoZXNlIGRldmljZXMgYWxp
dmUKd2hlbiB3ZSBlbmFibGUvcmVzZXQgU01NVSBkdXJpbmcgcHJvYmUoKS4KClNpZ25lZC1vZmYt
Ynk6IEpvbiBOZXR0bGV0b24gPGpvbkBzb2xpZC1ydW4uY29tPgpTaWduZWQtb2ZmLWJ5OiBTaGFt
ZWVyIEtvbG90aHVtIDxzaGFtZWVyYWxpLmtvbG90aHVtLnRob2RpQGh1YXdlaS5jb20+Ci0tLQog
ZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUvYXJtLXNtbXUuYyB8IDQyICsrKysrKysrKysrKysr
KysrKysrKysrKysrKwogZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUvYXJtLXNtbXUuaCB8ICAy
ICsrCiAyIGZpbGVzIGNoYW5nZWQsIDQ0IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2lvbW11L2FybS9hcm0tc21tdS9hcm0tc21tdS5jIGIvZHJpdmVycy9pb21tdS9hcm0vYXJt
LXNtbXUvYXJtLXNtbXUuYwppbmRleCBkOGM2YmZkZTZhNjEuLjRkMmY5MTYyNmQ4NyAxMDA2NDQK
LS0tIGEvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUvYXJtLXNtbXUuYworKysgYi9kcml2ZXJz
L2lvbW11L2FybS9hcm0tc21tdS9hcm0tc21tdS5jCkBAIC0yMTAyLDYgKzIxMDIsNDMgQEAgZXJy
X3Jlc2V0X3BsYXRmb3JtX29wczogX19tYXliZV91bnVzZWQ7CiAJcmV0dXJuIGVycjsKIH0KIAor
c3RhdGljIHZvaWQgYXJtX3NtbXVfcm1yX2luc3RhbGxfYnlwYXNzX3NtcihzdHJ1Y3QgYXJtX3Nt
bXVfZGV2aWNlICpzbW11KQoreworCXN0cnVjdCBpb21tdV9ybXIgKmU7CisJaW50IGksIGNudCA9
IDA7CisJdTMyIHNtcjsKKworCWZvciAoaSA9IDA7IGkgPCBzbW11LT5udW1fbWFwcGluZ19ncm91
cHM7IGkrKykgeworCQlzbXIgPSBhcm1fc21tdV9ncjBfcmVhZChzbW11LCBBUk1fU01NVV9HUjBf
U01SKGkpKTsKKwkJaWYgKCFGSUVMRF9HRVQoQVJNX1NNTVVfU01SX1ZBTElELCBzbXIpKQorCQkJ
Y29udGludWU7CisKKwkJbGlzdF9mb3JfZWFjaF9lbnRyeShlLCAmc21tdS0+cm1yX2xpc3QsIGxp
c3QpIHsKKwkJCWlmIChGSUVMRF9HRVQoQVJNX1NNTVVfU01SX0lELCBzbXIpICE9IGUtPnNpZCkK
KwkJCQljb250aW51ZTsKKworCQkJc21tdS0+c21yc1tpXS5pZCA9IEZJRUxEX0dFVChBUk1fU01N
VV9TTVJfSUQsIHNtcik7CisJCQlzbW11LT5zbXJzW2ldLm1hc2sgPSBGSUVMRF9HRVQoQVJNX1NN
TVVfU01SX01BU0ssIHNtcik7CisJCQlzbW11LT5zbXJzW2ldLnZhbGlkID0gdHJ1ZTsKKworCQkJ
c21tdS0+czJjcnNbaV0udHlwZSA9IFMyQ1JfVFlQRV9CWVBBU1M7CisJCQlzbW11LT5zMmNyc1tp
XS5wcml2Y2ZnID0gUzJDUl9QUklWQ0ZHX0RFRkFVTFQ7CisJCQlzbW11LT5zMmNyc1tpXS5jYm5k
eCA9IDB4ZmY7CisKKwkJCWNudCsrOworCQl9CisJfQorCisJZGV2X25vdGljZShzbW11LT5kZXYs
ICJcdHByZXNlcnZlZCAlZCBib290IG1hcHBpbmclc1xuIiwgY250LAorCQkgICBjbnQgPT0gMSA/
ICIiIDogInMiKTsKK30KKworc3RhdGljIGludCBhcm1fc21tdV9nZXRfcm1yKHN0cnVjdCBhcm1f
c21tdV9kZXZpY2UgKnNtbXUpCit7CisJSU5JVF9MSVNUX0hFQUQoJnNtbXUtPnJtcl9saXN0KTsK
KwlyZXR1cm4gaW9tbXVfZG1hX2dldF9ybXJzKGRldl9md25vZGUoc21tdS0+ZGV2KSwgJnNtbXUt
PnJtcl9saXN0KTsKK30KKwogc3RhdGljIGludCBhcm1fc21tdV9kZXZpY2VfcHJvYmUoc3RydWN0
IHBsYXRmb3JtX2RldmljZSAqcGRldikKIHsKIAlzdHJ1Y3QgcmVzb3VyY2UgKnJlczsKQEAgLTIy
MzEsNiArMjI2OCwxMSBAQCBzdGF0aWMgaW50IGFybV9zbW11X2RldmljZV9wcm9iZShzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlICpwZGV2KQogCX0KIAogCXBsYXRmb3JtX3NldF9kcnZkYXRhKHBkZXYs
IHNtbXUpOworCisJLyogQ2hlY2sgZm9yIFJNUnMgYW5kIGluc3RhbGwgYnlwYXNzIFNNUnMgaWYg
YW55ICovCisJaWYgKCFhcm1fc21tdV9nZXRfcm1yKHNtbXUpKQorCQlhcm1fc21tdV9ybXJfaW5z
dGFsbF9ieXBhc3Nfc21yKHNtbXUpOworCiAJYXJtX3NtbXVfZGV2aWNlX3Jlc2V0KHNtbXUpOwog
CWFybV9zbW11X3Rlc3Rfc21yX21hc2tzKHNtbXUpOwogCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lv
bW11L2FybS9hcm0tc21tdS9hcm0tc21tdS5oIGIvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUv
YXJtLXNtbXUuaAppbmRleCBkMmEyZDFiYzU4YmEuLmNhOTU1OWViODczMyAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUvYXJtLXNtbXUuaAorKysgYi9kcml2ZXJzL2lvbW11
L2FybS9hcm0tc21tdS9hcm0tc21tdS5oCkBAIC0zMjYsNiArMzI2LDggQEAgc3RydWN0IGFybV9z
bW11X2RldmljZSB7CiAKIAkvKiBJT01NVSBjb3JlIGNvZGUgaGFuZGxlICovCiAJc3RydWN0IGlv
bW11X2RldmljZQkJaW9tbXU7CisKKwlzdHJ1Y3QgbGlzdF9oZWFkCQlybXJfbGlzdDsKIH07CiAK
IGVudW0gYXJtX3NtbXVfY29udGV4dF9mbXQgewotLSAKMi4xNy4xCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVA
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
