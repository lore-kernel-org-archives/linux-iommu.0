From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu: use memunmap to free memremap
Date: Thu, 22 Nov 2018 17:03:18 +0100
Message-ID: <20181122160318.gmncgapsrwcwy6hy@8bytes.org>
References: <1542794027-93141-1-git-send-email-bianpan2016@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1542794027-93141-1-git-send-email-bianpan2016@163.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pan Bian <bianpan2016@163.com>
Cc: David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Nov 21, 2018 at 05:53:47PM +0800, Pan Bian wrote:
> memunmap() should be used to free the return of memremap(), not
> iounmap().
> 
> Fixes: dfddb969edf0("iommu/vt-d: Switch from ioremap_cache to memremap")
> Signed-off-by: Pan Bian <bianpan2016@163.com>
> ---
>  drivers/iommu/intel-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.
