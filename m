From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCHv3 10/19] iommu/tegra: smmu: Get "nvidia,swgroups" from DT
Date: Thu, 31 Oct 2013 10:15:31 -0700
Message-ID: <20131031171530.GC3037@kartoffel>
References: <1382092020-13170-1-git-send-email-hdoyu@nvidia.com>
	<1382092020-13170-11-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1382092020-13170-11-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Oct 18, 2013 at 11:26:51AM +0100, Hiroshi Doyu wrote:
> This provides the info about which H/W Accelerators are supported on
> Tegra SoC. This info is passed from DT. This is necessary to have the
> unified SMMU driver among Tegra SoCs. Instead of using platform data,
> DT passes "nvidia,swgroups" now. DT is mandatory in Tegra.
> 
> Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  .../bindings/iommu/nvidia,tegra30-smmu.txt         |  6 +++++
>  drivers/iommu/tegra-smmu.c                         | 31 ++++++++++------------
>  2 files changed, 20 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt b/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt
> index 89fb543..6a844b3 100644
> --- a/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt
> +++ b/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt
> @@ -8,6 +8,11 @@ Required properties:
>  - nvidia,#asids : # of ASIDs
>  - dma-window : IOVA start address and length.
>  - nvidia,ahb : phandle to the ahb bus connected to SMMU.
> +- nvidia,swgroups: A bitmap of supported HardWare Accelerators(HWA).
> +  Each bit represents one swgroup. The assignments may be found in header
> +  file <dt-bindings/memory/tegra-swgroup.h>. Its max is 64. 2 cells
> +  are required. This unique ID info can be used to calculate
> +  MC_SMMU_<SWGROUP name>_ASID_0 offset and HOTRESET bit.

I'd prefer that you pointed out the type of the property explicitly at the
beginning of the description. It's difficult to spot it in the middle, and
while the current description defines that the property is two cells, it
doesn't point out that they are expected to form a (big endian) u64 (rather
than an array of two u32s).

While we don't yet have a formal set of rules for consistent binding
documentation, defining the explicitly is one of the requirements I'd like to
push for in new bindings. Placing this at the start of the description makes it
far easier to skim a binding document and perform basic sanity checks of the
binding itself, dts using the binding, and kernel code parsing it.

Cheers,
Mark.
