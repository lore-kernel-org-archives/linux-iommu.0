Return-Path: <SRS0=6oxg=MB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6EF5C07E9B
	for <iommu@archiver.kernel.org>; Fri,  9 Jul 2021 16:48:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D114613BC
	for <iommu@archiver.kernel.org>; Fri,  9 Jul 2021 16:48:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D114613BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E013C60B8B;
	Fri,  9 Jul 2021 16:48:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cVsxmBt-vq2J; Fri,  9 Jul 2021 16:48:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CDFA360B8C;
	Fri,  9 Jul 2021 16:48:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 52FDFC0023;
	Fri,  9 Jul 2021 16:48:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 03E2AC000E
 for <iommu@lists.linux-foundation.org>; Fri,  9 Jul 2021 16:48:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DAC4E60B8B
 for <iommu@lists.linux-foundation.org>; Fri,  9 Jul 2021 16:48:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vRzKk2kyl-nJ for <iommu@lists.linux-foundation.org>;
 Fri,  9 Jul 2021 16:48:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2909E6075D
 for <iommu@lists.linux-foundation.org>; Fri,  9 Jul 2021 16:47:59 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10039"; a="231499905"
X-IronPort-AV: E=Sophos;i="5.84,226,1620716400"; d="scan'208";a="231499905"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2021 09:47:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,226,1620716400"; d="scan'208";a="428834682"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.171])
 by orsmga002.jf.intel.com with SMTP; 09 Jul 2021 09:47:54 -0700
Received: by stinkbox (sSMTP sendmail emulation);
 Fri, 09 Jul 2021 19:47:53 +0300
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: intel-gfx@lists.freedesktop.org
Subject: [PATCH 1/4] iommu/vt-d: Disable superpage for Geminilake igfx
Date: Fri,  9 Jul 2021 19:47:47 +0300
Message-Id: <20210709164750.9465-2-ville.syrjala@linux.intel.com>
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
bmFibGVkIGl0IGZhaWxzIGluIGxlc3MgdGhhbgphIG1pbnV0ZSB1c3VhbGx5LgoKVE9ETzogbWln
aHQgYmUgbmljZSB0byBkaXNhYmxlIHN1cGVycGFnZSBvbmx5IGZvciB0aGUgaWdmeCBpb21tdQog
ICAgICBpbnN0ZWFkIG9mIGJvdGggaW9tbXVzClRPRE86IHdvdWxkIGJlIG5pY2UgdG8gdXNlIHRo
ZSBtYWNyb3MgZnJvbSBpbmNsdWRlL2RybS9pOTE1X3BjaWlkcy5oLAogICAgICBidXQgY2FuJ3Qg
ZG8gdGhhdCB3aXRoIERFQ0xBUkVfUENJX0ZJWFVQX0hFQURFUigpCgpDYzogRGF2aWQgV29vZGhv
dXNlIDxkd213MkBpbmZyYWRlYWQub3JnPgpDYzogTHUgQmFvbHUgPGJhb2x1Lmx1QGxpbnV4Lmlu
dGVsLmNvbT4KQ2M6IGlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnClNpZ25lZC1vZmYt
Ynk6IFZpbGxlIFN5cmrDpGzDpCA8dmlsbGUuc3lyamFsYUBsaW51eC5pbnRlbC5jb20+Ci0tLQog
ZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5jIHwgMTAgKysrKysrKysrKwogMSBmaWxlIGNoYW5n
ZWQsIDEwIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2ludGVsL2lv
bW11LmMgYi9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMKaW5kZXggMTljNzg4OGNiYjg2Li40
ZmZmMmM5Yzg2YWYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYworKysg
Yi9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMKQEAgLTU2MTcsNiArNTYxNywxNiBAQCBERUNM
QVJFX1BDSV9GSVhVUF9IRUFERVIoUENJX1ZFTkRPUl9JRF9JTlRFTCwgMHgxNjMyLCBxdWlya19p
b21tdV9pZ2Z4KTsKIERFQ0xBUkVfUENJX0ZJWFVQX0hFQURFUihQQ0lfVkVORE9SX0lEX0lOVEVM
LCAweDE2M0EsIHF1aXJrX2lvbW11X2lnZngpOwogREVDTEFSRV9QQ0lfRklYVVBfSEVBREVSKFBD
SV9WRU5ET1JfSURfSU5URUwsIDB4MTYzRCwgcXVpcmtfaW9tbXVfaWdmeCk7CiAKK3N0YXRpYyB2
b2lkIHF1aXJrX2lvbW11X25vc3Aoc3RydWN0IHBjaV9kZXYgKmRldikKK3sKKwlwY2lfaW5mbyhk
ZXYsICJEaXNhYmxpbmcgSU9NTVUgc3VwZXJwYWdlIGZvciBncmFwaGljcyBvbiB0aGlzIGNoaXBz
ZXRcbiIpOworCWludGVsX2lvbW11X3N1cGVycGFnZSA9IDA7Cit9CisKKy8qIEdlbWluaWxha2Ug
aWdmeCBhcHBlYXJzIHRvIGhhdmUgaXNzdWVzIHdpdGggc3VwZXJwYWdlICovCitERUNMQVJFX1BD
SV9GSVhVUF9IRUFERVIoUENJX1ZFTkRPUl9JRF9JTlRFTCwgMHgzMTg0LCBxdWlya19pb21tdV9u
b3NwKTsKK0RFQ0xBUkVfUENJX0ZJWFVQX0hFQURFUihQQ0lfVkVORE9SX0lEX0lOVEVMLCAweDMx
ODUsIHF1aXJrX2lvbW11X25vc3ApOworCiBzdGF0aWMgdm9pZCBxdWlya19pb21tdV9yd2JmKHN0
cnVjdCBwY2lfZGV2ICpkZXYpCiB7CiAJaWYgKHJpc2t5X2RldmljZShkZXYpKQotLSAKMi4zMS4x
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBt
YWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
