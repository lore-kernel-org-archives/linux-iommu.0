From: Kai Huang <dev.kai.huang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/1] x86/iommu: use bit structures for context_entry
Date: Thu, 26 Dec 2013 09:55:10 +0800
Message-ID: <CAOtp4KqUgSnwadP0T=aWYX7rRzDBn3qkuqMzceDBO0c_bhpFwQ@mail.gmail.com>
References: <1387529101-29769-1-git-send-email-zhen-hual@hp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5548524467851487283=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1387529101-29769-1-git-send-email-zhen-hual-VXdhtT5mjnY@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Li, Zhen-Hua" <zhen-hual-VXdhtT5mjnY@public.gmane.org>
Cc: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

--===============5548524467851487283==
Content-Type: multipart/alternative; boundary=047d7bdc12808d2de304ee6644df

--047d7bdc12808d2de304ee6644df
Content-Type: text/plain; charset=ISO-8859-1

Just curious, why would |= operation cause problem? :)


On Fri, Dec 20, 2013 at 4:45 PM, Li, Zhen-Hua <zhen-hual-VXdhtT5mjnY@public.gmane.org> wrote:

> There is a structure named context_entry used by intel iommu, and there
> are some bit operations on it. Use bit structure may make these operations
> easy.
> Also the function context_set_address_root may cause problem because it
> uses
>  |= operation, not set the new value. And this patch can fix it.
>
> Signed-off-by: Li, Zhen-Hua <zhen-hual-VXdhtT5mjnY@public.gmane.org>
> ---
>  drivers/iommu/intel-iommu.c | 37 +++++++++++++++++++++++++++----------
>  1 file changed, 27 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 43b9bfe..65cd480 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -221,47 +221,64 @@ get_context_addr_from_root(struct root_entry *root)
>   * 8-23: domain id
>   */
>  struct context_entry {
> -       u64 lo;
> -       u64 hi;
> +       union {
> +               struct {
> +                       u64     present:1,
> +                               fpd:1,
> +                               translation_type:2,
> +                               reserved_l:8,
> +                               asr:52;
> +               };
> +               u64 lo;
> +       };
> +       union {
> +               struct {
> +                       u64     aw:3,
> +                               avail:4,
> +                               reserved_h1:1,
> +                               did:16,
> +                               reserved_h2:40;
> +               };
> +               u64 hi;
> +       };
>  };
>
>  static inline bool context_present(struct context_entry *context)
>  {
> -       return (context->lo & 1);
> +       return context->present;
>  }
>  static inline void context_set_present(struct context_entry *context)
>  {
> -       context->lo |= 1;
> +       context->present = 1;
>  }
>
>  static inline void context_set_fault_enable(struct context_entry *context)
>  {
> -       context->lo &= (((u64)-1) << 2) | 1;
> +       context->fpd = 1;
>  }
>
>  static inline void context_set_translation_type(struct context_entry
> *context,
>                                                 unsigned long value)
>  {
> -       context->lo &= (((u64)-1) << 4) | 3;
> -       context->lo |= (value & 3) << 2;
> +       context->translation_type = value;
>  }
>
>  static inline void context_set_address_root(struct context_entry *context,
>                                             unsigned long value)
>  {
> -       context->lo |= value & VTD_PAGE_MASK;
> +       context->asr = value >> VTD_PAGE_SHIFT
>  }
>
>  static inline void context_set_address_width(struct context_entry
> *context,
>                                              unsigned long value)
>  {
> -       context->hi |= value & 7;
> +       context->aw  = value;
>  }
>
>  static inline void context_set_domain_id(struct context_entry *context,
>                                          unsigned long value)
>  {
> -       context->hi |= (value & ((1 << 16) - 1)) << 8;
> +       context->did = value;
>  }
>
>  static inline void context_clear_entry(struct context_entry *context)
> --
> 1.8.4.3
>
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
>

