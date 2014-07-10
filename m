From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCHv2 0/3] Support for nesting IOMMUs in VFIO
Date: Thu, 10 Jul 2014 12:34:06 +0100
Message-ID: <20140710113406.GM2449@arm.com>
References: <1404930526-32119-1-git-send-email-will.deacon@arm.com>
	<1404938235.4256.199.camel@ul30vt.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1404938235.4256.199.camel-85EaTFmN5p//9pzu0YdTqQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hey Alex,

On Wed, Jul 09, 2014 at 09:37:15PM +0100, Alex Williamson wrote:
> On Wed, 2014-07-09 at 19:28 +0100, Will Deacon wrote:
> > Hello,
> > 
> > This is v2 of the RFC I originally posted here:
> > 
> >  RFCv1: http://permalink.gmane.org/gmane.linux.kernel.iommu/5552
> > 
> > It's changed significantly since then, based on helpful feedback from
> > Alex. In particular, I no longer butcher the IOMMU API, instead making
> > use of a new iommu_attr to indicate that a domain requires support for
> > nesting.
> > 
> > All feedback welcome (this is still an RFC after all),
> 
> It's a lot cleaner this way, but I'm concerned that allowing a "nesting"
> IOMMU to be created and used just like a TYPE1v2 IOMMU, even if the
> IOMMU doesn't support it, puts us in a corner for compatibility later.
> The safer approach might be to fail the attach_group function if we
> can't set the domain attribute, ie. enforce that the IOMMU must support
> it. 

I also contemplated this (and was my source of confusion when we were
discussing using iommu_attr before), however from a user's perspective it's
not at all clear what's gone wrong. Essentially, VFIO would advertise
support for VFIO_TYPE1_NESTING_IOMMU but any attempt to VFIO_SET_IOMMU
for a container would fail. Knowing to try and fall-back on VFIO_TYPE1v2_IOMMU
isn't at all obvious.

> I don't know how you'd handle it if only some of the domains within
> a container supported it, so enforcement may simplify things down the
> road too.  We wouldn't need the vfio_domains_have_iommu_nesting()
> function that way either.

Agreed, it would certainly make things simpler in the kernel. Although, if
we allow a subset of domains in a container to use nesting, I think that's
possible by only allowing groups in those domains to be part of the virtual
SMMU interface.

Do you think that returning something like -EOPNOTSUPP from an attach is
sufficient for userspace to figure out what's gone wrong?

Will
