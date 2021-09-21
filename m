Return-Path: <SRS0=Rn8G=OM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57105C433F5
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 05:13:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B281611B0
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 05:13:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1B281611B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 074B1613A0;
	Wed, 22 Sep 2021 05:13:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RbPie3NHTFEx; Wed, 22 Sep 2021 05:13:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 186C36138C;
	Wed, 22 Sep 2021 05:13:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F064EC0026;
	Wed, 22 Sep 2021 05:13:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3CD4DC0025
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 05:13:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6152D40486
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 05:13:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WJQddEH4552e for <iommu@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 05:13:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9718C40245
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 05:13:15 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10114"; a="287187660"
X-IronPort-AV: E=Sophos;i="5.85,312,1624345200"; d="scan'208";a="287187660"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2021 22:13:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,312,1624345200"; d="scan'208";a="550107703"
Received: from otc-wp-03.jf.intel.com ([10.54.39.79])
 by FMSMGA003.fm.intel.com with ESMTP; 21 Sep 2021 22:13:14 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 "Christoph Hellwig" <hch@infradead.org>
Subject: [RFC 7/7] dma/idxd: Use dma-iommu PASID API instead of SVA lib
Date: Tue, 21 Sep 2021 13:29:41 -0700
Message-Id: <1632256181-36071-8-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1632256181-36071-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1632256181-36071-1-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Tony Luck <tony.luck@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>, "Kumar,
 Sanjay K" <sanjay.k.kumar@intel.com>, mike.campin@intel.com
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

