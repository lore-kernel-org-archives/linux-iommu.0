From: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Subject: Re: [RESEND 0/6] iommu: ipmmu-vmsa: Add more Gen3 SoCs support
Date: Wed, 20 Jun 2018 13:29:14 +0200
Message-ID: <20180620112909.gzbdpj2kwcehebnx@verge.net.au>
References: <1528973306-7962-1-git-send-email-jacopo+renesas@jmondi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1528973306-7962-1-git-send-email-jacopo+renesas-AW8dsiIh9cEdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jacopo Mondi <jacopo+renesas-AW8dsiIh9cEdnm+yROfE0A@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

[CC Alex Williamson]

On Thu, Jun 14, 2018 at 12:48:20PM +0200, Jacopo Mondi wrote:
> Hello,
>    this series collects patches sent to mailing lists in late 2017 to add
> support for a number of R-Car Gen3 SoCs to the ipmmu-vmsa driver.
> 
> Part of the series these patches were part of went in through Alex Williamson
> tree and are now included in v4.17.
> 
> These patches have not yet been collected, and need to be rebased on v4.17,
> and this what this series serves for.
> 
> The series:
> - Increses the micro-TLB size to 48bits to accomodate newer SoCs
> - Adds support for M3-N, M3-W, V3-M and E3 to ipmmu-vmsa driver
> - Documents M3-N, V3H and E3 device tree bindings
> 
> All patches have been acked/reviewed by, if nothing big happens they should
> be ready to be collected.

All patches:

Reviewed-by: Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>

Joerg, Alex,

I'd be most grateful if we could find a way for these patches to progress
into mainline.

> 
> Thanks
>    j
> 
> Jacopo Mondi (2):
>   dt-bindings: iommu/ipmmu-vmsa: Add R-Car M3-N (R8A77965)
>   iommu/ipmmu-vmsa: Hook up R8A77965 DT matching code
> 
> Magnus Damm (3):
>   iommu/ipmmu-vmsa: Increase maximum micro-TLBS to 48
>   iommu/ipmmu-vmsa: Hook up r8a7796 DT matching code
>   iommu/ipmmu-vmsa: Document R-Car V3H and E3 IPMMU DT bindings
> 
> Simon Horman (1):
>   iommu/ipmmu-vmsa: Hook up r8a779(70|95) DT matching code
> 
>  .../bindings/iommu/renesas,ipmmu-vmsa.txt          |  3 ++
>  drivers/iommu/ipmmu-vmsa.c                         | 38 ++++++++++++++++++----
>  2 files changed, 34 insertions(+), 7 deletions(-)
> 
> --
> 2.7.4
> 
