From: Srinath Mannam <srinath.mannam@broadcom.com>
Subject: Re: [PATCH v2 2/2] PCI: iproc: Add PCIe 32bit outbound memory configuration
Date: Wed, 13 Feb 2019 10:21:55 +0530
Message-ID: <CABe79T6L5mCc5zoyRUD-bPk7UdxOv_Yz3vyUNYg=Edw-u2mGzQ@mail.gmail.com>
References: <1549342622-9929-1-git-send-email-srinath.mannam@broadcom.com>
 <1549342622-9929-3-git-send-email-srinath.mannam@broadcom.com> <20190212183739.GB918@e107981-ln.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190212183739.GB918@e107981-ln.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Abhishek Shah <abhishek.shah@broadcom.com>, Ray Jui <ray.jui@broadcom.com>
List-Id: iommu@lists.linux-foundation.org

Hi Lorenzo,

Thanks for review, please see my comments below inline.

On Wed, Feb 13, 2019 at 12:07 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Tue, Feb 05, 2019 at 10:27:01AM +0530, Srinath Mannam wrote:
> > Add configuration to support IPROC PCIe host controller outbound memory
> > window mapping with SOC address range inside 4GB boundary, which is 32 bit
> > AXI address.
>
> I do not understand what this means, explain it to me and rewrite the
> commit log accordingly.
>
This is about "I/O regions" addressing given through ranges DT property.
In the current driver "I/O regions" address mapping to corresponding
PCI memory address in controller outbound registers
is supports above 32-bit address.
> What does this solve ? Why do we need this patch or rephrased, what
> is missing in the current driver ?
With this patch, If ranges DT property has below 32-bit I/O regions
address then it will be added in the outbound mapping.
This will help to access I/O region from CPU in 32-bit.
I will update commit log and send next patch set.
Ex:
1. ranges DT property for current driver is,
    ranges = <0x83000000 0x0 0x40000000 0x4 0x00000000 0 0x40000000>;
    I/O region address is 0x400000000
2. ranges DT property with this patch,
    ranges = <0x83000000 0x0 0x42000000 0x0 0x42000000 0 0x2000000>;
    I/O region address is 0x42000000

Regards,
Srinath.
>
> > Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> > Signed-off-by: Abhishek Shah <abhishek.shah@broadcom.com>
> > Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> > Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> > Reviewed-by: Vikram Prakash <vikram.prakash@broadcom.com>
>
> Review tags should be given on public mailing lists, these ones seem
> to come from non-public review cycles in which case you must drop
> them.
>
> >  drivers/pci/controller/pcie-iproc.c | 21 +++++++++++++++++++--
> >  1 file changed, 19 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
> > index b882255..080f142 100644
> > --- a/drivers/pci/controller/pcie-iproc.c
> > +++ b/drivers/pci/controller/pcie-iproc.c
> > @@ -955,8 +955,25 @@ static int iproc_pcie_setup_ob(struct iproc_pcie *pcie, u64 axi_addr,
> >                       resource_size_t window_size =
> >                               ob_map->window_sizes[size_idx] * SZ_1M;
> >
> > -                     if (size < window_size)
> > -                             continue;
> > +                     /*
> > +                      * Keep iterating until we reach the last window and
> > +                      * with the minimal window size at index zero. In this
> > +                      * case, we take a compromise by mapping it using the
> > +                      * minimum window size that can be supported
>
> See above, I do not understand clearly what this means.
>
> Lorenzo
>
> > +                      */
> > +                     if (size < window_size) {
> > +                             if (size_idx > 0 || window_idx > 0)
> > +                                     continue;
> > +
> > +                             /*
> > +                              * For the corner case of reaching the minimal
> > +                              * window size that can be supported on the
> > +                              * last window
> > +                              */
> > +                             axi_addr = ALIGN_DOWN(axi_addr, window_size);
> > +                             pci_addr = ALIGN_DOWN(pci_addr, window_size);
> > +                             size = window_size;
> > +                     }
> >
> >                       if (!IS_ALIGNED(axi_addr, window_size) ||
> >                           !IS_ALIGNED(pci_addr, window_size)) {
> > --
> > 2.7.4
> >
