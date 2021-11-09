Return-Path: <SRS0=/C+/=P4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7690DC433EF
	for <iommu@archiver.kernel.org>; Tue,  9 Nov 2021 19:31:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E2536134F
	for <iommu@archiver.kernel.org>; Tue,  9 Nov 2021 19:31:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1E2536134F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D69EF608B4;
	Tue,  9 Nov 2021 19:31:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XuyWl5NS7yBo; Tue,  9 Nov 2021 19:31:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D050F60887;
	Tue,  9 Nov 2021 19:31:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9EA9EC0019;
	Tue,  9 Nov 2021 19:31:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 339BCC000E
 for <iommu@lists.linux-foundation.org>; Tue,  9 Nov 2021 19:31:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0A9AE40194
 for <iommu@lists.linux-foundation.org>; Tue,  9 Nov 2021 19:31:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w_b5WgGtnywy for <iommu@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 19:31:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 477764011B
 for <iommu@lists.linux-foundation.org>; Tue,  9 Nov 2021 19:31:41 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id D7DAF61350;
 Tue,  9 Nov 2021 19:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1636486300;
 bh=/Bxb1ItdVeACpN0IK1g8DCwertzUoQKfvRatD6rG9+Y=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=ZXSRZHN3JVN4mfDsv5fWJnIUKnLk+tvslctv8wB1gPO0QlUx+YR6hOSNdzIWwNrLC
 0mHK5o+vocUqNRmtv1AQDncbmefHvaSJlv52kRpnpYeQEPFdYnNJioFBEgWW1VcAxd
 fTyg6P+prqDUm3KZ0quVGGrsaPywGK8GZW4VYnifzazlcOaKURhT9BupQgblMPT03r
 jekXMSHqwNpcqdsjiKlgapFXnjGUAXg4KSjQEZB2JphLxIzIdbsW+BTzWfxDj53NK4
 acpEqHSEsAXRGYJnbKrWcUFVYRQk6ejbVbJuCClHMro1WtOdKyzI0Scp5fhNzjHJ6M
 v2ccR6iZtHo2Q==
Subject: Re: [GIT PULL] dma-mapping updates for Linux 5.16
From: pr-tracker-bot@kernel.org
In-Reply-To: <YYp9TAVLFsxqfVx7@infradead.org>
References: <YYp9TAVLFsxqfVx7@infradead.org>
X-PR-Tracked-List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
X-PR-Tracked-Message-Id: <YYp9TAVLFsxqfVx7@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git
 tags/dma-mapping-5.16
X-PR-Tracked-Commit-Id: 9fbd8dc19aa57ec8fe92606043199919527cd9be
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 372594985c786b40108a5201ca3192223d6c0c40
Message-Id: <163648630085.13393.4121089110456251047.pr-tracker-bot@kernel.org>
Date: Tue, 09 Nov 2021 19:31:40 +0000
To: Christoph Hellwig <hch@infradead.org>
Cc: iommu@lists.linux-foundation.org,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

The pull request you sent on Tue, 9 Nov 2021 14:53:16 +0100:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/372594985c786b40108a5201ca3192223d6c0c40

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
