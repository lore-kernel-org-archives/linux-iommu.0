From: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: Re: [RFC 0/5] vfio: AMBA devices support
Date: Tue, 26 Aug 2014 09:39:47 +0200
Message-ID: <CAG8rG2wxgut1NsUtDyVSLqt1VVbhO5MxJL2-TLeN+ZQ-H58yHw@mail.gmail.com>
References: <1408698088-5349-1-git-send-email-a.motakis@virtualopensystems.com>
	<20140825185611.cc359282a66d6afe7a4a590e@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5216564011077527649=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140825185611.cc359282a66d6afe7a4a590e-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Kim Phillips <kim.phillips-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Stuart Yoder <stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, KVM devel mailing list <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, alvise rigo <a.rigo-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, VirtualOpenSystems Technical Team <tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, kvm-arm <kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org>, Christoffer Dall <christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============5216564011077527649==
Content-Type: multipart/alternative; boundary=047d7bf17d6ca11d3705018369b0

--047d7bf17d6ca11d3705018369b0
Content-Type: text/plain; charset=UTF-8

On Tue, Aug 26, 2014 at 1:56 AM, Kim Phillips <kim.phillips-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
wrote:

> On Fri, 22 Aug 2014 11:01:23 +0200
> Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org> wrote:
>
> > This patch series depends on the VFIO for PLATFORM devices patch series,
> > and implements AMBA device support for VFIO.
>
> ...
>
> >  drivers/amba/bus.c                            |  43 +++
> >  drivers/vfio/platform/Kconfig                 |  10 +
> >  drivers/vfio/platform/Makefile                |   6 +-
> >  drivers/vfio/platform/vfio_amba.c             | 129 +++++++++
> >  drivers/vfio/platform/vfio_platform.c         | 355
> +-----------------------
> >  drivers/vfio/platform/vfio_platform_common.c  | 380
> ++++++++++++++++++++++++++
> >  drivers/vfio/platform/vfio_platform_irq.c     |   6 +-
> >  drivers/vfio/platform/vfio_platform_private.h |   9 +-
> >  include/linux/amba/bus.h                      |   1 +
> >  9 files changed, 591 insertions(+), 348 deletions(-)
> >  create mode 100644 drivers/vfio/platform/vfio_amba.c
> >  create mode 100644 drivers/vfio/platform/vfio_platform_common.c
>
> I think this patchseries should be merged with its dependent
> patchseries, in order to not have to review the common vfio_platform
> code twice.
>
>
Yeah, my intention is to squash them into one series for the next version
of VFIO PLATFORM, so we are in agreement here.


just my 2c.
>
> Thanks,
>
> Kim
>



-- 
Antonios Motakis
Virtual Open Systems

--047d7bf17d6ca11d3705018369b0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><br><div class=3D"gmail=
_quote">On Tue, Aug 26, 2014 at 1:56 AM, Kim Phillips <span dir=3D"ltr">&lt=
;<a href=3D"mailto:kim.phillips-KZfg59tc24xl57MIdRCFDg@public.gmane.org" target=3D"_blank">kim.philli=
ps-KZfg59tc24xl57MIdRCFDg@public.gmane.org</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"">On Fri, 22 Aug 2014 11:01:23=
 +0200<br>
Antonios Motakis &lt;<a href=3D"mailto:a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org">a.=
motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org</a>&gt; wrote:<br>
<br>
&gt; This patch series depends on the VFIO for PLATFORM devices patch serie=
s,<br>
&gt; and implements AMBA device support for VFIO.<br>
<br>
</div>...<br>
<div class=3D""><br>
&gt;=C2=A0 drivers/amba/bus.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 43 +++<br>
&gt;=C2=A0 drivers/vfio/platform/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 10 +<br>
&gt;=C2=A0 drivers/vfio/platform/Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A06 +-<br>
&gt;=C2=A0 drivers/vfio/platform/vfio_amba.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| 129 +++++++++<br>
&gt;=C2=A0 drivers/vfio/platform/vfio_platform.c=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0| 355 +-----------------------<br>
&gt;=C2=A0 drivers/vfio/platform/vfio_platform_common.c=C2=A0 | 380 +++++++=
+++++++++++++++++++<br>
&gt;=C2=A0 drivers/vfio/platform/vfio_platform_irq.c=C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A06 +-<br>
&gt;=C2=A0 drivers/vfio/platform/vfio_platform_private.h |=C2=A0 =C2=A09 +-=
<br>
&gt;=C2=A0 include/linux/amba/bus.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 9 files changed, 591 insertions(+), 348 deletions(-)<br>
&gt;=C2=A0 create mode 100644 drivers/vfio/platform/vfio_amba.c<br>
&gt;=C2=A0 create mode 100644 drivers/vfio/platform/vfio_platform_common.c<=
br>
<br>
</div>I think this patchseries should be merged with its dependent<br>
patchseries, in order to not have to review the common vfio_platform<br>
code twice.<br>
<br></blockquote><div><br></div><div>Yeah, my intention is to squash them i=
nto one series for the next version of VFIO PLATFORM, so we are in agreemen=
t here.<br></div><div>=C2=A0<br><br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">


just my 2c.<br>
<br>
Thanks,<br>
<br>
Kim<br>
</blockquote></div><br><br clear=3D"all"><br>-- <br>Antonios Motakis<br>Vir=
tual Open Systems
</div></div>

--047d7bf17d6ca11d3705018369b0--

--===============5216564011077527649==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5216564011077527649==--
