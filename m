Return-Path: <SRS0=6oxg=MB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90399C07E9C
	for <iommu@archiver.kernel.org>; Fri,  9 Jul 2021 16:48:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0197D613C8
	for <iommu@archiver.kernel.org>; Fri,  9 Jul 2021 16:48:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0197D613C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CCFEF41DA0;
	Fri,  9 Jul 2021 16:48:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xfd8PP19U64o; Fri,  9 Jul 2021 16:48:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C2F7341D84;
	Fri,  9 Jul 2021 16:48:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 976B0C0010;
	Fri,  9 Jul 2021 16:48:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ECD24C000E
 for <iommu@lists.linux-foundation.org>; Fri,  9 Jul 2021 16:48:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D7D5383C67
 for <iommu@lists.linux-foundation.org>; Fri,  9 Jul 2021 16:48:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XPGMgduG2Ypv for <iommu@lists.linux-foundation.org>;
 Fri,  9 Jul 2021 16:48:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 75E8F83CFF
 for <iommu@lists.linux-foundation.org>; Fri,  9 Jul 2021 16:48:04 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10039"; a="207908805"
X-IronPort-AV: E=Sophos;i="5.84,226,1620716400"; d="scan'208";a="207908805"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2021 09:48:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,226,1620716400"; d="scan'208";a="411326412"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.171])
 by orsmga006.jf.intel.com with SMTP; 09 Jul 2021 09:47:57 -0700
Received: by stinkbox (sSMTP sendmail emulation);
 Fri, 09 Jul 2021 19:47:57 +0300
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: intel-gfx@lists.freedesktop.org
Subject: [PATCH 2/4] iommu/vt-d: Disable superpage for Broxton igfx
Date: Fri,  9 Jul 2021 19:47:48 +0300
Message-Id: <20210709164750.9465-3-ville.syrjala@linux.intel.com>
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

RnJvbTogVmlsbGUgU3lyasOkbMOkIDx2aWxsZS5zeXJqYWxhQGxpbnV4LmludGVsLmNvbT4KCkJy
b3h0b24gaGFzIGtub3duIGlzc3VlcyB3aXRoIFZULWQgc3VwZXJwYWdlLiBOYW1lbHkgZnJhbWUg
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
cml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMgfCA3ICsrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA3
IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMg
Yi9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMKaW5kZXggNGZmZjJjOWM4NmFmLi40MDExN2Y4
Njg3NjEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYworKysgYi9kcml2
ZXJzL2lvbW11L2ludGVsL2lvbW11LmMKQEAgLTU2MjMsNiArNTYyMywxMyBAQCBzdGF0aWMgdm9p
ZCBxdWlya19pb21tdV9ub3NwKHN0cnVjdCBwY2lfZGV2ICpkZXYpCiAJaW50ZWxfaW9tbXVfc3Vw
ZXJwYWdlID0gMDsKIH0KIAorLyogQnJveHRvbiBpZ2Z4IGhhcyBpc3N1ZXMgd2l0aCBzdXBlcnBh
Z2UgKi8KK0RFQ0xBUkVfUENJX0ZJWFVQX0hFQURFUihQQ0lfVkVORE9SX0lEX0lOVEVMLCAweDBB
ODQsIHF1aXJrX2lvbW11X25vc3ApOworREVDTEFSRV9QQ0lfRklYVVBfSEVBREVSKFBDSV9WRU5E
T1JfSURfSU5URUwsIDB4MUE4NCwgcXVpcmtfaW9tbXVfbm9zcCk7CitERUNMQVJFX1BDSV9GSVhV
UF9IRUFERVIoUENJX1ZFTkRPUl9JRF9JTlRFTCwgMHgxQTg1LCBxdWlya19pb21tdV9ub3NwKTsK
K0RFQ0xBUkVfUENJX0ZJWFVQX0hFQURFUihQQ0lfVkVORE9SX0lEX0lOVEVMLCAweDVBODQsIHF1
aXJrX2lvbW11X25vc3ApOworREVDTEFSRV9QQ0lfRklYVVBfSEVBREVSKFBDSV9WRU5ET1JfSURf
SU5URUwsIDB4NUE4NSwgcXVpcmtfaW9tbXVfbm9zcCk7CisKIC8qIEdlbWluaWxha2UgaWdmeCBh
cHBlYXJzIHRvIGhhdmUgaXNzdWVzIHdpdGggc3VwZXJwYWdlICovCiBERUNMQVJFX1BDSV9GSVhV
UF9IRUFERVIoUENJX1ZFTkRPUl9JRF9JTlRFTCwgMHgzMTg0LCBxdWlya19pb21tdV9ub3NwKTsK
IERFQ0xBUkVfUENJX0ZJWFVQX0hFQURFUihQQ0lfVkVORE9SX0lEX0lOVEVMLCAweDMxODUsIHF1
aXJrX2lvbW11X25vc3ApOwotLSAKMi4zMS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vaW9tbXU=
