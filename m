From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Increase SMMU CMD queue poll timeout
Date: Wed, 26 Apr 2017 10:48:46 +0100
Message-ID: <20170426094846.GD21744@arm.com>
References: <1493035176-3633-1-git-send-email-gakula@caviumnetworks.com>
	<20170424160841.GS12323@arm.com>
	<CA+sq2CeyVm4pcAVME7OAFVxpOcSJc5CsP0vz3ypDkSxdx0SKnQ@mail.gmail.com>
	<20170424170518.GU12323@arm.com>
	<CA+sq2CfNYKs8Ub4bWTM1GRGO=06N-Tn7BkehwJE6LpZvC0=R=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CA+sq2CfNYKs8Ub4bWTM1GRGO=06N-Tn7BkehwJE6LpZvC0=R=Q@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sunil Kovvuri <sunil.kovvuri-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Goutham, Sunil" <Sunil.Goutham-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Geetha sowjanya <gakula-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Geetha <gakula-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, LAKML <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Apr 26, 2017 at 02:50:04PM +0530, Sunil Kovvuri wrote:
> On Mon, Apr 24, 2017 at 10:35 PM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> > On Mon, Apr 24, 2017 at 10:26:53PM +0530, Sunil Kovvuri wrote:
> >> On Mon, Apr 24, 2017 at 9:38 PM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> >> > On Mon, Apr 24, 2017 at 05:29:36PM +0530, Geetha sowjanya wrote:
> >> >> From: Geetha <gakula-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
> >> >>
> >> >> When large memory is being unmapped, huge no of tlb invalidation cmds are
> >> >> submitted followed by a SYNC command. This sometimes hits CMD queue full and
> >> >> poll on queue drain is being timedout throwing error message 'CMD_SYNC timeout'.
> >> >>
> >> >> Although there is no functional issue, error message confuses user. Hence increased
> >> >> poll timeout to 500us
> >> >
> >> > Hmm, what are you doing to unmap that much? Is this VFIO teardown? Do you
> >> > have 7c6d90e2bb1a ("iommu/io-pgtable-arm: Fix iova_to_phys for block
> >> > entries") applied?
> >>
> >> Yes it's VFIO teardown and again yes the above fix is applied.
> >> But i didn't get how above fix is related.
> >> TLB invalidation commands are submitted at 'arm_smmu_tlb_inv_range_nosync()'
> >> and it's a loop over granule size.
> >>
> >> 1357         do {
> >> 1358                 arm_smmu_cmdq_issue_cmd(smmu, &cmd);
> >> 1359                 cmd.tlbi.addr += granule;
> >> 1360         } while (size -= granule);
> >>
> >> So if invalidation size is big then huge no of invalidation commands
> >> will be submitted
> >> irrespective of fix that you pointed above, right ?
> >
> > VFIO has some logic to batch up invalidations, but this didn't work properly
> > for us without the fix above. However, I guess you have a huge memory range
> > that's mapped with 2M sections or something, so there are still loads of
> > entries to invalidate.
> >
> > I would much prefer it if VFIO could just teardown the whole address space
> > so that we could do an invalidate all, but there's a chicken-and-egg problem
> > with page accounting iirc.
> >
> 
> We can definitely look into this from VFIO perspective but for now I am guessing
> this patch is fine, as no functionality is being changed.
> What do you say ?

Thinking about it some more, I'd rather we rework the polling loop so that:

1. It's structured more like the arm-smmu.c TLB loop queued for 4.11
   (so we don't udelay(1) if the thing doesn't sync immediately)

2. Have a larger timeout for the drain case, which I think is what you're
   running into. This could even be 1s, like arm-smmu.c.

Will
