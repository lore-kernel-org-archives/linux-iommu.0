From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 0/4] SMMUv3 CMD_SYNC optimisation
Date: Mon, 16 Oct 2017 16:02:09 +0100
Message-ID: <20171016150208.GA10500@arm.com>
References: <cover.1504182142.git.robin.murphy@arm.com>
	<20171013190521.GD30572@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171013190521.GD30572-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, sgoutham-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Oct 13, 2017 at 08:05:21PM +0100, Will Deacon wrote:
> On Thu, Aug 31, 2017 at 02:44:24PM +0100, Robin Murphy wrote:
> > Since Nate reported a reasonable performance boost from the out-of-line
> > MSI polling in v1 [1], I've now implemented the equivalent for cons
> > polling as well - that has been boot-tested on D05 with some trivial I/O
> > and at least doesn't seem to lock up or explode. There's also a little
> > cosmetic tweaking to make the patches a bit cleaner as a series.
> > 
> > Robin.
> > 
> > [1] https://www.mail-archive.com/iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org/msg19657.html
> > 
> > Robin Murphy (5):
> >   iommu/arm-smmu-v3: Specialise CMD_SYNC handling
> >   iommu/arm-smmu-v3: Forget about cmdq-sync interrupt
> >   iommu/arm-smmu-v3: Use CMD_SYNC completion interrupt
> >   iommu/arm-smmu-v3: Poll for CMD_SYNC outside cmdq lock
> >   iommu/arm-smmu-v3: Use burst-polling for sync completion
> 
> What's this final mythical patch about? I don't see it in the series.
> 
> Anyway, the first two patches look fine to me, but this doesn't apply
> on top of my iommu/devel branch so they will need rebasing.

No idea what I was doing wrong on Friday, but the first two patches apply
cleanly now, so I'll push them out in a bit.

Sorry for the noise,

Will
