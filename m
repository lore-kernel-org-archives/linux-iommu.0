Return-Path: <SRS0=vqUx=OG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7769AC433EF
	for <iommu@archiver.kernel.org>; Thu, 16 Sep 2021 23:41:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 324ED6120D
	for <iommu@archiver.kernel.org>; Thu, 16 Sep 2021 23:41:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 324ED6120D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2FEA44049E;
	Thu, 16 Sep 2021 23:41:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ELoRh8zONoYq; Thu, 16 Sep 2021 23:41:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B1A984049D;
	Thu, 16 Sep 2021 23:41:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8C5DAC001E;
	Thu, 16 Sep 2021 23:41:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A7CDC0011
 for <iommu@lists.linux-foundation.org>; Thu, 16 Sep 2021 23:41:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5BF5361407
 for <iommu@lists.linux-foundation.org>; Thu, 16 Sep 2021 23:41:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=deltatee.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O1l3mzJxNhgy for <iommu@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 23:41:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AC853608ED
 for <iommu@lists.linux-foundation.org>; Thu, 16 Sep 2021 23:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Cc:To:From:content-disposition;
 bh=8bOXOFnckmEc8LCJ9PH0f4LyphVDIcC24zx3B6oadvQ=; b=RFVdJzEG1LYX/cCVSoDTFqrqzO
 eWbPdYWb6JTWgxd1VH8508Ykwd0ArTzEQflE+Zf39KsZT9V44tJlNZw1MlNDh1hGjxjce55nxShDO
 X/F436UI2JS6/1dTCeIfETkJCAsaFHpRzZm6+NPQz/uAWz5V8vOZbLFY5Qiz6QpbF+jkldK5QYtF1
 gQOyJeepovW7eyPIRZWyBJDz7xMCCcf/+Do9AeM4IG5nlQyYeXPmFJ+XU8umkONBVEMIJdLUc1ZAz
 1GKlO8AgAHAE0o1zX1N4kppCztLqedObZwWaCeAcEEUSw7bDG8VKfc1vq1+4pA1jClAbKym8zA+Dv
 EySiIlGg==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1mR107-0008I0-JT; Thu, 16 Sep 2021 17:41:08 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim
 4.94.2) (envelope-from <gunthorp@deltatee.com>)
 id 1mR103-000Vqp-JU; Thu, 16 Sep 2021 17:41:03 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Date: Thu, 16 Sep 2021 17:40:41 -0600
