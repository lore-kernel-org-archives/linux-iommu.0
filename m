Return-Path: <SRS0=7pZu=EE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A712EC4363A
	for <iommu@archiver.kernel.org>; Thu, 29 Oct 2020 15:42:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD247207BC
	for <iommu@archiver.kernel.org>; Thu, 29 Oct 2020 15:42:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD247207BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 489CF86CA6;
	Thu, 29 Oct 2020 15:42:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id to+XBo4+Bq7q; Thu, 29 Oct 2020 15:42:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 653BF86C9F;
	Thu, 29 Oct 2020 15:42:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3A725C088B;
	Thu, 29 Oct 2020 15:42:24 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D1F9EC0051
 for <iommu@lists.linux-foundation.org>; Thu, 29 Oct 2020 15:42:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 6EC52203E1
 for <iommu@lists.linux-foundation.org>; Thu, 29 Oct 2020 15:42:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3dAynglcP-Is for <iommu@lists.linux-foundation.org>;
 Thu, 29 Oct 2020 15:42:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by silver.osuosl.org (Postfix) with ESMTPS id F27B92010C
 for <iommu@lists.linux-foundation.org>; Thu, 29 Oct 2020 15:42:19 +0000 (UTC)
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CMV7C0yCzzLnGB;
 Thu, 29 Oct 2020 23:42:15 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.47.27.104) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Thu, 29 Oct 2020 23:42:03 +0800
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux-foundation.org>
Subject: [PATCH] iommu/arm-smmu-v3: Add def_domain_type callback
Date: Thu, 29 Oct 2020 15:41:14 +0000
Message-ID: <20201029154114.20364-1-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.47.27.104]
X-CFilter-Loop: Reflected
Cc: jean-philippe@linaro.org, ashok.raj@intel.com, will@kernel.org,
 linuxarm@huawei.com, robin.murphy@arm.com
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

