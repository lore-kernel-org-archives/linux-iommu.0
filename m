From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/omap: remove DEBUG_SEQ_FOPS_RO()
Date: Thu, 22 Nov 2018 17:12:08 +0100
Message-ID: <20181122161208.gp6vrnziuayschai@8bytes.org>
References: <20181122135443.25035-1-tiny.windzz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181122135443.25035-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yangtao Li <tiny.windzz@gmail.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Nov 22, 2018 at 08:54:43AM -0500, Yangtao Li wrote:
> Because we already have the DEFINE_SHOW_ATTRIBUTE,there is no need
> to define such a macro.So remove DEBUG_SEQ_FOPS_RO.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/iommu/omap-iommu-debug.c | 25 ++++++-------------------
>  1 file changed, 6 insertions(+), 19 deletions(-)

Applied, thanks.
