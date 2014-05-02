From: Jerry Hoemann <jerry.hoemann-VXdhtT5mjnY@public.gmane.org>
Subject: Re: [PATCH 0/8] iommu/vt-d: Fix crash dump failure caused by legacy
	DMA/IO
Date: Fri, 2 May 2014 14:13:07 -0600
Message-ID: <20140502201307.GA23419@anatevka.fc.hp.com>
References: <1398386198-19304-1-git-send-email-bill.sumner@hp.com>
	<1398854973.12733.23.camel@i7.infradead.org>
Reply-To: Jerry.Hoemann-VXdhtT5mjnY@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1398854973.12733.23.camel-W2I5cNIroUsVm/YvaOjsyQ@public.gmane.org>
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
Cc: bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, doug.hatch-VXdhtT5mjnY@public.gmane.org, ishii.hironobu-+CUm20s59erQFUHtdCDX3A@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, zhenhua-VXdhtT5mjnY@public.gmane.org, Bill Sumner <bill.sumner-VXdhtT5mjnY@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Apr 30, 2014 at 11:49:33AM +0100, David Woodhouse wrote:

Hi David,

As you may know,  Bill has retired and I am picking up this work.
I am still coming up to speed in this area so my goal is to understand
your concerns and research them as I dig through code and specs.

My apologizes for the delay in replying and for our missing your
earlier questions.


> On Thu, 2014-04-24 at 18:36 -0600, Bill Sumner wrote:
> > 
> > This patch set modifies the behavior of the Intel iommu in the crashdump kernel: 
> > 1. to accept the iommu hardware in an active state,
> > 2. to leave the current translations in-place so that legacy DMA will continue
> >    using its current buffers until the device drivers in the crashdump kernel
> >    initialize and initialize their devices,
> > 3. to use different portions of the iova address ranges for the device drivers
> >    in the crashdump kernel than the iova ranges that were in-use at the time
> >    of the panic.  
> 
> There could be all kinds of existing mappings in the DMA page tables,
> and I'm not sure it's safe to preserve them. What prevents the crashdump
> kernel from trying to use any of the physical pages which are
> accessible, and which could thus be corrupted by stray DMA?

In kdump, we switch to, and execute from the capture kernel.  (AKA 2nd kernel,
crash kernel.)  This is a separate distinct instance of linux.  One of
the intents of this switch is to (kdump.txt):

    "This ensures that ongoing Direct Memory Access
(DMA) from the system kernel does not corrupt the dump-capture kernel.
The kexec -p command loads the dump-capture kernel into this reserved
memory."

As capture kernel is allocated early in boot, we shouldn't have DMA
targeted to it once the capture kernel is loaded.

Now,  the capture kernel will try to access 1st kernel memory via /proc/vmcore
after it boots and runs makedumpfile.   Is it this access that you
are concerned with?



> 
> In fact, the old kernel could even have set up 1:1 passthrough mappings
> for some devices, which would then be able to DMA *anywhere*. Surely we
> need to prevent that?

>From prior patch version comments,  I know Bill was aware of the
issue of pass-through, but don't know to what extent he tested with
the feature enabled.  E.g. in Jan and prior versions he stated he
had not tested w/ pass through.  He subsequently dropped this statement.

The approach of the patch is to just allow the outstanding DMA
to complete.  Assuming the targeted address of the pass through
was sane,  does this differ greatly from the non pass through case?
Now, if the DMA was truly going to random places (like the capture
kernel itself)  I'm not sure what we would do.  Suggestions?


> 
> After the last round of this patchset, we discussed a potential
> improvement where you point every virtual bus address at the *same*
> physical scratch page.
> 
> That way, we allow the "rogue" DMA to continue to the same virtual bus
> addresses, but it can only ever affect one piece of physical memory and
> can't have detrimental effects elsewhere.
> 
> Was that option considered and discounted for some reason? It seems like
> it would make sense...

I don't know if this was considered.

I will need time to go through code and the spec to understand
implications better.

Thanks

Jerry


-- 

----------------------------------------------------------------------------
Jerry Hoemann            Software Engineer              Hewlett-Packard

3404 E Harmony Rd. MS 57                        phone:  (970) 898-1022
Ft. Collins, CO 80528                           FAX:    (970) 898-XXXX
                                                email:  jerry.hoemann-VXdhtT5mjnY@public.gmane.org
----------------------------------------------------------------------------
