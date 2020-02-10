Return-Path: <SRS0=xjv2=36=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E738C352A4
	for <iommu@archiver.kernel.org>; Mon, 10 Feb 2020 09:37:11 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D726B214DB
	for <iommu@archiver.kernel.org>; Mon, 10 Feb 2020 09:37:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D726B214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id AE9B7850EA;
	Mon, 10 Feb 2020 09:37:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T79DdmbdT18i; Mon, 10 Feb 2020 09:37:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 711758512E;
	Mon, 10 Feb 2020 09:37:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 58DFCC1796;
	Mon, 10 Feb 2020 09:37:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D0364C0171
 for <iommu@lists.linux-foundation.org>; Mon, 10 Feb 2020 09:37:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id BF3FF84798
 for <iommu@lists.linux-foundation.org>; Mon, 10 Feb 2020 09:37:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MwFB7ldzklXT for <iommu@lists.linux-foundation.org>;
 Mon, 10 Feb 2020 09:37:04 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D90BC8444E
 for <iommu@lists.linux-foundation.org>; Mon, 10 Feb 2020 09:37:03 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 7BC0534A; Mon, 10 Feb 2020 10:36:59 +0100 (CET)
From: Joerg Roedel <joro@8bytes.org>
To: iommu@lists.linux-foundation.org
Subject: [PATCH] iommu/vt-d: Fix compile warning from intel-svm.h
Date: Mon, 10 Feb 2020 10:36:56 +0100
Message-Id: <20200210093656.8961-1-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Cc: Joerg Roedel <jroedel@suse.de>, Ashok Raj <ashok.raj@intel.com>,
 linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>
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

RnJvbTogSm9lcmcgUm9lZGVsIDxqcm9lZGVsQHN1c2UuZGU+CgpUaGUgaW50ZWxfc3ZtX2lzX3Bh
c2lkX3ZhbGlkKCkgbmVlZHMgdG8gYmUgbWFya2VkIGlubGluZSwgb3RoZXJ3aXNlIGl0CmNhdXNl
cyB0aGUgY29tcGlsZSB3YXJuaW5nIGJlbG93OgoKICBDQyBbTV0gIGRyaXZlcnMvZG1hL2lkeGQv
Y2Rldi5vCkluIGZpbGUgaW5jbHVkZWQgZnJvbSBkcml2ZXJzL2RtYS9pZHhkL2NkZXYuYzo5OjA6
Ci4vaW5jbHVkZS9saW51eC9pbnRlbC1zdm0uaDoxMjU6MTI6IHdhcm5pbmc6IOKAmGludGVsX3N2
bV9pc19wYXNpZF92YWxpZOKAmSBkZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtZnVuY3Rp
b25dCiBzdGF0aWMgaW50IGludGVsX3N2bV9pc19wYXNpZF92YWxpZChzdHJ1Y3QgZGV2aWNlICpk
ZXYsIGludCBwYXNpZCkKICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+CgpSZXBv
cnRlZC1ieTogQm9yaXNsYXYgUGV0a292IDxicEBhbGllbjguZGU+CkZpeGVzOiAxNTA2MGFiYTcx
NzExICgnaW9tbXUvdnQtZDogSGVscGVyIGZ1bmN0aW9uIHRvIHF1ZXJ5IGlmIGEgcGFzaWQgaGFz
IGFueSBhY3RpdmUgdXNlcnMnKQpTaWduZWQtb2ZmLWJ5OiBKb2VyZyBSb2VkZWwgPGpyb2VkZWxA
c3VzZS5kZT4KLS0tCiBpbmNsdWRlL2xpbnV4L2ludGVsLXN2bS5oIHwgMiArLQogMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9saW51eC9pbnRlbC1zdm0uaCBiL2luY2x1ZGUvbGludXgvaW50ZWwtc3ZtLmgKaW5kZXggOTRm
MDQ3YThhODQ1Li5kN2M0MDNkMGRkMjcgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvaW50ZWwt
c3ZtLmgKKysrIGIvaW5jbHVkZS9saW51eC9pbnRlbC1zdm0uaApAQCAtMTIyLDcgKzEyMiw3IEBA
IHN0YXRpYyBpbmxpbmUgaW50IGludGVsX3N2bV91bmJpbmRfbW0oc3RydWN0IGRldmljZSAqZGV2
LCBpbnQgcGFzaWQpCiAJQlVHKCk7CiB9CiAKLXN0YXRpYyBpbnQgaW50ZWxfc3ZtX2lzX3Bhc2lk
X3ZhbGlkKHN0cnVjdCBkZXZpY2UgKmRldiwgaW50IHBhc2lkKQorc3RhdGljIGlubGluZSBpbnQg
aW50ZWxfc3ZtX2lzX3Bhc2lkX3ZhbGlkKHN0cnVjdCBkZXZpY2UgKmRldiwgaW50IHBhc2lkKQog
ewogCXJldHVybiAtRUlOVkFMOwogfQotLSAKMi4xNi40CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vaW9tbXU=
