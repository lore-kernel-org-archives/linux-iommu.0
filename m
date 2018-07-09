From: =?UTF-8?Q?Micha=C5=82_Nazarewicz?= <mina86-deATy8a+UHjQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2] mm/cma: remove unsupported gfp_mask parameter from
	cma_alloc()
Date: Mon, 9 Jul 2018 15:23:38 +0100
Message-ID: <CA+pa1O2H-rbTqgKgtSzD9jdnyxkD5w62b0Q=o5FX5Y85hCGVnA@mail.gmail.com>
References: <CGME20180709122019eucas1p2340da484acfcc932537e6014f4fd2c29@eucas1p2.samsung.com>
	<20180709121956.20200-1-m.szyprowski@samsung.com>
	<20180709122019eucas1p2340da484acfcc932537e6014f4fd2c29~-sqTPJKij2939229392eucas1p2j@eucas1p2.samsung.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1179940451339019588=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180709122019eucas1p2340da484acfcc932537e6014f4fd2c29~-sqTPJKij2939229392eucas1p2j-PmokGAFL9ItqW5MlFJXMulaTQe2KTcn/@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Michal Hocko <mhocko-IBi9RG/b67k@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Paul Mackerras <paulus-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, Sumit Semwal <sumit.semwal-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Laura Abbott <labbott-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, Joonsoo Kim <iamjoonsoo.kim-Hm3cg6mZ9cc@public.gmane.org>, Vlastimil Babka <vbabka-AlSwsSmVLrQ@public.gmane.org>, Chris Zankel <chris-YvXeqwSYzG2sTnJN9+BGXg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Martin Schwidefsky <schwidefsky-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

--===============1179940451339019588==
Content-Type: multipart/alternative; boundary="000000000000277366057091c3be"

--000000000000277366057091c3be
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 9 Jul 2018 13:20 Marek Szyprowski, <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote=
:

> cma_alloc() function doesn't really support gfp flags other than
> __GFP_NOWARN, so convert gfp_mask parameter to boolean no_warn parameter.
>
> This will help to avoid giving false feeling that this function supports
> standard gfp flags and callers can pass __GFP_ZERO to get zeroed buffer,
> what has already been an issue: see commit dd65a941f6ba ("arm64:
> dma-mapping: clear buffers allocated with FORCE_CONTIGUOUS flag").
>
> Signed-off-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>

Acked-by: Micha=C5=82 Nazarewicz <mina86-deATy8a+UHjQT0dZR+AlfA@public.gmane.org>

(Adding Acked-by on a phone is surprisingly hard).

---
>  arch/powerpc/kvm/book3s_hv_builtin.c       | 2 +-
>  drivers/s390/char/vmcp.c                   | 2 +-
>  drivers/staging/android/ion/ion_cma_heap.c | 2 +-
>  include/linux/cma.h                        | 2 +-
>  kernel/dma/contiguous.c                    | 3 ++-
>  mm/cma.c                                   | 8 ++++----
>  mm/cma_debug.c                             | 2 +-
>  7 files changed, 11 insertions(+), 10 deletions(-)
>

--000000000000277366057091c3be
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_quote"><div dir=3D"ltr">On Mon, =
9 Jul 2018 13:20 Marek Szyprowski, &lt;<a href=3D"mailto:m.szyprowski@samsu=
ng.com" target=3D"_blank" rel=3D"noreferrer">m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex">cma_alloc() function does=
n&#39;t really support gfp flags other than<br>
__GFP_NOWARN, so convert gfp_mask parameter to boolean no_warn parameter.<b=
r>
<br>
This will help to avoid giving false feeling that this function supports<br=
>
standard gfp flags and callers can pass __GFP_ZERO to get zeroed buffer,<br=
>
what has already been an issue: see commit dd65a941f6ba (&quot;arm64:<br>
dma-mapping: clear buffers allocated with FORCE_CONTIGUOUS flag&quot;).<br>
<br>
Signed-off-by: Marek Szyprowski &lt;<a href=3D"mailto:m.szyprowski@samsung.=
com" rel=3D"noreferrer noreferrer" target=3D"_blank">m.szyprowski@samsung.c=
om</a>&gt;<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Acked-by: Micha=C5=82 Nazarewicz &lt;<a href=3D"mailto:mina86@min=
a86.com" target=3D"_blank" rel=3D"noreferrer">mina86-deATy8a+UHjQT0dZR+AlfA@public.gmane.org</a>&gt;</di=
v><div dir=3D"auto"><br></div><div dir=3D"auto">(Adding Acked-by on a phone=
 is surprisingly hard).=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"=
auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D=
"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
---<br>
=C2=A0arch/powerpc/kvm/book3s_hv_builtin.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 +-=
<br>
=C2=A0drivers/s390/char/vmcp.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0| 2 +-<br>
=C2=A0drivers/staging/android/ion/ion_cma_heap.c | 2 +-<br>
=C2=A0include/linux/cma.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 +-<br>
=C2=A0kernel/dma/contiguous.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 | 3 ++-<br>
=C2=A0mm/cma.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 8 ++++-=
---<br>
=C2=A0mm/cma_debug.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 +-<br>
=C2=A07 files changed, 11 insertions(+), 10 deletions(-)<br></blockquote></=
div></div></div>

--000000000000277366057091c3be--

--===============1179940451339019588==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1179940451339019588==--
