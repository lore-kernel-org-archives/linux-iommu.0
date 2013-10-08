From: Sethi Varun-B16395 <B16395-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH 3/5] iommu/arm-smmu: Introduce stream ID masking
Date: Tue, 8 Oct 2013 18:18:45 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D0A516014@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1381224444-27303-1-git-send-email-andreas.herrmann@calxeda.com>
	<1381224444-27303-4-git-send-email-andreas.herrmann@calxeda.com>
	<20131008151007.GD21189@mudshark.cambridge.arm.com>
	<20131008152008.GE2935@alberich> <20131008164021.GH2935@alberich>
	<20131008165920.GG21189@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20131008165920.GG21189-MRww78TxoiP5vMa5CHWGZ34zcgK1vI+I0E9HWUfgJXw@public.gmane.org>
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
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org [mailto:iommu-
> bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org] On Behalf Of Will Deacon
> Sent: Tuesday, October 08, 2013 10:29 PM
> To: Andreas Herrmann
> Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; Rob Herring; linux-arm-
> kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> Subject: Re: [PATCH 3/5] iommu/arm-smmu: Introduce stream ID masking
> 
> On Tue, Oct 08, 2013 at 05:40:21PM +0100, Andreas Herrmann wrote:
> > On Tue, Oct 08, 2013 at 05:20:08PM +0200, Andreas Herrmann wrote:
> > To be more specific: For SATA I'd need to specify 10 StreamIds. This
> > would
> >
> > (1) exceed MAX_MASTER_STREAMIDS (currently it's 8)
> >
> >    (Can easily be fixed by adapting a macro.)
> >
> > (2) exceed number of available SMR groups to map the IDs to a context.
> >
> >    This can be solved by caclulating an appropriate mask for the
> >    mapping (but with a non-power-of-two number of StreamIds that's
> >    already non-trivial -- for the trivial case I have some code to do
> >    this).
> >
> > Both problems are avoided by introducing this patch -- use
> > smr_mask_bits to map all StreamIDs to the same context and be done
> > with it. (for the "single-master-SMMU" case)
> 
> The problem is, this information *really* doesn't belong in the device
> tree, but I think computing the general case dynamically is incredibly
> difficult too (and requires *complete* topological information in the
> device-tree, so you don't accidentally pull in other devices).
> 
[Sethi Varun-B16395] I don't quiet follow the point about topological information. How do you determine from the topology if the stream ids should share the iommu domain?
Another question, how would iommu group creation work for dma masters with multiple stream ids?

-Varun
