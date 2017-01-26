From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH/RFC] iommu/ipmmu-vmsa: Restrict IOMMU Domain Geometry to
	32-bit address space
Date: Thu, 26 Jan 2017 14:28:14 +0100
Message-ID: <CAMuHMdWGdQ9KfwQ+fMyM73BpvhJdqD6SVXA+02tZwYWtaJaZZg@mail.gmail.com>
References: <1485424391-29914-1-git-send-email-geert+renesas@glider.be>
	<78112a99-dee0-c163-1d16-68a17f64f701@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <78112a99-dee0-c163-1d16-68a17f64f701-5wv7dgnIgG8@public.gmane.org>
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
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

On Thu, Jan 26, 2017 at 12:23 PM, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
> On 26/01/17 09:53, Geert Uytterhoeven wrote:
>> Currently, the IPMMU/VMSA driver supports 32-bit I/O Virtual Addresses
>> only, and thus sets io_pgtable_cfg.ias = 32.  However, it doesn't force
>> a 32-bit IOVA space through the IOMMU Domain Geometry.
>>
>> Hence if a device (e.g. SYS-DMAC) rightfully configures a 40-bit DMA
>> mask, it will still be handed out a 40-bit IOVA, outside the 32-bit IOVA
>> space, leading to out-of-bounds accesses of the PGD when mapping the
>> IOVA.
>>
>> Force a 32-bit IOMMU Domain Geometry to fix this.
>
> Reviewed-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>

Thanks!

>> Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
>> ---
>> Should the generic code restrict the geometry based on IAS instead?
>
> Which generic code? IAS is specific to the io-pgtable library (well,
> really it's an ARM-SMMU-ism, but "input address size" is a fairly
> portable concept), but io-pgtable is just factored-out driver helper
> code and doesn't know anything about iommu_domains and the IOMMU API.
> Conversely, the IOMMU API core and kernel code beyond also know nothing
> about io-pgtable internals - in fact the domain geometry *is* how the
> IOMMU driver communicates its configured address space size to the
> outside world.

OK, so the IPMMU/VMSA does have to take care of it itself.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
