Return-Path: <SRS0=d8dU=JF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C012C43600
	for <iommu@archiver.kernel.org>; Thu,  8 Apr 2021 17:01:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F72F6115B
	for <iommu@archiver.kernel.org>; Thu,  8 Apr 2021 17:01:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F72F6115B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F294584D1F;
	Thu,  8 Apr 2021 17:01:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id olbh6YG7HsvB; Thu,  8 Apr 2021 17:01:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id CFEA584D63;
	Thu,  8 Apr 2021 17:01:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9AC20C000A;
	Thu,  8 Apr 2021 17:01:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22523C0018
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 17:01:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 06BA440E61
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 17:01:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=deltatee.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4-yhkIcefUCo for <iommu@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 17:01:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 682D840E66
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 17:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Cc:To:From:content-disposition;
 bh=pIy/hcM3RipH3vmChKhmRErsUYIkx5VaVGpWGhMgMeA=; b=LFhWQMIB3cTAHDrUoTtRJqph2g
 y/FVZw/7RCie2d5/Q7/39RDhhxh87Rkvhas8fgx6hdfwAqQyw4Ghy7b4XAZeJO3C+rCHNwYDZYVd/
 hzF86fXWFtqgzOPLyG/A1G35mWjjkEVgh4YFDVSt5ZTlErObnmieyPlj6Ql9TU0tVhmhzsEeDkSGi
 sIF9MbiVyMc9DyF6hKzKwF91ejOjMpB5fJqFF0/h5y5LfXtTRdlqswjYfWzCyM4N1Ik78t1owm0j+
 zyXiH0FiR4VSlPANDyKS9JnHs6p74/BqQO8qTtVSYkPB9K04P2Shg0SIEnN3zdb+Kv2ps5W9fcQVg
 7QFDVUrA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1lUY2G-0002Li-Td; Thu, 08 Apr 2021 11:01:42 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1lUY25-0002J0-MA; Thu, 08 Apr 2021 11:01:29 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Date: Thu,  8 Apr 2021 11:01:13 -0600
Message-Id: <20210408170123.8788-7-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210408170123.8788-1-logang@deltatee.com>
References: <20210408170123.8788-1-logang@deltatee.com>
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
 logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH 06/16] lib/scatterlist: Add flag for indicating P2PDMA
 segments in an SGL
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: Minturn Dave B <dave.b.minturn@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 John Hubbard <jhubbard@nvidia.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Robin Murphy <robin.murphy@arm.com>, Matthew Wilcox <willy@infradead.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Logan Gunthorpe <logang@deltatee.com>,
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

