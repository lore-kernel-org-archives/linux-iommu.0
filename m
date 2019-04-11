From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 5/6] iommu/ipmmu-vmsa: Extract hardware context
 initialization
Date: Thu, 11 Apr 2019 10:34:49 +0200
Message-ID: <20190411083449.i4khi3sqp5ybl7e2@verge.net.au>
References: <20190403182148.18058-1-geert+renesas@glider.be>
 <20190403182148.18058-6-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190403182148.18058-6-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Joerg Roedel <joro@8bytes.org>, Magnus Damm <damm+renesas@opensource.se>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, iommu@lists.linux-foundation.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Apr 03, 2019 at 08:21:47PM +0200, Geert Uytterhoeven wrote:
> ipmmu_domain_init_context() takes care of (1) initializing the software
> domain, and (2) initializing the hardware context for the domain.
> 
> Extract the code to initialize the hardware context into a new subroutine
> ipmmu_domain_setup_context(), to prepare for later reuse.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
