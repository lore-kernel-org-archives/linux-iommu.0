From: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH/RFC] iommu/ipmmu-vmsa: Restrict IOMMU Domain Geometry to
	32-bit address space
Date: Thu, 26 Jan 2017 19:17:00 +0900
Message-ID: <CANqRtoQ+5K1_raVjNyexP+zB9FHmhLizxYCoi1rLC9F8FVw4SA@mail.gmail.com>
References: <1485424391-29914-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1485424391-29914-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Cc: linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Geert,

On Thu, Jan 26, 2017 at 6:53 PM, Geert Uytterhoeven
<geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org> wrote:
> Currently, the IPMMU/VMSA driver supports 32-bit I/O Virtual Addresses
> only, and thus sets io_pgtable_cfg.ias = 32.  However, it doesn't force
> a 32-bit IOVA space through the IOMMU Domain Geometry.
>
> Hence if a device (e.g. SYS-DMAC) rightfully configures a 40-bit DMA
> mask, it will still be handed out a 40-bit IOVA, outside the 32-bit IOVA
> space, leading to out-of-bounds accesses of the PGD when mapping the
> IOVA.
>
> Force a 32-bit IOMMU Domain Geometry to fix this.

Nice, thanks!

> Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
> ---
> Should the generic code restrict the geometry based on IAS instead?

Might make sense. Since this is a software policy limited by hardware
it might be good to use as small IOVA space as possible to improve
performance. So selecting IOVA space based on slave device or domain
policy or something similar might be a good thing to do. Not sure how
to tie that into the IOMMU subsystem though...

Thanks!

/ magnus
