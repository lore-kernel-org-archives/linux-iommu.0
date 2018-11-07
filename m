From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/ipmmu-vmsa: Fix crash on early domain free
Date: Wed, 7 Nov 2018 17:04:06 +0100
Message-ID: <20181107160406.3j54niulfv5qgdx3@8bytes.org>
References: <20181107131850.11584-1-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181107131850.11584-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Robin Murphy <robin.murphy@arm.com>, Magnus Damm <magnus.damm@gmail.com>, iommu@lists.linux-foundation.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Nov 07, 2018 at 02:18:50PM +0100, Geert Uytterhoeven wrote:
 
> Fix this by checking if the domain's context already exists, before
> trying to destroy it.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/iommu/ipmmu-vmsa.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied, thanks.
