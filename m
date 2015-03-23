From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: ARM SMMU - Stall mode
Date: Mon, 23 Mar 2015 10:38:08 +0000
Message-ID: <20150323103808.GC11189@arm.com>
References: <20150319065207.GE23658@toto> <20150319165504.GD4751@arm.com>
	<20150320001438.GF23658@toto>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150320001438.GF23658@toto>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Edgar E. Iglesias" <edgar.iglesias-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Julien Grall <julien.grall-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Mar 20, 2015 at 12:14:38AM +0000, Edgar E. Iglesias wrote:
> On Thu, Mar 19, 2015 at 04:55:05PM +0000, Will Deacon wrote:
> > On Thu, Mar 19, 2015 at 06:52:07AM +0000, Edgar E. Iglesias wrote:
> > > I'm looking at adding models for the SMMU and it's stall feature to
> > > Xilinx ZynqMP QEMU models. The stall mode is quite problematic to
> > > model though. So I'm trying to figure out if I can get away without it :-)
> > 
> > Sure -- just make the context bank SCTLR.CFCFG fields RES0 and you'll be
> > fine. The stall mode is optional in the architecture and not used by
> > Linux.
> > 
> > > I was trying to figure from the kernel sources if the SMMU Stall mode
> > > (for stalling and later resuming failed memory accesses) is used by
> > > the kernel.
> > > 
> > > AFAICT, the stall mode is enabled by the SMMU driver but the users of
> > > the report_iommu_fault() callbacks seem to all just do error reporting.
> > > Do I understand correctly in that Linux/KVM is currently not really
> > > depending on the stall function?
> > > 
> > > Are there any plans or ongoing work to implement paging features that
> > > would require the stall/resume feature for IOMMUs?
> > > E.g swapping of DMA:able memory, CoW etc.
> > > 
> > > I noticed that AMD has something in their HSA/KFD framework around it
> > > but it seems quite AMD specific, please correct me if I'm wrong.
> > 
> > The main issue with the stall model is that it doesn't work nicely with
> > PCI and is prone to deadlock on systems that haven't been designed with
> > stalled transactions in mind. If/when Linux gets support for paged DMA
> > memory this will probably be using ATS/PRI.
> 
> What is the situation for platform devices (non-PCI) hanging off on-chip
> AXI interconnects for example, do you think the SMMUs stall mode would
> be useful to Linux to do paged DMA?
> Or is the stall mode unlikely to be used at all with current versions
> of the SMMU?

Well, I wouldn't rule anything out, but I don't know of anybody working
on the stall model and it would need to be used on an opt-in basis given
the potential for deadlocks.

Will
