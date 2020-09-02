Return-Path: <SRS0=BMay=CL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA8EC433E2
	for <iommu@archiver.kernel.org>; Wed,  2 Sep 2020 17:31:16 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3D812083B
	for <iommu@archiver.kernel.org>; Wed,  2 Sep 2020 17:31:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3D812083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C9C4D86872;
	Wed,  2 Sep 2020 17:31:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e4rOR4vjXhJl; Wed,  2 Sep 2020 17:31:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D2027868E1;
	Wed,  2 Sep 2020 17:31:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BDEC4C0890;
	Wed,  2 Sep 2020 17:31:12 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A6B04C0051
 for <iommu@lists.linux-foundation.org>; Wed,  2 Sep 2020 17:31:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 94372866AE
 for <iommu@lists.linux-foundation.org>; Wed,  2 Sep 2020 17:31:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sfalz9iNnbOc for <iommu@lists.linux-foundation.org>;
 Wed,  2 Sep 2020 17:31:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 685F386872
 for <iommu@lists.linux-foundation.org>; Wed,  2 Sep 2020 17:31:10 +0000 (UTC)
IronPort-SDR: adlz9RQOFjKLt3xHS1yGhrVmJ8CjAVWu0gjVR0HF0UAyeNdEpOAg1jM37py97buZDualIKLfs8
 20grrru4bJ+w==
X-IronPort-AV: E=McAfee;i="6000,8403,9732"; a="137493021"
X-IronPort-AV: E=Sophos;i="5.76,383,1592895600"; d="scan'208";a="137493021"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2020 10:31:09 -0700
IronPort-SDR: iboufCExiMkRwxCZvv9JA1JwWVwYv355gMVPE7gw/E2R9tqa+c/tjbiqe63h+2B+fgxp5kgTqr
 yw19mzRBOXhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,383,1592895600"; d="scan'208";a="334183284"
Received: from black.fi.intel.com ([10.237.72.28])
 by fmsmga002.fm.intel.com with ESMTP; 02 Sep 2020 10:31:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
 id 47C0FE1; Wed,  2 Sep 2020 20:31:06 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>, x86@kernel.org,
 Robin Murphy <robin.murphy@arm.com>, Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2 2/3] swiotlb: Declare swiotlb_late_init_with_default_size()
 in header
Date: Wed,  2 Sep 2020 20:31:04 +0300
Message-Id: <20200902173105.38293-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200902173105.38293-1-andriy.shevchenko@linux.intel.com>
References: <20200902173105.38293-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

Q29tcGlsZXIgaXMgbm90IGhhcHB5IGFib3V0IG9uZSBmdW5jdGlvbiBwcm90b3R5cGU6CgogIEND
ICAgICAga2VybmVsL2RtYS9zd2lvdGxiLm8KICBrZXJuZWwvZG1hL3N3aW90bGIuYzoyNzU6MTog
d2FybmluZzogbm8gcHJldmlvdXMgcHJvdG90eXBlIGZvciDigJhzd2lvdGxiX2xhdGVfaW5pdF93
aXRoX2RlZmF1bHRfc2l6ZeKAmSBbLVdtaXNzaW5nLXByb3RvdHlwZXNdCiAgMjc1IHwgc3dpb3Rs
Yl9sYXRlX2luaXRfd2l0aF9kZWZhdWx0X3NpemUoc2l6ZV90IGRlZmF1bHRfc2l6ZSkKICAgICAg
fCBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fgoKU2luY2UgaXQncyB1c2VkIG91
dHNpZGUgb2YgdGhlIG1vZHVsZSwgbW92ZSBpdHMgZGVjbGFyYXRpb24gdG8gdGhlIGhlYWRlcgpm
cm9tIHRoZSB1c2VyLgoKU2lnbmVkLW9mZi1ieTogQW5keSBTaGV2Y2hlbmtvIDxhbmRyaXkuc2hl
dmNoZW5rb0BsaW51eC5pbnRlbC5jb20+Ci0tLQp2Mjogbm8gY2hhbmdlCiBhcmNoL3g4Ni9wY2kv
c3RhMngxMS1maXh1cC5jIHwgMSAtCiBpbmNsdWRlL2xpbnV4L3N3aW90bGIuaCAgICAgIHwgMSAr
CiAyIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0t
Z2l0IGEvYXJjaC94ODYvcGNpL3N0YTJ4MTEtZml4dXAuYyBiL2FyY2gveDg2L3BjaS9zdGEyeDEx
LWZpeHVwLmMKaW5kZXggYzMxM2Q3ODRlZmFiLi4xMWMwZTgwYjllZDQgMTAwNjQ0Ci0tLSBhL2Fy
Y2gveDg2L3BjaS9zdGEyeDExLWZpeHVwLmMKKysrIGIvYXJjaC94ODYvcGNpL3N0YTJ4MTEtZml4
dXAuYwpAQCAtMTUsNyArMTUsNiBAQAogI2luY2x1ZGUgPGFzbS9pb21tdS5oPgogCiAjZGVmaW5l
IFNUQTJYMTFfU1dJT1RMQl9TSVpFICg0KjEwMjQqMTAyNCkKLWV4dGVybiBpbnQgc3dpb3RsYl9s
YXRlX2luaXRfd2l0aF9kZWZhdWx0X3NpemUoc2l6ZV90IGRlZmF1bHRfc2l6ZSk7CiAKIC8qCiAg
KiBXZSBidWlsZCBhIGxpc3Qgb2YgYnVzIG51bWJlcnMgdGhhdCBhcmUgdW5kZXIgdGhlIENvbm5l
WHQuIFRoZQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zd2lvdGxiLmggYi9pbmNsdWRlL2xp
bnV4L3N3aW90bGIuaAppbmRleCAwNDZiYjk0YmQ0ZDYuLjUxMzkxM2ZmNzQ4NiAxMDA2NDQKLS0t
IGEvaW5jbHVkZS9saW51eC9zd2lvdGxiLmgKKysrIGIvaW5jbHVkZS9saW51eC9zd2lvdGxiLmgK
QEAgLTM0LDYgKzM0LDcgQEAgaW50IHN3aW90bGJfaW5pdF93aXRoX3RibChjaGFyICp0bGIsIHVu
c2lnbmVkIGxvbmcgbnNsYWJzLCBpbnQgdmVyYm9zZSk7CiBleHRlcm4gdW5zaWduZWQgbG9uZyBz
d2lvdGxiX25yX3RibCh2b2lkKTsKIHVuc2lnbmVkIGxvbmcgc3dpb3RsYl9zaXplX29yX2RlZmF1
bHQodm9pZCk7CiBleHRlcm4gaW50IHN3aW90bGJfbGF0ZV9pbml0X3dpdGhfdGJsKGNoYXIgKnRs
YiwgdW5zaWduZWQgbG9uZyBuc2xhYnMpOworZXh0ZXJuIGludCBzd2lvdGxiX2xhdGVfaW5pdF93
aXRoX2RlZmF1bHRfc2l6ZShzaXplX3QgZGVmYXVsdF9zaXplKTsKIGV4dGVybiB2b2lkIF9faW5p
dCBzd2lvdGxiX3VwZGF0ZV9tZW1fYXR0cmlidXRlcyh2b2lkKTsKIAogLyoKLS0gCjIuMjguMAoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFp
bGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
