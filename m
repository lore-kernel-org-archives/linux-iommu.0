From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCHv5 6/9] iommu/tegra: smmu: get swgroups from DT "iommus="
Date: Tue, 19 Nov 2013 14:52:01 -0700
Message-ID: <528BDD81.1000507@wwwdotorg.org>
References: <1384853593-32202-1-git-send-email-hdoyu@nvidia.com>
	<1384853593-32202-7-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1384853593-32202-7-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 11/19/2013 02:33 AM, Hiroshi Doyu wrote:
> This provides the info about which swgroups a device belongs to. This
> info is passed from DT. This is necessary for the unified SMMU driver
> among Tegra SoCs since each has different H/W accelerators.

> diff --git a/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt b/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt

>  - nvidia,#asids : # of ASIDs
>  - dma-window : IOVA start address and length.
>  - nvidia,ahb : phandle to the ahb bus connected to SMMU.
> +- iommus: phandle to an iommu device which a device is
> +  attached to and indicates which swgroups a device belongs to(SWGROUP ID).
> +  SWGROUP ID is from 0 to 63, and a device can belong to multiple SWGROUPS.

I'm sure I've said this before:

#iommu-cells isn't documented.

The list of properties you added to is a list of properties that the
IOMMU node should contain. However, the iommus property is something
that *client* nodes should contain, not the IOMMU node itself.

Instead, I think you want something like:

-Required properties:
+Required properties in the IOMMU node:
 ... the current list of properties
+#iommu-cells. Should be 2. In client IOMMU specifiers, the two cells
+  represent a 64-bit bitmask of SWGROUP IDs under which the device
+  initiates transactions. The least significant word is first. See
+  <dt-bindings/memory/tegra-swgroup.h> for a list of valid values.
+
+Required properties in device nodes affected by the IOMMU:
+- iommus: A list of phandle plus specifier pairs for each IOMMU that
+    affects master transactions initiated by the device. The number of
+    cells in each specifier is defined by the #iommu-cells property in
+    the IOMMU node referred to by the phandle. The meaning of the
+    specifier cells is defined by the referenced IOMMU's binding.

Aside from those layout/wording issues, this is certainly the binding
that I think makes sense.

> +	host1x {
> +		compatible = "nvidia,tegra30-host1x", "simple-bus";
> +		iommus = <&smmu TEGRA_SWGROUP_CELLS(HC)>;
> +		....
> +		gr3d {
> +			compatible = "nvidia,tegra30-gr3d";
> +			nvidia,memory-clients = <&smmu TEGRA_SWGROUP_CELLS(NV)
> +						       TEGRA_SWGROUP_CELLS(NV2)>;

I think you forgot to update "nvidia,memory-clients" to "iommus" there.

> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c

> +static int smmu_of_get_swgroups(struct device *dev, unsigned long *swgroups)

This doesn't seem to be used by anything in this patch.
