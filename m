From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 2/5] iommu/mediatek: Add mt8173 IOMMU driver
Date: Thu, 12 Mar 2015 22:16:18 +0800
Message-ID: <1426169778.695.34.camel@mhfsdcap03>
References: <1425638900-24989-1-git-send-email-yong.wu@mediatek.com>
	<1425638900-24989-3-git-send-email-yong.wu@mediatek.com>
	<CAAFQd5CWOjT6XU8PFT+PO6Q2mb-i+iMTtZPSo_RDNUzpOO6TvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAAFQd5CWOjT6XU8PFT+PO6Q2mb-i+iMTtZPSo_RDNUzpOO6TvA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Dear Tomasz,

      Thanks very much for review so detail!

      Please check my reply below. Others I will fix it in the next
version.
       
      And I have got your comment of [2/5]. Do you have plan for the
other patch?

On Sun, 2015-03-08 at 13:12 +0900, Tomasz Figa wrote:
> Hi Yong Wu,
> 
> Thanks for this series. Please see my comments inline.
> 
> On Fri, Mar 6, 2015 at 7:48 PM,  <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
> > From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> >
> > This patch adds support for mediatek m4u (MultiMedia Memory Management Unit).
> > Currently this only supports m4u gen 2 with 2 levels of page table on mt8173.
> 
[snip]
> > +static const struct mtk_iommu_port mtk_iommu_mt8173_port[] = {
> > +       /* port name                m4uid slaveid larbid portid tfid */
> > +       /* larb0 */
> > +       {"M4U_PORT_DISP_OVL0",          0,  0,    0,  0, MTK_TFID(0, 0)},
> > +       {"M4U_PORT_DISP_RDMA0",         0,  0,    0,  1, MTK_TFID(0, 1)},
> > +       {"M4U_PORT_DISP_WDMA0",         0,  0,    0,  2, MTK_TFID(0, 2)},
> > +       {"M4U_PORT_DISP_OD_R",          0,  0,    0,  3, MTK_TFID(0, 3)},
> > +       {"M4U_PORT_DISP_OD_W",          0,  0,    0,  4, MTK_TFID(0, 4)},
> > +       {"M4U_PORT_MDP_RDMA0",          0,  0,    0,  5, MTK_TFID(0, 5)},
> > +       {"M4U_PORT_MDP_WDMA",           0,  0,    0,  6, MTK_TFID(0, 6)},
> > +       {"M4U_PORT_MDP_WROT0",          0,  0,    0,  7, MTK_TFID(0, 7)},
> 
> [snip]
> 
> > +       {"M4U_PORT_HSIC_MAS",              1,  0,    6,  12, 0x11},
> > +       {"M4U_PORT_HSIC_DEV",              1,  0,    6,  13, 0x19},
> > +       {"M4U_PORT_AP_DMA",                1,  0,    6,  14, 0x18},
> > +       {"M4U_PORT_HSIC_DMA",              1,  0,    6,  15, 0xc8},
> > +       {"M4U_PORT_MSDC0",                 1,  0,    6,  16, 0x0},
> > +       {"M4U_PORT_MSDC3",                 1,  0,    6,  17, 0x20},
> > +       {"M4U_PORT_UNKNOWN",               1,  0,    6,  18, 0xf},
> 
> Why the MTK_TFID() macro is not used for perisys iommu?
> 
       The perisys iommu don't connected with SMI and Local arbiter.
it's translation fault id is not MTK_TFID(x, y).it is special.
       For this perisys iommu , it is different with multimedia iommu,
we don't support it in this version, We have plan to delete perisys
iommu port next time.

> > +};
> > +
> 
> Anyway, is it really necessary to hardcode the SoC specific topology
> data in this driver? Is there really any use besides of printing port
> name? If not, you could just print the values in a way letting you
> quickly look up in the datasheet, without hardcoding this. Or even
> better, you could print which devices are attached to the port.
> 
a) Printing the port name is for debug. We could not request every iommu
user to understand smi&local arbiter. When there is irq, they have to
look up the iommu's datasheet to find out which port error. if we print
it directly, It may be more easily to debug.

b) In mtk_iommu_config_port, according to this hardcode we can be easily
to get out which local arbiter and which port we prepare to config.

