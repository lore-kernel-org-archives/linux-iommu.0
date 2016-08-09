From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH -next] iommu/amd: Fix non static symbol warning
Date: Tue, 9 Aug 2016 17:19:10 +0200
Message-ID: <20160809151910.GA29650@8bytes.org>
References: <1469671793-13052-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1469671793-13052-1-git-send-email-weiyj.lk@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Jul 28, 2016 at 02:09:53AM +0000, Wei Yongjun wrote:
> Fixes the following sparse warning:
> 
> drivers/iommu/amd_iommu.c:106:1: warning:
>  symbol '__pcpu_scope_flush_queue' was not declared. Should it be static?
> 
> Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>

Applied, thanks.
