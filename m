Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC26A7474
	for <iommu@lists.linux.dev>; Tue, 10 Jan 2023 14:03:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A38EC433D2;
	Tue, 10 Jan 2023 14:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1673359381;
	bh=e9t1+X+RfhH7WrNszHXC4AMmV7DcA4dWVnvqtiPupgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rqEVRIg2eQG33muLXzDZdm/qU4hwhkf2aCLw5Dm+3YVtH9vjHLAK3zwI4h1PUOmPs
	 EU5HcseJddw6MM212c2oEjKD1UapgubXQ/N0JA5zW/TDPUA+4WxkUeyUy9EppSyuDU
	 ZS8GzMqlJ6lJA7taZ9dfv5Ej3JYY/Cs0+KF9cHwrAqYvZZI+UrPbG+Uk/2AwF3QfGf
	 yufAW3xWg7qJshGyuZIxo+WXivq+uayOd70huw4nqlvnJ88ylBVp9MAw4x97NF6rMj
	 HENX96ZYIcgeL+DxFiZkSBqdI4LMhTf5QYgksS1XM/kE+7boGuMGfdzoF820HCqoDg
	 a7dwxt0Gu9Akg==
From: Will Deacon <will@kernel.org>
To: iommu@lists.linux.dev,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org,
	Michael Walle <michael@walle.cc>,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2 1/2] iommu/arm-smmu: don't unregister on shutdown
Date: Tue, 10 Jan 2023 14:02:53 +0000
Message-Id: <167335530178.54040.9319729864816203532.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221215141251.3688780-1-vladimir.oltean@nxp.com>
References: <20221215141251.3688780-1-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 15 Dec 2022 16:12:50 +0200, Vladimir Oltean wrote:
> Michael Walle says he noticed the following stack trace while performing
> a shutdown with "reboot -f". He suggests he got "lucky" and just hit the
> correct spot for the reboot while there was a packet transmission in
> flight.
> 
> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000098
> CPU: 0 PID: 23 Comm: kworker/0:1 Not tainted 6.1.0-rc5-00088-gf3600ff8e322 #1930
> Hardware name: Kontron KBox A-230-LS (DT)
> pc : iommu_get_dma_domain+0x14/0x20
> lr : iommu_dma_map_page+0x9c/0x254
> Call trace:
>  iommu_get_dma_domain+0x14/0x20
>  dma_map_page_attrs+0x1ec/0x250
>  enetc_start_xmit+0x14c/0x10b0
>  enetc_xmit+0x60/0xdc
>  dev_hard_start_xmit+0xb8/0x210
>  sch_direct_xmit+0x11c/0x420
>  __dev_queue_xmit+0x354/0xb20
>  ip6_finish_output2+0x280/0x5b0
>  __ip6_finish_output+0x15c/0x270
>  ip6_output+0x78/0x15c
>  NF_HOOK.constprop.0+0x50/0xd0
>  mld_sendpack+0x1bc/0x320
>  mld_ifc_work+0x1d8/0x4dc
>  process_one_work+0x1e8/0x460
>  worker_thread+0x178/0x534
>  kthread+0xe0/0xe4
>  ret_from_fork+0x10/0x20
> Code: d503201f f9416800 d503233f d50323bf (f9404c00)
> ---[ end trace 0000000000000000 ]---
> Kernel panic - not syncing: Oops: Fatal exception in interrupt
> 
> [...]

Applied to will (for-joerg/arm-smmu/fixes), thanks!

[1/2] iommu/arm-smmu: don't unregister on shutdown
      https://git.kernel.org/will/c/42afa58a2431
[2/2] iommu/arm-smmu-v3: don't unregister on shutdown
      https://git.kernel.org/will/c/1dc4b4b5c5e7

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
