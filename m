From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 2/6] iommu/ipmmu-vmsa: Prepare to handle 40-bit error
 addresses
Date: Thu, 11 Apr 2019 10:23:40 +0200
Message-ID: <20190411082340.rtqnhizeb4njafmk@verge.net.au>
References: <20190403182148.18058-1-geert+renesas@glider.be>
 <20190403182148.18058-3-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190403182148.18058-3-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Joerg Roedel <joro@8bytes.org>, Magnus Damm <damm+renesas@opensource.se>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, iommu@lists.linux-foundation.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Apr 03, 2019 at 08:21:44PM +0200, Geert Uytterhoeven wrote:
> On R-Car Gen3, the faulting virtual address is a 40-bit address, and
> comprised of two registers.  Read the upper address part, and combine
> both parts, when running on a 64-bit system.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Apart from this, the driver doesn't support 40-bit IOVA addresses yet.

None the less this seems like progress.

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
