From: Kai Huang <dev.kai.huang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Patch Part1 V2 07/20] iommu/vt-d, trivial: check suitable flag
	in function detect_intel_iommu()
Date: Fri, 27 Dec 2013 16:09:10 +0800
Message-ID: <CAOtp4KqnHTk0qh_h76y3z3EGJSax3QtsSS3SBPRNEjbAaBCTZg@mail.gmail.com>
References: <1386300083-6882-1-git-send-email-jiang.liu@linux.intel.com>
	<1386300083-6882-8-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1831079268305739064=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1386300083-6882-8-git-send-email-jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jiri Kosina <trivial-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============1831079268305739064==
Content-Type: multipart/alternative; boundary=001a11c2959ae815bc04ee7f9be4

--001a11c2959ae815bc04ee7f9be4
Content-Type: text/plain; charset=ISO-8859-1

On Fri, Dec 6, 2013 at 11:21 AM, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>wrote:

> Flag irq_remapping_enabled is only set by intel_enable_irq_remapping(),
> which is called after detect_intel_iommu(). So we should check flag
> disable_irq_remap instead of irq_remapping_enabled in function
> detect_intel_iommu().
>
> Reviewed-by: Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
>  drivers/iommu/dmar.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
> index c17dbf7..70612a9 100644
> --- a/drivers/iommu/dmar.c
> +++ b/drivers/iommu/dmar.c
> @@ -560,7 +560,7 @@ int __init detect_intel_iommu(void)
>
>                 dmar = (struct acpi_table_dmar *) dmar_tbl;
>
> -               if (ret && irq_remapping_enabled && cpu_has_x2apic &&
> +               if (ret && !disable_irq_remap && cpu_has_x2apic &&
>                     dmar->flags & 0x1)
>                         pr_info("Queued invalidation will be enabled to
> support x2apic and Intr-remapping.\n");
>

Then is it better to move this pr_info code to intel_enable_irq_remapping?


> --
> 1.7.10.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--001a11c2959ae815bc04ee7f9be4
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><br><div class=3D"gmail=
_quote">On Fri, Dec 6, 2013 at 11:21 AM, Jiang Liu <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" target=3D"_blank">jiang.liu@linu=
x.intel.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">Flag irq_remapping_enabled is only set by intel_enable_irq=
_remapping(),<br>

which is called after detect_intel_iommu(). So we should check flag<br>
disable_irq_remap instead of irq_remapping_enabled in function<br>
detect_intel_iommu().<br>
<br>
Reviewed-by: Yijing Wang &lt;<a href=3D"mailto:wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org">wangy=
ijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org</a>&gt;<br>
Signed-off-by: Jiang Liu &lt;<a href=3D"mailto:jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org">j=
iang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org</a>&gt;<br>
---<br>
=A0drivers/iommu/dmar.c | =A0 =A02 +-<br>
=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c<br>
index c17dbf7..70612a9 100644<br>
--- a/drivers/iommu/dmar.c<br>
+++ b/drivers/iommu/dmar.c<br>
@@ -560,7 +560,7 @@ int __init detect_intel_iommu(void)<br>
<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dmar =3D (struct acpi_table_dmar *) dmar_tb=
l;<br>
<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret &amp;&amp; irq_remapping_enabled &amp=
;&amp; cpu_has_x2apic &amp;&amp;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret &amp;&amp; !disable_irq_remap &amp;&a=
mp; cpu_has_x2apic &amp;&amp;<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dmar-&gt;flags &amp; 0x1)<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info(&quot;Queued invali=
dation will be enabled to support x2apic and Intr-remapping.\n&quot;);<br><=
/blockquote><div><br></div><div>Then is it better to move this pr_info code=
 to=A0<span style=3D"font-family:arial,sans-serif;font-size:13px">intel_ena=
ble_irq_remapping?=A0</span></div>
<div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-lef=
t-style:solid;padding-left:1ex">
<span class=3D""><font color=3D"#888888"><br>
--<br>
1.7.10.4<br>
<br>
--<br>
To unsubscribe from this list: send the line &quot;unsubscribe linux-pci&qu=
ot; in<br>
the body of a message to <a href=3D"mailto:majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">major=
domo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a><br>
More majordomo info at =A0<a href=3D"http://vger.kernel.org/majordomo-info.=
html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html</a><br>
</font></span></blockquote></div><br></div></div>

--001a11c2959ae815bc04ee7f9be4--

--===============1831079268305739064==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1831079268305739064==--
