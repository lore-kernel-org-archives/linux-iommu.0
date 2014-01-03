From: Yifan Zhang <yifan.zhangm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] iommu/arm-smmu: change pud/pmd entry fill sequence
Date: Fri, 3 Jan 2014 20:08:44 +0800
Message-ID: <CAGZxSSSuOx+YTryvr+ZXKDcUu-c7YQu+qekGNeQ5yAKedOrVvg@mail.gmail.com>
References: <1388750486-5060-1-git-send-email-yifan.zhangm@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1699328659510897845=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1388750486-5060-1-git-send-email-yifan.zhangm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: will.deacon-5wv7dgnIgG8@public.gmane.org, Catalin.Marinas-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Yifan Zhang <zhangyf-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============1699328659510897845==
Content-Type: multipart/alternative; boundary=e89a8f3bae6f84c42304ef0fc588

--e89a8f3bae6f84c42304ef0fc588
Content-Type: text/plain; charset=ISO-8859-1

Hi Will,

I found current smmu driver may generate wrong page tables, after apply
this patch, the result is correct. I have verified this patch on our
platform.

BR,
Yifan


On Fri, Jan 3, 2014 at 8:01 PM, Yifan Zhang <yifan.zhangm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> From: Yifan Zhang <zhangyf-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
>
> Pgd/pud entry should be filled only once when their next level pud/pmd
> created, the value should be pud/pmd start address, while in current
> code, pgd/pud entry is filled every time when pud/pmd walk occurs,
> the value is pud/pmd start address + iova pud/pmd index , this is
> incorrect; Besides, when pud/pmd are created, we need to add pud/pmd
> index, then pass to next level, while in currect code, if a new pud/pmd
> created, their iova pud/pmd index is not taken into account, only
> existing pud/pmd do. This patch change pud/pmd entry fill sequence,
> fixes the 2 bugs.
>
> Signed-off-by: Yifan Zhang <zhangyf-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/iommu/arm-smmu.c |   14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index e46a887..e3168a2 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -1317,6 +1317,11 @@ static int arm_smmu_alloc_init_pmd(struct
> arm_smmu_device *smmu, pud_t *pud,
>                 pmd = pmd_alloc_one(NULL, addr);
>                 if (!pmd)
>                         return -ENOMEM;
> +
> +               pud_populate(NULL, pud, pmd);
> +               arm_smmu_flush_pgtable(smmu, pud, sizeof(*pud));
> +
> +               pmd += pmd_index(addr);
>         } else
>  #endif
>                 pmd = pmd_offset(pud, addr);
> @@ -1325,8 +1330,6 @@ static int arm_smmu_alloc_init_pmd(struct
> arm_smmu_device *smmu, pud_t *pud,
>                 next = pmd_addr_end(addr, end);
>                 ret = arm_smmu_alloc_init_pte(smmu, pmd, addr, end, pfn,
>                                               flags, stage);
> -               pud_populate(NULL, pud, pmd);
> -               arm_smmu_flush_pgtable(smmu, pud, sizeof(*pud));
>                 phys += next - addr;
>         } while (pmd++, addr = next, addr < end);
>
> @@ -1346,6 +1349,11 @@ static int arm_smmu_alloc_init_pud(struct
> arm_smmu_device *smmu, pgd_t *pgd,
>                 pud = pud_alloc_one(NULL, addr);
>                 if (!pud)
>                         return -ENOMEM;
> +
> +               pgd_populate(NULL, pgd, pud);
> +               arm_smmu_flush_pgtable(smmu, pgd, sizeof(*pgd));
> +
> +               pud += pud_index(addr);
>         } else
>  #endif
>                 pud = pud_offset(pgd, addr);
> @@ -1354,8 +1362,6 @@ static int arm_smmu_alloc_init_pud(struct
> arm_smmu_device *smmu, pgd_t *pgd,
>                 next = pud_addr_end(addr, end);
>                 ret = arm_smmu_alloc_init_pmd(smmu, pud, addr, next, phys,
>                                               flags, stage);
> -               pgd_populate(NULL, pud, pgd);
> -               arm_smmu_flush_pgtable(smmu, pgd, sizeof(*pgd));
>                 phys += next - addr;
>         } while (pud++, addr = next, addr < end);
>
> --
> 1.7.9.5
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

