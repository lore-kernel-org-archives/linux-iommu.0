Return-Path: <SRS0=ynGH=LB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CB7C47094
	for <iommu@archiver.kernel.org>; Mon,  7 Jun 2021 12:49:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91C1F611C0
	for <iommu@archiver.kernel.org>; Mon,  7 Jun 2021 12:49:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91C1F611C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5F06560620;
	Mon,  7 Jun 2021 12:49:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dHNTfgjPg3wA; Mon,  7 Jun 2021 12:49:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9FFB2605C6;
	Mon,  7 Jun 2021 12:49:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 795FAC000D;
	Mon,  7 Jun 2021 12:49:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F04D6C0001
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 12:49:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C90784021C
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 12:49:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id osvshOtT9X6N for <iommu@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 12:49:13 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5F579400FE
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 12:49:13 +0000 (UTC)
Received: from cap.home.8bytes.org (p4ff2ba7c.dip0.t-ipconnect.de
 [79.242.186.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by theia.8bytes.org (Postfix) with ESMTPSA id 94980104;
 Mon,  7 Jun 2021 14:49:10 +0200 (CEST)
From: Joerg Roedel <joro@8bytes.org>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Subject: [PATCH] iommu/dma: Fix compile warning in 32-bit builds
Date: Mon,  7 Jun 2021 14:49:05 +0200
Message-Id: <20210607124905.27525-1-joro@8bytes.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org,
 Joerg Roedel <jroedel@suse.de>, Srinath Mannam <srinath.mannam@broadcom.com>,
 Oza Pawandeep <poza@codeaurora.org>
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

RnJvbTogSm9lcmcgUm9lZGVsIDxqcm9lZGVsQHN1c2UuZGU+CgpDb21waWxpbmcgdGhlIHJlY2Vu
dCBkbWEtaW9tbXUgY2hhbmdlcyB1bmRlciAzMi1iaXQgeDg2IHRyaWdnZXJzIHRoaXMKY29tcGls
ZSB3YXJuaW5nOgoKZHJpdmVycy9pb21tdS9kbWEtaW9tbXUuYzoyNDk6NTogd2FybmluZzogZm9y
bWF0IOKAmCVsbHjigJkgZXhwZWN0cyBhcmd1bWVudCBvZiB0eXBlIOKAmGxvbmcgbG9uZyB1bnNp
Z25lZCBpbnTigJksIGJ1dCBhcmd1bWVudCAzIGhhcyB0eXBlIOKAmHBoeXNfYWRkcl904oCZIHth
a2Eg4oCYdW5zaWduZWQgaW504oCZfSBbLVdmb3JtYXQ9XQoKVGhlIHJlYXNvbiBpcyB0aGF0ICVs
bHggaXMgdXNlZCB0byBwcmludCBhIHZhcmlhYmxlIG9mIHR5cGUKcGh5c19hZGRyX3QuIEZpeCBp
dCBieSB1c2luZyB0aGUgY29ycmVjdCAlcGEgZm9ybWF0IHNwZWNpZmllciBmb3IKcGh5c19hZGRy
X3QuCgpDYzogU3JpbmF0aCBNYW5uYW0gPHNyaW5hdGgubWFubmFtQGJyb2FkY29tLmNvbT4KQ2M6
IFJvYmluIE11cnBoeSA8cm9iaW4ubXVycGh5QGFybS5jb20+CkNjOiBPemEgUGF3YW5kZWVwIDxw
b3phQGNvZGVhdXJvcmEub3JnPgpGaXhlczogYWFkYWQwOTdjZDQ2ICgiaW9tbXUvZG1hOiBSZXNl
cnZlIElPVkEgZm9yIFBDSWUgaW5hY2Nlc3NpYmxlIERNQSBhZGRyZXNzIikKU2lnbmVkLW9mZi1i
eTogSm9lcmcgUm9lZGVsIDxqcm9lZGVsQHN1c2UuZGU+Ci0tLQogZHJpdmVycy9pb21tdS9kbWEt
aW9tbXUuYyB8IDQgKystLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2RtYS1pb21tdS5jIGIvZHJpdmVy
cy9pb21tdS9kbWEtaW9tbXUuYwppbmRleCA5NWU3MzQ5YWMzZjEuLjVkOTZmY2M0NWZlYyAxMDA2
NDQKLS0tIGEvZHJpdmVycy9pb21tdS9kbWEtaW9tbXUuYworKysgYi9kcml2ZXJzL2lvbW11L2Rt
YS1pb21tdS5jCkBAIC0yNDYsOCArMjQ2LDggQEAgc3RhdGljIGludCBpb3ZhX3Jlc2VydmVfcGNp
X3dpbmRvd3Moc3RydWN0IHBjaV9kZXYgKmRldiwKIAkJfSBlbHNlIGlmIChlbmQgPCBzdGFydCkg
ewogCQkJLyogZG1hX3JhbmdlcyBsaXN0IHNob3VsZCBiZSBzb3J0ZWQgKi8KIAkJCWRldl9lcnIo
JmRldi0+ZGV2LAotCQkJCSJGYWlsZWQgdG8gcmVzZXJ2ZSBJT1ZBIFslIzAxMGxseC0lIzAxMGxs
eF1cbiIsCi0JCQkJc3RhcnQsIGVuZCk7CisJCQkJIkZhaWxlZCB0byByZXNlcnZlIElPVkEgWyVw
YS0lcGFdXG4iLAorCQkJCSZzdGFydCwgJmVuZCk7CiAJCQlyZXR1cm4gLUVJTlZBTDsKIAkJfQog
Ci0tIAoyLjMxLjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
