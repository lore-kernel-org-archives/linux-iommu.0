Return-Path: <SRS0=00Kx=7A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BCCC433DF
	for <iommu@archiver.kernel.org>; Mon, 18 May 2020 23:04:27 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FB0820829
	for <iommu@archiver.kernel.org>; Mon, 18 May 2020 23:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="z1iP9xOG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FB0820829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D99CE86538;
	Mon, 18 May 2020 23:04:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RjnOLZoTwu5g; Mon, 18 May 2020 23:04:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4CF4586500;
	Mon, 18 May 2020 23:04:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 220EEC0881;
	Mon, 18 May 2020 23:04:22 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 85137C07FF
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 23:04:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7CCD987456
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 23:04:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jPKOvAf+mbBt for <iommu@lists.linux-foundation.org>;
 Mon, 18 May 2020 23:04:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 559ED872E9
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 23:04:16 +0000 (UTC)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A3A93207ED;
 Mon, 18 May 2020 23:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1589843056;
 bh=vTTgvB3JUjULE7uYpMa6wmTcpdP6w+Gge17Ze+4Iieg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=z1iP9xOGKusy7dXpZxmij9FsdSXHE/iAuAUadwQPy4Kgpj8W+sCDMtIsxLC0SX18j
 s1JHrjl8jEQEUtnsVVs8QJofrVz/k0mYVBS9pyPH1y04FT4PMi6RpLzIc+y4NiF8xg
 5jC0xa2bWfrTRV4w8bxA0PAdrb3QU6aP/cTKxwSo=
From: Will Deacon <will@kernel.org>
To: joro@8bytes.org, robin.murphy@arm.com, Chen Zhou <chenzhou10@huawei.com>
Subject: Re: [PATCH -next] iommu/arm-smmu-v3: remove set but not used variable
 'smmu'
Date: Tue, 19 May 2020 00:04:03 +0100
Message-Id: <158981035268.232610.8507071130600467853.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200508014955.87630-1-chenzhou10@huawei.com>
References: <20200508014955.87630-1-chenzhou10@huawei.com>
MIME-Version: 1.0
Cc: catalin.marinas@arm.com, iommu@lists.linux-foundation.org,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
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

T24gRnJpLCA4IE1heSAyMDIwIDA5OjQ5OjU1ICswODAwLCBDaGVuIFpob3Ugd3JvdGU6Cj4gRml4
ZXMgZ2NjICctV3VudXNlZC1idXQtc2V0LXZhcmlhYmxlJyB3YXJuaW5nOgo+IAo+IGRyaXZlcnMv
aW9tbXUvYXJtLXNtbXUtdjMuYzoyOTg5OjI2Ogo+IHdhcm5pbmc6IHZhcmlhYmxlIOKAmHNtbXXi
gJkgc2V0IGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtYnV0LXNldC12YXJpYWJsZV0KPiAgIHN0cnVj
dCBhcm1fc21tdV9kZXZpY2UgKnNtbXU7CgpBcHBsaWVkIHRvIHdpbGwgKGZvci1qb2VyZy9hcm0t
c21tdS91cGRhdGVzKSwgdGhhbmtzIQoKWzEvMV0gaW9tbXUvYXJtLXNtbXUtdjM6IHJlbW92ZSBz
ZXQgYnV0IG5vdCB1c2VkIHZhcmlhYmxlICdzbW11JwogICAgICBodHRwczovL2dpdC5rZXJuZWwu
b3JnL3dpbGwvYy8wNjAyMDE5NmM4MmUKCkNoZWVycywKLS0gCldpbGwKCmh0dHBzOi8vZml4ZXMu
YXJtNjQuZGV2Cmh0dHBzOi8vbmV4dC5hcm02NC5kZXYKaHR0cHM6Ly93aWxsLmFybTY0LmRldgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWls
aW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
