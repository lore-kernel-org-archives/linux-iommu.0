From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 3/3] iommu/ipmmu-vmsa: Document R-Car D3 IPMMU DT bindings
Date: Tue, 3 Oct 2017 16:45:19 -0500
Message-ID: <20171003214519.e2nngyicqqxt74oj@rob-hp-laptop>
References: <150603029494.9664.3785539947602559695.sendpatchset@little-apple>
 <150603032614.9664.3191963173399472802.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <150603032614.9664.3191963173399472802.sendpatchset@little-apple>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: devicetree@vger.kernel.org, mark.rutland@arm.com, laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, joro@8bytes.org, linux-renesas-soc@vger.kernel.org, iommu@lists.linux-foundation.org, horms+renesas@verge.net.au, robin.murphy@arm.com
List-Id: iommu@lists.linux-foundation.org

On Fri, Sep 22, 2017 at 06:45:26AM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
> 
> Update the IPMMU DT binding documentation to include the r8a77995 compat
> string for the IPMMU devices included in the R-Car D3 SoC.
> 
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> ---
> 
>  Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt |    1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
