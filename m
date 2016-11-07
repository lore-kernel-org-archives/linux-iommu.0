From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH 2/2] swiotlb: Add swiotlb=nobounce debug option
Date: Mon, 7 Nov 2016 19:57:11 +0100
Message-ID: <CAMuHMdXFCVP2L-1jdzxbA6JD2Pm4accCyc57fFXt=g7VgAv53Q@mail.gmail.com>
References: <1477928704-10611-1-git-send-email-geert+renesas@glider.be>
	<1477928704-10611-3-git-send-email-geert+renesas@glider.be>
	<20161031175252.GA6952@char.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20161031175252.GA6952-he5eyhs8q0BAdwtm4QZOy9BPR1lH4CV8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Konrad,

On Mon, Oct 31, 2016 at 6:52 PM, Konrad Rzeszutek Wilk
<konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org> wrote:
> On Mon, Oct 31, 2016 at 04:45:04PM +0100, Geert Uytterhoeven wrote:
>> On architectures like arm64, swiotlb is tied intimately to the core
>> architecture DMA support. In addition, ZONE_DMA cannot be disabled.
>>
>> To aid debugging and catch devices not supporting DMA to memory outside
>> the 32-bit address space, add a kernel command line option
>> "swiotlb=nobounce", which disables the use of bounce buffers.
>> If specified, trying to map memory that cannot be used with DMA will
>> fail, and a warning will be printed (rate-limited).
>
> I would make the 'swiotlb_force' an enum. And then instead of this
> being 'nobounce' just do the inverse of 'force', that is the
> 'noforce' would trigger this no bounce effect.
>
> So:
>
> enum {
>         NORMAL,         /* Default - depending on the hardware DMA mask and such. */
>         FORCE,          /* swiotlb=force */
>         NO_FORCE,       /* swiotlb=noforce */

Fine for me, but swiotlb_force is exported to platform code. Hence all users
should be updated?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
