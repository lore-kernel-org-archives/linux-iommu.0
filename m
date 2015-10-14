From: "G. Richard Bellamy" <rbellamy-1/AleqyZJC8ybS5Ee8rs3A@public.gmane.org>
Subject: Re: AMD-Vi: Event logged [INVALID_DEVICE_REQUEST device=00:14.0
	address=0x000000fdf9103300 flags=0x0600]
Date: Wed, 14 Oct 2015 16:47:37 -0700
Message-ID: <CADw2B2MnBKOMvXOFNKo0-awM5oA7aYnEz0JgCqqOToVYYuzjZQ@mail.gmail.com>
References: <CADw2B2Mzo2DbMMiyTVjBGVc4-f6Koa6sWQjoLmfX7NZ3B4+saA@mail.gmail.com>
	<20151014090649.GI27420@8bytes.org>
	<CADw2B2MzAMhNX5x9kZ5MN0mAh24ttDu=23EGVLy2aq6Paik4tQ@mail.gmail.com>
	<20151014163338.GR27420@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7335595589708840840=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20151014163338.GR27420-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

--===============7335595589708840840==
Content-Type: multipart/alternative; boundary=001a11c25d4eed1fbf0522192f24

--001a11c25d4eed1fbf0522192f24
Content-Type: text/plain; charset=UTF-8

I don't think I'm explicitly trying to attach to that PCI bus. As far as my
limited understanding goes, I've got a vanilla virtualization
configuration, where I'm running some virtio and pv drivers, but they're
not attaching directly to any specific bus or device.

I'll gladly try this patch - it'll take me a bit to setup and build a
custom kernel, so stay tuned, it'll probably be a few days at least before
I am in a place to check it.

-rb

On Wed, Oct 14, 2015 at 9:33 AM, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:

> On Wed, Oct 14, 2015 at 09:05:05AM -0700, G. Richard Bellamy wrote:
> > When I have "iommu=1 iommu=pt amd_iommu_dump=1" on my Kernel command
> line, the
> > messages spam the log so much neither dmesg nor the journal can keep up.
>
> Hmm, the ACPI table looks good, which device(s) are you attaching to the
> guest(s)?
>
> Also, can you try if the attached patch changes anything?
>
>
> Thanks,
>
>         Joerg
>
>

--001a11c25d4eed1fbf0522192f24
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:verdana,=
sans-serif">I don&#39;t think I&#39;m explicitly trying to attach to that P=
CI bus. As far as my limited understanding goes, I&#39;ve got a vanilla vir=
tualization configuration, where I&#39;m running some virtio and pv drivers=
, but they&#39;re not attaching directly to any specific bus or device.<br>=
</div><div class=3D"gmail_default" style=3D"font-family:verdana,sans-serif"=
><br>I&#39;ll gladly try this patch - it&#39;ll take me a bit to setup and =
build a custom kernel, so stay tuned, it&#39;ll probably be a few days at l=
east before I am in a place to check it.<br><br></div><div class=3D"gmail_d=
efault" style=3D"font-family:verdana,sans-serif">-rb<br></div></div><div cl=
ass=3D"gmail_extra"><br><div class=3D"gmail_quote">On Wed, Oct 14, 2015 at =
9:33 AM, Joerg Roedel <span dir=3D"ltr">&lt;<a href=3D"mailto:joro@8bytes.o=
rg" target=3D"_blank">joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org</a>&gt;</span> wrote:<br><blockquote =
class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex"><span class=3D"">On Wed, Oct 14, 2015 at 09:05:05AM -070=
0, G. Richard Bellamy wrote:<br>
&gt; When I have &quot;iommu=3D1 iommu=3Dpt amd_iommu_dump=3D1&quot; on my =
Kernel command line, the<br>
&gt; messages spam the log so much neither dmesg nor the journal can keep u=
p.<br>
<br>
</span>Hmm, the ACPI table looks good, which device(s) are you attaching to=
 the<br>
guest(s)?<br>
<br>
Also, can you try if the attached patch changes anything?<br>
<br>
<br>
Thanks,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Joerg<br>
<br>
</blockquote></div><br></div>

--001a11c25d4eed1fbf0522192f24--

--===============7335595589708840840==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7335595589708840840==--
