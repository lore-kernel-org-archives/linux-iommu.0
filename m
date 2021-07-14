Return-Path: <SRS0=i+j8=MG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3791AC11F66
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 13:18:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2DDF613BF
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 13:18:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2DDF613BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8BFE040289;
	Wed, 14 Jul 2021 13:18:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pelXrA4e-bbJ; Wed, 14 Jul 2021 13:18:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 388AF40281;
	Wed, 14 Jul 2021 13:18:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 13669C0010;
	Wed, 14 Jul 2021 13:18:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 98021C000E
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 13:18:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7A08240001
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 13:18:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LtR-n0iL3kPp for <iommu@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 13:18:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 22EF340267
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 13:18:47 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10044"; a="190720378"
X-IronPort-AV: E=Sophos;i="5.84,239,1620716400"; d="scan'208";a="190720378"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2021 06:18:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,239,1620716400"; d="scan'208";a="505253480"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.171])
 by fmsmga002.fm.intel.com with SMTP; 14 Jul 2021 06:18:45 -0700
Received: by stinkbox (sSMTP sendmail emulation);
 Wed, 14 Jul 2021 16:18:44 +0300
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: intel-gfx@lists.freedesktop.org
Subject: [PATCH v2 2/4] iommu/vt-d: Disable superpage for Broxton igfx
Date: Wed, 14 Jul 2021 16:18:35 +0300
Message-Id: <20210714131837.8978-3-ville.syrjala@linux.intel.com>
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

RnJvbTogVmlsbGUgU3lyasOkbMOkIDx2aWxsZS5zeXJqYWxhQGxpbnV4LmludGVsLmNvbT4KCkJy
b3h0b24gaGFzIGtub3duIGlzc3VlcyB3aXRoIFZULWQgc3VwZXJwYWdlLiBOYW1lbHkgZnJhbWUg
YnVmZmVyCmNvbXByZXNzaW9uIChGQkMpIGNhbid0IGJlIHNhZmVseSB1c2VkIHdoZW4gc3VwZXJw
YWdlIGlzIGVuYWJsZWQuCkN1cnJlbnRseSB3ZSdyZSBkaXNhYmxpbmcgRkJDIGVudGlyZWx5IHdo
ZW4gVlQtZCBpcyBhY3RpdmUsIGJ1dApJIHRoaW5rIGp1c3QgZGlzYWJsaW5nIHN1cGVycGFnZSB3
b3VsZCBiZSBiZXR0ZXIgc2luY2UgRkJDIGNhbgpzYXZlIHNvbWUgcG93ZXIuCgpUT0RPOiB3b3Vs
ZCBiZSBuaWNlIHRvIHVzZSB0aGUgbWFjcm9zIGZyb20gaW5jbHVkZS9kcm0vaTkxNV9wY2lpZHMu
aCwKICAgICAgYnV0IGNhbid0IGRvIHRoYXQgd2l0aCBERUNMQVJFX1BDSV9GSVhVUF9IRUFERVIo
KQoKQ2M6IERhdmlkIFdvb2Rob3VzZSA8ZHdtdzJAaW5mcmFkZWFkLm9yZz4KQ2M6IEx1IEJhb2x1
IDxiYW9sdS5sdUBsaW51eC5pbnRlbC5jb20+CkNjOiBpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpTaWduZWQtb2ZmLWJ5OiBWaWxsZSBTeXJqw6Rsw6QgPHZpbGxlLnN5cmphbGFAbGlu
dXguaW50ZWwuY29tPgotLS0KIGRyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYyB8IDcgKysrKysr
KwogMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
aW9tbXUvaW50ZWwvaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYwppbmRleCAw
OGJhNDEyMDUzZTMuLmVmNzE3OTA4NjQ3ZCAxMDA2NDQKLS0tIGEvZHJpdmVycy9pb21tdS9pbnRl
bC9pb21tdS5jCisrKyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYwpAQCAtNTY4MSw2ICs1
NjgxLDEzIEBAIHN0YXRpYyB2b2lkIHF1aXJrX3NraXBfaWdmeF9zdXBlcnBhZ2Uoc3RydWN0IHBj
aV9kZXYgKmRldikKIAlpb21tdV9za2lwX2lnZnhfc3VwZXJwYWdlID0gMTsKIH0KIAorLyogQnJv
eHRvbiBpZ2Z4IGhhcyBpc3N1ZXMgd2l0aCBzdXBlcnBhZ2UgKi8KK0RFQ0xBUkVfUENJX0ZJWFVQ
X0hFQURFUihQQ0lfVkVORE9SX0lEX0lOVEVMLCAweDBBODQsIHF1aXJrX3NraXBfaWdmeF9zdXBl
cnBhZ2UpOworREVDTEFSRV9QQ0lfRklYVVBfSEVBREVSKFBDSV9WRU5ET1JfSURfSU5URUwsIDB4
MUE4NCwgcXVpcmtfc2tpcF9pZ2Z4X3N1cGVycGFnZSk7CitERUNMQVJFX1BDSV9GSVhVUF9IRUFE
RVIoUENJX1ZFTkRPUl9JRF9JTlRFTCwgMHgxQTg1LCBxdWlya19za2lwX2lnZnhfc3VwZXJwYWdl
KTsKK0RFQ0xBUkVfUENJX0ZJWFVQX0hFQURFUihQQ0lfVkVORE9SX0lEX0lOVEVMLCAweDVBODQs
IHF1aXJrX3NraXBfaWdmeF9zdXBlcnBhZ2UpOworREVDTEFSRV9QQ0lfRklYVVBfSEVBREVSKFBD
SV9WRU5ET1JfSURfSU5URUwsIDB4NUE4NSwgcXVpcmtfc2tpcF9pZ2Z4X3N1cGVycGFnZSk7CisK
IC8qIEdlbWluaWxha2UgaWdmeCBhcHBlYXJzIHRvIGhhdmUgaXNzdWVzIHdpdGggc3VwZXJwYWdl
ICovCiBERUNMQVJFX1BDSV9GSVhVUF9IRUFERVIoUENJX1ZFTkRPUl9JRF9JTlRFTCwgMHgzMTg0
LCBxdWlya19za2lwX2lnZnhfc3VwZXJwYWdlKTsKIERFQ0xBUkVfUENJX0ZJWFVQX0hFQURFUihQ
Q0lfVkVORE9SX0lEX0lOVEVMLCAweDMxODUsIHF1aXJrX3NraXBfaWdmeF9zdXBlcnBhZ2UpOwot
LSAKMi4zMS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