V2l0aCB0aGUgaW50cm9kdWN0aW9uIG9mIGRlZl9kb21haW5fdHlwZSBpbiBpb21tdV9vcHMsIHZl
bmRvcgpkcml2ZXJzIGNhbiBub3cgaW5mb3JtIHRoZSBpb21tdSBnZW5lcmljIGxheWVyIGFib3V0
IGFueSBzcGVjaWZpYwpkZWZhdWx0IGRvbWFpbiByZXF1aXJlbWVudCBmb3IgYSBkZXZpY2UuIEFu
eSBwY2kgZGV2IG1hcmtlZCBhcwp1bnRydXN0ZWQgaXMgbm93IHByZXZlbnRlZCBmcm9tIGhhdmlu
ZyBhbiBJREVOVElUWSBtYXBwaW5nCmRvbWFpbi7CoAoKVGhlIGNhbGxiYWNrIGlzIGFsc28gcmVx
dWlyZWQgd2hlbiB0aGUgc3VwcG9ydCBmb3IgZHluYW1pY2FsbHkKY2hhbmdpbmcgdGhlIGRlZmF1
bHQgZG9tYWluIG9mIGEgZ3JvdXAgaXMgYXZhaWxhYmxlLgoKU2lnbmVkLW9mZi1ieTogU2hhbWVl
ciBLb2xvdGh1bSA8c2hhbWVlcmFsaS5rb2xvdGh1bS50aG9kaUBodWF3ZWkuY29tPgotLS0KIC1P
bmx5IGRldmljZXMgZG93bnN0cmVhbSBmcm9twqBleHRlcm5hbGx5IGV4cG9zZWQgUENJZSBoaWVy
YXJjaGllcwrCoCAoc3VjaCBhcyBUaHVuZGVyYm9sdCBvdXRzaWRlIHRoZSBwbGF0Zm9ybSkgYXJl
IGN1cnJlbnRseSBtYXJrZWQKICBhcyAidW50cnVzdGVkIi4gTm90IGF3YXJlIG9mIGFueSBBUk02
NCBwbGF0Zm9ybXMgdGhhdCBtYXkgdXNlCiAgdGhpcyB0eXBlIG9mIGRldmljZS7CoMKgCgrCoCBO
ZXZlcnRoZWxlc3MsIHRoZSBtYWluIG1vdGl2YXRpb24gZm9yIHRoaXMgcGF0Y2ggaXMgdG8gaGF2
ZSB0aGUKICBmbGV4aWJpbGl0eSBvZiBjaGFuZ2luZ8KgdGhlIGlvbW11IGRlZmF1bHQgZG9tYWlu
IGZvciBhIGdyb3VwIGJhc2VkCiAgb24gdGhlIHNlcmllc1sxXSAiaW9tbXU6IEFkZCBzdXBwb3J0
IHRvIGNoYW5nZSBkZWZhdWx0IGRvbWFpbiBvZiBhbgogIGlvbW11IGdyb3VwIiBhbmQgdGhhdCBt
YW5kYXRlcyB2ZW5kb3IgaW9tbXUgZHJpdmVyIHRvIHByb3ZpZGUgdGhpcwogIGNhbGxiYWNrLgoK
wqAtVGhpcyBpcyB0ZXN0ZWQgYWxvbmcgd2l0aCBbMV0gYW5kIHdhcyBhYmxlIHRvIGNoYW5nZcKg
dGhlIGRlZmF1bHQKwqAgZG9tYWluIG9mIGFuIGlvbW11IGdyb3VwIG9uIGFuIEhpU2lsaWNvbiBE
MDYgaGFyZHdhcmUuCiAKMS4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtaW9tbXUvMjAy
MDA5MjUxOTA2MjAuMTg3MzItMS1hc2hvay5yYWpAaW50ZWwuY29tLwotLS0KIGRyaXZlcnMvaW9t
bXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLmMgfCAyNiArKysrKysrKysrKysrKysrKysr
KysKIDEgZmlsZSBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9pb21tdS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMuYyBiL2RyaXZlcnMvaW9tbXUvYXJt
L2FybS1zbW11LXYzL2FybS1zbW11LXYzLmMKaW5kZXggZTYzNGJiZTYwNTczLi5kNWRiY2VlOTk1
ZGIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYz
LmMKKysrIGIvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMuYwpAQCAt
MjU2Nyw2ICsyNTY3LDMxIEBAIHN0YXRpYyBpbnQgYXJtX3NtbXVfZGV2X2Rpc2FibGVfZmVhdHVy
ZShzdHJ1Y3QgZGV2aWNlICpkZXYsCiAJfQogfQogCisvKgorICogUmV0dXJuIHRoZSByZXF1aXJl
ZCBkZWZhdWx0IGRvbWFpbiB0eXBlIGZvciBhIHNwZWNpZmljIGRldmljZS4KKyAqCisgKiBAZGV2
OiB0aGUgZGV2aWNlIGluIHF1ZXJ5CisgKgorICogUmV0dXJuczoKKyAqICAtIElPTU1VX0RPTUFJ
Tl9ETUE6IGRldmljZSByZXF1aXJlcyBhIGR5bmFtaWMgbWFwcGluZyBkb21haW4KKyAqICAtIDA6
IGJvdGggaWRlbnRpdHkgYW5kIGR5bmFtaWMgZG9tYWlucyB3b3JrIGZvciB0aGlzIGRldmljZQor
ICovCitzdGF0aWMgaW50IGFybV9zbW11X2RlZl9kb21haW5fdHlwZShzdHJ1Y3QgZGV2aWNlICpk
ZXYpCit7CisJaWYgKGRldl9pc19wY2koZGV2KSkgeworCQlzdHJ1Y3QgcGNpX2RldiAqcGRldiA9
IHRvX3BjaV9kZXYoZGV2KTsKKworCQkvKgorCQkgKiBQcmV2ZW50IGFueSBkZXZpY2UgbWFya2Vk
IGFzIHVudHJ1c3RlZCBmcm9tIGdldHRpbmcKKwkJICogcGxhY2VkIGludG8gdGhlIElkZW50aXR5
IG1hcHBpbmcgZG9tYWluLgorCQkgKi8KKwkJaWYgKHBkZXYtPnVudHJ1c3RlZCkKKwkJCXJldHVy
biBJT01NVV9ET01BSU5fRE1BOworCX0KKworCXJldHVybiAwOworfQorCiBzdGF0aWMgc3RydWN0
IGlvbW11X29wcyBhcm1fc21tdV9vcHMgPSB7CiAJLmNhcGFibGUJCT0gYXJtX3NtbXVfY2FwYWJs
ZSwKIAkuZG9tYWluX2FsbG9jCQk9IGFybV9zbW11X2RvbWFpbl9hbGxvYywKQEAgLTI1ODksNiAr
MjYxNCw3IEBAIHN0YXRpYyBzdHJ1Y3QgaW9tbXVfb3BzIGFybV9zbW11X29wcyA9IHsKIAkuZGV2
X2ZlYXRfZW5hYmxlZAk9IGFybV9zbW11X2Rldl9mZWF0dXJlX2VuYWJsZWQsCiAJLmRldl9lbmFi
bGVfZmVhdAk9IGFybV9zbW11X2Rldl9lbmFibGVfZmVhdHVyZSwKIAkuZGV2X2Rpc2FibGVfZmVh
dAk9IGFybV9zbW11X2Rldl9kaXNhYmxlX2ZlYXR1cmUsCisJLmRlZl9kb21haW5fdHlwZQk9IGFy
bV9zbW11X2RlZl9kb21haW5fdHlwZSwKIAkucGdzaXplX2JpdG1hcAkJPSAtMVVMLCAvKiBSZXN0
cmljdGVkIGR1cmluZyBkZXZpY2UgYXR0YWNoICovCiB9OwogCi0tIAoyLjE3LjEKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlz
dAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
