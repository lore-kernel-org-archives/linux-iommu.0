From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Subject: Re: [PATCH v2 0/4] Optimise 64-bit IOVA allocations
Date: Wed, 9 Aug 2017 12:09:00 +0800
Message-ID: <598A8ADC.5080906@huawei.com>
References: <cover.1500636791.git.robin.murphy@arm.com>
 <20170726110807.GN15833@8bytes.org> <59787A48.6060200@huawei.com>
 <CAKTKpr5j8gfurks-7U__w5GQ4A9Wk2MKyqZy6Dbve=2CfVRvzw@mail.gmail.com>
 <598A6877.4050307@huawei.com>
 <CAKTKpr7vTzfGDvPDD4HipLYkkO4mfPLcL+3PXDHjb-bQwFMHUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKTKpr7vTzfGDvPDD4HipLYkkO4mfPLcL+3PXDHjb-bQwFMHUA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ganapatrao Kulkarni <gklkml16@gmail.com>
Cc: Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, ard.biesheuvel@linaro.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, ray.jui@broadcom.com, nwatters@codeaurora.org, Jonathan.Cameron@huawei.com, dwmw2@infradead.org, linux-arm-kernel@lists.infradead.org, Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
List-Id: iommu@lists.linux-foundation.org



On 2017/8/9 11:24, Ganapatrao Kulkarni wrote:
> On Wed, Aug 9, 2017 at 7:12 AM, Leizhen (ThunderTown)
> <thunder.leizhen@huawei.com> wrote:
>>
>>
>> On 2017/8/8 20:03, Ganapatrao Kulkarni wrote:
>>> On Wed, Jul 26, 2017 at 4:47 PM, Leizhen (ThunderTown)
>>> <thunder.leizhen@huawei.com> wrote:
>>>>
>>>>
>>>> On 2017/7/26 19:08, Joerg Roedel wrote:
>>>>> Hi Robin.
>>>>>
>>>>> On Fri, Jul 21, 2017 at 12:41:57PM +0100, Robin Murphy wrote:
>>>>>> Hi all,
>>>>>>
>>>>>> In the wake of the ARM SMMU optimisation efforts, it seems that certain
>>>>>> workloads (e.g. storage I/O with large scatterlists) probably remain quite
>>>>>> heavily influenced by IOVA allocation performance. Separately, Ard also
>>>>>> reported massive performance drops for a graphical desktop on AMD Seattle
>>>>>> when enabling SMMUs via IORT, which we traced to dma_32bit_pfn in the DMA
>>>>>> ops domain getting initialised differently for ACPI vs. DT, and exposing
>>>>>> the overhead of the rbtree slow path. Whilst we could go around trying to
>>>>>> close up all the little gaps that lead to hitting the slowest case, it
>>>>>> seems a much better idea to simply make said slowest case a lot less slow.
>>>>>
>>>>> Do you have some numbers here? How big was the impact before these
>>>>> patches and how is it with the patches?
>>>> Here are some numbers:
>>>>
>>>> (before)$ iperf -s
>>>> ------------------------------------------------------------
>>>> Server listening on TCP port 5001
>>>> TCP window size: 85.3 KByte (default)
>>>> ------------------------------------------------------------
>>>> [  4] local 192.168.1.106 port 5001 connected with 192.168.1.198 port 35898
>>>> [ ID] Interval       Transfer     Bandwidth
>>>> [  4]  0.0-10.2 sec  7.88 MBytes  6.48 Mbits/sec
>>>> [  5] local 192.168.1.106 port 5001 connected with 192.168.1.198 port 35900
>>>> [  5]  0.0-10.3 sec  7.88 MBytes  6.43 Mbits/sec
>>>> [  4] local 192.168.1.106 port 5001 connected with 192.168.1.198 port 35902
>>>> [  4]  0.0-10.3 sec  7.88 MBytes  6.43 Mbits/sec
>>>>
>>>> (after)$ iperf -s
>>>> ------------------------------------------------------------
>>>> Server listening on TCP port 5001
>>>> TCP window size: 85.3 KByte (default)
>>>> ------------------------------------------------------------
>>>> [  4] local 192.168.1.106 port 5001 connected with 192.168.1.198 port 36330
>>>> [ ID] Interval       Transfer     Bandwidth
>>>> [  4]  0.0-10.0 sec  1.09 GBytes   933 Mbits/sec
>>>> [  5] local 192.168.1.106 port 5001 connected with 192.168.1.198 port 36332
>>>> [  5]  0.0-10.0 sec  1.10 GBytes   939 Mbits/sec
>>>> [  4] local 192.168.1.106 port 5001 connected with 192.168.1.198 port 36334
>>>> [  4]  0.0-10.0 sec  1.10 GBytes   938 Mbits/sec
>>>>
>>>
>>> Is this testing done on Host or on Guest/VM?
>> Host
> 
> As per your log, iperf throughput is improved to 938 Mbits/sec
> from  6.43 Mbits/sec.
> IMO, this seems to be unrealistic, some thing wrong with the testing?
For 64bits non-pci devices, the iova allocation is always searched from the last rb-tree node.
When many iovas allocated and keep a long time, the search process should check many rb nodes
then find a suitable free space. As my tracking, the average times exceeds 10K.
        [free-space][free][used][...][used]
                      ^     ^          ^
                      |     |          |-----rb_last
                      |     |--------- maybe more than 10K allocated iova nodes
                      |------- for 32bits devices, cached32_node remember the lastest freed node, which can help us reduce check times

This patch series add a new member "cached_node" to service for 64bits devices, like cached32_node service for 32bits devices.

> 
>>
>>>
>>>>>
>>>>>
>>>>>       Joerg
>>>>>
>>>>>
>>>>> .
>>>>>
>>>>
>>>> --
>>>> Thanks!
>>>> BestRegards
>>>>
>>>>
>>>> _______________________________________________
>>>> linux-arm-kernel mailing list
>>>> linux-arm-kernel@lists.infradead.org
>>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>
>>> thanks
>>> Ganapat
>>>
>>> .
>>>
>>
>> --
>> Thanks!
>> BestRegards
>>
> 
> thanks
> Ganapat
> 
> .
> 

-- 
Thanks!
BestRegards
