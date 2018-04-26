From: Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [Linaro-mm-sig] noveau vs arm dma ops
Date: Thu, 26 Apr 2018 02:24:22 -0700
Message-ID: <20180426092422.GA26825@infradead.org>
References: <20180425054855.GA17038@infradead.org>
	<CAKMK7uEFitkNQrD6cLX5Txe11XhVO=LC4YKJXH=VNdq+CY=DjQ@mail.gmail.com>
	<CAKMK7uFx=KB1vup=WhPCyfUFairKQcRR4BEd7aXaX1Pj-vj3Cw@mail.gmail.com>
	<20180425064335.GB28100@infradead.org> <20180425074151.GA2271@ulmo>
	<20180425085439.GA29996@infradead.org>
	<20180425100429.GR25142@phenom.ffwll.local>
	<20180425153312.GD27076@infradead.org>
	<20180425225443.GQ16141@n2100.armlinux.org.uk>
	<CAKMK7uG9R6paoP4BmvqDVUP_4Db4Dz8MSXeLwUBMYaORa5-kVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAKMK7uG9R6paoP4BmvqDVUP_4Db4Dz8MSXeLwUBMYaORa5-kVw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Daniel Vetter <daniel.vetter-/w4YWyX8dFk@public.gmane.org>
Cc: "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jerome Glisse <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Logan Gunthorpe <logang-OTvnGxWRz7hWk0Htik3J/w@public.gmane.org>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, Linux ARM <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Apr 26, 2018 at 11:20:44AM +0200, Daniel Vetter wrote:
> The above is already what we're implementing in i915, at least
> conceptually (it all boils down to clflush instructions because those
> both invalidate and flush).

The clwb instruction that just writes back dirty cache lines might
be very interesting for the x86 non-coherent dma case.  A lot of
architectures use their equivalent to prepare to to device transfers.

> One architectural guarantee we're exploiting is that prefetched (and
> hence non-dirty) cachelines will never get written back, but dropped
> instead.

And to make this work you'll need exactly this guarantee.
