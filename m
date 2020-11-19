Return-Path: <SRS0=wYjh=EZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183B4C6369E
	for <iommu@archiver.kernel.org>; Thu, 19 Nov 2020 12:13:22 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9190D246D3
	for <iommu@archiver.kernel.org>; Thu, 19 Nov 2020 12:13:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9190D246D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1BB1885F85;
	Thu, 19 Nov 2020 12:13:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Mq6lot2daUhT; Thu, 19 Nov 2020 12:13:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9021286AE0;
	Thu, 19 Nov 2020 12:13:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 689DDC1825;
	Thu, 19 Nov 2020 12:13:20 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B5DFBC0891
 for <iommu@lists.linux-foundation.org>; Thu, 19 Nov 2020 12:13:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A5B6E86DB7
 for <iommu@lists.linux-foundation.org>; Thu, 19 Nov 2020 12:13:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vc2PKFG-uLkP for <iommu@lists.linux-foundation.org>;
 Thu, 19 Nov 2020 12:13:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 0F7EF86D8B
 for <iommu@lists.linux-foundation.org>; Thu, 19 Nov 2020 12:13:18 +0000 (UTC)
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CcJV528Nrz70BV;
 Thu, 19 Nov 2020 20:13:01 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.210.168.73) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Thu, 19 Nov 2020 20:13:09 +0800
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <linux-arm-kernel@lists.infradead.org>, <linux-acpi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>, <devel@acpica.org>
Subject: [RFC PATCH v2 8/8] =?UTF-8?q?iommu/arm-smmu-v3:=20Reserve=20any?=
 =?UTF-8?q?=20RMR=20regions=20associated=20with=20a=C2=A0dev?=
Date: Thu, 19 Nov 2020 12:11:50 +0000
Message-ID: <20201119121150.3316-9-shameerali.kolothum.thodi@huawei.com>
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

R2V0IFJNUiByZWdpb25zIGFzc29jaWF0ZWQgd2l0aCBhIGRldsKgcmVzZXJ2ZWQgc28gdGhhdCB0
aGVyZSBpcwphIHVuaXR5IG1hcHBpbmcgZm9yIHRoZW0gaW7CoFNNTVUuCgpTaWduZWQtb2ZmLWJ5
OiBTaGFtZWVyIEtvbG90aHVtIDxzaGFtZWVyYWxpLmtvbG90aHVtLnRob2RpQGh1YXdlaS5jb20+
Ci0tLQogZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMuYyB8IDM4ICsr
KysrKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDM4IGluc2VydGlvbnMoKykKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12My5jIGIv
ZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMuYwppbmRleCA5N2RmMWRm
MDAxYzkuLjE3NGE5YmNmZDYyNyAxMDA2NDQKLS0tIGEvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNt
bXUtdjMvYXJtLXNtbXUtdjMuYworKysgYi9kcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9h
cm0tc21tdS12My5jCkBAIC0yNDkyLDYgKzI0OTIsNDMgQEAgc3RhdGljIGludCBhcm1fc21tdV9v
Zl94bGF0ZShzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBvZl9waGFuZGxlX2FyZ3MgKmFyZ3Mp
CiAJcmV0dXJuIGlvbW11X2Z3c3BlY19hZGRfaWRzKGRldiwgYXJncy0+YXJncywgMSk7CiB9CiAK
K3N0YXRpYyBib29sIGFybV9zbW11X2Rldl9oYXNfcm1yKHN0cnVjdCBhcm1fc21tdV9tYXN0ZXIg
Km1hc3RlciwKKwkJCQkgc3RydWN0IGlvbW11X3JtciAqZSkKK3sKKwlpbnQgaSwgajsKKworCWZv
ciAoaSA9IDA7IGkgPCBtYXN0ZXItPm51bV9zaWRzOyBpKyspIHsKKwkJZm9yIChqID0gMDsgaiA8
IGUtPm51bV9pZHM7IGorKykgeworCQkJaWYgKGUtPmlkc1tqXSA9PSBtYXN0ZXItPnNpZHNbaV0p
CisJCQkJcmV0dXJuIHRydWU7CisJCX0KKwl9CisKKwlyZXR1cm4gZmFsc2U7Cit9CisKK3N0YXRp
YyB2b2lkIGFybV9zbW11X3Jtcl9nZXRfcmVzdl9yZWdpb25zKHN0cnVjdCBkZXZpY2UgKmRldiwK
KwkJCQkJICBzdHJ1Y3QgbGlzdF9oZWFkICpoZWFkKQoreworCXN0cnVjdCBhcm1fc21tdV9tYXN0
ZXIgKm1hc3RlciA9IGRldl9pb21tdV9wcml2X2dldChkZXYpOworCXN0cnVjdCBhcm1fc21tdV9k
ZXZpY2UgKnNtbXUgPSBtYXN0ZXItPnNtbXU7CisJc3RydWN0IGlvbW11X3JtciAqcm1yOworCisJ
bGlzdF9mb3JfZWFjaF9lbnRyeShybXIsICZzbW11LT5ybXJfbGlzdCwgbGlzdCkgeworCQlzdHJ1
Y3QgaW9tbXVfcmVzdl9yZWdpb24gKnJlZ2lvbjsKKwkJaW50IHByb3QgPSBJT01NVV9SRUFEIHwg
SU9NTVVfV1JJVEUgfCBJT01NVV9OT0VYRUMgfCBJT01NVV9NTUlPOworCisJCWlmICghYXJtX3Nt
bXVfZGV2X2hhc19ybXIobWFzdGVyLCBybXIpKQorCQkJY29udGludWU7CisJCXJlZ2lvbiA9IGlv
bW11X2FsbG9jX3Jlc3ZfcmVnaW9uKHJtci0+YmFzZV9hZGRyZXNzLAorCQkJCQkJIHJtci0+bGVu
Z3RoLCBwcm90LAorCQkJCQkJIElPTU1VX1JFU1ZfRElSRUNUKTsKKwkJaWYgKCFyZWdpb24pCisJ
CQlyZXR1cm47CisKKwkJbGlzdF9hZGRfdGFpbCgmcmVnaW9uLT5saXN0LCBoZWFkKTsKKwl9Cit9
CiBzdGF0aWMgdm9pZCBhcm1fc21tdV9nZXRfcmVzdl9yZWdpb25zKHN0cnVjdCBkZXZpY2UgKmRl
diwKIAkJCQkgICAgICBzdHJ1Y3QgbGlzdF9oZWFkICpoZWFkKQogewpAQCAtMjUwNiw2ICsyNTQz
LDcgQEAgc3RhdGljIHZvaWQgYXJtX3NtbXVfZ2V0X3Jlc3ZfcmVnaW9ucyhzdHJ1Y3QgZGV2aWNl
ICpkZXYsCiAJbGlzdF9hZGRfdGFpbCgmcmVnaW9uLT5saXN0LCBoZWFkKTsKIAogCWlvbW11X2Rt
YV9nZXRfcmVzdl9yZWdpb25zKGRldiwgaGVhZCk7CisJYXJtX3NtbXVfcm1yX2dldF9yZXN2X3Jl
Z2lvbnMoZGV2LCBoZWFkKTsKIH0KIAogc3RhdGljIGJvb2wgYXJtX3NtbXVfZGV2X2hhc19mZWF0
dXJlKHN0cnVjdCBkZXZpY2UgKmRldiwKLS0gCjIuMTcuMQoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2lvbW11
