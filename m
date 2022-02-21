Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D93C4321E
	for <iommu@archiver.kernel.org>; Mon, 21 Feb 2022 15:44:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E51F4401BB;
	Mon, 21 Feb 2022 15:44:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vRaJYl4gs52Y; Mon, 21 Feb 2022 15:44:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DD23340100;
	Mon, 21 Feb 2022 15:44:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C20F5C001A;
	Mon, 21 Feb 2022 15:44:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D34BEC0011
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 15:44:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B27BB401BB
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 15:44:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0vYOpDVdY18Y for <iommu@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 15:44:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D724A40100
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 15:44:45 +0000 (UTC)
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K2RM41mmqz6GD3m;
 Mon, 21 Feb 2022 23:40:00 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 21 Feb 2022 16:44:42 +0100
Received: from A2006125610.china.huawei.com (10.47.91.169) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 21 Feb 2022 15:44:33 +0000
To: <linux-arm-kernel@lists.infradead.org>, <linux-acpi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
Subject: [PATCH v8 01/11] ACPI/IORT: Add temporary RMR node flag definitions
Date: Mon, 21 Feb 2022 15:43:34 +0000
Message-ID: <20220221154344.2126-2-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20220221154344.2126-1-shameerali.kolothum.thodi@huawei.com>
References: <20220221154344.2126-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.47.91.169]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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
From: Shameer Kolothum via iommu <iommu@lists.linux-foundation.org>
Reply-To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

SU9SVCByZXYgRS5kIGludHJvZHVjZXMgbW9yZSBkZXRhaWxzIGludG8gdGhlIFJNUiBub2RlIEZs
YWdzCmZpZWxkLiBBZGQgdGVtcG9yYXJ5IGRlZmluaXRpb25zIHRvIGRlc2NyaWJlIGFuZCBhY2Nl
c3MgdGhlc2UKRmxhZ3MgZmllbGQgdW50aWwgQUNQSUNBIGhlYWRlciBpcyB1cGRhdGVkIHRvIHN1
cHBvcnQgRS5kLgoKVGhpcyBwYXRjaCBjYW4gYmUgcmV2ZXJ0ZWTCoG9uY2UgdGhlIGluY2x1ZGUv
YWNwaS9hY3RibDIuaCBoYXMKYWxsIHRoZSByZWxldmFudMKgZGVmaW5pdGlvbnMuCgpTaWduZWQt
b2ZmLWJ5OiBTaGFtZWVyIEtvbG90aHVtIDxzaGFtZWVyYWxpLmtvbG90aHVtLnRob2RpQGh1YXdl
aS5jb20+Ci0tLQpQbGVhc2UgZmluZCB0aGUgQUNQSUNBIEUuZCByZWxhdGVkIGNoYW5nZXMgcHVs
bCByZXF1ZXN0IGhlcmUsCmh0dHBzOi8vZ2l0aHViLmNvbS9hY3BpY2EvYWNwaWNhL3B1bGwvNzUy
CgotLS0KIGRyaXZlcnMvYWNwaS9hcm02NC9pb3J0LmMgfCAyNCArKysrKysrKysrKysrKysrKysr
KysrKysKIDEgZmlsZSBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9hY3BpL2FybTY0L2lvcnQuYyBiL2RyaXZlcnMvYWNwaS9hcm02NC9pb3J0LmMKaW5kZXgg
ZjJmOGYwNTY2MmRlLi4wNzMwYzRkYmI3MDAgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvYWNwaS9hcm02
NC9pb3J0LmMKKysrIGIvZHJpdmVycy9hY3BpL2FybTY0L2lvcnQuYwpAQCAtMjUsNiArMjUsMzAg
QEAKICNkZWZpbmUgSU9SVF9JT01NVV9UWVBFCQkoKDEgPDwgQUNQSV9JT1JUX05PREVfU01NVSkg
fAlcCiAJCQkJKDEgPDwgQUNQSV9JT1JUX05PREVfU01NVV9WMykpCiAKKy8qCisgKiBUaGUgZm9s
bG93aW5nIFJNUiByZWxhdGVkIGRlZmluaXRpb25zIGFyZSB0ZW1wb3JhcnkgYW5kCisgKiBjYW4g
YmUgcmVtb3ZlZCBvbmNlIEFDUElDQSBoZWFkZXJzIHN1cHBvcnQgSU9SVCByZXYgRS5kCisgKi8K
KyNpZm5kZWYgQUNQSV9JT1JUX1JNUl9SRU1BUF9QRVJNSVRURUQKKyNkZWZpbmUgQUNQSV9JT1JU
X1JNUl9SRU1BUF9QRVJNSVRURUQJKDEpCisjZW5kaWYKKworI2lmbmRlZiBBQ1BJX0lPUlRfUk1S
X0FDQ0VTU19QUklWSUxFR0UKKyNkZWZpbmUgQUNQSV9JT1JUX1JNUl9BQ0NFU1NfUFJJVklMRUdF
CSgxIDw8IDEpCisjZW5kaWYKKworI2lmbmRlZiBBQ1BJX0lPUlRfUk1SX0FDQ0VTU19BVFRSSUJV
VEVTCisjZGVmaW5lIEFDUElfSU9SVF9STVJfQUNDRVNTX0FUVFJJQlVURVMoZmxhZ3MpCSgoKGZs
YWdzKSA+PiAyKSAmIDB4RkYpCisjZW5kaWYKKworI2lmbmRlZiBBQ1BJX0lPUlRfUk1SX0FUVFJf
REVWSUNFX0dSRQorI2RlZmluZSBBQ1BJX0lPUlRfUk1SX0FUVFJfREVWSUNFX0dSRQkweDAzCisj
ZW5kaWYKKworI2lmbmRlZiBBQ1BJX0lPUlRfUk1SX0FUVFJfTk9STUFMCisjZGVmaW5lIEFDUElf
SU9SVF9STVJfQVRUUl9OT1JNQUwJMHgwNQorI2VuZGlmCisKIHN0cnVjdCBpb3J0X2l0c19tc2lf
Y2hpcCB7CiAJc3RydWN0IGxpc3RfaGVhZAlsaXN0OwogCXN0cnVjdCBmd25vZGVfaGFuZGxlCSpm
d19ub2RlOwotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
aW9tbXU=
