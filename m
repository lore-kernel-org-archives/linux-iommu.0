From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: Report from 2013 ARM kernel summit
Date: Wed, 20 Nov 2013 13:22:39 -0700
Message-ID: <528D1A0F.2000508@wwwdotorg.org>
References: <20131119.114054.663999769447782808.hdoyu@nvidia.com>	<20131119173524.GK11778@mudshark.cambridge.arm.com>	<528BCDCE.6070006@gmail.com>	<20131120.083955.1386179068365424976.hdoyu@nvidia.com> <CAL_Jsq+AxEWhkOhxwAZ=+rpzDZ+yC1b3ZV541UhOu9kiwUhUdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAL_Jsq+AxEWhkOhxwAZ=+rpzDZ+yC1b3ZV541UhOu9kiwUhUdQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Mark.Rutland-5wv7dgnIgG8@public.gmane.org" <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Lorenzo.Pieralisi-5wv7dgnIgG8@public.gmane.org" <Lorenzo.Pieralisi-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "ksummit-2013-discuss-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org" <ksummit-2013-discuss-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org>, "olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org" <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, "lwn-T1hC0tSOHrs@public.gmane.org" <lwn-T1hC0tSOHrs@public.gmane.org>, "paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org" <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, "khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 11/20/2013 01:02 PM, Rob Herring wrote:
> On Wed, Nov 20, 2013 at 12:39 AM, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
>> Hi Rob,
>>
>> Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote @ Tue, 19 Nov 2013 21:45:02 +0100:
>>
>>> On 11/19/2013 11:35 AM, Will Deacon wrote:
>>>> On Tue, Nov 19, 2013 at 09:40:54AM +0000, Hiroshi Doyu wrote:
>>>>> Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote @ Fri, 15 Nov 2013 08:06:27 +0100:
>>>>>> On Mon, 11 Nov 2013 10:47:23 +0100, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
>>>>>>> 1, When a device is populated, it checks if that device is IOMMU'able
>>>>>>>    or not. This is identified by "#stream-id-cells" in DT. If
>>>>>>>    a device is normal(non IOMMU), a device is populated. If a device
>>>>>>>    is IOMMU'able, it continues to be checked.
>>>>
>>>> [...]
>>>>
>>>>>>> I'm not so sure if this dependecy on "#stream-id-cells" is acceptable
>>>>>>> or not, but I haven't any better idea right now.
>>>>>>
>>>>>> It seems a little fragile to me too. I'd rather the IOMMU requirement be
>>>>>> described more explicitly.
>>>
>>> I don't see how this can work. Typically you find a property and then
>>> read the relevant #*-cells to determine the size. Having multiple cell
>>> properties is asking for errors.
>>
>> The above was mentioned for PATCHv4 series[1], which used the arm,smmu
>> DT bindings,  "#stream-id-cells" in clients and "mmu-masters" in
>> iommu.
>>
>> In PATCHv5[2], we took the following DT binding where multiple cell
>> properties seem to work ok.
>>
>>   smmu_a: iommu@xxxxxxxx {
>>         #iommu-cells = <2>;
>>         ....
>>   };
>>
>>   smmu_b: iommu@xxxxxxxx {
>>         #iommu-cells = <3>;
>>         ....
>>   };
>>
>>   device_a {
>>          iommus = <&smmu_a param1 param2>,
>>                   <&smmu_b param1 param2 param3>;
>>   };
>>
>> This can describe the relation between a device and an iommu
>> independently. The number of params needed for each IOMMU can be
>> sepcified by #iommu-cells in its iommu entry.
>>
>>   device_a <-> smmu_a, needs 2 params for a device
>>   device_a <-> smmu_b, needs 3 params for a device
>>
>> For example, "smmu_a" can be an bus level global IOMMU where all child
>> devices can be an master of "smmu_a", and "smmu_b" is a local IOMMU
>> only for "device_a".
>>
>> "memory controller"---"smmu_a"---bus--+--"smmu_b"--"device_a"
>>                                       |
>>                                       |
>>                                       +--"device_b"
> 
> I think the above binding would be the correct way to describe things
> if you have 1 device connected to 2 IOMMUs (directly rather than
> chained). IIUC, that is something you have on tegra?

I'm not sure that we do, but perhaps; Hiroshi will have to answer.
Certainly whenever I personally mentioned chained IOMMUs it was simply
in the context of making sure the bindings allowed for any potential
arbitrary HW configuration, not because I had specific knowledge of one
that actually exists.

> For the topology above where you are chaining iommu's, I think
> something like this is more accurately describing the hierarchy:
> 
>   smmu_b: iommu@xxxxxxxx {
>         #iommu-cells = <3>;
>          iommus = <&smmu_a param1 param2>;
>        ....
>   };
>   device_a {
>          iommus = <&smmu_b param1 param2 param3>;
>   };
> 
> I remember discussing this with Will and seem to recall some issue
> with describing things this way. But looking at it now, I don't see
> what that was.

That's the DT content I would expect for that scenario.

The syntax:

>>          iommus = <&smmu_a param1 param2>,
>>                   <&smmu_b param1 param2 param3>;

... I would expect to be useful if a single device was a bus-master on
multiple buses, and each bus had a path to memory via a different IOMMU.
One example might be a DMA controller that bridges two buses. We
certainly have such a DMA controller on Tegra, although IIRC, the
upstream path to memory would pass through the same IOMMU from both
buses on current HW that I'm familiar with.
