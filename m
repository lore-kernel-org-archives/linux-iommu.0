Return-Path: <SRS0=a71q=DT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA119C433DF
	for <iommu@archiver.kernel.org>; Mon, 12 Oct 2020 14:07:57 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4528620838
	for <iommu@archiver.kernel.org>; Mon, 12 Oct 2020 14:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="CqyWnOKR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4528620838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id CE1B821511;
	Mon, 12 Oct 2020 14:07:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id izHUnWy1nIr7; Mon, 12 Oct 2020 14:07:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 95B97203A7;
	Mon, 12 Oct 2020 14:07:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 83C5CC0052;
	Mon, 12 Oct 2020 14:07:55 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 77D79C0051
 for <iommu@lists.linux-foundation.org>; Mon, 12 Oct 2020 13:28:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 4EA06207B0
 for <iommu@lists.linux-foundation.org>; Mon, 12 Oct 2020 13:28:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pXnD7S6y8-Jr for <iommu@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 13:28:37 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com
 [209.85.167.66])
 by silver.osuosl.org (Postfix) with ESMTPS id 050CB204D9
 for <iommu@lists.linux-foundation.org>; Mon, 12 Oct 2020 13:28:36 +0000 (UTC)
Received: by mail-lf1-f66.google.com with SMTP id j30so15986712lfp.4
 for <iommu@lists.linux-foundation.org>; Mon, 12 Oct 2020 06:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MvIZCy8+uyG7PlFqYpqlAdUF/vTk3X+HzF3V0T1VljQ=;
 b=CqyWnOKRUBw/Boxzc/3KtKSNAH6ni3OI/OFYvkdZluHArK5KZwePxrUUlxyYaLFSBD
 vCjQsVLLNHxs4L5K9N+J0DE1oYycFmVIyXG+DVnE4sfzmNGwRTtLoOtWBtyInpmquJ59
 IpyFj0YmyWVa0ZM9dP3oaCFjnqX1B8Lr1Df8k2afgovNm3+dcYmFK9xdLoF5Qhwx0Xcg
 Y+7SKm3sm9Mmkxk+asWaYAE9srvIKntsbamoUhgF066LAchmlrLae9MiFXpEy6M7jYwS
 qkFa2iUz8SWKFor3BtFIoWuIE9MJqo4pJ1TETNZnj+Df1hG0ZENJbBLvaSauiIb2OnrM
 rfIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MvIZCy8+uyG7PlFqYpqlAdUF/vTk3X+HzF3V0T1VljQ=;
 b=NVLhuRvCoL6m7N87DfgJ86qUccQcm6QNQvz1uMsmt/Fjx0M0qPH4JcQrplcgoYiFEQ
 u2MMByZJpUX9aFsjJYJsSUCrnr9Yj3R7OfUBul4uRyc197vbo1XLi29G7KGA79EBlH9a
 w+0Ma2xcrdr6Kud5+1nb+HsJGNfHV83f0zhkP/bDYuAjjqidMxP/KR6z9yAGqKGz2kZi
 bjc7Ip3JDC/OUAyrY23EKR+S5Vbv/N+EHkY8S+bDyqgbmg86oUTGjF5XrKIs+XVQBT41
 8et0uHGAyhnOVH1NOn7fzwfHZNbWNl3ZwMLsAfEcZteUZ5dnTZ2MfdTnHqa8eB+hD8qn
 GmOw==
X-Gm-Message-State: AOAM5304sxQLYDfqnhZkiutzUR486ZGOYJ0C6ZG4uU0Qa6nz/Kuh9avP
 gf+ukdFWA7QhtJmeDcSJ5rQ3AfkJQZxXfQ==
X-Google-Smtp-Source: ABdhPJyXrQMqvFC6DcpILZj94c1CmBX8YBtmQtfWHr/g3npQmL7PmVc15eqRA2+Qfrn+J6C8S5sWqQ==
X-Received: by 2002:adf:c3c2:: with SMTP id d2mr30672263wrg.191.1602505868361; 
 Mon, 12 Oct 2020 05:31:08 -0700 (PDT)
Received: from debian-brgl.home (amarseille-656-1-4-167.w90-8.abo.wanadoo.fr.
 [90.8.158.167])
 by smtp.gmail.com with ESMTPSA id b25sm20408235wmj.21.2020.10.12.05.31.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 05:31:07 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>
