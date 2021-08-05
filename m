Return-Path: <SRS0=+AsR=M4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_RED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A43C432BE
	for <iommu@archiver.kernel.org>; Thu,  5 Aug 2021 08:09:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FD6E6104F
	for <iommu@archiver.kernel.org>; Thu,  5 Aug 2021 08:09:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3FD6E6104F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 158B7838FE;
	Thu,  5 Aug 2021 08:09:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e9G9K3y9rOhW; Thu,  5 Aug 2021 08:09:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 03284838CC;
	Thu,  5 Aug 2021 08:09:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D5051C001A;
	Thu,  5 Aug 2021 08:09:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9ACDC000E
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 08:09:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CB47B401FF
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 08:09:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fXTj-WuSpP1k for <iommu@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 08:09:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 36B34401E9
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 08:09:42 +0000 (UTC)
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GgLqT3T2rz6F8Fl;
 Thu,  5 Aug 2021 16:09:25 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 5 Aug 2021 10:09:40 +0200
Received: from A2006125610.china.huawei.com (10.47.91.4) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 5 Aug 2021 09:09:33 +0100
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <linux-arm-kernel@lists.infradead.org>, <linux-acpi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
Subject: [PATCH v7 7/9] iommu/arm-smmu-v3: Get associated RMR info and install
 bypass STE
Date: Thu, 5 Aug 2021 09:07:22 +0100
Message-ID: <20210805080724.480-8-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
References: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.47.91.4]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Cc: robin.murphy@arm.com, jon@solid-run.com, linuxarm@huawei.com,
 steven.price@arm.com, guohanjun@huawei.com, yangyicong@huawei.com,
 Sami.Mujawar@arm.com, will@kernel.org, wanghuiqiang@huawei.com
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
L2FybS1zbW11LXYzLmMgfCAzMSArKysrKysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2Vk
LCAzMSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNt
bXUtdjMvYXJtLXNtbXUtdjMuYyBiL2RyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1z
bW11LXYzLmMKaW5kZXggODVmNmYxOTI1YTM2Li4xMTY1NjA1ZDZmN2EgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLmMKKysrIGIvZHJpdmVycy9p
b21tdS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMuYwpAQCAtMzc2MCw2ICszNzYwLDM0IEBA
IHN0YXRpYyB2b2lkIF9faW9tZW0gKmFybV9zbW11X2lvcmVtYXAoc3RydWN0IGRldmljZSAqZGV2
LCByZXNvdXJjZV9zaXplX3Qgc3RhcnQsCiAJcmV0dXJuIGRldm1faW9yZW1hcF9yZXNvdXJjZShk
ZXYsICZyZXMpOwogfQogCitzdGF0aWMgdm9pZCBhcm1fc21tdV9ybXJfaW5zdGFsbF9ieXBhc3Nf
c3RlKHN0cnVjdCBhcm1fc21tdV9kZXZpY2UgKnNtbXUpCit7CisJc3RydWN0IGxpc3RfaGVhZCBy
bXJfbGlzdDsKKwlzdHJ1Y3QgaW9tbXVfcmVzdl9yZWdpb24gKmU7CisJaW50IHJldDsKKworCUlO
SVRfTElTVF9IRUFEKCZybXJfbGlzdCk7CisJaWYgKGlvbW11X2RtYV9nZXRfcm1ycyhkZXZfZndu
b2RlKHNtbXUtPmRldiksICZybXJfbGlzdCkpCisJCXJldHVybjsKKworCWxpc3RfZm9yX2VhY2hf
ZW50cnkoZSwgJnJtcl9saXN0LCBsaXN0KSB7CisJCV9fbGU2NCAqc3RlcDsKKwkJdTMyIHNpZCA9
IGUtPmZ3X2RhdGEucm1yLnNpZDsKKworCQlyZXQgPSBhcm1fc21tdV9pbml0X3NpZF9zdHJ0YWIo
c21tdSwgc2lkKTsKKwkJaWYgKHJldCkgeworCQkJZGV2X2VycihzbW11LT5kZXYsICJSTVIgU0lE
KDB4JXgpIGJ5cGFzcyBmYWlsZWRcbiIsCisJCQkJc2lkKTsKKwkJCWNvbnRpbnVlOworCQl9CisK
KwkJc3RlcCA9IGFybV9zbW11X2dldF9zdGVwX2Zvcl9zaWQoc21tdSwgc2lkKTsKKwkJYXJtX3Nt
bXVfaW5pdF9ieXBhc3Nfc3RlcyhzdGVwLCAxLCB0cnVlKTsKKwl9CisKKwlpb21tdV9kbWFfcHV0
X3JtcnMoZGV2X2Z3bm9kZShzbW11LT5kZXYpLCAmcm1yX2xpc3QpOworfQorCiBzdGF0aWMgaW50
IGFybV9zbW11X2RldmljZV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQogewog
CWludCBpcnEsIHJldDsKQEAgLTM4NDEsNiArMzg2OSw5IEBAIHN0YXRpYyBpbnQgYXJtX3NtbXVf
ZGV2aWNlX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCiAJLyogUmVjb3JkIG91
ciBwcml2YXRlIGRldmljZSBzdHJ1Y3R1cmUgKi8KIAlwbGF0Zm9ybV9zZXRfZHJ2ZGF0YShwZGV2
LCBzbW11KTsKIAorCS8qIENoZWNrIGZvciBSTVJzIGFuZCBpbnN0YWxsIGJ5cGFzcyBTVEVzIGlm
IGFueSAqLworCWFybV9zbW11X3Jtcl9pbnN0YWxsX2J5cGFzc19zdGUoc21tdSk7CisKIAkvKiBS
ZXNldCB0aGUgZGV2aWNlICovCiAJcmV0ID0gYXJtX3NtbXVfZGV2aWNlX3Jlc2V0KHNtbXUsIGJ5
cGFzcyk7CiAJaWYgKHJldCkKLS0gCjIuMTcuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2lvbW11
