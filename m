Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C5C4C43219
	for <iommu@archiver.kernel.org>; Thu,  7 Apr 2022 16:22:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B8D2F40CD9;
	Thu,  7 Apr 2022 16:22:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C72T28Auizep; Thu,  7 Apr 2022 16:22:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6962B40CDF;
	Thu,  7 Apr 2022 16:22:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4FDC4C0088;
	Thu,  7 Apr 2022 16:22:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38DDFC0012
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 16:22:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AAF906129F
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 16:21:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=deltatee.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9Pwk3XB5YBrp for <iommu@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 16:21:57 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 04659612AA
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 16:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Cc:To:From:content-disposition;
 bh=mtQBRhKAuvCwGThlB7Jvwgfm5H5uDyU50loVdVNL23w=; b=eC0x024KGX2rizqrbDnRF7QGyP
 PTIJi8ULjZM2NXbDyn9j+NJs/zw63bx1ap5MQwjrB8SuWYrwDYBn9La6Oes+pW2AaOjw3/K9Lc8XA
 ZnUQ2OSWD6EeOVFFNPXWpXstaMgK1osRSprUbKhFO0EjDvhPm4roSjuSNUas7JiMaVOHpyy9+sXln
 wNH0T/9JHodD64cmpmnDuPPFnHpH9PesdwUFhcA4x7fg5iGBbNGo93rxEfBbu6fhYXQSj/nkoUwrJ
 vD9FP0FpxHOCq/FFoSdIboDvZRIr965ebPkVXhgGi1+fCSSGU9pBN5SF56ZkuAc7AqLCefsx1ysqm
 rAuK+wGg==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <gunthorp@deltatee.com>)
 id 1ncUMH-002BBf-KW; Thu, 07 Apr 2022 09:47:42 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim
 4.94.2) (envelope-from <gunthorp@deltatee.com>)
 id 1ncUMB-00021H-Ak; Thu, 07 Apr 2022 09:47:35 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Date: Thu,  7 Apr 2022 09:46:57 -0600
