From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v7 05/07] iommu/ipmmu-vmsa: Add new IOMMU_DOMAIN_DMA ops
Date: Wed, 22 Mar 2017 15:25:55 +0100
Message-ID: <20170322142555.GN29659@8bytes.org>
References: <148885660307.28553.995847796823338863.sendpatchset@little-apple>
	<148885665352.28553.13907030016954382230.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <148885665352.28553.13907030016954382230.sendpatchset@little-apple>
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

On Tue, Mar 07, 2017 at 12:17:33PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
> 
> Introduce an alternative set of iommu_ops suitable for 64-bit ARM
> as well as 32-bit ARM when CONFIG_IOMMU_DMA=y. Also adjust the
> Kconfig to depend on ARM or IOMMU_DMA. Initialize the device
> from ->xlate() when CONFIG_IOMMU_DMA=y.
> 
> Signed-off-by: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
> ---
> 
>  Changes since V6:
>  - Rolled in the following patches from "r8a7795 support V2":
>    [PATCH v2 04/11] iommu/ipmmu-vmsa: Reuse iommu groups
>    [PATCH v2 06/11] iommu/ipmmu-vmsa: Teach xlate() to skip disabled iommus
>  - Moved find_group() implementation to prevent warning on 32-bit ARM
>  - Rolled in the following patch from "IPMMU slave device whitelist V2":
>    [PATCH/RFC v2 3/4] iommu/ipmmu-vmsa: Check devices in xlate()
> 
>  drivers/iommu/Kconfig      |    1 
>  drivers/iommu/ipmmu-vmsa.c |  164 +++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 157 insertions(+), 8 deletions(-)

Reviewed-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
