From: Rob Clark <robdclark@gmail.com>
Subject: Re: [RFC] iommu: arm-smmu: stall support
Date: Wed, 27 Sep 2017 12:14:08 -0400
Message-ID: <CAF6AEGvdsqhxGrLEDJ-fT72Rd1ANDYwdU08bYt26Gyr_BO=kuQ@mail.gmail.com>
References: <20170914194444.32551-1-robdclark@gmail.com> <20170919123038.GF8398@8bytes.org>
 <CAF6AEGuutkqjrWk4jagE=p-NwHgxdiPZjjsaFsfwtczK568j+A@mail.gmail.com>
 <20170922090204.GJ8398@8bytes.org> <32e3ab2c-a996-c805-2a0d-a2e85deb3a50@arm.com>
 <CAF6AEGuh0FiNWEAmFm+7-7pc6MV5hKKz9cyA_J0d256bY-nYOQ@mail.gmail.com>
 <20170927121540.GL8398@8bytes.org> <4e2fc08e-3e7e-3355-17e5-72106196c732@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4e2fc08e-3e7e-3355-17e5-72106196c732@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Will Deacon <Will.Deacon@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Sep 27, 2017 at 9:49 AM, Jean-Philippe Brucker
<jean-philippe.brucker@arm.com> wrote:
> Hi Joerg,
>
> On 27/09/17 13:15, Joerg Roedel wrote:
>> Hi Rob, Jean,
>>
>> On Fri, Sep 22, 2017 at 02:42:44PM -0400, Rob Clark wrote:
>>> I'm in favour if splitting the reporting *somehow*.. the two
>>> approaches that seemed sane are:
>>>
>>> 1) call fault handler from irq and having separate domain->resume()
>>> called by the driver, potentially from a wq
>>> 2) or having two fault callbacks, first called before wq and then
>>> based on returned value, optionally 2nd callback called from wq
>>>
>>> The first seemed less intrusive to me, but I'm flexible.
>>
>> How about adding a flag to the fault-handler call-back that tells us
>> whether it wants to sleep or not. If it wants, we call it from a wq, if
>> not we call call it directly like we do today in the
>> report_iommu_fault() function.
>>
>> In any case we call iommu_ops->resume() when set on completion of the
>> fault-handler either from the workqueue or report_iommu_fault itself.
>
> I like this approach. When the device driver registers a fault handler,
> it also tells when it would like to be called (either in atomic context,
> blocking context, or both).

What I have in mind is still a case-by-case decision.  Ie. I'd decide
if it is the first fault from a particular submit (job), in which case
I'd want to schedule the wq, or if it is one of the 999 following
faults from the same submit (in which case, skip the wq).

So a static decision when registering the fault handler doesn't work.

BR,
-R


> Then the handler itself receives a flag that says which context it's
> being called from. It returns a value telling the IOMMU how to proceed.
> Depending on this value we either resume/abort immediately, or add the
> fault to the workqueue if necessary.
>
> How about using the following return values:
>
> /**
>  * enum iommu_fault_status - Return status of fault handlers, telling the IOMMU
>  *      driver how to proceed with the fault.
>  *
>  * @IOMMU_FAULT_STATUS_NONE: Fault was not handled. Call the next handler, or
>  *      terminate.
>  * @IOMMU_FAULT_STATUS_FAILURE: General error. Drop all subsequent faults from
>  *      this device if possible. This is "Response Failure" in PCI PRI.
>  * @IOMMU_FAULT_STATUS_INVALID: Could not handle this fault, don't retry the
>  *      access. This is "Invalid Request" in PCI PRI.
>  * @IOMMU_FAULT_STATUS_HANDLED: Fault has been handled and the page tables
>  *      populated, retry the access.
>  * @IOMMU_FAULT_STATUS_IGNORE: Stop processing the fault, and do not send a
>  *      reply to the device.
>  *
>  * For unrecoverable faults, the only valid status is IOMMU_FAULT_STATUS_NONE
>  * For a recoverable fault, if no one handled the fault, treat as
>  * IOMMU_FAULT_STATUS_INVALID.
>  */
> enum iommu_fault_status {
>         IOMMU_FAULT_STATUS_NONE = 0,
>         IOMMU_FAULT_STATUS_FAILURE,
>         IOMMU_FAULT_STATUS_INVALID,
>         IOMMU_FAULT_STATUS_HANDLED,
>         IOMMU_FAULT_STATUS_IGNORE,
> };
>
> This would probably cover the two use-cases of reporting faults to
> device drivers, and injecting them into the guest with VFIO, as well as
> handling PPRs internally. I'm also working on providing more details
> (pasid for instance) in the fault callback.
>
> We could also use the fault handler for invalid PRI Page Requests
> (currently specialized by amd_iommu_set_invalid_ppr_cb). It's just a
> matter of adding a registration flag to iommu_set_fault_handler.
>
> Thanks,
> Jean
