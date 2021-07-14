Return-Path: <SRS0=i+j8=MG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF6BC07E9A
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 13:19:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C61B611C0
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 13:19:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C61B611C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DA1AF83A41;
	Wed, 14 Jul 2021 13:19:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BpBdLOfx97XG; Wed, 14 Jul 2021 13:19:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C26D183BC1;
	Wed, 14 Jul 2021 13:19:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 97D0EC001A;
	Wed, 14 Jul 2021 13:19:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11FBBC000E
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 13:19:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E42AD803BE
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 13:18:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OO9HOnDc1n1G for <iommu@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 13:18:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 01B0D83B32
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 13:18:58 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10044"; a="197614231"
X-IronPort-AV: E=Sophos;i="5.84,239,1620716400"; d="scan'208";a="197614231"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2021 06:18:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,239,1620716400"; d="scan'208";a="459983615"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.171])
 by orsmga008.jf.intel.com with SMTP; 14 Jul 2021 06:18:48 -0700
Received: by stinkbox (sSMTP sendmail emulation);
 Wed, 14 Jul 2021 16:18:48 +0300
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: intel-gfx@lists.freedesktop.org
Subject: [PATCH v2 3/4] iommu/vt-d: Disable superpage for Skylake igfx
Date: Wed, 14 Jul 2021 16:18:36 +0300
Message-Id: <20210714131837.8978-4-ville.syrjala@linux.intel.com>
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

