From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [RFC] iommu: arm-smmu: stall support
Date: Mon, 18 Sep 2017 12:13:23 +0100
Message-ID: <9c2c136a-8c0f-6196-a135-0135b41c9b6e@arm.com>
References: <20170914194444.32551-1-robdclark@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20170914194444.32551-1-robdclark@gmail.com>
Content-Language: en-US
Sender: linux-arm-msm-owner@vger.kernel.org
To: Rob Clark <robdclark@gmail.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Cc: "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Will Deacon <Will.Deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

Hi Rob,

On 14/09/17 20:44, Rob Clark wrote:
> Adds a new domain property for iommu clients to opt-in to stalling
> with asynchronous resume, and for the client to determine if the
> iommu supports this.
> 
> Current motivation is that:
> 
> a) On 8x96/a530, if we don't enable CFCFG (or HUPCF) then non-
>    faulting translations which are happening concurrently with
>    one that faults, fail (or return garbage), which triggers all
>    sorts of fun GPU crashes, which generally have no relation
>    to the root fault.  (The CP can be far ahead in the cmdstream
>    from the other parts of the GPU...)

Would the GPU driver always enable stall for this implementation? Or only
enable it for specific domains?

Instead of enabling it at domain level, I wonder if couldn't be left
entirely to the SMMU driver. I have a proposal (that I'll publish shortly)
for adding a "can-stall" attribute to device-tree nodes, telling the SMMU
driver that the device can withstand stalled transactions without locking
up the system.

The SMMU would then enable stall for this particular device without
needing approval from the device driver. I'm doing this for v3, which has
a more mature stall model, but I suppose we can do the same for v2 as well.

In any case, the firmware has to tell the OS that a device is capable of
stalling, because it is unlikely that many platform devices will
gracefully handle this mode.

> b) I am working on a debugfs feature to dump submits/batches
>    that cause GPU hangs, and I would like to also use this for
>    faults.  But it needs to run in non-atomic context, so I
>    need to toss things off to a workqueue, and then resume
>    the iommu after it finishes.

Are you relying on stalled transaction to freeze the GPU state and
allow for introspection? I suppose the debug code would always terminate
after recording the fault? I'm just trying to get a picture of all
possible users of a common fault API.

> c) (and ofc at some point in the future for SVM we'd like to
>    be able to pin unpinned pages and things like that, in
>    response to faults.)

For SVM there will be generic code calling into the mm code to pin pages
and resume the SMMU. We are working on consolidating this with other
IOMMUs at the moment and use generic code where possible. Ideally the GPU
driver shouldn't need to get involved.

That new API will be based on PASIDs/SSIDs, which doesn't exist in SMMUv2.
I do believe that we also need to consolidate the API for devices and
IOMMUs that support page faults but not PASIDs. We could use a common
fault workqueue in the IOMMU core.

It seems like your use-case (b) could fit in there. If the device driver
didn't bind to a process but instead registered a fault handler, then we
could ask it to do something with the fault. And since it's in a wq, the
call to device driver would be synchronous and we'd pass the return status
(retry/terminate) to the SMMU.

This is probably easier to handle than a separate "resume" callback,
especially with SMMUv3 stall and PRI, where faults are out of order and
contain a token identifying a fault.

> TODO
>  - For RFC I thought it would be easier to review the idea
>    as a single patch, but it should be split into separate
>    core and arm-smmu parts
> 
>  - I vaguely remember someone (Will?) mentioning that there
>    could be cases with multiple masters sharing a single
>    context bank, and somehow stalling might not work in that
>    case?  (How does that even happen, arm-smmu assignes the
>    context banks?  Maybe I'm mis-remembering the details.)
>    I think that this probably shouldn't effect the API parts
>    of this RFC, the iommu driver should already know about
>    all the devices that might attach because of ->attach_dev()
>    so it could fail in _set_attr()?

With VFIO, userspace can decide to put multiple device in the same domain.
But attach_dev can fail if there are device incompatibilities, and then
VFIO will use a new domain. It might become relevant with vSVM, forwarding
recoverable faults from guest-assigned devices.

Thanks,
Jean
