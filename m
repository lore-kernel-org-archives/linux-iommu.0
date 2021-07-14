Return-Path: <SRS0=i+j8=MG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAFAC07E9A
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 13:18:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80254613B7
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 13:18:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80254613B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3A6B1803BE;
	Wed, 14 Jul 2021 13:18:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tc2Jey0fRXnD; Wed, 14 Jul 2021 13:18:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1423783A41;
	Wed, 14 Jul 2021 13:18:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C8FF1C0010;
	Wed, 14 Jul 2021 13:18:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CA15FC000E
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 13:18:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B8BD14053C
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 13:18:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ryGmT-h_iRvp for <iommu@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 13:18:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8274940001
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 13:18:45 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10044"; a="190720368"
X-IronPort-AV: E=Sophos;i="5.84,239,1620716400"; d="scan'208";a="190720368"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2021 06:18:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,239,1620716400"; d="scan'208";a="494448623"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.171])
 by FMSMGA003.fm.intel.com with SMTP; 14 Jul 2021 06:18:42 -0700
Received: by stinkbox (sSMTP sendmail emulation);
 Wed, 14 Jul 2021 16:18:41 +0300
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: intel-gfx@lists.freedesktop.org
Subject: [PATCH v2 1/4] iommu/vt-d: Disable superpage for Geminilake igfx
Date: Wed, 14 Jul 2021 16:18:34 +0300
Message-Id: <20210714131837.8978-2-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210714131837.8978-1-ville.syrjala@linux.intel.com>
References: <20210714131837.8978-1-ville.syrjala@linux.intel.com>
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, David Woodhouse <dwmw2@infradead.org>
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

