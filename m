From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 2/3] iommu/amd: constify mmu_notifier_ops structures
Date: Mon, 14 Dec 2015 15:45:00 +0100
Message-ID: <20151214144500.GA11292@8bytes.org>
References: <1448834571-2988-1-git-send-email-Julia.Lawall@lip6.fr>
 <1448834571-2988-3-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1448834571-2988-3-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: kernel-janitors@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Sun, Nov 29, 2015 at 11:02:50PM +0100, Julia Lawall wrote:
> This mmu_notifier_ops structure is never modified, so declare it as
> const, like the other mmu_notifier_ops structures.
> 
> Done with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> ---
> The patches in this series are independent of each other.
> 
>  drivers/iommu/amd_iommu_v2.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.
