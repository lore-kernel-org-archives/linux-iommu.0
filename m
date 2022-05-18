Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08C7BC433EF
	for <iommu@archiver.kernel.org>; Wed, 18 May 2022 18:17:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BD63A41017;
	Wed, 18 May 2022 18:17:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4kzgtYzCWvhE; Wed, 18 May 2022 18:17:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A25B9408E8;
	Wed, 18 May 2022 18:17:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7F4D6C0032;
	Wed, 18 May 2022 18:17:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A917C002D
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 18:17:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 001336124D
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 18:17:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 79MQmc76pctR for <iommu@lists.linux-foundation.org>;
 Wed, 18 May 2022 18:17:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9E3F76124C
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 18:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652897855; x=1684433855;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4MoEi9eIAsQEEnYGbn1gdDfBYv7oO8G4INN9f64CdNo=;
 b=GFTBwnlAfROeBqwQcUDYjdfZyiBAxzXGJ5+9sJPcByMh4H/D1pU97q2p
 gY2UBRG/I4mo/6LH9CpjBUs4xnPls/SnkxCXC8V43sgEaOgjWNYzdkxYI
 Cmq+z4vo+pxp5BhR5S7DZUHRsU8fi7LBZrc1jUwKhv/eDC1hVJ7yq5xxy
 RtJB23TBa98xN85BSW7s4lw5jIt5EjqCxn3pPdeFwkbVmoaJmT7NSxd/M
 EntTh06SawjprN+CjAHjsWRPouiK9WicbzmeJWmU6SfhiNjM2egbCnZNo
 2gdJ9QZAoW3Z7phM5haLhqZ1yCN9FnZe5t8VxP/5jSEtQKHOadx8GIaST A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="259392430"
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; d="scan'208";a="259392430"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2022 11:17:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; d="scan'208";a="639405510"
Received: from otc-wp-03.jf.intel.com (HELO jacob-builder.jf.intel.com)
 ([10.54.39.79])
 by fmsmga004.fm.intel.com with ESMTP; 18 May 2022 11:17:33 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 dmaengine@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "Lu Baolu" <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "Christoph Hellwig" <hch@infradead.org>, vkoul@kernel.org,
 robin.murphy@arm.com, will@kernel.org
Subject: [PATCH v4 6/6] iommu/vt-d: Delete unused SVM flag
Date: Wed, 18 May 2022 11:21:20 -0700
Message-Id: <20220518182120.1136715-7-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220518182120.1136715-1-jacob.jun.pan@linux.intel.com>
References: <20220518182120.1136715-1-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Raj Ashok <ashok.raj@intel.com>
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

