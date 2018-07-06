From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/amd: Argument page_size could be uninitialized
Date: Fri, 6 Jul 2018 13:18:40 +0200
Message-ID: <20180706111839.wwgnewib2r6xf4jd@8bytes.org>
References: <1527877815-11132-1-git-send-email-yzhai003@ucr.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1527877815-11132-1-git-send-email-yzhai003@ucr.edu>
Sender: linux-kernel-owner@vger.kernel.org
To: "yzhai003@ucr.edu" <yzhai003@ucr.edu>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, csong@cs.ucr.edu, zhiyunq@cs.ucr.edu
List-Id: iommu@lists.linux-foundation.org

On Fri, Jun 01, 2018 at 11:30:14AM -0700, yzhai003@ucr.edu wrote:
> Argument "page_size" passing to function "fetch_pte" could be
> uninitialized if the function returns NULL
> 
> The caller "iommu_unmap_page" checks the return value but the page_size is
> used outside the if block.
> 
> Signed-off-by: yzhai003@ucr.edu <yzhai003@ucr.edu>
> ---
>  drivers/iommu/amd_iommu.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.
