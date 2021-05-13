Return-Path: <SRS0=YXze=KI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F916C2B9F9
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 22:32:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E41061454
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 22:32:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E41061454
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E83E360E10;
	Thu, 13 May 2021 22:32:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f-Y225STH1rG; Thu, 13 May 2021 22:32:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 01D8A60E12;
	Thu, 13 May 2021 22:32:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AE9CEC0029;
	Thu, 13 May 2021 22:32:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6EC06C002B
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 22:32:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5C49760ABB
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 22:32:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YCkF5Hlzngt8 for <iommu@lists.linux-foundation.org>;
 Thu, 13 May 2021 22:32:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A9AE460AB2
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 22:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Cc:To:From:content-disposition;
 bh=urONlbDdNY96O4Br2qWINyrNaPT4Dibc1Xoxdfr4kAE=; b=ClKycIjBAcYGIEKiO+/BdOVOmR
 DYY6fkj8VEF259w5KCkdqa2KqJN3pQg4e9zRxCtnlJD6gegiKQgK4W5SBgAzOPL37TjH7CVq8bNK9
 YTFNBe1kop+7YnF8246nItSryrwpduptVhrDSWwxlM3RPrtGSox4ZJJ289gZQ0umFzkV9Aorbtnr/
 gj7IsHmXhhTykipF0BEpC23yD88kBtyQ1LSIQzYjbvSJuKsjZ5I8EOja6TudioyQHDWnHVTBRB+l9
 kmqwc9aD+wXd6+w+Z+XkAuFUhl/mKJEc3QHqxBsAWIm2Q5X4MdqpSVPmwXA/3Fi5TO/2XmUTuHvQ9
 Jjg2OloA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1lhJsV-0000nE-0b; Thu, 13 May 2021 16:32:24 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1lhJsH-0001T2-Ff; Thu, 13 May 2021 16:32:09 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Date: Thu, 13 May 2021 16:31:53 -0600
