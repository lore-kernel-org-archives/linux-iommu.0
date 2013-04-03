From: Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: RFC: vfio API changes needed for powerpc
Date: Wed, 3 Apr 2013 16:25:54 -0500
Message-ID: <1365024354.25627.14@snotra>
References: <1364958751.2882.209.camel@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="Flowed"; DelSp="Yes"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1364958751.2882.209.camel-xdHQ/5r00wBBDLzU/O5InQ@public.gmane.org> (from
	alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org on Tue Apr  2 22:12:31 2013)
Content-Disposition: inline
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
Cc: Wood Scott-B07421 <B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "agraf-l3A5Bk7waGM@public.gmane.org" <agraf-l3A5Bk7waGM@public.gmane.org>, "qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org" <qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org>, Yoder Stuart-B08248 <B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Bhushan Bharat-R65777 <R65777-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 04/02/2013 10:12:31 PM, Alex Williamson wrote:
> On Tue, 2013-04-02 at 17:44 -0500, Scott Wood wrote:
> > On 04/02/2013 04:32:04 PM, Alex Williamson wrote:
> > > On Tue, 2013-04-02 at 15:57 -0500, Scott Wood wrote:
> > > > On 04/02/2013 03:32:17 PM, Alex Williamson wrote:
> > > > > On x86 the interrupt remapper handles this transparently when  
> MSI
> > > > > is enabled and userspace never gets direct access to the  
> device
> > > MSI
> > > > > address/data registers.
> > > >
> > > > x86 has a totally different mechanism here, as far as I  
> understand
> > > --
> > > > even before you get into restrictions on mappings.
> > >
> > > So what control will userspace have over programming the actually  
> MSI
> > > vectors on PAMU?
> >
> > Not sure what you mean -- PAMU doesn't get explicitly involved in
> > MSIs.  It's just another 4K page mapping (per relevant MSI bank).   
> If
> > you want isolation, you need to make sure that an MSI group is only
> > used by one VFIO group, and that you're on a chip that has alias  
> pages
> > with just one MSI bank register each (newer chips do, but the first
> > chip to have a PAMU didn't).
> 
> How does a user figure this out?

The user's involvement could be limited to setting a policy knob of  
whether that degree of isolation is required (if required and  
unavailable, all devices using an MSI bank would be forced into the  
same group).  We'd need to do something with MSI allocation so that we  
avoid using an MSI bank with more than one IOMMU group where possible.   
I'm not sure about the details yet, or how practical this is.  There  
might need to be some MSI bank assignment done as part of the VFIO  
device binding process, if there are going to be more VFIO groups than  
there are MSI banks (reserving one bank for host use).

-Scott
