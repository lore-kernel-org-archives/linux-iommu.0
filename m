Return-Path: <SRS0=6oxg=MB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA9BC07E9E
	for <iommu@archiver.kernel.org>; Fri,  9 Jul 2021 16:48:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B819613C8
	for <iommu@archiver.kernel.org>; Fri,  9 Jul 2021 16:48:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B819613C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 46D4442401;
	Fri,  9 Jul 2021 16:48:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ndgvwPyVzx0S; Fri,  9 Jul 2021 16:48:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E2109423E1;
	Fri,  9 Jul 2021 16:48:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC294C0010;
	Fri,  9 Jul 2021 16:48:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF885C000E
 for <iommu@lists.linux-foundation.org>; Fri,  9 Jul 2021 16:48:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CD6C541DA5
 for <iommu@lists.linux-foundation.org>; Fri,  9 Jul 2021 16:48:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UyGinCFwOiiK for <iommu@lists.linux-foundation.org>;
 Fri,  9 Jul 2021 16:48:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 028D041D8F
 for <iommu@lists.linux-foundation.org>; Fri,  9 Jul 2021 16:48:06 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10039"; a="209548559"
X-IronPort-AV: E=Sophos;i="5.84,226,1620716400"; d="scan'208";a="209548559"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2021 09:48:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,226,1620716400"; d="scan'208";a="424497599"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.171])
 by fmsmga007.fm.intel.com with SMTP; 09 Jul 2021 09:48:01 -0700
