From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCHv5 2/9] driver/core: populate devices in order for IOMMUs
Date: Tue, 19 Nov 2013 14:22:47 -0700
Message-ID: <528BD6A7.3030908@wwwdotorg.org>
References: <1384853593-32202-1-git-send-email-hdoyu@nvidia.com><1384853593-32202-3-git-send-email-hdoyu@nvidia.com><20131119102506.GG31504@ulmo.nvidia.com> <20131119.140351.1342214267287135109.hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131119.140351.1342214267287135109.hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org" <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 11/19/2013 05:03 AM, Hiroshi Doyu wrote:
> Hi Thierry,
> 
> Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote @ Tue, 19 Nov 2013 11:25:07 +0100:
> 
>> From earlier discussions I thought the goal was to actually defer this
>> until all nodes referred to by the iommus property were actually
>> registered. The above only checks that the phandles can be resolved to
>> valid struct device_node:s. That doesn't mean that an actual IOMMU has
>> been registered for it, only that the devices have been created.
> 
> Currently "bus->iommu_ops" is set at the end of tegra_smmu_probe(). So
> if "bus->iommu_ops" is set, it means that an iommu instance is
> populated at that time.

Yes, but that's the register bus, upon which the device is a client, not
the bus upon which the device is a bus master. They aren't necessarily
the same.

There's no getting around the fact that, as Thierry said, you need to
search for a registered IOMMU device for each phandle, and defer probe
if any aren't registered yet.

If we do that, then you shouldn't need to look at the value of
dev->bus->iommu_ops at all; if all IOMMUs in the list were registered,
then iommu_ops must have been set when (one of them) was registered, and
if not, then it possibly wasn't, so defer probe.

That way, this code won't have to change if the core IOMMU code gets
extended to support multiple IOMMUs, devices mastering transactions onto
buses other than their register bus, etc.
