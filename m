From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 2/2] iommu/io-pgtable-arm: use
 __dma_sync_single_for_device()
Date: Mon, 9 May 2016 10:35:41 +0100
Message-ID: <20160509093540.GF19763@arm.com>
References: <1462705196-10857-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
 <1462705196-10857-3-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1462705196-10857-3-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, dmaengine@vger.kernel.org, joro@8bytes.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, robin.murphy@arm.com
List-Id: iommu@lists.linux-foundation.org

On Sun, May 08, 2016 at 12:59:56PM +0200, Niklas S=F6derlund wrote:
> The call to dma_sync_single_for_device() can be reached from
> dma_map_single(). If CONFIG_DMA_API_DEBUG is enabled this would resul=
t
> in a check that the mapping being synced is valid. Since the call to
> dma_map_single is not yet completed the mapping is not recorded in
> dma-debug and the check fails and a warning is printed. Avoid this
> warning by calling __dma_sync_single_for_device() which don't preform
> this check.

Hmm, I don't understand why this would trigger that warning. The memory
being sync'd here is the page table memory, not the buffer being mapped=
=2E
The page table memory is "mapped" using dma_map_single in
__arm_lpae_alloc_pages, so it sounds like the issue something else.

Will
