Return-Path: <SRS0=Ithz=52=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C4DC2BB86
	for <iommu@archiver.kernel.org>; Fri, 10 Apr 2020 14:27:05 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F2BC2082D
	for <iommu@archiver.kernel.org>; Fri, 10 Apr 2020 14:27:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F2BC2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 005472265B;
	Fri, 10 Apr 2020 14:27:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ohNV817Q7Sn0; Fri, 10 Apr 2020 14:27:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 1E46F22622;
	Fri, 10 Apr 2020 14:27:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EE434C1D74;
	Fri, 10 Apr 2020 14:27:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5F85CC0177
 for <iommu@lists.linux-foundation.org>; Fri, 10 Apr 2020 14:27:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4BFBD881A3
 for <iommu@lists.linux-foundation.org>; Fri, 10 Apr 2020 14:27:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jY5gz5lWVs31 for <iommu@lists.linux-foundation.org>;
 Fri, 10 Apr 2020 14:27:01 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D17F788148
 for <iommu@lists.linux-foundation.org>; Fri, 10 Apr 2020 14:27:00 +0000 (UTC)
Received: from ramsan ([84.195.182.253]) by albert.telenet-ops.be with bizsmtp
 id R2Sq2200B5USYZQ062SqQ2; Fri, 10 Apr 2020 16:26:58 +0200
Received: from rox.of.borg ([192.168.97.57]) by ramsan with esmtp (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1jMucM-0004qD-Ci; Fri, 10 Apr 2020 16:26:50 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1jMucM-0004qj-9Q; Fri, 10 Apr 2020 16:26:50 +0200
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Joerg Roedel <joro@8bytes.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH] netfilter: nft_fwd_netdev: Fix CONFIG_NET_CLS_ACT=n build
Date: Fri, 10 Apr 2020 16:26:48 +0200
Message-Id: <20200410142648.18599-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
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

SWYgQ09ORklHX05FVF9DTFNfQUNUPW46CgogICAgbmV0L25ldGZpbHRlci9uZnRfZndkX25ldGRl
di5jOiBJbiBmdW5jdGlvbiDigJhuZnRfZndkX25ldGRldl9ldmFs4oCZOgogICAgbmV0L25ldGZp
bHRlci9uZnRfZndkX25ldGRldi5jOjMyOjEwOiBlcnJvcjog4oCYc3RydWN0IHNrX2J1ZmbigJkg
aGFzIG5vIG1lbWJlciBuYW1lZCDigJh0Y19yZWRpcmVjdGVk4oCZCiAgICAgIHBrdC0+c2tiLT50
Y19yZWRpcmVjdGVkID0gMTsKCSAgICAgIF5+CiAgICBuZXQvbmV0ZmlsdGVyL25mdF9md2RfbmV0
ZGV2LmM6MzM6MTA6IGVycm9yOiDigJhzdHJ1Y3Qgc2tfYnVmZuKAmSBoYXMgbm8gbWVtYmVyIG5h
bWVkIOKAmHRjX2Zyb21faW5ncmVzc+KAmQogICAgICBwa3QtPnNrYi0+dGNfZnJvbV9pbmdyZXNz
ID0gMTsKCSAgICAgIF5+CgpGaXggdGhpcyBieSBwcm90ZWN0aW5nIHRoaXMgY29kZSBodW5rIHdp
dGggdGhlIGFwcHJvcHJpYXRlICNpZmRlZi4KClJlcG9ydGVkLWJ5OiBub3JlcGx5QGVsbGVybWFu
LmlkLmF1CkZpeGVzOiBiY2ZhYmVlMWFmZDk5NDg0ICgibmV0ZmlsdGVyOiBuZnRfZndkX25ldGRl
djogYWxsb3cgdG8gcmVkaXJlY3QgdG8gaWZiIHZpYSBpbmdyZXNzIikKU2lnbmVkLW9mZi1ieTog
R2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4KLS0tCiBuZXQvbmV0Zmls
dGVyL25mdF9md2RfbmV0ZGV2LmMgfCAyICsrCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspCgpkaWZmIC0tZ2l0IGEvbmV0L25ldGZpbHRlci9uZnRfZndkX25ldGRldi5jIGIvbmV0L25l
dGZpbHRlci9uZnRfZndkX25ldGRldi5jCmluZGV4IDc0ZjA1MGJhNmJhZGM5ZGMuLmViY2FmNWMz
MjU3MTJmMzAgMTAwNjQ0Ci0tLSBhL25ldC9uZXRmaWx0ZXIvbmZ0X2Z3ZF9uZXRkZXYuYworKysg
Yi9uZXQvbmV0ZmlsdGVyL25mdF9md2RfbmV0ZGV2LmMKQEAgLTI4LDkgKzI4LDExIEBAIHN0YXRp
YyB2b2lkIG5mdF9md2RfbmV0ZGV2X2V2YWwoY29uc3Qgc3RydWN0IG5mdF9leHByICpleHByLAog
CXN0cnVjdCBuZnRfZndkX25ldGRldiAqcHJpdiA9IG5mdF9leHByX3ByaXYoZXhwcik7CiAJaW50
IG9pZiA9IHJlZ3MtPmRhdGFbcHJpdi0+c3JlZ19kZXZdOwogCisjaWZkZWYgQ09ORklHX05FVF9D
TFNfQUNUCiAJLyogVGhlc2UgYXJlIHVzZWQgYnkgaWZiIG9ubHkuICovCiAJcGt0LT5za2ItPnRj
X3JlZGlyZWN0ZWQgPSAxOwogCXBrdC0+c2tiLT50Y19mcm9tX2luZ3Jlc3MgPSAxOworI2VuZGlm
CiAKIAluZl9md2RfbmV0ZGV2X2VncmVzcyhwa3QsIG9pZik7CiAJcmVncy0+dmVyZGljdC5jb2Rl
ID0gTkZfU1RPTEVOOwotLSAKMi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vaW9tbXU=
