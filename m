Return-Path: <SRS0=YXze=KI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B018C433B4
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 13:47:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21E0F613C7
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 13:47:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21E0F613C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E1B5A84407;
	Thu, 13 May 2021 13:47:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sYIJ_W9ADJqb; Thu, 13 May 2021 13:47:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id E0B3884530;
	Thu, 13 May 2021 13:47:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CD436C000E;
	Thu, 13 May 2021 13:47:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74341C0001
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 13:47:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 66E1084505
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 13:47:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W1mw1BSYlcA4 for <iommu@lists.linux-foundation.org>;
 Thu, 13 May 2021 13:47:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C16A384535
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 13:47:06 +0000 (UTC)
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FgtDk5dkhzBvBf;
 Thu, 13 May 2021 21:44:22 +0800 (CST)
Received: from A2006125610.china.huawei.com (10.47.81.63) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Thu, 13 May 2021 21:46:54 +0800
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <linux-arm-kernel@lists.infradead.org>, <linux-acpi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
Subject: [PATCH v4 6/8] iommu/arm-smmu-v3: Get associated RMR info and install
 bypass STE
Date: Thu, 13 May 2021 14:45:48 +0100
Message-ID: <20210513134550.2117-7-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20210513134550.2117-1-shameerali.kolothum.thodi@huawei.com>
References: <20210513134550.2117-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.47.81.63]
X-CFilter-Loop: Reflected
Cc: jon@solid-run.com, linuxarm@huawei.com, steven.price@arm.com,
 guohanjun@huawei.com, yangyicong@huawei.com, Sami.Mujawar@arm.com,
 robin.murphy@arm.com, wanghuiqiang@huawei.com
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
L2FybS1zbW11LXYzLmMgfCAzMyArKysrKysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2Vk
LCAzMyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNt
bXUtdjMvYXJtLXNtbXUtdjMuYyBiL2RyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1z
bW11LXYzLmMKaW5kZXggZjkxOTViNzQwZjQ4Li5jMmQyZTY1Yjk4NTYgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLmMKKysrIGIvZHJpdmVycy9p
b21tdS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMuYwpAQCAtMzU3NCw2ICszNTc0LDM2IEBA
IHN0YXRpYyB2b2lkIF9faW9tZW0gKmFybV9zbW11X2lvcmVtYXAoc3RydWN0IGRldmljZSAqZGV2
LCByZXNvdXJjZV9zaXplX3Qgc3RhcnQsCiAJcmV0dXJuIGRldm1faW9yZW1hcF9yZXNvdXJjZShk
ZXYsICZyZXMpOwogfQogCitzdGF0aWMgdm9pZCBhcm1fc21tdV9ybXJfaW5zdGFsbF9ieXBhc3Nf
c3RlKHN0cnVjdCBhcm1fc21tdV9kZXZpY2UgKnNtbXUpCit7CisJc3RydWN0IGxpc3RfaGVhZCBy
bXJfbGlzdDsKKwlzdHJ1Y3QgaW9tbXVfcm1yICplOworCWludCByZXQ7CisKKwlJTklUX0xJU1Rf
SEVBRCgmcm1yX2xpc3QpOworCWlmIChpb21tdV9kbWFfZ2V0X3JtcnMoZGV2X2Z3bm9kZShzbW11
LT5kZXYpLCAmcm1yX2xpc3QpKQorCQlyZXR1cm47CisKKwkvKgorCSAqIFNpbmNlLCB3ZSBkb24n
dCBoYXZlIGEgbWVjaGFuaXNtIHRvIGRpZmZlcmVudGlhdGUgdGhlIFJNUgorCSAqIFNJRHMgdGhh
dCBoYXMgYW4gb25nb2luZyBsaXZlIHN0cmVhbSwgaW5zdGFsbCBieXBhc3MgU1RFcworCSAqIGZv
ciBhbGwgdGhlIHJlcG9ydGVkIG9uZXMuwqAKKwkgKi8KKwlsaXN0X2Zvcl9lYWNoX2VudHJ5KGUs
ICZybXJfbGlzdCwgbGlzdCkgeworCQlfX2xlNjQgKnN0ZXA7CisKKwkJcmV0ID0gYXJtX3NtbXVf
aW5pdF9zaWRfc3RydGFiKHNtbXUsIGUtPnNpZCk7CisJCWlmIChyZXQpIHsKKwkJCWRldl9lcnIo
c21tdS0+ZGV2LCAiUk1SIGJ5cGFzcygweCV4KSBmYWlsZWRcbiIsCisJCQkJZS0+c2lkKTsKKwkJ
CWNvbnRpbnVlOworCQl9CisKKwkJc3RlcCA9IGFybV9zbW11X2dldF9zdGVwX2Zvcl9zaWQoc21t
dSwgZS0+c2lkKTsKKwkJYXJtX3NtbXVfd3JpdGVfc3RydGFiX2VudChOVUxMLCBlLT5zaWQsIHN0
ZXAsIHRydWUpOworCX0KK30KKwogc3RhdGljIGludCBhcm1fc21tdV9kZXZpY2VfcHJvYmUoc3Ry
dWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKIHsKIAlpbnQgaXJxLCByZXQ7CkBAIC0zNjU3LDYg
KzM2ODcsOSBAQCBzdGF0aWMgaW50IGFybV9zbW11X2RldmljZV9wcm9iZShzdHJ1Y3QgcGxhdGZv
cm1fZGV2aWNlICpwZGV2KQogCS8qIFJlY29yZCBvdXIgcHJpdmF0ZSBkZXZpY2Ugc3RydWN0dXJl
ICovCiAJcGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgc21tdSk7CiAKKwkvKiBDaGVjayBmb3Ig
Uk1ScyBhbmQgaW5zdGFsbCBieXBhc3MgU1RFcyBpZiBhbnkgKi8KKwlhcm1fc21tdV9ybXJfaW5z
dGFsbF9ieXBhc3Nfc3RlKHNtbXUpOworCiAJLyogUmVzZXQgdGhlIGRldmljZSAqLwogCXJldCA9
IGFybV9zbW11X2RldmljZV9yZXNldChzbW11LCBieXBhc3MpOwogCWlmIChyZXQpCi0tIAoyLjE3
LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11
IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
