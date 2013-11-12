From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCHv4 2/7] driver/core: Populate IOMMU'able devices in order
Date: Tue, 12 Nov 2013 16:30:15 -0700
Message-ID: <5282BA07.20506@wwwdotorg.org>
References: <1384158718-4756-1-git-send-email-hdoyu@nvidia.com> <1384158718-4756-3-git-send-email-hdoyu@nvidia.com> <20131111113936.GH28302@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131111113936.GH28302-MRww78TxoiP5vMa5CHWGZ34zcgK1vI+I0E9HWUfgJXw@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 11/11/2013 04:39 AM, Will Deacon wrote:
> On Mon, Nov 11, 2013 at 08:31:53AM +0000, Hiroshi Doyu wrote:
>> An "IOMMU device" on the bus is poplulated first, "IOMMU'able devices"
>> are done later.
>>
>> With CONFIG_OF_IOMMU, "#stream-id-cells" DT binding would be used to
>> identify whether a device is IOMMU'able or not. If a device is
>> IOMMU'able, we'll defer to populate that device till an iommu device
>> is populated. Once an iommu device is populated, "dev->bus->iommu_ops"
>> is set in the bus. Then, those defered IOMMU'able devices are
>> populated and configured as IOMMU'abled with help of the already
>> populated iommu device via iommu_ops->add_device().
>>
>> Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>> ---
>> Update:
>> This is newly added, and the successor of the following RFC:
>>   [RFC][PATCHv3+ 1/2] driver/core: Add of_iommu_attach()
>>   http://lists.linuxfoundation.org/pipermail/iommu/2013-November/006914.html
> 
> This generally looks like the right idea to me, but it would be good to have
> the input from a DT maintainer on the use of "#stream-id-cells" as an indicator
> that a device is behind an IOMMU. (aside: I think "iommuable" is a horrible
> word!).
> 
> What happens if you do the deferring at the bus level? E.g. defer all device
> probes on a bus, until the IOMMU is probed for that bus. That might fit
> better with future work, where we will almost certainly need to expose more
> of the bus topology to Linux. Of course, I can see that falling down for
> monolithic virtual buses like the platform bus.

I don't think it's correct to think about "the IOMMU for the bus".

There could easily be multiple different IOMMU slave-sides attached to a
bus, and hence you'd need to defer probing until "all the IOMMs for the
bus" to be available.

Equally, I assume that dev->bus->iommu_ops rather assumes that bus
masters always master transactions onto the same bus that their control
registers are slaves upon. That also doesn't seem like a reasonable
assumption.

As such, I think an approach where each device waits for any IOMMUs that
affect it (wherever/whatever and however many they may be) is better
than one where we try to explicitly manage the probe order of devices
based on their slave registers' location.
