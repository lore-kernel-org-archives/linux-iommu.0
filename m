Return-Path: <SRS0=6oxg=MB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A848FC07E99
	for <iommu@archiver.kernel.org>; Fri,  9 Jul 2021 16:48:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55AEB613C8
	for <iommu@archiver.kernel.org>; Fri,  9 Jul 2021 16:48:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55AEB613C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3488E41D8F;
	Fri,  9 Jul 2021 16:48:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0mkwIkXcb87A; Fri,  9 Jul 2021 16:48:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 25DBF41D9B;
	Fri,  9 Jul 2021 16:48:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 03A37C0010;
	Fri,  9 Jul 2021 16:48:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B24DC000E
 for <iommu@lists.linux-foundation.org>; Fri,  9 Jul 2021 16:48:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5AB8283CFF
 for <iommu@lists.linux-foundation.org>; Fri,  9 Jul 2021 16:48:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id liodtXyfX7Xw for <iommu@lists.linux-foundation.org>;
 Fri,  9 Jul 2021 16:48:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9BC0D83CDC
 for <iommu@lists.linux-foundation.org>; Fri,  9 Jul 2021 16:48:10 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10039"; a="273565518"
X-IronPort-AV: E=Sophos;i="5.84,226,1620716400"; d="scan'208";a="273565518"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2021 09:48:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,226,1620716400"; d="scan'208";a="450352609"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.171])
 by orsmga007.jf.intel.com with SMTP; 09 Jul 2021 09:48:04 -0700
Received: by stinkbox (sSMTP sendmail emulation);
 Fri, 09 Jul 2021 19:48:04 +0300
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: intel-gfx@lists.freedesktop.org
Subject: [PATCH 4/4] drm/i915/fbc: Allow FBC + VT-d on SKL/BXT
Date: Fri,  9 Jul 2021 19:47:50 +0300
Message-Id: <20210709164750.9465-5-ville.syrjala@linux.intel.com>
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

RnJvbTogVmlsbGUgU3lyasOkbMOkIDx2aWxsZS5zeXJqYWxhQGxpbnV4LmludGVsLmNvbT4KCldp
dGggdGhlIGlvbW11IGRyaXZlciBkaXNhYmxpbmcgVlQtZCBzdXBlcnBhZ2UgaXQgc2hvdWxkIGJl
CnNhZmUgdG8gdXNlIEZCQyBvbiBTS0wvQlhUIHdpdGggVlQtZCBvdGhlcndpc2UgZW5hYmxlZC4K
CkNjOiBEYXZpZCBXb29kaG91c2UgPGR3bXcyQGluZnJhZGVhZC5vcmc+CkNjOiBMdSBCYW9sdSA8
YmFvbHUubHVAbGludXguaW50ZWwuY29tPgpDYzogaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKU2lnbmVkLW9mZi1ieTogVmlsbGUgU3lyasOkbMOkIDx2aWxsZS5zeXJqYWxhQGxpbnV4
LmludGVsLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2ZiYy5j
IHwgMTYgLS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDE2IGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfZmJjLmMgYi9k
cml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2ZiYy5jCmluZGV4IDgyZWZmYjY0YTNi
OS4uZGU0NGY5M2EzM2QwIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5
L2ludGVsX2ZiYy5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfZmJj
LmMKQEAgLTE0NDgsMTkgKzE0NDgsNiBAQCBzdGF0aWMgaW50IGludGVsX3Nhbml0aXplX2ZiY19v
cHRpb24oc3RydWN0IGRybV9pOTE1X3ByaXZhdGUgKmRldl9wcml2KQogCXJldHVybiAwOwogfQog
Ci1zdGF0aWMgYm9vbCBuZWVkX2ZiY192dGRfd2Eoc3RydWN0IGRybV9pOTE1X3ByaXZhdGUgKmRl
dl9wcml2KQotewotCS8qIFdhRmJjVHVybk9mZkZiY1doZW5IeXBlclZpc29ySXNVc2VkOnNrbCxi
eHQgKi8KLQlpZiAoaW50ZWxfdnRkX2FjdGl2ZSgpICYmCi0JICAgIChJU19TS1lMQUtFKGRldl9w
cml2KSB8fCBJU19CUk9YVE9OKGRldl9wcml2KSkpIHsKLQkJZHJtX2luZm8oJmRldl9wcml2LT5k
cm0sCi0JCQkgIkRpc2FibGluZyBmcmFtZWJ1ZmZlciBjb21wcmVzc2lvbiAoRkJDKSB0byBwcmV2
ZW50IHNjcmVlbiBmbGlja2VyIHdpdGggVlQtZCBlbmFibGVkXG4iKTsKLQkJcmV0dXJuIHRydWU7
Ci0JfQotCi0JcmV0dXJuIGZhbHNlOwotfQotCiAvKioKICAqIGludGVsX2ZiY19pbml0IC0gSW5p
dGlhbGl6ZSBGQkMKICAqIEBkZXZfcHJpdjogdGhlIGk5MTUgZGV2aWNlCkBAIC0xNDc4LDkgKzE0
NjUsNiBAQCB2b2lkIGludGVsX2ZiY19pbml0KHN0cnVjdCBkcm1faTkxNV9wcml2YXRlICpkZXZf
cHJpdikKIAlpZiAoIWRybV9tbV9pbml0aWFsaXplZCgmZGV2X3ByaXYtPm1tLnN0b2xlbikpCiAJ
CW1rd3JpdGVfZGV2aWNlX2luZm8oZGV2X3ByaXYpLT5kaXNwbGF5Lmhhc19mYmMgPSBmYWxzZTsK
IAotCWlmIChuZWVkX2ZiY192dGRfd2EoZGV2X3ByaXYpKQotCQlta3dyaXRlX2RldmljZV9pbmZv
KGRldl9wcml2KS0+ZGlzcGxheS5oYXNfZmJjID0gZmFsc2U7Ci0KIAlkZXZfcHJpdi0+cGFyYW1z
LmVuYWJsZV9mYmMgPSBpbnRlbF9zYW5pdGl6ZV9mYmNfb3B0aW9uKGRldl9wcml2KTsKIAlkcm1f
ZGJnX2ttcygmZGV2X3ByaXYtPmRybSwgIlNhbml0aXplZCBlbmFibGVfZmJjIHZhbHVlOiAlZFxu
IiwKIAkJICAgIGRldl9wcml2LT5wYXJhbXMuZW5hYmxlX2ZiYyk7Ci0tIAoyLjMxLjEKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcg
bGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
