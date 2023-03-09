Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC43807
	for <iommu@lists.linux.dev>; Thu,  9 Mar 2023 07:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DFAE8C433AA;
	Thu,  9 Mar 2023 07:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1678347019;
	bh=pLu2EUjm0EUWWJ8Bq7EHf6FFQCmBn3/LFHoWP+HFOaM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TRQuKn87mlc14w2ao4dBhX1cwTkgy+XNoKUXHEVGLpkVkwA961dPU03wWDtoaRCoA
	 KyBg+99tIz4BIEUt4yRJjLm4kakaKOhBW2bABom535uQzWsAYQzIuv2b1wGgbxVv1I
	 h99HVGsJH5XnneOV/MClhLyGOSNsyynn8EROjm+3GxkFpvcDqjJgsJvhOCzKNNWsad
	 T7AURXwMYPT/hjEhGGqeiGj61NUZLPgN9CxIxpcYVno1yA6HaIr2DDe7b/W8+MxBYs
	 sw45PH57JbFR6WTsYZyqATB+g1nHYdBuBvdZyVhillv7JBDYRYVwybV3DK0ya5tBtz
	 fVjbtpLQp/f2A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CB1B0E61B60;
	Thu,  9 Mar 2023 07:30:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 00/11] tree-wide: remove support for Renesas R-Car H3 ES1
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <167834701982.22182.9521763384207545073.git-patchwork-notify@kernel.org>
Date: Thu, 09 Mar 2023 07:30:19 +0000
References: <20230307163041.3815-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20230307163041.3815-1-wsa+renesas@sang-engineering.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  7 Mar 2023 17:30:28 +0100 you wrote:
> Because H3 ES1 becomes an increasing maintenance burden and was only available
> to a development group, we decided to remove upstream support for it. Here are
> the patches to remove driver changes. Review tags have been gathered before
> during an internal discussion. Only change since the internal version is a
> plain rebase to v6.3-rc1. A branch with all removals is here:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/h3es1-removal
> 
> [...]

Here is the summary with links:
  - [07/11] ravb: remove R-Car H3 ES1.* handling
    https://git.kernel.org/netdev/net-next/c/6bf0ad7f2917

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