Message-Id: <20210916234100.122368-2-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210916234100.122368-1-logang@deltatee.com>
References: <20210916234100.122368-1-logang@deltatee.com>
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
Subject: [PATCH v3 01/20] lib/scatterlist: add flag for indicating P2PDMA
 segments in an SGL
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
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
dCBpcyBtYXJrZWQgYXMgUDJQRE1BLgoKVXNpbmcgdGhpcyBiaXQgcmVxdWlyZXMgYWRkaW5nIGFu
IGFkZGl0aW9uYWwgZGVwZW5kZW5jeSBvbiBDT05GSUdfNjRCSVQgdG8KQ09ORklHX1BDSV9QMlBE
TUEuIFRoaXMgc2hvdWxkIGJlIGFjY2VwdGFibGUgYXMgdGhlIG1ham9yaXR5IG9mIFAyUERNQQp1
c2UgY2FzZXMgYXJlIHJlc3RyaWN0ZWQgdG8gbmV3ZXIgcm9vdCBjb21wbGV4ZXMgYW5kIHJvdWdo
bHkgcmVxdWlyZSB0aGUKZXh0cmEgYWRkcmVzcyBzcGFjZSBmb3IgbWVtb3J5IEJBUnMgdXNlZCBp
biB0aGUgdHJhbnNhY3Rpb25zLgoKU2lnbmVkLW9mZi1ieTogTG9nYW4gR3VudGhvcnBlIDxsb2dh
bmdAZGVsdGF0ZWUuY29tPgpSZXZpZXdlZC1ieTogSm9obiBIdWJiYXJkIDxqaHViYmFyZEBudmlk
aWEuY29tPgotLS0KIGRyaXZlcnMvcGNpL0tjb25maWcgICAgICAgICB8ICAyICstCiBpbmNsdWRl
L2xpbnV4L3NjYXR0ZXJsaXN0LmggfCA1MCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrLS0tCiAyIGZpbGVzIGNoYW5nZWQsIDQ3IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvS2NvbmZpZyBiL2RyaXZlcnMvcGNpL0tjb25maWcK
aW5kZXggMGM0NzNkNzVlNjI1Li45MGI0YmRkYjMzMDAgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvcGNp
L0tjb25maWcKKysrIGIvZHJpdmVycy9wY2kvS2NvbmZpZwpAQCAtMTYzLDcgKzE2Myw3IEBAIGNv
bmZpZyBQQ0lfUEFTSUQKIAogY29uZmlnIFBDSV9QMlBETUEKIAlib29sICJQQ0kgcGVlci10by1w
ZWVyIHRyYW5zZmVyIHN1cHBvcnQiCi0JZGVwZW5kcyBvbiBaT05FX0RFVklDRQorCWRlcGVuZHMg
b24gWk9ORV9ERVZJQ0UgJiYgNjRCSVQKIAlzZWxlY3QgR0VORVJJQ19BTExPQ0FUT1IKIAloZWxw
CiAJICBFbmFibGXRlSBkcml2ZXJzIHRvIGRvIFBDSSBwZWVyLXRvLXBlZXIgdHJhbnNhY3Rpb25z
IHRvIGFuZCBmcm9tCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3NjYXR0ZXJsaXN0LmggYi9p
bmNsdWRlL2xpbnV4L3NjYXR0ZXJsaXN0LmgKaW5kZXggMjY2NzU0YTU1MzI3Li5lNjJiMWNmNjM4
NmYgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvc2NhdHRlcmxpc3QuaAorKysgYi9pbmNsdWRl
L2xpbnV4L3NjYXR0ZXJsaXN0LmgKQEAgLTY0LDYgKzY0LDIxIEBAIHN0cnVjdCBzZ19hcHBlbmRf
dGFibGUgewogI2RlZmluZSBTR19DSEFJTgkweDAxVUwKICNkZWZpbmUgU0dfRU5ECQkweDAyVUwK
IAorLyoKKyAqIGJpdCAyIGlzIHRoZSB0aGlyZCBmcmVlIGJpdCBpbiB0aGUgcGFnZV9saW5rIG9u
IDY0Yml0IHN5c3RlbXMgd2hpY2gKKyAqIGlzIHVzZWQgYnkgZG1hX3VubWFwX3NnKCkgdG8gZGV0
ZXJtaW5lIGlmIHRoZSBkbWFfYWRkcmVzcyBpcyBhIFBDSQorICogYnVzIGFkZHJlc3Mgd2hlbiBk
b2luZyBQMlBETUEuCisgKiBOb3RlOiBDT05GSUdfUENJX1AyUERNQSBkZXBlbmRzIG9uIENPTkZJ
R182NEJJVCBiZWNhdXNlIG9mIHRoaXMuCisgKi8KKworI2lmZGVmIENPTkZJR19QQ0lfUDJQRE1B
CisjZGVmaW5lIFNHX0RNQV9QQ0lfUDJQRE1BCTB4MDRVTAorI2Vsc2UKKyNkZWZpbmUgU0dfRE1B
X1BDSV9QMlBETUEJMHgwMFVMCisjZW5kaWYKKworI2RlZmluZSBTR19QQUdFX0xJTktfTUFTSyAo
U0dfQ0hBSU4gfCBTR19FTkQgfCBTR19ETUFfUENJX1AyUERNQSkKKwogLyoKICAqIFdlIG92ZXJs
b2FkIHRoZSBMU0Igb2YgdGhlIHBhZ2UgcG9pbnRlciB0byBpbmRpY2F0ZSB3aGV0aGVyIGl0J3MK
ICAqIGEgdmFsaWQgc2cgZW50cnksIG9yIHdoZXRoZXIgaXQgcG9pbnRzIHRvIHRoZSBzdGFydCBv
ZiBhIG5ldyBzY2F0dGVybGlzdC4KQEAgLTcyLDcgKzg3LDkgQEAgc3RydWN0IHNnX2FwcGVuZF90
YWJsZSB7CiAjZGVmaW5lIHNnX2lzX2NoYWluKHNnKQkJKChzZyktPnBhZ2VfbGluayAmIFNHX0NI
QUlOKQogI2RlZmluZSBzZ19pc19sYXN0KHNnKQkJKChzZyktPnBhZ2VfbGluayAmIFNHX0VORCkK
ICNkZWZpbmUgc2dfY2hhaW5fcHRyKHNnKQlcCi0JKChzdHJ1Y3Qgc2NhdHRlcmxpc3QgKikgKChz
ZyktPnBhZ2VfbGluayAmIH4oU0dfQ0hBSU4gfCBTR19FTkQpKSkKKwkoKHN0cnVjdCBzY2F0dGVy
bGlzdCAqKSgoc2cpLT5wYWdlX2xpbmsgJiB+U0dfUEFHRV9MSU5LX01BU0spKQorCisjZGVmaW5l
IHNnX2lzX2RtYV9wY2lfcDJwZG1hKHNnKSAoKHNnKS0+cGFnZV9saW5rICYgU0dfRE1BX1BDSV9Q
MlBETUEpCiAKIC8qKgogICogc2dfYXNzaWduX3BhZ2UgLSBBc3NpZ24gYSBnaXZlbiBwYWdlIHRv
IGFuIFNHIGVudHJ5CkBAIC04NiwxMyArMTAzLDEzIEBAIHN0cnVjdCBzZ19hcHBlbmRfdGFibGUg
ewogICoqLwogc3RhdGljIGlubGluZSB2b2lkIHNnX2Fzc2lnbl9wYWdlKHN0cnVjdCBzY2F0dGVy
bGlzdCAqc2csIHN0cnVjdCBwYWdlICpwYWdlKQogewotCXVuc2lnbmVkIGxvbmcgcGFnZV9saW5r
ID0gc2ctPnBhZ2VfbGluayAmIChTR19DSEFJTiB8IFNHX0VORCk7CisJdW5zaWduZWQgbG9uZyBw
YWdlX2xpbmsgPSBzZy0+cGFnZV9saW5rICYgU0dfUEFHRV9MSU5LX01BU0s7CiAKIAkvKgogCSAq
IEluIG9yZGVyIGZvciB0aGUgbG93IGJpdCBzdGVhbGluZyBhcHByb2FjaCB0byB3b3JrLCBwYWdl
cwogCSAqIG11c3QgYmUgYWxpZ25lZCBhdCBhIDMyLWJpdCBib3VuZGFyeSBhcyBhIG1pbmltdW0u
CiAJICovCi0JQlVHX09OKCh1bnNpZ25lZCBsb25nKSBwYWdlICYgKFNHX0NIQUlOIHwgU0dfRU5E
KSk7CisJQlVHX09OKCh1bnNpZ25lZCBsb25nKXBhZ2UgJiBTR19QQUdFX0xJTktfTUFTSyk7CiAj
aWZkZWYgQ09ORklHX0RFQlVHX1NHCiAJQlVHX09OKHNnX2lzX2NoYWluKHNnKSk7CiAjZW5kaWYK
QEAgLTEyNiw3ICsxNDMsNyBAQCBzdGF0aWMgaW5saW5lIHN0cnVjdCBwYWdlICpzZ19wYWdlKHN0
cnVjdCBzY2F0dGVybGlzdCAqc2cpCiAjaWZkZWYgQ09ORklHX0RFQlVHX1NHCiAJQlVHX09OKHNn
X2lzX2NoYWluKHNnKSk7CiAjZW5kaWYKLQlyZXR1cm4gKHN0cnVjdCBwYWdlICopKChzZyktPnBh
Z2VfbGluayAmIH4oU0dfQ0hBSU4gfCBTR19FTkQpKTsKKwlyZXR1cm4gKHN0cnVjdCBwYWdlICop
KChzZyktPnBhZ2VfbGluayAmIH5TR19QQUdFX0xJTktfTUFTSyk7CiB9CiAKIC8qKgpAQCAtMjI4
LDYgKzI0NSwzMSBAQCBzdGF0aWMgaW5saW5lIHZvaWQgc2dfdW5tYXJrX2VuZChzdHJ1Y3Qgc2Nh
dHRlcmxpc3QgKnNnKQogCXNnLT5wYWdlX2xpbmsgJj0gflNHX0VORDsKIH0KIAorLyoqCisgKiBz
Z19kbWFfbWFya19wY2lfcDJwZG1hIC0gTWFyayB0aGUgc2NhdHRlcmxpc3QgZW50cnkgZm9yIFBD
SSBwMnBkbWEKKyAqIEBzZzoJCSBTRyBlbnRyeVNjYXR0ZXJsaXN0CisgKgorICogRGVzY3JpcHRp
b246CisgKiAgIE1hcmtzIHRoZSBwYXNzZWQgaW4gc2cgZW50cnkgdG8gaW5kaWNhdGUgdGhhdCB0
aGUgZG1hX2FkZHJlc3MgaXMKKyAqICAgYSBQQ0kgYnVzIGFkZHJlc3MuCisgKiovCitzdGF0aWMg
aW5saW5lIHZvaWQgc2dfZG1hX21hcmtfcGNpX3AycGRtYShzdHJ1Y3Qgc2NhdHRlcmxpc3QgKnNn
KQoreworCXNnLT5wYWdlX2xpbmsgfD0gU0dfRE1BX1BDSV9QMlBETUE7Cit9CisKKy8qKgorICog
c2dfdW5tYXJrX3BjaV9wMnBkbWEgLSBVbm1hcmsgdGhlIHNjYXR0ZXJsaXN0IGVudHJ5IGZvciBQ
Q0kgcDJwZG1hCisgKiBAc2c6CQkgU0cgZW50cnlTY2F0dGVybGlzdAorICoKKyAqIERlc2NyaXB0
aW9uOgorICogICBDbGVhcnMgdGhlIFBDSSBQMlBETUEgbWFyaworICoqLworc3RhdGljIGlubGlu
ZSB2b2lkIHNnX2RtYV91bm1hcmtfcGNpX3AycGRtYShzdHJ1Y3Qgc2NhdHRlcmxpc3QgKnNnKQor
eworCXNnLT5wYWdlX2xpbmsgJj0gflNHX0RNQV9QQ0lfUDJQRE1BOworfQorCiAvKioKICAqIHNn
X3BoeXMgLSBSZXR1cm4gcGh5c2ljYWwgYWRkcmVzcyBvZiBhbiBzZyBlbnRyeQogICogQHNnOgkg
ICAgIFNHIGVudHJ5Ci0tIAoyLjMwLjIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby9pb21tdQ==
