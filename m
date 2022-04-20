Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3319AC433F5
	for <iommu@archiver.kernel.org>; Wed, 20 Apr 2022 16:49:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C41A760769;
	Wed, 20 Apr 2022 16:49:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Uu57iFbk8frF; Wed, 20 Apr 2022 16:49:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 92239600CC;
	Wed, 20 Apr 2022 16:49:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 55EBDC0033;
	Wed, 20 Apr 2022 16:49:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4C31CC002C
 for <iommu@lists.linux-foundation.org>; Wed, 20 Apr 2022 16:49:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 413A6404FC
 for <iommu@lists.linux-foundation.org>; Wed, 20 Apr 2022 16:49:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eqw9cLFTt3oR for <iommu@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 16:49:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4F02640148
 for <iommu@lists.linux-foundation.org>; Wed, 20 Apr 2022 16:49:52 +0000 (UTC)
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Kk6673Bvvz67Nln;
 Thu, 21 Apr 2022 00:47:27 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 20 Apr 2022 18:49:50 +0200
Received: from A2006125610.china.huawei.com (10.47.81.194) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 20 Apr 2022 17:49:41 +0100
To: <linux-arm-kernel@lists.infradead.org>, <linux-acpi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
Subject: [PATCH v10 3/9] ACPI/IORT: Provide a generic helper to retrieve
 reserve regions
