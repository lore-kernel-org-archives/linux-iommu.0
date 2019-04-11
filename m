From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 3/6] iommu/ipmmu-vmsa: Make IPMMU_CTX_MAX unsigned
Date: Thu, 11 Apr 2019 10:26:09 +0200
Message-ID: <20190411082609.bb6wl5dbusxjxccb@verge.net.au>
References: <20190403182148.18058-1-geert+renesas@glider.be>
 <20190403182148.18058-4-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190403182148.18058-4-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Joerg Roedel <joro@8bytes.org>, Magnus Damm <damm+renesas@opensource.se>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, iommu@lists.linux-foundation.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Apr 03, 2019 at 08:21:45PM +0200, Geert Uytterhoeven wrote:
> Make the IPMMU_CTX_MAX constant unsigned, to match the type of
> ipmmu_features.number_of_contexts.
> 
> This allows to use plain min() instead of type-casting min_t().
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
