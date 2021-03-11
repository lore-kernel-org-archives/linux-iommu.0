Return-Path: <SRS0=X4VR=IJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBADC433E0
	for <iommu@archiver.kernel.org>; Thu, 11 Mar 2021 23:48:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AB4864F7C
	for <iommu@archiver.kernel.org>; Thu, 11 Mar 2021 23:48:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AB4864F7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DFC094639D;
	Thu, 11 Mar 2021 23:48:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ri79Ij0QNq1Q; Thu, 11 Mar 2021 23:48:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5A08340150;
	Thu, 11 Mar 2021 23:48:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44018C000B;
	Thu, 11 Mar 2021 23:48:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D200C0001
 for <iommu@lists.linux-foundation.org>; Thu, 11 Mar 2021 23:48:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5C4A9462D3
 for <iommu@lists.linux-foundation.org>; Thu, 11 Mar 2021 23:48:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id npUEX6HxBOh5 for <iommu@lists.linux-foundation.org>;
 Thu, 11 Mar 2021 23:48:38 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8D93A4616A
 for <iommu@lists.linux-foundation.org>; Thu, 11 Mar 2021 23:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Cc:To:From:content-disposition;
 bh=SoJ7QXcdMSNUWNuLgYtfThq+6IS5T78F0fYqiwZNrwI=; b=QIMuZxlg4vewqu/4hC9UxXtgJ0
 o3uE3b2Nt1fxjOPIpxtlRszTvMXmqezV8xlxuXlUdnBrVDqJJ6ywk6oHVWuB7N6QbwUyvrauZn5tR
 Czn6BJRJ54+4CiKJjqMB+AUUc+4SV8kD13q7+6L1bQgUZdOQyNhmHLnvU4UEMOFa6d0AYVSr/r3OH
 zm7L3fx3qibd57BVLO4u82KL7qds64KW2ceFG8fqLRl4U00vjfuFApPj+bO2wDyf+RKaYb9lcqf4j
 pRS9wveW5+nbQBmQ6dRKJKhwWNECTH0VurPYT1q2Ew+itwn4+g7k33ZjhZ+4NnAfSBX9PK8DH1wrT
 H9so8qRw==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1lKUms-0003ev-BW; Thu, 11 Mar 2021 16:32:15 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1lKUmW-00024Y-E1; Thu, 11 Mar 2021 16:31:52 -0700
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Date: Thu, 11 Mar 2021 16:31:35 -0700
Message-Id: <20210311233142.7900-6-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210311233142.7900-1-logang@deltatee.com>
References: <20210311233142.7900-1-logang@deltatee.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de,
 jgg@ziepe.ca, christian.koenig@amd.com, jhubbard@nvidia.com,
 ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch,
 jason@jlekstrand.net, dave.hansen@linux.intel.com, dan.j.williams@intel.com,
 iweiny@intel.com, andrzej.jakowski@intel.com, dave.b.minturn@intel.com,
 jianxin.xiong@intel.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [RFC PATCH v2 05/11] lib/scatterlist: Add flag for indicating P2PDMA
 segments in an SGL
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: Minturn Dave B <dave.b.minturn@intel.com>,
 John Hubbard <jhubbard@nvidia.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Ira Weiny <iweiny@intel.com>, Matthew Wilcox <willy@infradead.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Logan Gunthorpe <logang@deltatee.com>,
 Jason Ekstrand <jason@jlekstrand.net>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dan Williams <dan.j.williams@intel.com>, Stephen Bates <sbates@raithlin.com>,
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

