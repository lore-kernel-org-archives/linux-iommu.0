From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC 0/6] vSMMU initialization
Date: Wed, 15 Jul 2015 14:42:22 +0100
Message-ID: <20150715134222.GA1579@arm.com>
References: <1434118810-28219-1-git-send-email-b.reynal@virtualopensystems.com>
	<20150612142328.GF12174@arm.com>
	<BN1PR0301MB06274ACB3A193799F40BE9F4EA9B0@BN1PR0301MB0627.namprd03.prod.outlook.com>
	<20150714110416.GD16213@arm.com>
	<CAN9JPjF1E0Dg_KAQcc4C+jKDuOHEATVhN+1NPa66jLrP8RieKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAN9JPjF1E0Dg_KAQcc4C+jKDuOHEATVhN+1NPa66jLrP8RieKA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Baptiste Reynal <b.reynal-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Cc: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org" <tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, "qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org" <qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jul 15, 2015 at 02:38:15PM +0100, Baptiste Reynal wrote:
> On Tue, Jul 14, 2015 at 1:04 PM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> > I think SMMUv3 is *far* more amenable to the vSMMU approach, largely
> > because it moves many of the data structures into memory, but also because
> > it has support for things like ATS and PRI, so sharing page tables with
> > the CPU becomes a real possibility (and is something that doesn't work
> > well with a PV model).
> >
> >> Just wondering if we can give more control with respect memory transaction
> >> attributes to the guest. Also, would it make sense to give guest control
> >> of the fault handling attributes i.e. fault/terminate model.
> >
> > I'd like to see the basics prototyped before we start trying to design
> > for these more advanced use-cases. I'm confident there are plenty of things
> > we haven't even considered at the moment.
> 
> From my current understanding, vSMMU and PV interface seems
> complementary and have different target. While the PV interface
> targets broad compatibility with hardware and page table abstraction,
> the vSMMU relies on specific hardware capabilities for better
> performances (with dual-stage support and future ATS/PRI). As no PV
> interface exists for now, we decided to focus our effort on the vSMMU.
> Unless PV interface is strictly needed, we'd like to continue with the
> implementation of the vSMMU.

On the contrary, I'm not going to merge vSMMU code unless there are strong
technical reasons against PV. I don't see your performance argument (I
would actually expect the vSMMU to be *slower* with SMMUv2) and I really
don't want fragmentation where user ABI is concerned.

Also, your argument about focussing on vSMMU because PV doesn't exist yet
doesn't make sense. Mainline doesn't support either of these for ARM.

> In my opinion, both solutions are complementary and can co-exist once
> someone shows interest for the PV.

I think you have this the wrong way around. We should start with PV (one
portable interface) and only add vSMMU interfaces where there are good
reasons to do so.

Will
