Return-Path: <SRS0=UfkB=G5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5722C433E6
	for <iommu@archiver.kernel.org>; Tue, 26 Jan 2021 13:07:47 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E6EF23110
	for <iommu@archiver.kernel.org>; Tue, 26 Jan 2021 13:07:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E6EF23110
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id DD8F886D5A;
	Tue, 26 Jan 2021 13:07:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aSzuDIJVrvsx; Tue, 26 Jan 2021 13:07:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8507286C0A;
	Tue, 26 Jan 2021 13:07:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7A107C0FA7;
	Tue, 26 Jan 2021 13:07:45 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A643CC013A
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 13:07:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9452985535
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 13:07:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mNLVVEfjP8II for <iommu@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 13:07:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id A2A5C85507
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 13:07:42 +0000 (UTC)
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DQ6Sb2LQ1zjCX4;
 Tue, 26 Jan 2021 21:06:39 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.47.82.74) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Tue, 26 Jan 2021 21:07:30 +0800
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>
Subject: [PATCH] iommu: Check dev->iommu in iommu_dev_xxx functions
Date: Tue, 26 Jan 2021 13:06:29 +0000
Message-ID: <20210126130629.8928-1-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.47.82.74]
X-CFilter-Loop: Reflected
Cc: jean-philippe@linaro.org, will@kernel.org, linuxarm@openeuler.org,
 prime.zeng@hisilicon.com
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
c2UgZnVuY3Rpb25zwqByZXN1bHRpbmcKYSBjcmFzaCBpbiBpb21tdSB2ZW5kb3IgZHJpdmVyIGNv
ZGUuIEhlbmNlIG1ha2XCoHN1cmUgd2UgY2hlY2sgdGhhdC4KClNpZ25lZC1vZmYtYnk6IFNoYW1l
ZXIgS29sb3RodW0gPHNoYW1lZXJhbGkua29sb3RodW0udGhvZGlAaHVhd2VpLmNvbT4KLS0tCiBk
cml2ZXJzL2lvbW11L2lvbW11LmMgfCA4ICsrKystLS0tCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNl
cnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvaW9t
bXUuYyBiL2RyaXZlcnMvaW9tbXUvaW9tbXUuYwppbmRleCBmZmVlYmRhOGQ2ZGUuLmNiNjgxNTNj
NWNjMCAxMDA2NDQKLS0tIGEvZHJpdmVycy9pb21tdS9pb21tdS5jCisrKyBiL2RyaXZlcnMvaW9t
bXUvaW9tbXUuYwpAQCAtMjg2Nyw3ICsyODY3LDcgQEAgYm9vbCBpb21tdV9kZXZfaGFzX2ZlYXR1
cmUoc3RydWN0IGRldmljZSAqZGV2LCBlbnVtIGlvbW11X2Rldl9mZWF0dXJlcyBmZWF0KQogewog
CWNvbnN0IHN0cnVjdCBpb21tdV9vcHMgKm9wcyA9IGRldi0+YnVzLT5pb21tdV9vcHM7CiAKLQlp
ZiAob3BzICYmIG9wcy0+ZGV2X2hhc19mZWF0KQorCWlmIChkZXYtPmlvbW11ICYmIG9wcyAmJiBv
cHMtPmRldl9oYXNfZmVhdCkKIAkJcmV0dXJuIG9wcy0+ZGV2X2hhc19mZWF0KGRldiwgZmVhdCk7
CiAKIAlyZXR1cm4gZmFsc2U7CkBAIC0yODc4LDcgKzI4NzgsNyBAQCBpbnQgaW9tbXVfZGV2X2Vu
YWJsZV9mZWF0dXJlKHN0cnVjdCBkZXZpY2UgKmRldiwgZW51bSBpb21tdV9kZXZfZmVhdHVyZXMg
ZmVhdCkKIHsKIAljb25zdCBzdHJ1Y3QgaW9tbXVfb3BzICpvcHMgPSBkZXYtPmJ1cy0+aW9tbXVf
b3BzOwogCi0JaWYgKG9wcyAmJiBvcHMtPmRldl9lbmFibGVfZmVhdCkKKwlpZiAoZGV2LT5pb21t
dSAmJiBvcHMgJiYgb3BzLT5kZXZfZW5hYmxlX2ZlYXQpCiAJCXJldHVybiBvcHMtPmRldl9lbmFi
bGVfZmVhdChkZXYsIGZlYXQpOwogCiAJcmV0dXJuIC1FTk9ERVY7CkBAIC0yODk0LDcgKzI4OTQs
NyBAQCBpbnQgaW9tbXVfZGV2X2Rpc2FibGVfZmVhdHVyZShzdHJ1Y3QgZGV2aWNlICpkZXYsIGVu
dW0gaW9tbXVfZGV2X2ZlYXR1cmVzIGZlYXQpCiB7CiAJY29uc3Qgc3RydWN0IGlvbW11X29wcyAq
b3BzID0gZGV2LT5idXMtPmlvbW11X29wczsKIAotCWlmIChvcHMgJiYgb3BzLT5kZXZfZGlzYWJs
ZV9mZWF0KQorCWlmIChkZXYtPmlvbW11ICYmIG9wcyAmJiBvcHMtPmRldl9kaXNhYmxlX2ZlYXQp
CiAJCXJldHVybiBvcHMtPmRldl9kaXNhYmxlX2ZlYXQoZGV2LCBmZWF0KTsKIAogCXJldHVybiAt
RUJVU1k7CkBAIC0yOTA1LDcgKzI5MDUsNyBAQCBib29sIGlvbW11X2Rldl9mZWF0dXJlX2VuYWJs
ZWQoc3RydWN0IGRldmljZSAqZGV2LCBlbnVtIGlvbW11X2Rldl9mZWF0dXJlcyBmZWF0KQogewog
CWNvbnN0IHN0cnVjdCBpb21tdV9vcHMgKm9wcyA9IGRldi0+YnVzLT5pb21tdV9vcHM7CiAKLQlp
ZiAob3BzICYmIG9wcy0+ZGV2X2ZlYXRfZW5hYmxlZCkKKwlpZiAoZGV2LT5pb21tdSAmJiBvcHMg
JiYgb3BzLT5kZXZfZmVhdF9lbmFibGVkKQogCQlyZXR1cm4gb3BzLT5kZXZfZmVhdF9lbmFibGVk
KGRldiwgZmVhdCk7CiAKIAlyZXR1cm4gZmFsc2U7Ci0tIAoyLjE3LjEKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21t
dUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
