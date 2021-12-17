Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70340C433F5
	for <iommu@archiver.kernel.org>; Fri, 17 Dec 2021 08:38:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1DB5A83EBD;
	Fri, 17 Dec 2021 08:38:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cLPQULcstfwm; Fri, 17 Dec 2021 08:38:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 13BED83F91;
	Fri, 17 Dec 2021 08:38:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E483AC002F;
	Fri, 17 Dec 2021 08:38:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D7140C0012
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 08:38:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B7B5584B4C
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 08:38:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KSB-7uJWSC0j for <iommu@lists.linux-foundation.org>;
 Fri, 17 Dec 2021 08:38:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F389383EF6
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 08:38:48 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="325999638"
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; d="scan'208";a="325999638"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2021 00:38:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; d="scan'208";a="662786063"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 17 Dec 2021 00:38:45 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 3/4] iommu/vt-d: Remove unused dma_to_mm_pfn function
Date: Fri, 17 Dec 2021 16:38:16 +0800
Message-Id: <20211217083817.1745419-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211217083817.1745419-1-baolu.lu@linux.intel.com>
References: <20211217083817.1745419-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>, Kees Cook <keescook@chromium.org>,
 Yury Norov <yury.norov@gmail.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <maira.canal@usp.br>,
 Nick Desaulniers <ndesaulniers@google.com>, iommu@lists.linux-foundation.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
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

RnJvbTogTWHDrXJhIENhbmFsIDxtYWlyYS5jYW5hbEB1c3AuYnI+CgpSZW1vdmUgZG1hX3RvX2J1
Zl9wZm4gZnVuY3Rpb24sIHdoaWNoIGlzIG5vdCB1c2VkIGluIHRoZSBjb2RlYmFzZS4KClRoaXMg
d2FzIHBvaW50ZWQgYnkgY2xhbmcgd2l0aCB0aGUgZm9sbG93aW5nIHdhcm5pbmc6Cgpkcml2ZXJz
L2lvbW11L2ludGVsL2lvbW11LmM6MTM2OjI5OiB3YXJuaW5nOiB1bnVzZWQgZnVuY3Rpb24KJ2Rt
YV90b19tbV9wZm4nIFstV3VudXNlZC1mdW5jdGlvbl0Kc3RhdGljIGlubGluZSB1bnNpZ25lZCBs
b25nIGRtYV90b19tbV9wZm4odW5zaWduZWQgbG9uZyBkbWFfcGZuKQogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgXgpTaWduZWQtb2ZmLWJ5OiBNYcOtcmEgQ2FuYWwgPG1haXJhLmNhbmFsQHVz
cC5icj4KUmV2aWV3ZWQtYnk6IE5pY2sgRGVzYXVsbmllcnMgPG5kZXNhdWxuaWVyc0Bnb29nbGUu
Y29tPgpodHRwczovL2xvcmUua2VybmVsLm9yZy9yL1lZaFk3R3FscmNUWmx6dUFAZmVkb3JhClNp
Z25lZC1vZmYtYnk6IEx1IEJhb2x1IDxiYW9sdS5sdUBsaW51eC5pbnRlbC5jb20+Ci0tLQogZHJp
dmVycy9pb21tdS9pbnRlbC9pb21tdS5jIHwgNSAtLS0tLQogMSBmaWxlIGNoYW5nZWQsIDUgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5jIGIvZHJp
dmVycy9pb21tdS9pbnRlbC9pb21tdS5jCmluZGV4IGU1OTg5NWFmOTUyYy4uNzNhZDQ1NzhkZTI1
IDEwMDY0NAotLS0gYS9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMKKysrIGIvZHJpdmVycy9p
b21tdS9pbnRlbC9pb21tdS5jCkBAIC0xMzMsMTEgKzEzMyw2IEBAIHN0YXRpYyBpbmxpbmUgdW5z
aWduZWQgbG9uZyBsdmxfdG9fbnJfcGFnZXModW5zaWduZWQgaW50IGx2bCkKIAogLyogVlQtZCBw
YWdlcyBtdXN0IGFsd2F5cyBiZSBfc21hbGxlcl8gdGhhbiBNTSBwYWdlcy4gT3RoZXJ3aXNlIHRo
aW5ncwogICAgYXJlIG5ldmVyIGdvaW5nIHRvIHdvcmsuICovCi1zdGF0aWMgaW5saW5lIHVuc2ln
bmVkIGxvbmcgZG1hX3RvX21tX3Bmbih1bnNpZ25lZCBsb25nIGRtYV9wZm4pCi17Ci0JcmV0dXJu
IGRtYV9wZm4gPj4gKFBBR0VfU0hJRlQgLSBWVERfUEFHRV9TSElGVCk7Ci19Ci0KIHN0YXRpYyBp
bmxpbmUgdW5zaWduZWQgbG9uZyBtbV90b19kbWFfcGZuKHVuc2lnbmVkIGxvbmcgbW1fcGZuKQog
ewogCXJldHVybiBtbV9wZm4gPDwgKFBBR0VfU0hJRlQgLSBWVERfUEFHRV9TSElGVCk7Ci0tIAoy
LjI1LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlv
bW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
