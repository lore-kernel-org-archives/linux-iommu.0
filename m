From: Hongbo Zhang <hongbo.zhang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v9 03/19] vfio: platform: add the VFIO PLATFORM module to
	Kconfig
Date: Wed, 12 Nov 2014 17:38:12 +0800
Message-ID: <CAOhR-w2N3SF=3DTgFr22JfAKDXxzz0PASznJaRjK3oBrRTVcsw@mail.gmail.com>
References: <1414433284-31719-1-git-send-email-a.motakis@virtualopensystems.com>
	<1414433284-31719-4-git-send-email-a.motakis@virtualopensystems.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0063489921517085012=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1414433284-31719-4-git-send-email-a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Cc: "open list:VFIO DRIVER" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, marc.zyngier-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org, Christoffer Dall <christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============0063489921517085012==
Content-Type: multipart/alternative; boundary=001a1133e418850ebf0507a627c5

--001a1133e418850ebf0507a627c5
Content-Type: text/plain; charset=UTF-8

On 28 October 2014 02:07, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org
> wrote:

> Enable building the VFIO PLATFORM driver that allows to use Linux platform
> devices with VFIO.
>
> Signed-off-by: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
> ---
>  drivers/vfio/Kconfig           | 1 +
>  drivers/vfio/Makefile          | 1 +
>  drivers/vfio/platform/Kconfig  | 9 +++++++++
>  drivers/vfio/platform/Makefile | 4 ++++
>  4 files changed, 15 insertions(+)
>  create mode 100644 drivers/vfio/platform/Kconfig
>  create mode 100644 drivers/vfio/platform/Makefile
>
> diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
> index a0abe04..962fb80 100644
> --- a/drivers/vfio/Kconfig
> +++ b/drivers/vfio/Kconfig
> @@ -27,3 +27,4 @@ menuconfig VFIO
>           If you don't know what to do here, say N.
>
>  source "drivers/vfio/pci/Kconfig"
> +source "drivers/vfio/platform/Kconfig"
> diff --git a/drivers/vfio/Makefile b/drivers/vfio/Makefile
> index 0b035b1..dadf0ca 100644
> --- a/drivers/vfio/Makefile
> +++ b/drivers/vfio/Makefile
> @@ -3,3 +3,4 @@ obj-$(CONFIG_VFIO_IOMMU_TYPE1) += vfio_iommu_type1.o
>  obj-$(CONFIG_VFIO_IOMMU_SPAPR_TCE) += vfio_iommu_spapr_tce.o
>  obj-$(CONFIG_VFIO_SPAPR_EEH) += vfio_spapr_eeh.o
>  obj-$(CONFIG_VFIO_PCI) += pci/
> +obj-$(CONFIG_VFIO_PLATFORM) += platform/
> diff --git a/drivers/vfio/platform/Kconfig b/drivers/vfio/platform/Kconfig
> new file mode 100644
> index 0000000..c51af17
> --- /dev/null
> +++ b/drivers/vfio/platform/Kconfig
> @@ -0,0 +1,9 @@
> +config VFIO_PLATFORM
> +       tristate "VFIO support for platform devices"
> +       depends on VFIO && EVENTFD && ARM
>

Hi Antonios,
Is this only for ARM? how about X86 and PowerPC?
On Freescale's PowerPC platform, the IOMMU is called PAMU (Peripheral
Access Management Unit), and I am trying to use this VFIO framework on it.


> +       help
> +         Support for platform devices with VFIO. This is required to make
> +         use of platform devices present on the system using the VFIO
> +         framework.
> +
> +         If you don't know what to do here, say N.
> diff --git a/drivers/vfio/platform/Makefile
> b/drivers/vfio/platform/Makefile
> new file mode 100644
> index 0000000..279862b
> --- /dev/null
> +++ b/drivers/vfio/platform/Makefile
> @@ -0,0 +1,4 @@
> +
> +vfio-platform-y := vfio_platform.o vfio_platform_common.o
> +
> +obj-$(CONFIG_VFIO_PLATFORM) += vfio-platform.o
> --
> 2.1.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

