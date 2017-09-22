From: Rob Clark <robdclark@gmail.com>
Subject: Re: [RFC] iommu: arm-smmu: stall support
Date: Fri, 22 Sep 2017 14:42:44 -0400
Message-ID: <CAF6AEGuh0FiNWEAmFm+7-7pc6MV5hKKz9cyA_J0d256bY-nYOQ@mail.gmail.com>
References: <20170914194444.32551-1-robdclark@gmail.com> <20170919123038.GF8398@8bytes.org>
 <CAF6AEGuutkqjrWk4jagE=p-NwHgxdiPZjjsaFsfwtczK568j+A@mail.gmail.com>
 <20170922090204.GJ8398@8bytes.org> <32e3ab2c-a996-c805-2a0d-a2e85deb3a50@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <32e3ab2c-a996-c805-2a0d-a2e85deb3a50@arm.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Will Deacon <Will.Deacon@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Sep 22, 2017 at 6:02 AM, Jean-Philippe Brucker
<jean-philippe.brucker@arm.com> wrote:
> On 22/09/17 10:02, Joerg Roedel wrote:
>> On Tue, Sep 19, 2017 at 10:23:43AM -0400, Rob Clark wrote:
>>> I would like to decide in the IRQ whether or not to queue work or not,
>>> because when we get a gpu fault, we tend to get 1000's of gpu faults
>>> all at once (and I really only need to handle the first one).  I
>>> suppose that could also be achieved by having a special return value
>>> from the fault handler to say "call me again from a wq"..
>>>
>>> Note that in the drm driver I already have a suitable wq to queue the
>>> work, so it really doesn't buy me anything to have the iommu driver
>>> toss things off to a wq for me.  Might be a different situation for
>>> other drivers (but I guess mostly other drivers are using iommu API
>>> indirectly via dma-mapping?)
>>
>> Okay, so since you are the only user for now, we don't need a
>> work-queue. But I still want the ->resume call-back to be hidden in the
>> iommu code and not be exposed to users.
>>
>> We already have per-domain fault-handlers, so the best solution for now
>> is to call ->resume from report_iommu_fault() when the fault-handler
>> returns a special value.
>
> The problem is that report_iommu_fault is called from IRQ context by the
> SMMU driver, so the device driver callback cannot sleep.
>
> So if the device driver needs to be able to sleep between fault report and
> resume, as I understand Rob needs for writing debugfs, we can either:
>
> * call report_iommu_fault from higher up, in a thread or workqueue.
> * split the fault reporting as this patch proposes. The exact same
>   mechanism is needed for the vSVM work by Intel: in order to inject fault
>   into the guest, they would like to have an atomic notifier registered by
>   VFIO for passing down the Page Request, and a new function in the IOMMU
>   API to resume/complete the fault.
>

I'm in favour if splitting the reporting *somehow*.. the two
approaches that seemed sane are:

1) call fault handler from irq and having separate domain->resume()
called by the driver, potentially from a wq
2) or having two fault callbacks, first called before wq and then
based on returned value, optionally 2nd callback called from wq

The first seemed less intrusive to me, but I'm flexible.

BR,
-R
