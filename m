Return-Path: <SRS0=Rn8G=OM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C78C433F5
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 05:13:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D2536105A
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 05:13:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2D2536105A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 04A8D83E82;
	Wed, 22 Sep 2021 05:13:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qy35dbRKxzLM; Wed, 22 Sep 2021 05:13:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id ED48F83EAD;
	Wed, 22 Sep 2021 05:13:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B72DDC0028;
	Wed, 22 Sep 2021 05:13:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 04B69C000F
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 05:13:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 107C14047C
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 05:13:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ounYueObOzej for <iommu@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 05:13:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1CB3D4047D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 05:13:15 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10114"; a="287187658"
X-IronPort-AV: E=Sophos;i="5.85,312,1624345200"; d="scan'208";a="287187658"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2021 22:13:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,312,1624345200"; d="scan'208";a="550107698"
Received: from otc-wp-03.jf.intel.com ([10.54.39.79])
 by FMSMGA003.fm.intel.com with ESMTP; 21 Sep 2021 22:13:14 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 "Christoph Hellwig" <hch@infradead.org>
Subject: [RFC 6/7] iommu: Add KVA map API
Date: Tue, 21 Sep 2021 13:29:40 -0700
Message-Id: <1632256181-36071-7-git-send-email-jacob.jun.pan@linux.intel.com>
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

