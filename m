Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5A66C433EF
	for <iommu@archiver.kernel.org>; Fri, 17 Dec 2021 08:38:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5141B41C0E;
	Fri, 17 Dec 2021 08:38:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZExkedc3CxxF; Fri, 17 Dec 2021 08:38:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5495D41BD9;
	Fri, 17 Dec 2021 08:38:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19F58C002F;
	Fri, 17 Dec 2021 08:38:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 82036C0012
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 08:38:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7069D83EBD
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 08:38:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dJE8toCAU1vh for <iommu@lists.linux-foundation.org>;
 Fri, 17 Dec 2021 08:38:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 057EB83EB6
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 08:38:40 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="325999620"
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; d="scan'208";a="325999620"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2021 00:38:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; d="scan'208";a="662786048"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 17 Dec 2021 00:38:38 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 0/4] [PULL REQUEST] Intel IOMMU Updates for Linux v5.17
Date: Fri, 17 Dec 2021 16:38:13 +0800
Message-Id: <20211217083817.1745419-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>, Kees Cook <keescook@chromium.org>,
 Yury Norov <yury.norov@gmail.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <maira.canal@usp.br>,
 Nick Desaulniers <ndesaulniers@google.com>, iommu@lists.linux-foundation.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
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

SGkgSm9lcmcsCgpUaGUgcGF0Y2hlcyBxdWV1ZWQgaW4gdGhpcyBzZXJpZXMgYXJlIGZvciB2NS4x
Ny4gSXQgaW5jbHVkZXM6CgogLSBWYXJpb3VzIGNsZWFudXBzLCBubyBmdW5jdGlvbmFsIGNoYW5n
ZXMuCgpQbGVhc2UgcHVsbC4KCkJlc3QgcmVnYXJkcywKQmFvbHUKCkNocmlzdG9waGUgSkFJTExF
VCAoMSk6CiAgaW9tbXUvdnQtZDogVXNlIGJpdG1hcF96YWxsb2MoKSB3aGVuIGFwcGxpY2FibGUK
CktlZXMgQ29vayAoMSk6CiAgaW9tbXUvdnQtZDogVXNlIGNvcnJlY3RseSBzaXplZCBhcmd1bWVu
dHMgZm9yIGJpdCBmaWVsZAoKS2VmZW5nIFdhbmcgKDEpOgogIGlvbW11L3Z0LWQ6IERyb3AgZHVw
bGljYXRlIGNoZWNrIGluIGRtYV9wdGVfZnJlZV9wYWdldGFibGUoKQoKTWHDrXJhIENhbmFsICgx
KToKICBpb21tdS92dC1kOiBSZW1vdmUgdW51c2VkIGRtYV90b19tbV9wZm4gZnVuY3Rpb24KCiBk
cml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMgfCAyMiArKysrKystLS0tLS0tLS0tLS0tLS0tCiAx
IGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAxNiBkZWxldGlvbnMoLSkKCi0tIAoyLjI1
LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11
IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
