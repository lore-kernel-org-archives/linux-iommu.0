From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
Date: Tue, 29 Jan 2019 22:26:57 -0500
Message-ID: <20190129222021-mutt-send-email-mst@kernel.org>
References: <87zhrj8kcp.fsf@morokweng.localdomain>
 <87womn8inf.fsf@morokweng.localdomain>
 <20190129134750-mutt-send-email-mst@kernel.org>
 <6c68f7f7-1b28-6eba-9b8b-2c32efac9701@redhat.com>
 <20190129213137-mutt-send-email-mst@kernel.org>
 <94ab8910-594e-a056-c799-5536d8ae2b0e@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <94ab8910-594e-a056-c799-5536d8ae2b0e@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Wang <jasowang@redhat.com>
Cc: Thiago Jung Bauermann <bauerman@linux.ibm.com>, virtualization@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, David Gibson <david@gibson.dropbear.id.au>, Alexey Kardashevskiy <aik@linux.ibm.com>, Paul Mackerras <paulus@ozlabs.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ram Pai <linuxram@us.ibm.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jan 30, 2019 at 11:05:42AM +0800, Jason Wang wrote:
> 
> On 2019/1/30 上午10:36, Michael S. Tsirkin wrote:
> > On Wed, Jan 30, 2019 at 10:24:01AM +0800, Jason Wang wrote:
> > > On 2019/1/30 上午3:02, Michael S. Tsirkin wrote:
> > > > On Tue, Jan 29, 2019 at 03:42:44PM -0200, Thiago Jung Bauermann wrote:
> > > > > Fixing address of powerpc mailing list.
> > > > > 
> > > > > Thiago Jung Bauermann <bauerman@linux.ibm.com> writes:
> > > > > 
> > > > > > Hello,
> > > > > > 
> > > > > > With Christoph's rework of the DMA API that recently landed, the patch
> > > > > > below is the only change needed in virtio to make it work in a POWER
> > > > > > secure guest under the ultravisor.
> > > > > > 
> > > > > > The other change we need (making sure the device's dma_map_ops is NULL
> > > > > > so that the dma-direct/swiotlb code is used) can be made in
> > > > > > powerpc-specific code.
> > > > > > 
> > > > > > Of course, I also have patches (soon to be posted as RFC) which hook up
> > > > > > <linux/mem_encrypt.h> to the powerpc secure guest support code.
> > > > > > 
> > > > > > What do you think?
> > > > > > 
> > > > > >   From d0629a36a75c678b4a72b853f8f7f8c17eedd6b3 Mon Sep 17 00:00:00 2001
> > > > > > From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> > > > > > Date: Thu, 24 Jan 2019 22:08:02 -0200
> > > > > > Subject: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
> > > > > > 
> > > > > > The host can't access the guest memory when it's encrypted, so using
> > > > > > regular memory pages for the ring isn't an option. Go through the DMA API.
> > > > > > 
> > > > > > Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> > > > Well I think this will come back to bite us (witness xen which is now
> > > > reworking precisely this path - but at least they aren't to blame, xen
> > > > came before ACCESS_PLATFORM).
> > > > 
> > > > I also still think the right thing would have been to set
> > > > ACCESS_PLATFORM for all systems where device can't access all memory.
> > > > 
> > > > But I also think I don't have the energy to argue about power secure
> > > > guest anymore.  So be it for power secure guest since the involved
> > > > engineers disagree with me.  Hey I've been wrong in the past ;).
> > > > 
> > > > But the name "sev_active" makes me scared because at least AMD guys who
> > > > were doing the sensible thing and setting ACCESS_PLATFORM (unless I'm
> > > > wrong? I reemember distinctly that's so) will likely be affected too.
> > > > We don't want that.
> > > > 
> > > > So let's find a way to make sure it's just power secure guest for now
> > > > pls.
> > > > 
> > > > I also think we should add a dma_api near features under virtio_device
> > > > such that these hacks can move off data path.
> > > 
> > > Anyway the current Xen code is conflict with spec which said:
> > > 
> > > "If this feature bit is set to 0, then the device has same access to memory
> > > addresses supplied to it as the driver has. In particular, the device will
> > > always use physical addresses matching addresses used by the driver
> > > (typically meaning physical addresses used by the CPU) and not translated
> > > further, and can access any address supplied to it by the driver. When
> > > clear, this overrides any platform-specific description of whether device
> > > access is limited or translated in any way, e.g. whether an IOMMU may be
> > > present. "
> > > 
> > > I wonder how much value that the above description can give us. It's kind of
> > > odd that the behavior of "when the feature is not negotiated" is described
> > > in the spec.
> > Hmm what's odd about it? We need to describe the behaviour is all cases.
> 
> 
> Well, try to limit the behavior of 'legacy' driver is tricky or even
> impossible. Xen is an exact example for this.

So don't. Xen got grand-fathered in because when that came
along we thought it's a one off thing. Was easier to just
add that as a special case. But really >99% of people
have a hypervisor device with direct guest memory access.
All else is esoterica.

> 
> > 
> > > Personally I think we can remove the above and then we can
> > > switch to use DMA API unconditionally in guest driver. It may have single
> > > digit regression probably, we can try to overcome it.
> > > 
> > > Thanks
> > This has been discussed ad nauseum. virtio is all about compatibility.
> > Losing a couple of lines of code isn't worth breaking working setups.
> > People that want "just use DMA API no tricks" now have the option.
> > Setting a flag in a feature bit map is literally a single line
> > of code in the hypervisor. So stop pushing for breaking working
> > legacy setups and just fix it in the right place.
> 
> 
> I may miss soemthing, which kind of legacy setup is broken? Do you mean
> using virtio without IOMMU_PLATFORM on platform with IOMMU? We actually
> unbreak this setup.
> 
> Thanks


Legacy setups by definition are working setups.  The rules are pretty
simple. By default virtio == full guest memory access.
If your access is limited or translated in any way, you use a device
with ACCESS_PLATFORM. When in doubt use ACCESS_PLATFORM.

Xen was there before, and it does not have a flag and it still
wants ACCESS_PLATFORM semantics without setting ACCESS_PLATFORM
sometimes. So we don't want to break existing setups,
and we make an exception in that case.
I don't really see any good reason to make more exceptions.

Nor IMHO should we trust all platform people to know about virtio
and have special kind of DMA API just for virtio.


> 
> > 
> > > > By the way could you please respond about virtio-iommu and
> > > > why there's no support for ACCESS_PLATFORM on power?
> > > > 
> > > > I have Cc'd you on these discussions.
> > > > 
> > > > 
> > > > Thanks!
> > > > 
> > > > 
> > > > > > ---
> > > > > >    drivers/virtio/virtio_ring.c | 5 ++++-
> > > > > >    1 file changed, 4 insertions(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > > > > index cd7e755484e3..321a27075380 100644
> > > > > > --- a/drivers/virtio/virtio_ring.c
> > > > > > +++ b/drivers/virtio/virtio_ring.c
> > > > > > @@ -259,8 +259,11 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
> > > > > >    	 * not work without an even larger kludge.  Instead, enable
> > > > > >    	 * the DMA API if we're a Xen guest, which at least allows
> > > > > >    	 * all of the sensible Xen configurations to work correctly.
> > > > > > +	 *
> > > > > > +	 * Also, if guest memory is encrypted the host can't access
> > > > > > +	 * it directly. In this case, we'll need to use the DMA API.
> > > > > >    	 */
> > > > > > -	if (xen_domain())
> > > > > > +	if (xen_domain() || sev_active())
> > > > > >    		return true;
> > > > > > 
> > > > > >    	return false;
> > > > > -- 
> > > > > Thiago Jung Bauermann
> > > > > IBM Linux Technology Center
