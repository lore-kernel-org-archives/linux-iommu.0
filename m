Return-Path: <SRS0=hfNk=2U=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85914C2D0C2
	for <iommu@archiver.kernel.org>; Mon, 30 Dec 2019 17:26:32 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F8E320722
	for <iommu@archiver.kernel.org>; Mon, 30 Dec 2019 17:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HRBqtPtN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F8E320722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id ED46B8749A;
	Mon, 30 Dec 2019 17:26:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8MRdi43VgVa3; Mon, 30 Dec 2019 17:26:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C8992874C5;
	Mon, 30 Dec 2019 17:26:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A4EECC1796;
	Mon, 30 Dec 2019 17:26:29 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AB195C077D
 for <iommu@lists.linux-foundation.org>; Mon, 30 Dec 2019 17:26:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A15B7204F1
 for <iommu@lists.linux-foundation.org>; Mon, 30 Dec 2019 17:26:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YTalPBr6jjWO for <iommu@lists.linux-foundation.org>;
 Mon, 30 Dec 2019 17:26:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 1CE83204EE
 for <iommu@lists.linux-foundation.org>; Mon, 30 Dec 2019 17:26:28 +0000 (UTC)
Received: from localhost.localdomain (unknown [194.230.155.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8489C206DB;
 Mon, 30 Dec 2019 17:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1577726787;
 bh=m+ZsnKOEnT8GfyM0PUcj40hjdwjIfZjmIypDhpTq+ik=;
 h=From:To:Cc:Subject:Date:From;
 b=HRBqtPtNPOzb2L2x+3OSWikBP4FKNAVR42FB70Wcgjwn8mqRoHStWhLBmS1x0lTCC
 ECT0BCbZ/ENrYxfL42XTGsOJsT7eVBoYviLfTVztjhFsNb8tneY6s4NVT7aB4OUt82
 lThzmgV0913aszsJJYtsVNZAUyBSXq7KjUT251sc=
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 Douglas Anderson <dianders@chromium.org>, Suman Anna <s-anna@ti.com>,
 Tero Kristo <t-kristo@ti.com>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] iommu: omap: Fix pointer cast -Wpointer-to-int-cast
 warnings on 64 bit
Date: Mon, 30 Dec 2019 18:26:17 +0100
Message-Id: <20191230172619.17814-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Cc: Krzysztof Kozlowski <krzk@kernel.org>
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

cG9pbnRlcnMgc2hvdWxkIGJlIGNhc3RlZCB0byB1bnNpZ25lZCBsb25nIHRvIGF2b2lkCi1XcG9p
bnRlci10by1pbnQtY2FzdCB3YXJuaW5ncyB3aGVuIGNvbXBpbGluZyBvbiA2NC1iaXQgcGxhdGZv
cm0gKGUuZy4Kd2l0aCBDT01QSUxFX1RFU1QpOgoKICAgIGRyaXZlcnMvaW9tbXUvb21hcC1pb21t
dS5jOiBJbiBmdW5jdGlvbiDigJhvbWFwMl9pb21tdV9lbmFibGXigJk6CiAgICBkcml2ZXJzL2lv
bW11L29tYXAtaW9tbXUuYzoxNzA6MjU6IHdhcm5pbmc6CiAgICAgICAgY2FzdCBmcm9tIHBvaW50
ZXIgdG8gaW50ZWdlciBvZiBkaWZmZXJlbnQgc2l6ZSBbLVdwb2ludGVyLXRvLWludC1jYXN0XQog
ICAgICBpZiAoIW9iai0+aW9wZ2QgfHwgIUlTX0FMSUdORUQoKHUzMilvYmotPmlvcGdkLCAgU1pf
MTZLKSkKICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeCgpTaWduZWQtb2ZmLWJ5OiBLcnp5
c3p0b2YgS296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+Ci0tLQogZHJpdmVycy9pb21tdS9vbWFw
LWlvbW11LmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRp
b24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L29tYXAtaW9tbXUuYyBiL2RyaXZlcnMv
aW9tbXUvb21hcC1pb21tdS5jCmluZGV4IGJlNTUxY2MzNGJlNC4uNTBlOGFjZjg4ZWM0IDEwMDY0
NAotLS0gYS9kcml2ZXJzL2lvbW11L29tYXAtaW9tbXUuYworKysgYi9kcml2ZXJzL2lvbW11L29t
YXAtaW9tbXUuYwpAQCAtMTY3LDcgKzE2Nyw3IEBAIHN0YXRpYyBpbnQgb21hcDJfaW9tbXVfZW5h
YmxlKHN0cnVjdCBvbWFwX2lvbW11ICpvYmopCiB7CiAJdTMyIGwsIHBhOwogCi0JaWYgKCFvYmot
PmlvcGdkIHx8ICFJU19BTElHTkVEKCh1MzIpb2JqLT5pb3BnZCwgIFNaXzE2SykpCisJaWYgKCFv
YmotPmlvcGdkIHx8ICFJU19BTElHTkVEKCh1bnNpZ25lZCBsb25nKW9iai0+aW9wZ2QsICBTWl8x
NkspKQogCQlyZXR1cm4gLUVJTlZBTDsKIAogCXBhID0gdmlydF90b19waHlzKG9iai0+aW9wZ2Qp
OwotLSAKMi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
