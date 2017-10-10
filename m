From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/vt-d: Delete unnecessary check
Date: Tue, 10 Oct 2017 14:10:22 +0200
Message-ID: <20171010121022.rfwvz2xpwjavtn2r@8bytes.org>
References: <1507502011-18062-1-git-send-email-chris.gekas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1507502011-18062-1-git-send-email-chris.gekas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christos Gkekas <chris.gekas@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Sun, Oct 08, 2017 at 11:33:31PM +0100, Christos Gkekas wrote:
> Variable did_old is unsigned so checking whether it is greater or equal
> to zero is not necessary.
> 
> Signed-off-by: Christos Gkekas <chris.gekas@gmail.com>
> ---
>  drivers/iommu/intel-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.
