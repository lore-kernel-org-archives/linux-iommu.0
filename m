From: John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH] of/device: Really only set bus DMA mask when appropriate
Date: Tue, 6 Nov 2018 15:16:11 -0800
Message-ID: <CALAqxLWif1wjRHx5X136sBqdg0KJ8itqXPk9G6NJ70Z_QFavzQ@mail.gmail.com>
References: <b06321ac25a1211e572e650a630e5e1aa9f8173f.1541504601.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <b06321ac25a1211e572e650a630e5e1aa9f8173f.1541504601.git.robin.murphy@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, aaro.koskinen@iki.fi, jean-philippe.brucker@arm.com, iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>, linux-mips@linux-mips.org, hch@lst.de, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

On Tue, Nov 6, 2018 at 3:54 AM, Robin Murphy <robin.murphy@arm.com> wrote:
> of_dma_configure() was *supposed* to be following the same logic as
> acpi_dma_configure() and only setting bus_dma_mask if some range was
> specified by the firmware. However, it seems that subtlety got lost in
> the process of fitting it into the differently-shaped control flow, and
> as a result the force_dma==true case ends up always setting the bus mask
> to the 32-bit default, which is not what anyone wants.
>
> Make sure we only touch it if the DT actually said so.
>
> Fixes: 6c2fb2ea7636 ("of/device: Set bus DMA mask as appropriate")
> Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Reported-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>
> Sorry about that... I guess I only have test setups that either have
> dma-ranges or where a 32-bit bus mask goes unnoticed :(
>
> The Octeon and SMMU issues sound like they're purely down to this, and
> it's probably related to at least one of John's Hikey woes.

Yep! This does seem to resolve the mali bifrost dma address warn-ons I
was seeing, and makes the board seem to function more consistently, so
that's great!

Tested-by: John Stultz <john.stultz@linaro.org>

Though I still find I have to revert "swiotlb: use swiotlb_map_page in
swiotlb_map_sg_attrs" still to boot to UI successfully with AOSP.
Still not sure whats going on there (its sort of soft hangs where some
userland runs ok, but other bits seem to jam up, even console commands
sometimes hang - almost seems like io stalls).

Anyway, thanks so much again for this one!
-john
