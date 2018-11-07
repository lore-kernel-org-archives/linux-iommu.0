From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/ipmmu-vmsa: Fix crash on early domain free
Date: Wed, 7 Nov 2018 16:34:18 +0100
Message-ID: <20181107153418.cge2dj5zmztahxrf@8bytes.org>
References: <20181107131850.11584-1-geert+renesas@glider.be>
 <e4dcd8b2-768e-b11d-b6de-337b7e942050@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e4dcd8b2-768e-b11d-b6de-337b7e942050@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, iommu@lists.linux-foundation.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Nov 07, 2018 at 01:22:52PM +0000, Robin Murphy wrote:
> On 2018-11-07 1:18 pm, Geert Uytterhoeven wrote:
> > Fix this by checking if the domain's context already exists, before
> > trying to destroy it.
> 
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Does this need a Fixes-tag? If so, which patch should be in that tag?


Thanks,

	Joerg