U3VwZXJ2aXNvciBQQVNJRCBmb3IgU1ZBL1NWTSBpcyBubyBsb25nZXIgc3VwcG9ydGVkLCBkZWxl
dGUgdGhlIHVudXNlZApmbGFnLgoKU2lnbmVkLW9mZi1ieTogSmFjb2IgUGFuIDxqYWNvYi5qdW4u
cGFuQGxpbnV4LmludGVsLmNvbT4KLS0tCiBkcml2ZXJzL2lvbW11L2ludGVsL3N2bS5jIHwgIDIg
Ky0KIGluY2x1ZGUvbGludXgvaW50ZWwtc3ZtLmggfCAxMyAtLS0tLS0tLS0tLS0tCiAyIGZpbGVz
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2lvbW11L2ludGVsL3N2bS5jIGIvZHJpdmVycy9pb21tdS9pbnRlbC9zdm0uYwppbmRl
eCA0NDMzMWRiMDYwZTQuLjViMjIwZDQ2NDIxOCAxMDA2NDQKLS0tIGEvZHJpdmVycy9pb21tdS9p
bnRlbC9zdm0uYworKysgYi9kcml2ZXJzL2lvbW11L2ludGVsL3N2bS5jCkBAIC03NTAsNyArNzUw
LDcgQEAgc3RhdGljIGlycXJldHVybl90IHBycV9ldmVudF90aHJlYWQoaW50IGlycSwgdm9pZCAq
ZCkKIAkJCSAqIHRvIHVuYmluZCB0aGUgbW0gd2hpbGUgYW55IHBhZ2UgZmF1bHRzIGFyZSBvdXRz
dGFuZGluZy4KIAkJCSAqLwogCQkJc3ZtID0gcGFzaWRfcHJpdmF0ZV9maW5kKHJlcS0+cGFzaWQp
OwotCQkJaWYgKElTX0VSUl9PUl9OVUxMKHN2bSkgfHwgKHN2bS0+ZmxhZ3MgJiBTVk1fRkxBR19T
VVBFUlZJU09SX01PREUpKQorCQkJaWYgKElTX0VSUl9PUl9OVUxMKHN2bSkpCiAJCQkJZ290byBi
YWRfcmVxOwogCQl9CiAKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvaW50ZWwtc3ZtLmggYi9p
bmNsdWRlL2xpbnV4L2ludGVsLXN2bS5oCmluZGV4IGIzYjEyNWIzMzJhYS4uNjgzNWE2NjVjMTk1
IDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L2ludGVsLXN2bS5oCisrKyBiL2luY2x1ZGUvbGlu
dXgvaW50ZWwtc3ZtLmgKQEAgLTEzLDE3ICsxMyw0IEBACiAjZGVmaW5lIFBSUV9SSU5HX01BU0sJ
KCgweDEwMDAgPDwgUFJRX09SREVSKSAtIDB4MjApCiAjZGVmaW5lIFBSUV9ERVBUSAkoKDB4MTAw
MCA8PCBQUlFfT1JERVIpID4+IDUpCiAKLS8qCi0gKiBUaGUgU1ZNX0ZMQUdfU1VQRVJWSVNPUl9N
T0RFIGZsYWcgcmVxdWVzdHMgYSBQQVNJRCB3aGljaCBjYW4gYmUgdXNlZCBvbmx5Ci0gKiBmb3Ig
YWNjZXNzIHRvIGtlcm5lbCBhZGRyZXNzZXMuIE5vIElPVExCIGZsdXNoZXMgYXJlIGF1dG9tYXRp
Y2FsbHkgZG9uZQotICogZm9yIGtlcm5lbCBtYXBwaW5nczsgaXQgaXMgdmFsaWQgb25seSBmb3Ig
YWNjZXNzIHRvIHRoZSBrZXJuZWwncyBzdGF0aWMKLSAqIDE6MSBtYXBwaW5nIG9mIHBoeXNpY2Fs
IG1lbW9yeSDigJQgbm90IHRvIHZtYWxsb2Mgb3IgZXZlbiBtb2R1bGUgbWFwcGluZ3MuCi0gKiBB
IGZ1dHVyZSBBUEkgYWRkaXRpb24gbWF5IHBlcm1pdCB0aGUgdXNlIG9mIHN1Y2ggcmFuZ2VzLCBi
eSBtZWFucyBvZiBhbgotICogZXhwbGljaXQgSU9UTEIgZmx1c2ggY2FsbCAoYWtpbiB0byB0aGUg
RE1BIEFQSSdzIHVubWFwIG1ldGhvZCkuCi0gKgotICogSXQgaXMgdW5saWtlbHkgdGhhdCB3ZSB3
aWxsIGV2ZXIgaG9vayBpbnRvIGZsdXNoX3RsYl9rZXJuZWxfcmFuZ2UoKSB0bwotICogZG8gc3Vj
aCBJT1RMQiBmbHVzaGVzIGF1dG9tYXRpY2FsbHkuCi0gKi8KLSNkZWZpbmUgU1ZNX0ZMQUdfU1VQ
RVJWSVNPUl9NT0RFCUJJVCgwKQotCiAjZW5kaWYgLyogX19JTlRFTF9TVk1fSF9fICovCi0tIAoy
LjI1LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlv
bW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
