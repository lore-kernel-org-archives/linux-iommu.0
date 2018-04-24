From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: [PATCH 11/12] swiotlb: move the SWIOTLB config symbol to
	lib/Kconfig
Date: Tue, 24 Apr 2018 09:56:45 +0200
Message-ID: <20180424075645.GA19379@lst.de>
References: <20180423170419.20330-1-hch@lst.de>
	<20180423170419.20330-12-hch@lst.de>
	<20180423235205.GH16141@n2100.armlinux.org.uk>
	<20180424065549.GA18468@lst.de>
	<20180424074726.GI16141@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180424074726.GI16141-l+eeeJia6m9URfEZ8mYm6t73F7V6hmMc@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-block-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Apr 24, 2018 at 08:47:27AM +0100, Russell King - ARM Linux wrote:
> Therefore, the default state for SWIOTLB and hence NEED_SG_DMA_LENGTH
> becomes 'y' on ARM, and any defconfig file that does not mention SWIOTLB
> explicitly ends up with both these enabled.

Indeed, sorry.

> It does look a bit weird though - patch 10 arranged stuff so that we
> didn't end up with SWIOTLB always enabled, but this patch reintroduces
> that with the allowance that the user can disable if so desired.

I am not very happy with that patch, but I have a hard time coming
up with something saner.

Bascially x86_64 and mips/loongson default to SWIOTLB=y but allow to
deselect it, powerpc has it optional without any real dependency
and defaults to n and everyone just selects it otherwise.

I suspect the right thing is to just have it always one for x86_64
and loongson and have a ppc-specific option to enable it on powerpc
so that we can always use select statements.  I'll do that for the
next round.
