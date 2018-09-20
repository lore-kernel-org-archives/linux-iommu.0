From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: [PATCH] kernel/dma: Fix panic caused by passing cma to command
	line
Date: Thu, 20 Sep 2018 08:54:30 +0200
Message-ID: <20180920065430.GA13761@lst.de>
References: <CGME20180917032603epcas4p4da3674e558c4704622f58b133e7fe5ce@epcas4p4.samsung.com>
	<1537154660-296740-1-git-send-email-zhe.he@windriver.com>
	<20180918092834eucas1p1ebdbc3051a7ca8bbacec26b955689784~VdHnT_5yZ0331203312eucas1p1U@eucas1p1.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180918092834eucas1p1ebdbc3051a7ca8bbacec26b955689784~VdHnT_5yZ0331203312eucas1p1U-MHMrYXj8g+pqW5MlFJXMulaTQe2KTcn/@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, zhe.he-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Sep 18, 2018 at 11:28:33AM +0200, Marek Szyprowski wrote:
> Hi
> 
> On 2018-09-17 05:24, zhe.he-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org wrote:
> > From: He Zhe <zhe.he-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
> >
> > early_cma does not check input argument before passing it to
> > simple_strtoull. The argument would be a NULL pointer if "cma", without
> > its value, is set in command line and thus causes the following panic.
> >
> > PANIC: early exception 0xe3 IP 10:ffffffffa3e9db8d error 0 cr2 0x0
> > [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.19.0-rc3-yocto-standard+ #7
> > [    0.000000] RIP: 0010:_parse_integer_fixup_radix+0xd/0x70
> > ...
> > [    0.000000] Call Trace:
> > [    0.000000]  simple_strtoull+0x29/0x70
> > [    0.000000]  memparse+0x26/0x90
> > [    0.000000]  early_cma+0x17/0x6a
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
> > Signed-off-by: He Zhe <zhe.he-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
> > Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > Cc: hch-jcswGhMUV9g@public.gmane.org
> > Cc: m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
> > Cc: robin.murphy-5wv7dgnIgG8@public.gmane.org
> 
> Thanks for the fix.
> 
> Reviewed-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

Thanks, added to the dma-mapping tree.
