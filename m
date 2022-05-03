Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92C6DC433F5
	for <iommu@archiver.kernel.org>; Tue,  3 May 2022 16:34:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 43F8F6102A;
	Tue,  3 May 2022 16:34:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZU2VG7sakcqG; Tue,  3 May 2022 16:34:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 00ADE60B09;
	Tue,  3 May 2022 16:34:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D4239C0032;
	Tue,  3 May 2022 16:34:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27AC8C002D
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 16:34:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 07A37404C4
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 16:34:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tQBt3MXm4oxe for <iommu@lists.linux-foundation.org>;
 Tue,  3 May 2022 16:34:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 17C95400BF
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 16:34:43 +0000 (UTC)
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Kt57s0mKgz67vBH;
 Wed,  4 May 2022 00:31:37 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Tue, 3 May 2022 18:34:40 +0200
Received: from A2006125610.china.huawei.com (10.202.227.178) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 3 May 2022 17:34:33 +0100
To: <linux-arm-kernel@lists.infradead.org>, <linux-acpi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
Subject: [PATCH v12 3/9] ACPI/IORT: Provide a generic helper to retrieve
 reserve regions
Date: Tue, 3 May 2022 17:33:24 +0100
Message-ID: <20220503163330.509-4-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20220503163330.509-1-shameerali.kolothum.thodi@huawei.com>
References: <20220503163330.509-1-shameerali.kolothum.thodi@huawei.com>
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
bT4KU2lnbmVkLW9mZi1ieTogU2hhbWVlciBLb2xvdGh1bSA8c2hhbWVlcmFsaS5rb2xvdGh1bS50
aG9kaUBodWF3ZWkuY29tPgotLS0KIGRyaXZlcnMvYWNwaS9hcm02NC9pb3J0LmMgfCAyMiArKysr
KysrKysrKysrKystLS0tLS0tCiBkcml2ZXJzL2lvbW11L2RtYS1pb21tdS5jIHwgIDIgKy0KIGlu
Y2x1ZGUvbGludXgvYWNwaV9pb3J0LmggfCAgNCArKy0tCiAzIGZpbGVzIGNoYW5nZWQsIDE4IGlu
c2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvYWNwaS9h
cm02NC9pb3J0LmMgYi9kcml2ZXJzL2FjcGkvYXJtNjQvaW9ydC5jCmluZGV4IDIxM2Y2MWNhZTE3
Ni4uY2Q1ZDFkNzgyM2NiIDEwMDY0NAotLS0gYS9kcml2ZXJzL2FjcGkvYXJtNjQvaW9ydC5jCisr
KyBiL2RyaXZlcnMvYWNwaS9hcm02NC9pb3J0LmMKQEAgLTgwNiwxNSArODA2LDEzIEBAIHN0YXRp
YyBzdHJ1Y3QgYWNwaV9pb3J0X25vZGUgKmlvcnRfZ2V0X21zaV9yZXN2X2lvbW11KHN0cnVjdCBk
ZXZpY2UgKmRldikKIAlyZXR1cm4gTlVMTDsKIH0KIAotLyoqCi0gKiBpb3J0X2lvbW11X21zaV9n
ZXRfcmVzdl9yZWdpb25zIC0gUmVzZXJ2ZWQgcmVnaW9uIGRyaXZlciBoZWxwZXIKLSAqIEBkZXY6
IERldmljZSBmcm9tIGlvbW11X2dldF9yZXN2X3JlZ2lvbnMoKQotICogQGhlYWQ6IFJlc2VydmVk
IHJlZ2lvbiBsaXN0IGZyb20gaW9tbXVfZ2V0X3Jlc3ZfcmVnaW9ucygpCi0gKgorLyoKKyAqIFJl
dHJpZXZlIHBsYXRmb3JtIHNwZWNpZmljIEhXIE1TSSByZXNlcnZlIHJlZ2lvbnMuCiAgKiBUaGUg
SVRTIGludGVycnVwdCB0cmFuc2xhdGlvbiBzcGFjZXMgKElUU19iYXNlICsgU1pfNjRLLCBTWl82
NEspCiAgKiBhc3NvY2lhdGVkIHdpdGggdGhlIGRldmljZSBhcmUgdGhlIEhXIE1TSSByZXNlcnZl
ZCByZWdpb25zLgogICovCi12b2lkIGlvcnRfaW9tbXVfbXNpX2dldF9yZXN2X3JlZ2lvbnMoc3Ry
dWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgbGlzdF9oZWFkICpoZWFkKQorc3RhdGljIHZvaWQgaW9y
dF9pb21tdV9tc2lfZ2V0X3Jlc3ZfcmVnaW9ucyhzdHJ1Y3QgZGV2aWNlICpkZXYsCisJCQkJCSAg
ICBzdHJ1Y3QgbGlzdF9oZWFkICpoZWFkKQogewogCXN0cnVjdCBpb21tdV9md3NwZWMgKmZ3c3Bl
YyA9IGRldl9pb21tdV9md3NwZWNfZ2V0KGRldik7CiAJc3RydWN0IGFjcGlfaW9ydF9pdHNfZ3Jv
dXAgKml0czsKQEAgLTg2Myw2ICs4NjEsMTYgQEAgdm9pZCBpb3J0X2lvbW11X21zaV9nZXRfcmVz
dl9yZWdpb25zKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGxpc3RfaGVhZCAqaGVhZCkKIAl9
CiB9CiAKKy8qKgorICogaW9ydF9pb21tdV9nZXRfcmVzdl9yZWdpb25zIC0gR2VuZXJpYyBoZWxw
ZXIgdG8gcmV0cmlldmUgcmVzZXJ2ZWQgcmVnaW9ucy4KKyAqIEBkZXY6IERldmljZSBmcm9tIGlv
bW11X2dldF9yZXN2X3JlZ2lvbnMoKQorICogQGhlYWQ6IFJlc2VydmVkIHJlZ2lvbiBsaXN0IGZy
b20gaW9tbXVfZ2V0X3Jlc3ZfcmVnaW9ucygpCisgKi8KK3ZvaWQgaW9ydF9pb21tdV9nZXRfcmVz
dl9yZWdpb25zKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGxpc3RfaGVhZCAqaGVhZCkKK3sK
Kwlpb3J0X2lvbW11X21zaV9nZXRfcmVzdl9yZWdpb25zKGRldiwgaGVhZCk7Cit9CisKIHN0YXRp
YyBpbmxpbmUgYm9vbCBpb3J0X2lvbW11X2RyaXZlcl9lbmFibGVkKHU4IHR5cGUpCiB7CiAJc3dp
dGNoICh0eXBlKSB7CkBAIC0xMDI3LDcgKzEwMzUsNyBAQCBpbnQgaW9ydF9pb21tdV9jb25maWd1
cmVfaWQoc3RydWN0IGRldmljZSAqZGV2LCBjb25zdCB1MzIgKmlkX2luKQogfQogCiAjZWxzZQot
dm9pZCBpb3J0X2lvbW11X21zaV9nZXRfcmVzdl9yZWdpb25zKHN0cnVjdCBkZXZpY2UgKmRldiwg
c3RydWN0IGxpc3RfaGVhZCAqaGVhZCkKK3ZvaWQgaW9ydF9pb21tdV9nZXRfcmVzdl9yZWdpb25z
KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGxpc3RfaGVhZCAqaGVhZCkKIHsgfQogaW50IGlv
cnRfaW9tbXVfY29uZmlndXJlX2lkKHN0cnVjdCBkZXZpY2UgKmRldiwgY29uc3QgdTMyICppbnB1
dF9pZCkKIHsgcmV0dXJuIC1FTk9ERVY7IH0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvZG1h
LWlvbW11LmMgYi9kcml2ZXJzL2lvbW11L2RtYS1pb21tdS5jCmluZGV4IDA5ZjZlMWMwZjljMC4u
OTNkNzZiNjY2ODg4IDEwMDY0NAotLS0gYS9kcml2ZXJzL2lvbW11L2RtYS1pb21tdS5jCisrKyBi
L2RyaXZlcnMvaW9tbXUvZG1hLWlvbW11LmMKQEAgLTM4NCw3ICszODQsNyBAQCB2b2lkIGlvbW11
X2RtYV9nZXRfcmVzdl9yZWdpb25zKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGxpc3RfaGVh
ZCAqbGlzdCkKIHsKIAogCWlmICghaXNfb2Zfbm9kZShkZXZfaW9tbXVfZndzcGVjX2dldChkZXYp
LT5pb21tdV9md25vZGUpKQotCQlpb3J0X2lvbW11X21zaV9nZXRfcmVzdl9yZWdpb25zKGRldiwg
bGlzdCk7CisJCWlvcnRfaW9tbXVfZ2V0X3Jlc3ZfcmVnaW9ucyhkZXYsIGxpc3QpOwogCiB9CiBF
WFBPUlRfU1lNQk9MKGlvbW11X2RtYV9nZXRfcmVzdl9yZWdpb25zKTsKZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvbGludXgvYWNwaV9pb3J0LmggYi9pbmNsdWRlL2xpbnV4L2FjcGlfaW9ydC5oCmluZGV4
IGE4MTk4YjgzNzUzZC4uZTVkMmRlOWNhZjdmIDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L2Fj
cGlfaW9ydC5oCisrKyBiL2luY2x1ZGUvbGludXgvYWNwaV9pb3J0LmgKQEAgLTM2LDcgKzM2LDcg
QEAgaW50IGlvcnRfcG1zaV9nZXRfZGV2X2lkKHN0cnVjdCBkZXZpY2UgKmRldiwgdTMyICpkZXZf
aWQpOwogLyogSU9NTVUgaW50ZXJmYWNlICovCiBpbnQgaW9ydF9kbWFfZ2V0X3JhbmdlcyhzdHJ1
Y3QgZGV2aWNlICpkZXYsIHU2NCAqc2l6ZSk7CiBpbnQgaW9ydF9pb21tdV9jb25maWd1cmVfaWQo
c3RydWN0IGRldmljZSAqZGV2LCBjb25zdCB1MzIgKmlkX2luKTsKLXZvaWQgaW9ydF9pb21tdV9t
c2lfZ2V0X3Jlc3ZfcmVnaW9ucyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBsaXN0X2hlYWQg
KmhlYWQpOwordm9pZCBpb3J0X2lvbW11X2dldF9yZXN2X3JlZ2lvbnMoc3RydWN0IGRldmljZSAq
ZGV2LCBzdHJ1Y3QgbGlzdF9oZWFkICpoZWFkKTsKIHBoeXNfYWRkcl90IGFjcGlfaW9ydF9kbWFf
Z2V0X21heF9jcHVfYWRkcmVzcyh2b2lkKTsKICNlbHNlCiBzdGF0aWMgaW5saW5lIHZvaWQgYWNw
aV9pb3J0X2luaXQodm9pZCkgeyB9CkBAIC01Miw3ICs1Miw3IEBAIHN0YXRpYyBpbmxpbmUgaW50
IGlvcnRfZG1hX2dldF9yYW5nZXMoc3RydWN0IGRldmljZSAqZGV2LCB1NjQgKnNpemUpCiBzdGF0
aWMgaW5saW5lIGludCBpb3J0X2lvbW11X2NvbmZpZ3VyZV9pZChzdHJ1Y3QgZGV2aWNlICpkZXYs
IGNvbnN0IHUzMiAqaWRfaW4pCiB7IHJldHVybiAtRU5PREVWOyB9CiBzdGF0aWMgaW5saW5lCi12
b2lkIGlvcnRfaW9tbXVfbXNpX2dldF9yZXN2X3JlZ2lvbnMoc3RydWN0IGRldmljZSAqZGV2LCBz
dHJ1Y3QgbGlzdF9oZWFkICpoZWFkKQordm9pZCBpb3J0X2lvbW11X2dldF9yZXN2X3JlZ2lvbnMo
c3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgbGlzdF9oZWFkICpoZWFkKQogeyB9CiAKIHN0YXRp
YyBpbmxpbmUgcGh5c19hZGRyX3QgYWNwaV9pb3J0X2RtYV9nZXRfbWF4X2NwdV9hZGRyZXNzKHZv
aWQpCi0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21t
dQ==
