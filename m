From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] Revert "iommu/io-pgtable-arm: Check for v7s-incapable
 systems"
Date: Mon, 17 Dec 2018 10:20:04 +0100
Message-ID: <20181217092004.3s2nwcuwus3wdljs@8bytes.org>
References: <1544692788-24427-1-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1544692788-24427-1-git-send-email-yong.wu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yong Wu <yong.wu@mediatek.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Tomasz Figa <tfiga@google.com>, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, youlin.pei@mediatek.com, Nicolas Boichat <drinkcat@chromium.org>, CK Hu <ck.hu@mediatek.com>, Stephen Boyd <swboyd@chromium.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Dec 13, 2018 at 05:19:48PM +0800, Yong Wu wrote:
> This reverts commit 82db33dc5e49fb625262d81125625d07a0d6184e.
> 
> After the commit 29859aeb8a6e ("iommu/io-pgtable-arm-v7s: Abort
> allocation when table address overflows the PTE"), v7s will return fail
> if the page table allocation isn't expected. this PHYS_OFFSET check
> is unnecessary now.
> 
> And this check may lead to fail. For example, If CONFIG_RANDOMIZE_BASE
> is enabled, the "memstart_addr" will be updated randomly, then the
> PHYS_OFFSET may be random.
> 
> Reported-by: CK Hu <ck.hu@mediatek.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/iommu/io-pgtable-arm-v7s.c | 4 ----
>  1 file changed, 4 deletions(-)

Applied to iommu/fixes, thanks.
