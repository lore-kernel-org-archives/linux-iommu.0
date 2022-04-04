Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FF51C433F5
	for <iommu@archiver.kernel.org>; Mon,  4 Apr 2022 12:43:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 68E1D408A6;
	Mon,  4 Apr 2022 12:43:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZvzA5N1Z60-h; Mon,  4 Apr 2022 12:43:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id ECEA74088B;
	Mon,  4 Apr 2022 12:43:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CB199C001D;
	Mon,  4 Apr 2022 12:43:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C1CABC0012
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 12:43:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A1C75813A8
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 12:43:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RWbh5aimG-wu for <iommu@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 12:43:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B481B8137E
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 12:43:37 +0000 (UTC)
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KX9Pq4TV3z685B2;
 Mon,  4 Apr 2022 20:41:35 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 4 Apr 2022 14:43:35 +0200
Received: from A2006125610.china.huawei.com (10.47.93.34) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 4 Apr 2022 13:43:27 +0100
To: <linux-arm-kernel@lists.infradead.org>, <linux-acpi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
Subject: [PATCH v9 04/11] ACPI/IORT: Provide a generic helper to retrieve
 reserve regions
Date: Mon, 4 Apr 2022 13:42:02 +0100
Message-ID: <20220404124209.1086-5-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20220404124209.1086-1-shameerali.kolothum.thodi@huawei.com>
References: <20220404124209.1086-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.47.93.34]
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
From: Shameer Kolothum via iommu <iommu@lists.linux-foundation.org>
Reply-To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Q3VycmVudGx5IElPUlQgcHJvdmlkZXMgYSBoZWxwZXIgdG8gcmV0cmlldmUgSFcgTVNJIHJlc2Vy
dmUgcmVnaW9ucy4KQ2hhbmdlIHRoaXMgdG8gYSBnZW5lcmljIGhlbHBlciB0byByZXRyaWV2ZcKg
YW55IElPUlQgcmVsYXRlZCByZXNlcnZlCnJlZ2lvbnMuIFRoaXMgd2lsbCBiZSB1c2VmdWwgd2hl
biB3ZcKgYWRkIHN1cHBvcnQgZm9yIFJNUiBub2RlcyBpbgpzdWJzZXF1ZW50IHBhdGNoZXMuCgpT
aWduZWQtb2ZmLWJ5OiBTaGFtZWVyIEtvbG90aHVtIDxzaGFtZWVyYWxpLmtvbG90aHVtLnRob2Rp
QGh1YXdlaS5jb20+Ci0tLQogZHJpdmVycy9hY3BpL2FybTY0L2lvcnQuYyB8IDIzICsrKysrKysr
KysrKysrKy0tLS0tLS0tCiBkcml2ZXJzL2lvbW11L2RtYS1pb21tdS5jIHwgIDIgKy0KIGluY2x1
ZGUvbGludXgvYWNwaV9pb3J0LmggfCAgNCArKy0tCiAzIGZpbGVzIGNoYW5nZWQsIDE4IGluc2Vy
dGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvYWNwaS9hcm02
NC9pb3J0LmMgYi9kcml2ZXJzL2FjcGkvYXJtNjQvaW9ydC5jCmluZGV4IGM1ZWJiMmJlOWExOS4u
NjNhY2MzYzViMjc1IDEwMDY0NAotLS0gYS9kcml2ZXJzL2FjcGkvYXJtNjQvaW9ydC5jCisrKyBi
L2RyaXZlcnMvYWNwaS9hcm02NC9pb3J0LmMKQEAgLTgzMCwxNiArODMwLDEzIEBAIHN0YXRpYyBz
dHJ1Y3QgYWNwaV9pb3J0X25vZGUgKmlvcnRfZ2V0X21zaV9yZXN2X2lvbW11KHN0cnVjdCBkZXZp
Y2UgKmRldikKIAlyZXR1cm4gTlVMTDsKIH0KIAotLyoqCi0gKiBpb3J0X2lvbW11X21zaV9nZXRf
cmVzdl9yZWdpb25zIC0gUmVzZXJ2ZWQgcmVnaW9uIGRyaXZlciBoZWxwZXIKLSAqICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBmb3IgSFcgTVNJIHJlZ2lvbnMuCi0gKiBAZGV2OiBE
ZXZpY2UgZnJvbSBpb21tdV9nZXRfcmVzdl9yZWdpb25zKCkKLSAqIEBoZWFkOiBSZXNlcnZlZCBy
ZWdpb24gbGlzdCBmcm9tIGlvbW11X2dldF9yZXN2X3JlZ2lvbnMoKQotICoKKy8qCisgKiBSZXRy
aWV2ZSBwbGF0Zm9ybSBzcGVjaWZpYyBIVyBNU0kgcmVzZXJ2ZSByZWdpb25zLgogICogVGhlIElU
UyBpbnRlcnJ1cHQgdHJhbnNsYXRpb24gc3BhY2VzIChJVFNfYmFzZSArIFNaXzY0SywgU1pfNjRL
KQogICogYXNzb2NpYXRlZCB3aXRoIHRoZSBkZXZpY2UgYXJlIHRoZSBIVyBNU0kgcmVzZXJ2ZWQg
cmVnaW9ucy4KICAqLwotdm9pZCBpb3J0X2lvbW11X21zaV9nZXRfcmVzdl9yZWdpb25zKHN0cnVj
dCBkZXZpY2UgKmRldiwgc3RydWN0IGxpc3RfaGVhZCAqaGVhZCkKK3N0YXRpYyB2b2lkCitpb3J0
X2lvbW11X21zaV9nZXRfcmVzdl9yZWdpb25zKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGxp
c3RfaGVhZCAqaGVhZCkKIHsKIAlzdHJ1Y3QgaW9tbXVfZndzcGVjICpmd3NwZWMgPSBkZXZfaW9t
bXVfZndzcGVjX2dldChkZXYpOwogCXN0cnVjdCBhY3BpX2lvcnRfaXRzX2dyb3VwICppdHM7CkBA
IC04ODgsNiArODg1LDE2IEBAIHZvaWQgaW9ydF9pb21tdV9tc2lfZ2V0X3Jlc3ZfcmVnaW9ucyhz
dHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBsaXN0X2hlYWQgKmhlYWQpCiAJfQogfQogCisvKioK
KyAqIGlvcnRfaW9tbXVfZ2V0X3Jlc3ZfcmVnaW9ucyAtIEdlbmVyaWMgaGVscGVyIHRvIHJldHJp
ZXZlIHJlc2VydmVkIHJlZ2lvbnMuCisgKiBAZGV2OiBEZXZpY2UgZnJvbSBpb21tdV9nZXRfcmVz
dl9yZWdpb25zKCkKKyAqIEBoZWFkOiBSZXNlcnZlZCByZWdpb24gbGlzdCBmcm9tIGlvbW11X2dl
dF9yZXN2X3JlZ2lvbnMoKQorICovCit2b2lkIGlvcnRfaW9tbXVfZ2V0X3Jlc3ZfcmVnaW9ucyhz
dHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBsaXN0X2hlYWQgKmhlYWQpCit7CisJaW9ydF9pb21t
dV9tc2lfZ2V0X3Jlc3ZfcmVnaW9ucyhkZXYsIGhlYWQpOworfQorCiBzdGF0aWMgaW5saW5lIGJv
b2wgaW9ydF9pb21tdV9kcml2ZXJfZW5hYmxlZCh1OCB0eXBlKQogewogCXN3aXRjaCAodHlwZSkg
ewpAQCAtMTA1Miw3ICsxMDU5LDcgQEAgaW50IGlvcnRfaW9tbXVfY29uZmlndXJlX2lkKHN0cnVj
dCBkZXZpY2UgKmRldiwgY29uc3QgdTMyICppZF9pbikKIH0KIAogI2Vsc2UKLXZvaWQgaW9ydF9p
b21tdV9tc2lfZ2V0X3Jlc3ZfcmVnaW9ucyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBsaXN0
X2hlYWQgKmhlYWQpCit2b2lkIGlvcnRfaW9tbXVfZ2V0X3Jlc3ZfcmVnaW9ucyhzdHJ1Y3QgZGV2
aWNlICpkZXYsIHN0cnVjdCBsaXN0X2hlYWQgKmhlYWQpCiB7IH0KIGludCBpb3J0X2lvbW11X2Nv
bmZpZ3VyZV9pZChzdHJ1Y3QgZGV2aWNlICpkZXYsIGNvbnN0IHUzMiAqaW5wdXRfaWQpCiB7IHJl
dHVybiAtRU5PREVWOyB9CmRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2RtYS1pb21tdS5jIGIv
ZHJpdmVycy9pb21tdS9kbWEtaW9tbXUuYwppbmRleCAwOWY2ZTFjMGY5YzAuLjkzZDc2YjY2Njg4
OCAxMDA2NDQKLS0tIGEvZHJpdmVycy9pb21tdS9kbWEtaW9tbXUuYworKysgYi9kcml2ZXJzL2lv
bW11L2RtYS1pb21tdS5jCkBAIC0zODQsNyArMzg0LDcgQEAgdm9pZCBpb21tdV9kbWFfZ2V0X3Jl
c3ZfcmVnaW9ucyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBsaXN0X2hlYWQgKmxpc3QpCiB7
CiAKIAlpZiAoIWlzX29mX25vZGUoZGV2X2lvbW11X2Z3c3BlY19nZXQoZGV2KS0+aW9tbXVfZndu
b2RlKSkKLQkJaW9ydF9pb21tdV9tc2lfZ2V0X3Jlc3ZfcmVnaW9ucyhkZXYsIGxpc3QpOworCQlp
b3J0X2lvbW11X2dldF9yZXN2X3JlZ2lvbnMoZGV2LCBsaXN0KTsKIAogfQogRVhQT1JUX1NZTUJP
TChpb21tdV9kbWFfZ2V0X3Jlc3ZfcmVnaW9ucyk7CmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4
L2FjcGlfaW9ydC5oIGIvaW5jbHVkZS9saW51eC9hY3BpX2lvcnQuaAppbmRleCBhODE5OGI4Mzc1
M2QuLmU1ZDJkZTljYWY3ZiAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9hY3BpX2lvcnQuaAor
KysgYi9pbmNsdWRlL2xpbnV4L2FjcGlfaW9ydC5oCkBAIC0zNiw3ICszNiw3IEBAIGludCBpb3J0
X3Btc2lfZ2V0X2Rldl9pZChzdHJ1Y3QgZGV2aWNlICpkZXYsIHUzMiAqZGV2X2lkKTsKIC8qIElP
TU1VIGludGVyZmFjZSAqLwogaW50IGlvcnRfZG1hX2dldF9yYW5nZXMoc3RydWN0IGRldmljZSAq
ZGV2LCB1NjQgKnNpemUpOwogaW50IGlvcnRfaW9tbXVfY29uZmlndXJlX2lkKHN0cnVjdCBkZXZp
Y2UgKmRldiwgY29uc3QgdTMyICppZF9pbik7Ci12b2lkIGlvcnRfaW9tbXVfbXNpX2dldF9yZXN2
X3JlZ2lvbnMoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgbGlzdF9oZWFkICpoZWFkKTsKK3Zv
aWQgaW9ydF9pb21tdV9nZXRfcmVzdl9yZWdpb25zKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0
IGxpc3RfaGVhZCAqaGVhZCk7CiBwaHlzX2FkZHJfdCBhY3BpX2lvcnRfZG1hX2dldF9tYXhfY3B1
X2FkZHJlc3Modm9pZCk7CiAjZWxzZQogc3RhdGljIGlubGluZSB2b2lkIGFjcGlfaW9ydF9pbml0
KHZvaWQpIHsgfQpAQCAtNTIsNyArNTIsNyBAQCBzdGF0aWMgaW5saW5lIGludCBpb3J0X2RtYV9n
ZXRfcmFuZ2VzKHN0cnVjdCBkZXZpY2UgKmRldiwgdTY0ICpzaXplKQogc3RhdGljIGlubGluZSBp
bnQgaW9ydF9pb21tdV9jb25maWd1cmVfaWQoc3RydWN0IGRldmljZSAqZGV2LCBjb25zdCB1MzIg
KmlkX2luKQogeyByZXR1cm4gLUVOT0RFVjsgfQogc3RhdGljIGlubGluZQotdm9pZCBpb3J0X2lv
bW11X21zaV9nZXRfcmVzdl9yZWdpb25zKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGxpc3Rf
aGVhZCAqaGVhZCkKK3ZvaWQgaW9ydF9pb21tdV9nZXRfcmVzdl9yZWdpb25zKHN0cnVjdCBkZXZp
Y2UgKmRldiwgc3RydWN0IGxpc3RfaGVhZCAqaGVhZCkKIHsgfQogCiBzdGF0aWMgaW5saW5lIHBo
eXNfYWRkcl90IGFjcGlfaW9ydF9kbWFfZ2V0X21heF9jcHVfYWRkcmVzcyh2b2lkKQotLSAKMi4y
NS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21t
dSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
