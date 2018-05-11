From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 3/3] iommu: armsmmu: set iommu ops for rpmsg bus
Date: Fri, 11 May 2018 19:24:10 +0100
Message-ID: <61ded3c7-d367-1557-a2e8-f69fcd48964d@arm.com>
References: <20180302145531.20463-1-srinivas.kandagatla@linaro.org>
	<20180302145531.20463-4-srinivas.kandagatla@linaro.org>
	<57fc5480-c57e-dfd3-e6af-5e5bba296430@arm.com>
	<CAOCOHw4RDwmbCySN==-zT7cQ6abzLzKUhBHBSdv_EvWnU4g4Pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAOCOHw4RDwmbCySN==-zT7cQ6abzLzKUhBHBSdv_EvWnU4g4Pg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, "open list:REMOTE PROCESSOR (REMOTEPROC) SUBSYSTEM" <linux-remoteproc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, LAKML <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 07/05/18 20:28, Bjorn Andersson wrote:
> On Fri, Mar 2, 2018 at 8:59 AM, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
>> On 02/03/18 14:55, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org wrote:
>>>
>>> From: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>>
>>> On Qualcomm SoCs, ADSP exposes many functions like audio and
>>> others. These services need iommu access to allocate any
>>> memory for the DSP. As these drivers are childeren of
>>> rpmsg bus, able to allocate memory from iommus is basic
>>> requirement. So set arm smmu iommu ops for this bus type.
>>
> 
> Forgot to answer this and the dma_ops patch seems to be going in the
> right direction.
> 
>>
>> Documentation/rpmsg.txt: "Every rpmsg device is a communication channel with
>> a remote processor (thus rpmsg devices are called channels)."
>>
>> I'd instinctively assume that a remote processor already has its own memory,
>> and that a communication channel doesn't somehow go directly through an
>> IOMMU, so that "basic requirement" seems like a pretty big assumption.
>>
> 
> As of today rpmsg exclusively uses system memory for implementing the
> communication fifos, but this memory is owned/handled by the rpmsg
> bus. The need here is for drivers on top of the rpmsg_bus,
> implementing some application-level protocol that requires indirection
> buffers; e.g. to achieve zero copy of audio or image buffers that the
> remote processor is expected to operate on. In this case the device
> sitting on top of the rpmsg bus will have to map the buffer to the
> appropriate context and can then send application specific control
> requests referencing this mapping.

Right, but that's more or less what I was getting at - rpmsg can be used 
as a means to signal some DMA master device to start doing a thing, but 
that thing itself is unrelated to rpmsg, and it by no means implies that 
everything which rpmsg can talk to is always capable of system-wide DMA. 
It's no different if that communication channel is a hardware mailbox or 
an I2C/SPI/USB/etc. link, rather than virtio; we wouldn't automatically 
consider devices on the other end of those to be directly connected to 
an IOMMU either.

IOMMU and DMA operations are highly dependent on the physical hardware 
topology, which is why I really don't like trying to shoehorn them into 
software constructs without modelling the actual hardware reasonably 
accurately. For instance it's not unheard of for remote processors in a 
SoC to see a different physical memory map from the main application 
processors - how would rpmsg try to describe that? What even is the 
address space of the rpmsg "bus"?

> As different parts of the firmware might operate in different contexts
> it's not feasible to utilize the parent's (the rpmsg_bus) context for
> these indirection buffers.

Indeed, and I maintain that that wouldn't be the right thing to do 
anyway. As before, I think the most accurate way to model the situation 
with the tools we have available is to have the actual hardware function 
represented by a platform device, which is associated with a 
corresponding rpmsg endpoint. Then the driver can manage communication 
in the rpmsg context, and physical DMA setup in the 'real' hardware 
context, and everything looks sane without questionable abstraction 
breakage. Since this looked to be more or less what is actually 
implemented anyway, it doesn't seem all that hard to refine; if there 
are multiple DMA master functions identified distinctly to the IOMMU, 
then they could either be represented as separate platform devices with 
explicit IOMMU specifiers, or you could model the actual DSP subsystem 
hardware as its own bus-like arrangement with an iommu-map arrangement 
translating function identifiers to IOMMU identifiers.

What I don't like is forcing IOMMU drivers to pretend that some data in 
a shared memory buffer is itself directly capable of generating 
transactions on the interconnect. If other 'indirect' bus abstractions 
like CoreSight can get this right, I don't see why rpmsg deserves to be 
special.

>>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>> ---
>>>    drivers/iommu/arm-smmu.c | 5 +++++
>>>    1 file changed, 5 insertions(+)
>>>
>>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>>> index e6920d32ac9e..9b63489af15c 100644
>>> --- a/drivers/iommu/arm-smmu.c
>>> +++ b/drivers/iommu/arm-smmu.c
>>> @@ -53,6 +53,7 @@
>>>    #include <linux/spinlock.h>
>>>      #include <linux/amba/bus.h>
>>> +#include <linux/rpmsg.h>
>>>      #include "io-pgtable.h"
>>>    #include "arm-smmu-regs.h"
>>> @@ -2168,6 +2169,10 @@ static void arm_smmu_bus_init(void)
>>>                  bus_set_iommu(&pci_bus_type, &arm_smmu_ops);
>>>          }
>>>    #endif
>>> +#ifdef CONFIG_RPMSG
>>
>>
>> Ah, so this will at least build OK with RPMSG=m, but I doubt it does what
>> you want it to in that case.
>>
> 
> Things have been refactored but the core has remained tristate,
> causing extra head aches in various areas. I think it's very
> reasonable to review the rpmsg config options and make CONFIG_RPMSG
> bool.
> 
> So with the addition of making CONFIG_RPMSG bool the patch has my Acked-by.
> 
> That said I'm generally concerned about the first probed iommu
> implementation assigning itself as the sole iommu implementation for
> all busses, but I guess we haven't yet hit the point where there are
> different iommu implementations in a single SoC?

As it happens I do know of one such SoC already - Rockchip RK3288 seems 
to have an undocumented Arm SMMU alongside all the rockchip-iommu 
instances, but it's not used by Linux (and I have no idea what it was 
intended for; I just went and poked the intriguing "peripheral MMU" 
region of the memory map and found what looks an awful lot like an Arm 
MMU-400). More realistically, I also know of folks using the Arm Juno 
dev board with an MMU-600 in the add-on FPGA tile, which would have that 
driver-probe-order fight with the MMU-401 instances in the SoC, but I 
figure they were either using an older firmware which didn't enable the 
latter or just got lucky with not having the SMMUv2 driver enabled.

But yes, the per-bus ops thing is awful and I've been complaining about 
it for years now. Since iommu_fwspec we at least have the foundations 
for per-device ops in place now, but as is often the case, getting 80% 
of the way there is simple[1], whilst the last 20% (like replacing 
iommu_domain_alloc(), and where to call iommu_{add,remove}_device() 
from) is really hard.

Robin.

[1] 
https://www.mail-archive.com/iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org/msg14576.html
