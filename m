From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH 00/04] iommu/ipmmu-vmsa: IPMMU CONFIG_IOMMU_DMA update
Date: Thu, 17 Mar 2016 10:22:50 +0200
Message-ID: <1563504.M3TNYUzKHf@avalon>
References: <20160315170431.20615.30333.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160315170431.20615.30333.sendpatchset@little-apple>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Magnus,

Thank you for the patches.

On Wednesday 16 March 2016 02:04:31 Magnus Damm wrote:
> iommu/ipmmu-vmsa: IPMMU CONFIG_IOMMU_DMA update
> 
> [PATCH 01/04] iommu/ipmmu-vmsa: 32-bit ARM may have CONFIG_IOMMU_DMA=y
> [PATCH 02/04] iommu/ipmmu-vmsa: Break out utlb parsing code
> [PATCH 03/04] iommu/ipmmu-vmsa: Break out domain allocation code
> [PATCH 04/04] iommu/ipmmu-vmsa: Add new IOMMU_DOMAIN_DMA ops
> 
> This series updates the IPMMU driver with CONFIG_IOMMU_DMA=y support
> which is present in mainline for 64-bit ARM while experimental support
> has been posted for 32-bit ARM thanks to Marek Szyprowski:
> 
> [RFC 0/3] Unify IOMMU-based DMA-mapping code for ARM and ARM64
> 
> Most of the patches in this series based on code earlier included in
> the series below but has been reworked to also fit on 32-bit ARM:
> 
> [PATCH/RFC 00/10] iommu/ipmmu-vmsa: Experimental r8a7795 support
> 
> Signed-off-by: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>

Great ! Thanks a lot for the work, I'm really happy to see this being 
addressed.

For patches 1/4 to 3/4,

Reviewed-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>

For patch 4/4, please see my comments in the reply to the patch.

> ---
> 
>  Built on top of next-20160315
>  Depends on [PATCH v2 00/04] iommu/ipmmu-vmsa: IPMMU multi-arch update V2
> 
>  drivers/iommu/ipmmu-vmsa.c |  238 ++++++++++++++++++++++++++++++----------
>  1 file changed, 174 insertions(+), 64 deletions(-)

-- 
Regards,

Laurent Pinchart