c) If we support different SOCs, we could change this arrays easily.

> > +static const struct mtk_iommu_cfg mtk_iommu_mt8173_cfg = {
> > +       .larb_nr = 6,
> > +       .m4u_port_nr = ARRAY_SIZE(mtk_iommu_mt8173_port),
> > +       .pport = mtk_iommu_mt8173_port,
> > +};
> > +
> > +static const char *mtk_iommu_get_port_name(const struct mtk_iommu_info *piommu,
> > +                                          unsigned int portid)
> > +{
> > +       const struct mtk_iommu_port *pcurport = NULL;
> > +
> > +       pcurport = piommu->imucfg->pport + portid;
> > +       if (portid < piommu->imucfg->m4u_port_nr && pcurport)
> > +               return pcurport->port_name;
> > +       else
> > +               return "UNKNOWN_PORT";
> > +}
> 
> This function seems to be used just for printing the hardcoded port names.
> 
> > +
> > +static int mtk_iommu_get_port_by_tfid(const struct mtk_iommu_info *pimu,
> > +                                     int tf_id)
> > +{
> > +       const struct mtk_iommu_cfg *pimucfg = pimu->imucfg;
> > +       int i;
> > +       unsigned int portid = pimucfg->m4u_port_nr;
> > +
> > +       for (i = 0; i < pimucfg->m4u_port_nr; i++) {
> > +               if (pimucfg->pport[i].tf_id == tf_id) {
> > +                       portid = i;
> > +                       break;
> > +               }
> > +       }
> > +       if (i == pimucfg->m4u_port_nr)
> > +               dev_err(pimu->dev, "tf_id find fail, tfid %d\n", tf_id);
> > +       return portid;
> > +}
> 
> This function seems to be used just for finding an index into the
> array of hardcoded port names for printing purposes.
   Yes. "mtk_iommu_get_port_name" and "mtk_iommu_get_port_by_tfid" is
only for find out the right port to print for improve debug.
> 
[snip]
> > +
> > +static int mtk_iommu_invalidate_tlb(const struct mtk_iommu_info *piommu,
> > +                                   int isinvall, unsigned int iova_start,
> > +                                   unsigned int iova_end)
> > +{
> > +       void __iomem *m4u_base = piommu->m4u_base;
> > +       u32 val;
> > +       u64 start, end;
> > +
> > +       start = sched_clock();
> 
> I don't think this is the preferred way of checking time in kernel
> drivers, especially after seeing this comment:
> http://lxr.free-electrons.com/source/include/linux/sched.h#L2134
> 
> You should use ktime_get() and other ktime_ helpers.
> 
   I will try to replace this with readl_polling_timeout from Mitchel.
Is it ok?

> > +
> > +       if (!isinvall) {
> > +               iova_start = round_down(iova_start, SZ_4K);
> > +               iova_end = round_up(iova_end, SZ_4K);
> > +       }
> > +
> > +       val = F_MMU_INV_EN_L2 | F_MMU_INV_EN_L1;
> > +
> > +       writel(val, m4u_base + REG_INVLID_SEL);
> > +
> > +       if (isinvall) {
> > +               writel(F_MMU_INV_ALL, m4u_base + REG_MMU_INVLD);
> 
> Please move invalidate all into separate function and just call it
> wherever the code currently passes true as invall argument. You will
> get rid of two of the ifs in this function.
> 
> > +       } else {
> > +               writel(iova_start, m4u_base + REG_MMU_INVLD_SA);
> > +               writel(iova_end, m4u_base + REG_MMU_INVLD_EA);
> > +               writel(F_MMU_INV_RANGE, m4u_base + REG_MMU_INVLD);
> > +
> > +               while (!readl(m4u_base + REG_MMU_CPE_DONE)) {
> > +                       end = sched_clock();
> > +                       if (end - start >= 100000000ULL) {
> 
> Looks like a very interesting magic number. Please define a macro and
> use normal time units along with ktime_to_<unit>() helpers.
> 
> > +                               dev_warn(piommu->dev, "invalid don't done\n");
> > +                               writel(F_MMU_INV_ALL, m4u_base + REG_MMU_INVLD);
> 
> By following my comment above, you could just call the new invalidate
> all function here instead of duplicating the same register write.
[snip]
> Best regards,
> Tomasz
