From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH V3 6/8] arm: dma-mapping: Reset the device's dma_ops
Date: Fri, 26 May 2017 10:48:53 +0530
Message-ID: <5fae044c-fe7a-4252-622d-577b57f4b169@codeaurora.org>
References: <1475600632-21289-1-git-send-email-sricharan@codeaurora.org>
	<20170523224216.GI22219@n2100.armlinux.org.uk>
	<c4ad7341-fa9f-81b7-a41c-417144c4f842@codeaurora.org>
	<7413479.FJ3cKQnUFA@avalon>
	<20170525150540.GJ22219@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170525150540.GJ22219-l+eeeJia6m9URfEZ8mYm6t73F7V6hmMc@public.gmane.org>
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
To: Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Russell,

On 5/25/2017 8:35 PM, Russell King - ARM Linux wrote:
> On Wed, May 24, 2017 at 02:26:13PM +0300, Laurent Pinchart wrote:
>> Again, the patch I propose is the simplest v4.12-rc fix I can think of, short 
>> of reverting your complete IOMMU probe deferral patch series. Let's focus on 
>> the v4.12-rc fix, and then discuss how to move forward in v4.13 and beyond.
> 
> Except, I don't think it fixes the problem that Sricharan is trying to
> fix, namely that of DMA ops that have been setup, torn down, and are
> trying to be re-setup again.  The issue here is that results in a stale
> setup, because the dma_ops are left in-place from the first iommu setup,
> but the iommu mapping has been disposed of.
> 
> Your patch only avoids the problem of tearing down someone else's DMA
> ops.  We need a combination of both patches together.
> 
> What needs to happen for Sricharan's problem to be resolved is:
> 
> 1. move all of __arm_iommu_detach_device() into arm_iommu_detach_device().
> 2. replace the __arm_iommu_detach_device() call in arm_teardown_iommu_dma_ops()
>    with arm_iommu_detach_device().
> 
> as I don't see any need to have a different order in
> arm_teardown_iommu_dma_ops().
> 

Right, both patches are required and i was also thining the same thing about
using arm_iommu_detach_device from arm_teardown_iommu_dma_ops instead. Will
repost with this.

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