Received: by stinkbox (sSMTP sendmail emulation);
 Fri, 09 Jul 2021 19:48:00 +0300
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: intel-gfx@lists.freedesktop.org
Subject: [PATCH 3/4] iommu/vt-d: Disable superpage for Skylake igfx
Date: Fri,  9 Jul 2021 19:47:49 +0300
Message-Id: <20210709164750.9465-4-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210709164750.9465-1-ville.syrjala@linux.intel.com>
References: <20210709164750.9465-1-ville.syrjala@linux.intel.com>
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
b3VsZCBiZSBiZXR0ZXIgc2luY2UgRkJDIGNhbgpzYXZlIHNvbWUgcG93ZXIuCgpUT0RPOiBtaWdo
dCBiZSBuaWNlIHRvIGRpc2FibGUgc3VwZXJwYWdlIG9ubHkgZm9yIHRoZSBpZ2Z4IGlvbW11CiAg
ICAgIGluc3RlYWQgb2YgYm90aCBpb21tdXMKVE9ETzogd291bGQgYmUgbmljZSB0byB1c2UgdGhl
IG1hY3JvcyBmcm9tIGluY2x1ZGUvZHJtL2k5MTVfcGNpaWRzLmgsCiAgICAgIGJ1dCBjYW4ndCBk
byB0aGF0IHdpdGggREVDTEFSRV9QQ0lfRklYVVBfSEVBREVSKCkKCkNjOiBEYXZpZCBXb29kaG91
c2UgPGR3bXcyQGluZnJhZGVhZC5vcmc+CkNjOiBMdSBCYW9sdSA8YmFvbHUubHVAbGludXguaW50
ZWwuY29tPgpDYzogaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKU2lnbmVkLW9mZi1i
eTogVmlsbGUgU3lyasOkbMOkIDx2aWxsZS5zeXJqYWxhQGxpbnV4LmludGVsLmNvbT4KLS0tCiBk
cml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMgfCAyNyArKysrKysrKysrKysrKysrKysrKysrKysr
KysKIDEgZmlsZSBjaGFuZ2VkLCAyNyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9pb21tdS9pbnRlbC9pb21tdS5jIGIvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5jCmluZGV4
IDQwMTE3Zjg2ODc2MS4uMTRmOTUxY2E0Nzk5IDEwMDY0NAotLS0gYS9kcml2ZXJzL2lvbW11L2lu
dGVsL2lvbW11LmMKKysrIGIvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5jCkBAIC01NjIzLDYg
KzU2MjMsMzMgQEAgc3RhdGljIHZvaWQgcXVpcmtfaW9tbXVfbm9zcChzdHJ1Y3QgcGNpX2RldiAq
ZGV2KQogCWludGVsX2lvbW11X3N1cGVycGFnZSA9IDA7CiB9CiAKKy8qIFNreWxha2UgaWdmeCBo
YXMgaXNzdWVzIHdpdGggc3VwZXJwYWdlICovCitERUNMQVJFX1BDSV9GSVhVUF9IRUFERVIoUENJ
X1ZFTkRPUl9JRF9JTlRFTCwgMHgxOTA2LCBxdWlya19pb21tdV9ub3NwKTsKK0RFQ0xBUkVfUENJ
X0ZJWFVQX0hFQURFUihQQ0lfVkVORE9SX0lEX0lOVEVMLCAweDE5MTMsIHF1aXJrX2lvbW11X25v
c3ApOworREVDTEFSRV9QQ0lfRklYVVBfSEVBREVSKFBDSV9WRU5ET1JfSURfSU5URUwsIDB4MTkw
RSwgcXVpcmtfaW9tbXVfbm9zcCk7CitERUNMQVJFX1BDSV9GSVhVUF9IRUFERVIoUENJX1ZFTkRP
Ul9JRF9JTlRFTCwgMHgxOTE1LCBxdWlya19pb21tdV9ub3NwKTsKK0RFQ0xBUkVfUENJX0ZJWFVQ
X0hFQURFUihQQ0lfVkVORE9SX0lEX0lOVEVMLCAweDE5MDIsIHF1aXJrX2lvbW11X25vc3ApOwor
REVDTEFSRV9QQ0lfRklYVVBfSEVBREVSKFBDSV9WRU5ET1JfSURfSU5URUwsIDB4MTkwQSwgcXVp
cmtfaW9tbXVfbm9zcCk7CitERUNMQVJFX1BDSV9GSVhVUF9IRUFERVIoUENJX1ZFTkRPUl9JRF9J
TlRFTCwgMHgxOTBCLCBxdWlya19pb21tdV9ub3NwKTsKK0RFQ0xBUkVfUENJX0ZJWFVQX0hFQURF
UihQQ0lfVkVORE9SX0lEX0lOVEVMLCAweDE5MTcsIHF1aXJrX2lvbW11X25vc3ApOworREVDTEFS
RV9QQ0lfRklYVVBfSEVBREVSKFBDSV9WRU5ET1JfSURfSU5URUwsIDB4MTkxNiwgcXVpcmtfaW9t
bXVfbm9zcCk7CitERUNMQVJFX1BDSV9GSVhVUF9IRUFERVIoUENJX1ZFTkRPUl9JRF9JTlRFTCwg
MHgxOTIxLCBxdWlya19pb21tdV9ub3NwKTsKK0RFQ0xBUkVfUENJX0ZJWFVQX0hFQURFUihQQ0lf
VkVORE9SX0lEX0lOVEVMLCAweDE5MUUsIHF1aXJrX2lvbW11X25vc3ApOworREVDTEFSRV9QQ0lf
RklYVVBfSEVBREVSKFBDSV9WRU5ET1JfSURfSU5URUwsIDB4MTkxMiwgcXVpcmtfaW9tbXVfbm9z
cCk7CitERUNMQVJFX1BDSV9GSVhVUF9IRUFERVIoUENJX1ZFTkRPUl9JRF9JTlRFTCwgMHgxOTFB
LCBxdWlya19pb21tdV9ub3NwKTsKK0RFQ0xBUkVfUENJX0ZJWFVQX0hFQURFUihQQ0lfVkVORE9S
X0lEX0lOVEVMLCAweDE5MUIsIHF1aXJrX2lvbW11X25vc3ApOworREVDTEFSRV9QQ0lfRklYVVBf
SEVBREVSKFBDSV9WRU5ET1JfSURfSU5URUwsIDB4MTkxRCwgcXVpcmtfaW9tbXVfbm9zcCk7CitE
RUNMQVJFX1BDSV9GSVhVUF9IRUFERVIoUENJX1ZFTkRPUl9JRF9JTlRFTCwgMHgxOTIzLCBxdWly
a19pb21tdV9ub3NwKTsKK0RFQ0xBUkVfUENJX0ZJWFVQX0hFQURFUihQQ0lfVkVORE9SX0lEX0lO
VEVMLCAweDE5MjYsIHF1aXJrX2lvbW11X25vc3ApOworREVDTEFSRV9QQ0lfRklYVVBfSEVBREVS
KFBDSV9WRU5ET1JfSURfSU5URUwsIDB4MTkyNywgcXVpcmtfaW9tbXVfbm9zcCk7CitERUNMQVJF
X1BDSV9GSVhVUF9IRUFERVIoUENJX1ZFTkRPUl9JRF9JTlRFTCwgMHgxOTJBLCBxdWlya19pb21t
dV9ub3NwKTsKK0RFQ0xBUkVfUENJX0ZJWFVQX0hFQURFUihQQ0lfVkVORE9SX0lEX0lOVEVMLCAw
eDE5MkIsIHF1aXJrX2lvbW11X25vc3ApOworREVDTEFSRV9QQ0lfRklYVVBfSEVBREVSKFBDSV9W
RU5ET1JfSURfSU5URUwsIDB4MTkyRCwgcXVpcmtfaW9tbXVfbm9zcCk7CitERUNMQVJFX1BDSV9G
SVhVUF9IRUFERVIoUENJX1ZFTkRPUl9JRF9JTlRFTCwgMHgxOTMyLCBxdWlya19pb21tdV9ub3Nw
KTsKK0RFQ0xBUkVfUENJX0ZJWFVQX0hFQURFUihQQ0lfVkVORE9SX0lEX0lOVEVMLCAweDE5M0Es
IHF1aXJrX2lvbW11X25vc3ApOworREVDTEFSRV9QQ0lfRklYVVBfSEVBREVSKFBDSV9WRU5ET1Jf
SURfSU5URUwsIDB4MTkzQiwgcXVpcmtfaW9tbXVfbm9zcCk7CitERUNMQVJFX1BDSV9GSVhVUF9I
RUFERVIoUENJX1ZFTkRPUl9JRF9JTlRFTCwgMHgxOTNELCBxdWlya19pb21tdV9ub3NwKTsKKwog
LyogQnJveHRvbiBpZ2Z4IGhhcyBpc3N1ZXMgd2l0aCBzdXBlcnBhZ2UgKi8KIERFQ0xBUkVfUENJ
X0ZJWFVQX0hFQURFUihQQ0lfVkVORE9SX0lEX0lOVEVMLCAweDBBODQsIHF1aXJrX2lvbW11X25v
c3ApOwogREVDTEFSRV9QQ0lfRklYVVBfSEVBREVSKFBDSV9WRU5ET1JfSURfSU5URUwsIDB4MUE4
NCwgcXVpcmtfaW9tbXVfbm9zcCk7Ci0tIAoyLjMxLjEKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby9pb21tdQ==
