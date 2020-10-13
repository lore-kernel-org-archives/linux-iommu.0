Return-Path: <SRS0=IGn4=DU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D6DC433DF
	for <iommu@archiver.kernel.org>; Tue, 13 Oct 2020 07:31:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D011420872
	for <iommu@archiver.kernel.org>; Tue, 13 Oct 2020 07:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="fKo8s7aG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D011420872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8CBEE87AE3;
	Tue, 13 Oct 2020 07:31:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VzWFNoytkaIm; Tue, 13 Oct 2020 07:31:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2BD4687ABE;
	Tue, 13 Oct 2020 07:31:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 117D5C07FF;
	Tue, 13 Oct 2020 07:31:02 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5769DC0051
 for <iommu@lists.linux-foundation.org>; Tue, 13 Oct 2020 07:31:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 363422E0DE
 for <iommu@lists.linux-foundation.org>; Tue, 13 Oct 2020 07:31:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EgNKYGT9PJUR for <iommu@lists.linux-foundation.org>;
 Tue, 13 Oct 2020 07:30:58 +0000 (UTC)
X-Greylist: delayed 18:59:48 by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by silver.osuosl.org (Postfix) with ESMTPS id 967832C35C
 for <iommu@lists.linux-foundation.org>; Tue, 13 Oct 2020 07:30:58 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id e18so22689924wrw.9
 for <iommu@lists.linux-foundation.org>; Tue, 13 Oct 2020 00:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=d1itffo3X+hs/Kx12mE/CckAQ68mnKs9JtFcGt6GmGA=;
 b=fKo8s7aGRbyQ/M1hKfql+Q8iDgL6L07G252DWiGsDX27Px293F5Ek90661OxTtJInI
 Et8G+vGvSGKFDLSrQbZFBwno+kQhC6bvQztaaSvdMznWEWq0xuYtlahIUT4j/Qdg+NQc
 mydgbhDVlNkcvW8DcIvoweMXXP+7NboZ8XphcCmCZLT1wyqmmxL3mu86JcTPcqSLSlLK
 az2rhkDgmtJn4nWqPCOY8ZAJEy/p9h2SZc8/Mb8pL3Hvn8iPA3G37gnWm9kB69KV3cK5
 hkC45e9LrAqR3B+Y9nvBUs8PvoXwiaxA1kGn68tvQxpqIzZ1+31izraYBnZ1d+dt4NPj
 u42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=d1itffo3X+hs/Kx12mE/CckAQ68mnKs9JtFcGt6GmGA=;
 b=e6beVac+Fekk2yMMbGV8M/A+aUsPHkKapH9GwgEUjQNC1Sg5etAJS4Tm3jYGJsspvz
 wfRQyyTFKBMhwdIUjUU91d0YDtf9fuLETGVjlZHjAr8XdjJO0neU5oBW31xPqWNIOSxu
 IDwzog5cWaKstkaGOKMMJzoN+hWgIrQzJgSmuF3FV2RZkB3rkhSLfW07UbwheIA6vBNQ
 HxSP8aumERZWYrhmKYlCh9mdISUZomI0Cko5ksfVUaK1dn6mX1DWAvXRCTW00KgTtYGP
 h6O0Z8MAoLkLzFWTijUrP3y7drXq3MUy7xxs5DMqjBCLRdgHj8v2Z7dvMlUJ2CygQBTH
 r58Q==
X-Gm-Message-State: AOAM532Vh3QFA8IMJxWXDh105SpQEUcdi7z7M2XV6jdPJMy9UcwJjnWd
 E6DlupfeqMWvjyvkQU6glDlyNA==
X-Google-Smtp-Source: ABdhPJwToXjrL09HlvAznisOXzNoxKEpn+drBc0B0fY4v9mtvl2Qjr6iZLO2MIRsQNf6sU6ThGFUQw==
X-Received: by 2002:adf:e4c4:: with SMTP id v4mr8989706wrm.79.1602574257128;
 Tue, 13 Oct 2020 00:30:57 -0700 (PDT)
