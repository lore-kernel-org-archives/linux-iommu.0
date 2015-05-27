From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v2 1/6] dt-bindings: iommu: Add binding for mediatek IOMMU
Date: Wed, 27 May 2015 15:03:26 +0800
Message-ID: <1432710206.721.111.camel@mhfsdcap03>
References: <1431683009-18158-1-git-send-email-yong.wu@mediatek.com>
	<1431683009-18158-2-git-send-email-yong.wu@mediatek.com>
	<CAAFQd5AF5UVb35PEg+GjzLAqqr0q=Wg+XONRmK4XR=HLuJv2rA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAAFQd5AF5UVb35PEg+GjzLAqqr0q=Wg+XONRmK4XR=HLuJv2rA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, k.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, youhua.li-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Tomasz,
	Thanks very much for your suggestion!.
	please help check my comment.
On Mon, 2015-05-25 at 15:31 +0900, Tomasz Figa wrote:
> Hi,
> 
> Please see my comments inline.
> 
> On Fri, May 15, 2015 at 6:43 PM, Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
> > This patch add mediatek iommu dts binding document.
> >
> > Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > ---
> >  .../devicetree/bindings/iommu/mediatek,iommu.txt   |  51 ++++++++++
> >  include/dt-bindings/iommu/mt8173-iommu-port.h      | 112 +++++++++++++++++++++
> >  2 files changed, 163 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
> >  create mode 100644 include/dt-bindings/iommu/mt8173-iommu-port.h
> >
> > diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt b/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
> > new file mode 100644
> > index 0000000..f2cc7c0
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
> > @@ -0,0 +1,51 @@
> > +/******************************************************/
> > +/*    Mediatek IOMMU Hardware Block Diagram           */
> > +/******************************************************/
> 
> nit: Could you follow one of existing styles of DT binding
> documentation? You might be able to use [1] as an example.
> 
> [1] http://lxr.free-electrons.com/source/Documentation/devicetree/bindings/iommu/arm,smmu.txt
How about below:

* Mediatek IOMMU Architecture Implementation

  Mediatek Socs may contain a implementation of Multimedia Memory
Management Unit(M4U),which use ARM Short-descriptor translation table
to achieve address translation.
  
  The IOMMU Hardware Block Diagram, please check below:
> .
> 
> > +              EMI (External Memory Interface)
> > +               |
> > +              m4u (Multimedia Memory Management Unit)
> > +               |
> > +              smi (Smart Multimedia Interface)
> > +               |
> > +        +---------------+-------
> > +        |               |
> > +        |               |
> > +    vdec larb       disp larb      ... SoCs have different smi local arbiter(larb).
> > +        |               |
> > +        |               |
> > +   +----+----+    +-----+-----+
> > +   |    |    |    |     |     |    ...
> > +   |    |    |    |     |     |    ...
> > +   |    |    |    |     |     |    ...
> > +  MC   PP   VLD  OVL0 RDMA0 WDMA0  ... There are different ports in each larb.
> > +
> 
> This diagram is still quite meaningless without proper description of
> all the functionality off all the blocks and interfaces between them.
How about it if like this:
 //========
    As above, The Multimedia HW will go through SMI and M4U while it
access EMI. SMI is a brige between m4u and the Multimedia HW. It contain
smi local arbiter and smi common. It will control whether the Multimedia
HW should go though the m4u for translation or bypass it and talk
directly with EMI.And also SMI will help control the clocks for each
local arbiter.
    About smi local arbiter(larb), Normally we specify a local
arbiter(larb) for each multimedia HW like display, video decode, and
camera. And there are different ports in each larb. Take a example,
There are some ports like MC, PP, VLD, AVC_MV, PRED_RD, PRED_WR in the
video local arbiter, all the ports are according to the video HW.
  //======