VGhpcyBwYXRjaCBhZGRzIEtWQSBtYXAgQVBJLiBJdCBlbmZvcmNlcyBLVkEgYWRkcmVzcyByYW5n
ZSBjaGVja2luZyBhbmQKb3RoZXIgcG90ZW50aWFsIHNhbml0eSBjaGVja3MuIEN1cnJlbnRseSwg
b25seSB0aGUgZGlyZWN0IG1hcCByYW5nZSBpcwpjaGVja2VkLgpGb3IgdHJ1c3RlZCBkZXZpY2Vz
LCB0aGlzIEFQSSByZXR1cm5zIGltbWVkaWF0ZWx5IGFmdGVyIHRoZSBhYm92ZSBzYW5pdHkKY2hl
Y2suIEZvciB1bnRydXN0ZWQgZGV2aWNlcywgdGhpcyBBUEkgc2VydmVzIGFzIGEgc2ltcGxlIHdy
YXBwZXIgYXJvdW5kCklPTU1VIG1hcC91bm1hcCBBUElzLsKgCk9QRU46IEFsaWdubWVudCBhdCB0
aGUgbWluaW11bSBwYWdlIHNpemUgaXMgcmVxdWlyZWQsIG5vdCBhcyByaWNoIGFuZApmbGV4aWJs
ZSBhcyBETUEtQVBJcy4KClNpZ25lZC1vZmYtYnk6IEphY29iIFBhbiA8amFjb2IuanVuLnBhbkBs
aW51eC5pbnRlbC5jb20+Ci0tLQogZHJpdmVycy9pb21tdS9pb21tdS5jIHwgNTcgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogaW5jbHVkZS9saW51eC9pb21tdS5o
IHwgIDUgKysrKwogMiBmaWxlcyBjaGFuZ2VkLCA2MiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9pb21tdS9pb21tdS5jIGIvZHJpdmVycy9pb21tdS9pb21tdS5jCmluZGV4IGFj
ZmRjZDdlYmQ2YS4uNDViYTU1OTQxMjA5IDEwMDY0NAotLS0gYS9kcml2ZXJzL2lvbW11L2lvbW11
LmMKKysrIGIvZHJpdmVycy9pb21tdS9pb21tdS5jCkBAIC0yNDkwLDYgKzI0OTAsNjMgQEAgaW50
IGlvbW11X21hcChzdHJ1Y3QgaW9tbXVfZG9tYWluICpkb21haW4sIHVuc2lnbmVkIGxvbmcgaW92
YSwKIH0KIEVYUE9SVF9TWU1CT0xfR1BMKGlvbW11X21hcCk7CiAKKy8qCisgKiBSRVZJU0lUOiBU
aGlzIG1pZ2h0IG5vdCBiZSBzdWZmaWNpZW50LiBDb3VsZCBhbHNvIGNoZWNrIHBlcm1pc3Npb24g
bWF0Y2gsCisgKiBleGNsdWRlIGtlcm5lbCB0ZXh0LCBldGMuCisgKi8KK3N0YXRpYyBpbmxpbmUg
Ym9vbCBpc19rZXJuZWxfZGlyZWN0X21hcCh1bnNpZ25lZCBsb25nIHN0YXJ0LCBwaHlzX2FkZHJf
dCBzaXplKQoreworCXJldHVybiAoc3RhcnQgPj0gUEFHRV9PRkZTRVQpICYmICgoc3RhcnQgKyBz
aXplKSA8PSBWTUFMTE9DX1NUQVJUKTsKK30KKworLyoqCisgKiBAYnJpZWYgTWFwIGtlcm5lbCB2
aXJ0dWFsIGFkZHJlc3MgZm9yIERNQSByZW1hcC4gRE1BIHJlcXVlc3Qgd2l0aAorICoJZG9tYWlu
J3MgZGVmYXVsdCBQQVNJRCB3aWxsIHRhcmdldCBrZXJuZWwgdmlydHVhbCBhZGRyZXNzIHNwYWNl
LgorICoKKyAqIEBwYXJhbSBkb21haW4JRG9tYWluIGNvbnRhaW5zIHRoZSBQQVNJRAorICogQHBh
cmFtIHBhZ2UJCUtlcm5lbCB2aXJ0dWFsIGFkZHJlc3MKKyAqIEBwYXJhbSBzaXplCQlTaXplIHRv
IG1hcAorICogQHBhcmFtIHByb3QJCVBlcm1pc3Npb25zCisgKiBAcmV0dXJuIGludAkJMCBvbiBz
dWNjZXNzIG9yIGVycm9yIGNvZGUKKyAqLworaW50IGlvbW11X21hcF9rdmEoc3RydWN0IGlvbW11
X2RvbWFpbiAqZG9tYWluLCBzdHJ1Y3QgcGFnZSAqcGFnZSwKKwkJICBzaXplX3Qgc2l6ZSwgaW50
IHByb3QpCit7CisJcGh5c19hZGRyX3QgcGh5cyA9IHBhZ2VfdG9fcGh5cyhwYWdlKTsKKwl2b2lk
ICprdmEgPSBwaHlzX3RvX3ZpcnQocGh5cyk7CisKKwkvKgorCSAqIFRPRE86IExpbWl0IERNQSB0
byBrZXJuZWwgZGlyZWN0IG1hcHBpbmcgb25seSwgYXZvaWQgZHluYW1pYyByYW5nZQorCSAqIHVu
dGlsIHdlIGhhdmUgbW11X25vdGlmaWVyIGZvciBtYWtpbmcgSU9UTEIgY29oZXJlbnQgd2l0aCBD
UFUuCisJICovCisJaWYgKCFpc19rZXJuZWxfZGlyZWN0X21hcCgodW5zaWduZWQgbG9uZylrdmEs
IHNpemUpKQorCQlyZXR1cm4gLUVJTlZBTDsKKwkvKiBLVkEgZG9tYWluIHR5cGUgaW5kaWNhdGVz
IHNoYXJlZCBDUFUgcGFnZSB0YWJsZSwgc2tpcCBidWlsZGluZworCSAqIElPTU1VIHBhZ2UgdGFi
bGVzLiBUaGlzIGlzIHRoZSBmYXN0IG1vZGUgd2hlcmUgb25seSBzYW5pdHkgY2hlY2sKKwkgKiBp
cyBwZXJmb3JtZWQuCisJICovCisJaWYgKGRvbWFpbi0+dHlwZSA9PSBJT01NVV9ET01BSU5fS1ZB
KQorCQlyZXR1cm4gMDsKKworCXJldHVybiBpb21tdV9tYXAoZG9tYWluLCAodW5zaWduZWQgbG9u
ZylrdmEsIHBoeXMsIHNpemUsIHByb3QpOworfQorRVhQT1JUX1NZTUJPTF9HUEwoaW9tbXVfbWFw
X2t2YSk7CisKK2ludCBpb21tdV91bm1hcF9rdmEoc3RydWN0IGlvbW11X2RvbWFpbiAqZG9tYWlu
LCB2b2lkICprdmEsCisJCSAgICBzaXplX3Qgc2l6ZSkKK3sKKwlpZiAoIWlzX2tlcm5lbF9kaXJl
Y3RfbWFwKCh1bnNpZ25lZCBsb25nKWt2YSwgc2l6ZSkpCisJCXJldHVybiAtRUlOVkFMOworCisJ
aWYgKGRvbWFpbi0+dHlwZSA9PSBJT01NVV9ET01BSU5fS1ZBKSB7CisJCXByX2RlYnVnX3JhdGVs
aW1pdGVkKCJ1bm1hcCBrdmEgc2tpcHBlZCAlbGx4IiwgKHU2NClrdmEpOworCQlyZXR1cm4gMDsK
Kwl9CisJLyogUkVWSVNJVDogZG8gd2UgbmVlZCBhIGZhc3QgdmVyc2lvbj8gKi8KKwlyZXR1cm4g
aW9tbXVfdW5tYXAoZG9tYWluLCAodW5zaWduZWQgbG9uZylrdmEsIHNpemUpOworfQorRVhQT1JU
X1NZTUJPTF9HUEwoaW9tbXVfdW5tYXBfa3ZhKTsKKwogaW50IGlvbW11X21hcF9hdG9taWMoc3Ry
dWN0IGlvbW11X2RvbWFpbiAqZG9tYWluLCB1bnNpZ25lZCBsb25nIGlvdmEsCiAJICAgICAgcGh5
c19hZGRyX3QgcGFkZHIsIHNpemVfdCBzaXplLCBpbnQgcHJvdCkKIHsKZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvbGludXgvaW9tbXUuaCBiL2luY2x1ZGUvbGludXgvaW9tbXUuaAppbmRleCBjZDgyMjVm
NmJjMjMuLmMwZmFjMDUwY2E1NyAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9pb21tdS5oCisr
KyBiL2luY2x1ZGUvbGludXgvaW9tbXUuaApAQCAtNDI3LDYgKzQyNywxMSBAQCBleHRlcm4gc2l6
ZV90IGlvbW11X21hcF9zZyhzdHJ1Y3QgaW9tbXVfZG9tYWluICpkb21haW4sIHVuc2lnbmVkIGxv
bmcgaW92YSwKIGV4dGVybiBzaXplX3QgaW9tbXVfbWFwX3NnX2F0b21pYyhzdHJ1Y3QgaW9tbXVf
ZG9tYWluICpkb21haW4sCiAJCQkJICB1bnNpZ25lZCBsb25nIGlvdmEsIHN0cnVjdCBzY2F0dGVy
bGlzdCAqc2csCiAJCQkJICB1bnNpZ25lZCBpbnQgbmVudHMsIGludCBwcm90KTsKK2V4dGVybiBp
bnQgaW9tbXVfbWFwX2t2YShzdHJ1Y3QgaW9tbXVfZG9tYWluICpkb21haW4sCisJCQkgc3RydWN0
IHBhZ2UgKnBhZ2UsIHNpemVfdCBzaXplLCBpbnQgcHJvdCk7CitleHRlcm4gaW50IGlvbW11X3Vu
bWFwX2t2YShzdHJ1Y3QgaW9tbXVfZG9tYWluICpkb21haW4sCisJCQkgICB2b2lkICprdmEsIHNp
emVfdCBzaXplKTsKKwogZXh0ZXJuIHBoeXNfYWRkcl90IGlvbW11X2lvdmFfdG9fcGh5cyhzdHJ1
Y3QgaW9tbXVfZG9tYWluICpkb21haW4sIGRtYV9hZGRyX3QgaW92YSk7CiBleHRlcm4gdm9pZCBp
b21tdV9zZXRfZmF1bHRfaGFuZGxlcihzdHJ1Y3QgaW9tbXVfZG9tYWluICpkb21haW4sCiAJCQlp
b21tdV9mYXVsdF9oYW5kbGVyX3QgaGFuZGxlciwgdm9pZCAqdG9rZW4pOwotLSAKMi4yNS4xCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWls
aW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
