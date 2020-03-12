Return-Path: <SRS0=xT8t=45=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231D6C10DCE
	for <iommu@archiver.kernel.org>; Thu, 12 Mar 2020 06:12:40 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDBC320578
	for <iommu@archiver.kernel.org>; Thu, 12 Mar 2020 06:12:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDBC320578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 90B0987DAA;
	Thu, 12 Mar 2020 06:12:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BfKPTDyCqv0V; Thu, 12 Mar 2020 06:12:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0085A87B62;
	Thu, 12 Mar 2020 06:12:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E231DC18D3;
	Thu, 12 Mar 2020 06:12:38 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 649E8C0177
 for <iommu@lists.linux-foundation.org>; Thu, 12 Mar 2020 06:12:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 5335187B0F
 for <iommu@lists.linux-foundation.org>; Thu, 12 Mar 2020 06:12:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 62pyanEkwcEu for <iommu@lists.linux-foundation.org>;
 Thu, 12 Mar 2020 06:12:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by hemlock.osuosl.org (Postfix) with ESMTPS id BDEED87A39
 for <iommu@lists.linux-foundation.org>; Thu, 12 Mar 2020 06:12:36 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Mar 2020 23:12:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,543,1574150400"; d="scan'208";a="266226102"
Received: from allen-box.sh.intel.com ([10.239.159.139])
 by fmsmga004.fm.intel.com with ESMTP; 11 Mar 2020 23:12:35 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 2/2] iommu/vt-d: Ignore devices with out-of-spec domain number
Date: Thu, 12 Mar 2020 14:09:55 +0800
Message-Id: <20200312060955.8523-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200312060955.8523-1-baolu.lu@linux.intel.com>
References: <20200312060955.8523-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, Daniel Drake <drake@endlessm.com>
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

