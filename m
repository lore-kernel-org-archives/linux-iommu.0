From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/2] iommu/vt-d: Report superpage support in sysfs
Date: Mon, 03 Aug 2015 09:09:00 -0600
Message-ID: <1438614540.13460.112.camel@redhat.com>
References: <20150714211624.11515.25204.stgit@gimli.home>
	<20150714212459.11515.71211.stgit@gimli.home>
	<20150803143029.GD20968@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150803143029.GD20968-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, 2015-08-03 at 16:30 +0200, Joerg Roedel wrote:
> On Tue, Jul 14, 2015 at 03:25:04PM -0600, Alex Williamson wrote:
> > We already have the VT-d capability register printed raw, but it
> > typically involves a trip to the code or the spec to figure out
> > whether superpages are supported.  Make this easier with "2M_pages"
> > and "1G_pages" sysfs entries that clearly report Y/N.
> > 
> > Signed-off-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > ---
> >  drivers/iommu/intel-iommu.c |   22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> 
> Can we make this a generic entry for all iommu types and export a
> pagesize bitmap instead?

Are you suggesting a bitmap in order to have a consistent interface,
independently implemented by each IOMMU driver, or are you suggesting a
common interface implemented by iommu_ops.pgsize_bitmap?  The latter is
pretty well broken already.  It can't represent different IOMMU hardware
units having different capabilities, and it's broken by drivers like
intel-iommu that don't expose native hardware page sizes, but anything
that can be broken down into native hardware page size, so ~(4k-1).

Programatically, a bitmap is a concise way to expose multiple page
sizes, but for human consumption, it's not an ideal solution.  Thanks,

Alex
