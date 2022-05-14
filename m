Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD6E2C433EF
	for <iommu@archiver.kernel.org>; Sat, 14 May 2022 01:47:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 81D4D82F03;
	Sat, 14 May 2022 01:47:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HtwtSyUE-esG; Sat, 14 May 2022 01:47:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6CAB0828B5;
	Sat, 14 May 2022 01:47:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 48079C0032;
	Sat, 14 May 2022 01:47:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9E953C002D
 for <iommu@lists.linux-foundation.org>; Sat, 14 May 2022 01:46:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8E0E1828DA
 for <iommu@lists.linux-foundation.org>; Sat, 14 May 2022 01:46:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EiguF57jmzx0 for <iommu@lists.linux-foundation.org>;
 Sat, 14 May 2022 01:46:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F27D2828B5
 for <iommu@lists.linux-foundation.org>; Sat, 14 May 2022 01:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652492818; x=1684028818;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KozZnrzYJ+0UFKmzjAu1U8Z4jZPTgTst8scozy/7ge4=;
 b=mLZKmH1WEWsJdgCUhgqhYAxEFrehXGPHU9kK7pIXqBM0ifshOL/vLrap
 QXiFEB1auBi1MDEjeNNIztlzFU89hVjujp2YnrR2x+5qiqrxjKpEWr2n9
 9cXls4+4EI43OnSsaLiSd9abLyXAeadpLz+t8oFB7mgx61HL655zmx74u
 lSKTXK3a6UQclbgDviqDplJqBXRZefiQu1GlgkOszl6k8g0qmup0TWCVJ
 Vo2Cps0rfhLr3UJlIkLLny62gZB67PzHdOIyVCSCd3XIqc6jd7nXBWd7T
 eKqCgBvORAvXi1xaxhxnNeTw1GgXaJHageDwkfjTYhetsRlqA26rb4IM/ w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="333487685"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; d="scan'208";a="333487685"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2022 18:46:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; d="scan'208";a="712630801"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga001.fm.intel.com with ESMTP; 13 May 2022 18:46:53 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Airlie <airlied@linux.ie>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 Daniel Vetter <daniel@ffwll.ch>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Ning Sun <ning.sun@intel.com>
Subject: [PATCH 4/7] drm/i915: Remove unnecessary include
Date: Sat, 14 May 2022 09:43:19 +0800
Message-Id: <20220514014322.2927339-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220514014322.2927339-1-baolu.lu@linux.intel.com>
References: <20220514014322.2927339-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Steve Wahl <steve.wahl@hpe.com>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jason Gunthorpe <jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>
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

aW50ZWwtaW9tbXUuaCBpcyBub3QgbmVlZGVkIGluIGRybS9pOTE1IGFueW1vcmUuIFJlbW92ZSBp
dHMgaW5jbHVkZS4KClNpZ25lZC1vZmYtYnk6IEx1IEJhb2x1IDxiYW9sdS5sdUBsaW51eC5pbnRl
bC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2k5MTUvaTkxNV9kcnYuaCAgICAgICAgICAgICAg
ICB8IDEgLQogZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9kaXNwbGF5LmMgICB8
IDEgLQogZHJpdmVycy9ncHUvZHJtL2k5MTUvZ2VtL2k5MTVfZ2VtX2V4ZWNidWZmZXIuYyB8IDEg
LQogMyBmaWxlcyBjaGFuZ2VkLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9pOTE1L2k5MTVfZHJ2LmggYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9pOTE1X2Rydi5o
CmluZGV4IGZhMTRkYTg0MzYyZS4uZjJhNjk4MmMzYmVmIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vaTkxNS9pOTE1X2Rydi5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2k5MTVfZHJ2
LmgKQEAgLTM2LDcgKzM2LDYgQEAKIAogI2luY2x1ZGUgPGxpbnV4L2kyYy5oPgogI2luY2x1ZGUg
PGxpbnV4L2kyYy1hbGdvLWJpdC5oPgotI2luY2x1ZGUgPGxpbnV4L2ludGVsLWlvbW11Lmg+CiAj
aW5jbHVkZSA8bGludXgvcG1fcW9zLmg+CiAKICNpbmNsdWRlIDxkcm0vZHJtX2Nvbm5lY3Rvci5o
PgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9kaXNwbGF5
LmMgYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2Rpc3BsYXkuYwppbmRleCA3
ZGZlYjQ1OGFhNjUuLjY4NmRkYmVlYmFkYyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2k5
MTUvZGlzcGxheS9pbnRlbF9kaXNwbGF5LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlz
cGxheS9pbnRlbF9kaXNwbGF5LmMKQEAgLTI3LDcgKzI3LDYgQEAKICNpbmNsdWRlIDxhY3BpL3Zp
ZGVvLmg+CiAjaW5jbHVkZSA8bGludXgvaTJjLmg+CiAjaW5jbHVkZSA8bGludXgvaW5wdXQuaD4K
LSNpbmNsdWRlIDxsaW51eC9pbnRlbC1pb21tdS5oPgogI2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5o
PgogI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPgogI2luY2x1ZGUgPGxpbnV4L2RtYS1yZXN2Lmg+
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vaTkxNS9nZW0vaTkxNV9nZW1fZXhlY2J1ZmZl
ci5jIGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZ2VtL2k5MTVfZ2VtX2V4ZWNidWZmZXIuYwppbmRl
eCBkNDJmNDM3MTQ5YzkuLmM5ODIzNTI4ZWE5NCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2k5MTUvZ2VtL2k5MTVfZ2VtX2V4ZWNidWZmZXIuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vaTkx
NS9nZW0vaTkxNV9nZW1fZXhlY2J1ZmZlci5jCkBAIC00LDcgKzQsNiBAQAogICogQ29weXJpZ2h0
IMKpIDIwMDgsMjAxMCBJbnRlbCBDb3Jwb3JhdGlvbgogICovCiAKLSNpbmNsdWRlIDxsaW51eC9p
bnRlbC1pb21tdS5oPgogI2luY2x1ZGUgPGxpbnV4L2RtYS1yZXN2Lmg+CiAjaW5jbHVkZSA8bGlu
dXgvc3luY19maWxlLmg+CiAjaW5jbHVkZSA8bGludXgvdWFjY2Vzcy5oPgotLSAKMi4yNS4xCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWls
aW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