RnJvbTogRGFuaWVsIERyYWtlIDxkcmFrZUBlbmRsZXNzbS5jb20+CgpWTUQgc3ViZGV2aWNlcyBh
cmUgY3JlYXRlZCB3aXRoIGEgUENJIGRvbWFpbiBJRCBvZiAweDEwMDAwIG9yCmhpZ2hlci4KClRo
ZXNlIHN1YmRldmljZXMgYXJlIGFsc28gaGFuZGxlZCBsaWtlIGFsbCBvdGhlciBQQ0kgZGV2aWNl
cyBieQpkbWFyX3BjaV9idXNfbm90aWZpZXIoKS4KCkhvd2V2ZXIsIHdoZW4gZG1hcl9hbGxvY19w
Y2lfbm90aWZ5X2luZm8oKSB0YWtlIHJlY29yZHMgb2Ygc3VjaCBkZXZpY2VzLAppdCB3aWxsIHRy
dW5jYXRlIHRoZSBkb21haW4gSUQgdG8gYSB1MTYgdmFsdWUgKGluIGluZm8tPnNlZykuClRoZSBk
ZXZpY2UgYXQgKGUuZy4pIDEwMDAwOjAwOjAyLjAgaXMgdGhlbiB0cmVhdGVkIGJ5IHRoZSBETUFS
IGNvZGUgYXMgaWYKaXQgaXMgMDAwMDowMDowMi4wLgoKSW4gdGhlIHVubHVja3kgZXZlbnQgdGhh
dCBhIHJlYWwgZGV2aWNlIGFsc28gZXhpc3RzIGF0IDAwMDA6MDA6MDIuMCBhbmQKYWxzbyBoYXMg
YSBkZXZpY2Utc3BlY2lmaWMgZW50cnkgaW4gdGhlIERNQVIgdGFibGUsCmRtYXJfaW5zZXJ0X2Rl
dl9zY29wZSgpIHdpbGwgY3Jhc2ggb246CiDCoCBCVUdfT04oaSA+PSBkZXZpY2VzX2NudCk7CgpU
aGF0J3MgYmFzaWNhbGx5IGEgc2FuaXR5IGNoZWNrIHRoYXQgb25seSBvbmUgUENJIGRldmljZSBt
YXRjaGVzIGEKc2luZ2xlIERNQVIgZW50cnk7IGluIHRoaXMgY2FzZSB3ZSBzZWVtIHRvIGhhdmUg
dHdvIG1hdGNoaW5nIGRldmljZXMuCgpGaXggdGhpcyBieSBpZ25vcmluZyBkZXZpY2VzIHRoYXQg
aGF2ZSBhIGRvbWFpbiBudW1iZXIgaGlnaGVyIHRoYW4Kd2hhdCBjYW4gYmUgbG9va2VkIHVwIGlu
IHRoZSBETUFSIHRhYmxlLgoKVGhpcyBwcm9ibGVtIHdhcyBjYXJlZnVsbHkgZGlhZ25vc2VkIGJ5
IEppYW4tSG9uZyBQYW4uCgpTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgRHJha2UgPGRyYWtlQGVuZGxl
c3NtLmNvbT4KU2lnbmVkLW9mZi1ieTogTHUgQmFvbHUgPGJhb2x1Lmx1QGxpbnV4LmludGVsLmNv
bT4KLS0tCiBkcml2ZXJzL2lvbW11L2RtYXIuYyB8IDggKysrKysrKysKIDEgZmlsZSBjaGFuZ2Vk
LCA4IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2RtYXIuYyBiL2Ry
aXZlcnMvaW9tbXUvZG1hci5jCmluZGV4IGM3YjE0NjFlOGQwYS4uZjc3ZGFlN2JhN2Q0IDEwMDY0
NAotLS0gYS9kcml2ZXJzL2lvbW11L2RtYXIuYworKysgYi9kcml2ZXJzL2lvbW11L2RtYXIuYwpA
QCAtMjgsNiArMjgsNyBAQAogI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4KICNpbmNsdWRlIDxsaW51
eC9pb21tdS5oPgogI2luY2x1ZGUgPGxpbnV4L251bWEuaD4KKyNpbmNsdWRlIDxsaW51eC9saW1p
dHMuaD4KICNpbmNsdWRlIDxhc20vaXJxX3JlbWFwcGluZy5oPgogI2luY2x1ZGUgPGFzbS9pb21t
dV90YWJsZS5oPgogCkBAIC0xMjgsNiArMTI5LDEzIEBAIGRtYXJfYWxsb2NfcGNpX25vdGlmeV9p
bmZvKHN0cnVjdCBwY2lfZGV2ICpkZXYsIHVuc2lnbmVkIGxvbmcgZXZlbnQpCiAKIAlCVUdfT04o
ZGV2LT5pc192aXJ0Zm4pOwogCisJLyoKKwkgKiBJZ25vcmUgZGV2aWNlcyB0aGF0IGhhdmUgYSBk
b21haW4gbnVtYmVyIGhpZ2hlciB0aGFuIHdoYXQgY2FuCisJICogYmUgbG9va2VkIHVwIGluIERN
QVIsIGUuZy4gVk1EIHN1YmRldmljZXMgd2l0aCBkb21haW4gMHgxMDAwMAorCSAqLworCWlmIChw
Y2lfZG9tYWluX25yKGRldi0+YnVzKSA+IFUxNl9NQVgpCisJCXJldHVybiBOVUxMOworCiAJLyog
T25seSBnZW5lcmF0ZSBwYXRoW10gZm9yIGRldmljZSBhZGRpdGlvbiBldmVudCAqLwogCWlmIChl
dmVudCA9PSBCVVNfTk9USUZZX0FERF9ERVZJQ0UpCiAJCWZvciAodG1wID0gZGV2OyB0bXA7IHRt
cCA9IHRtcC0+YnVzLT5zZWxmKQotLSAKMi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vaW9tbXU=
