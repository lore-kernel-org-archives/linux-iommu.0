Return-Path: <SRS0=wYjh=EZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5B0C388F9
	for <iommu@archiver.kernel.org>; Thu, 19 Nov 2020 10:37:11 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A52A4246EF
	for <iommu@archiver.kernel.org>; Thu, 19 Nov 2020 10:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xc3qmQwf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A52A4246EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 51ACC86A33;
	Thu, 19 Nov 2020 10:37:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ubtaQ_o1B9uB; Thu, 19 Nov 2020 10:37:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C312686A11;
	Thu, 19 Nov 2020 10:37:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A7A01C1825;
	Thu, 19 Nov 2020 10:37:09 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7598AC0891
 for <iommu@lists.linux-foundation.org>; Thu, 19 Nov 2020 10:37:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 62ECF204E3
 for <iommu@lists.linux-foundation.org>; Thu, 19 Nov 2020 10:37:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2Eb93EZsCEFk for <iommu@lists.linux-foundation.org>;
 Thu, 19 Nov 2020 10:37:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id DB5CD204D0
 for <iommu@lists.linux-foundation.org>; Thu, 19 Nov 2020 10:37:07 +0000 (UTC)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 92906246D3;
 Thu, 19 Nov 2020 10:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605782227;
 bh=TKCufnkL7v52leDjZA5aQSovB4YY3GyC4v0oEhprvno=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Xc3qmQwfX6dCz0aRkdTQiS5LS/CsnHRsCpU3UTuRURQqSTxLJ70tsKnJ9AXdJzIqI
 4iCg2gFoeA6HqQr1akzY3dld3Omt3QQpH785pVAxGiICa6/uOVP3zKvor98LoUzg9J
 GgXNxRjoxXp9eFoLUTFyS8mAFstlCWSyn7DwtihM=
From: Will Deacon <will@kernel.org>
To: Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix compile error with CONFIG_PCI_ATS not
 set
Date: Thu, 19 Nov 2020 10:37:01 +0000
Message-Id: <160577954777.1956553.12280033649864052626.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201119055119.2862701-1-baolu.lu@linux.intel.com>
References: <20201119055119.2862701-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Will Deacon <will@kernel.org>, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com
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

T24gVGh1LCAxOSBOb3YgMjAyMCAxMzo1MToxOSArMDgwMCwgTHUgQmFvbHUgd3JvdGU6Cj4gRml4
IHRoZSBjb21waWxlIGVycm9yIGJlbG93IChDT05GSUdfUENJX0FUUyBub3Qgc2V0KToKPiAKPiBk
cml2ZXJzL2lvbW11L2ludGVsL2RtYXIuYzogSW4gZnVuY3Rpb24g4oCYdmZfaW5oZXJpdF9tc2lf
ZG9tYWlu4oCZOgo+IGRyaXZlcnMvaW9tbXUvaW50ZWwvZG1hci5jOjMzODo1OTogZXJyb3I6IOKA
mHN0cnVjdCBwY2lfZGV24oCZIGhhcyBubyBtZW1iZXIgbmFtZWQg4oCYcGh5c2Zu4oCZOyBkaWQg
eW91IG1lYW4g4oCYaXNfcGh5c2Zu4oCZPwo+ICAgMzM4IHwgIGRldl9zZXRfbXNpX2RvbWFpbigm
cGRldi0+ZGV2LCBkZXZfZ2V0X21zaV9kb21haW4oJnBkZXYtPnBoeXNmbi0+ZGV2KSk7Cj4gICAg
ICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgXn5+fn5+Cj4gICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgaXNfcGh5c2ZuCgpBcHBsaWVkIHRvIGFybTY0IChmb3It
bmV4dC9pb21tdS9maXhlcyksIHRoYW5rcyEKClsxLzFdIGlvbW11L3Z0LWQ6IEZpeCBjb21waWxl
IGVycm9yIHdpdGggQ09ORklHX1BDSV9BVFMgbm90IHNldAogICAgICBodHRwczovL2dpdC5rZXJu
ZWwub3JnL2FybTY0L2MvMzY0NWEzNGY1Yjk2CgpDaGVlcnMsCi0tIApXaWxsCgpodHRwczovL2Zp
eGVzLmFybTY0LmRldgpodHRwczovL25leHQuYXJtNjQuZGV2Cmh0dHBzOi8vd2lsbC5hcm02NC5k
ZXYKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUg
bWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
