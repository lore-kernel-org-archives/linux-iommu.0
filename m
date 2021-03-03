Return-Path: <SRS0=nNEG=IB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D56C433E0
	for <iommu@archiver.kernel.org>; Wed,  3 Mar 2021 17:36:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A61E60202
	for <iommu@archiver.kernel.org>; Wed,  3 Mar 2021 17:36:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A61E60202
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A318F4B158;
	Wed,  3 Mar 2021 17:36:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CCkiRUbO5ZoC; Wed,  3 Mar 2021 17:36:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4EE024AC6E;
	Wed,  3 Mar 2021 17:36:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 26710C000A;
	Wed,  3 Mar 2021 17:36:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14D4AC0001
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 17:36:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EED976F820
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 17:36:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N0YyevT9kEBM for <iommu@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 17:36:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F2A1B605E5
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 17:36:44 +0000 (UTC)
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DrLjx3KNMzjTqL;
 Thu,  4 Mar 2021 01:35:17 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.47.83.26) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Thu, 4 Mar 2021 01:36:29 +0800
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>
Subject: [PATCH v3] iommu: Check dev->iommu in iommu_dev_xxx functions
Date: Wed, 3 Mar 2021 17:36:11 +0000
Message-ID: <20210303173611.520-1-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.47.83.26]
X-CFilter-Loop: Reflected
Cc: jean-philippe@linaro.org, will@kernel.org, linuxarm@openeuler.org,
 prime.zeng@hisilicon.com, robin.murphy@arm.com
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

