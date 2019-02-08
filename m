From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] remove unused end_pfn
Date: Fri, 8 Feb 2019 17:23:57 +0100
Message-ID: <20190208162357.GX32526@8bytes.org>
References: <2017datesandletters@somehostname>
 <20190208140439.26738-1-murphyt7@tcd.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190208140439.26738-1-murphyt7@tcd.ie>
Sender: linux-kernel-owner@vger.kernel.org
To: Tom Murphy <murphyt7@tcd.ie>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Feb 08, 2019 at 02:04:38PM +0000, Tom Murphy wrote:
> This variable is useless.
> 
> ---
>  drivers/iommu/dma-iommu.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

A similar change is already in the iommu tree[1].

	Joerg

[1] https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git/commit/?h=core
