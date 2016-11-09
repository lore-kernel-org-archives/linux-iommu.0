From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Summary of LPC guest MSI discussion in Santa Fe
Date: Wed, 9 Nov 2016 16:59:57 -0700
Message-ID: <20161109165957.62c1eb61@t450s.home>
References: <20161108202922.GC15676@cbox> <20161108163508.1bcae0c2@t450s.home>
	<58228F71.6020108@redhat.com> <20161109170326.GG17771@arm.com>
	<582371FB.2040808@redhat.com> <20161109192303.GD15676@cbox>
	<20161109203145.GO17771@arm.com>
	<20161109151709.74927f83@t450s.home>
	<20161109222522.GS17771@arm.com>
	<20161109162458.39594fdb@t450s.home>
	<20161109233847.GT17771@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20161109233847.GT17771-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, dwmw-vV1OtcyAfmbQXOPxS62xeg@public.gmane.org, Christoffer Dall <christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, 9 Nov 2016 23:38:50 +0000
Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:

> On Wed, Nov 09, 2016 at 04:24:58PM -0700, Alex Williamson wrote:
> > On Wed, 9 Nov 2016 22:25:22 +0000
> > Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> >   
> > > On Wed, Nov 09, 2016 at 03:17:09PM -0700, Alex Williamson wrote:  
> > > > On Wed, 9 Nov 2016 20:31:45 +0000
> > > > Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:    
> > > > > On Wed, Nov 09, 2016 at 08:23:03PM +0100, Christoffer Dall wrote:    
> > > > > > 
> > > > > > (I suppose it's technically possible to get around this issue by letting
> > > > > > QEMU place RAM wherever it wants but tell the guest to never use a
> > > > > > particular subset of its RAM for DMA, because that would conflict with
> > > > > > the doorbell IOVA or be seen as p2p transactions.  But I think we all
> > > > > > probably agree that it's a disgusting idea.)      
> > > > > 
> > > > > Disgusting, yes, but Ben's idea of hotplugging on the host controller with
> > > > > firmware tables describing the reserved regions is something that we could
> > > > > do in the distant future. In the meantime, I don't think that VFIO should
> > > > > explicitly reject overlapping mappings if userspace asks for them.    
> > > > 
> > > > I'm confused by the last sentence here, rejecting user mappings that
> > > > overlap reserved ranges, such as MSI doorbell pages, is exactly how
> > > > we'd reject hot-adding a device when we meet such a conflict.  If we
> > > > don't reject such a mapping, we're knowingly creating a situation that
> > > > potentially leads to data loss.  Minimally, QEMU would need to know
> > > > about the reserved region, map around it through VFIO, and take
> > > > responsibility (somehow) for making sure that region is never used for
> > > > DMA.  Thanks,    
> > > 
> > > Yes, but my point is that it should be up to QEMU to abort the hotplug, not
> > > the host kernel, since there may be ways in which a guest can tolerate the
> > > overlapping region (e.g. by avoiding that range of memory for DMA).  
> > 
> > The VFIO_IOMMU_MAP_DMA ioctl is a contract, the user ask to map a range
> > of IOVAs to a range of virtual addresses for a given device.  If VFIO
> > cannot reasonably fulfill that contract, it must fail.  It's up to QEMU
> > how to manage the hotplug and what memory regions it asks VFIO to map
> > for a device, but VFIO must reject mappings that it (or the SMMU by
> > virtue of using the IOMMU API) know to overlap reserved ranges.  So I
> > still disagree with the referenced statement.  Thanks,  
> 
> I think that's a pity. Not only does it mean that both QEMU and the kernel
> have more work to do (the former has to carve up its mapping requests,
> whilst the latter has to check that it is indeed doing this), but it also
> precludes the use of hugepage mappings on the IOMMU because of reserved
> regions. For example, a 4k hole someplace may mean we can't put down 1GB
> table entries for the guest memory in the SMMU.
> 
> All this seems to do is add complexity and decrease performance. For what?
> QEMU has to go read the reserved regions from someplace anyway. It's also
> the way that VFIO works *today* on arm64 wrt reserved regions, it just has
> no way to identify those holes at present.

Sure, that sucks, but how is the alternative even an option?  The user
asked to map something, we can't, if we allow that to happen now it's a
bug.  Put the MSI doorbells somewhere that this won't be an issue.  If
the platform has it fixed somewhere that this is an issue, don't use
that platform.  The correctness of the interface is more important than
catering to a poorly designed system layout IMO.  Thanks,

Alex
