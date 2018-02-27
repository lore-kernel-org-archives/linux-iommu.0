From: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Subject: Re: [PATCH 0/8] R-Car M3-N: Enable EtherAVB device node
Date: Tue, 27 Feb 2018 09:35:09 +0100
Message-ID: <20180227083509.6qrp2g3wstq7j24x@verge.net.au>
References: <1519667836-31330-1-git-send-email-jacopo+renesas@jmondi.org>
	<CAMuHMdXwxhT7MP5xs3HLP3oFX+V9rhCM5jQycXUiCyBOKOUg1Q@mail.gmail.com>
	<20180227082838.GA23738@w540>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180227082838.GA23738@w540>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: jacopo mondi <jacopo-AW8dsiIh9cEdnm+yROfE0A@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, netdev <netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jacopo Mondi <jacopo+renesas-AW8dsiIh9cEdnm+yROfE0A@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Linux ARM <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Feb 27, 2018 at 09:28:38AM +0100, jacopo mondi wrote:
> Hi Geert,
> 
> On Mon, Feb 26, 2018 at 07:28:47PM +0100, Geert Uytterhoeven wrote:
> > Hi Jacopo,
> >
> > On Mon, Feb 26, 2018 at 6:57 PM, Jacopo Mondi <jacopo+renesas-AW8dsiIh9cEdnm+yROfE0A@public.gmane.org> wrote:
> > >   as discussed with you Sergei and Geert, in order to enable EtherAVB for
> > > R8A77965 we first wanted to make the phy-mode "rgmii-txid" a board specific
> > > property for all other SoCs.
> >
> > Thanks for your series!
> >
> > > This series adds  the phy-mode property to salvator-common.dtsi and reset the
> > > one for R8A77965/R8A7796/R8A77995 to "rgmii".
> >
> > I forgot that r8a7795.dtsi and r8a7796.dtsi are used for the ULCB boards, too.
> > So to avoid regressions, you need to make a similar change to ulcb.dtsi like you
> > made for salvator-common.dtsi.
> >
> > In addition, r8a77995.dtsi is only used for the Draak board.
> > So you have to update r8a7795-draak.dtsi first, too.
> 
> Of course! I forgot about ULCB (and had a patch for Draak I lost while
> rebasing :/ )
> >
> > > Then, in order to enable EtherAVB for R-Car M3-N, iommu nodes had to be added
> > > as they are referenced by the "avb" device node (CC the iommu list for the
> > > series for that reason).
> >
> > I don't think we need the iommu properties and nodes at this early stage.
> > Ethernet works fine without them. Simon, do you agree?
> 
> I'll wait for Simon reply and then resend, possibly without iommu and
> ULCB and Draak patches!

I don't feel strongly about this but I don't think iommu is a strict
dependency of enabling Ethernet and I think its good not to include extra
dependencies - if it was me I'd try to get Ethernet accepted then follow-up
on iommu.
