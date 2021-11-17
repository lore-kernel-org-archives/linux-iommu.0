Return-Path: <SRS0=sOBO=QE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD92C4167E
	for <iommu@archiver.kernel.org>; Wed, 17 Nov 2021 21:54:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B99861BCF
	for <iommu@archiver.kernel.org>; Wed, 17 Nov 2021 21:54:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2B99861BCF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 47ECB8249B;
	Wed, 17 Nov 2021 21:54:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2fkP04Jf4fUY; Wed, 17 Nov 2021 21:54:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 990B6824BD;
	Wed, 17 Nov 2021 21:54:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84943C0044;
	Wed, 17 Nov 2021 21:54:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1D390C0039
 for <iommu@lists.linux-foundation.org>; Wed, 17 Nov 2021 21:54:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B66DC40581
 for <iommu@lists.linux-foundation.org>; Wed, 17 Nov 2021 21:54:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=deltatee.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0ZDIW4oE5xU4 for <iommu@lists.linux-foundation.org>;
 Wed, 17 Nov 2021 21:54:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A36E240600
 for <iommu@lists.linux-foundation.org>; Wed, 17 Nov 2021 21:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Cc:To:From:content-disposition;
 bh=kbxRRD/WjYOKmNXeZ54PsZJVBl6dgAV7EkPJgY+ogAQ=; b=EPbsJ0cS3BwETRTubjgeZLim87
 zU5lc+qxf57+emnTUgK+eNKrmk1W+kPbvSmXPLbL8Ep6my1GDulQucIIB/Krph/GG8cIvXY54LK14
 iw4hlm9xWIrpDp4tzPnxsQK/nWidaK5Ii/qxmteMNi/mJWZxD5IwcEDGD1hCZlD8v45s9eHFmyG65
 KtM+K23QE0wdLymKxRG2knTdmJsOEAz6kdNtsEn0qur5ftHxpmdgUR/6vO56uN0J+QYdgOe0Z1ERO
 U8C9vLvE1p1QKukPgaifYHNMBbC0KbLy7/meTyserJO0EeE/HgVz6MAqeXsZyYOg7G/Gr/zDayvRy
 EKfx1x8g==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <gunthorp@deltatee.com>)
 id 1mnSsn-000Zo3-Eq; Wed, 17 Nov 2021 14:54:22 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim
 4.94.2) (envelope-from <gunthorp@deltatee.com>)
 id 1mnSsl-00010I-MH; Wed, 17 Nov 2021 14:54:19 -0700
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Date: Wed, 17 Nov 2021 14:54:08 -0700
Message-Id: <20211117215410.3695-22-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211117215410.3695-1-logang@deltatee.com>
References: <20211117215410.3695-1-logang@deltatee.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de,
 jgg@ziepe.ca, christian.koenig@amd.com, jhubbard@nvidia.com,
 ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch,
 jason@jlekstrand.net, dave.hansen@linux.intel.com, helgaas@kernel.org,
 dan.j.williams@intel.com, andrzej.jakowski@intel.com, dave.b.minturn@intel.com,
 jianxin.xiong@intel.com, ira.weiny@intel.com, robin.murphy@arm.com,
 martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v4 21/23] mm: use custom page_free for P2PDMA pages
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: Minturn Dave B <dave.b.minturn@intel.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Ira Weiny <ira.weiny@intel.com>, John Hubbard <jhubbard@nvidia.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Robin Murphy <robin.murphy@arm.com>,
 Matthew Wilcox <willy@infradead.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Logan Gunthorpe <logang@deltatee.com>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Jason Ekstrand <jason@jlekstrand.net>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Bjorn Helgaas <helgaas@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Stephen Bates <sbates@raithlin.com>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>, Christoph Hellwig <hch@lst.de>,
 Xiong Jianxin <jianxin.xiong@intel.com>
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