TWFrZSB1c2Ugb2YgdGhlIHRoaXJkIGZyZWUgTFNCIGluIHNjYXR0ZXJsaXN0J3MgcGFnZV9saW5r
IG9uIDY0Yml0IHN5c3RlbXMuCgpUaGUgZXh0cmEgYml0IHdpbGwgYmUgdXNlZCBieSBkbWFfW3Vu
XW1hcF9zZ19wMnBkbWEoKSB0byBkZXRlcm1pbmUgd2hlbiBhCmdpdmVuIFNHTCBzZWdtZW50cyBk
bWFfYWRkcmVzcyBwb2ludHMgdG8gYSBQQ0kgYnVzIGFkZHJlc3MuCmRtYV91bm1hcF9zZ19wMnBk
bWEoKSB3aWxsIG5lZWQgdG8gcGVyZm9ybSBkaWZmZXJlbnQgY2xlYW51cCB3aGVuIGEKc2VnbWVu
dCBpcyBtYXJrZWQgYXMgUDJQRE1BLgoKVXNpbmcgdGhpcyBiaXQgcmVxdWlyZXMgYWRkaW5nIGFu
IGFkZGl0aW9uYWwgZGVwZW5kZW5jeSBvbiBDT05GSUdfNjRCSVQgdG8KQ09ORklHX1BDSV9QMlBE
TUEuIFRoaXMgc2hvdWxkIGJlIGFjY2VwdGFibGUgYXMgdGhlIG1ham9yaXR5IG9mIFAyUERNQQp1
c2UgY2FzZXMgYXJlIHJlc3RyaWN0ZWQgdG8gbmV3ZXIgcm9vdCBjb21wbGV4ZXMgYW5kIHJvdWdo
bHkgcmVxdWlyZSB0aGUKZXh0cmEgYWRkcmVzcyBzcGFjZSBmb3IgbWVtb3J5IEJBUnMgdXNlZCBp
biB0aGUgdHJhbnNhY3Rpb25zLgoKU2lnbmVkLW9mZi1ieTogTG9nYW4gR3VudGhvcnBlIDxsb2dh
bmdAZGVsdGF0ZWUuY29tPgotLS0KIGRyaXZlcnMvcGNpL0tjb25maWcgICAgICAgICB8ICAyICst
CiBpbmNsdWRlL2xpbnV4L3NjYXR0ZXJsaXN0LmggfCA0OSArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrLS0tCiAyIGZpbGVzIGNoYW5nZWQsIDQ2IGluc2VydGlvbnMoKyksIDUgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvS2NvbmZpZyBiL2RyaXZlcnMvcGNp
L0tjb25maWcKaW5kZXggMGM0NzNkNzVlNjI1Li45MGI0YmRkYjMzMDAgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvcGNpL0tjb25maWcKKysrIGIvZHJpdmVycy9wY2kvS2NvbmZpZwpAQCAtMTYzLDcgKzE2
Myw3IEBAIGNvbmZpZyBQQ0lfUEFTSUQKIAogY29uZmlnIFBDSV9QMlBETUEKIAlib29sICJQQ0kg
cGVlci10by1wZWVyIHRyYW5zZmVyIHN1cHBvcnQiCi0JZGVwZW5kcyBvbiBaT05FX0RFVklDRQor
CWRlcGVuZHMgb24gWk9ORV9ERVZJQ0UgJiYgNjRCSVQKIAlzZWxlY3QgR0VORVJJQ19BTExPQ0FU
T1IKIAloZWxwCiAJICBFbmFibGXRlSBkcml2ZXJzIHRvIGRvIFBDSSBwZWVyLXRvLXBlZXIgdHJh
bnNhY3Rpb25zIHRvIGFuZCBmcm9tCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3NjYXR0ZXJs
aXN0LmggYi9pbmNsdWRlL2xpbnV4L3NjYXR0ZXJsaXN0LmgKaW5kZXggNmY3MDU3MmIyOTM4Li41
NTI1ZDNlYmYzNmYgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvc2NhdHRlcmxpc3QuaAorKysg
Yi9pbmNsdWRlL2xpbnV4L3NjYXR0ZXJsaXN0LmgKQEAgLTU4LDYgKzU4LDIxIEBAIHN0cnVjdCBz
Z190YWJsZSB7CiAjZGVmaW5lIFNHX0NIQUlOCTB4MDFVTAogI2RlZmluZSBTR19FTkQJCTB4MDJV
TAogCisvKgorICogYml0IDIgaXMgdGhlIHRoaXJkIGZyZWUgYml0IGluIHRoZSBwYWdlX2xpbmsg
b24gNjRiaXQgc3lzdGVtcyB3aGljaAorICogaXMgdXNlZCBieSBkbWFfdW5tYXBfc2coKSB0byBk
ZXRlcm1pbmUgaWYgdGhlIGRtYV9hZGRyZXNzIGlzIGEgUENJCisgKiBidXMgYWRkcmVzcyB3aGVu
IGRvaW5nIFAyUERNQS4KKyAqIE5vdGU6IENPTkZJR19QQ0lfUDJQRE1BIGRlcGVuZHMgb24gQ09O
RklHXzY0QklUIGJlY2F1c2Ugb2YgdGhpcy4KKyAqLworCisjaWZkZWYgQ09ORklHX1BDSV9QMlBE
TUEKKyNkZWZpbmUgU0dfUENJX1AyUERNQQkweDA0VUwKKyNlbHNlCisjZGVmaW5lIFNHX1BDSV9Q
MlBETUEJMHgwMFVMCisjZW5kaWYKKworI2RlZmluZSBTR19QQUdFX0xJTktfTUFTSyAoU0dfQ0hB
SU4gfCBTR19FTkQgfCBTR19QQ0lfUDJQRE1BKQorCiAvKgogICogV2Ugb3ZlcmxvYWQgdGhlIExT
QiBvZiB0aGUgcGFnZSBwb2ludGVyIHRvIGluZGljYXRlIHdoZXRoZXIgaXQncwogICogYSB2YWxp
ZCBzZyBlbnRyeSwgb3Igd2hldGhlciBpdCBwb2ludHMgdG8gdGhlIHN0YXJ0IG9mIGEgbmV3IHNj
YXR0ZXJsaXN0LgpAQCAtNjUsOCArODAsOSBAQCBzdHJ1Y3Qgc2dfdGFibGUgewogICovCiAjZGVm
aW5lIHNnX2lzX2NoYWluKHNnKQkJKChzZyktPnBhZ2VfbGluayAmIFNHX0NIQUlOKQogI2RlZmlu
ZSBzZ19pc19sYXN0KHNnKQkJKChzZyktPnBhZ2VfbGluayAmIFNHX0VORCkKKyNkZWZpbmUgc2df
aXNfcGNpX3AycGRtYShzZykJKChzZyktPnBhZ2VfbGluayAmIFNHX1BDSV9QMlBETUEpCiAjZGVm
aW5lIHNnX2NoYWluX3B0cihzZykJXAotCSgoc3RydWN0IHNjYXR0ZXJsaXN0ICopICgoc2cpLT5w
YWdlX2xpbmsgJiB+KFNHX0NIQUlOIHwgU0dfRU5EKSkpCisJKChzdHJ1Y3Qgc2NhdHRlcmxpc3Qg
KikgKChzZyktPnBhZ2VfbGluayAmIH5TR19QQUdFX0xJTktfTUFTSykpCiAKIC8qKgogICogc2df
YXNzaWduX3BhZ2UgLSBBc3NpZ24gYSBnaXZlbiBwYWdlIHRvIGFuIFNHIGVudHJ5CkBAIC04MCwx
MyArOTYsMTMgQEAgc3RydWN0IHNnX3RhYmxlIHsKICAqKi8KIHN0YXRpYyBpbmxpbmUgdm9pZCBz
Z19hc3NpZ25fcGFnZShzdHJ1Y3Qgc2NhdHRlcmxpc3QgKnNnLCBzdHJ1Y3QgcGFnZSAqcGFnZSkK
IHsKLQl1bnNpZ25lZCBsb25nIHBhZ2VfbGluayA9IHNnLT5wYWdlX2xpbmsgJiAoU0dfQ0hBSU4g
fCBTR19FTkQpOworCXVuc2lnbmVkIGxvbmcgcGFnZV9saW5rID0gc2ctPnBhZ2VfbGluayAmIFNH
X1BBR0VfTElOS19NQVNLOwogCiAJLyoKIAkgKiBJbiBvcmRlciBmb3IgdGhlIGxvdyBiaXQgc3Rl
YWxpbmcgYXBwcm9hY2ggdG8gd29yaywgcGFnZXMKIAkgKiBtdXN0IGJlIGFsaWduZWQgYXQgYSAz
Mi1iaXQgYm91bmRhcnkgYXMgYSBtaW5pbXVtLgogCSAqLwotCUJVR19PTigodW5zaWduZWQgbG9u
ZykgcGFnZSAmIChTR19DSEFJTiB8IFNHX0VORCkpOworCUJVR19PTigodW5zaWduZWQgbG9uZykg
cGFnZSAmIFNHX1BBR0VfTElOS19NQVNLKTsKICNpZmRlZiBDT05GSUdfREVCVUdfU0cKIAlCVUdf
T04oc2dfaXNfY2hhaW4oc2cpKTsKICNlbmRpZgpAQCAtMTIwLDcgKzEzNiw3IEBAIHN0YXRpYyBp
bmxpbmUgc3RydWN0IHBhZ2UgKnNnX3BhZ2Uoc3RydWN0IHNjYXR0ZXJsaXN0ICpzZykKICNpZmRl
ZiBDT05GSUdfREVCVUdfU0cKIAlCVUdfT04oc2dfaXNfY2hhaW4oc2cpKTsKICNlbmRpZgotCXJl
dHVybiAoc3RydWN0IHBhZ2UgKikoKHNnKS0+cGFnZV9saW5rICYgfihTR19DSEFJTiB8IFNHX0VO
RCkpOworCXJldHVybiAoc3RydWN0IHBhZ2UgKikoKHNnKS0+cGFnZV9saW5rICYgflNHX1BBR0Vf
TElOS19NQVNLKTsKIH0KIAogLyoqCkBAIC0yMjIsNiArMjM4LDMxIEBAIHN0YXRpYyBpbmxpbmUg
dm9pZCBzZ191bm1hcmtfZW5kKHN0cnVjdCBzY2F0dGVybGlzdCAqc2cpCiAJc2ctPnBhZ2VfbGlu
ayAmPSB+U0dfRU5EOwogfQogCisvKioKKyAqIHNnX21hcmtfcGNpX3AycGRtYSAtIE1hcmsgdGhl
IHNjYXR0ZXJsaXN0IGVudHJ5IGZvciBQQ0kgcDJwZG1hCisgKiBAc2c6CQkgU0cgZW50cnlTY2F0
dGVybGlzdAorICoKKyAqIERlc2NyaXB0aW9uOgorICogICBNYXJrcyB0aGUgcGFzc2VkIGluIHNn
IGVudHJ5IHRvIGluZGljYXRlIHRoYXQgdGhlIGRtYV9hZGRyZXNzIGlzCisgKiAgIGEgUENJIGJ1
cyBhZGRyZXNzLgorICoqLworc3RhdGljIGlubGluZSB2b2lkIHNnX21hcmtfcGNpX3AycGRtYShz
dHJ1Y3Qgc2NhdHRlcmxpc3QgKnNnKQoreworCXNnLT5wYWdlX2xpbmsgfD0gU0dfUENJX1AyUERN
QTsKK30KKworLyoqCisgKiBzZ191bm1hcmtfcGNpX3AycGRtYSAtIFVubWFyayB0aGUgc2NhdHRl
cmxpc3QgZW50cnkgZm9yIFBDSSBwMnBkbWEKKyAqIEBzZzoJCSBTRyBlbnRyeVNjYXR0ZXJsaXN0
CisgKgorICogRGVzY3JpcHRpb246CisgKiAgIENsZWFycyB0aGUgUENJIFAyUERNQSBtYXJrCisg
KiovCitzdGF0aWMgaW5saW5lIHZvaWQgc2dfdW5tYXJrX3BjaV9wMnBkbWEoc3RydWN0IHNjYXR0
ZXJsaXN0ICpzZykKK3sKKwlzZy0+cGFnZV9saW5rICY9IH5TR19QQ0lfUDJQRE1BOworfQorCiAv
KioKICAqIHNnX3BoeXMgLSBSZXR1cm4gcGh5c2ljYWwgYWRkcmVzcyBvZiBhbiBzZyBlbnRyeQog
ICogQHNnOgkgICAgIFNHIGVudHJ5Ci0tIAoyLjIwLjEKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby9pb21tdQ==
