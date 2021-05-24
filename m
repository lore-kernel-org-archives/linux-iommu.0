Return-Path: <SRS0=7UOM=KT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C848C04FF3
	for <iommu@archiver.kernel.org>; Mon, 24 May 2021 11:04:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57906610FA
	for <iommu@archiver.kernel.org>; Mon, 24 May 2021 11:04:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57906610FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3654C8348C;
	Mon, 24 May 2021 11:04:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DK0o0vqN0d8Q; Mon, 24 May 2021 11:04:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3712A834DE;
	Mon, 24 May 2021 11:04:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1B8FEC000E;
	Mon, 24 May 2021 11:04:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CBED8C0001
 for <iommu@lists.linux-foundation.org>; Mon, 24 May 2021 11:04:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AE7E8834D5
 for <iommu@lists.linux-foundation.org>; Mon, 24 May 2021 11:04:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8CGoB_ksVhCm for <iommu@lists.linux-foundation.org>;
 Mon, 24 May 2021 11:04:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EEBAA834DE
 for <iommu@lists.linux-foundation.org>; Mon, 24 May 2021 11:04:11 +0000 (UTC)
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.58])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FpZ4f2rBbzmknN;
 Mon, 24 May 2021 19:00:34 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 19:04:08 +0800
Received: from A2006125610.china.huawei.com (10.47.80.77) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 12:03:59 +0100
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <linux-arm-kernel@lists.infradead.org>, <linux-acpi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
Subject: [PATCH v5 6/8] iommu/arm-smmu-v3: Get associated RMR info and install
Date: Mon, 24 May 2021 12:02:20 +0100
Message-ID: <20210524110222.2212-7-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20210524110222.2212-1-shameerali.kolothum.thodi@huawei.com>
References: <20210524110222.2212-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.47.80.77]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
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
L2FybS1zbW11LXYzLmMgfCAzNiArKysrKysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2Vk
LCAzNiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNt
bXUtdjMvYXJtLXNtbXUtdjMuYyBiL2RyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1z
bW11LXYzLmMKaW5kZXggZjkxOTViNzQwZjQ4Li5iZTE1NjNlMDY3MzIgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLmMKKysrIGIvZHJpdmVycy9p
b21tdS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMuYwpAQCAtMzU3NCw2ICszNTc0LDM5IEBA
IHN0YXRpYyB2b2lkIF9faW9tZW0gKmFybV9zbW11X2lvcmVtYXAoc3RydWN0IGRldmljZSAqZGV2
LCByZXNvdXJjZV9zaXplX3Qgc3RhcnQsCiAJcmV0dXJuIGRldm1faW9yZW1hcF9yZXNvdXJjZShk
ZXYsICZyZXMpOwogfQogCitzdGF0aWMgdm9pZCBhcm1fc21tdV9ybXJfaW5zdGFsbF9ieXBhc3Nf
c3RlKHN0cnVjdCBhcm1fc21tdV9kZXZpY2UgKnNtbXUpCit7CisJc3RydWN0IGxpc3RfaGVhZCBy
bXJfbGlzdDsKKwlzdHJ1Y3QgaW9tbXVfcmVzdl9yZWdpb24gKmU7CisJaW50IHJldDsKKworCUlO
SVRfTElTVF9IRUFEKCZybXJfbGlzdCk7CisJaWYgKGlvbW11X2RtYV9nZXRfcm1ycyhkZXZfZndu
b2RlKHNtbXUtPmRldiksICZybXJfbGlzdCkpCisJCXJldHVybjsKKworCS8qCisJICogU2luY2Us
IHdlIGRvbid0IGhhdmUgYSBtZWNoYW5pc20gdG8gZGlmZmVyZW50aWF0ZSB0aGUgUk1SCisJICog
U0lEcyB0aGF0IGhhcyBhbiBvbmdvaW5nIGxpdmUgc3RyZWFtLCBpbnN0YWxsIGJ5cGFzcyBTVEVz
CisJICogZm9yIGFsbCB0aGUgcmVwb3J0ZWQgb25lcy7CoAorCSAqLworCWxpc3RfZm9yX2VhY2hf
ZW50cnkoZSwgJnJtcl9saXN0LCBsaXN0KSB7CisJCV9fbGU2NCAqc3RlcDsKKwkJdTMyIHNpZCA9
IGUtPmZ3X2RhdGEucm1yLnNpZDsKKworCQlyZXQgPSBhcm1fc21tdV9pbml0X3NpZF9zdHJ0YWIo
c21tdSwgc2lkKTsKKwkJaWYgKHJldCkgeworCQkJZGV2X2VycihzbW11LT5kZXYsICJSTVIgYnlw
YXNzKDB4JXgpIGZhaWxlZFxuIiwKKwkJCQlzaWQpOworCQkJY29udGludWU7CisJCX0KKworCQlz
dGVwID0gYXJtX3NtbXVfZ2V0X3N0ZXBfZm9yX3NpZChzbW11LCBzaWQpOworCQlhcm1fc21tdV93
cml0ZV9zdHJ0YWJfZW50KE5VTEwsIHNpZCwgc3RlcCwgdHJ1ZSk7CisJfQorCisJaW9tbXVfZG1h
X3B1dF9ybXJzKGRldl9md25vZGUoc21tdS0+ZGV2KSwgJnJtcl9saXN0KTsKK30KKwogc3RhdGlj
IGludCBhcm1fc21tdV9kZXZpY2VfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikK
IHsKIAlpbnQgaXJxLCByZXQ7CkBAIC0zNjU3LDYgKzM2OTAsOSBAQCBzdGF0aWMgaW50IGFybV9z
bW11X2RldmljZV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQogCS8qIFJlY29y
ZCBvdXIgcHJpdmF0ZSBkZXZpY2Ugc3RydWN0dXJlICovCiAJcGxhdGZvcm1fc2V0X2RydmRhdGEo
cGRldiwgc21tdSk7CiAKKwkvKiBDaGVjayBmb3IgUk1ScyBhbmQgaW5zdGFsbCBieXBhc3MgU1RF
cyBpZiBhbnkgKi8KKwlhcm1fc21tdV9ybXJfaW5zdGFsbF9ieXBhc3Nfc3RlKHNtbXUpOworCiAJ
LyogUmVzZXQgdGhlIGRldmljZSAqLwogCXJldCA9IGFybV9zbW11X2RldmljZV9yZXNldChzbW11
LCBieXBhc3MpOwogCWlmIChyZXQpCi0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby9pb21tdQ==
