From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [GIT PULL] Intel IOMMU for 4.1
Date: Mon, 27 Apr 2015 11:30:52 -0600
Message-ID: <1430155852.4472.85.camel@redhat.com>
References: <1430038266.4833.14.camel@infradead.org>
	<1430069591.8301.91.camel@redhat.com>
	<1430070924.13479.5.camel@infradead.org>
	<1430072207.8301.103.camel@redhat.com> <553E4109.5060903@hp.com>
	<1430149195.4472.43.camel@redhat.com>
	<1430154752.6377.19.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1430154752.6377.19.camel-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, 2015-04-27 at 18:12 +0100, David Woodhouse wrote:
> On Mon, 2015-04-27 at 09:39 -0600, Alex Williamson wrote:
> > David,
> > 
> > Since this got pulled anyway, do you plan to follow-up with patches to
> > limit the graphics RMRR exception to the known and acceptable uses and
> > document them, or should I send a revert patch?  I don't think what we
> > have here is acceptable going forward or being backported to stable.
> > Thanks,
> 
> I didn't plan to, no. So far we *only* know of acceptable uses of RMRR
> on graphics devices, and the false positives that Linda mentioned.
> 
> The only cases we ever saw of RMRR being *problematic* when we tried
> to assign devices to guests were non-graphics devices, weren't they?

That's true, but if we're only trying to enable IGD assignment (which of
course doesn't work yet anyway), why add the entire PCI class rather
than perhaps at least testing for vendor ID 8086 and pci_is_root_bus()?
I don't see why we want to open the door any wider than necessary.

> Although obviously I'm looking into the oops that sl4ever reported;
> currently I'm wondering if that was broken even before your patch that
> blacklisted all RMRR-afflicted devices. It looks like
> device_to_iommu() doesn't return the correct results for devices
> behind a disabled IOMMU; it incorrectly attributes them to a catch-all
> IOMMU instead.
> 
> Or perhaps this is probably tied into the fact that your patch broke
> iommu=pt for RMRR-afflicted devices too. They currently get full
> translation. Which surely shouldn't be necessary, since passthrough
> mode would obviously *also* preserve the RMRR regions of 1:1 mappings.

I think you're actually referring to:

commit ea2447f700cab264019b52e2b417d689e052dcfd
Author: Tom Mingarelli <thomas.mingarelli-VXdhtT5mjnY@public.gmane.org>
Date:   Tue Nov 20 19:43:17 2012 +0000

    intel-iommu: Prevent devices with RMRRs from being placed into SI Domain
    
    This patch is to prevent non-USB devices that have RMRRs associated with the
    being placed into the SI Domain during init. This fixes the issue where the 
    for devices being placed in and out of the SI Domain gets lost.
    
    Signed-off-by: Thomas Mingarelli <thomas.mingarelli-VXdhtT5mjnY@public.gmane.org>
    Tested-by: Shuah Khan <shuah.khan-VXdhtT5mjnY@public.gmane.org>
    Reviewed-by: Donald Dutile <ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
    Reviewed-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
    Signed-off-by: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>


That patch has been present since v3.8 and was only cosmetically
affected by my patch with a shared helper function.  Thanks,

Alex
