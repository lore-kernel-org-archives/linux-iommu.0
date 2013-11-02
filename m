From: Marcelo Tosatti <mtosatti-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: BUG unpinning 1 GiB huge pages with KVM PCI assignment
Date: Fri, 1 Nov 2013 23:17:09 -0200
Message-ID: <20131102011709.GB30381@amt.cnet>
References: <20131028193756.GA1653@psuche> <20131029231943.GA29828@psuche>
	<20131101174734.GA27370@amt.cnet> <20131101180126.GD7961@psuche>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20131101180126.GD7961@psuche>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Greg Edwards <gedwards-LfVdkaOWEx8@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Nov 01, 2013 at 12:01:26PM -0600, Greg Edwards wrote:
> >> Is it expected the same pages might be mapped in multiple memslots?  I
> >> noticed the gfn overlap check in __kvm_set_memory_region().
> >>
> >> It appears pfn_to_dma_pte() is behaving as expected, given half the huge
> >> page is still mapped.  Do I have that correct?  If so, then we really
> >> can't rely on iommu_iova_to_phys() alone to determine if its safe to
> >> unpin a page in kvm_iommu_put_pages().
> >>
> >> Ideas on how to best handle this condition?
> >
> > iommu_unmap should grab lpage_level bits from the virtual address
> > (should fix the BUG), and should return correct number of freed pfns in
> > case of large ptes (should fix the leak). Will send a patch shortly.
> 
> Thanks, Marcelo.  This patch also fixes the BUG:
> 
> http://www.spinics.net/lists/kvm/msg97784.html

Was using an old tree, without leak bug fixes from present upstream.