Received: from debian-brgl.home (amarseille-656-1-4-167.w90-8.abo.wanadoo.fr.
 [90.8.158.167])
 by smtp.gmail.com with ESMTPSA id d2sm18051159wrq.34.2020.10.13.00.30.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2020 00:30:56 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>
Subject: [PATCH next] iommu: intel: don't dereference iommu_device if
 IOMMU_API is not built
Date: Tue, 13 Oct 2020 09:30:55 +0200
Message-Id: <20201013073055.11262-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
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
IHN0cnVjdCBpb21tdV9kZXZpY2UgdG8KYmUgc2VsZWN0ZWQuIFdlIGNhbiBkcm9wIHRoaXMgZGVw
ZW5kZW5jeSBieSBub3QgZGVyZWZlcmVuY2luZyBzdHJ1Y3QKaW9tbXVfZGV2aWNlIGlmIElPTU1V
X0FQSSBpcyBub3Qgc2VsZWN0ZWQgYW5kIGJ5IHJldXNpbmcgdGhlIGluZm9ybWF0aW9uCnN0b3Jl
ZCBpbiBpb21tdS0+ZHJoZC0+aWdub3JlZCBpbnN0ZWFkLgoKVGhpcyBmaXhlcyB0aGUgZm9sbG93
aW5nIGJ1aWxkIGVycm9yIHdoZW4gSU9NTVVfQVBJIGlzIG5vdCBzZWxlY3RlZDoKCmRyaXZlcnMv
aW9tbXUvaW50ZWwvZG1hci5jOiBJbiBmdW5jdGlvbiDigJhmcmVlX2lvbW114oCZOgpkcml2ZXJz
L2lvbW11L2ludGVsL2RtYXIuYzoxMTM5OjQxOiBlcnJvcjog4oCYc3RydWN0IGlvbW11X2Rldmlj
ZeKAmSBoYXMgbm8gbWVtYmVyIG5hbWVkIOKAmG9wc+KAmQogMTEzOSB8ICBpZiAoaW50ZWxfaW9t
bXVfZW5hYmxlZCAmJiBpb21tdS0+aW9tbXUub3BzKSB7CiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIF4KCkZpeGVzOiBjNDBhYWFhYzEwMTggKCJpb21tdS92
dC1kOiBHcmFjZWZ1bGx5IGhhbmRsZSBETUFSIHVuaXRzIHdpdGggbm8gc3VwcG9ydGVkIGFkZHJl
c3Mgd2lkdGhzIikKU2lnbmVkLW9mZi1ieTogQmFydG9zeiBHb2xhc3pld3NraSA8YmdvbGFzemV3
c2tpQGJheWxpYnJlLmNvbT4KLS0tCiBkcml2ZXJzL2lvbW11L2ludGVsL2RtYXIuYyB8IDIgKy0K
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvZG1hci5jIGIvZHJpdmVycy9pb21tdS9pbnRlbC9kbWFy
LmMKaW5kZXggMmQ3MGQ1NmQ4ZTBkLi40MDRiNDBhZjMxY2IgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
aW9tbXUvaW50ZWwvZG1hci5jCisrKyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwvZG1hci5jCkBAIC0x
MTM2LDcgKzExMzYsNyBAQCBzdGF0aWMgaW50IGFsbG9jX2lvbW11KHN0cnVjdCBkbWFyX2RyaGRf
dW5pdCAqZHJoZCkKIAogc3RhdGljIHZvaWQgZnJlZV9pb21tdShzdHJ1Y3QgaW50ZWxfaW9tbXUg
KmlvbW11KQogewotCWlmIChpbnRlbF9pb21tdV9lbmFibGVkICYmIGlvbW11LT5pb21tdS5vcHMp
IHsKKwlpZiAoaW50ZWxfaW9tbXVfZW5hYmxlZCAmJiAhaW9tbXUtPmRyaGQtPmlnbm9yZWQpIHsK
IAkJaW9tbXVfZGV2aWNlX3VucmVnaXN0ZXIoJmlvbW11LT5pb21tdSk7CiAJCWlvbW11X2Rldmlj
ZV9zeXNmc19yZW1vdmUoJmlvbW11LT5pb21tdSk7CiAJfQotLSAKMi4yOC4wCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QK
aW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
