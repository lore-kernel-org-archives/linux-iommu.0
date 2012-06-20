From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 1/5] iommu/tegra: smmu: Add DMA window parser,
	of_get_dma_window()
Date: Wed, 20 Jun 2012 11:11:51 -0600
Message-ID: <4FE20457.8090307@wwwdotorg.org>
References: <20120521124707.GC2604@amd.com>
	<1340176620-13012-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1340176620-13012-1-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 06/20/2012 01:16 AM, Hiroshi DOYU wrote:
> From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> 
> This code was based on:
>     "arch/microblaze/kernel/prom_parse.c"
>     "arch/powerpc/kernel/prom_parse.c"
> 
> Can be promoted as a global function for general use to replace
> "of_parse_dma_window()" in the above. This supports different formats
> flexibly. "prefix" can be configured if any. "busno" and "index" are
> optionally specified. Set NULL and 0 if not used.
> 
> Signed-off-by: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
> Based on the discussion:
> http://marc.info/?l=linux-tegra&m=133732046606458&w=2

Hmmm. This function really should be in some common location and
available for all drivers to use. Can't we add it to that common
location from the start? What prevented the earlier patch that did this
from getting merged into 3.5?

One thing that might help here would be /not/ to add the common code to
drivers/of/of_dma.c as was done in the earlier revisions of this patch -
I believe that Grant has been trying to push subsystem-specific OF
functionality into files in those individual subsystems, so that
drivers/of can be kept for core support. Perhaps this patch should
create drivers/iommu/of_iommu.c or similar?

But I wonder: Is this function likely to be useful outside of
drivers/iommu/ - you mentioned that similar code already exists in the
two arch-specific prom_parse.c files; where are the existing users of
those functions. If not in drivers/iommu/, then probably drivers/iommu/
isn't a good place to put the new common function...

> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c

> +static int of_get_dma_window(struct device_node *dn,
> +			const char *prefix, int index,
> +			unsigned long *busno,
> +			dma_addr_t *addr, size_t *size)

> +	const char *s = "";

> +	if (prefix)
> +		s = prefix;

One minor nit, you could just do this and remove variable s:

if (!prefix)
    prefix = "";
