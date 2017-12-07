From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v3 15/16] iommu: introduce page response function
Date: Thu, 7 Dec 2017 14:51:21 -0700
Message-ID: <20171207145121.23b3f26f@t450s.home>
References: <1510944914-54430-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1510944914-54430-16-git-send-email-jacob.jun.pan@linux.intel.com>
	<93661c1c-2d3b-295f-0b9d-52e50ea9e1d0@arm.com>
	<20171204133715.50c45136@jacob-builder>
	<a6cfc27a-6121-1e67-6e0d-f94a383bcd6f@arm.com>
	<20171206112521.1edf8e9b@jacob-builder>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20171206112521.1edf8e9b@jacob-builder>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Rafael Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Kumar,
	Sanjay K" <sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, 6 Dec 2017 11:25:21 -0800
Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:

> On Tue, 5 Dec 2017 17:21:15 +0000
> Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org> wrote:
> 
> > Hi Jacob,
> > 
> > On 04/12/17 21:37, Jacob Pan wrote:  
> > > On Fri, 24 Nov 2017 12:03:50 +0000
> > > Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org> wrote:
> > >     
> > >> On 17/11/17 18:55, Jacob Pan wrote:    
> > >>> When nested translation is turned on and guest owns the
> > >>> first level page tables, device page request can be forwared
> > >>> to the guest for handling faults. As the page response returns
> > >>> by the guest, IOMMU driver on the host need to process the
> > >>> response which informs the device and completes the page request
> > >>> transaction.
> > >>>
> > >>> This patch introduces generic API function for page response
> > >>> passing from the guest or other in-kernel users. The definitions
> > >>> of the generic data is based on PCI ATS specification not limited
> > >>> to any vendor.>
> > >>> Signed-off-by: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>    
> > [...]  
> > > I think the simpler interface works for in-kernel driver use case
> > > very well. But in case of VFIO, the callback function does not turn
> > > around send back page response. The page response comes from guest
> > > and qemu, where they don;t keep track of the the prq event data.    
> > 
> > Is it safe to trust whatever response the guest or userspace gives
> > us? The answer seems fairly vendor- and device-specific so I wonder
> > if VFIO or IOMMU shouldn't do a bit of sanity checking somewhere, and
> > keep track of all injected page requests.

This is always my question when we start embedding IDs in structures.
> > 
> > From SMMUv3 POV, it seems safe (haven't looked at SMMUv2 but I'm not
> > so confident).
> > 
> > * The guest can only send page responses to devices assigned to it,
> > that's a given.
> >   
> Agree, IOMMU driver cannot enforce it. I think VFIO layer can make sure
> page response come from the assigned device and its guest/container.

Can we enforce it via the IOMMU/VFIO interface?  If the response is for
a struct device, and not an rid/did embedded in a structure, then vfio
can pass it through w/o worrying about it, ie. response comes in via
ioctl with association to vfio device fd -> struct vfio_device -> struct
device, iommu driver fills in rid/did.  Thanks,

Alex
