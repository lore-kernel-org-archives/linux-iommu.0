From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] iommu/ipmmu-vmsa: Add r8a7795 DT binding
Date: Wed, 2 Mar 2016 09:30:19 +0900
Message-ID: <20160302003019.GI17986@verge.net.au>
References: <20160229143309.28517.77269.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160229143309.28517.77269.sendpatchset@little-apple>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: devicetree@vger.kernel.org, mark.rutland@arm.com, laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, joro@8bytes.org, linux-renesas-soc@vger.kernel.org, iommu@lists.linux-foundation.org, robh+dt@kernel.org, galak@codeaurora.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Feb 29, 2016 at 11:33:09PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
> 
> Update the IPMMU DT binding documentation to include the r8a7795 compat
> string as well as the "renesas,ipmmu-main" property that on r8a7795 will
> be used to describe the topology and the relationship between the various
> cache IPMMU instances and the main IPMMU.
> 
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
