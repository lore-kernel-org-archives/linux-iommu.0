From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Summary of LPC guest MSI discussion in Santa Fe
Date: Wed, 9 Nov 2016 15:17:09 -0700
Message-ID: <20161109151709.74927f83@t450s.home>
References: <1478209178-3009-1-git-send-email-eric.auger@redhat.com>
	<20161103220205.37715b49@t450s.home>
	<20161108024559.GA20591@arm.com> <20161108202922.GC15676@cbox>
	<20161108163508.1bcae0c2@t450s.home> <58228F71.6020108@redhat.com>
	<20161109170326.GG17771@arm.com> <582371FB.2040808@redhat.com>
	<20161109192303.GD15676@cbox> <20161109203145.GO17771@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20161109203145.GO17771-5wv7dgnIgG8@public.gmane.org>
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

On Wed, 9 Nov 2016 20:31:45 +0000
Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> On Wed, Nov 09, 2016 at 08:23:03PM +0100, Christoffer Dall wrote:
> > 
> > (I suppose it's technically possible to get around this issue by letting
> > QEMU place RAM wherever it wants but tell the guest to never use a
> > particular subset of its RAM for DMA, because that would conflict with
> > the doorbell IOVA or be seen as p2p transactions.  But I think we all
> > probably agree that it's a disgusting idea.)  
> 
> Disgusting, yes, but Ben's idea of hotplugging on the host controller with
> firmware tables describing the reserved regions is something that we could
> do in the distant future. In the meantime, I don't think that VFIO should
> explicitly reject overlapping mappings if userspace asks for them.

I'm confused by the last sentence here, rejecting user mappings that
overlap reserved ranges, such as MSI doorbell pages, is exactly how
we'd reject hot-adding a device when we meet such a conflict.  If we
don't reject such a mapping, we're knowingly creating a situation that
potentially leads to data loss.  Minimally, QEMU would need to know
about the reserved region, map around it through VFIO, and take
responsibility (somehow) for making sure that region is never used for
DMA.  Thanks,

Alex