V2hlbiBQMlBETUEgcGFnZXMgYXJlIHBhc3NlZCB0byB1c2Vyc3BhY2UsIHRoZXkgd2lsbCBuZWVk
IHRvIGJlCnJlZmVyZW5jZSBjb3VudGVkIHByb3Blcmx5IGFuZCByZXR1cm5lZCB0byB0aGVpciBn
ZW5hbGxvYyBhZnRlciB0aGVpcgpyZWZlcmVuY2UgY291bnQgcmV0dXJucyB0byAxLiBUaGlzIGlz
IGFjY29tcGxpc2hlZCB3aXRoIHRoZSBleGlzdGluZwpERVZfUEFHRU1BUF9PUFMgYW5kIHRoZSAu
cGFnZV9mcmVlKCkgb3BlcmF0aW9uLgoKQ2hhbmdlIENPTkZJR19QMlBETUEgdG8gc2VsZWN0IENP
TkZJR19ERVZfUEFHRU1BUF9PUFMgYW5kIGFkZApNRU1PUllfREVWSUNFX1BDSV9QMlBETUEgdG8g
cGFnZV9pc19kZXZtYXBfbWFuYWdlZCgpLApkZXZtYXBfbWFuYWdlZF9lbmFibGVfW3B1dHxnZXRd
KCkgYW5kIGZyZWVfZGV2bWFwX21hbmFnZWRfcGFnZSgpLgoKU2lnbmVkLW9mZi1ieTogTG9nYW4g
R3VudGhvcnBlIDxsb2dhbmdAZGVsdGF0ZWUuY29tPgotLS0KIGRyaXZlcnMvcGNpL0tjb25maWcg
IHwgIDEgKwogZHJpdmVycy9wY2kvcDJwZG1hLmMgfCAxMyArKysrKysrKysrKysrCiBpbmNsdWRl
L2xpbnV4L21tLmggICB8ICAxICsKIG1tL21lbXJlbWFwLmMgICAgICAgIHwgMTIgKysrKysrKysr
LS0tCiA0IGZpbGVzIGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvS2NvbmZpZyBiL2RyaXZlcnMvcGNpL0tjb25maWcKaW5k
ZXggOTVmMjk2MDFhNGRmLi5kYTUzNzk5Y2RkYWIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvcGNpL0tj
b25maWcKKysrIGIvZHJpdmVycy9wY2kvS2NvbmZpZwpAQCAtMTcwLDYgKzE3MCw3IEBAIGNvbmZp
ZyBQQ0lfUDJQRE1BCiAJIwogCXNlbGVjdCBORUVEX1NHX0RNQV9CVVNfQUREUl9GTEFHCiAJc2Vs
ZWN0IEdFTkVSSUNfQUxMT0NBVE9SCisJc2VsZWN0IERFVl9QQUdFTUFQX09QUwogCWhlbHAKIAkg
IEVuYWJsZdGVIGRyaXZlcnMgdG8gZG8gUENJIHBlZXItdG8tcGVlciB0cmFuc2FjdGlvbnMgdG8g
YW5kIGZyb20KIAkgIEJBUnMgdGhhdCBhcmUgZXhwb3NlZCBpbiBvdGhlciBkZXZpY2VzIHRoYXQg
YXJlIHRoZSBwYXJ0IG9mCmRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9wMnBkbWEuYyBiL2RyaXZl
cnMvcGNpL3AycGRtYS5jCmluZGV4IDU2M2U5YmU5NTk5ZS4uMTY5OTJiMGYwYzM2IDEwMDY0NAot
LS0gYS9kcml2ZXJzL3BjaS9wMnBkbWEuYworKysgYi9kcml2ZXJzL3BjaS9wMnBkbWEuYwpAQCAt
MTAxLDYgKzEwMSwxOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGF0dHJpYnV0ZV9ncm91cCBwMnBt
ZW1fZ3JvdXAgPSB7CiAJLm5hbWUgPSAicDJwbWVtIiwKIH07CiAKK3N0YXRpYyB2b2lkIHAycGRt
YV9wYWdlX2ZyZWUoc3RydWN0IHBhZ2UgKnBhZ2UpCit7CisJc3RydWN0IHBjaV9wMnBkbWFfcGFn
ZW1hcCAqcGdtYXAgPSB0b19wMnBfcGdtYXAocGFnZS0+cGdtYXApOworCisJZ2VuX3Bvb2xfZnJl
ZShwZ21hcC0+cHJvdmlkZXItPnAycGRtYS0+cG9vbCwKKwkJICAgICAgKHVpbnRwdHJfdClwYWdl
X3RvX3ZpcnQocGFnZSksIFBBR0VfU0laRSk7Cit9CisKK3N0YXRpYyBjb25zdCBzdHJ1Y3QgZGV2
X3BhZ2VtYXBfb3BzIHAycGRtYV9wZ21hcF9vcHMgPSB7CisJLnBhZ2VfZnJlZSA9IHAycGRtYV9w
YWdlX2ZyZWUsCit9OworCiBzdGF0aWMgdm9pZCBwY2lfcDJwZG1hX3JlbGVhc2Uodm9pZCAqZGF0
YSkKIHsKIAlzdHJ1Y3QgcGNpX2RldiAqcGRldiA9IGRhdGE7CkBAIC0xOTgsNiArMjEwLDcgQEAg
aW50IHBjaV9wMnBkbWFfYWRkX3Jlc291cmNlKHN0cnVjdCBwY2lfZGV2ICpwZGV2LCBpbnQgYmFy
LCBzaXplX3Qgc2l6ZSwKIAlwZ21hcC0+cmFuZ2UuZW5kID0gcGdtYXAtPnJhbmdlLnN0YXJ0ICsg
c2l6ZSAtIDE7CiAJcGdtYXAtPm5yX3JhbmdlID0gMTsKIAlwZ21hcC0+dHlwZSA9IE1FTU9SWV9E
RVZJQ0VfUENJX1AyUERNQTsKKwlwZ21hcC0+b3BzID0gJnAycGRtYV9wZ21hcF9vcHM7CiAKIAlw
MnBfcGdtYXAtPnByb3ZpZGVyID0gcGRldjsKIAlwMnBfcGdtYXAtPmJ1c19vZmZzZXQgPSBwY2lf
YnVzX2FkZHJlc3MocGRldiwgYmFyKSAtCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L21tLmgg
Yi9pbmNsdWRlL2xpbnV4L21tLmgKaW5kZXggMzM2N2Q5MzZiMjU2Li5mMjZlYTdlMWZjNzQgMTAw
NjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvbW0uaAorKysgYi9pbmNsdWRlL2xpbnV4L21tLmgKQEAg
LTExNjgsNiArMTE2OCw3IEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBwYWdlX2lzX2Rldm1hcF9tYW5h
Z2VkKHN0cnVjdCBwYWdlICpwYWdlKQogCXN3aXRjaCAocGFnZS0+cGdtYXAtPnR5cGUpIHsKIAlj
YXNlIE1FTU9SWV9ERVZJQ0VfUFJJVkFURToKIAljYXNlIE1FTU9SWV9ERVZJQ0VfRlNfREFYOgor
CWNhc2UgTUVNT1JZX0RFVklDRV9QQ0lfUDJQRE1BOgogCQlyZXR1cm4gdHJ1ZTsKIAlkZWZhdWx0
OgogCQlicmVhazsKZGlmZiAtLWdpdCBhL21tL21lbXJlbWFwLmMgYi9tbS9tZW1yZW1hcC5jCmlu
ZGV4IDVhNjZhNzFhYjU5MS4uZWMzMTQzZmZkZWVlIDEwMDY0NAotLS0gYS9tbS9tZW1yZW1hcC5j
CisrKyBiL21tL21lbXJlbWFwLmMKQEAgLTQ0LDE0ICs0NCwxNiBAQCBFWFBPUlRfU1lNQk9MKGRl
dm1hcF9tYW5hZ2VkX2tleSk7CiBzdGF0aWMgdm9pZCBkZXZtYXBfbWFuYWdlZF9lbmFibGVfcHV0
KHN0cnVjdCBkZXZfcGFnZW1hcCAqcGdtYXApCiB7CiAJaWYgKHBnbWFwLT50eXBlID09IE1FTU9S
WV9ERVZJQ0VfUFJJVkFURSB8fAotCSAgICBwZ21hcC0+dHlwZSA9PSBNRU1PUllfREVWSUNFX0ZT
X0RBWCkKKwkgICAgcGdtYXAtPnR5cGUgPT0gTUVNT1JZX0RFVklDRV9GU19EQVggfHwKKwkgICAg
cGdtYXAtPnR5cGUgPT0gTUVNT1JZX0RFVklDRV9QQ0lfUDJQRE1BKQogCQlzdGF0aWNfYnJhbmNo
X2RlYygmZGV2bWFwX21hbmFnZWRfa2V5KTsKIH0KIAogc3RhdGljIHZvaWQgZGV2bWFwX21hbmFn
ZWRfZW5hYmxlX2dldChzdHJ1Y3QgZGV2X3BhZ2VtYXAgKnBnbWFwKQogewogCWlmIChwZ21hcC0+
dHlwZSA9PSBNRU1PUllfREVWSUNFX1BSSVZBVEUgfHwKLQkgICAgcGdtYXAtPnR5cGUgPT0gTUVN
T1JZX0RFVklDRV9GU19EQVgpCisJICAgIHBnbWFwLT50eXBlID09IE1FTU9SWV9ERVZJQ0VfRlNf
REFYIHx8CisJICAgIHBnbWFwLT50eXBlID09IE1FTU9SWV9ERVZJQ0VfUENJX1AyUERNQSkKIAkJ
c3RhdGljX2JyYW5jaF9pbmMoJmRldm1hcF9tYW5hZ2VkX2tleSk7CiB9CiAjZWxzZQpAQCAtMzU1
LDYgKzM1NywxMCBAQCB2b2lkICptZW1yZW1hcF9wYWdlcyhzdHJ1Y3QgZGV2X3BhZ2VtYXAgKnBn
bWFwLCBpbnQgbmlkKQogCWNhc2UgTUVNT1JZX0RFVklDRV9HRU5FUklDOgogCQlicmVhazsKIAlj
YXNlIE1FTU9SWV9ERVZJQ0VfUENJX1AyUERNQToKKwkJaWYgKCFwZ21hcC0+b3BzLT5wYWdlX2Zy
ZWUpIHsKKwkJCVdBUk4oMSwgIk1pc3NpbmcgcGFnZV9mcmVlIG1ldGhvZFxuIik7CisJCQlyZXR1
cm4gRVJSX1BUUigtRUlOVkFMKTsKKwkJfQogCQlwYXJhbXMucGdwcm90ID0gcGdwcm90X25vbmNh
Y2hlZChwYXJhbXMucGdwcm90KTsKIAkJYnJlYWs7CiAJZGVmYXVsdDoKQEAgLTQ5OCw3ICs1MDQs
NyBAQCBFWFBPUlRfU1lNQk9MX0dQTChnZXRfZGV2X3BhZ2VtYXApOwogdm9pZCBmcmVlX2Rldm1h
cF9tYW5hZ2VkX3BhZ2Uoc3RydWN0IHBhZ2UgKnBhZ2UpCiB7CiAJLyogbm90aWZ5IHBhZ2UgaWRs
ZSBmb3IgZGF4ICovCi0JaWYgKCFpc19kZXZpY2VfcHJpdmF0ZV9wYWdlKHBhZ2UpKSB7CisJaWYg
KCFpc19kZXZpY2VfcHJpdmF0ZV9wYWdlKHBhZ2UpICYmICFpc19wY2lfcDJwZG1hX3BhZ2UocGFn
ZSkpIHsKIAkJd2FrZV91cF92YXIoJnBhZ2UtPl9yZWZjb3VudCk7CiAJCXJldHVybjsKIAl9Ci0t
IAoyLjMwLjIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
