From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH 0/6] Add platform device SVM support for ARM SMMUv3
Date: Tue, 5 Sep 2017 13:56:00 +0100
Message-ID: <95d1a9e2-1816-ff7d-9a8d-98406a6c2c22@arm.com>
References: <1504167642-14922-1-git-send-email-xieyisheng1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1504167642-14922-1-git-send-email-xieyisheng1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Yisheng Xie <xieyisheng1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, xieyisheng-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, chenjiankang1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 31/08/17 09:20, Yisheng Xie wrote:
> Jean-Philippe has post a patchset for Adding PCIe SVM support to ARM SMMUv3:
> https://www.spinics.net/lists/arm-kernel/msg565155.html
> 
> But for some platform devices(aka on-chip integrated devices), there is also
> SVM requirement, which works based on the SMMU stall mode.
> Jean-Philippe has prepared a prototype patchset to support it:
> git://linux-arm.org/linux-jpb.git svm/stall

Only meant for testing at that point, and unfit even for an RFC.

> We tested this patchset with some fixes on a on-chip integrated device. The
> basic function is ok, so I just send them out for review, although this
> patchset heavily depends on the former patchset (PCIe SVM support for ARM
> SMMUv3), which is still under discussion.
> 
> Patch Overview:
> *1 to 3 prepare for device tree or acpi get the device stall ability and pasid bits
> *4 is to realise the SVM function for platform device
> *5 is fix a bug when test SVM function while SMMU donnot support this feature
> *6 avoid ILLEGAL setting of STE and CD entry about stall
> 
> Acctually here, I also have a question about SVM on SMMUv3:
> 
> 1. Why the SVM feature on SMMUv3 depends on BTM feature? when bind a task to device,
>    it will register a mmu_notify. Therefore, when a page range is invalid, we can
>    send TLBI or ATC invalid without BTM?

We could, but the end goal for SVM is to perfectly mirror the CPU page
tables. So for platform SVM we would like to get rid of MMU notifiers
entirely.

> 2. According to ACPI IORT spec, named component specific data has a node flags field
>    whoes bit0 is for Stall support. However, it do not have any field for pasid bit.
>    Can we use other 5 bits[5:1] for pasid bit numbers, so we can have 32 pasid bit for
>    a single platform device which should be enough, because SMMU only support 20 bit pasid
> 
> 3. Presently, the pasid is allocate for a task but not for a context, if a task is trying
>    to bind to 2 device A and B:
>      a) A support 5 pasid bits
>      b) B support 2 pasid bits
>      c) when the task bind to device A, it allocate pasid = 16
>      d) then it must be fail when trying to bind to task B, for its highest pasid is 4.
>    So it should allocate a single pasid for a context to avoid this?

Ideally yes, but the model chosen for the IOMMU API was one PASID per
task, so I implemented this model (the PASID allocator will be common to
IOMMU core in the future).

Therefore the PASID allocation will fail in your example, and there is no
way around it. If you do (d) then (c), the task will have PASID 4.

Thanks,
Jean
