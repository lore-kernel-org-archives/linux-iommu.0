From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] iommu: Add a quirk for ARM Mali midgard MMU
Date: Tue, 26 Feb 2019 14:05:09 -0600
Message-ID: <CAL_JsqJ857qSQTQ9WFCrPQxNsZ=6uB-PPwCY7cXmkcsP2NA=YQ@mail.gmail.com>
References: <20190226181716.14556-1-robh@kernel.org>
 <efd64b34-a05e-1d34-c974-280e0da4807b@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <efd64b34-a05e-1d34-c974-280e0da4807b@arm.com>
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
Cc: Joerg Roedel <joro@8bytes.org>, Linux IOMMU <iommu@lists.linux-foundation.org>, Will Deacon <will.deacon@arm.com>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>
List-Id: iommu@lists.linux-foundation.org

On Tue, Feb 26, 2019 at 1:25 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> Hi Rob,
>
> On 26/02/2019 18:17, Rob Herring wrote:
> > ARM Mali midgard GPUs have a few differences from standard 64-bit
> > stage 1 page tables.
> >
> > The 3rd level page entry bits are 0x1 instead of 0x3 for page entries.
> >
> > The access flags are not read-only and unprivileged, but read and write.
> > This is similar to stage 2 entries, but the memory attributes field matches
> > stage 1 being an index.
> >
> > The nG bit is also not set by the vendor driver, but that one doesn't
> > seem to matter.
> >
> > Add a quirk to handle all of these differences.
>
>  From the look of these changes, this isn't a quirk but a distinct
> format. AFAICS from the mali_kbase driver, this must be "LPAE mode"
> rather than "AArch64 mode", so it seems unlikely that it really supports
> the full VMSAv8 gamut of granules, address sizes, and page sizes that
> this patch will happily let through.

Right, but the page size bitmap and the in and out address sizes in
the config struct should be enough to restrict those.

What do you propose? Add another init function which hardcodes all
those or add some checks of allowed settings?

Rob
