From: Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH] documentation: iommu: add description of ARM System MMU
	binding
Date: Sat, 13 Apr 2013 14:02:09 -0700
Message-ID: <5169C7D1.8070300@codeaurora.org>
References: <1365094259-24847-1-git-send-email-will.deacon@arm.com>
	<515F37C1.4000109@codeaurora.org>
	<20130408092535.GA17476@mudshark.cambridge.arm.com>
	<5162F87A.7070409@codeaurora.org>
	<20130410173732.GQ26992@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20130410173732.GQ26992-MRww78TxoiP5vMa5CHWGZ34zcgK1vI+I0E9HWUfgJXw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi again Will,

On 4/10/2013 10:37 AM, Will Deacon wrote:
> On Mon, Apr 08, 2013 at 06:03:54PM +0100, Olav Haugan wrote:
> 
>>> Generally, the StreamIDs are fixed in hardware (as a function of
>>> various AXI bits -- see the SMMU integration guide) and cannot be
>>> set by software. Furthermore, when the StreamIDs have an implicit
>>> effect on IOMMU domain configuration, since stream-matching may
>>> not be always be able to identify a master uniquely.
>> 
>> Let me clarify what I mean by "our SMMU driver programs the SMMU
>> SIDs". What I meant to say is that our SMMU driver programs the SID
>> into the Stream Match Register (SMR) to route the transactions to
>> the correct context bank based on the SID.
> 
> Ok, but then how does that interact with the IOMMU API in Linux? e.g.
> if a client asks for an iova <-> pa mapping on a device, then you
> need to lookup the StreamIDs for that device, no?

Can you explain this use case a bit more. I am not clear what you mean
by a "client"? Are you referring to a client in Linux or are you
referring to the client being the core behind an IOMMU (such as a DMA
engine or a video core)?

I am not sure how StreamIDs relates to the IOMMU API in Linux :-)
I think it helps if I explain my use case to you so you understand how
we use the IOMMU and maybe you can explain your use case and how your
driver works so that we can get on the same page. BTW, our ARMv1 IOMMU
driver can be found @ [1]

Our use case:

1) During boot IOMMU HW is probed, devices for each IOMMU and for each
context bank are created.
2) Video session starts.
3) Linux Video Driver (LVD) creates one or more domain
(iommu_domain_alloc) and calls iommu_attach_device() for each context
bank it is going to use.
4) LVD then calls map as needed for the buffers that the video core
needs to access.
5) LVD shares IOVA with video core and kicks off video core decoding.
6) Video session ends.
7) LVD unmaps
8) LVD detaches.

The video driver selects context bank to attach to based on the use case
and does not know about StreamIDs really.

BTW, when you call iommu_attach_device() what "device" do you pass as
argument? Do you pass the IOMMU as a device? How do you specify which
Context Bank to attach to?

>>> StreamIDs aren't statically associated with a translation
>>> context. Why do you put them here? Also, how do this interact
>>> with stream matching?
>> 
>> We put the StreamIDs in the context bank to tell our driver that
>> these StreamIDs should be programmed into the Stream Match Register
>> (SMR) to route the transactions bearing these StreamIDs to this
>> context bank. We don't really change the SID2CB mapping during
>> run-time. It is set during compile time.
> 
> Again, I'm struggling to see how this interfaces to the more
> general-purpose IOMMU API.

What general-purpose IOMMU API deals with StreamIDs?

>>>> Optional sub-node properties: - qcom,secure-context : boolean
>>>> indicating that a context is secure and programmed by the
>>>> secure environment.
>>> 
>>> Why does Linux care about this?
>> 
>> Linux cares about this because if we are doing content protection
>> using one of the context banks then the context bank is programmed
>> by the secure environment and not accessible/programmable by the
>> HLOS.
> 
> Why can't the secure world just hide those context banks by using 
> SMMU_SCR1.NSNUMCBO?

Yes, that is a possibility for context banks. If you have 1 or more
"secure" context banks it also means that Linux does not have access
(read: can't have) to the global register space and this must be
communicated somehow (hence the "secure-id" IOMMU node property. The
secure-context property might be redundant. However, there might be use
cases were Linux would want to know about the secure context bank. One
such use case could be to register for page fault from the secure
context bank so that Linux can log a useful page fault message to the
kernel log.

[1]
https://www.codeaurora.org/gitweb/quic/la/?p=kernel/msm.git;a=blob;f=drivers/iommu/msm_iommu-v2.c;h=e3aa30c6e31bf55ae5eea3800a8ad910545c5edb;hb=bd3e933fcaca9ffdb45ddc0ce341c45e1ee14091

Thanks,

Olav Haugan

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