--047d7bdc12808d2de304ee6644df
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Just curious, why would |=3D operation cause problem? :)</=
div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On Fri, D=
ec 20, 2013 at 4:45 PM, Li, Zhen-Hua <span dir=3D"ltr">&lt;<a href=3D"mailt=
o:zhen-hual-VXdhtT5mjnY@public.gmane.org" target=3D"_blank">zhen-hual-VXdhtT5mjnY@public.gmane.org</a>&gt;</span> wrote=
:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">There is a structure named context_entry use=
d by intel iommu, and there<br>
are some bit operations on it. Use bit structure may make these operations<=
br>
easy.<br>
Also the function context_set_address_root may cause problem because it use=
s<br>
=A0|=3D operation, not set the new value. And this patch can fix it.<br>
<br>
Signed-off-by: Li, Zhen-Hua &lt;<a href=3D"mailto:zhen-hual-VXdhtT5mjnY@public.gmane.org">zhen-hu=
al-VXdhtT5mjnY@public.gmane.org</a>&gt;<br>
---<br>
=A0drivers/iommu/intel-iommu.c | 37 +++++++++++++++++++++++++++----------<b=
r>
=A01 file changed, 27 insertions(+), 10 deletions(-)<br>
<br>
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c<br>
index 43b9bfe..65cd480 100644<br>
--- a/drivers/iommu/intel-iommu.c<br>
+++ b/drivers/iommu/intel-iommu.c<br>
@@ -221,47 +221,64 @@ get_context_addr_from_root(struct root_entry *root)<b=
r>
=A0 * 8-23: domain id<br>
=A0 */<br>
=A0struct context_entry {<br>
- =A0 =A0 =A0 u64 lo;<br>
- =A0 =A0 =A0 u64 hi;<br>
+ =A0 =A0 =A0 union {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u64 =A0 =A0 present:1,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fpd:1,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 translation_t=
ype:2,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reserved_l:8,=
<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 asr:52;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 };<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 u64 lo;<br>
+ =A0 =A0 =A0 };<br>
+ =A0 =A0 =A0 union {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u64 =A0 =A0 aw:3,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 avail:4,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reserved_h1:1=
,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 did:16,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reserved_h2:4=
0;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 };<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 u64 hi;<br>
+ =A0 =A0 =A0 };<br>
=A0};<br>
<br>
=A0static inline bool context_present(struct context_entry *context)<br>
=A0{<br>
- =A0 =A0 =A0 return (context-&gt;lo &amp; 1);<br>
+ =A0 =A0 =A0 return context-&gt;present;<br>
=A0}<br>
=A0static inline void context_set_present(struct context_entry *context)<br=
>
=A0{<br>
- =A0 =A0 =A0 context-&gt;lo |=3D 1;<br>
+ =A0 =A0 =A0 context-&gt;present =3D 1;<br>
=A0}<br>
<br>
=A0static inline void context_set_fault_enable(struct context_entry *contex=
t)<br>
=A0{<br>
- =A0 =A0 =A0 context-&gt;lo &amp;=3D (((u64)-1) &lt;&lt; 2) | 1;<br>
+ =A0 =A0 =A0 context-&gt;fpd =3D 1;<br>
=A0}<br>
<br>
=A0static inline void context_set_translation_type(struct context_entry *co=
ntext,<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 unsigned long value)<br>
=A0{<br>
- =A0 =A0 =A0 context-&gt;lo &amp;=3D (((u64)-1) &lt;&lt; 4) | 3;<br>
- =A0 =A0 =A0 context-&gt;lo |=3D (value &amp; 3) &lt;&lt; 2;<br>
+ =A0 =A0 =A0 context-&gt;translation_type =3D value;<br>
=A0}<br>
<br>
=A0static inline void context_set_address_root(struct context_entry *contex=
t,<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 unsigned long value)<br>
=A0{<br>
- =A0 =A0 =A0 context-&gt;lo |=3D value &amp; VTD_PAGE_MASK;<br>
+ =A0 =A0 =A0 context-&gt;asr =3D value &gt;&gt; VTD_PAGE_SHIFT<br>
=A0}<br>
<br>
=A0static inline void context_set_address_width(struct context_entry *conte=
xt,<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0unsigned long value)<br>
=A0{<br>
- =A0 =A0 =A0 context-&gt;hi |=3D value &amp; 7;<br>
+ =A0 =A0 =A0 context-&gt;aw =A0=3D value;<br>
=A0}<br>
<br>
=A0static inline void context_set_domain_id(struct context_entry *context,<=
br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0unsigned long value)<br>
=A0{<br>
- =A0 =A0 =A0 context-&gt;hi |=3D (value &amp; ((1 &lt;&lt; 16) - 1)) &lt;&=
lt; 8;<br>
+ =A0 =A0 =A0 context-&gt;did =3D value;<br>
=A0}<br>
<br>
=A0static inline void context_clear_entry(struct context_entry *context)<br=
>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
1.8.4.3<br>
<br>
_______________________________________________<br>
iommu mailing list<br>
<a href=3D"mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org">iommu-cunTk1MwBs9QetFLy7KEm2CgeU+1il2p@public.gmane.org=
ation.org</a><br>
<a href=3D"https://lists.linuxfoundation.org/mailman/listinfo/iommu" target=
=3D"_blank">https://lists.linuxfoundation.org/mailman/listinfo/iommu</a><br=
>
</font></span></blockquote></div><br></div>

--047d7bdc12808d2de304ee6644df--

--===============5548524467851487283==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5548524467851487283==--
