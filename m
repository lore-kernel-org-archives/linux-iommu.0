From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/arm-smmu: Fix sign-extension of upstream bus
 addresses at stage 1
Date: Mon, 11 May 2015 18:46:02 +0200
Message-ID: <20150511164601.GA10216@8bytes.org>
References: <1431103462-8153-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1431103462-8153-1-git-send-email-will.deacon@arm.com>
Sender: stable-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: iommu@lists.linux-foundation.org, Varun.Sethi@freescale.com, linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Fri, May 08, 2015 at 05:44:22PM +0100, Will Deacon wrote:
> Hi Joerg,
> 
> I only have this one fix pending for arm-smmu, so please could you pick
> it up for 4.1? I can send a pull if you'd prefer, but it feels a bit
> OTT.
> 
> Will
> 
>  drivers/iommu/arm-smmu.c | 30 ++----------------------------
>  1 file changed, 2 insertions(+), 28 deletions(-)

Applied to iommu/fixes, thanks.
