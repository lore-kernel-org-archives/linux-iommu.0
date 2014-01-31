From: Andrew Cooks <acooks-vYTEC60ixJUAvxtiuMwx3w@public.gmane.org>
Subject: Re: Who understand the IOMMU code?
Date: Fri, 31 Jan 2014 08:42:23 +0800
Message-ID: <CAJtEV7YLC=iSbzWS8PWDo8JWY_fyaRckxtLC3aCqU7sx+O4UPQ@mail.gmail.com>
References: <20140130201219.20665.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140130201219.20665.qmail-FT9nftu9LUyCkawlElnc8EEOCMrvLtNR@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: George Spelvin <linux-gpGsJRJZ3PBBDgjK7y7TUQ@public.gmane.org>
Cc: fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, "open list:INTEL IOMMU (VT-d)" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, "open list:PCI SUBSYSTEM" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 31 January 2014 04:12, George Spelvin <linux-gpGsJRJZ3PBBDgjK7y7TUQ@public.gmane.org> wrote:
>
> I'm trying to add a quirk to the IOMMU code to handle certain buggy
> devices which use the wrong requester id (devfn) for PCIe requests.
> In my case, there are a number of Marvell SATA controllers, popular with
> motherboard manufacturers, which generate DMA from functions 0 and 1,
> even though they only support function 0.
>
> Andrew cooks wrote a working (but, to my eyes, ugly) patch; see
> https://bugzilla.kernel.org/show_bug.cgi?id=42679#c22
>
> I'm trying to improve it, but even limiting myself to intel-iommu.c,
> it's definitely hairy.

What's hairy? The patch, the problem, or the iommu code?

> Right now, I'm trying to figure out where to remove the additional
> mapping.

Which additional mapping? Are you implying that the patch adds redundant
context entries or are you talking about folding the
quirk_map_multi_requester_ids()
and quirk_map_requester_id()  functions into the main code path?

> Currently I'm looking at adding another clear_context_table() call
> before iommu_detach_dev() in domain_remove_one_dev_info(); my goal is
> to piggyback on iommu_detach_dev's flush calls.
>
> But I'm having trouble figuring out the whole device_domain_info list
> business.
>
> In particular, does the comparison of domain, bus, and
> devinfo ever produce a different result than just comparing
> info->dev to pdev?
>
> I have a flag in the pci_device warning about the quirk, but
> I'm having trouble finding the function that's the opposite of
> domain_context_mapping().
>
> Does anyone actually understand this stuff well enough to review my
> patches when I finish?  May I ask for a bit of guidance on the way?
> Right now I don't even understand the Intel iommu code, much less all
> ther others I should be patching for a full fix.

Let me see if I understand you correctly.
1) You don't like the simple patch that clearly shows the problem (and offers
    a simple work-around), because it's too ugly.
2) You complain that "this stuff" (presumably the stuff you didn't
learn from the
    ugly patch) is hard to understand.
3) You question whether anyone else understands "this stuff".
4) You want to know whether anyone is qualified to review your patch when
    you 'finish it' ...
5) ... as long as someone just help you a little bit?

It that really what you meant?

> The same code points would also be a good place to add phantom functions
> support some day.


I don't think you understood the relevance of Alex's patch set for a
"PCIe requester ID interface", that I referred you to.

Firstly, finding the full set of requester ids that an iommu might see for every
pdev below it is a bigger problem than just quirky Marvell SATA controllers and
phantom functions (which may or may not actually be used by anyone). PCIe
bridges, even spec compliant ones, introduce similar issues.

Secondly, that patch tries to unify the quirky and non quirky cases under the
pcie_for_each_requester() function, which seems like the prefered approach.

Thirdly, that patch was written and reviewed by people who do actually
understand how "this stuff" works, so there is much to learn from it if you want
to write the solution that is ultimately accepted into mainline and convince
them that you can (and will) maintain it.

Here's the link to the patch posting and review again:
https://lists.linuxfoundation.org/pipermail/iommu/2013-July/006083.html

When you've read and understood that discussion, have another look at the
current domain_context_mapping() and try to see the resemblance between
the handling of bridging, dependant devices and quirky devices.

Ultimately, this isn't going anywhere until David Woodhouse, the Intel iommu
maintainer, gets involved. I have not yet found the magical incantation to
achieve that.

May the odds be ever in your favour!

a.
