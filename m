Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF827C433F5
	for <iommu@archiver.kernel.org>; Fri, 22 Apr 2022 16:30:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AA5B8843C8;
	Fri, 22 Apr 2022 16:30:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LF_mhXRregez; Fri, 22 Apr 2022 16:30:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 44C83843E6;
	Fri, 22 Apr 2022 16:30:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2CB30C0039;
	Fri, 22 Apr 2022 16:30:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15926C002D
 for <iommu@lists.linux-foundation.org>; Fri, 22 Apr 2022 16:30:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E7FE440256
 for <iommu@lists.linux-foundation.org>; Fri, 22 Apr 2022 16:30:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jeCLUd1SUZvY for <iommu@lists.linux-foundation.org>;
 Fri, 22 Apr 2022 16:30:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B6BF5416FF
 for <iommu@lists.linux-foundation.org>; Fri, 22 Apr 2022 16:30:04 +0000 (UTC)
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KlKZ9626Vz687XH;
 Sat, 23 Apr 2022 00:27:29 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 22 Apr 2022 18:30:02 +0200
Received: from A2006125610.china.huawei.com (10.202.227.178) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 22 Apr 2022 17:29:54 +0100
To: <linux-arm-kernel@lists.infradead.org>, <linux-acpi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
Subject: [PATCH v11 3/9] ACPI/IORT: Provide a generic helper to retrieve
 reserve regions