--e89a8f3bae6f84c42304ef0fc588
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Will,<div><br></div><div>I found current smmu driver ma=
y generate wrong page tables, after apply this patch, the result is correct=
. I have verified this patch on our platform.</div><div><br></div><div>BR,<=
/div>
<div>Yifan</div></div><div class=3D"gmail_extra"><br><br><div class=3D"gmai=
l_quote">On Fri, Jan 3, 2014 at 8:01 PM, Yifan Zhang <span dir=3D"ltr">&lt;=
<a href=3D"mailto:yifan.zhangm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">yifan.zhangm@gm=
ail.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">From: Yifan Zhang &lt;<a href=3D"mailto:zhan=
gyf-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org">zhangyf-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org</a>&gt;<br>
<br>
Pgd/pud entry should be filled only once when their next level pud/pmd<br>
created, the value should be pud/pmd start address, while in current<br>
code, pgd/pud entry is filled every time when pud/pmd walk occurs,<br>
the value is pud/pmd start address + iova pud/pmd index , this is<br>
incorrect; Besides, when pud/pmd are created, we need to add pud/pmd<br>
index, then pass to next level, while in currect code, if a new pud/pmd<br>
created, their iova pud/pmd index is not taken into account, only<br>
existing pud/pmd do. This patch change pud/pmd entry fill sequence,<br>
fixes the 2 bugs.<br>
<br>
Signed-off-by: Yifan Zhang &lt;<a href=3D"mailto:zhangyf-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org">zhang=
yf-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org</a>&gt;<br>
---<br>
=A0drivers/iommu/arm-smmu.c | =A0 14 ++++++++++----<br>
=A01 file changed, 10 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c<br>
index e46a887..e3168a2 100644<br>
--- a/drivers/iommu/arm-smmu.c<br>
+++ b/drivers/iommu/arm-smmu.c<br>
@@ -1317,6 +1317,11 @@ static int arm_smmu_alloc_init_pmd(struct arm_smmu_d=
evice *smmu, pud_t *pud,<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pmd =3D pmd_alloc_one(NULL, addr);<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!pmd)<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 pud_populate(NULL, pud, pmd);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 arm_smmu_flush_pgtable(smmu, pud, sizeof(*pud=
));<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 pmd +=3D pmd_index(addr);<br>
=A0 =A0 =A0 =A0 } else<br>
=A0#endif<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pmd =3D pmd_offset(pud, addr);<br>
@@ -1325,8 +1330,6 @@ static int arm_smmu_alloc_init_pmd(struct arm_smmu_de=
vice *smmu, pud_t *pud,<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 next =3D pmd_addr_end(addr, end);<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D arm_smmu_alloc_init_pte(smmu, pmd, =
addr, end, pfn,<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 flags, stage);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 pud_populate(NULL, pud, pmd);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 arm_smmu_flush_pgtable(smmu, pud, sizeof(*pud=
));<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 phys +=3D next - addr;<br>
=A0 =A0 =A0 =A0 } while (pmd++, addr =3D next, addr &lt; end);<br>
<br>
@@ -1346,6 +1349,11 @@ static int arm_smmu_alloc_init_pud(struct arm_smmu_d=
evice *smmu, pgd_t *pgd,<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pud =3D pud_alloc_one(NULL, addr);<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!pud)<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 pgd_populate(NULL, pgd, pud);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 arm_smmu_flush_pgtable(smmu, pgd, sizeof(*pgd=
));<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 pud +=3D pud_index(addr);<br>
=A0 =A0 =A0 =A0 } else<br>
=A0#endif<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pud =3D pud_offset(pgd, addr);<br>
@@ -1354,8 +1362,6 @@ static int arm_smmu_alloc_init_pud(struct arm_smmu_de=
vice *smmu, pgd_t *pgd,<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 next =3D pud_addr_end(addr, end);<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D arm_smmu_alloc_init_pmd(smmu, pud, =
addr, next, phys,<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 flags, stage);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 pgd_populate(NULL, pud, pgd);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 arm_smmu_flush_pgtable(smmu, pgd, sizeof(*pgd=
));<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 phys +=3D next - addr;<br>
=A0 =A0 =A0 =A0 } while (pud++, addr =3D next, addr &lt; end);<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
1.7.9.5<br>
<br>
<br>
_______________________________________________<br>
linux-arm-kernel mailing list<br>
<a href=3D"mailto:linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org">linux-arm-kernel@li=
sts.infradead.org</a><br>
<a href=3D"http://lists.infradead.org/mailman/listinfo/linux-arm-kernel" ta=
rget=3D"_blank">http://lists.infradead.org/mailman/listinfo/linux-arm-kerne=
l</a><br>
</font></span></blockquote></div><br></div>

--e89a8f3bae6f84c42304ef0fc588--

--===============1699328659510897845==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1699328659510897845==--