RnJvbTogVmlsbGUgU3lyasOkbMOkIDx2aWxsZS5zeXJqYWxhQGxpbnV4LmludGVsLmNvbT4KCldo
aWxlIHJ1bm5pbmcgImdlbV9leGVjX2JpZyAtLXIgc2luZ2xlIiBmcm9tIGlndC1ncHUtdG9vbHMg
b24KR2VtaW5pbGFrZSBhcyBzb29uIGFzIGEgMk0gbWFwcGluZyBpcyBtYWRlIEkgdGVuZCB0byBn
ZXQgYSBETUFSCndyaXRlIGZhdWx0LiBTdHJhbmdlbHkgdGhlIGZhdWx0aW5nIGFkZHJlc3MgaXMg
YWx3YXlzIGEgNEsgcGFnZQphbmQgdXN1YWxseSB2ZXJ5IGZhciBhd2F5IGZyb20gdGhlIDJNIHBh
Z2UgdGhhdCBnb3QgbWFwcGVkLgpCdXQgaWYgbm8gMk0gbWFwcGluZ3MgZ2V0IHVzZWQgSSBjYW4n
dCByZXByb2R1Y2UgdGhlIGZhdWx0LgoKSSBhbHNvIHRyaWVkIHRvIGR1bXAgdGhlIFBURSBmb3Ig
dGhlIGZhdWx0aW5nIGFkZHJlc3MgYnV0IGl0IGFjdHVhbGx5Cmxvb2tzIGNvcnJlY3QgdG8gbWUg
KGllLiBkZWZpbml0ZWx5IHNlZW1zIHRvIGhhdmUgdGhlIHdyaXRlIGJpdCBzZXQpOgogRE1BUjog
RFJIRDogaGFuZGxpbmcgZmF1bHQgc3RhdHVzIHJlZyAyCiBETUFSOiBbRE1BIFdyaXRlXSBSZXF1
ZXN0IGRldmljZSBbMDA6MDIuMF0gUEFTSUQgZmZmZmZmZmYgZmF1bHQgYWRkciA3ZmE4YTc4MDAw
IFtmYXVsdCByZWFzb24gMDVdIFBURSBXcml0ZSBhY2Nlc3MgaXMgbm90IHNldAogRE1BUjogZmF1
bHQgN2ZhOGE3ODAwMCAobGV2ZWw9MSkgUFRFID0gMTQ5ZWZjMDAzCgpTbyBub3QgcmVhbGx5IHN1
cmUgd2hhdCdzIGdvaW5nIG9uIGFuZCB0aGlzIG1pZ2h0IGp1c3QgYmUgZnVsbCBvbiBkdWN0CnRh
cGUsIGJ1dCBpdCBzZWVtcyB0byB3b3JrIGhlcmUuIFRoZSBtYWNoaW5lIGhhcyBub3cgc3Vydml2
ZWQgYSB3aG9sZSBkYXkKcnVubmluZyB0aGF0IHRlc3Qgd2hlcmVhcyB3aXRoIHN1cGVycGFnZSBl
bmFibGVkIGl0IGZhaWxzIGluIGxlc3MgdGhhbgphIG1pbnV0ZSB1c3VhbGx5LgoKQ3JlZGl0IHRv
IEx1IEJhb2x1IGZvciB0aGUgbWVjaGFuaXNtIHRvIGRpc2FibGUgc3VwZXJwYWdlIGp1c3QKZm9y
IHRoZSBpZ2Z4IGlvbW11LgoKVE9ETzogd291bGQgYmUgbmljZSB0byB1c2UgdGhlIG1hY3JvcyBm
cm9tIGluY2x1ZGUvZHJtL2k5MTVfcGNpaWRzLmgsCiAgICAgIGJ1dCBjYW4ndCBkbyB0aGF0IHdp
dGggREVDTEFSRV9QQ0lfRklYVVBfSEVBREVSKCkKCkNjOiBEYXZpZCBXb29kaG91c2UgPGR3bXcy
QGluZnJhZGVhZC5vcmc+CkNjOiBMdSBCYW9sdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPgpD
YzogaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKU2lnbmVkLW9mZi1ieTogVmlsbGUg
U3lyasOkbMOkIDx2aWxsZS5zeXJqYWxhQGxpbnV4LmludGVsLmNvbT4KLS0tCiBkcml2ZXJzL2lv
bW11L2ludGVsL2lvbW11LmMgfCAzNCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKyst
CiAxIGZpbGUgY2hhbmdlZCwgMzMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwv
aW9tbXUuYwppbmRleCBiMDRiZmIwZDk0MDkuLjA4YmE0MTIwNTNlMyAxMDA2NDQKLS0tIGEvZHJp
dmVycy9pb21tdS9pbnRlbC9pb21tdS5jCisrKyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUu
YwpAQCAtMzY1LDYgKzM2NSw3IEBAIHN0YXRpYyBpbnQgaW50ZWxfaW9tbXVfc3RyaWN0Owogc3Rh
dGljIGludCBpbnRlbF9pb21tdV9zdXBlcnBhZ2UgPSAxOwogc3RhdGljIGludCBpb21tdV9pZGVu
dGl0eV9tYXBwaW5nOwogc3RhdGljIGludCBpb21tdV9za2lwX3RlX2Rpc2FibGU7CitzdGF0aWMg
aW50IGlvbW11X3NraXBfaWdmeF9zdXBlcnBhZ2U7CiAKICNkZWZpbmUgSURFTlRNQVBfR0ZYCQky
CiAjZGVmaW5lIElERU5UTUFQX0FaQUxJQQkJNApAQCAtNjc0LDYgKzY3NSwyNyBAQCBzdGF0aWMg
Ym9vbCBkb21haW5fdXBkYXRlX2lvbW11X3Nub29waW5nKHN0cnVjdCBpbnRlbF9pb21tdSAqc2tp
cCkKIAlyZXR1cm4gcmV0OwogfQogCitzdGF0aWMgYm9vbCBkb21haW5fdXNlX3N1cGVyX3BhZ2Uo
c3RydWN0IGRtYXJfZG9tYWluICpkb21haW4pCit7CisJc3RydWN0IGRtYXJfZHJoZF91bml0ICpk
cmhkOworCXN0cnVjdCBpbnRlbF9pb21tdSAqaW9tbXU7CisJYm9vbCByZXQgPSB0cnVlOworCisJ
aWYgKCFpbnRlbF9pb21tdV9zdXBlcnBhZ2UpCisJCXJldHVybiBmYWxzZTsKKworCXJjdV9yZWFk
X2xvY2soKTsKKwlmb3JfZWFjaF9hY3RpdmVfaW9tbXUoaW9tbXUsIGRyaGQpIHsKKwkJaWYgKGRy
aGQtPmdmeF9kZWRpY2F0ZWQgJiYgaW9tbXVfc2tpcF9pZ2Z4X3N1cGVycGFnZSkgeworCQkJcmV0
ID0gZmFsc2U7CisJCQlicmVhazsKKwkJfQorCX0KKwlyY3VfcmVhZF91bmxvY2soKTsKKworCXJl
dHVybiByZXQ7Cit9CisKIHN0YXRpYyBpbnQgZG9tYWluX3VwZGF0ZV9pb21tdV9zdXBlcnBhZ2Uo
c3RydWN0IGRtYXJfZG9tYWluICpkb21haW4sCiAJCQkJCSBzdHJ1Y3QgaW50ZWxfaW9tbXUgKnNr
aXApCiB7CkBAIC02ODEsNyArNzAzLDcgQEAgc3RhdGljIGludCBkb21haW5fdXBkYXRlX2lvbW11
X3N1cGVycGFnZShzdHJ1Y3QgZG1hcl9kb21haW4gKmRvbWFpbiwKIAlzdHJ1Y3QgaW50ZWxfaW9t
bXUgKmlvbW11OwogCWludCBtYXNrID0gMHgzOwogCi0JaWYgKCFpbnRlbF9pb21tdV9zdXBlcnBh
Z2UpCisJaWYgKCFkb21haW5fdXNlX3N1cGVyX3BhZ2UoZG9tYWluKSkKIAkJcmV0dXJuIDA7CiAK
IAkvKiBzZXQgaW9tbXVfc3VwZXJwYWdlIHRvIHRoZSBzbWFsbGVzdCBjb21tb24gZGVub21pbmF0
b3IgKi8KQEAgLTU2NTMsNiArNTY3NSwxNiBAQCBERUNMQVJFX1BDSV9GSVhVUF9IRUFERVIoUENJ
X1ZFTkRPUl9JRF9JTlRFTCwgMHgxNjMyLCBxdWlya19pb21tdV9pZ2Z4KTsKIERFQ0xBUkVfUENJ
X0ZJWFVQX0hFQURFUihQQ0lfVkVORE9SX0lEX0lOVEVMLCAweDE2M0EsIHF1aXJrX2lvbW11X2ln
ZngpOwogREVDTEFSRV9QQ0lfRklYVVBfSEVBREVSKFBDSV9WRU5ET1JfSURfSU5URUwsIDB4MTYz
RCwgcXVpcmtfaW9tbXVfaWdmeCk7CiAKK3N0YXRpYyB2b2lkIHF1aXJrX3NraXBfaWdmeF9zdXBl
cnBhZ2Uoc3RydWN0IHBjaV9kZXYgKmRldikKK3sKKwlwY2lfaW5mbyhkZXYsICJEaXNhYmxpbmcg
SU9NTVUgc3VwZXJwYWdlIGZvciBncmFwaGljcyBvbiB0aGlzIGNoaXBzZXRcbiIpOworCWlvbW11
X3NraXBfaWdmeF9zdXBlcnBhZ2UgPSAxOworfQorCisvKiBHZW1pbmlsYWtlIGlnZnggYXBwZWFy
cyB0byBoYXZlIGlzc3VlcyB3aXRoIHN1cGVycGFnZSAqLworREVDTEFSRV9QQ0lfRklYVVBfSEVB
REVSKFBDSV9WRU5ET1JfSURfSU5URUwsIDB4MzE4NCwgcXVpcmtfc2tpcF9pZ2Z4X3N1cGVycGFn
ZSk7CitERUNMQVJFX1BDSV9GSVhVUF9IRUFERVIoUENJX1ZFTkRPUl9JRF9JTlRFTCwgMHgzMTg1
LCBxdWlya19za2lwX2lnZnhfc3VwZXJwYWdlKTsKKwogc3RhdGljIHZvaWQgcXVpcmtfaW9tbXVf
cndiZihzdHJ1Y3QgcGNpX2RldiAqZGV2KQogewogCWlmIChyaXNreV9kZXZpY2UoZGV2KSkKLS0g
CjIuMzEuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
aW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
