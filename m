From: Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [RFC] PCI ACS Flags Clarification
Date: Wed, 5 Apr 2017 09:51:06 -0400
Message-ID: <615834cc-37d2-afd4-d093-23fc9e33f5d7@codeaurora.org>
References: <49257b71-6fa1-5870-fba6-1b8c5179b8ec@codeaurora.org>
	<20170404133923.5232e424@t450s.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170404133923.5232e424-1yVPhWWZRC1BDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Linux PCI <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Alex,

Thank you very much for the detailed explanation.

On 4/4/2017 3:39 PM, Alex Williamson wrote:
> On Tue, 4 Apr 2017 14:47:58 -0400
> Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
> 
[cut]

>> The requirement is to have an 
>> 1. ACS capability with PCI_ACS_SV if p2p is not supported
>> 2. ACS capability with PCI_ACS_SV|PCI_ACS_RR | PCI_ACS_CR |
>>   PCI_ACS_UF if p2p is supported.
>>
>> Did I get this right?
> 

I'm looking for sanity check on OS requirements. According to the PCIE spec,
ACS itself is optional. However, Linux requires ACS capability. I want to
make sure that we are satisfying the Linux requirements here.

I also agree that spec should be the guide. Maybe, a combination of spec+linux
is the right answer.

> I'd suggest following the spec, not the code, that way you always have a
> case for how you interpret the spec and the behavior of your hardware.
> The code is an attempt to validate the device against the spec, but more
> thorough implementations may follow.  REQ_ACS_FLAGS defines the set of
> ACS capabilities we think are relevant to device isolation.  In
> particular, UF seems like a key feature and our current test for it may
> not be fully correct.  Note how RR and CR only specify p2p with other
> root ports while UF requires transaction towards to the RC.  Section
> 6.12.2 further defines Redirected Request Validation as a feature
> within the context of RR and CR.  So rather than look at the code,
> discuss section 6.12 with the hardware engineers and understand how it
> behaves relative to each device and transaction type.  Implement the
> capabilities that best match.  Attempting a minimal implementation
> based on the current software interpretation may bite later, for
> instance if we re-interpret how UF works.  Thanks,

I read your reply multiple times. Here is what I got from it.

The summary below is for the root ports only.

- P2P on root ports is optional. 
- If P2P is there source validation, translation blocking, upstream forwarding,
p2p request redirection and p2p completion redirection ACS capabilities need to be
there for spec+linux compliance. 
- If P2P is not there source validation, translation blocking and upstream forwarding
needs to be there for spec+linux compliance.
- The code is relaxed to allow any combination of these today based on the ACS
capability but it can change tomorrow. 

Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
