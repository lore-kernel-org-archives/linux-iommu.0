From: Matthieu <mspeder-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Subject: Re: [PATCH] iommu/intel: GAW only gets smaller by adding devices
Date: Sat, 21 Jun 2014 15:51:36 +0200
Message-ID: <CAOzT74z5UsV8GfAV57oD9Fb2vran3ykfNygir+LqZDUz7hOoyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1019620798378290660=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

--===============1019620798378290660==
Content-Type: multipart/alternative; boundary=089e0122a9249cddb204fc58e8d4

--089e0122a9249cddb204fc58e8d4
Content-Type: text/plain; charset=UTF-8

Tested-by: mspeder-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org

Problem described in bug 76331 is fully solved by Alex's patch.
Could it be included in next 3.15 release ?

Thanks !

Matthieu



On Thu, May 29, 2014 at 10:23 PM, Alex Williamson <
alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> As analyzed in https://bugzilla.kernel.org/show_bug.cgi?id=76331
> we can have multiple DRHDs in a system and each may support different
> guest address widths.  We can add a device behind a less capable DRHD
> to a domain so long as the lesser DRHD can map the existing domain
> page table.  We should never increase the address width as a result
> of adding a device to the domain.  The current code simply updates
> the width to the last added device.  Change to keep it at the
> minumum DRHD width.
>
> Reported-by: mspeder-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Signed-off-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Cc: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
> ---
>  drivers/iommu/intel-iommu.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index e68f44b..cd41d8d 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -4276,7 +4276,7 @@ static int intel_iommu_attach_device(struct
> iommu_domain *domain,
>                        __func__, addr_width, dmar_domain->max_addr);
>                 return -EFAULT;
>         }
> -       dmar_domain->gaw = addr_width;
> +       dmar_domain->gaw = min(addr_width, dmar_domain->gaw);
>
>         /*
>          * Knock out extra levels of page tables if necessary
>
>

--089e0122a9249cddb204fc58e8d4
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span style=3D"font-family:arial,sans-serif;font-size:13px=
">Tested-by:=C2=A0</span><a href=3D"mailto:mspeder-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" t=
arget=3D"_blank">mspeder-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org</a><div><br></div><div>Probl=
em described in bug 76331 is fully solved by Alex&#39;s patch.</div>
<div>Could it be included in next 3.15 release ?</div><div><br></div><div>T=
hanks !</div><div><br></div><div>Matthieu<br><div><br></div><div><div class=
=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On Thu, May 29, 2014 at=
 10:23 PM, Alex Williamson <span dir=3D"ltr">&lt;<a href=3D"mailto:alex.wil=
liamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" target=3D"_blank">alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;</s=
pan> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">As analyzed in <a href=3D"https://bugzilla.kernel.org/show=
_bug.cgi?id=3D76331" target=3D"_blank">https://bugzilla.kernel.org/show_bug=
.cgi?id=3D76331</a><br>


we can have multiple DRHDs in a system and each may support different<br>
guest address widths. =C2=A0We can add a device behind a less capable DRHD<=
br>
to a domain so long as the lesser DRHD can map the existing domain<br>
page table. =C2=A0We should never increase the address width as a result<br=
>
of adding a device to the domain. =C2=A0The current code simply updates<br>
the width to the last added device. =C2=A0Change to keep it at the<br>
minumum DRHD width.<br>
<br>
Reported-by: <a href=3D"mailto:mspeder-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" target=3D"_bl=
ank">mspeder-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org</a><br>
Signed-off-by: Alex Williamson &lt;<a href=3D"mailto:alex.williamson@redhat=
.com" target=3D"_blank">alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;<br>
Cc: David Woodhouse &lt;<a href=3D"mailto:dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" target=3D"_b=
lank">dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org</a>&gt;<br>
---<br>
=C2=A0drivers/iommu/intel-iommu.c | =C2=A0 =C2=A02 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c<br>
index e68f44b..cd41d8d 100644<br>
--- a/drivers/iommu/intel-iommu.c<br>
+++ b/drivers/iommu/intel-iommu.c<br>
@@ -4276,7 +4276,7 @@ static int intel_iommu_attach_device(struct iommu_dom=
ain *domain,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0__func__, addr_width, dmar_domain-&gt;max_addr);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EFAULT;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
- =C2=A0 =C2=A0 =C2=A0 dmar_domain-&gt;gaw =3D addr_width;<br>
+ =C2=A0 =C2=A0 =C2=A0 dmar_domain-&gt;gaw =3D min(addr_width, dmar_domain-=
&gt;gaw);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Knock out extra levels of page tables i=
f necessary<br>
<br>
</blockquote></div><br></div></div></div></div>

--089e0122a9249cddb204fc58e8d4--

--===============1019620798378290660==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1019620798378290660==--
