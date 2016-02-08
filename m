From: Anup Patel <anup.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v2 4/4] iommu/arm-smmu: Add stub of_xlate() operation in
	SMMUv1/SMMUv2 driver
Date: Mon, 8 Feb 2016 18:11:10 +0530
Message-ID: <CAALAos_DXi=h_fG4ZgxSaBytZoGegyvtdsjfNhFo_4eHAQXxzQ@mail.gmail.com>
References: <1454908652-15317-1-git-send-email-anup.patel@broadcom.com>
	<1454908652-15317-5-git-send-email-anup.patel@broadcom.com>
	<20160208111829.GA13498@leverpostej>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8399655316564371081=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160208111829.GA13498@leverpostej>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Device Tree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Vikram Prakash <vikramp-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, BCM Kernel Feedback <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Linux ARM Kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============8399655316564371081==
Content-Type: multipart/alternative; boundary=001a1134f81af3fc6c052b4183fc

--001a1134f81af3fc6c052b4183fc
Content-Type: text/plain; charset=UTF-8

On Mon, Feb 8, 2016 at 4:48 PM, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org> wrote:

> On Mon, Feb 08, 2016 at 10:47:32AM +0530, Anup Patel wrote:
> > To allow use of large memory (> 4Gb) with 32bit devices we need to use
> > IOMMU based DMA mappings for such 32bit devices. The IOMMU dt-bindings
> > allows us do this by specifying 'iommus' attribute in 32bit device DT
> > node. Unfortunately, specifying 'iommus' attribute does not work with
> > current SMMUv1/SMMUv2 driver because it requires of_xlate() operation
> > to be implemented by the driver.
> >
> > This patch adds a stub implementation of of_xlate() in SMMUv1/SMMUv2
> > driver to allow usage of 'iommus' attribute in DT for 32bit devices.
> >
> > Signed-off-by: Anup Patel <anup.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> > Reviewed-by: Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> > Reviewed-by: Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> > ---
> >  drivers/iommu/arm-smmu.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > index 02cd67d..8e090d8 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -1398,6 +1398,16 @@ static int arm_smmu_init_platform_device(struct
> device *dev,
> >       return 0;
> >  }
> >
> > +int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
> > +{
> > +     /*
> > +      * Nothing to do here because SMMU is already aware of all
> > +      * MMU masters and their stream IDs using mmu-master attibute
> > +      * SMMU DT node.
> > +      */
> > +     return 0;
> > +}
>
> NAK to this.
>

I had no intention in continuing this change if I knew some work
on generic IOMMU binding was in-progress. In fact, I had asked
about alternate options previously. (Refer,
http://lists.infradead.org/pipermail/linux-arm-kernel/2016-January/403128.html
)


> As previously mentioned by others [1], this is an abuse of the generic
> iommu binding support code.
>
> The SMMU binding currently does not define its implementation of the
> generic IOMMU binding. This series did not define what an SMMU's
> #iommu-cells would be nor what the contained values would represent.
> Therefore it is not valid to use an SMMU node with an iommus property as
> the SMMu doesn't follwo the generic IOMMU binding.
>
> There is ongoing work to have generic iommu binding support for the
> SMMU. In the absence of documentation for what this means for the
> binding, I am worried that this hack harms that effort.
>

Thanks for the info, I would like to try this on Broadcom SoCs.

Whats the ETA of patches for generic IOMMU binding for SMMU?


>
> To use features of the generic IOMMU binding, we must properly implement
> the generic IOMMU binding for the SMMU rather than bodging it onto the
> side of the existing binding.
>
> Thanks,
> Mark.
>
>
Regards,
Anup

--001a1134f81af3fc6c052b4183fc
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On M=
on, Feb 8, 2016 at 4:48 PM, Mark Rutland <span dir=3D"ltr">&lt;<a href=3D"m=
ailto:mark.rutland-5wv7dgnIgG8@public.gmane.org" target=3D"_blank">mark.rutland-5wv7dgnIgG8@public.gmane.org</a>&gt;<=
/span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-l=
eft-style:solid;padding-left:1ex"><div class=3D""><div class=3D"h5">On Mon,=
 Feb 08, 2016 at 10:47:32AM +0530, Anup Patel wrote:<br>
