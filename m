Return-Path: <SRS0=gpU2=JR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CF5C43460
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 09:29:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE56D61073
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 09:29:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE56D61073
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5B53D6080D;
	Tue, 20 Apr 2021 09:29:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6iALNzt8P5J0; Tue, 20 Apr 2021 09:29:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4F1456080A;
	Tue, 20 Apr 2021 09:29:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C5A6C001E;
	Tue, 20 Apr 2021 09:29:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 12E55C000B
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 09:29:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 003C140215
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 09:29:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MRaufu9zJdig for <iommu@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 09:28:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DE8EF4021E
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 09:28:58 +0000 (UTC)
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FPdbv2TP3z19M25;
 Tue, 20 Apr 2021 17:26:35 +0800 (CST)
Received: from A2006125610.china.huawei.com (10.47.83.26) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Tue, 20 Apr 2021 17:28:45 +0800
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <linux-arm-kernel@lists.infradead.org>, <linux-acpi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
Subject: [PATCH v3 07/10] iommu/arm-smmu-v3: Get associated RMR info and
 install bypass STE
Date: Tue, 20 Apr 2021 10:27:48 +0200
Message-ID: <20210420082751.1829-8-shameerali.kolothum.thodi@huawei.com>
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

Q2hlY2sgaWYgdGhlcmUgaXMgYW55IFJNUiBpbmZvIGFzc29jaWF0ZWTCoHdpdGggdGhlIGRldmlj
ZXMgYmVoaW5kCnRoZSBTTU1VdjMgYW5kIGlmIGFueSwgaW5zdGFsbCBieXBhc3MgU1RFcyBmb3Ig
dGhlbS4gVGhpcyBpcyB0bwprZWVwIGFueSBvbmdvaW5nIHRyYWZmaWMgYXNzb2NpYXRlZCB3aXRo
IHRoZXNlIGRldmljZXMgYWxpdmUKd2hlbiB3ZSBlbmFibGUvcmVzZXQgU01NVXYzIGR1cmluZyBw
cm9iZSgpLgoKU2lnbmVkLW9mZi1ieTogU2hhbWVlciBLb2xvdGh1bSA8c2hhbWVlcmFsaS5rb2xv
dGh1bS50aG9kaUBodWF3ZWkuY29tPgotLS0KIGRyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYz
L2FybS1zbW11LXYzLmMgfCAzNSArKysrKysrKysrKysrKysrKysrKysKIGRyaXZlcnMvaW9tbXUv
YXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLmggfCAgMiArKwogMiBmaWxlcyBjaGFuZ2VkLCAz
NyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUt
djMvYXJtLXNtbXUtdjMuYyBiL2RyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11
LXYzLmMKaW5kZXggMTkwMjg1ODEyMTgyLi4xNGU5YzcwMzRjMDQgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLmMKKysrIGIvZHJpdmVycy9pb21t
dS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMuYwpAQCAtMzUzMCw2ICszNTMwLDM3IEBAIHN0
YXRpYyB2b2lkIF9faW9tZW0gKmFybV9zbW11X2lvcmVtYXAoc3RydWN0IGRldmljZSAqZGV2LCBy
ZXNvdXJjZV9zaXplX3Qgc3RhcnQsCiAJcmV0dXJuIGRldm1faW9yZW1hcF9yZXNvdXJjZShkZXYs
ICZyZXMpOwogfQogCitzdGF0aWMgdm9pZCBhcm1fc21tdV9ybXJfaW5zdGFsbF9ieXBhc3Nfc3Rl
KHN0cnVjdCBhcm1fc21tdV9kZXZpY2UgKnNtbXUpCit7CisJc3RydWN0IGlvbW11X3JtciAqZTsK
KwlpbnQgcmV0OworCisJLyoKKwkgKiBTaW5jZSwgd2UgZG9uJ3QgaGF2ZSBhIG1lY2hhbmlzbSB0
byBkaWZmZXJlbnRpYXRlIHRoZSBSTVIKKwkgKiBTSURzIHRoYXQgaGFzIGFuIG9uZ29pbmcgbGl2
ZSBzdHJlYW0sIGluc3RhbGwgYnlwYXNzIFNURXMKKwkgKiBmb3IgYWxsIHRoZSByZXBvcnRlZCBv
bmVzLsKgCisJICovCisJbGlzdF9mb3JfZWFjaF9lbnRyeShlLCAmc21tdS0+cm1yX2xpc3QsIGxp
c3QpIHsKKwkJX19sZTY0ICpzdGVwOworCisJCXJldCA9IGFybV9zbW11X2luaXRfc2lkX3N0cnRh
YihzbW11LCBlLT5zaWQpOworCQlpZiAocmV0KSB7CisJCQlkZXZfZXJyKHNtbXUtPmRldiwgIlJN
UiBieXBhc3MoMHgleCkgZmFpbGVkXG4iLAorCQkJCWUtPnNpZCk7CisJCQljb250aW51ZTsKKwkJ
fQorCisJCXN0ZXAgPSBhcm1fc21tdV9nZXRfc3RlcF9mb3Jfc2lkKHNtbXUsIGUtPnNpZCk7CisJ
CWFybV9zbW11X3dyaXRlX3N0cnRhYl9lbnQoTlVMTCwgZS0+c2lkLCBzdGVwLCB0cnVlKTsKKwl9
Cit9CisKK3N0YXRpYyBpbnQgYXJtX3NtbXVfZ2V0X3JtcihzdHJ1Y3QgYXJtX3NtbXVfZGV2aWNl
ICpzbW11KQoreworCUlOSVRfTElTVF9IRUFEKCZzbW11LT5ybXJfbGlzdCk7CisJcmV0dXJuIGlv
bW11X2RtYV9nZXRfcm1ycyhkZXZfZndub2RlKHNtbXUtPmRldiksICZzbW11LT5ybXJfbGlzdCk7
Cit9CisKIHN0YXRpYyBpbnQgYXJtX3NtbXVfZGV2aWNlX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UgKnBkZXYpCiB7CiAJaW50IGlycSwgcmV0OwpAQCAtMzYxMyw2ICszNjQ0LDEwIEBAIHN0
YXRpYyBpbnQgYXJtX3NtbXVfZGV2aWNlX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBk
ZXYpCiAJLyogUmVjb3JkIG91ciBwcml2YXRlIGRldmljZSBzdHJ1Y3R1cmUgKi8KIAlwbGF0Zm9y
bV9zZXRfZHJ2ZGF0YShwZGV2LCBzbW11KTsKIAorCS8qIENoZWNrIGZvciBSTVJzIGFuZCBpbnN0
YWxsIGJ5cGFzcyBTVEVzIGlmIGFueSAqLworCWlmICghYXJtX3NtbXVfZ2V0X3JtcihzbW11KSkK
KwkJYXJtX3NtbXVfcm1yX2luc3RhbGxfYnlwYXNzX3N0ZShzbW11KTsKKwogCS8qIFJlc2V0IHRo
ZSBkZXZpY2UgKi8KIAlyZXQgPSBhcm1fc21tdV9kZXZpY2VfcmVzZXQoc21tdSwgYnlwYXNzKTsK
IAlpZiAocmV0KQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUtdjMvYXJt
LXNtbXUtdjMuaCBiL2RyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLmgK
aW5kZXggZjk4NTgxN2M5NjdhLi5lMjEwZmE4MTUzOGEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvaW9t
bXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLmgKKysrIGIvZHJpdmVycy9pb21tdS9hcm0v
YXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMuaApAQCAtNjM5LDYgKzYzOSw4IEBAIHN0cnVjdCBhcm1f
c21tdV9kZXZpY2UgewogCiAJLyogSU9NTVUgY29yZSBjb2RlIGhhbmRsZSAqLwogCXN0cnVjdCBp
b21tdV9kZXZpY2UJCWlvbW11OworCisJc3RydWN0IGxpc3RfaGVhZAkJcm1yX2xpc3Q7CiB9Owog
CiAvKiBTTU1VIHByaXZhdGUgZGF0YSBmb3IgZWFjaCBtYXN0ZXIgKi8KLS0gCjIuMTcuMQoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGlu
ZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
