From: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: Re: [RFC PATCH v6 02/20] iommu: add capability IOMMU_CAP_NOEXEC
Date: Fri, 6 Jun 2014 18:35:06 +0200
Message-ID: <CAG8rG2xMeeExpz9aDMx4oxJDDiQcPOexHZ7xi8oiUemd8=t3Xg@mail.gmail.com>
References: <1401987808-23596-1-git-send-email-a.motakis@virtualopensystems.com>
	<1401987808-23596-3-git-send-email-a.motakis@virtualopensystems.com>
	<1401998627.9207.227.camel@ul30vt.home>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7876699416468763974=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1401998627.9207.227.camel-85EaTFmN5p//9pzu0YdTqQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Shuah Khan <shuah.kh-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, KVM devel mailing list <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexey Kardashevskiy <aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, alvise rigo <a.rigo-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, Stuart Yoder <stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, VirtualOpenSystems Technical Team <tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, kvm-arm <kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org>, Christoffer Dall <christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============7876699416468763974==
Content-Type: multipart/alternative; boundary=001a1134a8e0eb16aa04fb2d72fa

--001a1134a8e0eb16aa04fb2d72fa
Content-Type: text/plain; charset=UTF-8

On Thu, Jun 5, 2014 at 10:03 PM, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
> wrote:

> On Thu, 2014-06-05 at 19:03 +0200, Antonios Motakis wrote:
> > Some IOMMUs accept an IOMMU_NOEXEC protection flag in addition to
> > IOMMU_READ and IOMMU_WRITE. Expose this as an IOMMU capability.
> >
> > Signed-off-by: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
> > ---
> >  include/linux/iommu.h | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index fc464d2..7e152fb 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -57,8 +57,9 @@ struct iommu_domain {
> >       struct iommu_domain_geometry geometry;
> >  };
> >
> > -#define IOMMU_CAP_CACHE_COHERENCY    0x1
> > -#define IOMMU_CAP_INTR_REMAP         0x2     /* isolates device intrs */
> > +#define IOMMU_CAP_CACHE_COHERENCY    (1 << 0)
> > +#define IOMMU_CAP_INTR_REMAP         (1 << 1) /* isolates device intrs
> */
> > +#define IOMMU_CAP_NOEXEC             (1 << 2) /* IOMMU_NOEXEC flag */
> >
> >  /*
> >   * Following constraints are specifc to FSL_PAMUV1:
>
> Hmm, was this really intended to be a bitmap?  Why?  Thanks,
>

Oops, not really :) will change that


>
> Alex
>
>


-- 
Antonios Motakis
Virtual Open Systems

--001a1134a8e0eb16aa04fb2d72fa
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><br><div class=3D"gmail=
_quote">On Thu, Jun 5, 2014 at 10:03 PM, Alex Williamson <span dir=3D"ltr">=
&lt;<a href=3D"mailto:alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" target=3D"_blank">alex.wi=
lliamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On T=
hu, 2014-06-05 at 19:03 +0200, Antonios Motakis wrote:<br>
&gt; Some IOMMUs accept an IOMMU_NOEXEC protection flag in addition to<br>
&gt; IOMMU_READ and IOMMU_WRITE. Expose this as an IOMMU capability.<br>
&gt;<br>
&gt; Signed-off-by: Antonios Motakis &lt;<a href=3D"mailto:a.motakis@virtua=
lopensystems.com">a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org</a>&gt;<br>
&gt; ---<br>
&gt; =C2=A0include/linux/iommu.h | 5 +++--<br>
&gt; =C2=A01 file changed, 3 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/include/linux/iommu.h b/include/linux/iommu.h<br>
&gt; index fc464d2..7e152fb 100644<br>
&gt; --- a/include/linux/iommu.h<br>
&gt; +++ b/include/linux/iommu.h<br>
&gt; @@ -57,8 +57,9 @@ struct iommu_domain {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 struct iommu_domain_geometry geometry;<br>
&gt; =C2=A0};<br>
&gt;<br>
&gt; -#define IOMMU_CAP_CACHE_COHERENCY =C2=A0 =C2=A00x1<br>
&gt; -#define IOMMU_CAP_INTR_REMAP =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x2 =C2=A0 =
=C2=A0 /* isolates device intrs */<br>
&gt; +#define IOMMU_CAP_CACHE_COHERENCY =C2=A0 =C2=A0(1 &lt;&lt; 0)<br>
&gt; +#define IOMMU_CAP_INTR_REMAP =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; =
1) /* isolates device intrs */<br>
&gt; +#define IOMMU_CAP_NOEXEC =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1=
 &lt;&lt; 2) /* IOMMU_NOEXEC flag */<br>
&gt;<br>
&gt; =C2=A0/*<br>
&gt; =C2=A0 * Following constraints are specifc to FSL_PAMUV1:<br>
<br>
</div></div>Hmm, was this really intended to be a bitmap? =C2=A0Why? =C2=A0=
Thanks,<br></blockquote><div><br></div><div>Oops, not really :) will change=
 that<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">


<br>
Alex<br>
<br>
</blockquote></div><br><br clear=3D"all"><br>-- <br>Antonios Motakis<br>Vir=
tual Open Systems
</div></div>

--001a1134a8e0eb16aa04fb2d72fa--

--===============7876699416468763974==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7876699416468763974==--