TWFrZSB1c2Ugb2YgdGhlIHRoaXJkIGZyZWUgTFNCIGluIHNjYXR0ZXJsaXN0J3MgcGFnZV9saW5r
IG9uIDY0Yml0IHN5c3RlbXMuCgpUaGUgZXh0cmEgYml0IHdpbGwgYmUgdXNlZCBieSBkbWFfW3Vu
XW1hcF9zZygpIHRvIGRldGVybWluZSB3aGVuIGEKZ2l2ZW4gU0dMIHNlZ21lbnRzIGRtYV9hZGRy
ZXNzIHBvaW50cyB0byBhIFBDSSBidXMgYWRkcmVzcy4KZG1hX3VubWFwX3NnKCkgd2lsbCBuZWVk
IHRvIHBlcmZvcm0gZGlmZmVyZW50IGNsZWFudXAgd2hlbiB0aGlzIGlzIHRoZQpjYXNlLgoKVXNp
bmcgdGhpcyBiaXQgcmVxdWlyZXMgYWRkaW5nIGFuIGFkZGl0aW9uYWwgZGVwZW5kZW5jeSBvbiBD
T05GSUdfNjRCSVQgdG8KQ09ORklHX1BDSV9QMlBETUEuIFRoaXMgc2hvdWxkIGJlIGFjY2VwdGFi
bGUgYXMgdGhlIG1ham9yaXR5IG9mIFAyUERNQQp1c2UgY2FzZXMgYXJlIHJlc3RyaWN0ZWQgdG8g
bmV3ZXIgcm9vdCBjb21wbGV4ZXMgYW5kIHJvdWdobHkgcmVxdWlyZSB0aGUKZXh0cmEgYWRkcmVz
cyBzcGFjZSBmb3IgbWVtb3J5IEJBUnMgdXNlZCBpbiB0aGUgdHJhbnNhY3Rpb25zLgoKU2lnbmVk
LW9mZi1ieTogTG9nYW4gR3VudGhvcnBlIDxsb2dhbmdAZGVsdGF0ZWUuY29tPgotLS0KIGRyaXZl
cnMvcGNpL0tjb25maWcgICAgICAgICB8ICAyICstCiBpbmNsdWRlL2xpbnV4L3NjYXR0ZXJsaXN0
LmggfCA0OSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tCiAyIGZpbGVzIGNo
YW5nZWQsIDQ2IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9wY2kvS2NvbmZpZyBiL2RyaXZlcnMvcGNpL0tjb25maWcKaW5kZXggMGM0NzNkNzVlNjI1
Li45MGI0YmRkYjMzMDAgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvcGNpL0tjb25maWcKKysrIGIvZHJp
dmVycy9wY2kvS2NvbmZpZwpAQCAtMTYzLDcgKzE2Myw3IEBAIGNvbmZpZyBQQ0lfUEFTSUQKIAog
Y29uZmlnIFBDSV9QMlBETUEKIAlib29sICJQQ0kgcGVlci10by1wZWVyIHRyYW5zZmVyIHN1cHBv
cnQiCi0JZGVwZW5kcyBvbiBaT05FX0RFVklDRQorCWRlcGVuZHMgb24gWk9ORV9ERVZJQ0UgJiYg
NjRCSVQKIAlzZWxlY3QgR0VORVJJQ19BTExPQ0FUT1IKIAloZWxwCiAJICBFbmFibGXRlSBkcml2
ZXJzIHRvIGRvIFBDSSBwZWVyLXRvLXBlZXIgdHJhbnNhY3Rpb25zIHRvIGFuZCBmcm9tCmRpZmYg
LS1naXQgYS9pbmNsdWRlL2xpbnV4L3NjYXR0ZXJsaXN0LmggYi9pbmNsdWRlL2xpbnV4L3NjYXR0
ZXJsaXN0LmgKaW5kZXggNmY3MDU3MmIyOTM4Li41NTI1ZDNlYmYzNmYgMTAwNjQ0Ci0tLSBhL2lu
Y2x1ZGUvbGludXgvc2NhdHRlcmxpc3QuaAorKysgYi9pbmNsdWRlL2xpbnV4L3NjYXR0ZXJsaXN0
LmgKQEAgLTU4LDYgKzU4LDIxIEBAIHN0cnVjdCBzZ190YWJsZSB7CiAjZGVmaW5lIFNHX0NIQUlO
CTB4MDFVTAogI2RlZmluZSBTR19FTkQJCTB4MDJVTAogCisvKgorICogYml0IDIgaXMgdGhlIHRo
aXJkIGZyZWUgYml0IGluIHRoZSBwYWdlX2xpbmsgb24gNjRiaXQgc3lzdGVtcyB3aGljaAorICog
aXMgdXNlZCBieSBkbWFfdW5tYXBfc2coKSB0byBkZXRlcm1pbmUgaWYgdGhlIGRtYV9hZGRyZXNz
IGlzIGEgUENJCisgKiBidXMgYWRkcmVzcyB3aGVuIGRvaW5nIFAyUERNQS4KKyAqIE5vdGU6IENP
TkZJR19QQ0lfUDJQRE1BIGRlcGVuZHMgb24gQ09ORklHXzY0QklUIGJlY2F1c2Ugb2YgdGhpcy4K
KyAqLworCisjaWZkZWYgQ09ORklHX1BDSV9QMlBETUEKKyNkZWZpbmUgU0dfUENJX1AyUERNQQkw
eDA0VUwKKyNlbHNlCisjZGVmaW5lIFNHX1BDSV9QMlBETUEJMHgwMFVMCisjZW5kaWYKKworI2Rl
ZmluZSBTR19QQUdFX0xJTktfTUFTSyAoU0dfQ0hBSU4gfCBTR19FTkQgfCBTR19QQ0lfUDJQRE1B
KQorCiAvKgogICogV2Ugb3ZlcmxvYWQgdGhlIExTQiBvZiB0aGUgcGFnZSBwb2ludGVyIHRvIGlu
ZGljYXRlIHdoZXRoZXIgaXQncwogICogYSB2YWxpZCBzZyBlbnRyeSwgb3Igd2hldGhlciBpdCBw
b2ludHMgdG8gdGhlIHN0YXJ0IG9mIGEgbmV3IHNjYXR0ZXJsaXN0LgpAQCAtNjUsOCArODAsOSBA
QCBzdHJ1Y3Qgc2dfdGFibGUgewogICovCiAjZGVmaW5lIHNnX2lzX2NoYWluKHNnKQkJKChzZykt
PnBhZ2VfbGluayAmIFNHX0NIQUlOKQogI2RlZmluZSBzZ19pc19sYXN0KHNnKQkJKChzZyktPnBh
Z2VfbGluayAmIFNHX0VORCkKKyNkZWZpbmUgc2dfaXNfcGNpX3AycGRtYShzZykJKChzZyktPnBh
Z2VfbGluayAmIFNHX1BDSV9QMlBETUEpCiAjZGVmaW5lIHNnX2NoYWluX3B0cihzZykJXAotCSgo
c3RydWN0IHNjYXR0ZXJsaXN0ICopICgoc2cpLT5wYWdlX2xpbmsgJiB+KFNHX0NIQUlOIHwgU0df
RU5EKSkpCisJKChzdHJ1Y3Qgc2NhdHRlcmxpc3QgKikgKChzZyktPnBhZ2VfbGluayAmIH5TR19Q
QUdFX0xJTktfTUFTSykpCiAKIC8qKgogICogc2dfYXNzaWduX3BhZ2UgLSBBc3NpZ24gYSBnaXZl
biBwYWdlIHRvIGFuIFNHIGVudHJ5CkBAIC04MCwxMyArOTYsMTMgQEAgc3RydWN0IHNnX3RhYmxl
IHsKICAqKi8KIHN0YXRpYyBpbmxpbmUgdm9pZCBzZ19hc3NpZ25fcGFnZShzdHJ1Y3Qgc2NhdHRl
cmxpc3QgKnNnLCBzdHJ1Y3QgcGFnZSAqcGFnZSkKIHsKLQl1bnNpZ25lZCBsb25nIHBhZ2VfbGlu
ayA9IHNnLT5wYWdlX2xpbmsgJiAoU0dfQ0hBSU4gfCBTR19FTkQpOworCXVuc2lnbmVkIGxvbmcg
cGFnZV9saW5rID0gc2ctPnBhZ2VfbGluayAmIFNHX1BBR0VfTElOS19NQVNLOwogCiAJLyoKIAkg
KiBJbiBvcmRlciBmb3IgdGhlIGxvdyBiaXQgc3RlYWxpbmcgYXBwcm9hY2ggdG8gd29yaywgcGFn
ZXMKIAkgKiBtdXN0IGJlIGFsaWduZWQgYXQgYSAzMi1iaXQgYm91bmRhcnkgYXMgYSBtaW5pbXVt
LgogCSAqLwotCUJVR19PTigodW5zaWduZWQgbG9uZykgcGFnZSAmIChTR19DSEFJTiB8IFNHX0VO
RCkpOworCUJVR19PTigodW5zaWduZWQgbG9uZykgcGFnZSAmIFNHX1BBR0VfTElOS19NQVNLKTsK
ICNpZmRlZiBDT05GSUdfREVCVUdfU0cKIAlCVUdfT04oc2dfaXNfY2hhaW4oc2cpKTsKICNlbmRp
ZgpAQCAtMTIwLDcgKzEzNiw3IEBAIHN0YXRpYyBpbmxpbmUgc3RydWN0IHBhZ2UgKnNnX3BhZ2Uo
c3RydWN0IHNjYXR0ZXJsaXN0ICpzZykKICNpZmRlZiBDT05GSUdfREVCVUdfU0cKIAlCVUdfT04o
c2dfaXNfY2hhaW4oc2cpKTsKICNlbmRpZgotCXJldHVybiAoc3RydWN0IHBhZ2UgKikoKHNnKS0+
cGFnZV9saW5rICYgfihTR19DSEFJTiB8IFNHX0VORCkpOworCXJldHVybiAoc3RydWN0IHBhZ2Ug
KikoKHNnKS0+cGFnZV9saW5rICYgflNHX1BBR0VfTElOS19NQVNLKTsKIH0KIAogLyoqCkBAIC0y
MjIsNiArMjM4LDMxIEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBzZ191bm1hcmtfZW5kKHN0cnVjdCBz
Y2F0dGVybGlzdCAqc2cpCiAJc2ctPnBhZ2VfbGluayAmPSB+U0dfRU5EOwogfQogCisvKioKKyAq
IHNnX21hcmtfcGNpX3AycGRtYSAtIE1hcmsgdGhlIHNjYXR0ZXJsaXN0IGVudHJ5IGZvciBQQ0kg
cDJwZG1hCisgKiBAc2c6CQkgU0cgZW50cnlTY2F0dGVybGlzdAorICoKKyAqIERlc2NyaXB0aW9u
OgorICogICBNYXJrcyB0aGUgcGFzc2VkIGluIHNnIGVudHJ5IHRvIGluZGljYXRlIHRoYXQgdGhl
IGRtYV9hZGRyZXNzIGlzCisgKiAgIGEgUENJIGJ1cyBhZGRyZXNzLgorICoqLworc3RhdGljIGlu
bGluZSB2b2lkIHNnX21hcmtfcGNpX3AycGRtYShzdHJ1Y3Qgc2NhdHRlcmxpc3QgKnNnKQorewor
CXNnLT5wYWdlX2xpbmsgfD0gU0dfUENJX1AyUERNQTsKK30KKworLyoqCisgKiBzZ191bm1hcmtf
cGNpX3AycGRtYSAtIFVubWFyayB0aGUgc2NhdHRlcmxpc3QgZW50cnkgZm9yIFBDSSBwMnBkbWEK
KyAqIEBzZzoJCSBTRyBlbnRyeVNjYXR0ZXJsaXN0CisgKgorICogRGVzY3JpcHRpb246CisgKiAg
IENsZWFycyB0aGUgUENJIFAyUERNQSBtYXJrCisgKiovCitzdGF0aWMgaW5saW5lIHZvaWQgc2df
dW5tYXJrX3BjaV9wMnBkbWEoc3RydWN0IHNjYXR0ZXJsaXN0ICpzZykKK3sKKwlzZy0+cGFnZV9s
aW5rICY9IH5TR19QQ0lfUDJQRE1BOworfQorCiAvKioKICAqIHNnX3BoeXMgLSBSZXR1cm4gcGh5
c2ljYWwgYWRkcmVzcyBvZiBhbiBzZyBlbnRyeQogICogQHNnOgkgICAgIFNHIGVudHJ5Ci0tIAoy
LjIwLjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlv
bW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
