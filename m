Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C8AC433F5
	for <iommu@archiver.kernel.org>; Fri,  8 Apr 2022 07:30:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DAE8440289;
	Fri,  8 Apr 2022 07:30:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R10Ncl5Ep3kw; Fri,  8 Apr 2022 07:30:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B52E040139;
	Fri,  8 Apr 2022 07:30:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 86DEEC002C;
	Fri,  8 Apr 2022 07:30:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 43285C0012
 for <iommu@lists.linux-foundation.org>; Fri,  8 Apr 2022 04:10:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2253940105
 for <iommu@lists.linux-foundation.org>; Fri,  8 Apr 2022 04:10:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ssFTs1S_IOQG for <iommu@lists.linux-foundation.org>;
 Fri,  8 Apr 2022 04:10:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F3756400D7
 for <iommu@lists.linux-foundation.org>; Fri,  8 Apr 2022 04:10:13 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id D09BD61E28;
 Fri,  8 Apr 2022 04:10:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 346FDC385A6;
 Fri,  8 Apr 2022 04:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649391012;
 bh=s5hllkVWyKG3dwiRu2x53s6FttJzBDWJDsJdzlkdWME=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=tQtUUgGg5F+MPr7OtlF15gjaq27E6Zt5oTtYbUl2IgZ5J+XKJdW2J79ZC2vsqr9X8
 p5JAhzAbMHSWGHfcw0v21guqZ1gk6W3U7dFZkvfvQtwhChgngCotkIyRL4Nq5+sSLA
 JG6oK/EWssmOZutGwnPZqTkXnK+7VIBV3gpyXO/aFgZKu0Hxfv/78DHusX3UE4C/BU
 h2BzgHPPyJQ9gh9+tHFcN9gwCKrDl49Xzngz5iaaa85nADt0A2xfWQ1ePEQJ7IW2Zu
 3/Fq6VK2PgEtF/YA3GIGhKjTGakuFDnemmdHxcGcaz6wZ5adJrKQQm/a3wiFRM1Fiv
 2q/eZALTS+MmQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 18876E8DBDD; Fri,  8 Apr 2022 04:10:12 +0000 (UTC)
MIME-Version: 1.0
Subject: Re: [PATCH net-next] sfc: Stop using iommu_present()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <164939101209.29309.3949750124677153031.git-patchwork-notify@kernel.org>
Date: Fri, 08 Apr 2022 04:10:12 +0000
References: <7350f957944ecfce6cce90f422e3992a1f428775.1649166055.git.robin.murphy@arm.com>
In-Reply-To: <7350f957944ecfce6cce90f422e3992a1f428775.1649166055.git.robin.murphy@arm.com>
To: Robin Murphy <robin.murphy@arm.com>
X-Mailman-Approved-At: Fri, 08 Apr 2022 07:30:50 +0000
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ecree.xilinx@gmail.com, iommu@lists.linux-foundation.org,
 habetsm.xilinx@gmail.com, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hello:

This patch was applied to netdev/net-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  5 Apr 2022 14:40:55 +0100 you wrote:
> Even if an IOMMU might be present for some PCI segment in the system,
> that doesn't necessarily mean it provides translation for the device
> we care about. It appears that what we care about here is specifically
> whether DMA mapping ops involve any IOMMU overhead or not, so check for
> translation actually being active for our device.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> 
> [...]

Here is the summary with links:
  - [net-next] sfc: Stop using iommu_present()
    https://git.kernel.org/netdev/net-next/c/6a62924c0a81

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