RnJvbTogVmlsbGUgU3lyasOkbMOkIDx2aWxsZS5zeXJqYWxhQGxpbnV4LmludGVsLmNvbT4KClNr
eWxha2UgaGFzIGtub3duIGlzc3VlcyB3aXRoIFZULWQgc3VwZXJwYWdlLiBOYW1lbHkgZnJhbWUg
YnVmZmVyCmNvbXByZXNzaW9uIChGQkMpIGNhbid0IGJlIHNhZmVseSB1c2VkIHdoZW4gc3VwZXJw
YWdlIGlzIGVuYWJsZWQuCkN1cnJlbnRseSB3ZSdyZSBkaXNhYmxpbmcgRkJDIGVudGlyZWx5IHdo
ZW4gVlQtZCBpcyBhY3RpdmUsIGJ1dApJIHRoaW5rIGp1c3QgZGlzYWJsaW5nIHN1cGVycGFnZSB3
b3VsZCBiZSBiZXR0ZXIgc2luY2UgRkJDIGNhbgpzYXZlIHNvbWUgcG93ZXIuCgpUT0RPOiB3b3Vs
ZCBiZSBuaWNlIHRvIHVzZSB0aGUgbWFjcm9zIGZyb20gaW5jbHVkZS9kcm0vaTkxNV9wY2lpZHMu
aCwKICAgICAgYnV0IGNhbid0IGRvIHRoYXQgd2l0aCBERUNMQVJFX1BDSV9GSVhVUF9IRUFERVIo
KQoKQ2M6IERhdmlkIFdvb2Rob3VzZSA8ZHdtdzJAaW5mcmFkZWFkLm9yZz4KQ2M6IEx1IEJhb2x1
IDxiYW9sdS5sdUBsaW51eC5pbnRlbC5jb20+CkNjOiBpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpTaWduZWQtb2ZmLWJ5OiBWaWxsZSBTeXJqw6Rsw6QgPHZpbGxlLnN5cmphbGFAbGlu
dXguaW50ZWwuY29tPgotLS0KIGRyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYyB8IDI3ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDI3IGluc2VydGlvbnMoKykK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMgYi9kcml2ZXJzL2lvbW11
L2ludGVsL2lvbW11LmMKaW5kZXggZWY3MTc5MDg2NDdkLi5lYTljNjlkYzEzZjUgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYworKysgYi9kcml2ZXJzL2lvbW11L2ludGVs
L2lvbW11LmMKQEAgLTU2ODEsNiArNTY4MSwzMyBAQCBzdGF0aWMgdm9pZCBxdWlya19za2lwX2ln
Znhfc3VwZXJwYWdlKHN0cnVjdCBwY2lfZGV2ICpkZXYpCiAJaW9tbXVfc2tpcF9pZ2Z4X3N1cGVy
cGFnZSA9IDE7CiB9CiAKKy8qIFNreWxha2UgaWdmeCBoYXMgaXNzdWVzIHdpdGggc3VwZXJwYWdl
ICovCitERUNMQVJFX1BDSV9GSVhVUF9IRUFERVIoUENJX1ZFTkRPUl9JRF9JTlRFTCwgMHgxOTA2
LCBxdWlya19za2lwX2lnZnhfc3VwZXJwYWdlKTsKK0RFQ0xBUkVfUENJX0ZJWFVQX0hFQURFUihQ
Q0lfVkVORE9SX0lEX0lOVEVMLCAweDE5MTMsIHF1aXJrX3NraXBfaWdmeF9zdXBlcnBhZ2UpOwor
REVDTEFSRV9QQ0lfRklYVVBfSEVBREVSKFBDSV9WRU5ET1JfSURfSU5URUwsIDB4MTkwRSwgcXVp
cmtfc2tpcF9pZ2Z4X3N1cGVycGFnZSk7CitERUNMQVJFX1BDSV9GSVhVUF9IRUFERVIoUENJX1ZF
TkRPUl9JRF9JTlRFTCwgMHgxOTE1LCBxdWlya19za2lwX2lnZnhfc3VwZXJwYWdlKTsKK0RFQ0xB
UkVfUENJX0ZJWFVQX0hFQURFUihQQ0lfVkVORE9SX0lEX0lOVEVMLCAweDE5MDIsIHF1aXJrX3Nr
aXBfaWdmeF9zdXBlcnBhZ2UpOworREVDTEFSRV9QQ0lfRklYVVBfSEVBREVSKFBDSV9WRU5ET1Jf
SURfSU5URUwsIDB4MTkwQSwgcXVpcmtfc2tpcF9pZ2Z4X3N1cGVycGFnZSk7CitERUNMQVJFX1BD
SV9GSVhVUF9IRUFERVIoUENJX1ZFTkRPUl9JRF9JTlRFTCwgMHgxOTBCLCBxdWlya19za2lwX2ln
Znhfc3VwZXJwYWdlKTsKK0RFQ0xBUkVfUENJX0ZJWFVQX0hFQURFUihQQ0lfVkVORE9SX0lEX0lO
VEVMLCAweDE5MTcsIHF1aXJrX3NraXBfaWdmeF9zdXBlcnBhZ2UpOworREVDTEFSRV9QQ0lfRklY
VVBfSEVBREVSKFBDSV9WRU5ET1JfSURfSU5URUwsIDB4MTkxNiwgcXVpcmtfc2tpcF9pZ2Z4X3N1
cGVycGFnZSk7CitERUNMQVJFX1BDSV9GSVhVUF9IRUFERVIoUENJX1ZFTkRPUl9JRF9JTlRFTCwg
MHgxOTIxLCBxdWlya19za2lwX2lnZnhfc3VwZXJwYWdlKTsKK0RFQ0xBUkVfUENJX0ZJWFVQX0hF
QURFUihQQ0lfVkVORE9SX0lEX0lOVEVMLCAweDE5MUUsIHF1aXJrX3NraXBfaWdmeF9zdXBlcnBh
Z2UpOworREVDTEFSRV9QQ0lfRklYVVBfSEVBREVSKFBDSV9WRU5ET1JfSURfSU5URUwsIDB4MTkx
MiwgcXVpcmtfc2tpcF9pZ2Z4X3N1cGVycGFnZSk7CitERUNMQVJFX1BDSV9GSVhVUF9IRUFERVIo
UENJX1ZFTkRPUl9JRF9JTlRFTCwgMHgxOTFBLCBxdWlya19za2lwX2lnZnhfc3VwZXJwYWdlKTsK
K0RFQ0xBUkVfUENJX0ZJWFVQX0hFQURFUihQQ0lfVkVORE9SX0lEX0lOVEVMLCAweDE5MUIsIHF1
aXJrX3NraXBfaWdmeF9zdXBlcnBhZ2UpOworREVDTEFSRV9QQ0lfRklYVVBfSEVBREVSKFBDSV9W
RU5ET1JfSURfSU5URUwsIDB4MTkxRCwgcXVpcmtfc2tpcF9pZ2Z4X3N1cGVycGFnZSk7CitERUNM
QVJFX1BDSV9GSVhVUF9IRUFERVIoUENJX1ZFTkRPUl9JRF9JTlRFTCwgMHgxOTIzLCBxdWlya19z
a2lwX2lnZnhfc3VwZXJwYWdlKTsKK0RFQ0xBUkVfUENJX0ZJWFVQX0hFQURFUihQQ0lfVkVORE9S
X0lEX0lOVEVMLCAweDE5MjYsIHF1aXJrX3NraXBfaWdmeF9zdXBlcnBhZ2UpOworREVDTEFSRV9Q
Q0lfRklYVVBfSEVBREVSKFBDSV9WRU5ET1JfSURfSU5URUwsIDB4MTkyNywgcXVpcmtfc2tpcF9p
Z2Z4X3N1cGVycGFnZSk7CitERUNMQVJFX1BDSV9GSVhVUF9IRUFERVIoUENJX1ZFTkRPUl9JRF9J
TlRFTCwgMHgxOTJBLCBxdWlya19za2lwX2lnZnhfc3VwZXJwYWdlKTsKK0RFQ0xBUkVfUENJX0ZJ
WFVQX0hFQURFUihQQ0lfVkVORE9SX0lEX0lOVEVMLCAweDE5MkIsIHF1aXJrX3NraXBfaWdmeF9z
dXBlcnBhZ2UpOworREVDTEFSRV9QQ0lfRklYVVBfSEVBREVSKFBDSV9WRU5ET1JfSURfSU5URUws
IDB4MTkyRCwgcXVpcmtfc2tpcF9pZ2Z4X3N1cGVycGFnZSk7CitERUNMQVJFX1BDSV9GSVhVUF9I
RUFERVIoUENJX1ZFTkRPUl9JRF9JTlRFTCwgMHgxOTMyLCBxdWlya19za2lwX2lnZnhfc3VwZXJw
YWdlKTsKK0RFQ0xBUkVfUENJX0ZJWFVQX0hFQURFUihQQ0lfVkVORE9SX0lEX0lOVEVMLCAweDE5
M0EsIHF1aXJrX3NraXBfaWdmeF9zdXBlcnBhZ2UpOworREVDTEFSRV9QQ0lfRklYVVBfSEVBREVS
KFBDSV9WRU5ET1JfSURfSU5URUwsIDB4MTkzQiwgcXVpcmtfc2tpcF9pZ2Z4X3N1cGVycGFnZSk7
CitERUNMQVJFX1BDSV9GSVhVUF9IRUFERVIoUENJX1ZFTkRPUl9JRF9JTlRFTCwgMHgxOTNELCBx
dWlya19za2lwX2lnZnhfc3VwZXJwYWdlKTsKKwogLyogQnJveHRvbiBpZ2Z4IGhhcyBpc3N1ZXMg
d2l0aCBzdXBlcnBhZ2UgKi8KIERFQ0xBUkVfUENJX0ZJWFVQX0hFQURFUihQQ0lfVkVORE9SX0lE
X0lOVEVMLCAweDBBODQsIHF1aXJrX3NraXBfaWdmeF9zdXBlcnBhZ2UpOwogREVDTEFSRV9QQ0lf
RklYVVBfSEVBREVSKFBDSV9WRU5ET1JfSURfSU5URUwsIDB4MUE4NCwgcXVpcmtfc2tpcF9pZ2Z4
X3N1cGVycGFnZSk7Ci0tIAoyLjMxLjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby9pb21tdQ==
