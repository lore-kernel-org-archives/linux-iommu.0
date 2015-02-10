From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH] CHROMIUM: iommu: rockchip: Make sure that page table state is coherent
Date: Tue, 10 Feb 2015 23:21:55 +0100
Message-ID: <1697393.usElVkPJfb@diego>
References: <1423480761-33453-1-git-send-email-tfiga@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423480761-33453-1-git-send-email-tfiga@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomasz Figa <tfiga@chromium.org>
Cc: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, Joerg Roedel <joro@8bytes.org>, Daniel Kurtz <djkurtz@chromium.org>
List-Id: iommu@lists.linux-foundation.org

Am Montag, 9. Februar 2015, 20:19:21 schrieb Tomasz Figa:
> Even though the code uses the dt_lock spin lock to serialize mapping
> operation from different threads, it does not protect from IOMMU
> accesses that might be already taking place and thus altering state
> of the IOTLB. This means that current mapping code which first zaps
> the page table and only then updates it with new mapping which is
> prone to mentioned race.
> 
> In addition, current code assumes that mappings are always > 4 MiB
> (which translates to 1024 PTEs) and so they would always occupy
> entire page tables. This is not true for mappings created by V4L2
> Videobuf2 DMA contig allocator.
> 
> This patch changes the mapping code to always zap the page table
> after it is updated, which avoids the aforementioned race and also
> zap the last page of the mapping to make sure that stale data is
> not cached from an already existing mapping.
> 
> Signed-off-by: Tomasz Figa <tfiga@chromium.org>
> Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>

I don't know enough about iommu-magic yet to review this properly, but on my 
rk3288-firefly the whole display pipeline stays in working condition, down to 
x11 and es2gears, so

Tested-by: Heiko Stuebner <heiko@sntech.de>
