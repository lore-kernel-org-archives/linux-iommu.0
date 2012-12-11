From: Sethi Varun-B16395 <B16395-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH 3/4 v5] iommu/fsl: Add iommu domain attributes required
	by fsl PAMU driver.
Date: Tue, 11 Dec 2012 04:50:29 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D2C4AEE@039-SN2MPN1-013.039d.mgd.msft.net>
References: <C5ECD7A89D1DC44195F34B25E172658D2B70EE@039-SN2MPN1-013.039d.mgd.msft.net>
	<1354645371.16710.15@snotra>
	<C5ECD7A89D1DC44195F34B25E172658D2C09A4@039-SN2MPN1-013.039d.mgd.msft.net>
	<1355187644.5334.23@snotra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1355187644.5334.23@snotra>
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
To: Wood Scott-B07421 <B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Tabi Timur-B04825 <B04825-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Tuesday, December 11, 2012 6:31 AM
> To: Sethi Varun-B16395
> Cc: Wood Scott-B07421; Joerg Roedel; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org; Tabi
> Timur-B04825
> Subject: Re: [PATCH 3/4 v5] iommu/fsl: Add iommu domain attributes
> required by fsl PAMU driver.
> 
> On 12/10/2012 04:10:06 AM, Sethi Varun-B16395 wrote:
> >
> >
> > > -----Original Message-----
> > > From: Wood Scott-B07421
> > > Sent: Tuesday, December 04, 2012 11:53 PM
> > > To: Sethi Varun-B16395
> > > Cc: Wood Scott-B07421; Joerg Roedel; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> > > iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org;
> > Tabi
> > > Timur-B04825
> > > Subject: Re: [PATCH 3/4 v5] iommu/fsl: Add iommu domain attributes
> > > required by fsl PAMU driver.
> > >
> > > On 12/04/2012 05:53:33 AM, Sethi Varun-B16395 wrote:
> > > >
> > > >
> > > > > -----Original Message-----
> > > > > From: Wood Scott-B07421
> > > > > Sent: Monday, December 03, 2012 10:34 PM
> > > > > To: Sethi Varun-B16395
> > > > > Cc: Joerg Roedel; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> > iommu-cunTk1MwBs/ROKNJybVBZg@public.gmane.org
> > > > > foundation.org; Wood Scott-B07421;
> > linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org;
> > > > Tabi
> > > > > Timur-B04825
> > > > > Subject: Re: [PATCH 3/4 v5] iommu/fsl: Add iommu domain
> > attributes
> > > > > required by fsl PAMU driver.
> > > > >
> > > > > On 12/03/2012 10:57:29 AM, Sethi Varun-B16395 wrote:
> > > > > >
> > > > > >
> > > > > > > -----Original Message-----
> > > > > > > From: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> > [mailto:iommu-
> > > > > > > bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org] On Behalf Of Joerg
> > Roedel
> > > > > > > Sent: Sunday, December 02, 2012 7:33 PM
> > > > > > > To: Sethi Varun-B16395
> > > > > > > Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> > > > iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org;
> > > > > > Wood
> > > > > > > Scott-B07421; linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org; Tabi
> > Timur-B04825
> > > > > > > Subject: Re: [PATCH 3/4 v5] iommu/fsl: Add iommu domain
> > > > attributes
> > > > > > > required by fsl PAMU driver.
> > > > > > >
> > > > > > > Hmm, we need to work out a good abstraction for this.
> > > > > > >
> > > > > > > On Tue, Nov 20, 2012 at 07:24:56PM +0530, Varun Sethi wrote:
> > > > > > > > Added the following domain attributes required by FSL PAMU
> > > > driver:
> > > > > > > > 1. Subwindows field added to the iommu domain geometry
> > > > attribute.
> > > > > > >
> > > > > > > Are the Subwindows mapped with full size or do you map only
> > > > parts
> > > > > > of the
> > > > > > > subwindows?
> > > > > > >
> > > > > > [Sethi Varun-B16395] It's possible to map a part of the
> > subwindow
> > > > i.e.
> > > > > > size of the mapping can be less than the sub window size.
> > > > > >
> > > > > > > > +	 * This attribute indicates number of DMA subwindows
> > > > > supported
> > > > > > by
> > > > > > > > +	 * the geometry. If there is a single window that maps
> > > > the
> > > > > > entire
> > > > > > > > +	 * geometry, attribute must be set to "1". A value of
> > > > "0"
> > > > > > implies
> > > > > > > > +	 * that this mechanism is not used at all(normal paging
> > > > is
> > > > > > used).
> > > > > > > > +	 * Value other than* "0" or "1" indicates the actual
> > > > number
> > > > > of
> > > > > > > > +	 * subwindows.
> > > > > > > > +	 */
> > > > > > >
> > > > > > > This semantic is ugly, how about a feature detection
> > mechanism?
> > > > > > >
> > > > > > [Sethi Varun-B16395] A feature mechanism to query the type of
> > > > IOMMU?
> > > > >
> > > > > A feature mechanism to determine whether this subwindow
> > mechanism is
> > > > > available, and what the limits are.
> > > > >
> > > > So, we use the IOMMU capability interface to find out if IOMMU
> > > > supports sub windows or not, right? But still number of sub
> > windows
> > > > would be specified as a part of the geometry and the valid value
> > for
> > > > sub windows would  0,1 or actual number of sub windows.
> > >
> > > How does a user of the interface find out what values are possible
> > for
> > > the "actual number of subwindows"?  How does a user of the
> > interface find
> > > out whether there are any limitations on specifying a value of zero
> > (in
> > > the case of PAMU, that would be a maximum 1 MiB naturally-aligned
> > > aperture to support arbitrary 4KiB mappings)?
> > How about if we say that the default value for subwindows is zero and
> > this what you get when you read the geometry (iommu_get_attr) after
> > initializing the domain? In that case the user would know that
> > implication of setting subwindows to zero with respect to the aperture
> > size.
> 
> So it would default to the maximum aperture size possible with no
> subwindows?  That might be OK, though is there a way to reset the domain
> later on to get back to that informational state?
> 
[Sethi Varun-B16395] Yes, that can be done via iommu_set_attr API.

> How about finding out the maximum number of subwindows?
[Sethi Varun-B16395] We can introduce an API to determine the permissible range of values for an attribute, but it may be redundant for other IOMMU implementations. For the IOMMU implementations where geometry is just a read only attribute, iommu_get_attr returns the set of permissible values. I think it would be better if we can add a read only field (for the users) "max_subwindows" to the geometry.

-Varun
