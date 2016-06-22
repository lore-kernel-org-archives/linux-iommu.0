From: Honghui Zhang <honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v4 5/5] ARM: dts: mt2701: add iommu/smi dtsi node for
	mt2701
Date: Wed, 22 Jun 2016 15:45:47 +0800
Message-ID: <1466581547.8787.18.camel@mtksdaap41>
References: <1465379461-14757-1-git-send-email-honghui.zhang@mediatek.com>
	<1465379461-14757-6-git-send-email-honghui.zhang@mediatek.com>
	<20160621095748.GE28248@8bytes.org>
	<1466574342.27791.8.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1466574342.27791.8.camel@mtksdaap41>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "catalin.marinas-5wv7dgnIgG8@public.gmane.org" <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, Youlin Pei =?UTF-8?Q?=28=E8=A3=B4=E5=8F=8B=E6=9E=97=29?= <youlin.pei-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Yingjoe Chen =?UTF-8?Q?=28=3F=3F=E8=8B=B1=E6=B4=B2=29?= <Yingjoe.Chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kendrick Hsu =?UTF-8?Q?=28=E5=BE=90=E5=AD=90=E5=87=A1=29?= <Kendrick.Hsu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm>
List-Id: iommu@lists.linux-foundation.org

On Wed, 2016-06-22 at 13:45 +0800, Eddie Huang wrote:
> On Tue, 2016-06-21 at 17:57 +0800, Joerg Roedel wrote:
> > On Wed, Jun 08, 2016 at 05:51:01PM +0800, honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org wrote:
> > > From: Honghui Zhang <honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > > 
> > > Add the dtsi node of iommu and smi for mt2701.
> > > 
> > > Signed-off-by: Honghui Zhang <honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > > ---
> > >  arch/arm/boot/dts/mt2701.dtsi | 51 +++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 51 insertions(+)
> > 
> > Okay, I pushed my arm/mediatek branch to my tree at
> > 
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
> > 
> > Please base the patch on that branch and re-send.
> > 
> 
> I think it is better let Mediatek SoC maintainer Matthias to accept dtsi
> patch like other drivers. This can avoid dtsi conflict. As I
> remember,last time MT8173 IOMMU dtsi patch accepted in iommu tree and
> mt8173.dtsi had conflict with arm soc tree at the merge window. Honghui
> should resend this patch to Matthias, and elaborate your dependency with
> clock and power domain dtsi, then Matthias know the merge sequence. 
> 

Thanks, Eddie.

Hi, Joerg, 
This one is based on CCF "arm: dts: mt2701: Add clock controller device
nodes"[1] and power domain patch "Mediatek MT2701 SCPSYS power domain
support v7"[2],
But these two patchset are still being review now.

Do you think it's better that I send this one later after ccf and power
domain patch got merged, and let Matthias take it?


Thanks.
[1] https://patchwork.kernel.org/patch/9109081
[2]
http://lists.infradead.org/pipermail/linux-mediatek/2016-May/005429.html

> Eddie
> Thanks 
> 
> 
