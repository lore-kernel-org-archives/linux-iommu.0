From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/vt-d: fix shift-out-of-bounds in bug checking
Date: Thu, 3 May 2018 15:27:00 +0200
Message-ID: <20180503132700.djfqox2gokzqybct@8bytes.org>
References: <1524202195-4656-1-git-send-email-changbin.du@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1524202195-4656-1-git-send-email-changbin.du@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: changbin.du@intel.com
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Apr 20, 2018 at 01:29:55PM +0800, changbin.du@intel.com wrote:
> 
> Signed-off-by: Changbin Du <changbin.du@intel.com>
> ---
>  drivers/iommu/dmar.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied and put a patch on-top to change the BUG_ON to a WARN_ON_ONCE.
