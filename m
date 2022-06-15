Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA12DC43334
	for <iommu@archiver.kernel.org>; Wed, 15 Jun 2022 10:12:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5BA28419BE;
	Wed, 15 Jun 2022 10:12:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bkI-r6owjC_E; Wed, 15 Jun 2022 10:12:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1A85D41976;
	Wed, 15 Jun 2022 10:12:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DD4B7C007A;
	Wed, 15 Jun 2022 10:12:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0FA5BC002D
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 10:12:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 63AF840BC9
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 10:12:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e-JNelQYrkbz for <iommu@lists.linux-foundation.org>;
 Wed, 15 Jun 2022 10:12:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 76DBF40B9E
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 10:12:00 +0000 (UTC)
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LNLf60hpqz67bmq;
 Wed, 15 Jun 2022 18:10:22 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 15 Jun 2022 12:11:58 +0200
Received: from A2006125610.china.huawei.com (10.202.227.178) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 15 Jun 2022 11:11:51 +0100
To: <linux-arm-kernel@lists.infradead.org>, <linux-acpi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
Subject: [PATCH v13 3/9] ACPI/IORT: Provide a generic helper to retrieve
 reserve regions
Date: Wed, 15 Jun 2022 11:10:38 +0100
Message-ID: <20220615101044.1972-4-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20220615101044.1972-1-shameerali.kolothum.thodi@huawei.com>
References: <20220615101044.1972-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.202.227.178]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Cc: robin.murphy@arm.com, jon@solid-run.com, linuxarm@huawei.com,
 steven.price@arm.com, hch@infradead.org, guohanjun@huawei.com,
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