U2hvd2Nhc2UgYSBwYXJ0aWFsIHVzYWdlIG9mIHRoZSBuZXcgUEFTSUQgRE1BIEFQSSwgaXQgcmVw
bGFjZXMgU1ZBCmxpYsKgQVBJIGluIHRlcm1zIG9mIG9idGFpbmluZyBzeXN0ZW3CoFBBU0lEIGFu
ZCBhZGRyZXNzaW5nIG1vZGUgc2V0dXAuCkJ1dCB0aGUgYWN0dWFsIHdvcmsgc3VibWlzc2lvbiBp
cyBub3QgaW5jbHVkZWQuCgpTaWduZWQtb2ZmLWJ5OiBKYWNvYiBQYW4gPGphY29iLmp1bi5wYW5A
bGludXguaW50ZWwuY29tPgotLS0KIGRyaXZlcnMvZG1hL2lkeGQvaWR4ZC5oIHwgIDQgKysrLQog
ZHJpdmVycy9kbWEvaWR4ZC9pbml0LmMgfCAzNiArKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0t
LS0tLS0tLS0KIDIgZmlsZXMgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgMjEgZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9kbWEvaWR4ZC9pZHhkLmggYi9kcml2ZXJzL2RtYS9p
ZHhkL2lkeGQuaAppbmRleCA1MDdmNWQ1MTE5ZjkuLmVhZWRhZjNjM2UzYiAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9kbWEvaWR4ZC9pZHhkLmgKKysrIGIvZHJpdmVycy9kbWEvaWR4ZC9pZHhkLmgKQEAg
LTEyLDYgKzEyLDcgQEAKICNpbmNsdWRlIDxsaW51eC9wY2kuaD4KICNpbmNsdWRlIDxsaW51eC9w
ZXJmX2V2ZW50Lmg+CiAjaW5jbHVkZSA8bGludXgvaWR4ZC5oPgorI2luY2x1ZGUgPGxpbnV4L2Rt
YS1pb21tdS5oPgogI2luY2x1ZGUgInJlZ2lzdGVycy5oIgogCiAjZGVmaW5lIElEWERfRFJJVkVS
X1ZFUlNJT04JIjEuMDAiCkBAIC0yNTMsNyArMjU0LDggQEAgc3RydWN0IGlkeGRfZGV2aWNlIHsK
IAogCXN0cnVjdCBpb21tdV9zdmEgKnN2YTsKIAl1bnNpZ25lZCBpbnQgcGFzaWQ7Ci0KKwllbnVt
IGlvbW11X2RtYV9wYXNpZF9tb2RlIHNwYXNpZF9tb2RlOworCXN0cnVjdCBpb21tdV9kb21haW4g
KmRvbWFpbjsgLyogRm9yIEtWQSBtYXBwaW5nICovCiAJaW50IG51bV9ncm91cHM7CiAKIAl1MzIg
bXNpeF9wZXJtX29mZnNldDsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZG1hL2lkeGQvaW5pdC5jIGIv
ZHJpdmVycy9kbWEvaWR4ZC9pbml0LmMKaW5kZXggYzQwNGExMzIwNTM2Li44Zjk1MmE0Yzg5MDkg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZG1hL2lkeGQvaW5pdC5jCisrKyBiL2RyaXZlcnMvZG1hL2lk
eGQvaW5pdC5jCkBAIC0xNiw2ICsxNiw3IEBACiAjaW5jbHVkZSA8bGludXgvaWRyLmg+CiAjaW5j
bHVkZSA8bGludXgvaW50ZWwtc3ZtLmg+CiAjaW5jbHVkZSA8bGludXgvaW9tbXUuaD4KKyNpbmNs
dWRlIDxsaW51eC9kbWEtaW9tbXUuaD4KICNpbmNsdWRlIDx1YXBpL2xpbnV4L2lkeGQuaD4KICNp
bmNsdWRlIDxsaW51eC9kbWFlbmdpbmUuaD4KICNpbmNsdWRlICIuLi9kbWFlbmdpbmUuaCIKQEAg
LTMyLDYgKzMzLDExIEBAIHN0YXRpYyBib29sIHN2YSA9IHRydWU7CiBtb2R1bGVfcGFyYW0oc3Zh
LCBib29sLCAwNjQ0KTsKIE1PRFVMRV9QQVJNX0RFU0Moc3ZhLCAiVG9nZ2xlIFNWQSBzdXBwb3J0
IG9uL29mZiIpOwogCitzdGF0aWMgaW50IHNwYXNpZF9tb2RlID0gSU9NTVVfRE1BX1BBU0lEX0lP
VkE7Cittb2R1bGVfcGFyYW0oc3Bhc2lkX21vZGUsIGludCwgMDY0NCk7CitNT0RVTEVfUEFSTV9E
RVNDKHNwYXNpZF9tb2RlLAorCQkgIlN1cGVydmlzb3IgUEFTSUQgbW9kZSAoMTogcGFzcy10aHJv
dWdoLDI6IERNQSBBUEkpIik7CisKICNkZWZpbmUgRFJWX05BTUUgImlkeGQiCiAKIGJvb2wgc3Vw
cG9ydF9lbnFjbWQ7CkBAIC01MTksMzUgKzUyNSwyNSBAQCBzdGF0aWMgc3RydWN0IGlkeGRfZGV2
aWNlICppZHhkX2FsbG9jKHN0cnVjdCBwY2lfZGV2ICpwZGV2LCBzdHJ1Y3QgaWR4ZF9kcml2ZXJf
ZAogCiBzdGF0aWMgaW50IGlkeGRfZW5hYmxlX3N5c3RlbV9wYXNpZChzdHJ1Y3QgaWR4ZF9kZXZp
Y2UgKmlkeGQpCiB7Ci0JaW50IGZsYWdzOwotCXVuc2lnbmVkIGludCBwYXNpZDsKLQlzdHJ1Y3Qg
aW9tbXVfc3ZhICpzdmE7Ci0KLQlmbGFncyA9IFNWTV9GTEFHX1NVUEVSVklTT1JfTU9ERTsKLQot
CXN2YSA9IGlvbW11X3N2YV9iaW5kX2RldmljZSgmaWR4ZC0+cGRldi0+ZGV2LCBOVUxMLCAmZmxh
Z3MpOwotCWlmIChJU19FUlIoc3ZhKSkgewotCQlkZXZfd2FybigmaWR4ZC0+cGRldi0+ZGV2LAot
CQkJICJpb21tdSBzdmEgYmluZCBmYWlsZWQ6ICVsZFxuIiwgUFRSX0VSUihzdmEpKTsKLQkJcmV0
dXJuIFBUUl9FUlIoc3ZhKTsKLQl9CisJaW50IHBhc2lkOworCXN0cnVjdCBpb21tdV9kb21haW4g
KmRvbWFpbiA9IE5VTEw7CiAKLQlwYXNpZCA9IGlvbW11X3N2YV9nZXRfcGFzaWQoc3ZhKTsKLQlp
ZiAocGFzaWQgPT0gSU9NTVVfUEFTSURfSU5WQUxJRCkgewotCQlpb21tdV9zdmFfdW5iaW5kX2Rl
dmljZShzdmEpOworCXBhc2lkID0gaW9tbXVfZG1hX3Bhc2lkX2VuYWJsZSgmaWR4ZC0+cGRldi0+
ZGV2LCAmZG9tYWluLCBzcGFzaWRfbW9kZSk7CisJaWYgKHBhc2lkID09IElOVkFMSURfSU9BU0lE
KSB7CisJCWRldl9lcnIoJmlkeGQtPnBkZXYtPmRldiwgIk5vIERNQSBQQVNJRCBpbiBtb2RlICVk
XG4iLCBzcGFzaWRfbW9kZSk7CiAJCXJldHVybiAtRU5PREVWOwogCX0KLQotCWlkeGQtPnN2YSA9
IHN2YTsKIAlpZHhkLT5wYXNpZCA9IHBhc2lkOwotCWRldl9kYmcoJmlkeGQtPnBkZXYtPmRldiwg
InN5c3RlbSBwYXNpZDogJXVcbiIsIHBhc2lkKTsKKwlpZHhkLT5zcGFzaWRfbW9kZSA9IHNwYXNp
ZF9tb2RlOworCWlkeGQtPmRvbWFpbiA9IGRvbWFpbjsKKwogCXJldHVybiAwOwogfQogCiBzdGF0
aWMgdm9pZCBpZHhkX2Rpc2FibGVfc3lzdGVtX3Bhc2lkKHN0cnVjdCBpZHhkX2RldmljZSAqaWR4
ZCkKIHsKLQotCWlvbW11X3N2YV91bmJpbmRfZGV2aWNlKGlkeGQtPnN2YSk7CisJLyogVE9ETzog
cmVtb3ZlIHN2YSwgcmVzdG9yZSBubyBQQVNJRCBQVCBhbmQgUEFTSURFICovCisJaW9tbXVfZG1h
X3Bhc2lkX2Rpc2FibGUoJmlkeGQtPnBkZXYtPmRldiwgaWR4ZC0+ZG9tYWluKTsKIAlpZHhkLT5z
dmEgPSBOVUxMOwogfQogCi0tIAoyLjI1LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby9pb21tdQ==
