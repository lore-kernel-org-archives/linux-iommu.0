From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 2/5] iommu/mediatek: Add mt8173 IOMMU driver
Date: Wed, 29 Apr 2015 14:23:27 +0800
Message-ID: <1430288607.24151.40.camel@mhfsdcap03>
References: <1425638900-24989-1-git-send-email-yong.wu@mediatek.com>
	<1425638900-24989-3-git-send-email-yong.wu@mediatek.com>
	<CAAFQd5ASywTX7P9L8cogBbBTra0W1=oVxeWfK5=K7L+SR2xaFA@mail.gmail.com>
	<1426677749.22581.38.camel@mhfsdcap03>
	<CAAFQd5DOzFmfXki8GwUC75VQFEWzxBUNUgOtSuRtV6tc27kD2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAAFQd5DOzFmfXki8GwUC75VQFEWzxBUNUgOtSuRtV6tc27kD2A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Dear Tomasz,
     About a hardcode your comment, please help check below.

Dear Mark,
      I would like to add a item in the dtsi of mtk-iommu. Please also
help have a look.


> > > +static const struct mtk_iommu_port mtk_iommu_mt8173_port[] = {
> > > +       /* port name                m4uid slaveid larbid portid
tfid */
> > > +       /* larb0 */
> > > +       {"M4U_PORT_DISP_OVL0",          0,  0,    0,  0,
MTK_TFID(0, 0)},
> > > +       {"M4U_PORT_DISP_RDMA0",         0,  0,    0,  1,
MTK_TFID(0, 1)},
> > > +       {"M4U_PORT_DISP_WDMA0",         0,  0,    0,  2,
MTK_TFID(0, 2)},
> > > +       {"M4U_PORT_DISP_OD_R",          0,  0,    0,  3,
MTK_TFID(0, 3)},
> > > +       {"M4U_PORT_DISP_OD_W",          0,  0,    0,  4,
MTK_TFID(0, 4)},
> > > +       {"M4U_PORT_MDP_RDMA0",          0,  0,    0,  5,
MTK_TFID(0, 5)},
> > > +       {"M4U_PORT_MDP_WDMA",           0,  0,    0,  6,
MTK_TFID(0, 6)},
> > > +       {"M4U_PORT_MDP_WROT0",          0,  0,    0,  7,
MTK_TFID(0, 7)},
[...]
> 
> > > +};
> > > +
> > 
> > Anyway, is it really necessary to hardcode the SoC specific topology
> > data in this driver? Is there really any use besides of printing
port
> > name? If not, you could just print the values in a way letting you
> > quickly look up in the datasheet, without hardcoding this. Or even
> > better, you could print which devices are attached to the port.
> > 
> a) Printing the port name is for debug. We could not request every
iommu
> user to understand smi&local arbiter. When there is irq, they have to
> look up the iommu's datasheet to find out which port error. if we
print
> it directly, It may be more easily to debug.
> 
> b) In mtk_iommu_config_port, according to this hardcode we can be
easily
> to get out which local arbiter and which port we prepare to config.
> 
> c) If we support different SOCs, we could change this arrays easily.
> 
> > 
     There is no similar code in the others iommu, so I prepare to
delete it, But we really need know which local arbiter and which port we
are going to config(which port will enable iommu)
        so we prepare add a item in the dtsi like this:

	iommu: mmsys_iommu@10205000 {
			compatible = "mediatek,mt8173-iommu";
			<...>
+			larb-portes-nr = <M4U_LARB0_PORT_NR
+					 M4U_LARB1_PORT_NR
+					 M4U_LARB2_PORT_NR
+					 M4U_LARB3_PORT_NR
+					 M4U_LARB4_PORT_NR
+					 M4U_LARB5_PORT_NR>;
			larb = <&larb0 &larb1 &larb2 &larb3 &larb4 &larb5>;
			#iommu-cells = <1>;
		};
	larb-portes-nr : the number of the portes in each local arbiter.
        
	If we have this item, we can get which larb and which port from the
portid in the dtsi of the iommu user.

        And while there is isr, I will print the larb-id and the port-id
instead of the string of the port name.

	The M4U_LARB0_PORT_NR/... will be added in
dt-bindings/iommu/mt8173-iommu-port.h[0]

Dear Mark, 
      As above, if I add this item in the dtsi of iommu, is it ok?


[0]:http://lists.linuxfoundation.org/pipermail/iommu/2015-March/012450.html
 
