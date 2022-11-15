Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D13C1FC1
	for <iommu@lists.linux.dev>; Tue, 15 Nov 2022 03:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 162F4C433D7;
	Tue, 15 Nov 2022 03:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1668481216;
	bh=7GwYrxfGLtv3EWezChxqb+EW1qTYQWOsMI1x0yOy/oM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=C/bEiGywRVb82J2X3iohUPsoR5VFGT138fbFv/XrIkmjGs2ZRayyC7JCaEZlnMDLC
	 3K1T4KRAtqdTekG0wTAN0zp3bcdRkrV8ZjK/kjng4ybddpNbjHoPEP2WxwojQToVph
	 z+1XmL84ug3FedJjcKeQbug0BKPQAYWWUobPpx1QAaRDLYhqEAU4EXfIv/Yc1EKN2v
	 1A1Kttu2USPTmA+F+Yp11L4ve0gbojWUX3E4K0INQ9t3agglnd0LrNSGiELzqxo0KM
	 htIZ1DFY6o1h0R3UI8Zd4eE4x3fWvjqkQHLsUYIjAlB9d2pR4AFWb38IVzM9UmQrt5
	 EGkwh/TLqp5Rw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EA42FC395FE;
	Tue, 15 Nov 2022 03:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [patch 00/10] genirq/msi: Treewide cleanup of pointless linux/msi.h
 includes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <166848121595.31359.929419753615501478.git-patchwork-notify@kernel.org>
Date: Tue, 15 Nov 2022 03:00:15 +0000
References: <20221113201935.776707081@linutronix.de>
In-Reply-To: <20221113201935.776707081@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, maz@kernel.org, lee@kernel.org,
 damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
 james.smart@broadcom.com, dick.kennedy@broadcom.com, jejb@linux.ibm.com,
 martin.petersen@oracle.com, linux-scsi@vger.kernel.org, stuyoder@gmail.com,
 laurentiu.tudor@nxp.com, fenghua.yu@intel.com, dave.jiang@intel.com,
 vkoul@kernel.org, dmaengine@vger.kernel.org, ioana.ciornei@nxp.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, simon.horman@corigine.com, oss-drivers@corigine.com,
 Roy.Pledge@nxp.com, diana.craciun@oss.nxp.com, alex.williamson@redhat.com,
 cohuck@redhat.com, kvm@vger.kernel.org, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, iommu@lists.linux.dev

Hello:

This series was applied to netdev/net-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 13 Nov 2022 21:33:54 +0100 (CET) you wrote:
> While working on per device MSI domains I noticed that quite some files
> include linux/msi.h just because.
> 
> The top level comment in the header file clearly says:
> 
>   Regular device drivers have no business with any of these functions....
> 
> [...]

Here is the summary with links:
  - [06/10] net: dpaa2: Remove linux/msi.h includes
    https://git.kernel.org/netdev/net-next/c/515e5fb6a95e
  - [07/10] net: nfp: Remove linux/msi.h includes
    https://git.kernel.org/netdev/net-next/c/5fd66a0b3bb4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


