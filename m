From: Sricharan R <sricharan@codeaurora.org>
Subject: Re: [PATCH V3 0/5] iommu/arm-smmu: Add runtime pm/sleep support
Date: Tue, 4 Apr 2017 10:45:59 +0530
Message-ID: <8b5298ed-72cf-f62a-03e4-7f27d7d91a20@codeaurora.org>
References: <1489073748-3659-1-git-send-email-sricharan@codeaurora.org>
 <20170331175457.GD4897@arm.com>
 <CAF6AEGv_1pNvhCc-mVP5S28Yt5kTJmTRfe8tKSJpEmxfOKM7Jg@mail.gmail.com>
 <20170403172307.GI5706@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20170403172307.GI5706@arm.com>
Sender: linux-clk-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>, Rob Clark <robdclark@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

Hi Will,

On 4/3/2017 10:53 PM, Will Deacon wrote:
> On Fri, Mar 31, 2017 at 10:58:16PM -0400, Rob Clark wrote:
>> On Fri, Mar 31, 2017 at 1:54 PM, Will Deacon <will.deacon@arm.com> wrote:
>>> On Thu, Mar 09, 2017 at 09:05:43PM +0530, Sricharan R wrote:
>>>> This series provides the support for turning on the arm-smmu's
>>>> clocks/power domains using runtime pm. This is done using the
>>>> recently introduced device links patches, which lets the symmu's
>>>> runtime to follow the master's runtime pm, so the smmu remains
>>>> powered only when the masters use it.
>>>
>>> Do you have any numbers for the power savings you achieve with this?
>>> How often do we actually manage to stop the SMMU clocks on an SoC with
>>> a handful of masters?
>>>
>>> In other words, is this too coarse-grained to be useful, or is it common
>>> that all the devices upstream of the SMMU are suspended?
>>
>> well, if you think about a phone/tablet with a command mode panel,
>> pretty much all devices will be suspended most of the time ;-)
>
> Well, that's really what I was asking about. I assumed that periodic
> modem/radio transactions would keep the SMMU clocked, so would like to get a
> rough idea of the power savings achieved with this coarse-grained approach.
>

One main reason for introducing this was to enable power for
the iommus separately in those places where the iommu gets
accessed without the context of the master, pm runtime was
done to use the device links feature and also those iommus
had their power-domains to be enabled (during the iommu probe,
faults) (downstream was modelling those power-domains as
'regulators' which was not correct) and have to be clocked
as well.

I was in the process of trying to measure the power difference
that this would achieve. One concern here is, this series depends
on the device link between master and iommu.
So essentially the masters have to be pm runtime adapted fully
to use this. For my testing i was using couple of them (mdp, gpu),
by just enabling pm runtime for them, not full pm runtime though.
But i will come-up with the numbers by instrumenting little more.
The downstream code explicitly turns on the iommu clocks/regulators
in the standalone path (called without master context and after
that, lets the master to control the iommu clocks ( the iommu
clocks are populated in master DT data as well), so ensures iommu
is clocked only when really needed by the master. So number
measured from downstream should also give the power numbers in
another way.

Regards,
  Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member of Code Aurora Forum, hosted by The Linux Foundation
