Return-Path: <SRS0=f7gc=B5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1C7C433E1
	for <iommu@archiver.kernel.org>; Wed, 19 Aug 2020 17:13:42 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9590E207FF
	for <iommu@archiver.kernel.org>; Wed, 19 Aug 2020 17:13:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9590E207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2AC9087C76;
	Wed, 19 Aug 2020 17:13:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mOqVRZXkCE8J; Wed, 19 Aug 2020 17:13:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3A83786D88;
	Wed, 19 Aug 2020 17:13:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 02A91C0889;
	Wed, 19 Aug 2020 17:13:39 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EBBEEC0051
 for <iommu@lists.linux-foundation.org>; Wed, 19 Aug 2020 17:13:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id DA4FF2156F
 for <iommu@lists.linux-foundation.org>; Wed, 19 Aug 2020 17:13:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id za8lIgJH2vXB for <iommu@lists.linux-foundation.org>;
 Wed, 19 Aug 2020 17:13:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by silver.osuosl.org (Postfix) with ESMTPS id 064DB2001A
 for <iommu@lists.linux-foundation.org>; Wed, 19 Aug 2020 17:13:35 +0000 (UTC)
IronPort-SDR: zVn0+GApsmca2BUcJS05w0tf+9C3kPTfQ/Zj1FuBwFyWJ4eORnymSYj25Z2TC3fDQ15aVJi8WP
 6hdF5NEh8NIA==
X-IronPort-AV: E=McAfee;i="6000,8403,9718"; a="135227836"
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; d="scan'208";a="135227836"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2020 10:13:35 -0700
IronPort-SDR: CVN9NDYw0XmWDOcyKev6oK59OL/V5IFQ7oin/CXiNZ/wnYKad8JTybW/lnVfqYuMbh3nDZ8mKT
 3AJ6zROpQLEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; d="scan'208";a="279753189"
Received: from black.fi.intel.com ([10.237.72.28])
 by fmsmga008.fm.intel.com with ESMTP; 19 Aug 2020 10:13:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
 id 68A061FD; Wed, 19 Aug 2020 20:13:32 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>, x86@kernel.org,
 Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v1 2/3] swiotlb: Declare swiotlb_late_init_with_default_size()
 in header
Date: Wed, 19 Aug 2020 20:13:25 +0300
Message-Id: <20200819171326.35931-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200819171326.35931-1-andriy.shevchenko@linux.intel.com>
References: <20200819171326.35931-1-andriy.shevchenko@linux.intel.com>
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
dmNoZW5rb0BsaW51eC5pbnRlbC5jb20+Ci0tLQogYXJjaC94ODYvcGNpL3N0YTJ4MTEtZml4dXAu
YyB8IDMgKystCiBpbmNsdWRlL2xpbnV4L3N3aW90bGIuaCAgICAgIHwgMSArCiAyIGZpbGVzIGNo
YW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2FyY2gv
eDg2L3BjaS9zdGEyeDExLWZpeHVwLmMgYi9hcmNoL3g4Ni9wY2kvc3RhMngxMS1maXh1cC5jCmlu
ZGV4IGMzMTNkNzg0ZWZhYi4uNjQzNDdjMzM3MmEwIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9wY2kv
c3RhMngxMS1maXh1cC5jCisrKyBiL2FyY2gveDg2L3BjaS9zdGEyeDExLWZpeHVwLmMKQEAgLTEy
LDEwICsxMiwxMSBAQAogI2luY2x1ZGUgPGxpbnV4L2V4cG9ydC5oPgogI2luY2x1ZGUgPGxpbnV4
L2xpc3QuaD4KICNpbmNsdWRlIDxsaW51eC9kbWEtZGlyZWN0Lmg+CisjaW5jbHVkZSA8bGludXgv
c3dpb3RsYi5oPgorCiAjaW5jbHVkZSA8YXNtL2lvbW11Lmg+CiAKICNkZWZpbmUgU1RBMlgxMV9T
V0lPVExCX1NJWkUgKDQqMTAyNCoxMDI0KQotZXh0ZXJuIGludCBzd2lvdGxiX2xhdGVfaW5pdF93
aXRoX2RlZmF1bHRfc2l6ZShzaXplX3QgZGVmYXVsdF9zaXplKTsKIAogLyoKICAqIFdlIGJ1aWxk
IGEgbGlzdCBvZiBidXMgbnVtYmVycyB0aGF0IGFyZSB1bmRlciB0aGUgQ29ubmVYdC4gVGhlCmRp
ZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3N3aW90bGIuaCBiL2luY2x1ZGUvbGludXgvc3dpb3Rs
Yi5oCmluZGV4IDA0NmJiOTRiZDRkNi4uNTEzOTEzZmY3NDg2IDEwMDY0NAotLS0gYS9pbmNsdWRl
L2xpbnV4L3N3aW90bGIuaAorKysgYi9pbmNsdWRlL2xpbnV4L3N3aW90bGIuaApAQCAtMzQsNiAr
MzQsNyBAQCBpbnQgc3dpb3RsYl9pbml0X3dpdGhfdGJsKGNoYXIgKnRsYiwgdW5zaWduZWQgbG9u
ZyBuc2xhYnMsIGludCB2ZXJib3NlKTsKIGV4dGVybiB1bnNpZ25lZCBsb25nIHN3aW90bGJfbnJf
dGJsKHZvaWQpOwogdW5zaWduZWQgbG9uZyBzd2lvdGxiX3NpemVfb3JfZGVmYXVsdCh2b2lkKTsK
IGV4dGVybiBpbnQgc3dpb3RsYl9sYXRlX2luaXRfd2l0aF90YmwoY2hhciAqdGxiLCB1bnNpZ25l
ZCBsb25nIG5zbGFicyk7CitleHRlcm4gaW50IHN3aW90bGJfbGF0ZV9pbml0X3dpdGhfZGVmYXVs
dF9zaXplKHNpemVfdCBkZWZhdWx0X3NpemUpOwogZXh0ZXJuIHZvaWQgX19pbml0IHN3aW90bGJf
dXBkYXRlX21lbV9hdHRyaWJ1dGVzKHZvaWQpOwogCiAvKgotLSAKMi4yOC4wCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QK
aW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
