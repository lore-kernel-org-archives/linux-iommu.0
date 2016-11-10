From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: Summary of LPC guest MSI discussion in Santa Fe
Date: Thu, 10 Nov 2016 16:18:48 +0100
Message-ID: <20161110151848.GE2078@8bytes.org>
References: <1478209178-3009-1-git-send-email-eric.auger@redhat.com>
	<20161103220205.37715b49@t450s.home>
	<20161108024559.GA20591@arm.com> <20161108202922.GC15676@cbox>
	<20161108163508.1bcae0c2@t450s.home> <58228F71.6020108@redhat.com>
	<20161109170326.GG17771@arm.com> <582371FB.2040808@redhat.com>
	<e59e9a17-e943-a227-5ea4-d028232155a8@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <e59e9a17-e943-a227-5ea4-d028232155a8-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: arnd-r2nGTMty4D4@public.gmane.org, drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, dwmw-vV1OtcyAfmbQXOPxS62xeg@public.gmane.org, Christoffer Dall <christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Nov 09, 2016 at 08:11:16PM +0000, Robin Murphy wrote:
> When we *are* in full control of the IOVA space, we just carve out what
> we can find as best we can - see iova_reserve_pci_windows() in
> dma-iommu.c, which isn't really all that different to what x86 does
> (e.g. init_reserved_iova_ranges() in amd-iommu.c).

Yeah, that code was actually written with a look at what the Intel
driver does. I don't really like that it goes over all resources and
reserves them individually (not only because it is not hotplug-safe).

I have to check whether there is a nice and generic way to find out the
root-bridge windows and just reserve them in the iova-space. That would
be easier and more reliable.


	Joerg
