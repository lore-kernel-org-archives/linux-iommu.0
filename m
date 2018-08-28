From: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v3 06/19] dt-bindings: memory: tegra: Squash tegra20-gart
 into tegra20-mc
Date: Tue, 28 Aug 2018 16:09:05 +0300
Message-ID: <80ab7d8c-8172-2521-2eda-a235bfcc2824@gmail.com>
References: <20180818155430.5586-1-digetx@gmail.com>
 <20180818155430.5586-7-digetx@gmail.com> <20180820191209.GA28618@bogus>
 <b46cac22-9b31-9aa7-7eca-4725156346bb@gmail.com>
 <4538309b-fcb3-73ee-04e3-6cefcedd376d@gmail.com> <20180828104755.GC9386@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180828104755.GC9386@ulmo>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, Jonathan Hunter <jonathanh@nvidia.com>, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 28.08.2018 13:47, Thierry Reding wrote:
> On Mon, Aug 20, 2018 at 10:35:54PM +0300, Dmitry Osipenko wrote:
>> On 20.08.2018 22:27, Dmitry Osipenko wrote:
>>> On 20.08.2018 22:12, Rob Herring wrote:
>>>> On Sat, Aug 18, 2018 at 06:54:17PM +0300, Dmitry Osipenko wrote:
>>>>> Splitting GART and Memory Controller wasn't a good decision that was made
>>>>> back in the day. Given that the GART driver hasn't ever been used by
>>>>> anything in the kernel, we decided that it will be better to correct the
>>>>> mistakes of the past and merge two bindings into a single one. In a result
>>>>
>>>> As a result...
>>>>
>>>>> there is a DT ABI change for the Memory Controller that allows not to
>>>>> break newer kernels using older DT by introducing a new required property,
>>>>> the memory clock. Adding the new clock property also puts the tegra20-mc
>>>>> binding in line with the bindings of the later Tegra generations.
>>>>
>>>> I don't understand this part. It looks to me like you are breaking 
>>>> compatibility. The driver failing to probe with an old DT is okay?
>>>
>>> Yes, DT compatibility is broken. New driver won't probe/load with the old DT,
>>> that's what we want.
>>>
>>>> OS's like OpenSUSE use new DTs with older kernel versions, so you should 
>>>> consider how to not break them as well. I guess if all this is optional 
>>>> or has been unused, then there shouldn't be a problem.
>>>
>>> That's interesting.. Memory Controller isn't optional, I guess we could change
>>> compatible to "nvidia,tegra20-mc-gart".bled in kernels config by
>> default and driver is functional, but it's okay 
>>
>> * I meant it's not optional in a sense that it's enaif MC driver will stop to probe
>> with older kernels as it is used only for reporting memory errors.
> 
> Yeah, we don't really regress at runtime. The errors reported by the
> current driver are very rare, and even if you encounter them, they're
> pretty cryptic, so I think this is one of the exceptional cases where
> breaking the ABI "for the greater good" is acceptable.

It's now became apparent that factoring out EMC from MC isn't a good idea too
because MC need to interact with EMC and probably vice versa. Looks like we
should consider restructuring MC for all Tegra's.
