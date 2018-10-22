From: Konrad Rzeszutek Wilk <konrad@darnok.org>
Subject: Re: [PATCH] kernel/dma: Fix panic caused by passing swiotlb to
 command line
Date: Mon, 22 Oct 2018 15:29:23 -0400
Message-ID: <20181022192921.GA20677@dhcp-10-175-29-12.vpn.oracle.com>
References: <1537154831-447363-1-git-send-email-zhe.he@windriver.com>
 <c3536f4f-9bde-4f7f-a180-aa569d4e786d@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c3536f4f-9bde-4f7f-a180-aa569d4e786d@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: He Zhe <zhe.he@windriver.com>
Cc: konrad.wilk@oracle.com, hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Sat, Sep 22, 2018 at 08:56:58PM +0800, He Zhe wrote:
> May I have your input?

Alternatively would it make more sense for it to assume some default
value?
> 
> Thanks,
> Zhe
> 
> On 2018年09月17日 11:27, zhe.he@windriver.com wrote:
> > From: He Zhe <zhe.he@windriver.com>
> >
> > setup_io_tlb_npages does not check input argument before passing it
> > to isdigit. The argument would be a NULL pointer if "swiotlb", without
> > its value, is set in command line and thus causes the following panic.
> >
> > PANIC: early exception 0xe3 IP 10:ffffffffbb9b8e9f error 0 cr2 0x0
> > [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.19.0-rc3-yocto-standard+ #9
> > [    0.000000] RIP: 0010:setup_io_tlb_npages+0xf/0x95
> > ...
> > [    0.000000] Call Trace:
> > [    0.000000]  do_early_param+0x57/0x8e
> > [    0.000000]  parse_args+0x208/0x320
> > [    0.000000]  ? rdinit_setup+0x30/0x30
> > [    0.000000]  parse_early_options+0x29/0x2d
> > [    0.000000]  ? rdinit_setup+0x30/0x30
> > [    0.000000]  parse_early_param+0x36/0x4d
> > [    0.000000]  setup_arch+0x336/0x99e
> > [    0.000000]  start_kernel+0x6f/0x4e6
> > [    0.000000]  x86_64_start_reservations+0x24/0x26
> > [    0.000000]  x86_64_start_kernel+0x6f/0x72
> > [    0.000000]  secondary_startup_64+0xa4/0xb0
> >
> > This patch adds a check to prevent the panic.
> >
> > Signed-off-by: He Zhe <zhe.he@windriver.com>
> > Cc: stable@vger.kernel.org
> > Cc: konrad.wilk@oracle.com
> > Cc: hch@lst.de
> > Cc: m.szyprowski@samsung.com
> > Cc: robin.murphy@arm.com
> > ---
> >  kernel/dma/swiotlb.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> > index 4f8a6db..46fc34e 100644
> > --- a/kernel/dma/swiotlb.c
> > +++ b/kernel/dma/swiotlb.c
> > @@ -109,6 +109,11 @@ static int late_alloc;
> >  static int __init
> >  setup_io_tlb_npages(char *str)
> >  {
> > +	if (!str) {
> > +		pr_err("Config string not provided\n");
> > +		return -EINVAL;
> > +	}
> > +
> >  	if (isdigit(*str)) {
> >  		io_tlb_nslabs = simple_strtoul(str, &str, 0);
> >  		/* avoid tail segment of size < IO_TLB_SEGSIZE */
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
