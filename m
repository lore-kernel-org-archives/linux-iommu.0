From: Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] PCI: iproc: Add feature to set order mode
Date: Thu, 24 Jan 2019 13:31:31 -0600
Message-ID: <20190124193131.GG14636@google.com>
References: <1547785403-32268-1-git-send-email-srinath.mannam@broadcom.com>
	<1547785403-32268-2-git-send-email-srinath.mannam@broadcom.com>
	<20190118150713.GB25249@google.com>
	<CABe79T741K-jPpkgCWWOoFRGY2Nf3zs1ea=NO=sLke=WJUT9iA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CABe79T741K-jPpkgCWWOoFRGY2Nf3zs1ea=NO=sLke=WJUT9iA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Srinath Mannam <srinath.mannam-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, BCM Kernel Feedback <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Jan 24, 2019 at 02:10:18PM +0530, Srinath Mannam wrote:
> On Fri, Jan 18, 2019 at 8:37 PM Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> > On Fri, Jan 18, 2019 at 09:53:21AM +0530, Srinath Mannam wrote:
> > > Order mode in RX header of incoming pcie packets can be override to
> > > strict or loose order based on requirement.
> > > Sysfs entry is provided to set dynamic and default order modes of upstream
> > > traffic.
> > ...
> > Are you talking about the Relaxed Ordering bit in the TLP Attributes
> > field?  If so, please use the exact language used in the spec and
> > include a reference, e.g., to PCIe r4.0, sec 2.2.6.4, 2.4, etc.
> >
> Yes Relax ordering bit in TLP. I will use spec reference. Thanks.
> > I'm hesitant about a new sysfs file for this.  That automatically
> > creates a user-space dependency on this iProc feature.  Who would use
> > this file?
> >
> This is the specific feature given in iProc, used to improve
> performance for the endpoints which does not support
> ordering configuration at its end.
> This is the reason we used sysfs file, which allows user to change
> ordering based on endpoint used and requirement.
> we are using these sysfs files to configure ordering to improve
> performance in NVMe endpoints with SPDK/DPDK drivers.
> If we enable this default in kernel, then it is applicable to all
> endpoints connected. But it may not required for all endpoints.

Normally, relaxed ordering is used only when an endpoint sets the
"Relaxed Ordering" attribute bit in a TLP.  The endpoint is only
allowed to do that if relaxed ordering is enabled in the Device
Control register.

If I understand correctly, this sysfs knob would let you configure the
iProc RC so it handles *all* TLPs (or just those in certain address
ranges) with relaxed ordering, regardless of whether the endpoint has
relaxed ordering, or even whether it supports relaxed ordering at all.

My gut feeling is that this is a messy hack, and if you want the
performance benefits of relaxed ordering, you should just choose an
NVMe endpoint that supports it correctly.

I assume the iProc RC does actually have the smarts to pay attention
to the Relaxed Ordering bit in TLPs if the endpoint sets it?

> > > To improve performance in few endpoints we required to modify the
> > > ordering attributes. Using this feature we can override order modes of RX
> > > packets at IPROC RC.
> > >
> > > Ex:
> > > In PCIe based NVMe SSD endpoints data read/writes from disk is using
> > > Queue pairs (submit/completion). After completion of block read/write,
> > > EP writes completion command to completion queue to notify RC.
> > > So that all data transfers before completion command write are not
> > > required to strict order except completion command. It means previous all
> > > packets before completion command write to RC should be written to memory
> > > and acknowledged.
> >
> > IIUC, if Enable Relaxed Ordering in the endpoint's Device Control
> > register is set, the device is permitted to set the Relaxed Ordering
> > bit in TLPs it initiates.  So I would think that if we set Enable
> > Relaxed Ordering correctly, the NVMe endpoint should be able to
> > use Relaxed Ordering for the data transfers and strict ordering (the
> > default) for the completion command.  What am I missing?
> >
> As per NVMe spec Enable Relaxed ordering is implementation specific all cards
> may not support.

Relaxed ordering support is optional for *every* PCIe endpoint, not
just NVMe.  If an endpoint doesn't support relaxed ordering at all, it
should hardwire the Enable Relaxed Ordering bit to zero.