VGhlIGRldmljZSBpb21tdSBwcm9iZS9hdHRhY2ggbWlnaHQgaGF2ZSBmYWlsZWQgbGVhdmluZyBk
ZXYtPmlvbW11CnRvIE5VTEwgYW5kIGRldmljZSBkcml2ZXJzIG1heSBzdGlsbCBpbnZva2UgdGhl
c2UgZnVuY3Rpb25zIHJlc3VsdGluZwppbiBhIGNyYXNoIGluIGlvbW11IHZlbmRvciBkcml2ZXIg
Y29kZS4KCkhlbmNlIG1ha2Ugc3VyZSB3ZSBjaGVjayB0aGF0LgoKRml4ZXM6wqBhM2ExOTU5Mjlk
NDAgKCJpb21tdTogQWRkIEFQSXMgZm9yIG11bHRpcGxlIGRvbWFpbnMgcGVyIGRldmljZSIpClNp
Z25lZC1vZmYtYnk6IFNoYW1lZXIgS29sb3RodW0gPHNoYW1lZXJhbGkua29sb3RodW0udGhvZGlA
aHVhd2VpLmNvbT4KLS0tCnYyIC0tPiB2MwogLVJlbW92ZWQgaW9tbXVfb3BzIGZyb20gc3RydWN0
IGRldl9pb21tdS4KdjEgLS0+IHYyOgogLUFkZGVkIGlvbW11X29wcyB0byBzdHJ1Y3QgZGV2X2lv
bW11IGJhc2VkIG9uIHRoZSBkaXNjdXNzaW9uIHdpdGggUm9iaW4uCiAtUmViYXNlZCBhZ2FpbnN0
IGlvbW11LXRyZWUgY29yZSBicmFuY2guCi0tLQogZHJpdmVycy9pb21tdS9pb21tdS5jIHwgMjQg
KysrKysrKysrKysrKysrLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygr
KSwgOSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2lvbW11LmMgYi9k
cml2ZXJzL2lvbW11L2lvbW11LmMKaW5kZXggZDBiMGExNWRiYTg0Li5lMTBjZmE5OTA1N2MgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvaW9tbXUvaW9tbXUuYworKysgYi9kcml2ZXJzL2lvbW11L2lvbW11
LmMKQEAgLTI4NzgsMTAgKzI4NzgsMTIgQEAgRVhQT1JUX1NZTUJPTF9HUEwoaW9tbXVfZndzcGVj
X2FkZF9pZHMpOwogICovCiBpbnQgaW9tbXVfZGV2X2VuYWJsZV9mZWF0dXJlKHN0cnVjdCBkZXZp
Y2UgKmRldiwgZW51bSBpb21tdV9kZXZfZmVhdHVyZXMgZmVhdCkKIHsKLQljb25zdCBzdHJ1Y3Qg
aW9tbXVfb3BzICpvcHMgPSBkZXYtPmJ1cy0+aW9tbXVfb3BzOworCWlmIChkZXYtPmlvbW11ICYm
IGRldi0+aW9tbXUtPmlvbW11X2RldikgeworCQljb25zdCBzdHJ1Y3QgaW9tbXVfb3BzICpvcHMg
PSBkZXYtPmlvbW11LT5pb21tdV9kZXYtPm9wczsKIAotCWlmIChvcHMgJiYgb3BzLT5kZXZfZW5h
YmxlX2ZlYXQpCi0JCXJldHVybiBvcHMtPmRldl9lbmFibGVfZmVhdChkZXYsIGZlYXQpOworCQlp
ZiAob3BzLT5kZXZfZW5hYmxlX2ZlYXQpCisJCQlyZXR1cm4gb3BzLT5kZXZfZW5hYmxlX2ZlYXQo
ZGV2LCBmZWF0KTsKKwl9CiAKIAlyZXR1cm4gLUVOT0RFVjsKIH0KQEAgLTI4OTQsMTAgKzI4OTYs
MTIgQEAgRVhQT1JUX1NZTUJPTF9HUEwoaW9tbXVfZGV2X2VuYWJsZV9mZWF0dXJlKTsKICAqLwog
aW50IGlvbW11X2Rldl9kaXNhYmxlX2ZlYXR1cmUoc3RydWN0IGRldmljZSAqZGV2LCBlbnVtIGlv
bW11X2Rldl9mZWF0dXJlcyBmZWF0KQogewotCWNvbnN0IHN0cnVjdCBpb21tdV9vcHMgKm9wcyA9
IGRldi0+YnVzLT5pb21tdV9vcHM7CisJaWYgKGRldi0+aW9tbXUgJiYgZGV2LT5pb21tdS0+aW9t
bXVfZGV2KSB7CisJCWNvbnN0IHN0cnVjdCBpb21tdV9vcHMgKm9wcyA9IGRldi0+aW9tbXUtPmlv
bW11X2Rldi0+b3BzOwogCi0JaWYgKG9wcyAmJiBvcHMtPmRldl9kaXNhYmxlX2ZlYXQpCi0JCXJl
dHVybiBvcHMtPmRldl9kaXNhYmxlX2ZlYXQoZGV2LCBmZWF0KTsKKwkJaWYgKG9wcy0+ZGV2X2Rp
c2FibGVfZmVhdCkKKwkJCXJldHVybiBvcHMtPmRldl9kaXNhYmxlX2ZlYXQoZGV2LCBmZWF0KTsK
Kwl9CiAKIAlyZXR1cm4gLUVCVVNZOwogfQpAQCAtMjkwNSwxMCArMjkwOSwxMiBAQCBFWFBPUlRf
U1lNQk9MX0dQTChpb21tdV9kZXZfZGlzYWJsZV9mZWF0dXJlKTsKIAogYm9vbCBpb21tdV9kZXZf
ZmVhdHVyZV9lbmFibGVkKHN0cnVjdCBkZXZpY2UgKmRldiwgZW51bSBpb21tdV9kZXZfZmVhdHVy
ZXMgZmVhdCkKIHsKLQljb25zdCBzdHJ1Y3QgaW9tbXVfb3BzICpvcHMgPSBkZXYtPmJ1cy0+aW9t
bXVfb3BzOworCWlmIChkZXYtPmlvbW11ICYmIGRldi0+aW9tbXUtPmlvbW11X2RldikgeworCQlj
b25zdCBzdHJ1Y3QgaW9tbXVfb3BzICpvcHMgPSBkZXYtPmlvbW11LT5pb21tdV9kZXYtPm9wczsK
IAotCWlmIChvcHMgJiYgb3BzLT5kZXZfZmVhdF9lbmFibGVkKQotCQlyZXR1cm4gb3BzLT5kZXZf
ZmVhdF9lbmFibGVkKGRldiwgZmVhdCk7CisJCWlmIChvcHMtPmRldl9mZWF0X2VuYWJsZWQpCisJ
CQlyZXR1cm4gb3BzLT5kZXZfZmVhdF9lbmFibGVkKGRldiwgZmVhdCk7CisJfQogCiAJcmV0dXJu
IGZhbHNlOwogfQotLSAKMi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vaW9tbXU=