Q3VycmVudGx5IElPUlQgcHJvdmlkZXMgYSBoZWxwZXIgdG8gcmV0cmlldmUgSFcgTVNJIHJlc2Vy
dmUgcmVnaW9ucy4KQ2hhbmdlIHRoaXMgdG8gYSBnZW5lcmljIGhlbHBlciB0byByZXRyaWV2ZcKg
YW55IElPUlQgcmVsYXRlZCByZXNlcnZlCnJlZ2lvbnMuIFRoaXMgd2lsbCBiZSB1c2VmdWwgd2hl
biB3ZcKgYWRkIHN1cHBvcnQgZm9yIFJNUiBub2RlcyBpbgpzdWJzZXF1ZW50IHBhdGNoZXMuCgpb
TG9yZW56bzogRm9yIEFDUEkgSU9SVF0KUmV2aWV3ZWQtYnk6IExvcmVuem8gUGllcmFsaXNpIDxs
b3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tPgpSZXZpZXdlZC1ieTogQ2hyaXN0b3BoIEhlbGx3aWcg
PGhjaEBsc3QuZGU+ClRlc3RlZC1ieTogU3RldmVuIFByaWNlIDxzdGV2ZW4ucHJpY2VAYXJtLmNv
bT4KVGVzdGVkLWJ5OiBMYXVyZW50aXUgVHVkb3IgPGxhdXJlbnRpdS50dWRvckBueHAuY29tPgpU
ZXN0ZWQtYnk6IEhhbmp1biBHdW8gPGd1b2hhbmp1bkBodWF3ZWkuY29tPgpSZXZpZXdlZC1ieTog
SGFuanVuIEd1byA8Z3VvaGFuanVuQGh1YXdlaS5jb20+ClNpZ25lZC1vZmYtYnk6IFNoYW1lZXIg
S29sb3RodW0gPHNoYW1lZXJhbGkua29sb3RodW0udGhvZGlAaHVhd2VpLmNvbT4KLS0tCiBkcml2
ZXJzL2FjcGkvYXJtNjQvaW9ydC5jIHwgMjIgKysrKysrKysrKysrKysrLS0tLS0tLQogZHJpdmVy
cy9pb21tdS9kbWEtaW9tbXUuYyB8ICAyICstCiBpbmNsdWRlL2xpbnV4L2FjcGlfaW9ydC5oIHwg
IDQgKystLQogMyBmaWxlcyBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkvYXJtNjQvaW9ydC5jIGIvZHJpdmVycy9hY3Bp
L2FybTY0L2lvcnQuYwppbmRleCAyMTNmNjFjYWUxNzYuLmNkNWQxZDc4MjNjYiAxMDA2NDQKLS0t
IGEvZHJpdmVycy9hY3BpL2FybTY0L2lvcnQuYworKysgYi9kcml2ZXJzL2FjcGkvYXJtNjQvaW9y
dC5jCkBAIC04MDYsMTUgKzgwNiwxMyBAQCBzdGF0aWMgc3RydWN0IGFjcGlfaW9ydF9ub2RlICpp
b3J0X2dldF9tc2lfcmVzdl9pb21tdShzdHJ1Y3QgZGV2aWNlICpkZXYpCiAJcmV0dXJuIE5VTEw7
CiB9CiAKLS8qKgotICogaW9ydF9pb21tdV9tc2lfZ2V0X3Jlc3ZfcmVnaW9ucyAtIFJlc2VydmVk
IHJlZ2lvbiBkcml2ZXIgaGVscGVyCi0gKiBAZGV2OiBEZXZpY2UgZnJvbSBpb21tdV9nZXRfcmVz
dl9yZWdpb25zKCkKLSAqIEBoZWFkOiBSZXNlcnZlZCByZWdpb24gbGlzdCBmcm9tIGlvbW11X2dl
dF9yZXN2X3JlZ2lvbnMoKQotICoKKy8qCisgKiBSZXRyaWV2ZSBwbGF0Zm9ybSBzcGVjaWZpYyBI
VyBNU0kgcmVzZXJ2ZSByZWdpb25zLgogICogVGhlIElUUyBpbnRlcnJ1cHQgdHJhbnNsYXRpb24g
c3BhY2VzIChJVFNfYmFzZSArIFNaXzY0SywgU1pfNjRLKQogICogYXNzb2NpYXRlZCB3aXRoIHRo
ZSBkZXZpY2UgYXJlIHRoZSBIVyBNU0kgcmVzZXJ2ZWQgcmVnaW9ucy4KICAqLwotdm9pZCBpb3J0
X2lvbW11X21zaV9nZXRfcmVzdl9yZWdpb25zKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGxp
c3RfaGVhZCAqaGVhZCkKK3N0YXRpYyB2b2lkIGlvcnRfaW9tbXVfbXNpX2dldF9yZXN2X3JlZ2lv
bnMoc3RydWN0IGRldmljZSAqZGV2LAorCQkJCQkgICAgc3RydWN0IGxpc3RfaGVhZCAqaGVhZCkK
IHsKIAlzdHJ1Y3QgaW9tbXVfZndzcGVjICpmd3NwZWMgPSBkZXZfaW9tbXVfZndzcGVjX2dldChk
ZXYpOwogCXN0cnVjdCBhY3BpX2lvcnRfaXRzX2dyb3VwICppdHM7CkBAIC04NjMsNiArODYxLDE2
IEBAIHZvaWQgaW9ydF9pb21tdV9tc2lfZ2V0X3Jlc3ZfcmVnaW9ucyhzdHJ1Y3QgZGV2aWNlICpk
ZXYsIHN0cnVjdCBsaXN0X2hlYWQgKmhlYWQpCiAJfQogfQogCisvKioKKyAqIGlvcnRfaW9tbXVf
Z2V0X3Jlc3ZfcmVnaW9ucyAtIEdlbmVyaWMgaGVscGVyIHRvIHJldHJpZXZlIHJlc2VydmVkIHJl
Z2lvbnMuCisgKiBAZGV2OiBEZXZpY2UgZnJvbSBpb21tdV9nZXRfcmVzdl9yZWdpb25zKCkKKyAq
IEBoZWFkOiBSZXNlcnZlZCByZWdpb24gbGlzdCBmcm9tIGlvbW11X2dldF9yZXN2X3JlZ2lvbnMo
KQorICovCit2b2lkIGlvcnRfaW9tbXVfZ2V0X3Jlc3ZfcmVnaW9ucyhzdHJ1Y3QgZGV2aWNlICpk
ZXYsIHN0cnVjdCBsaXN0X2hlYWQgKmhlYWQpCit7CisJaW9ydF9pb21tdV9tc2lfZ2V0X3Jlc3Zf
cmVnaW9ucyhkZXYsIGhlYWQpOworfQorCiBzdGF0aWMgaW5saW5lIGJvb2wgaW9ydF9pb21tdV9k
cml2ZXJfZW5hYmxlZCh1OCB0eXBlKQogewogCXN3aXRjaCAodHlwZSkgewpAQCAtMTAyNyw3ICsx
MDM1LDcgQEAgaW50IGlvcnRfaW9tbXVfY29uZmlndXJlX2lkKHN0cnVjdCBkZXZpY2UgKmRldiwg
Y29uc3QgdTMyICppZF9pbikKIH0KIAogI2Vsc2UKLXZvaWQgaW9ydF9pb21tdV9tc2lfZ2V0X3Jl
c3ZfcmVnaW9ucyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBsaXN0X2hlYWQgKmhlYWQpCit2
b2lkIGlvcnRfaW9tbXVfZ2V0X3Jlc3ZfcmVnaW9ucyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVj
dCBsaXN0X2hlYWQgKmhlYWQpCiB7IH0KIGludCBpb3J0X2lvbW11X2NvbmZpZ3VyZV9pZChzdHJ1
Y3QgZGV2aWNlICpkZXYsIGNvbnN0IHUzMiAqaW5wdXRfaWQpCiB7IHJldHVybiAtRU5PREVWOyB9
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2RtYS1pb21tdS5jIGIvZHJpdmVycy9pb21tdS9k
bWEtaW9tbXUuYwppbmRleCBmOTAyNTE1NzJhNWQuLjk3MGEyZTAxODY4NCAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9pb21tdS9kbWEtaW9tbXUuYworKysgYi9kcml2ZXJzL2lvbW11L2RtYS1pb21tdS5j
CkBAIC0zODUsNyArMzg1LDcgQEAgdm9pZCBpb21tdV9kbWFfZ2V0X3Jlc3ZfcmVnaW9ucyhzdHJ1
Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBsaXN0X2hlYWQgKmxpc3QpCiB7CiAKIAlpZiAoIWlzX29m
X25vZGUoZGV2X2lvbW11X2Z3c3BlY19nZXQoZGV2KS0+aW9tbXVfZndub2RlKSkKLQkJaW9ydF9p
b21tdV9tc2lfZ2V0X3Jlc3ZfcmVnaW9ucyhkZXYsIGxpc3QpOworCQlpb3J0X2lvbW11X2dldF9y
ZXN2X3JlZ2lvbnMoZGV2LCBsaXN0KTsKIAogfQogRVhQT1JUX1NZTUJPTChpb21tdV9kbWFfZ2V0
X3Jlc3ZfcmVnaW9ucyk7CmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2FjcGlfaW9ydC5oIGIv
aW5jbHVkZS9saW51eC9hY3BpX2lvcnQuaAppbmRleCBhODE5OGI4Mzc1M2QuLmU1ZDJkZTljYWY3
ZiAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9hY3BpX2lvcnQuaAorKysgYi9pbmNsdWRlL2xp
bnV4L2FjcGlfaW9ydC5oCkBAIC0zNiw3ICszNiw3IEBAIGludCBpb3J0X3Btc2lfZ2V0X2Rldl9p
ZChzdHJ1Y3QgZGV2aWNlICpkZXYsIHUzMiAqZGV2X2lkKTsKIC8qIElPTU1VIGludGVyZmFjZSAq
LwogaW50IGlvcnRfZG1hX2dldF9yYW5nZXMoc3RydWN0IGRldmljZSAqZGV2LCB1NjQgKnNpemUp
OwogaW50IGlvcnRfaW9tbXVfY29uZmlndXJlX2lkKHN0cnVjdCBkZXZpY2UgKmRldiwgY29uc3Qg
dTMyICppZF9pbik7Ci12b2lkIGlvcnRfaW9tbXVfbXNpX2dldF9yZXN2X3JlZ2lvbnMoc3RydWN0
IGRldmljZSAqZGV2LCBzdHJ1Y3QgbGlzdF9oZWFkICpoZWFkKTsKK3ZvaWQgaW9ydF9pb21tdV9n
ZXRfcmVzdl9yZWdpb25zKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGxpc3RfaGVhZCAqaGVh
ZCk7CiBwaHlzX2FkZHJfdCBhY3BpX2lvcnRfZG1hX2dldF9tYXhfY3B1X2FkZHJlc3Modm9pZCk7
CiAjZWxzZQogc3RhdGljIGlubGluZSB2b2lkIGFjcGlfaW9ydF9pbml0KHZvaWQpIHsgfQpAQCAt
NTIsNyArNTIsNyBAQCBzdGF0aWMgaW5saW5lIGludCBpb3J0X2RtYV9nZXRfcmFuZ2VzKHN0cnVj
dCBkZXZpY2UgKmRldiwgdTY0ICpzaXplKQogc3RhdGljIGlubGluZSBpbnQgaW9ydF9pb21tdV9j
b25maWd1cmVfaWQoc3RydWN0IGRldmljZSAqZGV2LCBjb25zdCB1MzIgKmlkX2luKQogeyByZXR1
cm4gLUVOT0RFVjsgfQogc3RhdGljIGlubGluZQotdm9pZCBpb3J0X2lvbW11X21zaV9nZXRfcmVz
dl9yZWdpb25zKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGxpc3RfaGVhZCAqaGVhZCkKK3Zv
aWQgaW9ydF9pb21tdV9nZXRfcmVzdl9yZWdpb25zKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0
IGxpc3RfaGVhZCAqaGVhZCkKIHsgfQogCiBzdGF0aWMgaW5saW5lIHBoeXNfYWRkcl90IGFjcGlf
aW9ydF9kbWFfZ2V0X21heF9jcHVfYWRkcmVzcyh2b2lkKQotLSAKMi4yNS4xCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QK
aW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
