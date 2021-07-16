Return-Path: <SRS0=XGcg=MI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F70C12002
	for <iommu@archiver.kernel.org>; Fri, 16 Jul 2021 08:35:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C8C5613C3
	for <iommu@archiver.kernel.org>; Fri, 16 Jul 2021 08:35:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C8C5613C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6087660D5E;
	Fri, 16 Jul 2021 08:35:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 10AGdC21XieO; Fri, 16 Jul 2021 08:35:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 43ABA60C03;
	Fri, 16 Jul 2021 08:35:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18C53C0010;
	Fri, 16 Jul 2021 08:35:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5D983C000E
 for <iommu@lists.linux-foundation.org>; Fri, 16 Jul 2021 08:35:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4D2FD60D5D
 for <iommu@lists.linux-foundation.org>; Fri, 16 Jul 2021 08:35:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iLAppGOAJjKx for <iommu@lists.linux-foundation.org>;
 Fri, 16 Jul 2021 08:35:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AB7DC60C03
 for <iommu@lists.linux-foundation.org>; Fri, 16 Jul 2021 08:35:50 +0000 (UTC)
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GR42N5bQqz6D8WS;
 Fri, 16 Jul 2021 16:21:16 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 16 Jul 2021 10:35:48 +0200
Received: from A2006125610.china.huawei.com (10.47.80.222) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 16 Jul 2021 09:35:41 +0100
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <linux-arm-kernel@lists.infradead.org>, <linux-acpi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
Subject: [PATCH v6 7/9] iommu/arm-smmu-v3: Get associated RMR info and install
 bypass STE
Date: Fri, 16 Jul 2021 09:34:40 +0100
Message-ID: <20210716083442.1708-8-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20210716083442.1708-1-shameerali.kolothum.thodi@huawei.com>
References: <20210716083442.1708-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.47.80.222]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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
L2FybS1zbW11LXYzLmMgfCAzMSArKysrKysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2Vk
LCAzMSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNt
bXUtdjMvYXJtLXNtbXUtdjMuYyBiL2RyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1z
bW11LXYzLmMKaW5kZXggMzRmODQ2NDFkYzZhLi43MWE2ODJmYjM3NWIgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLmMKKysrIGIvZHJpdmVycy9p
b21tdS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMuYwpAQCAtMzc1OSw2ICszNzU5LDM0IEBA
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
CWludCBpcnEsIHJldDsKQEAgLTM4NDAsNiArMzg2OCw5IEBAIHN0YXRpYyBpbnQgYXJtX3NtbXVf
ZGV2aWNlX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCiAJLyogUmVjb3JkIG91
ciBwcml2YXRlIGRldmljZSBzdHJ1Y3R1cmUgKi8KIAlwbGF0Zm9ybV9zZXRfZHJ2ZGF0YShwZGV2
LCBzbW11KTsKIAorCS8qIENoZWNrIGZvciBSTVJzIGFuZCBpbnN0YWxsIGJ5cGFzcyBTVEVzIGlm
IGFueSAqLworCWFybV9zbW11X3Jtcl9pbnN0YWxsX2J5cGFzc19zdGUoc21tdSk7CisKIAkvKiBS
ZXNldCB0aGUgZGV2aWNlICovCiAJcmV0ID0gYXJtX3NtbXVfZGV2aWNlX3Jlc2V0KHNtbXUsIGJ5
cGFzcyk7CiAJaWYgKHJldCkKLS0gCjIuMTcuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2lvbW11