Message-Id: <20210513223203.5542-13-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210513223203.5542-1-logang@deltatee.com>
References: <20210513223203.5542-1-logang@deltatee.com>
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
Subject: [PATCH v2 12/22] lib/scatterlist: Add flag for indicating P2PDMA
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
bmNsdWRlL2xpbnV4L3NjYXR0ZXJsaXN0LmgKaW5kZXggNmY3MDU3MmIyOTM4Li41NjJjMGFhMjY0
ZjUgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvc2NhdHRlcmxpc3QuaAorKysgYi9pbmNsdWRl
L2xpbnV4L3NjYXR0ZXJsaXN0LmgKQEAgLTU4LDYgKzU4LDIxIEBAIHN0cnVjdCBzZ190YWJsZSB7
CiAjZGVmaW5lIFNHX0NIQUlOCTB4MDFVTAogI2RlZmluZSBTR19FTkQJCTB4MDJVTAogCisvKgor
ICogYml0IDIgaXMgdGhlIHRoaXJkIGZyZWUgYml0IGluIHRoZSBwYWdlX2xpbmsgb24gNjRiaXQg
c3lzdGVtcyB3aGljaAorICogaXMgdXNlZCBieSBkbWFfdW5tYXBfc2coKSB0byBkZXRlcm1pbmUg
aWYgdGhlIGRtYV9hZGRyZXNzIGlzIGEgUENJCisgKiBidXMgYWRkcmVzcyB3aGVuIGRvaW5nIFAy
UERNQS4KKyAqIE5vdGU6IENPTkZJR19QQ0lfUDJQRE1BIGRlcGVuZHMgb24gQ09ORklHXzY0QklU
IGJlY2F1c2Ugb2YgdGhpcy4KKyAqLworCisjaWZkZWYgQ09ORklHX1BDSV9QMlBETUEKKyNkZWZp
bmUgU0dfRE1BX1BDSV9QMlBETUEJMHgwNFVMCisjZWxzZQorI2RlZmluZSBTR19ETUFfUENJX1Ay
UERNQQkweDAwVUwKKyNlbmRpZgorCisjZGVmaW5lIFNHX1BBR0VfTElOS19NQVNLIChTR19DSEFJ
TiB8IFNHX0VORCB8IFNHX0RNQV9QQ0lfUDJQRE1BKQorCiAvKgogICogV2Ugb3ZlcmxvYWQgdGhl
IExTQiBvZiB0aGUgcGFnZSBwb2ludGVyIHRvIGluZGljYXRlIHdoZXRoZXIgaXQncwogICogYSB2
YWxpZCBzZyBlbnRyeSwgb3Igd2hldGhlciBpdCBwb2ludHMgdG8gdGhlIHN0YXJ0IG9mIGEgbmV3
IHNjYXR0ZXJsaXN0LgpAQCAtNjYsNyArODEsOSBAQCBzdHJ1Y3Qgc2dfdGFibGUgewogI2RlZmlu
ZSBzZ19pc19jaGFpbihzZykJCSgoc2cpLT5wYWdlX2xpbmsgJiBTR19DSEFJTikKICNkZWZpbmUg
c2dfaXNfbGFzdChzZykJCSgoc2cpLT5wYWdlX2xpbmsgJiBTR19FTkQpCiAjZGVmaW5lIHNnX2No
YWluX3B0cihzZykJXAotCSgoc3RydWN0IHNjYXR0ZXJsaXN0ICopICgoc2cpLT5wYWdlX2xpbmsg
JiB+KFNHX0NIQUlOIHwgU0dfRU5EKSkpCisJKChzdHJ1Y3Qgc2NhdHRlcmxpc3QgKikgKChzZykt
PnBhZ2VfbGluayAmIH5TR19QQUdFX0xJTktfTUFTSykpCisKKyNkZWZpbmUgc2dfaXNfZG1hX3Bj
aV9wMnBkbWEoc2cpICgoc2cpLT5wYWdlX2xpbmsgJiBTR19ETUFfUENJX1AyUERNQSkKIAogLyoq
CiAgKiBzZ19hc3NpZ25fcGFnZSAtIEFzc2lnbiBhIGdpdmVuIHBhZ2UgdG8gYW4gU0cgZW50cnkK
QEAgLTgwLDEzICs5NywxMyBAQCBzdHJ1Y3Qgc2dfdGFibGUgewogICoqLwogc3RhdGljIGlubGlu
ZSB2b2lkIHNnX2Fzc2lnbl9wYWdlKHN0cnVjdCBzY2F0dGVybGlzdCAqc2csIHN0cnVjdCBwYWdl
ICpwYWdlKQogewotCXVuc2lnbmVkIGxvbmcgcGFnZV9saW5rID0gc2ctPnBhZ2VfbGluayAmIChT
R19DSEFJTiB8IFNHX0VORCk7CisJdW5zaWduZWQgbG9uZyBwYWdlX2xpbmsgPSBzZy0+cGFnZV9s
aW5rICYgU0dfUEFHRV9MSU5LX01BU0s7CiAKIAkvKgogCSAqIEluIG9yZGVyIGZvciB0aGUgbG93
IGJpdCBzdGVhbGluZyBhcHByb2FjaCB0byB3b3JrLCBwYWdlcwogCSAqIG11c3QgYmUgYWxpZ25l
ZCBhdCBhIDMyLWJpdCBib3VuZGFyeSBhcyBhIG1pbmltdW0uCiAJICovCi0JQlVHX09OKCh1bnNp
Z25lZCBsb25nKSBwYWdlICYgKFNHX0NIQUlOIHwgU0dfRU5EKSk7CisJQlVHX09OKCh1bnNpZ25l
ZCBsb25nKSBwYWdlICYgU0dfUEFHRV9MSU5LX01BU0spOwogI2lmZGVmIENPTkZJR19ERUJVR19T
RwogCUJVR19PTihzZ19pc19jaGFpbihzZykpOwogI2VuZGlmCkBAIC0xMjAsNyArMTM3LDcgQEAg
c3RhdGljIGlubGluZSBzdHJ1Y3QgcGFnZSAqc2dfcGFnZShzdHJ1Y3Qgc2NhdHRlcmxpc3QgKnNn
KQogI2lmZGVmIENPTkZJR19ERUJVR19TRwogCUJVR19PTihzZ19pc19jaGFpbihzZykpOwogI2Vu
ZGlmCi0JcmV0dXJuIChzdHJ1Y3QgcGFnZSAqKSgoc2cpLT5wYWdlX2xpbmsgJiB+KFNHX0NIQUlO
IHwgU0dfRU5EKSk7CisJcmV0dXJuIChzdHJ1Y3QgcGFnZSAqKSgoc2cpLT5wYWdlX2xpbmsgJiB+
U0dfUEFHRV9MSU5LX01BU0spOwogfQogCiAvKioKQEAgLTIyMiw2ICsyMzksMzEgQEAgc3RhdGlj
IGlubGluZSB2b2lkIHNnX3VubWFya19lbmQoc3RydWN0IHNjYXR0ZXJsaXN0ICpzZykKIAlzZy0+
cGFnZV9saW5rICY9IH5TR19FTkQ7CiB9CiAKKy8qKgorICogc2dfZG1hX21hcmtfcGNpX3AycGRt
YSAtIE1hcmsgdGhlIHNjYXR0ZXJsaXN0IGVudHJ5IGZvciBQQ0kgcDJwZG1hCisgKiBAc2c6CQkg
U0cgZW50cnlTY2F0dGVybGlzdAorICoKKyAqIERlc2NyaXB0aW9uOgorICogICBNYXJrcyB0aGUg
cGFzc2VkIGluIHNnIGVudHJ5IHRvIGluZGljYXRlIHRoYXQgdGhlIGRtYV9hZGRyZXNzIGlzCisg
KiAgIGEgUENJIGJ1cyBhZGRyZXNzLgorICoqLworc3RhdGljIGlubGluZSB2b2lkIHNnX2RtYV9t
YXJrX3BjaV9wMnBkbWEoc3RydWN0IHNjYXR0ZXJsaXN0ICpzZykKK3sKKwlzZy0+cGFnZV9saW5r
IHw9IFNHX0RNQV9QQ0lfUDJQRE1BOworfQorCisvKioKKyAqIHNnX3VubWFya19wY2lfcDJwZG1h
IC0gVW5tYXJrIHRoZSBzY2F0dGVybGlzdCBlbnRyeSBmb3IgUENJIHAycGRtYQorICogQHNnOgkJ
IFNHIGVudHJ5U2NhdHRlcmxpc3QKKyAqCisgKiBEZXNjcmlwdGlvbjoKKyAqICAgQ2xlYXJzIHRo
ZSBQQ0kgUDJQRE1BIG1hcmsKKyAqKi8KK3N0YXRpYyBpbmxpbmUgdm9pZCBzZ19kbWFfdW5tYXJr
X3BjaV9wMnBkbWEoc3RydWN0IHNjYXR0ZXJsaXN0ICpzZykKK3sKKwlzZy0+cGFnZV9saW5rICY9
IH5TR19ETUFfUENJX1AyUERNQTsKK30KKwogLyoqCiAgKiBzZ19waHlzIC0gUmV0dXJuIHBoeXNp
Y2FsIGFkZHJlc3Mgb2YgYW4gc2cgZW50cnkKICAqIEBzZzoJICAgICBTRyBlbnRyeQotLSAKMi4y
MC4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21t
dSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
