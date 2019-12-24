Return-Path: <SRS0=A6MP=2O=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367BEC2D0CF
	for <iommu@archiver.kernel.org>; Tue, 24 Dec 2019 08:29:10 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF3F8206B7
	for <iommu@archiver.kernel.org>; Tue, 24 Dec 2019 08:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="LH5d5Xb5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF3F8206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CE02085569;
	Tue, 24 Dec 2019 08:29:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hjCTPwUP-YRq; Tue, 24 Dec 2019 08:29:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0CCBA8543E;
	Tue, 24 Dec 2019 08:29:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E4391C1D80;
	Tue, 24 Dec 2019 08:29:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 237EEC0881
 for <iommu@lists.linux-foundation.org>; Tue, 24 Dec 2019 08:29:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1E2E681E80
 for <iommu@lists.linux-foundation.org>; Tue, 24 Dec 2019 08:29:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AVMqGWHtahKW for <iommu@lists.linux-foundation.org>;
 Tue, 24 Dec 2019 08:29:07 +0000 (UTC)
X-Greylist: delayed 00:08:54 by SQLgrey-1.7.6
Received: from condef-08.nifty.com (condef-08.nifty.com [202.248.20.73])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C29DC81D76
 for <iommu@lists.linux-foundation.org>; Tue, 24 Dec 2019 08:29:06 +0000 (UTC)
Received: from conuserg-11.nifty.com ([10.126.8.74])by condef-08.nifty.com
 with ESMTP id xBO8FjTV030280
 for <iommu@lists.linux-foundation.org>; Tue, 24 Dec 2019 17:15:46 +0900
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp
 [153.142.97.92]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id xBO8F6tP002467;
 Tue, 24 Dec 2019 17:15:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com xBO8F6tP002467
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1577175313;
 bh=jKX8H24L9P/kDcEFr52nFIN6vZX1dw3qi1ILU0zzQ1g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LH5d5Xb5XetelHCGw0KPciGf1DQ6qgz5oVGoCFofMdCnSzxQwCijuOMxa7tyy8Nae
 J8ya1rujKnF8/SQ4hvd9Ambys/TIe9W3GoOnvvjH1dNPRxx4KgLuZX662+Kxfx9pGu
 6ds95X3thYTUHLzGXLz9Pj3II036sln0SGiZZw84ZI87mGEq6glrS1ebEtSZrP1OlY
 e+d+TG8oVOFV49EzKMexbjYQZckYB2t92lbIuickAk52vdd8zLIn3jfhvse6zCQbgb
 +SYsgW6YMNFStKmpRhasFF4QBF7qRQ+ce9KCd2SYzQL/ipqJ8eOF4khF9Tk/rM25+4
 z7TBYuHiwL3+w==
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org, Joerg Roedel <joro@8bytes.org>,
 iommu@lists.linux-foundation.org
Subject: [PATCH 2/2] iommu/arm-smmu: fix -Wunused-const-variable warning
Date: Tue, 24 Dec 2019 17:15:00 +0900
Message-Id: <20191224081500.18628-2-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191224081500.18628-1-yamada.masahiro@socionext.com>
References: <20191224081500.18628-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
 linux-kernel@vger.kernel.org
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

Rm9yIEFSQ0g9YXJtIGJ1aWxkcywgT0YgaXMgbm90IG5lY2Vzc2FyaWx5IGVuYWJsZWQsIHRoYXQg
aXMsIHlvdSBjYW4KYnVpbGQgdGhpcyBkcml2ZXIgd2l0aG91dCBDT05GSUdfT0YuCgpXaGVuIENP
TkZJR19PRiBpcyB1bnNldCwgb2ZfbWF0Y2hfcHRyKCkgaXMgTlVMTCwgYW5kIGFybV9zbW11X29m
X21hdGNoCmlzIGxlZnQgb3JwaGFuLgoKQnVpbGRpbmcgaXQgd2l0aCBXPTEgZW1pdHMgYSB3YXJu
aW5nOgoKZHJpdmVycy9pb21tdS9hcm0tc21tdS5jOjE5MDQ6MzQ6IHdhcm5pbmc6IOKAmGFybV9z
bW11X29mX21hdGNo4oCZIGRlZmluZWQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1jb25zdC12YXJp
YWJsZT1dCiBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBhcm1fc21tdV9vZl9tYXRj
aFtdID0gewogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+
fn4KClRoZXJlIGFyZSB0d28gd2F5cyB0byBmaXggdGhpczoKCiAtIGFubm90YXRlIGFybV9zbW11
X29mX21hdGNoIHdpdGggX19tYXliZV91bnVzZWQgKG9yIHN1cnJvdW5kIHRoZQogICBjb2RlIHdp
dGggI2lmZGVmIENPTkZJR19PRiAuLi4gI2VuZGlmKQoKIC0gc3RvcCB1c2luZyBvZl9tYXRjaF9w
dHIoKQoKVGhpcyBjb21taXQgdG9vayB0aGUgbGF0dGVyIHNvbHV0aW9uLgoKSXQgc2xpZ2h0bHkg
aW5jcmVhc2VzIHRoZSBvYmplY3Qgc2l6ZSwgYnV0IGl0IGlzIHByb2JhYmx5IG5vdCBhIGJpZyBk
ZWFsCmJlY2F1c2UgYXJtX3NtbXVfZGV2aWNlX2R0X3Byb2JlKCkgaXMgYWxzbyBjb21waWxlZCBp
cnJlc3BlY3RpdmUgb2YKQ09ORklHX09GLgoKU2lnbmVkLW9mZi1ieTogTWFzYWhpcm8gWWFtYWRh
IDx5YW1hZGEubWFzYWhpcm9Ac29jaW9uZXh0LmNvbT4KLS0tCgogZHJpdmVycy9pb21tdS9hcm0t
c21tdS5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9u
KC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9hcm0tc21tdS5jIGIvZHJpdmVycy9pb21t
dS9hcm0tc21tdS5jCmluZGV4IDRmMWEzNTBkOTUyOS4uMDQ0NmEzYmY2YmQwIDEwMDY0NAotLS0g
YS9kcml2ZXJzL2lvbW11L2FybS1zbW11LmMKKysrIGIvZHJpdmVycy9pb21tdS9hcm0tc21tdS5j
CkBAIC0yMjY3LDcgKzIyNjcsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGRldl9wbV9vcHMgYXJt
X3NtbXVfcG1fb3BzID0gewogc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgYXJtX3NtbXVf
ZHJpdmVyID0gewogCS5kcml2ZXIJPSB7CiAJCS5uYW1lCQkJPSAiYXJtLXNtbXUiLAotCQkub2Zf
bWF0Y2hfdGFibGUJCT0gb2ZfbWF0Y2hfcHRyKGFybV9zbW11X29mX21hdGNoKSwKKwkJLm9mX21h
dGNoX3RhYmxlCQk9IGFybV9zbW11X29mX21hdGNoLAogCQkucG0JCQk9ICZhcm1fc21tdV9wbV9v
cHMsCiAJCS5zdXBwcmVzc19iaW5kX2F0dHJzCT0gdHJ1ZSwKIAl9LAotLSAKMi4xNy4xCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5n
IGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
