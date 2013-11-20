From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Report from 2013 ARM kernel summit
Date: Wed, 20 Nov 2013 14:02:10 -0600
Message-ID: <CAL_Jsq+AxEWhkOhxwAZ=+rpzDZ+yC1b3ZV541UhOu9kiwUhUdQ@mail.gmail.com>
References: <20131119.114054.663999769447782808.hdoyu@nvidia.com>
	<20131119173524.GK11778@mudshark.cambridge.arm.com>
	<528BCDCE.6070006@gmail.com>
	<20131120.083955.1386179068365424976.hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131120.083955.1386179068365424976.hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Mark.Rutland-5wv7dgnIgG8@public.gmane.org" <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Lorenzo.Pieralisi-5wv7dgnIgG8@public.gmane.org" <Lorenzo.Pieralisi-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "ksummit-2013-discuss-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org" <ksummit-2013-discuss-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org>, "olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org" <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, "lwn-T1hC0tSOHrs@public.gmane.org" <lwn-T1hC0tSOHrs@public.gmane.org>, "paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org" <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, "khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Nov 20, 2013 at 12:39 AM, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
> Hi Rob,
>
> Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote @ Tue, 19 Nov 2013 21:45:02 +0100:
>
>> On 11/19/2013 11:35 AM, Will Deacon wrote:
>> > On Tue, Nov 19, 2013 at 09:40:54AM +0000, Hiroshi Doyu wrote:
>> >> Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote @ Fri, 15 Nov 2013 08:06:27 +0100:
>> >>> On Mon, 11 Nov 2013 10:47:23 +0100, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
>> >>>> 1, When a device is populated, it checks if that device is IOMMU'able
>> >>>>    or not. This is identified by "#stream-id-cells" in DT. If
>> >>>>    a device is normal(non IOMMU), a device is populated. If a device
>> >>>>    is IOMMU'able, it continues to be checked.
>> >
>> > [...]
>> >
>> >>>> I'm not so sure if this dependecy on "#stream-id-cells" is acceptable
>> >>>> or not, but I haven't any better idea right now.
>> >>>
>> >>> It seems a little fragile to me too. I'd rather the IOMMU requirement be
>> >>> described more explicitly.
>>
>> I don't see how this can work. Typically you find a property and then
>> read the relevant #*-cells to determine the size. Having multiple cell
>> properties is asking for errors.
>
> The above was mentioned for PATCHv4 series[1], which used the arm,smmu
> DT bindings,  "#stream-id-cells" in clients and "mmu-masters" in
> iommu.
>
> In PATCHv5[2], we took the following DT binding where multiple cell
> properties seem to work ok.
>
>   smmu_a: iommu@xxxxxxxx {
>         #iommu-cells = <2>;
>         ....
>   };
>
>   smmu_b: iommu@xxxxxxxx {
>         #iommu-cells = <3>;
>         ....
>   };
>
>   device_a {
>          iommus = <&smmu_a param1 param2>,
>                   <&smmu_b param1 param2 param3>;
>   };
>
> This can describe the relation between a device and an iommu
> independently. The number of params needed for each IOMMU can be
> sepcified by #iommu-cells in its iommu entry.
>
>   device_a <-> smmu_a, needs 2 params for a device
>   device_a <-> smmu_b, needs 3 params for a device
>
> For example, "smmu_a" can be an bus level global IOMMU where all child
> devices can be an master of "smmu_a", and "smmu_b" is a local IOMMU
> only for "device_a".
>
> "memory controller"---"smmu_a"---bus--+--"smmu_b"--"device_a"
>                                       |
>                                       |
>                                       +--"device_b"

I think the above binding would be the correct way to describe things
if you have 1 device connected to 2 IOMMUs (directly rather than
chained). IIUC, that is something you have on tegra?

For the topology above where you are chaining iommu's, I think
something like this is more accurately describing the hierarchy:

  smmu_b: iommu@xxxxxxxx {
        #iommu-cells = <3>;
         iommus = <&smmu_a param1 param2>;
       ....
  };
  device_a {
         iommus = <&smmu_b param1 param2 param3>;
  };

I remember discussing this with Will and seem to recall some issue
with describing things this way. But looking at it now, I don't see
what that was.

>> >> I think that Will Deacon can do better than I.
>> >
>> > I already commented briefly here:
>> >
>> >   http://www.spinics.net/lists/devicetree/msg11513.html
>> >
>> > basically deferring to DT people :)
>> >
>> > Anyway, I'm happy to tighten up the IOMMU requirement description but
>> > *not* at the expense of breaking what we currently have for the ARM SMMU,
>> > which is being used by Calxeda.
>> >
>> > Adding Andreas and Rob for input on potential binding additions to the SMMU.
>>
>> The above proposal would be an incompatible change. However, I think we
>> could still deal with a change in this binding at this stage.
>>
>> One way approach to handle this without changing the binding would be to
>> scan the DT for all iommu's up front and create a list of all nodes and
>> their iommu parent. The fact that the hierarchy is described in a way
>> that doesn't fit Linux well is really a Linux implementation detail.
>
> I may need some implementation to understand this further.
>
>> If changing the binding, a simple approach would be to allow
>> 'smmu-parent' to be a bus and/or device property and not just for
>> chained iommu's. This could be a global or bus property that is
>> inherited. Like interrupt-parent, you would have to deal with the parent
>> being itself. Also, perhaps iommu-parent would be a better name. In any
>> case, I'd like to see this all be a generic iommu binding.
>
> I guess that this would work.
>
> One concern to this may be that there might be the case where IOMMU
> hierarchy doesn't always follow the bus's one, I guess. I'm not so
> sure if it's an good example, but, platform_bus itself doesn't follow
> the actual bus hierarchy at all. But if we start to describe the bus
> hierarchy(adding a specific bus) we'll loose the benefit of
> platform_bus, where we can share almost all devices in a single
> driver.

It is not trying to follow the bus hierarchy. Inheritance is just a
convenience. Interrupts don't follow the bus hierarchy either.

Rob

>
> OTOH, do you see any limitations of point-to-point connections between
> a device and IOMMUs, described in the above "device_a" and "smmu_[a|b]"?
>
> [1] http://lists.linuxfoundation.org/pipermail/iommu/2013-November/006931.html
> [2] http://lists.linuxfoundation.org/pipermail/iommu/2013-November/007004.html
