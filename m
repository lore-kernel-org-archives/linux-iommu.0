From: "George Spelvin" <linux-gpGsJRJZ3PBBDgjK7y7TUQ@public.gmane.org>
Subject: Who understand the IOMMU code?
Date: 30 Jan 2014 15:12:19 -0500
Message-ID: <20140130201219.20665.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Cc: acooks-Re5JQEeQqe+YEALZW0XXGg@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ""@gmail.com, linux-gpGsJRJZ3PBBDgjK7y7TUQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

I'm trying to add a quirk to the IOMMU code to handle certain buggy
devices which use the wrong requester id (devfn) for PCIe requests.
In my case, there are a number of Marvell SATA controllers, popular with
motherboard manufacturers, which generate DMA from functions 0 and 1,
even though they only support function 0.

Andrew cooks wrote a working (but, to my eyes, ugly) patch; see
https://bugzilla.kernel.org/show_bug.cgi?id=42679#c22

I'm trying to improve it, but even limiting myself to intel-iommu.c,
it's definitely hairy.

Right now, I'm trying to figure out where to remove the additional
mapping.

Currently I'm looking at adding another clear_context_table() call
before iommu_detach_dev() in domain_remove_one_dev_info(); my goal is
to piggyback on iommu_detach_dev's flush calls.

But I'm having trouble figuring out the whole device_domain_info list
business.

In particular, does the comparison of domain, bus, and
devinfo ever produce a different result than just comparing
info->dev to pdev?

I have a flag in the pci_device warning about the quirk, but
I'm having trouble finding the function that's the opposite of
domain_context_mapping().

Does anyone actually understand this stuff well enough to review my
patches when I finish?  May I ask for a bit of guidance on the way?
Right now I don't even understand the Intel iommu code, much less all
ther others I should be patching for a full fix.

The same code points would also be a good place to add phantom functions
support some day.

Thank you!
