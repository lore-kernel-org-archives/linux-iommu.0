From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2] memory: mtk-smi: Handle return value of
 clk_prepare_enable
Date: Tue, 15 Aug 2017 17:47:26 +0200
Message-ID: <20170815154726.GC25618@8bytes.org>
References: <daeed02ff9e257286bbae9e4e496e40e4c5480c5.1502341483.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <daeed02ff9e257286bbae9e4e496e40e4c5480c5.1502341483.git.arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: matthias.bgg@gmail.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Aug 10, 2017 at 10:47:32AM +0530, Arvind Yadav wrote:
> clk_prepare_enable() can fail here and we must check its return value.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
> changes in v2:
>              Rebase patch[1]https://lkml.org/lkml/2017/8/3/968
>              and apply this change. Otherwise will merge conflict.
> 
>  drivers/memory/mtk-smi.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Applied, thanks.
