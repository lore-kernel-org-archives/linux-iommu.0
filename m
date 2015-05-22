From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [BUG 4.1-rc4] i40e VF creation breaks vt-d
Date: Fri, 22 May 2015 12:09:26 +0200
Message-ID: <20150522100926.GA1928@suse.de>
References: <555DC288.5030108@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <555DC288.5030108-l3A5Bk7waGM@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alexander Graf <agraf-l3A5Bk7waGM@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, "Williams,
	Mitch A" <mitch.a.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, jesse.brandeburg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hey Alex,

On Thu, May 21, 2015 at 01:33:28PM +0200, Alexander Graf wrote:
> While trying to get a sense for performance of i40e and i40evf, I
> figured I'd try and create a VF device on the host and activate it.
> However, as soon as I brought the VF up, my host became unreachable. The
> kernel is current 4.1-rc4.
> 
> Main network is connected through ixgbe (eth1), i40e is on a
> direct-connect connection with another system. The host is an Intel
> Haswell box with XAPIC and Vt-d enabled.

It is weird that you see DMAR faults two days after you tried this. Are
there any messages from the IOMMU around the time you enabled the VF?

Does it work with iommu disabled?

> ---- almost 2 days pass ----
> 
> [    9.061798] dmar: DRHD: handling fault status reg 2
> [    9.072566] dmar: INTR-REMAP: Request device [[03:00.0] fault index 5e
> [    9.072566] INTR-REMAP:[fault reason 34] Present field in the IRTE
> entry is clear

The timing info is indeed weird and might indicate another problem
outside of the iommu space. The DMAR faults might just be a follow-on
error then.


	Joerg
