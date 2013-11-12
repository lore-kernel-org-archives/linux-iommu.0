From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCHv4 2/7] driver/core: Populate IOMMU'able devices in order
Date: Tue, 12 Nov 2013 16:34:20 -0700
Message-ID: <5282BAFC.8070405@wwwdotorg.org>
References: <1384158718-4756-1-git-send-email-hdoyu@nvidia.com> <1384158718-4756-3-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1384158718-4756-3-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 11/11/2013 01:31 AM, Hiroshi Doyu wrote:
> An "IOMMU device" on the bus is poplulated first, "IOMMU'able devices"
> are done later.
> 
> With CONFIG_OF_IOMMU, "#stream-id-cells" DT binding would be used to
> identify whether a device is IOMMU'able or not. If a device is
> IOMMU'able, we'll defer to populate that device till an iommu device
> is populated. Once an iommu device is populated, "dev->bus->iommu_ops"
> is set in the bus. Then, those defered IOMMU'able devices are
> populated and configured as IOMMU'abled with help of the already
> populated iommu device via iommu_ops->add_device().

This looks fairly neat and clean.

I'm still worried about using #stream-id-cells in DT nodes though. While
I do understand that the *Linux* device model currently only allows each
struct device to be affected by a single IOMMU, I worry that encoding
that same restriction into DT is a mistake. I'd far rather see a
property like:

SMMU:
    smmu: smmu@xxxxxx {
        #smmu-cells = <1>;
    }

Affected device:
    smmus = <&smmu 1>;
    (perhaps with smmu-names too)

That would allow the DT to represent basically arbitrary HW configurations.

The implementation of this patch would then be almost as trivial; you'd
just need to walk the smmus property to find each phandle in turn, just
like any other phandle+specifier property, and validate that the SMMU
driver was already probe()d for each.