Date: Wed, 20 Apr 2022 17:48:30 +0100
Message-ID: <20220420164836.1181-4-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20220420164836.1181-1-shameerali.kolothum.thodi@huawei.com>
References: <20220420164836.1181-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.47.81.194]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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
b3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tPgpUZXN0ZWQtYnk6IFN0ZXZlbiBQcmljZSA8c3RldmVu
LnByaWNlQGFybS5jb20+ClRlc3RlZC1ieTogTGF1cmVudGl1IFR1ZG9yIDxsYXVyZW50aXUudHVk
b3JAbnhwLmNvbT4KU2lnbmVkLW9mZi1ieTogU2hhbWVlciBLb2xvdGh1bSA8c2hhbWVlcmFsaS5r
b2xvdGh1bS50aG9kaUBodWF3ZWkuY29tPgotLS0KIGRyaXZlcnMvYWNwaS9hcm02NC9pb3J0LmMg
fCAyMiArKysrKysrKysrKysrKystLS0tLS0tCiBkcml2ZXJzL2lvbW11L2RtYS1pb21tdS5jIHwg
IDIgKy0KIGluY2x1ZGUvbGludXgvYWNwaV9pb3J0LmggfCAgNCArKy0tCiAzIGZpbGVzIGNoYW5n
ZWQsIDE4IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvYWNwaS9hcm02NC9pb3J0LmMgYi9kcml2ZXJzL2FjcGkvYXJtNjQvaW9ydC5jCmluZGV4IDIx
M2Y2MWNhZTE3Ni4uY2Q1ZDFkNzgyM2NiIDEwMDY0NAotLS0gYS9kcml2ZXJzL2FjcGkvYXJtNjQv
aW9ydC5jCisrKyBiL2RyaXZlcnMvYWNwaS9hcm02NC9pb3J0LmMKQEAgLTgwNiwxNSArODA2LDEz
IEBAIHN0YXRpYyBzdHJ1Y3QgYWNwaV9pb3J0X25vZGUgKmlvcnRfZ2V0X21zaV9yZXN2X2lvbW11
KHN0cnVjdCBkZXZpY2UgKmRldikKIAlyZXR1cm4gTlVMTDsKIH0KIAotLyoqCi0gKiBpb3J0X2lv
bW11X21zaV9nZXRfcmVzdl9yZWdpb25zIC0gUmVzZXJ2ZWQgcmVnaW9uIGRyaXZlciBoZWxwZXIK
LSAqIEBkZXY6IERldmljZSBmcm9tIGlvbW11X2dldF9yZXN2X3JlZ2lvbnMoKQotICogQGhlYWQ6
IFJlc2VydmVkIHJlZ2lvbiBsaXN0IGZyb20gaW9tbXVfZ2V0X3Jlc3ZfcmVnaW9ucygpCi0gKgor
LyoKKyAqIFJldHJpZXZlIHBsYXRmb3JtIHNwZWNpZmljIEhXIE1TSSByZXNlcnZlIHJlZ2lvbnMu
CiAgKiBUaGUgSVRTIGludGVycnVwdCB0cmFuc2xhdGlvbiBzcGFjZXMgKElUU19iYXNlICsgU1pf
NjRLLCBTWl82NEspCiAgKiBhc3NvY2lhdGVkIHdpdGggdGhlIGRldmljZSBhcmUgdGhlIEhXIE1T
SSByZXNlcnZlZCByZWdpb25zLgogICovCi12b2lkIGlvcnRfaW9tbXVfbXNpX2dldF9yZXN2X3Jl
Z2lvbnMoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgbGlzdF9oZWFkICpoZWFkKQorc3RhdGlj
IHZvaWQgaW9ydF9pb21tdV9tc2lfZ2V0X3Jlc3ZfcmVnaW9ucyhzdHJ1Y3QgZGV2aWNlICpkZXYs
CisJCQkJCSAgICBzdHJ1Y3QgbGlzdF9oZWFkICpoZWFkKQogewogCXN0cnVjdCBpb21tdV9md3Nw
ZWMgKmZ3c3BlYyA9IGRldl9pb21tdV9md3NwZWNfZ2V0KGRldik7CiAJc3RydWN0IGFjcGlfaW9y
dF9pdHNfZ3JvdXAgKml0czsKQEAgLTg2Myw2ICs4NjEsMTYgQEAgdm9pZCBpb3J0X2lvbW11X21z
aV9nZXRfcmVzdl9yZWdpb25zKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGxpc3RfaGVhZCAq
aGVhZCkKIAl9CiB9CiAKKy8qKgorICogaW9ydF9pb21tdV9nZXRfcmVzdl9yZWdpb25zIC0gR2Vu
ZXJpYyBoZWxwZXIgdG8gcmV0cmlldmUgcmVzZXJ2ZWQgcmVnaW9ucy4KKyAqIEBkZXY6IERldmlj
ZSBmcm9tIGlvbW11X2dldF9yZXN2X3JlZ2lvbnMoKQorICogQGhlYWQ6IFJlc2VydmVkIHJlZ2lv
biBsaXN0IGZyb20gaW9tbXVfZ2V0X3Jlc3ZfcmVnaW9ucygpCisgKi8KK3ZvaWQgaW9ydF9pb21t
dV9nZXRfcmVzdl9yZWdpb25zKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGxpc3RfaGVhZCAq
aGVhZCkKK3sKKwlpb3J0X2lvbW11X21zaV9nZXRfcmVzdl9yZWdpb25zKGRldiwgaGVhZCk7Cit9
CisKIHN0YXRpYyBpbmxpbmUgYm9vbCBpb3J0X2lvbW11X2RyaXZlcl9lbmFibGVkKHU4IHR5cGUp
CiB7CiAJc3dpdGNoICh0eXBlKSB7CkBAIC0xMDI3LDcgKzEwMzUsNyBAQCBpbnQgaW9ydF9pb21t
dV9jb25maWd1cmVfaWQoc3RydWN0IGRldmljZSAqZGV2LCBjb25zdCB1MzIgKmlkX2luKQogfQog
CiAjZWxzZQotdm9pZCBpb3J0X2lvbW11X21zaV9nZXRfcmVzdl9yZWdpb25zKHN0cnVjdCBkZXZp
Y2UgKmRldiwgc3RydWN0IGxpc3RfaGVhZCAqaGVhZCkKK3ZvaWQgaW9ydF9pb21tdV9nZXRfcmVz
dl9yZWdpb25zKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGxpc3RfaGVhZCAqaGVhZCkKIHsg
fQogaW50IGlvcnRfaW9tbXVfY29uZmlndXJlX2lkKHN0cnVjdCBkZXZpY2UgKmRldiwgY29uc3Qg
dTMyICppbnB1dF9pZCkKIHsgcmV0dXJuIC1FTk9ERVY7IH0KZGlmZiAtLWdpdCBhL2RyaXZlcnMv
aW9tbXUvZG1hLWlvbW11LmMgYi9kcml2ZXJzL2lvbW11L2RtYS1pb21tdS5jCmluZGV4IDA5ZjZl
MWMwZjljMC4uOTNkNzZiNjY2ODg4IDEwMDY0NAotLS0gYS9kcml2ZXJzL2lvbW11L2RtYS1pb21t
dS5jCisrKyBiL2RyaXZlcnMvaW9tbXUvZG1hLWlvbW11LmMKQEAgLTM4NCw3ICszODQsNyBAQCB2
b2lkIGlvbW11X2RtYV9nZXRfcmVzdl9yZWdpb25zKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0
IGxpc3RfaGVhZCAqbGlzdCkKIHsKIAogCWlmICghaXNfb2Zfbm9kZShkZXZfaW9tbXVfZndzcGVj
X2dldChkZXYpLT5pb21tdV9md25vZGUpKQotCQlpb3J0X2lvbW11X21zaV9nZXRfcmVzdl9yZWdp
b25zKGRldiwgbGlzdCk7CisJCWlvcnRfaW9tbXVfZ2V0X3Jlc3ZfcmVnaW9ucyhkZXYsIGxpc3Qp
OwogCiB9CiBFWFBPUlRfU1lNQk9MKGlvbW11X2RtYV9nZXRfcmVzdl9yZWdpb25zKTsKZGlmZiAt
LWdpdCBhL2luY2x1ZGUvbGludXgvYWNwaV9pb3J0LmggYi9pbmNsdWRlL2xpbnV4L2FjcGlfaW9y
dC5oCmluZGV4IGE4MTk4YjgzNzUzZC4uZTVkMmRlOWNhZjdmIDEwMDY0NAotLS0gYS9pbmNsdWRl
L2xpbnV4L2FjcGlfaW9ydC5oCisrKyBiL2luY2x1ZGUvbGludXgvYWNwaV9pb3J0LmgKQEAgLTM2
LDcgKzM2LDcgQEAgaW50IGlvcnRfcG1zaV9nZXRfZGV2X2lkKHN0cnVjdCBkZXZpY2UgKmRldiwg
dTMyICpkZXZfaWQpOwogLyogSU9NTVUgaW50ZXJmYWNlICovCiBpbnQgaW9ydF9kbWFfZ2V0X3Jh
bmdlcyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHU2NCAqc2l6ZSk7CiBpbnQgaW9ydF9pb21tdV9jb25m
aWd1cmVfaWQoc3RydWN0IGRldmljZSAqZGV2LCBjb25zdCB1MzIgKmlkX2luKTsKLXZvaWQgaW9y
dF9pb21tdV9tc2lfZ2V0X3Jlc3ZfcmVnaW9ucyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBs
aXN0X2hlYWQgKmhlYWQpOwordm9pZCBpb3J0X2lvbW11X2dldF9yZXN2X3JlZ2lvbnMoc3RydWN0
IGRldmljZSAqZGV2LCBzdHJ1Y3QgbGlzdF9oZWFkICpoZWFkKTsKIHBoeXNfYWRkcl90IGFjcGlf
aW9ydF9kbWFfZ2V0X21heF9jcHVfYWRkcmVzcyh2b2lkKTsKICNlbHNlCiBzdGF0aWMgaW5saW5l
IHZvaWQgYWNwaV9pb3J0X2luaXQodm9pZCkgeyB9CkBAIC01Miw3ICs1Miw3IEBAIHN0YXRpYyBp
bmxpbmUgaW50IGlvcnRfZG1hX2dldF9yYW5nZXMoc3RydWN0IGRldmljZSAqZGV2LCB1NjQgKnNp
emUpCiBzdGF0aWMgaW5saW5lIGludCBpb3J0X2lvbW11X2NvbmZpZ3VyZV9pZChzdHJ1Y3QgZGV2
aWNlICpkZXYsIGNvbnN0IHUzMiAqaWRfaW4pCiB7IHJldHVybiAtRU5PREVWOyB9CiBzdGF0aWMg
aW5saW5lCi12b2lkIGlvcnRfaW9tbXVfbXNpX2dldF9yZXN2X3JlZ2lvbnMoc3RydWN0IGRldmlj
ZSAqZGV2LCBzdHJ1Y3QgbGlzdF9oZWFkICpoZWFkKQordm9pZCBpb3J0X2lvbW11X2dldF9yZXN2
X3JlZ2lvbnMoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgbGlzdF9oZWFkICpoZWFkKQogeyB9
CiAKIHN0YXRpYyBpbmxpbmUgcGh5c19hZGRyX3QgYWNwaV9pb3J0X2RtYV9nZXRfbWF4X2NwdV9h
ZGRyZXNzKHZvaWQpCi0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby9pb21tdQ==
