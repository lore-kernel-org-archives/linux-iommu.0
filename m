Return-Path: <SRS0=sOBO=QE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4818C4167D
	for <iommu@archiver.kernel.org>; Wed, 17 Nov 2021 21:54:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB9A461BFB
	for <iommu@archiver.kernel.org>; Wed, 17 Nov 2021 21:54:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AB9A461BFB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 87F3A60A9B;
	Wed, 17 Nov 2021 21:54:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nHwic8iZDRPo; Wed, 17 Nov 2021 21:54:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5615760A97;
	Wed, 17 Nov 2021 21:54:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6216DC0039;
	Wed, 17 Nov 2021 21:54:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BFFB6C003E
 for <iommu@lists.linux-foundation.org>; Wed, 17 Nov 2021 21:54:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C3F3980C63
 for <iommu@lists.linux-foundation.org>; Wed, 17 Nov 2021 21:54:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=deltatee.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SkzD-g0soBvR for <iommu@lists.linux-foundation.org>;
 Wed, 17 Nov 2021 21:54:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1C13080CB0
 for <iommu@lists.linux-foundation.org>; Wed, 17 Nov 2021 21:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Cc:To:From:content-disposition;
 bh=E9tQWtvaLICmPSoEVBJb4KTrJ+PSjHquPVLYmy++lAQ=; b=mxEXmW4OZEo8i67U5DMx5HrPbS
 AK51pgfhmTpE6vjIujjmCpY6A999ck0das6Npk9wDVBcYvnl0gbK1ZiUDlXCosy+XmIlbhUrVTAPZ
 91/bA6ba3/Cvv04qAIODBzWTtAiiSx+V26PZJhQnAs12eMgjW7W09G8nDZ3Grj/zcNnkBFe16y2/x
 3EeSCU5zQmKpyIBKL3ExEDIK8vyuN11OYMSzAtVXOmO6g9WGvL2RbrJQUL8n8Bi1fVrHh4w1bx0ZC
 jvYm0EPPRg8+gcnpY5++dLLNcWVdibi79wrXO38JGd6xsQRZfLh0GmriWFh1BXBlkfAKoiPIIxUux
 I8dRAKeA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <gunthorp@deltatee.com>)
 id 1mnSsi-000Zo5-TA; Wed, 17 Nov 2021 14:54:17 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim
 4.94.2) (envelope-from <gunthorp@deltatee.com>)
 id 1mnSse-0000yr-90; Wed, 17 Nov 2021 14:54:12 -0700
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Date: Wed, 17 Nov 2021 14:53:49 -0700
Message-Id: <20211117215410.3695-3-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211117215410.3695-1-logang@deltatee.com>
References: <20211117215410.3695-1-logang@deltatee.com>
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
 martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v4 02/23] lib/scatterlist: add flag for indicating P2PDMA
 segments in an SGL
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: Minturn Dave B <dave.b.minturn@intel.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Ira Weiny <ira.weiny@intel.com>, John Hubbard <jhubbard@nvidia.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Robin Murphy <robin.murphy@arm.com>,
 Matthew Wilcox <willy@infradead.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Logan Gunthorpe <logang@deltatee.com>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
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
dCBpcyBtYXJrZWQgYXMgYSBidXMgYWRkcmVzcy4KCkNyZWF0ZSBhIENPTkZJR19ORUVEX1NHX0RN
QV9CVVNfQUREUl9GTEFHIGJvb2wgd2hpY2ggZGVwZW5kcyBvbgpDT05GSUdfNjRCSVQgKHNvIHRo
ZXJlIGlzIHNwYWNlIGluIHRoZSBwYWdlIGxpbmsgZm9yIHRoZSBuZXcgZmxhZykuCkNPTkZJR19Q
Q0lfUDJQRE1BIHdpbGwgdGhlbiBkZXBlbmQgb24gdGhpcyBzbyB0aGlzIG1lYW5zIFBDSSBQMlBE
TUEgd2lsbApyZXF1aXJlIENPTkZJR182NEJJVC4gVGhpcyBzaG91bGQgYmUgYWNjZXB0YWJsZSBh
cyB0aGUgbWFqb3JpdHkgb2YgUDJQRE1BCnVzZSBjYXNlcyBhcmUgcmVzdHJpY3RlZCB0byBuZXdl
ciByb290IGNvbXBsZXhlcyBhbmQgcm91Z2hseSByZXF1aXJlIHRoZQpleHRyYSBhZGRyZXNzIHNw
YWNlIGZvciBtZW1vcnkgQkFScyB1c2VkIGluIHRoZSB0cmFuc2FjdGlvbnMuCgpTaWduZWQtb2Zm
LWJ5OiBMb2dhbiBHdW50aG9ycGUgPGxvZ2FuZ0BkZWx0YXRlZS5jb20+Ci0tLQogZHJpdmVycy9w
Y2kvS2NvbmZpZyAgICAgICAgIHwgIDUgKysrKysKIGluY2x1ZGUvbGludXgvc2NhdHRlcmxpc3Qu
aCB8IDQ0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0KIGtlcm5lbC9kbWEv
S2NvbmZpZyAgICAgICAgICB8IDEwICsrKysrKysrKwogMyBmaWxlcyBjaGFuZ2VkLCA1OCBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvS2NvbmZp
ZyBiL2RyaXZlcnMvcGNpL0tjb25maWcKaW5kZXggNDNlNjE1YWExMmZmLi45NWYyOTYwMWE0ZGYg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvcGNpL0tjb25maWcKKysrIGIvZHJpdmVycy9wY2kvS2NvbmZp
ZwpAQCAtMTY0LDYgKzE2NCwxMSBAQCBjb25maWcgUENJX1BBU0lECiBjb25maWcgUENJX1AyUERN
QQogCWJvb2wgIlBDSSBwZWVyLXRvLXBlZXIgdHJhbnNmZXIgc3VwcG9ydCIKIAlkZXBlbmRzIG9u
IFpPTkVfREVWSUNFCisJIworCSMgVGhlIG5lZWQgZm9yIHRoZSBzY2F0dGVybGlzdCBETUEgYnVz
IGFkZHJlc3MgZmxhZyBtZWFucyBQQ0kgUDJQRE1BCisJIyByZXF1aXJlcyA2NGJpdAorCSMKKwlz
ZWxlY3QgTkVFRF9TR19ETUFfQlVTX0FERFJfRkxBRwogCXNlbGVjdCBHRU5FUklDX0FMTE9DQVRP
UgogCWhlbHAKIAkgIEVuYWJsZdGVIGRyaXZlcnMgdG8gZG8gUENJIHBlZXItdG8tcGVlciB0cmFu
c2FjdGlvbnMgdG8gYW5kIGZyb20KZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvc2NhdHRlcmxp
c3QuaCBiL2luY2x1ZGUvbGludXgvc2NhdHRlcmxpc3QuaAppbmRleCA3ZmY5ZDYzODZjMTIuLjkx
N2MwOWRjYzU2NiAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9zY2F0dGVybGlzdC5oCisrKyBi
L2luY2x1ZGUvbGludXgvc2NhdHRlcmxpc3QuaApAQCAtNjQsMTIgKzY0LDI0IEBAIHN0cnVjdCBz
Z19hcHBlbmRfdGFibGUgewogI2RlZmluZSBTR19DSEFJTgkweDAxVUwKICNkZWZpbmUgU0dfRU5E
CQkweDAyVUwKIAorLyoKKyAqIGJpdCAyIGlzIHRoZSB0aGlyZCBmcmVlIGJpdCBpbiB0aGUgcGFn
ZV9saW5rIG9uIDY0Yml0IHN5c3RlbXMgd2hpY2gKKyAqIGlzIHVzZWQgYnkgZG1hX3VubWFwX3Nn
KCkgdG8gZGV0ZXJtaW5lIGlmIHRoZSBkbWFfYWRkcmVzcyBpcyBhCisgKiBidXMgYWRkcmVzcyB3
aGVuIGRvaW5nIFAyUERNQS4KKyAqLworI2lmZGVmIENPTkZJR19ORUVEX1NHX0RNQV9CVVNfQURE
Ul9GTEFHCisjZGVmaW5lIFNHX0RNQV9CVVNfQUREUkVTUwkweDA0VUwKK3N0YXRpY19hc3NlcnQo
X19hbGlnbm9mX18oc3RydWN0IHBhZ2UpID49IDgpOworI2Vsc2UKKyNkZWZpbmUgU0dfRE1BX0JV
U19BRERSRVNTCTB4MDBVTAorI2VuZGlmCisKIC8qCiAgKiBXZSBvdmVybG9hZCB0aGUgTFNCIG9m
IHRoZSBwYWdlIHBvaW50ZXIgdG8gaW5kaWNhdGUgd2hldGhlciBpdCdzCiAgKiBhIHZhbGlkIHNn
IGVudHJ5LCBvciB3aGV0aGVyIGl0IHBvaW50cyB0byB0aGUgc3RhcnQgb2YgYSBuZXcgc2NhdHRl
cmxpc3QuCiAgKiBUaG9zZSBsb3cgYml0cyBhcmUgdGhlcmUgZm9yIGV2ZXJ5b25lISAodGhhbmtz
IG1hc29uIDotKQogICovCi0jZGVmaW5lIFNHX1BBR0VfTElOS19NQVNLIChTR19DSEFJTiB8IFNH
X0VORCkKKyNkZWZpbmUgU0dfUEFHRV9MSU5LX01BU0sgKFNHX0NIQUlOIHwgU0dfRU5EIHwgU0df
RE1BX0JVU19BRERSRVNTKQogCiBzdGF0aWMgaW5saW5lIHVuc2lnbmVkIGludCBfX3NnX2ZsYWdz
KHN0cnVjdCBzY2F0dGVybGlzdCAqc2cpCiB7CkBAIC05MSw2ICsxMDMsMTEgQEAgc3RhdGljIGlu
bGluZSBib29sIHNnX2lzX2xhc3Qoc3RydWN0IHNjYXR0ZXJsaXN0ICpzZykKIAlyZXR1cm4gX19z
Z19mbGFncyhzZykgJiBTR19FTkQ7CiB9CiAKK3N0YXRpYyBpbmxpbmUgYm9vbCBzZ19pc19kbWFf
YnVzX2FkZHJlc3Moc3RydWN0IHNjYXR0ZXJsaXN0ICpzZykKK3sKKwlyZXR1cm4gX19zZ19mbGFn
cyhzZykgJiBTR19ETUFfQlVTX0FERFJFU1M7Cit9CisKIC8qKgogICogc2dfYXNzaWduX3BhZ2Ug
LSBBc3NpZ24gYSBnaXZlbiBwYWdlIHRvIGFuIFNHIGVudHJ5CiAgKiBAc2c6CQkgICAgU0cgZW50
cnkKQEAgLTI0NSw2ICsyNjIsMzEgQEAgc3RhdGljIGlubGluZSB2b2lkIHNnX3VubWFya19lbmQo
c3RydWN0IHNjYXR0ZXJsaXN0ICpzZykKIAlzZy0+cGFnZV9saW5rICY9IH5TR19FTkQ7CiB9CiAK
Ky8qKgorICogc2dfZG1hX21hcmtfYnVzIGFkZHJlc3MgLSBNYXJrIHRoZSBzY2F0dGVybGlzdCBl
bnRyeSBhcyBhIGJ1cyBhZGRyZXNzCisgKiBAc2c6CQkgU0cgZW50cnlTY2F0dGVybGlzdAorICoK
KyAqIERlc2NyaXB0aW9uOgorICogICBNYXJrcyB0aGUgcGFzc2VkIGluIHNnIGVudHJ5IHRvIGlu
ZGljYXRlIHRoYXQgdGhlIGRtYV9hZGRyZXNzIGlzCisgKiAgIGEgYnVzIGFkZHJlc3MgYW5kIGRv
ZXNuJ3QgbmVlZCB0byBiZSB1bm1hcHBlZC4KKyAqKi8KK3N0YXRpYyBpbmxpbmUgdm9pZCBzZ19k
bWFfbWFya19idXNfYWRkcmVzcyhzdHJ1Y3Qgc2NhdHRlcmxpc3QgKnNnKQoreworCXNnLT5wYWdl
X2xpbmsgfD0gU0dfRE1BX0JVU19BRERSRVNTOworfQorCisvKioKKyAqIHNnX3VubWFya19wY2lf
cDJwZG1hIC0gVW5tYXJrIHRoZSBzY2F0dGVybGlzdCBlbnRyeSBhcyBhIGJ1cyBhZGRyZXNzCisg
KiBAc2c6CQkgU0cgZW50cnlTY2F0dGVybGlzdAorICoKKyAqIERlc2NyaXB0aW9uOgorICogICBD
bGVhcnMgdGhlIGJ1cyBhZGRyZXNzIG1hcmsuCisgKiovCitzdGF0aWMgaW5saW5lIHZvaWQgc2df
ZG1hX3VubWFya19idXNfYWRkcmVzcyhzdHJ1Y3Qgc2NhdHRlcmxpc3QgKnNnKQoreworCXNnLT5w
YWdlX2xpbmsgJj0gflNHX0RNQV9CVVNfQUREUkVTUzsKK30KKwogLyoqCiAgKiBzZ19waHlzIC0g
UmV0dXJuIHBoeXNpY2FsIGFkZHJlc3Mgb2YgYW4gc2cgZW50cnkKICAqIEBzZzoJICAgICBTRyBl
bnRyeQpkaWZmIC0tZ2l0IGEva2VybmVsL2RtYS9LY29uZmlnIGIva2VybmVsL2RtYS9LY29uZmln
CmluZGV4IDFiMDIxNzk3NThjYi4uNmU1ZTFkOGUxMzI5IDEwMDY0NAotLS0gYS9rZXJuZWwvZG1h
L0tjb25maWcKKysrIGIva2VybmVsL2RtYS9LY29uZmlnCkBAIC0yNyw2ICsyNywxNiBAQCBjb25m
aWcgQVJDSF9IQVNfRE1BX01BUF9ESVJFQ1QKIGNvbmZpZyBORUVEX1NHX0RNQV9MRU5HVEgKIAli
b29sCiAKKyMKKyMgUENJIFAyUERNQSBuZWVkcyB0byBzdG9yZSBidXMgYWRkcmVzc2VzIGluIHRo
ZSBTR0wncyBkbWFfYWRkcmVzcyBzbyB0aGF0IHRoZQorIyBkbWFfdW5tYXBfc2coKSBpbXBsZW1l
bnRhdGlvbnMgY2FuIGtub3cgbm90IHRvIHVubWFwIHRob3NlIHNlZ21lbnRzLgorIyBUaGUgZmxh
ZyBpcyBzdG9yZWQgaW4gdGhlIDNyZCBiaXQgaW4gdGhlIHBhZ2VfbGluayBmaWVsZCBpbiB0aGUg
U0dMCisjIHdoaWNoIG1lYW5zIHRoaXMgY2FuIG9ubHkgYmUgZG9uZSBvbiA2NGJpdCBzeXN0ZW1z
LgorIworY29uZmlnIE5FRURfU0dfRE1BX0JVU19BRERSX0ZMQUcKKwlkZXBlbmRzIG9uIDY0QklU
CisJYm9vbAorCiBjb25maWcgTkVFRF9ETUFfTUFQX1NUQVRFCiAJYm9vbAogCi0tIAoyLjMwLjIK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1h
aWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
