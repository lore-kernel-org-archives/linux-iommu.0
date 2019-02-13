From: Srinath Mannam <srinath.mannam@broadcom.com>
Subject: Re: [PATCH v2 1/2] PCI: iproc: Add CRS check in config read
Date: Wed, 13 Feb 2019 09:27:20 +0530
Message-ID: <CABe79T7prLa-hPWOfESPYabA_HNvdcc52ztkNJfyLoLv+w7i0A@mail.gmail.com>
References: <1549342622-9929-1-git-send-email-srinath.mannam@broadcom.com>
 <1549342622-9929-2-git-send-email-srinath.mannam@broadcom.com> <20190212181208.GA918@e107981-ln.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190212181208.GA918@e107981-ln.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

Hi Lorenzo,

Thanks for review, please see my comments below inline.

On Tue, Feb 12, 2019 at 11:42 PM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Tue, Feb 05, 2019 at 10:27:00AM +0530, Srinath Mannam wrote:
> > In the current implementation, config read output data 0xffff0001 is
> > assumed as CRS completion. But sometimes 0xffff0001 can be a valid data.
> >
> > IPROC PCIe host controller has a register to show config read request
> > status flags like SC, UR, CRS and CA. So that extra check is added to
> > confirm the CRS using status flags before reissue config read.
> >
> > Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> > Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> > ---
> >  drivers/pci/controller/pcie-iproc.c | 23 +++++++++++++++++++++--
> >  1 file changed, 21 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
> > index c20fd6b..b882255 100644
> > --- a/drivers/pci/controller/pcie-iproc.c
> > +++ b/drivers/pci/controller/pcie-iproc.c
> > @@ -60,6 +60,10 @@
> >  #define APB_ERR_EN_SHIFT             0
> >  #define APB_ERR_EN                   BIT(APB_ERR_EN_SHIFT)
> >
> > +#define CFG_RD_SUCCESS                       0
> > +#define CFG_RD_UR                    1
> > +#define CFG_RD_CRS                   2
> > +#define CFG_RD_CA                    3
> >  #define CFG_RETRY_STATUS             0xffff0001
> >  #define CFG_RETRY_STATUS_TIMEOUT_US  500000 /* 500 milliseconds */
> >
> > @@ -289,6 +293,9 @@ enum iproc_pcie_reg {
> >       IPROC_PCIE_IARR4,
> >       IPROC_PCIE_IMAP4,
> >
> > +     /* config read status */
> > +     IPROC_PCIE_CFG_RD_STATUS,
> > +
> >       /* link status */
> >       IPROC_PCIE_LINK_STATUS,
> >
> > @@ -350,6 +357,7 @@ static const u16 iproc_pcie_reg_paxb_v2[] = {
> >       [IPROC_PCIE_IMAP3]              = 0xe08,
> >       [IPROC_PCIE_IARR4]              = 0xe68,
> >       [IPROC_PCIE_IMAP4]              = 0xe70,
> > +     [IPROC_PCIE_CFG_RD_STATUS]      = 0xee0,
>
> So, with the *current* code, on controllers that does not support this
> register you won't be able to get any HW whose config space register
> value reads 0xffff0001 to work, is that correct ?
>
Yes, this feature(register) is available only in "iProc PCIe PAXB v2"
controller for other controllers it will not applicable.

Regards,
Srinath.
> Lorenzo
>
> >       [IPROC_PCIE_LINK_STATUS]        = 0xf0c,
> >       [IPROC_PCIE_APB_ERR_EN]         = 0xf40,
> >  };
> > @@ -474,10 +482,12 @@ static void __iomem *iproc_pcie_map_ep_cfg_reg(struct iproc_pcie *pcie,
> >       return (pcie->base + offset);
> >  }
> >
> > -static unsigned int iproc_pcie_cfg_retry(void __iomem *cfg_data_p)
> > +static unsigned int iproc_pcie_cfg_retry(struct iproc_pcie *pcie,
> > +                                      void __iomem *cfg_data_p)
> >  {
> >       int timeout = CFG_RETRY_STATUS_TIMEOUT_US;
> >       unsigned int data;
> > +     u32 status;
> >
> >       /*
> >        * As per PCIe spec r3.1, sec 2.3.2, CRS Software Visibility only
> > @@ -498,6 +508,15 @@ static unsigned int iproc_pcie_cfg_retry(void __iomem *cfg_data_p)
> >        */
> >       data = readl(cfg_data_p);
> >       while (data == CFG_RETRY_STATUS && timeout--) {
> > +             /*
> > +              * CRS state is set in CFG_RD status register
> > +              * This will handle the case where CFG_RETRY_STATUS is
> > +              * valid config data.
> > +              */
> > +             status = iproc_pcie_read_reg(pcie, IPROC_PCIE_CFG_RD_STATUS);
> > +             if (status != CFG_RD_CRS)
> > +                     return data;
> > +
> >               udelay(1);
> >               data = readl(cfg_data_p);
> >       }
> > @@ -576,7 +595,7 @@ static int iproc_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
> >       if (!cfg_data_p)
> >               return PCIBIOS_DEVICE_NOT_FOUND;
> >
> > -     data = iproc_pcie_cfg_retry(cfg_data_p);
> > +     data = iproc_pcie_cfg_retry(pcie, cfg_data_p);
> >
> >       *val = data;
> >       if (size <= 2)
> > --
> > 2.7.4
> >
