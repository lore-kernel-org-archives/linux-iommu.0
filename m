From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: RFC: vfio API changes needed for powerpc
Date: Tue, 02 Apr 2013 20:54:05 -0600
Message-ID: <1364957645.2882.195.camel@bling.home>
References: <1364940828.24520.26@snotra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1364940828.24520.26@snotra>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Wood Scott-B07421 <B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "agraf-l3A5Bk7waGM@public.gmane.org" <agraf-l3A5Bk7waGM@public.gmane.org>, "qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org" <qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org>, Yoder Stuart-B08248 <B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Bhushan Bharat-R65777 <R65777-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, 2013-04-02 at 17:13 -0500, Scott Wood wrote:
> On 04/02/2013 04:16:11 PM, Alex Williamson wrote:
> > On Tue, 2013-04-02 at 15:54 -0500, Stuart Yoder wrote:
> > > The number of windows is always power of 2 (and max is 256).  And  
> > to reduce
> > > PAMU cache pressure you want to use the fewest number of windows
> > > you can.    So, I don't see practically how we could transparently
> > > steal entries to
> > > add the MSIs.     Either user space knows to leave empty windows for
> > > MSIs and by convention the kernel knows which windows those are (as
> > > in option #A) or explicitly tell the kernel which windows (as in  
> > option #B).
> > 
> > Ok, apparently I don't understand the API.  Is it something like
> > userspace calls GET_ATTR and finds out that there are 256 available
> > windows, userspace determines that it needs 8 for RAM and then it has  
> > an
> > MSI device, so it needs to call SET_ATTR and ask for 16?  That seems
> > prone to exploitation by the first userspace to allocate it's  
> > aperture,
> 
> What exploitation?
> 
> It's not as if there is a pool of 256 global windows that users  
> allocate from.  The subwindow count is just how finely divided the  
> aperture is.  The only way one user will affect another is through  
> cache contention (which is why we want the minimum number of subwindows  
> that we can get away with).
> 
> > but I'm also not sure why userspace could specify the (non-power of 2)
> > number of windows it needs for RAM, then VFIO would see that the  
> > devices
> > attached have MSI and add those windows and align to a power of 2.
> 
> If you double the subwindow count without userspace knowing, you have  
> to double the aperture as well (and you may need to grow up or down  
> depending on alignment).  This means you also need to halve the maximum  
> aperture that userspace can request.  And you need to expose a  
> different number of maximum subwindows in the IOMMU API based on  
> whether we might have MSIs of this type.  It's ugly and awkward, and  
> removes the possibility for userspace to place the MSIs in some unused  
> slot in the middle, or not use MSIs at all.

Ok, I missed this in Stuart's example:

    Total aperture: 512MB
    # of windows: 8

    win gphys/
    #   iova        phys          size
    --- ----        ----          ----
    0   0x00000000  0xX_XX000000  64MB
    1   0x04000000  0xX_XX000000  64MB
    2   0x08000000  0xX_XX000000  64MB
    3   0x0C000000  0xX_XX000000  64MB
    4   0x10000000  0xf_fe044000  4KB    // msi bank 1
          ^^
    5   0x14000000  0xf_fe045000  4KB    // msi bank 2
          ^^
    6   0x18000000  0xf_fe046000  4KB    // msi bank 3
          ^^
    7            -             -  disabled

So even though the MSI banks are 4k in this example, they're still on
64MB boundaries.  If userspace were to leave this as 256 windows, each
would be 2MB and we'd use 128 of them to map the same memory as these
4x64MB windows and thrash the iotlb harder.  The picture is becoming
clearer.  Thanks,

Alex