&gt; To allow use of large memory (&gt; 4Gb) with 32bit devices we need to =
use<br>
&gt; IOMMU based DMA mappings for such 32bit devices. The IOMMU dt-bindings=
<br>
&gt; allows us do this by specifying &#39;iommus&#39; attribute in 32bit de=
vice DT<br>
&gt; node. Unfortunately, specifying &#39;iommus&#39; attribute does not wo=
rk with<br>
&gt; current SMMUv1/SMMUv2 driver because it requires of_xlate() operation<=
br>
&gt; to be implemented by the driver.<br>
&gt;<br>
&gt; This patch adds a stub implementation of of_xlate() in SMMUv1/SMMUv2<b=
r>
&gt; driver to allow usage of &#39;iommus&#39; attribute in DT for 32bit de=
vices.<br>
&gt;<br>
&gt; Signed-off-by: Anup Patel &lt;<a href=3D"mailto:anup.patel-dY08KVG/lbrQFizaE/u3fw@public.gmane.org=
m">anup.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org</a>&gt;<br>
&gt; Reviewed-by: Ray Jui &lt;<a href=3D"mailto:rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org">rjui@bro=
adcom.com</a>&gt;<br>
&gt; Reviewed-by: Scott Branden &lt;<a href=3D"mailto:sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org=
">sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/iommu/arm-smmu.c | 11 +++++++++++<br>
&gt;=C2=A0 1 file changed, 11 insertions(+)<br>
&gt;<br>
&gt; diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c<br>
&gt; index 02cd67d..8e090d8 100644<br>
&gt; --- a/drivers/iommu/arm-smmu.c<br>
&gt; +++ b/drivers/iommu/arm-smmu.c<br>
&gt; @@ -1398,6 +1398,16 @@ static int arm_smmu_init_platform_device(struct=
 device *dev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; +int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *arg=
s)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * Nothing to do here because SMMU is already awa=
re of all<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * MMU masters and their stream IDs using mmu-mas=
ter attibute<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * SMMU DT node.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
<br>
</div></div>NAK to this.<br></blockquote><div><br></div><div>I had no inten=
tion in continuing this change if I knew some work</div><div>on generic IOM=
MU binding was in-progress. In fact, I had asked</div><div>about alternate =
options previously. (Refer,</div><div><a href=3D"http://lists.infradead.org=
/pipermail/linux-arm-kernel/2016-January/403128.html">http://lists.infradea=
d.org/pipermail/linux-arm-kernel/2016-January/403128.html</a>)<br></div><di=
v><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-left-s=
tyle:solid;padding-left:1ex">
<br>
As previously mentioned by others [1], this is an abuse of the generic<br>
iommu binding support code.<br>
<br>
The SMMU binding currently does not define its implementation of the<br>
generic IOMMU binding. This series did not define what an SMMU&#39;s<br>
#iommu-cells would be nor what the contained values would represent.<br>
Therefore it is not valid to use an SMMU node with an iommus property as<br=
>
the SMMu doesn&#39;t follwo the generic IOMMU binding.<br>
<br>
There is ongoing work to have generic iommu binding support for the<br>
SMMU. In the absence of documentation for what this means for the<br>
binding, I am worried that this hack harms that effort.<br></blockquote><di=
v><br></div><div>Thanks for the info, I would like to try this on Broadcom =
SoCs.</div><div><br></div><div>Whats the ETA of patches for generic IOMMU b=
inding for SMMU?</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb=
(204,204,204);border-left-style:solid;padding-left:1ex">
<br>
To use features of the generic IOMMU binding, we must properly implement<br=
>
the generic IOMMU binding for the SMMU rather than bodging it onto the<br>
side of the existing binding.<br>
<br>
Thanks,<br>
Mark.<br>
<span class=3D""><br></span></blockquote><div><br></div><div>Regards,</div>=
<div>Anup=C2=A0</div></div></div></div>

--001a1134f81af3fc6c052b4183fc--

--===============8399655316564371081==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8399655316564371081==--