Subject: [PATCH next] iommu: intel: make DMAR_TABLE select IOMMU_API
Date: Mon, 12 Oct 2020 14:31:05 +0200
Message-Id: <20201012123105.32652-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 12 Oct 2020 14:07:54 +0000
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

RnJvbTogQmFydG9zeiBHb2xhc3pld3NraSA8YmdvbGFzemV3c2tpQGJheWxpYnJlLmNvbT4KClNp
bmNlIGNvbW1pdCBjNDBhYWFhYzEwMTggKCJpb21tdS92dC1kOiBHcmFjZWZ1bGx5IGhhbmRsZSBE
TUFSIHVuaXRzCndpdGggbm8gc3VwcG9ydGVkIGFkZHJlc3Mgd2lkdGhzIikgZG1hci5jIG5lZWRz
IHN0cnVjdCBpb21tdV9kZXZpY2UgdG8KYmUgZGVmaW5lZC4gV2UgbmVlZCB0byB1bmNvbmRpdGlv
bmFsbHkgc2VsZWN0IElPTU1VX0FQSSB3aGVuIERNQVJfVEFCTEUKaXMgc2VsZWN0ZWQuIFRoaXMg
Zml4ZXMgdGhlIGZvbGxvd2luZyBidWlsZCBlcnJvciB3aGVuIElPTU1VX0FQSSBpcyBub3QKc2Vs
ZWN0ZWQ6Cgpkcml2ZXJzL2lvbW11L2ludGVsL2RtYXIuYzogSW4gZnVuY3Rpb24g4oCYZnJlZV9p
b21tdeKAmToKZHJpdmVycy9pb21tdS9pbnRlbC9kbWFyLmM6MTEzOTo0MTogZXJyb3I6IOKAmHN0
cnVjdCBpb21tdV9kZXZpY2XigJkgaGFzIG5vIG1lbWJlciBuYW1lZCDigJhvcHPigJkKIDExMzkg
fCAgaWYgKGludGVsX2lvbW11X2VuYWJsZWQgJiYgaW9tbXUtPmlvbW11Lm9wcykgewogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeCgpGaXhlczogYzQwYWFh
YWMxMDE4ICgiaW9tbXUvdnQtZDogR3JhY2VmdWxseSBoYW5kbGUgRE1BUiB1bml0cyB3aXRoIG5v
IHN1cHBvcnRlZCBhZGRyZXNzIHdpZHRocyIpClNpZ25lZC1vZmYtYnk6IEJhcnRvc3ogR29sYXN6
ZXdza2kgPGJnb2xhc3pld3NraUBiYXlsaWJyZS5jb20+Ci0tLQogZHJpdmVycy9pb21tdS9pbnRl
bC9LY29uZmlnIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0
aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pbnRlbC9LY29uZmlnIGIvZHJpdmVy
cy9pb21tdS9pbnRlbC9LY29uZmlnCmluZGV4IDUzMzdlZTE1ODRiMC4uZjgxNGI3NTg1YmE4IDEw
MDY0NAotLS0gYS9kcml2ZXJzL2lvbW11L2ludGVsL0tjb25maWcKKysrIGIvZHJpdmVycy9pb21t
dS9pbnRlbC9LY29uZmlnCkBAIC0xLDEzICsxLDEzIEBACiAjIFNQRFgtTGljZW5zZS1JZGVudGlm
aWVyOiBHUEwtMi4wLW9ubHkKICMgSW50ZWwgSU9NTVUgc3VwcG9ydAogY29uZmlnIERNQVJfVEFC
TEUKKwlzZWxlY3QgSU9NTVVfQVBJCiAJYm9vbAogCiBjb25maWcgSU5URUxfSU9NTVUKIAlib29s
ICJTdXBwb3J0IGZvciBJbnRlbCBJT01NVSB1c2luZyBETUEgUmVtYXBwaW5nIERldmljZXMiCiAJ
ZGVwZW5kcyBvbiBQQ0lfTVNJICYmIEFDUEkgJiYgKFg4NiB8fCBJQTY0KQogCXNlbGVjdCBETUFf
T1BTCi0Jc2VsZWN0IElPTU1VX0FQSQogCXNlbGVjdCBJT01NVV9JT1ZBCiAJc2VsZWN0IE5FRURf
RE1BX01BUF9TVEFURQogCXNlbGVjdCBETUFSX1RBQkxFCi0tIAoyLjI4LjAKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdApp
b21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
