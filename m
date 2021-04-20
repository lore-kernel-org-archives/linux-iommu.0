Return-Path: <SRS0=gpU2=JR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22526C433B4
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 09:29:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C19C261073
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 09:29:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C19C261073
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 907BB6080E;
	Tue, 20 Apr 2021 09:29:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jwWh_esVK1ME; Tue, 20 Apr 2021 09:29:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7F47D6081E;
	Tue, 20 Apr 2021 09:29:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5DD8BC000E;
	Tue, 20 Apr 2021 09:29:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 47128C000B
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 09:29:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BAFFB40286
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 09:29:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zH2OHPFfTDpJ for <iommu@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 09:29:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 138164021E
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 09:29:03 +0000 (UTC)
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FPdc02yFRz19Ln5;
 Tue, 20 Apr 2021 17:26:40 +0800 (CST)
Received: from A2006125610.china.huawei.com (10.47.83.26) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Tue, 20 Apr 2021 17:28:51 +0800
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <linux-arm-kernel@lists.infradead.org>, <linux-acpi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
Subject: [PATCH v3 08/10] iommu/arm-smmu-v3: Reserve any RMR regions
 associated with a dev
Date: Tue, 20 Apr 2021 10:27:49 +0200
Message-ID: <20210420082751.1829-9-shameerali.kolothum.thodi@huawei.com>
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

R2V0IFJNUiByZWdpb25zIGFzc29jaWF0ZWQgd2l0aCBhIGRldsKgcmVzZXJ2ZWQgc28gdGhhdCB0
aGVyZSBpcwphIHVuaXR5IG1hcHBpbmcgZm9yIHRoZW0gaW7CoFNNTVUuCgpTaWduZWQtb2ZmLWJ5
OiBTaGFtZWVyIEtvbG90aHVtIDxzaGFtZWVyYWxpLmtvbG90aHVtLnRob2RpQGh1YXdlaS5jb20+
Ci0tLQogZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMuYyB8IDI5ICsr
KysrKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDI5IGluc2VydGlvbnMoKykKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12My5jIGIv
ZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMuYwppbmRleCAxNGU5Yzcw
MzRjMDQuLjhiYWNlZGY3YmIzNCAxMDA2NDQKLS0tIGEvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNt
bXUtdjMvYXJtLXNtbXUtdjMuYworKysgYi9kcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9h
cm0tc21tdS12My5jCkBAIC0yNTMxLDYgKzI1MzEsMzQgQEAgc3RhdGljIGludCBhcm1fc21tdV9v
Zl94bGF0ZShzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBvZl9waGFuZGxlX2FyZ3MgKmFyZ3Mp
CiAJcmV0dXJuIGlvbW11X2Z3c3BlY19hZGRfaWRzKGRldiwgYXJncy0+YXJncywgMSk7CiB9CiAK
K3N0YXRpYyBib29sIGFybV9zbW11X2Rldl9oYXNfcm1yKHN0cnVjdCBhcm1fc21tdV9tYXN0ZXIg
Km1hc3RlciwKKwkJCQkgc3RydWN0IGlvbW11X3JtciAqZSkKK3sKKwlpbnQgaTsKKworCWZvciAo
aSA9IDA7IGkgPCBtYXN0ZXItPm51bV9zaWRzOyBpKyspIHsKKwkJaWYgKGUtPnNpZCA9PSBtYXN0
ZXItPnNpZHNbaV0pCisJCQlyZXR1cm4gdHJ1ZTsKKwl9CisKKwlyZXR1cm4gZmFsc2U7Cit9CisK
K3N0YXRpYyB2b2lkIGFybV9zbW11X3Jtcl9nZXRfcmVzdl9yZWdpb25zKHN0cnVjdCBkZXZpY2Ug
KmRldiwKKwkJCQkJICBzdHJ1Y3QgbGlzdF9oZWFkICpoZWFkKQoreworCXN0cnVjdCBhcm1fc21t
dV9tYXN0ZXIgKm1hc3RlciA9IGRldl9pb21tdV9wcml2X2dldChkZXYpOworCXN0cnVjdCBhcm1f
c21tdV9kZXZpY2UgKnNtbXUgPSBtYXN0ZXItPnNtbXU7CisJc3RydWN0IGlvbW11X3JtciAqcm1y
OworCisJbGlzdF9mb3JfZWFjaF9lbnRyeShybXIsICZzbW11LT5ybXJfbGlzdCwgbGlzdCkgewor
CQlpZiAoIWFybV9zbW11X2Rldl9oYXNfcm1yKG1hc3Rlciwgcm1yKSkKKwkJCWNvbnRpbnVlOwor
CisJCWlvbW11X2RtYV9nZXRfcm1yX3Jlc3ZfcmVnaW9ucyhkZXYsIHJtciwgaGVhZCk7CisJfQor
fQorCiBzdGF0aWMgdm9pZCBhcm1fc21tdV9nZXRfcmVzdl9yZWdpb25zKHN0cnVjdCBkZXZpY2Ug
KmRldiwKIAkJCQkgICAgICBzdHJ1Y3QgbGlzdF9oZWFkICpoZWFkKQogewpAQCAtMjU0NSw2ICsy
NTczLDcgQEAgc3RhdGljIHZvaWQgYXJtX3NtbXVfZ2V0X3Jlc3ZfcmVnaW9ucyhzdHJ1Y3QgZGV2
aWNlICpkZXYsCiAJbGlzdF9hZGRfdGFpbCgmcmVnaW9uLT5saXN0LCBoZWFkKTsKIAogCWlvbW11
X2RtYV9nZXRfcmVzdl9yZWdpb25zKGRldiwgaGVhZCk7CisJYXJtX3NtbXVfcm1yX2dldF9yZXN2
X3JlZ2lvbnMoZGV2LCBoZWFkKTsKIH0KIAogc3RhdGljIGJvb2wgYXJtX3NtbXVfZGV2X2hhc19m
ZWF0dXJlKHN0cnVjdCBkZXZpY2UgKmRldiwKLS0gCjIuMTcuMQoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
