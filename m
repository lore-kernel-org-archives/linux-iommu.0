From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: SMMU 2-stage support
Date: Fri, 17 Apr 2015 13:41:28 +0100
Message-ID: <20150417124128.GB29348@arm.com>
References: <CAN9JPjFf1Lb+L8sWq0SWt8f6P6DX2i308OeF+TdnFdstRoU3hA@mail.gmail.com>
	<20150218185600.GN22017@arm.com>
	<CAN9JPjFvg=e948ZLLtrUTnvDp8UWHCX2NGB4iUEES733T9YytQ@mail.gmail.com>
	<20150413104122.GC2869@arm.com>
	<BN3PR0301MB12194C697DBE9D721BC97F5DEAE60@BN3PR0301MB1219.namprd03.prod.outlook.com>
	<20150415161739.GD18864@arm.com>
	<CY1PR0301MB0748D6CF4A434A441442D84087E40@CY1PR0301MB0748.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CY1PR0301MB0748D6CF4A434A441442D84087E40-YrwGdl+PljkyhdUd3pz1uJwN6zqB+hSMnBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Stuart Yoder <stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Apr 16, 2015 at 04:46:59PM +0100, Stuart Yoder wrote:
> > > > So, whilst it's great that you're looking at the code, I'm not very keen on
> > > > merging anything until we have people committed to using it. Right now, the
> > > > only feedback I've had has been going in the para-virt direction and I don't
> > > > think we should do this "for fun".
> > > Freescale would be interested in using the vSMMU implementation. We have
> > > use cases for assigning devices to guest user space. Are you suggesting
> > > that you are more inclined to using the para virtualized approach?
> > 
> > I can see arguments either way; the vSMMU means that the guest can use the
> > same SMMU driver as the host but a para-virtualised approach could
> > theoretically be used across multiple SMMU implementations as well as
> > potentially being kinder on the TLB.
> 
> In the paravirt approach is the guest managing its own stage 1 
> page tables (read directly by the hardware SMMU)?

No; ideally the paravirtualised interface would abstract any details of
the hardware, including page table format. So you might have a "map" hvc
call that takes iova, (guest) phys, size, for example. Then the hypervisor
would manually collapse that into the current page tables using iommu_map.

> Is there anything written up anywhere sketching out how the paravirt
> approach would work?   Are there any limitations vs the vSMMU?

Not yet, and that's exactly the kind of research/investigation I'd like to
see happening before we commit ourselves one way or the other.

Will