> > This sysfs file apparently affects the Root Port/Root Complex
> > behavior, not the Endpoint's behavior.  Does that mean iProc ignores
> > the Relaxed Ordering bit by default, and you're providing a knob that
> >
> With sysfs file setting, ordering attributes of all TLPs directed to
> specific memory window can be override iProc layer based on
> settings.  TLPs to one memory window can keep as strict order and
> other memory windows can set to strict order.
>
> Using sysfs file ordering settings can configure and revert back to default.
>
> > makes it pay attention to it?  If that's the case, why wouldn't you
> > enable iProc support for Relaxed Ordering always, by default?
> >
> Option is given to user, because few endpoints may support ordering
> configuration internally.
> few EPs doesn't support. Based on requirement user can configure
> ordering settings.
> 
> > > Signed-off-by: Srinath Mannam <srinath.mannam-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> > > Reviewed-by: Ray Jui <ray.jui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> > > ---
> > >  drivers/pci/controller/pcie-iproc.c | 128 ++++++++++++++++++++++++++++++++++++
> > >  drivers/pci/controller/pcie-iproc.h |  16 +++++
> > >  2 files changed, 144 insertions(+)
> > >
> > > diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
> > > index c20fd6b..13ce80f 100644
> > > --- a/drivers/pci/controller/pcie-iproc.c
> > > +++ b/drivers/pci/controller/pcie-iproc.c
> > > @@ -57,6 +57,9 @@
> > >  #define PCIE_DL_ACTIVE_SHIFT         2
> > >  #define PCIE_DL_ACTIVE                       BIT(PCIE_DL_ACTIVE_SHIFT)
> > >
> > > +#define MPS_MRRS_CFG_MPS_SHIFT               0
> > > +#define MPS_MRRS_CFG_MRRS_SHIFT              16
> > > +
> > >  #define APB_ERR_EN_SHIFT             0
> > >  #define APB_ERR_EN                   BIT(APB_ERR_EN_SHIFT)
> > >
> > > @@ -91,6 +94,14 @@
> > >
> > >  #define IPROC_PCIE_REG_INVALID               0xffff
> > >
> > > +#define RO_FIELD(window)             BIT((window) << 1)
> > > +#define RO_VALUE(window)             BIT(((window) << 1) + 1)
> > > +/* All Windows are allowed */
> > > +#define RO_ALL_WINDOW                        0x33333333
> > > +/* Wait on All Windows */
> > > +#define RO_FIELD_ALL_WINDOW          0x11111111
> > > +#define DYNAMIC_ORDER_MODE           0x5
> > > +
> > >  /**
> > >   * iProc PCIe outbound mapping controller specific parameters
> > >   *
> > > @@ -295,6 +306,15 @@ enum iproc_pcie_reg {
> > >       /* enable APB error for unsupported requests */
> > >       IPROC_PCIE_APB_ERR_EN,
> > >
> > > +     /* Ordering Mode configuration registers */
> > > +     IPROC_PCIE_ORDERING_CFG,
> > > +     IPROC_PCIE_MPS_MRRS_CFG,
> > > +     IPROC_PCIE_IMAP0_RO_CONTROL,
> > > +     IPROC_PCIE_IMAP1_RO_CONTROL,
> > > +     IPROC_PCIE_IMAP2_RO_CONTROL,
> > > +     IPROC_PCIE_IMAP3_RO_CONTROL,
> > > +     IPROC_PCIE_IMAP4_RO_CONTROL,
> > > +
> > >       /* total number of core registers */
> > >       IPROC_PCIE_MAX_NUM_REG,
> > >  };
> > > @@ -352,6 +372,13 @@ static const u16 iproc_pcie_reg_paxb_v2[] = {
> > >       [IPROC_PCIE_IMAP4]              = 0xe70,
> > >       [IPROC_PCIE_LINK_STATUS]        = 0xf0c,
> > >       [IPROC_PCIE_APB_ERR_EN]         = 0xf40,
> > > +     [IPROC_PCIE_ORDERING_CFG]       = 0x2000,
> > > +     [IPROC_PCIE_MPS_MRRS_CFG]       = 0x2008,
> > > +     [IPROC_PCIE_IMAP0_RO_CONTROL]   = 0x201c,
> > > +     [IPROC_PCIE_IMAP1_RO_CONTROL]   = 0x2020,
> > > +     [IPROC_PCIE_IMAP2_RO_CONTROL]   = 0x2024,
> > > +     [IPROC_PCIE_IMAP3_RO_CONTROL]   = 0x2028,
> > > +     [IPROC_PCIE_IMAP4_RO_CONTROL]   = 0x202c,
> > >  };
> > >
> > >  /* iProc PCIe PAXC v1 registers */
> > > @@ -1401,6 +1428,97 @@ static int iproc_pcie_rev_init(struct iproc_pcie *pcie)
> > >       return 0;
> > >  }
> > >
> > > +static
> > > +ssize_t order_mode_show(struct device *dev,
> > > +                     struct device_attribute *attr,
> > > +                     char *buff)
> >
> > Please format the same as the rest of the file, i.e.,
> >
> >   static ssize_t order_mode_show(struct device *dev, ...
> >
> > > +{
> > > +     struct pci_host_bridge *host = to_pci_host_bridge(dev);
> > > +     struct iproc_pcie *pcie = pci_host_bridge_priv(host);
> > > +
> > > +     return sprintf(buff, "Current PAXB order configuration %d\n",
> > > +                    pcie->order_cfg);
> > > +}
> > > +
> > > +static void pcie_iproc_set_dynamic_order(struct iproc_pcie *pcie)
> > > +{
> > > +     u32 val = 0, mps;
> > > +
> > > +     /* Set all IMAPs to relaxed order in dynamic order mode */
> > > +     iproc_pcie_write_reg(pcie, IPROC_PCIE_ORDERING_CFG,
> > > +                          DYNAMIC_ORDER_MODE);
> > > +     iproc_pcie_write_reg(pcie, IPROC_PCIE_IMAP0_RO_CONTROL,
> > > +                          RO_ALL_WINDOW);
> > > +     iproc_pcie_write_reg(pcie, IPROC_PCIE_IMAP1_RO_CONTROL,
> > > +                          RO_ALL_WINDOW);
> > > +     iproc_pcie_write_reg(pcie, IPROC_PCIE_IMAP2_RO_CONTROL,
> > > +                          RO_ALL_WINDOW);
> > > +     iproc_pcie_write_reg(pcie, IPROC_PCIE_IMAP3_RO_CONTROL,
> > > +                          RO_ALL_WINDOW);
> > > +     iproc_pcie_write_reg(pcie, IPROC_PCIE_IMAP4_RO_CONTROL,
> > > +                          RO_ALL_WINDOW);
> > > +
> > > +     /* PAXB MPS/MRRS settings configuration */
> > > +     iproc_pci_raw_config_read32(pcie, 0, IPROC_PCI_EXP_CAP + PCI_EXP_DEVCTL,
> > > +                                 2, &mps);
> > > +     mps = (mps & PCI_EXP_DEVCTL_PAYLOAD) >> 5;
> > > +     /* set MRRS to match system MPS */
> > > +     val |= (mps << MPS_MRRS_CFG_MRRS_SHIFT);
> > > +     /* set MPS to 4096 bytes */
> > > +     val |= (0x5 << MPS_MRRS_CFG_MPS_SHIFT);
> > > +     iproc_pcie_write_reg(pcie, IPROC_PCIE_MPS_MRRS_CFG, val);
> > > +}
> > > +
> > > +static
> > > +ssize_t order_mode_store(struct device *dev,
> > > +                      struct device_attribute *attr,
> > > +                      const char *buf,
> > > +                      size_t count)
> >
> > Fix formatting as above.
> >
> > > +{
> > > +     struct pci_host_bridge *host = to_pci_host_bridge(dev);
> > > +     struct iproc_pcie *pcie = pci_host_bridge_priv(host);
> > > +     unsigned long  val, regval;
> > > +
> > > +     if (kstrtoul(buf, 0, &val) < 0)
> > > +             return -EINVAL;
> > > +
> > > +     if (val > PAXB_ORDER_DEV_MEM_ONLY) {
> > > +             dev_err(dev, "Invalid Value passed %lu\n", val);
> > > +             dev_err(dev, "0: Everything in strict order\n");
> > > +             dev_err(dev, "1: Only IMAP2 in strict order\n");
> > > +             dev_err(dev, "2: Only device memory in strict order (MSI/MSIX)\n");
> > > +             return -EINVAL;
> > > +     }
> > > +
> > > +     if (val == pcie->order_cfg)
> > > +             return count;
> > > +
> > > +     switch (val) {
> > > +     case PAXB_ORDER_IMAP2_ONLY:
> > > +             pcie_iproc_set_dynamic_order(pcie);
> > > +             regval = RO_ALL_WINDOW;
> > > +             regval &= ~(RO_VALUE(0));
> > > +             /* Set IMAP2 to strict order */
> > > +             iproc_pcie_write_reg(pcie, IPROC_PCIE_IMAP2_RO_CONTROL, regval);
> > > +             dev_info(dev, "RO_IMAP2 set to %#lx\n", regval);
> > > +             break;
> > > +     case PAXB_ORDER_DEV_MEM_ONLY:
> > > +             pcie_iproc_set_dynamic_order(pcie);
> > > +             /* Set IMAP0 to strict order */
> > > +             iproc_pcie_write_reg(pcie, IPROC_PCIE_IMAP0_RO_CONTROL,
> > > +                                  RO_FIELD_ALL_WINDOW);
> > > +             dev_info(dev, "RO_IMAP0 set to %#x\n", RO_FIELD_ALL_WINDOW);
> > > +             break;
> > > +     default:
> > > +             iproc_pcie_write_reg(pcie, IPROC_PCIE_ORDERING_CFG, 0);
> > > +             break;
> > > +     }
> > > +     pcie->order_cfg = val;
> > > +     return count;
> > > +}
> > > +
> > > +static DEVICE_ATTR_RW(order_mode);
> > > +
> > >  int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
> > >  {
> > >       struct device *dev;
> > > @@ -1484,6 +1602,11 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
> > >
> > >       pci_bus_add_devices(host->bus);
> > >
> > > +     if (pcie->type == IPROC_PCIE_PAXB_V2) {
> > > +             ret = device_create_file(&host->dev, &dev_attr_order_mode);
> > > +             if (ret < 0)
> > > +                     goto err_power_off_phy;
> > > +     }
> > >       return 0;
> > >
> > >  err_power_off_phy:
> > > @@ -1496,6 +1619,11 @@ EXPORT_SYMBOL(iproc_pcie_setup);
> > >
> > >  int iproc_pcie_remove(struct iproc_pcie *pcie)
> > >  {
> > > +     struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
> > > +
> > > +     if (pcie->type == IPROC_PCIE_PAXB_V2)
> > > +             device_remove_file(&host->dev, &dev_attr_order_mode);
> > > +
> > >       pci_stop_root_bus(pcie->root_bus);
> > >       pci_remove_root_bus(pcie->root_bus);
> > >
> > > diff --git a/drivers/pci/controller/pcie-iproc.h b/drivers/pci/controller/pcie-iproc.h
> > > index 4f03ea5..6e100cd 100644
> > > --- a/drivers/pci/controller/pcie-iproc.h
> > > +++ b/drivers/pci/controller/pcie-iproc.h
> > > @@ -24,6 +24,18 @@ enum iproc_pcie_type {
> > >  };
> > >
> > >  /**
> > > + * PAXB Dynamic ordering modes
> > > + * PAXB_ORDER_EVERYTHING: Everything in strict order
> > > + * PAXB_ORDER_IMAP2_ONLY: Only IMAP2 memory window strict order
> > > + * PAXB_ORDER_DEV_MEM_ONLY: Only device memory (MSI/MSIX) is strict order
> > > + */
> > > +enum paxb_order_cfg {
> > > +     PAXB_ORDER_EVERYTHING,
> > > +     PAXB_ORDER_IMAP2_ONLY,
> > > +     PAXB_ORDER_DEV_MEM_ONLY,
> > > +};
> > > +
> > > +/**
> > >   * iProc PCIe outbound mapping
> > >   * @axi_offset: offset from the AXI address to the internal address used by
> > >   * the iProc PCIe core
> > > @@ -74,6 +86,8 @@ struct iproc_msi;
> > >   * @ib: inbound mapping related parameters
> > >   * @ib_map: outbound mapping region related parameters
> > >   *
> > > + * @order_cfg: indicates current value of the order mode.
> > > + *
> > >   * @need_msi_steer: indicates additional configuration of the iProc PCIe
> > >   * controller is required to steer MSI writes to external interrupt controller
> > >   * @msi: MSI data
> > > @@ -102,6 +116,8 @@ struct iproc_pcie {
> > >       struct iproc_pcie_ib ib;
> > >       const struct iproc_pcie_ib_map *ib_map;
> > >
> > > +     enum paxb_order_cfg order_cfg;
> > > +
> > >       bool need_msi_steer;
> > >       struct iproc_msi *msi;
> > >  };
> > > --
> > > 2.7.4
> > >
