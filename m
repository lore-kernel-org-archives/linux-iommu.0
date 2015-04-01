From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [GIT PULL] iommu: Kill off pgsize_bitmap field from struct
	iommu_ops
Date: Wed, 01 Apr 2015 10:45:39 -0600
Message-ID: <1427906739.5567.251.camel@redhat.com>
References: <20150327171946.GL1562@arm.com>
	<20150331142440.GD22683@8bytes.org> <20150331144956.GA24094@arm.com>
	<1427817050.5567.148.camel@redhat.com> <20150401115340.GG1552@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150401115340.GG1552-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, 2015-04-01 at 12:53 +0100, Will Deacon wrote:
> On Tue, Mar 31, 2015 at 04:50:50PM +0100, Alex Williamson wrote:
> > It makes sense to me that supported page sizes has a similar problem to
> > IOMMU_CACHE; IOMMU mappings can be made that are dependent on the
> > composition of the domain at the time of mapping and there's no
> > requirement that all the IOMMU hardware units support the exact same
> > features.  VFIO already assumes that separate domains don't necessarily
> > use the same ops and we make sure mappings and un-mappings are aligned
> > to the smallest common size.  We'll have some work to do though if there
> > is no common size between the domains and we may need to add a test to
> > our notion of compatible domains if pgsize_bitmap moves from iommu_ops
> > (sorry, I forget whether you already had a patch for that in this pull
> > request).  Thanks,
> 
> The series updates vfio_pgsize_bitmap to use the domains, so dma_do_map
> will fail if there's no common page size amongst the IOMMUs referenced
> by the container. That preserves the existing behaviour, but I'm not
> sure why it's actually required. Couldn't we potentially allow different
> domains to use different page sizes?

We can.  I think the only thing we're trying to do with it now is
confirm that the user mapping meets the minimum size and alignment
requirements of the IOMMU.  We don't use it as a basis for our actual
mappings, it's the IOMMU API's job to do that.  Thanks,

Alex
