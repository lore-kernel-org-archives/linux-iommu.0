From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3 02/10] devicetree: Add generic IOMMU device tree
 bindings
Date: Fri, 27 Jun 2014 14:55:38 +0100
Message-ID: <20140627135537.GU26276@arm.com>
References: <1403815790-8548-1-git-send-email-thierry.reding@gmail.com>
 <1403815790-8548-3-git-send-email-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1403815790-8548-3-git-send-email-thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Dave P Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>, Marc Zyngier <Marc.Zyngier-5wv7dgnIgG8@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Paul Walmsley <pwalmsley-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Rhyland Klein <rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Allen Martin <amartin-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra@vger.>
List-Id: iommu@lists.linux-foundation.org

Hi Thierry,

On Thu, Jun 26, 2014 at 09:49:42PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> 
> This commit introduces a generic device tree binding for IOMMU devices.
> Only a very minimal subset is described here, but it is enough to cover
> the requirements of both the Exynos System MMU and Tegra SMMU as
> discussed here:
> 
>     https://lkml.org/lkml/2014/4/27/346
> 
> Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

[...]

> +Required properties:
> +--------------------
> +- #iommu-cells: The number of cells in an IOMMU specifier needed to encode an
> +  address.
> +
> +Typical values for the above include:
> +- #iommu-cells = <0>: Single master IOMMU devices are not configurable and
> +  therefore no additional information needs to be encoded in the specifier.
> +  This may also apply to multiple master IOMMU devices that do not allow the
> +  association of masters to be configured.

A multiple-master capable IOMMU could be built with a single master, but
we'd still need #iommu-cells > 0 here. I appreciate this is just an example,
but the wording sounds like it's enforced.

> +- #iommu-cells = <1>: Multiple master IOMMU devices may need to be configured
> +  in order to enable translation for a given master. In such cases the single
> +  address cell corresponds to the master device's ID.

Again, we will definitely need more than one cell in this case, as I fully
expect multiple StreamIDs for each master (e.g. Qualcomm mentioned on the
list the other day that they have a master emitting 43 unique IDs).

Anyway, the actual binding looks great, I just don't want people to think
they need to do something different because they don't fit your example
use-cases.

> +Multiple-master IOMMU:
> +----------------------
> +
> +	iommu {
> +		/* the specifier represents the ID of the master */
> +		#iommu-cells = <1>;
> +	};
> +
> +	master {
> +		/* device has master ID 42 in the IOMMU */
> +		iommus = <&/iommu 42>;
> +	};
> +
> +Multiple-master IOMMU with configurable DMA window:
> +---------------------------------------------------
> +
> +	/ {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		iommu {
> +			/* master ID, address and length of DMA window */
> +			#iommu-cells = <4>;
> +		};
> +
> +		master {
> +			/* master ID 42, 4 GiB DMA window starting at 0 */
> +			iommus = <&/iommu  42  0  0x1 0x0>;
> +		};
> +	};

Could you also please include an example of a master with multiple IDs?

Will
