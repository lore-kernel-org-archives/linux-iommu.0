From: Jordan Crouse <jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [Freedreno] [PATCH 0/7] RFC: iommu/arm-smmu-v2: Dynamic domains
Date: Tue, 7 Mar 2017 10:22:41 -0700
Message-ID: <20170307172241.GB20962@jcrouse-lnx.qualcomm.com>
References: <1488904795-870-1-git-send-email-jcrouse@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1488904795-870-1-git-send-email-jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Mar 07, 2017 at 09:39:48AM -0700, Jordan Crouse wrote:
> Pursuant to the arm-smmu-v3 SVM support:
> 
> https://lists.linuxfoundation.org/pipermail/iommu/2017-February/020599.html
> 
> I felt it would be helpful if I would demonstrate how Qualcomm implements
> per-process pagetables for several generations of SoCs and GPUs focusing on the
> Adreno A540 GPU and an arm-smmu-v2 IOMMU on the Snapdragon 820 SoC.
> 
> The requirement is to implement per-process GPU address spaces for security
> reasons. Though some very crude SVM support is possible we focus mainly on
> individual address spaces that are maintained and mapped by the GPU driver.
> 
> In a nutshell, the solution is to create special virtual or "dynamic" domains
> that are associated with a real domain. The dynamic domains allocate pagetables
> but do not reprogram the hardware. When a command is submitted, the kernel
> driver provides the physial address of the pagetable (TTBR0) to the GPU which
> reprograms the TTBR0 register in context bank 0 of the GPMU SMMU on the fly (and
> does the requisite flushing and stalling).
> 
> The TTBR1 address space is used to maintain a split between the process and the
> global GPU buffers (ringbuffers, etc). This greatly facilitates the switching
> process.
> 
> In more detail this is the workflow:
> 
>  - The kernel driver attaches a UNMANAGED domain to context bank 0
> 
>  - Global GPU buffers are allocated in the TTBR1 address space
>  
>  - Each new process creates a dynamic domain cloned from the "real" domain
> 
>  - New buffers for the process are mapped into the dynamic domain
> 
>  - The kernel driver gets the TTBR0/ASID register value from the dynamic domain
>    via an attribute
> 
>  - At command submission time, the kernel driver sends the TTBR0/ASID value to
>    the GPU before the command. The GPU switches the pagetable by programming
>    the SMMU hardware before executing the command.
> 
> I'll be uploading the series to implement this in the MSM DRM driver to show how
> it works from the GPU perspective. I'm adding it as a separate thread to avoid
> crossing the streams and confusing folks - I'll reply to this email with a link.

Here is a link to the GPU implementation. I'll leave the link here but if
enough folks think it is useful I can reply append the actual patches to this
thread too.

https://lists.freedesktop.org/archives/freedreno/2017-March/001049.html

Jordan
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
