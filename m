From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v6 6/8] dma-mapping: detect and configure IOMMU in
	of_dma_configure
Date: Mon, 15 Dec 2014 17:10:13 +0000
Message-ID: <20141215171013.GO20738@arm.com>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
	<20141210150853.GH23639@arm.com> <6860089.2Ca399bIPK@avalon>
	<1427076.5uVd9K6nak@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1427076.5uVd9K6nak@avalon>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Sun, Dec 14, 2014 at 03:59:38PM +0000, Laurent Pinchart wrote:
> On Sunday 14 December 2014 17:49:34 Laurent Pinchart wrote:
> > On Wednesday 10 December 2014 15:08:53 Will Deacon wrote:
> > > On Wed, Dec 10, 2014 at 02:52:56PM +0000, Rob Clark wrote:
> > > > so, what is the way for a driver that explicitly wants to manage it's
> > > > own device virtual address space to opt out of this?  I suspect that
> > > > won't be the common case, but for a gpu, if dma layer all of a sudden
> > > > thinks it is in control of the gpu's virtual address space, things are
> > > > going to end in tears..
> > > 
> > > I think you'll need to detach from the DMA domain, then have the driver
> > > manage everything itself. As you say, it's not the common case, so you
> > > may need to add some hooks for detaching from the default domain and
> > > swizzling your DMA ops.
> > 
> > I'm wondering if it's such an exotic case after all. I can see two reasons
> > not to use the default domain. In addition to special requirements coming
> > from the bus master side, the IOMMU itself might not support one domain per
> > bus master (I'm of course raising the issue from a very selfish Renesas
> > IPMMU point of view).
> > 
> > In that case the IOMMU driver can still detach the device from the default
> > domain in the .of_xlate() callback and attach it to its private domain.
> 
> I actually spoke too fast, the .of_xlate() callback is called before 
> arch_setup_dma_ops(). The operation could be performed in the .add_device() 
> callback. I'm having trouble understanding how you envision .add_device, 
> .remove_device and .of_xlate working together in the DT case. Could you please 
> detail what you think each callback should be responsible of exactly ?

I think the sequence goes something like:


1: of_iommu_init: early initialisiation of IOMMU driver, stashes its private
                  data via of_iommu_set_ops

2: ->of_xlate: called for each master upstream of the IOMMU before the master
               has probed. Passes back the DT info, which can be used to
	       get hold of the private data from earlier. Per-device data
	       can be stored in archdata.iommu (but I'd like to change this,
	       see below).

3. ->domain_init: called from dma-mapping to create default domain (this
                  should be replaced by ->get_default_domain in future).

3. ->attach_device: called by dma-mapping to attach device to the default
                    domain

4. ->add_device: called just before the master is probed


Now, the thing missing here is the instantiation of iommu_groups. They
require a fully initialised struct device because of some sysfs magic
that goes on in iommu_group_add_device. The questions I have are:

  - How should we describe/create iommu_groups for platform devices?

  - When do the groups actually need to be initialised (currently likely
    to be in add_device).

Will