> 
> > +Required properties:
> > +- compatible : must be "mediatek,mt8173-m4u".
> > +- reg : m4u register base and size.
> > +- interrupts : the interrupt of m4u.
> > +- clocks : must contain one entry for each clock-names.
> > +- clock-names : must be "bclk", It is the block clock of m4u.
> > +- larb-portes-nr : must contain the number of the portes for each larb(local
> > +       arbiter). The number is defined in dt-binding/iommu/mt8173-iommu-port.h.
> 
> typo: Should it be "ports" instead of "portes"?
> 
> Anyway, shouldn't this be a property of larb nodes? I.e. the larb0
> node would have a port-count property set to M4U_LARB0_PORT_NR.
> 
> > +- larb : must contain the local arbiters of the current platform. Refer to
> > +       bindings/soc/mediatek/mediatek,smi.txt. It must sort according to the
> > +       local arbiter index, like larb0, larb1, larb2...
> > +- iommu-cells : must be 1. Specifies the client PortID as defined in
> > +       dt-binding/iommu/mt8173-iommu-port.h
> 
> Looking at the driver, wouldn't a 2 cell system be more appropriate
> here? With first cell indexing the larbs and second the ports within
> that larb.
Thanks very much. This is very helpful!
if we use 2, we can enter smi driver to enable/disable iommu easily. and
the code will be easier to read.

Then How about the descriptor if I write like this:

//====
iommu-cells : must be 2.There are 2 cell needed to enable/disable iommu.
The first is local arbiter index(larbid), and the second is port
index(portid) within local arbiter. Specifies the larbid and portid as
defined in dt-binding/iommu/mt8173-iommu-port.h. 
//====

Is it ok?
> 
> [snip]
> 
> > +#define M4U_LARB0_PORT_NR      8
> > +#define M4U_LARB1_PORT_NR      10
> > +#define M4U_LARB2_PORT_NR      21
> > +#define M4U_LARB3_PORT_NR      15
> > +#define M4U_LARB4_PORT_NR      6
> > +#define M4U_LARB5_PORT_NR      9
> > +
> > +#define M4U_LARB0_PORT(n)      (n)
> > +#define M4U_LARB1_PORT(n)      ((n) + M4U_LARB0_PORT_NR + M4U_LARB0_PORT(0))
> > +#define M4U_LARB2_PORT(n)      ((n) + M4U_LARB1_PORT_NR + M4U_LARB1_PORT(0))
> > +#define M4U_LARB3_PORT(n)      ((n) + M4U_LARB2_PORT_NR + M4U_LARB2_PORT(0))
> > +#define M4U_LARB4_PORT(n)      ((n) + M4U_LARB3_PORT_NR + M4U_LARB3_PORT(0))
> > +#define M4U_LARB5_PORT(n)      ((n) + M4U_LARB4_PORT_NR + M4U_LARB4_PORT(0))
> 
> This looks like some artificial indexing. Does it have any
> correspondence with actual hardware configuration?
No. We don't have the correspondence hardware config about this.
we only find out the local arbiter id and port id according to the 
M4U_LARB0_PORT,M4U_LARB1_PORT,...

So if we use 2 in the iommu-cells. we don't need to remember the port id
offset for each local arbiter. I will delete them.

Then I could define like this.

#define M4U_LARB0_ID  (0)
#define M4U_LARB1_ID  (1)
#define M4U_LARB2_ID  (2)

/* larb0 */
#define        M4U_PORT_DISP_OVL0              (0)
#define        M4U_PORT_DISP_RDMA0             (1)
#define        M4U_PORT_DISP_WDMA0             (2)
...
/* larb1 */
#define        M4U_PORT_HW_VDEC_MC_EXT         (0)
#define        M4U_PORT_HW_VDEC_PP_EXT         (1)
...

Then we could write like this in the client's dtsi.

   vdec:vdec@xxxx{
	reg = <xxxxx>;
        iommu = <&iommu M4U_LARB1_ID M4U_PORT_HW_VDEC_MC_EXT>,
		<&iommu M4U_LARB1_ID M4U_PORT_HW_VDEC_PP_EXT>;
   }

 Is it ok?

> 
> > +
> > +/* larb0 */
> > +#define        M4U_PORT_DISP_OVL0              M4U_LARB0_PORT(0)
> > +#define        M4U_PORT_DISP_RDMA0             M4U_LARB0_PORT(1)
> > +#define        M4U_PORT_DISP_WDMA0             M4U_LARB0_PORT(2)
> [snip]
> > +#define        M4U_PORT_VENC_CUR_CHROMA_SET2   M4U_LARB5_PORT(6)
> > +#define        M4U_PORT_VENC_RD_COMA_SET2      M4U_LARB5_PORT(7)
> > +#define        M4U_PORT_VENC_SV_COMA_SET2      M4U_LARB5_PORT(8)
> 
> This convinces me even more that this binding actually needs
> #iommu-cells to be 2 and the indexing system I described above.
> 
> Best regards,
> Tomasz
