From: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC] iommu: arm-smmu: stall support
Date: Mon, 18 Sep 2017 08:11:47 -0400
Message-ID: <CAF6AEGv0WZe-bYXUVYt4WxMX3RFnZxr5038pDg3VOiP8Edx+4Q@mail.gmail.com>
References: <20170914194444.32551-1-robdclark@gmail.com>
	<9c2c136a-8c0f-6196-a135-0135b41c9b6e@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <9c2c136a-8c0f-6196-a135-0135b41c9b6e-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Cc: "linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Sep 18, 2017 at 7:13 AM, Jean-Philippe Brucker
<jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org> wrote:
> Hi Rob,
>
> On 14/09/17 20:44, Rob Clark wrote:
>> Adds a new domain property for iommu clients to opt-in to stalling
>> with asynchronous resume, and for the client to determine if the
>> iommu supports this.
>>
>> Current motivation is that:
>>
>> a) On 8x96/a530, if we don't enable CFCFG (or HUPCF) then non-
>>    faulting translations which are happening concurrently with
>>    one that faults, fail (or return garbage), which triggers all
>>    sorts of fun GPU crashes, which generally have no relation
>>    to the root fault.  (The CP can be far ahead in the cmdstream
>>    from the other parts of the GPU...)
>
> Would the GPU driver always enable stall for this implementation? Or only
> enable it for specific domains?

I expect for all domains.  (Currently that is just a single domain,
but I expect that to change)

> Instead of enabling it at domain level, I wonder if couldn't be left
> entirely to the SMMU driver. I have a proposal (that I'll publish shortly)
> for adding a "can-stall" attribute to device-tree nodes, telling the SMMU
> driver that the device can withstand stalled transactions without locking
> up the system.
>
> The SMMU would then enable stall for this particular device without
> needing approval from the device driver. I'm doing this for v3, which has
> a more mature stall model, but I suppose we can do the same for v2 as well.

The GPU driver does need to know if stalling is supported/enabled by
the iommu driver (since depending on SoC, drm/msm works with one of
three different iommu drivers currently), and to be in control of
resume.. I'm a bit sceptical about trying to abstract too much at the
iommu level.

For example when the gpu gets a fault, it tends to get 1000s of
faults.  On the first fault, I want to kick things off to a wq where I
can snapshot the cmdstream and gpu state.  But subsequent faults on
the same submit I ignore.

Btw, apologies that I haven't sent the corresponding drm/msm patches
yet.  I haven't had a chance to clean up yet, but you can find
something rough here:

  https://github.com/freedreno/kernel-msm/commits/integration-linux-qcomlt-v4.13-rc3

> In any case, the firmware has to tell the OS that a device is capable of
> stalling, because it is unlikely that many platform devices will
> gracefully handle this mode.
>
>> b) I am working on a debugfs feature to dump submits/batches
>>    that cause GPU hangs, and I would like to also use this for
>>    faults.  But it needs to run in non-atomic context, so I
>>    need to toss things off to a workqueue, and then resume
>>    the iommu after it finishes.
>
> Are you relying on stalled transaction to freeze the GPU state and
> allow for introspection? I suppose the debug code would always terminate
> after recording the fault? I'm just trying to get a picture of all
> possible users of a common fault API.

yes, this is what I'm doing now.  For SVM, however, we'd retry the
transaction instead of terminating.

>> c) (and ofc at some point in the future for SVM we'd like to
>>    be able to pin unpinned pages and things like that, in
>>    response to faults.)
>
> For SVM there will be generic code calling into the mm code to pin pages
> and resume the SMMU. We are working on consolidating this with other
> IOMMUs at the moment and use generic code where possible. Ideally the GPU
> driver shouldn't need to get involved.
>
> That new API will be based on PASIDs/SSIDs, which doesn't exist in SMMUv2.
> I do believe that we also need to consolidate the API for devices and
> IOMMUs that support page faults but not PASIDs. We could use a common
> fault workqueue in the IOMMU core.

I've no idea qcom's plans for future hw, but pretty sure we are going
to want to implement SVM on v2 iommu, without PASIDs/SSIDs.  However
on current hw, there is really only one userspace process active on
the gpu at a time, so we don't really need PASIDs/SSIDs.

> It seems like your use-case (b) could fit in there. If the device driver
> didn't bind to a process but instead registered a fault handler, then we
> could ask it to do something with the fault. And since it's in a wq, the
> call to device driver would be synchronous and we'd pass the return status
> (retry/terminate) to the SMMU.
>
> This is probably easier to handle than a separate "resume" callback,
> especially with SMMUv3 stall and PRI, where faults are out of order and
> contain a token identifying a fault.

IIRC Will or Robin mentioned wanting a token in earlier stall
discussion.. although not being familiar with v3 I wasn't quite sure
what the use was.

At any rate, adding a token to fault handler callback and
iommu_domain_resume() seems like something that could be added later,
when it is needed.

Anyways, I am interested to see what your proposal is.. although tend
to be a bit sceptical about trying to abstract too much.  (And if
there should be something more abstract, maybe it should be at the
dma-mapping layer instead?)

I don't suppose you or someone working on this from ARM side will be
at linaro connect in a couple weeks?  Jordan and myself will be there,
and it could be a good time to chat about this, and also per-process
pagetables and gpu switching switching pagetables directly on v2 hw.

BR,
-R

>> TODO
>>  - For RFC I thought it would be easier to review the idea
>>    as a single patch, but it should be split into separate
>>    core and arm-smmu parts
>>
>>  - I vaguely remember someone (Will?) mentioning that there
>>    could be cases with multiple masters sharing a single
>>    context bank, and somehow stalling might not work in that
>>    case?  (How does that even happen, arm-smmu assignes the
>>    context banks?  Maybe I'm mis-remembering the details.)
>>    I think that this probably shouldn't effect the API parts
>>    of this RFC, the iommu driver should already know about
>>    all the devices that might attach because of ->attach_dev()
>>    so it could fail in _set_attr()?
>
> With VFIO, userspace can decide to put multiple device in the same domain.
> But attach_dev can fail if there are device incompatibilities, and then
> VFIO will use a new domain. It might become relevant with vSVM, forwarding
> recoverable faults from guest-assigned devices.
>
> Thanks,
> Jean
