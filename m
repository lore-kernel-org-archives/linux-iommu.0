From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/vt-d: fix memory leak
Date: Tue, 29 Sep 2015 15:40:46 +0200
Message-ID: <20150929134046.GA7572@8bytes.org>
References: <1442573827-28795-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1442573827-28795-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Sep 18, 2015 at 04:27:07PM +0530, Sudip Mukherjee wrote:
> We are returning NULL if we are not able to attach the iommu to the
> domain but while returning we missed freeing info.
> 
> Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> ---
>  drivers/iommu/intel-iommu.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.
