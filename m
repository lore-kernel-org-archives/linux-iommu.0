From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 3/5] iommu/arm-smmu: Introduce stream ID masking
Date: Wed, 9 Oct 2013 11:09:17 +0100
Message-ID: <20131009100917.GB5985@mudshark.cambridge.arm.com>
References: <1381224444-27303-1-git-send-email-andreas.herrmann@calxeda.com>
	<1381224444-27303-4-git-send-email-andreas.herrmann@calxeda.com>
	<20131008151007.GD21189@mudshark.cambridge.arm.com>
	<20131008152008.GE2935@alberich> <20131008164021.GH2935@alberich>
	<20131008165920.GG21189@mudshark.cambridge.arm.com>
	<52545266.6010400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <52545266.6010400-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Oct 08, 2013 at 07:43:50PM +0100, Rob Herring wrote:
> On 10/08/2013 11:59 AM, Will Deacon wrote:
> > On Tue, Oct 08, 2013 at 05:40:21PM +0100, Andreas Herrmann wrote:
> >> On Tue, Oct 08, 2013 at 05:20:08PM +0200, Andreas Herrmann wrote:
> >> To be more specific: For SATA I'd need to specify 10 StreamIds. This
> >> would
> >>
> >> (1) exceed MAX_MASTER_STREAMIDS (currently it's 8)
> >>
> >>    (Can easily be fixed by adapting a macro.)
> >>
> >> (2) exceed number of available SMR groups to map the IDs to a context.
> >>
> >>    This can be solved by caclulating an appropriate mask for the
> >>    mapping (but with a non-power-of-two number of StreamIds that's
> >>    already non-trivial -- for the trivial case I have some code to do
> >>    this).
> >>
> >> Both problems are avoided by introducing this patch -- use
> >> smr_mask_bits to map all StreamIDs to the same context and be done
> >> with it. (for the "single-master-SMMU" case)
> > 
> > The problem is, this information *really* doesn't belong in the device tree,
> > but I think computing the general case dynamically is incredibly difficult
> > too (and requires *complete* topological information in the device-tree, so
> > you don't accidentally pull in other devices).
> 
> Couldn't this information be implied from the DT when you have no
> streamID and only a single mmu-master?

It's still fairly fragile though, since you (a) don't know that the stream
IDs of the master are matchable by the SMRs (if we had the stream IDs, we
can check this) and (b) you can still end up pulling devices into your
address space that would otherwise happily operate using passthrough.

Will
