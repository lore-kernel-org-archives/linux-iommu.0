From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 03/23] ARM: dt: tegra30: iommu: Add "nvidia,memory-clients"
Date: Mon, 01 Jul 2013 17:07:46 -0600
Message-ID: <51D20BC2.4090302@wwwdotorg.org>
References: <1372238906-9346-4-git-send-email-hdoyu@nvidia.com> <20130626101816.GE27083@manwe>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130626101816.GE27083@manwe>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 06/26/2013 04:18 AM, Thierry Reding wrote:
> On Wed, Jun 26, 2013 at 12:28:06PM +0300, Hiroshi Doyu wrote: 
> [...]
>> diff --git
>> a/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt
>> b/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt
>
>> 
[...]
>> @@ -23,3 +24,13 @@ Example: nvidia,swgroups = <0x00000000
>> 0x000779ff>; nvidia,ahb = <&ahb>; }; + +	host1x { +		compatible =
>> "nvidia,tegra30-host1x", "simple-bus"; +		nvidia,memory-clients =
>> <SWGID_HC>;
> 
> And this could use the SWGID(HC) to match up with how GPIOs are 
> referenced in the DTS files.

I only made TEGRA_GPIO(bank, id) a macro because there was a regular
bank/id structure to the GPIO numbering. I haven't read these patches
yet, but I assume SWGIDs are just a flat numbering space with
arbitrarily assigned number in HW, so there's no much point saying
SWGID(X) rather than SWGID_X.