--001a1133e418850ebf0507a627c5
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On 28 October 2014 02:07, Antonios Motakis <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org" target=3D"_blank">a.motakis@v=
irtualopensystems.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">Enable building the VFIO PLATFORM driver that allows to use Linux platfo=
rm<br>
devices with VFIO.<br>
<br>
Signed-off-by: Antonios Motakis &lt;<a href=3D"mailto:a.motakis@virtualopen=
systems.com">a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org</a>&gt;<br>
---<br>
=C2=A0drivers/vfio/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 1 +<br=
>
=C2=A0drivers/vfio/Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 1 +<br>
=C2=A0drivers/vfio/platform/Kconfig=C2=A0 | 9 +++++++++<br>
=C2=A0drivers/vfio/platform/Makefile | 4 ++++<br>
=C2=A04 files changed, 15 insertions(+)<br>
=C2=A0create mode 100644 drivers/vfio/platform/Kconfig<br>
=C2=A0create mode 100644 drivers/vfio/platform/Makefile<br>
<br>
diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig<br>
index a0abe04..962fb80 100644<br>
--- a/drivers/vfio/Kconfig<br>
+++ b/drivers/vfio/Kconfig<br>
@@ -27,3 +27,4 @@ menuconfig VFIO<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 If you don&#39;t know what to do here, s=
ay N.<br>
<br>
=C2=A0source &quot;drivers/vfio/pci/Kconfig&quot;<br>
+source &quot;drivers/vfio/platform/Kconfig&quot;<br>
diff --git a/drivers/vfio/Makefile b/drivers/vfio/Makefile<br>
index 0b035b1..dadf0ca 100644<br>
--- a/drivers/vfio/Makefile<br>
+++ b/drivers/vfio/Makefile<br>
@@ -3,3 +3,4 @@ obj-$(CONFIG_VFIO_IOMMU_TYPE1) +=3D vfio_iommu_type1.o<br>
=C2=A0obj-$(CONFIG_VFIO_IOMMU_SPAPR_TCE) +=3D vfio_iommu_spapr_tce.o<br>
=C2=A0obj-$(CONFIG_VFIO_SPAPR_EEH) +=3D vfio_spapr_eeh.o<br>
=C2=A0obj-$(CONFIG_VFIO_PCI) +=3D pci/<br>
+obj-$(CONFIG_VFIO_PLATFORM) +=3D platform/<br>
diff --git a/drivers/vfio/platform/Kconfig b/drivers/vfio/platform/Kconfig<=
br>
new file mode 100644<br>
index 0000000..c51af17<br>
--- /dev/null<br>
+++ b/drivers/vfio/platform/Kconfig<br>
@@ -0,0 +1,9 @@<br>
+config VFIO_PLATFORM<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tristate &quot;VFIO support for platform device=
s&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0depends on VFIO &amp;&amp; EVENTFD &amp;&amp; A=
RM<br></blockquote><div><br></div><div>Hi Antonios,</div><div>Is this only =
for ARM? how about X86 and PowerPC?</div><div>On Freescale&#39;s PowerPC pl=
atform, the IOMMU is called PAMU (Peripheral Access Management Unit), and I=
 am trying to use this VFIO framework on it.</div><div>=C2=A0</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0help<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Support for platform devices with VFIO. =
This is required to make<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0use of platform devices present on the s=
ystem using the VFIO<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0framework.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0If you don&#39;t know what to do here, s=
ay N.<br>
diff --git a/drivers/vfio/platform/Makefile b/drivers/vfio/platform/Makefil=
e<br>
new file mode 100644<br>
index 0000000..279862b<br>
--- /dev/null<br>
+++ b/drivers/vfio/platform/Makefile<br>
@@ -0,0 +1,4 @@<br>
+<br>
+vfio-platform-y :=3D vfio_platform.o vfio_platform_common.o<br>
+<br>
+obj-$(CONFIG_VFIO_PLATFORM) +=3D vfio-platform.o<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
2.1.1<br>
<br>
--<br>
To unsubscribe from this list: send the line &quot;unsubscribe linux-kernel=
&quot; in<br>
the body of a message to <a href=3D"mailto:majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">major=
domo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a><br>
More majordomo info at=C2=A0 <a href=3D"http://vger.kernel.org/majordomo-in=
fo.html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html</a><b=
r>
Please read the FAQ at=C2=A0 <a href=3D"http://www.tux.org/lkml/" target=3D=
"_blank">http://www.tux.org/lkml/</a><br>
</font></span></blockquote></div><br></div></div>

--001a1133e418850ebf0507a627c5--

--===============0063489921517085012==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0063489921517085012==--