Date: Fri, 22 Apr 2022 17:29:01 +0100
Message-ID: <20220422162907.1276-4-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20220422162907.1276-1-shameerali.kolothum.thodi@huawei.com>
References: <20220422162907.1276-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.202.227.178]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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
PGhjaEBsc3QuZGU+ClNpZ25lZC1vZmYtYnk6IFNoYW1lZXIgS29sb3RodW0gPHNoYW1lZXJhbGku
a29sb3RodW0udGhvZGlAaHVhd2VpLmNvbT4KLS0tCiBkcml2ZXJzL2FjcGkvYXJtNjQvaW9ydC5j
IHwgMjIgKysrKysrKysrKysrKysrLS0tLS0tLQogZHJpdmVycy9pb21tdS9kbWEtaW9tbXUuYyB8
ICAyICstCiBpbmNsdWRlL2xpbnV4L2FjcGlfaW9ydC5oIHwgIDQgKystLQogMyBmaWxlcyBjaGFu
Z2VkLCAxOCBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2FjcGkvYXJtNjQvaW9ydC5jIGIvZHJpdmVycy9hY3BpL2FybTY0L2lvcnQuYwppbmRleCAy
MTNmNjFjYWUxNzYuLmNkNWQxZDc4MjNjYiAxMDA2NDQKLS0tIGEvZHJpdmVycy9hY3BpL2FybTY0
L2lvcnQuYworKysgYi9kcml2ZXJzL2FjcGkvYXJtNjQvaW9ydC5jCkBAIC04MDYsMTUgKzgwNiwx
MyBAQCBzdGF0aWMgc3RydWN0IGFjcGlfaW9ydF9ub2RlICppb3J0X2dldF9tc2lfcmVzdl9pb21t
dShzdHJ1Y3QgZGV2aWNlICpkZXYpCiAJcmV0dXJuIE5VTEw7CiB9CiAKLS8qKgotICogaW9ydF9p
b21tdV9tc2lfZ2V0X3Jlc3ZfcmVnaW9ucyAtIFJlc2VydmVkIHJlZ2lvbiBkcml2ZXIgaGVscGVy
Ci0gKiBAZGV2OiBEZXZpY2UgZnJvbSBpb21tdV9nZXRfcmVzdl9yZWdpb25zKCkKLSAqIEBoZWFk
OiBSZXNlcnZlZCByZWdpb24gbGlzdCBmcm9tIGlvbW11X2dldF9yZXN2X3JlZ2lvbnMoKQotICoK
Ky8qCisgKiBSZXRyaWV2ZSBwbGF0Zm9ybSBzcGVjaWZpYyBIVyBNU0kgcmVzZXJ2ZSByZWdpb25z
LgogICogVGhlIElUUyBpbnRlcnJ1cHQgdHJhbnNsYXRpb24gc3BhY2VzIChJVFNfYmFzZSArIFNa
XzY0SywgU1pfNjRLKQogICogYXNzb2NpYXRlZCB3aXRoIHRoZSBkZXZpY2UgYXJlIHRoZSBIVyBN
U0kgcmVzZXJ2ZWQgcmVnaW9ucy4KICAqLwotdm9pZCBpb3J0X2lvbW11X21zaV9nZXRfcmVzdl9y
ZWdpb25zKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGxpc3RfaGVhZCAqaGVhZCkKK3N0YXRp
YyB2b2lkIGlvcnRfaW9tbXVfbXNpX2dldF9yZXN2X3JlZ2lvbnMoc3RydWN0IGRldmljZSAqZGV2
LAorCQkJCQkgICAgc3RydWN0IGxpc3RfaGVhZCAqaGVhZCkKIHsKIAlzdHJ1Y3QgaW9tbXVfZndz
cGVjICpmd3NwZWMgPSBkZXZfaW9tbXVfZndzcGVjX2dldChkZXYpOwogCXN0cnVjdCBhY3BpX2lv
cnRfaXRzX2dyb3VwICppdHM7CkBAIC04NjMsNiArODYxLDE2IEBAIHZvaWQgaW9ydF9pb21tdV9t
c2lfZ2V0X3Jlc3ZfcmVnaW9ucyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBsaXN0X2hlYWQg
KmhlYWQpCiAJfQogfQogCisvKioKKyAqIGlvcnRfaW9tbXVfZ2V0X3Jlc3ZfcmVnaW9ucyAtIEdl
bmVyaWMgaGVscGVyIHRvIHJldHJpZXZlIHJlc2VydmVkIHJlZ2lvbnMuCisgKiBAZGV2OiBEZXZp
Y2UgZnJvbSBpb21tdV9nZXRfcmVzdl9yZWdpb25zKCkKKyAqIEBoZWFkOiBSZXNlcnZlZCByZWdp
b24gbGlzdCBmcm9tIGlvbW11X2dldF9yZXN2X3JlZ2lvbnMoKQorICovCit2b2lkIGlvcnRfaW9t
bXVfZ2V0X3Jlc3ZfcmVnaW9ucyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBsaXN0X2hlYWQg
KmhlYWQpCit7CisJaW9ydF9pb21tdV9tc2lfZ2V0X3Jlc3ZfcmVnaW9ucyhkZXYsIGhlYWQpOwor
fQorCiBzdGF0aWMgaW5saW5lIGJvb2wgaW9ydF9pb21tdV9kcml2ZXJfZW5hYmxlZCh1OCB0eXBl
KQogewogCXN3aXRjaCAodHlwZSkgewpAQCAtMTAyNyw3ICsxMDM1LDcgQEAgaW50IGlvcnRfaW9t
bXVfY29uZmlndXJlX2lkKHN0cnVjdCBkZXZpY2UgKmRldiwgY29uc3QgdTMyICppZF9pbikKIH0K
IAogI2Vsc2UKLXZvaWQgaW9ydF9pb21tdV9tc2lfZ2V0X3Jlc3ZfcmVnaW9ucyhzdHJ1Y3QgZGV2
aWNlICpkZXYsIHN0cnVjdCBsaXN0X2hlYWQgKmhlYWQpCit2b2lkIGlvcnRfaW9tbXVfZ2V0X3Jl
c3ZfcmVnaW9ucyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBsaXN0X2hlYWQgKmhlYWQpCiB7
IH0KIGludCBpb3J0X2lvbW11X2NvbmZpZ3VyZV9pZChzdHJ1Y3QgZGV2aWNlICpkZXYsIGNvbnN0
IHUzMiAqaW5wdXRfaWQpCiB7IHJldHVybiAtRU5PREVWOyB9CmRpZmYgLS1naXQgYS9kcml2ZXJz
L2lvbW11L2RtYS1pb21tdS5jIGIvZHJpdmVycy9pb21tdS9kbWEtaW9tbXUuYwppbmRleCAwOWY2
ZTFjMGY5YzAuLjkzZDc2YjY2Njg4OCAxMDA2NDQKLS0tIGEvZHJpdmVycy9pb21tdS9kbWEtaW9t
bXUuYworKysgYi9kcml2ZXJzL2lvbW11L2RtYS1pb21tdS5jCkBAIC0zODQsNyArMzg0LDcgQEAg
dm9pZCBpb21tdV9kbWFfZ2V0X3Jlc3ZfcmVnaW9ucyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVj
dCBsaXN0X2hlYWQgKmxpc3QpCiB7CiAKIAlpZiAoIWlzX29mX25vZGUoZGV2X2lvbW11X2Z3c3Bl
Y19nZXQoZGV2KS0+aW9tbXVfZndub2RlKSkKLQkJaW9ydF9pb21tdV9tc2lfZ2V0X3Jlc3ZfcmVn
aW9ucyhkZXYsIGxpc3QpOworCQlpb3J0X2lvbW11X2dldF9yZXN2X3JlZ2lvbnMoZGV2LCBsaXN0
KTsKIAogfQogRVhQT1JUX1NZTUJPTChpb21tdV9kbWFfZ2V0X3Jlc3ZfcmVnaW9ucyk7CmRpZmYg
LS1naXQgYS9pbmNsdWRlL2xpbnV4L2FjcGlfaW9ydC5oIGIvaW5jbHVkZS9saW51eC9hY3BpX2lv
cnQuaAppbmRleCBhODE5OGI4Mzc1M2QuLmU1ZDJkZTljYWY3ZiAxMDA2NDQKLS0tIGEvaW5jbHVk
ZS9saW51eC9hY3BpX2lvcnQuaAorKysgYi9pbmNsdWRlL2xpbnV4L2FjcGlfaW9ydC5oCkBAIC0z
Niw3ICszNiw3IEBAIGludCBpb3J0X3Btc2lfZ2V0X2Rldl9pZChzdHJ1Y3QgZGV2aWNlICpkZXYs
IHUzMiAqZGV2X2lkKTsKIC8qIElPTU1VIGludGVyZmFjZSAqLwogaW50IGlvcnRfZG1hX2dldF9y
YW5nZXMoc3RydWN0IGRldmljZSAqZGV2LCB1NjQgKnNpemUpOwogaW50IGlvcnRfaW9tbXVfY29u
ZmlndXJlX2lkKHN0cnVjdCBkZXZpY2UgKmRldiwgY29uc3QgdTMyICppZF9pbik7Ci12b2lkIGlv
cnRfaW9tbXVfbXNpX2dldF9yZXN2X3JlZ2lvbnMoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3Qg
bGlzdF9oZWFkICpoZWFkKTsKK3ZvaWQgaW9ydF9pb21tdV9nZXRfcmVzdl9yZWdpb25zKHN0cnVj
dCBkZXZpY2UgKmRldiwgc3RydWN0IGxpc3RfaGVhZCAqaGVhZCk7CiBwaHlzX2FkZHJfdCBhY3Bp
X2lvcnRfZG1hX2dldF9tYXhfY3B1X2FkZHJlc3Modm9pZCk7CiAjZWxzZQogc3RhdGljIGlubGlu
ZSB2b2lkIGFjcGlfaW9ydF9pbml0KHZvaWQpIHsgfQpAQCAtNTIsNyArNTIsNyBAQCBzdGF0aWMg
aW5saW5lIGludCBpb3J0X2RtYV9nZXRfcmFuZ2VzKHN0cnVjdCBkZXZpY2UgKmRldiwgdTY0ICpz
aXplKQogc3RhdGljIGlubGluZSBpbnQgaW9ydF9pb21tdV9jb25maWd1cmVfaWQoc3RydWN0IGRl
dmljZSAqZGV2LCBjb25zdCB1MzIgKmlkX2luKQogeyByZXR1cm4gLUVOT0RFVjsgfQogc3RhdGlj
IGlubGluZQotdm9pZCBpb3J0X2lvbW11X21zaV9nZXRfcmVzdl9yZWdpb25zKHN0cnVjdCBkZXZp
Y2UgKmRldiwgc3RydWN0IGxpc3RfaGVhZCAqaGVhZCkKK3ZvaWQgaW9ydF9pb21tdV9nZXRfcmVz
dl9yZWdpb25zKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGxpc3RfaGVhZCAqaGVhZCkKIHsg
fQogCiBzdGF0aWMgaW5saW5lIHBoeXNfYWRkcl90IGFjcGlfaW9ydF9kbWFfZ2V0X21heF9jcHVf
YWRkcmVzcyh2b2lkKQotLSAKMi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vaW9tbXU=
