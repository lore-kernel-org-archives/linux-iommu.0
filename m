Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FAF3C3527D
	for <iommu@archiver.kernel.org>; Fri, 28 Jan 2022 00:26:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C8E6C404DB;
	Fri, 28 Jan 2022 00:26:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qtZfDapDbI3F; Fri, 28 Jan 2022 00:26:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3EAB440594;
	Fri, 28 Jan 2022 00:26:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3D142C0080;
	Fri, 28 Jan 2022 00:26:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2F82BC0039
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 00:26:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0C13484E03
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 00:26:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=deltatee.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I5CN7hLI-wZ5 for <iommu@lists.linux-foundation.org>;
 Fri, 28 Jan 2022 00:26:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BFAFE84DFB
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 00:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Cc:To:From:content-disposition;
 bh=rs0zdLb19gC/hi9gcePRI1HlpCpDH9cKr/rV+O/g6PI=; b=BqqxQzy6I+a6VISPJzx9XqEL9k
 OP7HDA2YovJANZLSQ7Z4l/US+dxVgLkCa1dQQeu3MorRsjxynTmtGjQ+FWTR/w9EtwT+sW087npWh
 RpeKkJGFVw0CcB7A8t++0OeVZaCisfZQ6XfWk9NiBLaGP3aUtBLMp4CQrnvredRgsIgP4DWQMIOjN
 b/f49PK9y6KBoGB36zSvStK9i1ho40q4bBxV65AzIK8GfZ5ftCI5Il/FNIsgj9WJdsjg4lK5Kl3ee
 KeFEkjYMxkz8zvkGXIn4EqwCUotBUKsZWjOo2psRUDI+OfTVcJANPDDUt5de7J+FW8LquV1P0IGS9
 c8eNbSpg==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <gunthorp@deltatee.com>)
 id 1nDF5p-005OcZ-LW; Thu, 27 Jan 2022 17:26:23 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim
 4.94.2) (envelope-from <gunthorp@deltatee.com>)
 id 1nDF5m-0001cI-IR; Thu, 27 Jan 2022 17:26:18 -0700
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Date: Thu, 27 Jan 2022 17:25:53 -0700
Message-Id: <20220128002614.6136-4-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220128002614.6136-1-logang@deltatee.com>
References: <20220128002614.6136-1-logang@deltatee.com>
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
Subject: [PATCH v5 03/24] lib/scatterlist: add flag for indicating P2PDMA
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
dCBpcyBtYXJrZWQgYXMgYSBidXMgYWRkcmVzcy4KCkNyZWF0ZSBhIENPTkZJR19ORUVEX1NHX0RN
QV9CVVNfQUREUl9GTEFHIGJvb2wgd2hpY2ggZGVwZW5kcyBvbgpDT05GSUdfNjRCSVQgKHNvIHRo
ZXJlIGlzIHNwYWNlIGluIHRoZSBwYWdlIGxpbmsgZm9yIHRoZSBuZXcgZmxhZykuCkNPTkZJR19Q
Q0lfUDJQRE1BIHdpbGwgdGhlbiBkZXBlbmQgb24gdGhpcyBzbyB0aGlzIG1lYW5zIFBDSSBQMlBE
TUEgd2lsbApyZXF1aXJlIENPTkZJR182NEJJVC4gVGhpcyBzaG91bGQgYmUgYWNjZXB0YWJsZSBh
cyB0aGUgbWFqb3JpdHkgb2YgUDJQRE1BCnVzZSBjYXNlcyBhcmUgcmVzdHJpY3RlZCB0byBuZXdl
ciByb290IGNvbXBsZXhlcyBhbmQgcm91Z2hseSByZXF1aXJlIHRoZQpleHRyYSBhZGRyZXNzIHNw
YWNlIGZvciBtZW1vcnkgQkFScyB1c2VkIGluIHRoZSB0cmFuc2FjdGlvbnMuCgpTaWduZWQtb2Zm
LWJ5OiBMb2dhbiBHdW50aG9ycGUgPGxvZ2FuZ0BkZWx0YXRlZS5jb20+ClJldmlld2VkLWJ5OiBD
aGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPgotLS0KIGRyaXZlcnMvcGNpL0tjb25m
aWcgICAgICAgICB8ICA1ICsrKysrCiBpbmNsdWRlL2xpbnV4L3NjYXR0ZXJsaXN0LmggfCA0NCAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystCiAyIGZpbGVzIGNoYW5nZWQsIDQ4
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9L
Y29uZmlnIGIvZHJpdmVycy9wY2kvS2NvbmZpZwppbmRleCBkOThmYWZkZDBmOTkuLjNlODM3ZDll
MTYwMCAxMDA2NDQKLS0tIGEvZHJpdmVycy9wY2kvS2NvbmZpZworKysgYi9kcml2ZXJzL3BjaS9L
Y29uZmlnCkBAIC0xNjQsNiArMTY0LDExIEBAIGNvbmZpZyBQQ0lfUEFTSUQKIGNvbmZpZyBQQ0lf
UDJQRE1BCiAJYm9vbCAiUENJIHBlZXItdG8tcGVlciB0cmFuc2ZlciBzdXBwb3J0IgogCWRlcGVu
ZHMgb24gWk9ORV9ERVZJQ0UKKwkjCisJIyBUaGUgbmVlZCBmb3IgdGhlIHNjYXR0ZXJsaXN0IERN
QSBidXMgYWRkcmVzcyBmbGFnIG1lYW5zIFBDSSBQMlBETUEKKwkjIHJlcXVpcmVzIDY0Yml0CisJ
IworCWRlcGVuZHMgb24gNjRCSVQKIAlzZWxlY3QgR0VORVJJQ19BTExPQ0FUT1IKIAloZWxwCiAJ
ICBFbmFibGXRlSBkcml2ZXJzIHRvIGRvIFBDSSBwZWVyLXRvLXBlZXIgdHJhbnNhY3Rpb25zIHRv
IGFuZCBmcm9tCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3NjYXR0ZXJsaXN0LmggYi9pbmNs
dWRlL2xpbnV4L3NjYXR0ZXJsaXN0LmgKaW5kZXggN2ZmOWQ2Mzg2YzEyLi42NTYxY2E4YWVhZDgg
MTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvc2NhdHRlcmxpc3QuaAorKysgYi9pbmNsdWRlL2xp
bnV4L3NjYXR0ZXJsaXN0LmgKQEAgLTY0LDEyICs2NCwyNCBAQCBzdHJ1Y3Qgc2dfYXBwZW5kX3Rh
YmxlIHsKICNkZWZpbmUgU0dfQ0hBSU4JMHgwMVVMCiAjZGVmaW5lIFNHX0VORAkJMHgwMlVMCiAK
Ky8qCisgKiBiaXQgMiBpcyB0aGUgdGhpcmQgZnJlZSBiaXQgaW4gdGhlIHBhZ2VfbGluayBvbiA2
NGJpdCBzeXN0ZW1zIHdoaWNoCisgKiBpcyB1c2VkIGJ5IGRtYV91bm1hcF9zZygpIHRvIGRldGVy
bWluZSBpZiB0aGUgZG1hX2FkZHJlc3MgaXMgYQorICogYnVzIGFkZHJlc3Mgd2hlbiBkb2luZyBQ
MlBETUEuCisgKi8KKyNpZmRlZiBDT05GSUdfUENJX1AyUERNQQorI2RlZmluZSBTR19ETUFfQlVT
X0FERFJFU1MJMHgwNFVMCitzdGF0aWNfYXNzZXJ0KF9fYWxpZ25vZl9fKHN0cnVjdCBwYWdlKSA+
PSA4KTsKKyNlbHNlCisjZGVmaW5lIFNHX0RNQV9CVVNfQUREUkVTUwkweDAwVUwKKyNlbmRpZgor
CiAvKgogICogV2Ugb3ZlcmxvYWQgdGhlIExTQiBvZiB0aGUgcGFnZSBwb2ludGVyIHRvIGluZGlj
YXRlIHdoZXRoZXIgaXQncwogICogYSB2YWxpZCBzZyBlbnRyeSwgb3Igd2hldGhlciBpdCBwb2lu
dHMgdG8gdGhlIHN0YXJ0IG9mIGEgbmV3IHNjYXR0ZXJsaXN0LgogICogVGhvc2UgbG93IGJpdHMg
YXJlIHRoZXJlIGZvciBldmVyeW9uZSEgKHRoYW5rcyBtYXNvbiA6LSkKICAqLwotI2RlZmluZSBT
R19QQUdFX0xJTktfTUFTSyAoU0dfQ0hBSU4gfCBTR19FTkQpCisjZGVmaW5lIFNHX1BBR0VfTElO
S19NQVNLIChTR19DSEFJTiB8IFNHX0VORCB8IFNHX0RNQV9CVVNfQUREUkVTUykKIAogc3RhdGlj
IGlubGluZSB1bnNpZ25lZCBpbnQgX19zZ19mbGFncyhzdHJ1Y3Qgc2NhdHRlcmxpc3QgKnNnKQog
ewpAQCAtOTEsNiArMTAzLDExIEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBzZ19pc19sYXN0KHN0cnVj
dCBzY2F0dGVybGlzdCAqc2cpCiAJcmV0dXJuIF9fc2dfZmxhZ3Moc2cpICYgU0dfRU5EOwogfQog
CitzdGF0aWMgaW5saW5lIGJvb2wgc2dfaXNfZG1hX2J1c19hZGRyZXNzKHN0cnVjdCBzY2F0dGVy
bGlzdCAqc2cpCit7CisJcmV0dXJuIF9fc2dfZmxhZ3Moc2cpICYgU0dfRE1BX0JVU19BRERSRVNT
OworfQorCiAvKioKICAqIHNnX2Fzc2lnbl9wYWdlIC0gQXNzaWduIGEgZ2l2ZW4gcGFnZSB0byBh
biBTRyBlbnRyeQogICogQHNnOgkJICAgIFNHIGVudHJ5CkBAIC0yNDUsNiArMjYyLDMxIEBAIHN0
YXRpYyBpbmxpbmUgdm9pZCBzZ191bm1hcmtfZW5kKHN0cnVjdCBzY2F0dGVybGlzdCAqc2cpCiAJ
c2ctPnBhZ2VfbGluayAmPSB+U0dfRU5EOwogfQogCisvKioKKyAqIHNnX2RtYV9tYXJrX2J1cyBh
ZGRyZXNzIC0gTWFyayB0aGUgc2NhdHRlcmxpc3QgZW50cnkgYXMgYSBidXMgYWRkcmVzcworICog
QHNnOgkJIFNHIGVudHJ5U2NhdHRlcmxpc3QKKyAqCisgKiBEZXNjcmlwdGlvbjoKKyAqICAgTWFy
a3MgdGhlIHBhc3NlZCBpbiBzZyBlbnRyeSB0byBpbmRpY2F0ZSB0aGF0IHRoZSBkbWFfYWRkcmVz
cyBpcworICogICBhIGJ1cyBhZGRyZXNzIGFuZCBkb2Vzbid0IG5lZWQgdG8gYmUgdW5tYXBwZWQu
CisgKiovCitzdGF0aWMgaW5saW5lIHZvaWQgc2dfZG1hX21hcmtfYnVzX2FkZHJlc3Moc3RydWN0
IHNjYXR0ZXJsaXN0ICpzZykKK3sKKwlzZy0+cGFnZV9saW5rIHw9IFNHX0RNQV9CVVNfQUREUkVT
UzsKK30KKworLyoqCisgKiBzZ191bm1hcmtfcGNpX3AycGRtYSAtIFVubWFyayB0aGUgc2NhdHRl
cmxpc3QgZW50cnkgYXMgYSBidXMgYWRkcmVzcworICogQHNnOgkJIFNHIGVudHJ5U2NhdHRlcmxp
c3QKKyAqCisgKiBEZXNjcmlwdGlvbjoKKyAqICAgQ2xlYXJzIHRoZSBidXMgYWRkcmVzcyBtYXJr
LgorICoqLworc3RhdGljIGlubGluZSB2b2lkIHNnX2RtYV91bm1hcmtfYnVzX2FkZHJlc3Moc3Ry
dWN0IHNjYXR0ZXJsaXN0ICpzZykKK3sKKwlzZy0+cGFnZV9saW5rICY9IH5TR19ETUFfQlVTX0FE
RFJFU1M7Cit9CisKIC8qKgogICogc2dfcGh5cyAtIFJldHVybiBwaHlzaWNhbCBhZGRyZXNzIG9m
IGFuIHNnIGVudHJ5CiAgKiBAc2c6CSAgICAgU0cgZW50cnkKLS0gCjIuMzAuMgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0
CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
