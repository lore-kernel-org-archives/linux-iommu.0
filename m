From: Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/9] dma: pl330: use dma_addr_t for describing bus
	addresses
Date: Tue, 11 Jun 2013 10:07:12 +0530
Message-ID: <CAJe_ZheKMVQgq42Vx5N1TXXdgFJ2sp50ixU30A7beXhmSVHnZQ@mail.gmail.com>
References: <1370889285-22799-1-git-send-email-will.deacon@arm.com>
	<1370889285-22799-3-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2063003166782855452=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1370889285-22799-3-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, device-tree <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============2063003166782855452==
Content-Type: multipart/alternative; boundary=089e012952ec6cabfc04ded973e6

--089e012952ec6cabfc04ded973e6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11 June 2013 00:04, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:

> The microcode bus address (pl330_dmac.mcode_bus) is currently a u32,
> which fails to compile when building on a system with 64-bit bus
> addresses.
>
> This patch uses dma_addr_t to represent the address instead.
>
> Acked-by: Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>


> Cc: Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> ---
>  drivers/dma/pl330.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
> index 22e2a8f..f1bc593 100644
> --- a/drivers/dma/pl330.c
> +++ b/drivers/dma/pl330.c
> @@ -501,7 +501,7 @@ struct pl330_dmac {
>         /* Maximum possible events/irqs */
>         int                     events[32];
>         /* BUS address of MicroCode buffer */
> -       u32                     mcode_bus;
> +       dma_addr_t              mcode_bus;
>         /* CPU address of MicroCode buffer */
>         void                    *mcode_cpu;
>         /* List of all Channel threads */
> --
> 1.8.2.2
>
>


--=20
Linaro.org =E2=94=82 Open source software for ARM SoCs | Follow Linaro
http://facebook.com/pages/Linaro/155974581091106  -
http://twitter.com/#!/linaroorg - http://linaro.org/linaro-blog

--089e012952ec6cabfc04ded973e6
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><br><div class=3D"gmail=
_quote">On 11 June 2013 00:04, Will Deacon <span dir=3D"ltr">&lt;<a href=3D=
"mailto:will.deacon-5wv7dgnIgG8@public.gmane.org" target=3D"_blank">will.deacon-5wv7dgnIgG8@public.gmane.org</a>&gt;<=
/span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">The microcode bus address (pl330_dmac.mcode_bus) is curren=
tly a u32,<br>

which fails to compile when building on a system with 64-bit bus<br>
addresses.<br>
<br>
This patch uses dma_addr_t to represent the address instead.<br>
<br></blockquote><div style>Acked-by: Jassi Brar &lt;<a href=3D"mailto:jasw=
inder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org">jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org</a>&gt;</div><div>=C2=A0=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left-width:1px;border-left-color:rgb(204,204,204);border-left-style:s=
olid;padding-left:1ex">

Cc: Jassi Brar &lt;<a href=3D"mailto:jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org">jaswinder.=
singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org</a>&gt;<br>
Cc: Vinod Koul &lt;<a href=3D"mailto:vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org">vinod.koul@intel=
.com</a>&gt;<br>
Signed-off-by: Will Deacon &lt;<a href=3D"mailto:will.deacon-5wv7dgnIgG8@public.gmane.org">will.=
deacon-5wv7dgnIgG8@public.gmane.org</a>&gt;<br>
---<br>
=C2=A0drivers/dma/pl330.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c<br>
index 22e2a8f..f1bc593 100644<br>
--- a/drivers/dma/pl330.c<br>
+++ b/drivers/dma/pl330.c<br>
@@ -501,7 +501,7 @@ struct pl330_dmac {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Maximum possible events/irqs */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 events[32];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* BUS address of MicroCode buffer */<br>
- =C2=A0 =C2=A0 =C2=A0 u32 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 mcode_bus;<br>
+ =C2=A0 =C2=A0 =C2=A0 dma_addr_t =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0mcode_bus;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* CPU address of MicroCode buffer */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 void =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0*mcode_cpu;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* List of all Channel threads */<br>
<span class=3D""><font color=3D"#888888">--<br>
1.8.2.2<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r>Linaro.org =E2=94=82 Open source software for ARM SoCs | Follow Linaro<br=
><a href=3D"http://facebook.com/pages/Linaro/155974581091106" target=3D"_bl=
ank">http://facebook.com/pages/Linaro/155974581091106</a> =C2=A0-<br>
<a href=3D"http://twitter.com/#!/linaroorg" target=3D"_blank">http://twitte=
r.com/#!/linaroorg</a> - <a href=3D"http://linaro.org/linaro-blog" target=
=3D"_blank">http://linaro.org/linaro-blog</a>
</div></div>

--089e012952ec6cabfc04ded973e6--

--===============2063003166782855452==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2063003166782855452==--