Message-Id: <20220407154717.7695-2-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220407154717.7695-1-logang@deltatee.com>
References: <20220407154717.7695-1-logang@deltatee.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de,
 jgg@ziepe.ca, christian.koenig@amd.com, ddutile@redhat.com,
 willy@infradead.org, daniel.vetter@ffwll.ch, jason@jlekstrand.net,
 dave.hansen@linux.intel.com, helgaas@kernel.org, dan.j.williams@intel.com,
 andrzej.jakowski@intel.com, dave.b.minturn@intel.com, jianxin.xiong@intel.com,
 ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com,
 ckulkarnilinux@gmail.com, logang@deltatee.com, jhubbard@nvidia.com,
 rcampbell@nvidia.com, kch@nvidia.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v6 01/21] lib/scatterlist: add flag for indicating P2PDMA
 segments in an SGL
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dave Hansen <dave.hansen@linux.intel.com>, Stephen Bates <sbates@raithlin.com>,
 Jason Ekstrand <jason@jlekstrand.net>, Ira Weiny <ira.weiny@intel.com>,
 Christoph Hellwig <hch@lst.de>, Minturn Dave B <dave.b.minturn@intel.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Ralph Campbell <rcampbell@nvidia.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, Logan Gunthorpe <logang@deltatee.com>,
 Robin Murphy <robin.murphy@arm.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
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
dCBpcyBtYXJrZWQgYXMgYSBidXMgYWRkcmVzcy4KClRoZSBuZXcgYml0IHdpbGwgb25seSBiZSB1
c2VkIHdoZW4gQ09ORklHX1BDSV9QMlBETUEgaXMgc2V0OyB0aGlzIG1lYW5zClBDSSBQMlBETUEg
d2lsbCByZXF1aXJlIENPTkZJR182NEJJVC4gVGhpcyBzaG91bGQgYmUgYWNjZXB0YWJsZSBhcyB0
aGUKbWFqb3JpdHkgb2YgUDJQRE1BIHVzZSBjYXNlcyBhcmUgcmVzdHJpY3RlZCB0byBuZXdlciBy
b290IGNvbXBsZXhlcyBhbmQKcm91Z2hseSByZXF1aXJlIHRoZSBleHRyYSBhZGRyZXNzIHNwYWNl
IGZvciBtZW1vcnkgQkFScyB1c2VkIGluIHRoZQp0cmFuc2FjdGlvbnMuCgpTaWduZWQtb2ZmLWJ5
OiBMb2dhbiBHdW50aG9ycGUgPGxvZ2FuZ0BkZWx0YXRlZS5jb20+ClJldmlld2VkLWJ5OiBDaGFp
dGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPgotLS0KIGRyaXZlcnMvcGNpL0tjb25maWcg
ICAgICAgICB8ICA1ICsrKysrCiBpbmNsdWRlL2xpbnV4L3NjYXR0ZXJsaXN0LmggfCA0NCArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystCiAyIGZpbGVzIGNoYW5nZWQsIDQ4IGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9LY29u
ZmlnIGIvZHJpdmVycy9wY2kvS2NvbmZpZwppbmRleCAxMzNjNzMyMDc3ODIuLjVjYzdjYmExOTQx
ZiAxMDA2NDQKLS0tIGEvZHJpdmVycy9wY2kvS2NvbmZpZworKysgYi9kcml2ZXJzL3BjaS9LY29u
ZmlnCkBAIC0xNjQsNiArMTY0LDExIEBAIGNvbmZpZyBQQ0lfUEFTSUQKIGNvbmZpZyBQQ0lfUDJQ
RE1BCiAJYm9vbCAiUENJIHBlZXItdG8tcGVlciB0cmFuc2ZlciBzdXBwb3J0IgogCWRlcGVuZHMg
b24gWk9ORV9ERVZJQ0UKKwkjCisJIyBUaGUgbmVlZCBmb3IgdGhlIHNjYXR0ZXJsaXN0IERNQSBi
dXMgYWRkcmVzcyBmbGFnIG1lYW5zIFBDSSBQMlBETUEKKwkjIHJlcXVpcmVzIDY0Yml0CisJIwor
CWRlcGVuZHMgb24gNjRCSVQKIAlzZWxlY3QgR0VORVJJQ19BTExPQ0FUT1IKIAloZWxwCiAJICBF
bmFibGXRlSBkcml2ZXJzIHRvIGRvIFBDSSBwZWVyLXRvLXBlZXIgdHJhbnNhY3Rpb25zIHRvIGFu
ZCBmcm9tCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3NjYXR0ZXJsaXN0LmggYi9pbmNsdWRl
L2xpbnV4L3NjYXR0ZXJsaXN0LmgKaW5kZXggN2ZmOWQ2Mzg2YzEyLi42NTYxY2E4YWVhZDggMTAw
NjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvc2NhdHRlcmxpc3QuaAorKysgYi9pbmNsdWRlL2xpbnV4
L3NjYXR0ZXJsaXN0LmgKQEAgLTY0LDEyICs2NCwyNCBAQCBzdHJ1Y3Qgc2dfYXBwZW5kX3RhYmxl
IHsKICNkZWZpbmUgU0dfQ0hBSU4JMHgwMVVMCiAjZGVmaW5lIFNHX0VORAkJMHgwMlVMCiAKKy8q
CisgKiBiaXQgMiBpcyB0aGUgdGhpcmQgZnJlZSBiaXQgaW4gdGhlIHBhZ2VfbGluayBvbiA2NGJp
dCBzeXN0ZW1zIHdoaWNoCisgKiBpcyB1c2VkIGJ5IGRtYV91bm1hcF9zZygpIHRvIGRldGVybWlu
ZSBpZiB0aGUgZG1hX2FkZHJlc3MgaXMgYQorICogYnVzIGFkZHJlc3Mgd2hlbiBkb2luZyBQMlBE
TUEuCisgKi8KKyNpZmRlZiBDT05GSUdfUENJX1AyUERNQQorI2RlZmluZSBTR19ETUFfQlVTX0FE
RFJFU1MJMHgwNFVMCitzdGF0aWNfYXNzZXJ0KF9fYWxpZ25vZl9fKHN0cnVjdCBwYWdlKSA+PSA4
KTsKKyNlbHNlCisjZGVmaW5lIFNHX0RNQV9CVVNfQUREUkVTUwkweDAwVUwKKyNlbmRpZgorCiAv
KgogICogV2Ugb3ZlcmxvYWQgdGhlIExTQiBvZiB0aGUgcGFnZSBwb2ludGVyIHRvIGluZGljYXRl
IHdoZXRoZXIgaXQncwogICogYSB2YWxpZCBzZyBlbnRyeSwgb3Igd2hldGhlciBpdCBwb2ludHMg
dG8gdGhlIHN0YXJ0IG9mIGEgbmV3IHNjYXR0ZXJsaXN0LgogICogVGhvc2UgbG93IGJpdHMgYXJl
IHRoZXJlIGZvciBldmVyeW9uZSEgKHRoYW5rcyBtYXNvbiA6LSkKICAqLwotI2RlZmluZSBTR19Q
QUdFX0xJTktfTUFTSyAoU0dfQ0hBSU4gfCBTR19FTkQpCisjZGVmaW5lIFNHX1BBR0VfTElOS19N
QVNLIChTR19DSEFJTiB8IFNHX0VORCB8IFNHX0RNQV9CVVNfQUREUkVTUykKIAogc3RhdGljIGlu
bGluZSB1bnNpZ25lZCBpbnQgX19zZ19mbGFncyhzdHJ1Y3Qgc2NhdHRlcmxpc3QgKnNnKQogewpA
QCAtOTEsNiArMTAzLDExIEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBzZ19pc19sYXN0KHN0cnVjdCBz
Y2F0dGVybGlzdCAqc2cpCiAJcmV0dXJuIF9fc2dfZmxhZ3Moc2cpICYgU0dfRU5EOwogfQogCitz
dGF0aWMgaW5saW5lIGJvb2wgc2dfaXNfZG1hX2J1c19hZGRyZXNzKHN0cnVjdCBzY2F0dGVybGlz
dCAqc2cpCit7CisJcmV0dXJuIF9fc2dfZmxhZ3Moc2cpICYgU0dfRE1BX0JVU19BRERSRVNTOwor
fQorCiAvKioKICAqIHNnX2Fzc2lnbl9wYWdlIC0gQXNzaWduIGEgZ2l2ZW4gcGFnZSB0byBhbiBT
RyBlbnRyeQogICogQHNnOgkJICAgIFNHIGVudHJ5CkBAIC0yNDUsNiArMjYyLDMxIEBAIHN0YXRp
YyBpbmxpbmUgdm9pZCBzZ191bm1hcmtfZW5kKHN0cnVjdCBzY2F0dGVybGlzdCAqc2cpCiAJc2ct
PnBhZ2VfbGluayAmPSB+U0dfRU5EOwogfQogCisvKioKKyAqIHNnX2RtYV9tYXJrX2J1cyBhZGRy
ZXNzIC0gTWFyayB0aGUgc2NhdHRlcmxpc3QgZW50cnkgYXMgYSBidXMgYWRkcmVzcworICogQHNn
OgkJIFNHIGVudHJ5U2NhdHRlcmxpc3QKKyAqCisgKiBEZXNjcmlwdGlvbjoKKyAqICAgTWFya3Mg
dGhlIHBhc3NlZCBpbiBzZyBlbnRyeSB0byBpbmRpY2F0ZSB0aGF0IHRoZSBkbWFfYWRkcmVzcyBp
cworICogICBhIGJ1cyBhZGRyZXNzIGFuZCBkb2Vzbid0IG5lZWQgdG8gYmUgdW5tYXBwZWQuCisg
KiovCitzdGF0aWMgaW5saW5lIHZvaWQgc2dfZG1hX21hcmtfYnVzX2FkZHJlc3Moc3RydWN0IHNj
YXR0ZXJsaXN0ICpzZykKK3sKKwlzZy0+cGFnZV9saW5rIHw9IFNHX0RNQV9CVVNfQUREUkVTUzsK
K30KKworLyoqCisgKiBzZ191bm1hcmtfcGNpX3AycGRtYSAtIFVubWFyayB0aGUgc2NhdHRlcmxp
c3QgZW50cnkgYXMgYSBidXMgYWRkcmVzcworICogQHNnOgkJIFNHIGVudHJ5U2NhdHRlcmxpc3QK
KyAqCisgKiBEZXNjcmlwdGlvbjoKKyAqICAgQ2xlYXJzIHRoZSBidXMgYWRkcmVzcyBtYXJrLgor
ICoqLworc3RhdGljIGlubGluZSB2b2lkIHNnX2RtYV91bm1hcmtfYnVzX2FkZHJlc3Moc3RydWN0
IHNjYXR0ZXJsaXN0ICpzZykKK3sKKwlzZy0+cGFnZV9saW5rICY9IH5TR19ETUFfQlVTX0FERFJF
U1M7Cit9CisKIC8qKgogICogc2dfcGh5cyAtIFJldHVybiBwaHlzaWNhbCBhZGRyZXNzIG9mIGFu
IHNnIGVudHJ5CiAgKiBAc2c6CSAgICAgU0cgZW50cnkKLS0gCjIuMzAuMgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0Cmlv
bW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
