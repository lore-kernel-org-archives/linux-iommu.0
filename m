From: "G. Richard Bellamy" <rbellamy-1/AleqyZJC8ybS5Ee8rs3A@public.gmane.org>
Subject: Re: AMD-Vi: Event logged [INVALID_DEVICE_REQUEST device=00:14.0
	address=0x000000fdf9103300 flags=0x0600]
Date: Thu, 15 Oct 2015 23:28:03 -0700
Message-ID: <CADw2B2N3VZdXVWTtotomZ2pZ3xb8ZEot=TR7j1gUq7-FM_R41w@mail.gmail.com>
References: <CADw2B2Mzo2DbMMiyTVjBGVc4-f6Koa6sWQjoLmfX7NZ3B4+saA@mail.gmail.com>
	<20151014090649.GI27420@8bytes.org>
	<CADw2B2MzAMhNX5x9kZ5MN0mAh24ttDu=23EGVLy2aq6Paik4tQ@mail.gmail.com>
	<20151014163338.GR27420@8bytes.org>
	<CADw2B2MnBKOMvXOFNKo0-awM5oA7aYnEz0JgCqqOToVYYuzjZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3387643864830374063=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CADw2B2MnBKOMvXOFNKo0-awM5oA7aYnEz0JgCqqOToVYYuzjZQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

--===============3387643864830374063==
Content-Type: multipart/alternative; boundary=001a11c3e73ad7c8d5052232e5a0

--001a11c3e73ad7c8d5052232e5a0
Content-Type: text/plain; charset=UTF-8

Applied the patch, and no longer receiving the kernel error messages.
Haven't tried to do anything with my VMs yet, but thought you'd want to
know sooner than later.

On Wed, Oct 14, 2015 at 4:47 PM, G. Richard Bellamy <rbellamy-1/AleqyZJC8ybS5Ee8rs3A@public.gmane.org>
wrote:

> I don't think I'm explicitly trying to attach to that PCI bus. As far as
> my limited understanding goes, I've got a vanilla virtualization
> configuration, where I'm running some virtio and pv drivers, but they're
> not attaching directly to any specific bus or device.
>
> I'll gladly try this patch - it'll take me a bit to setup and build a
> custom kernel, so stay tuned, it'll probably be a few days at least before
> I am in a place to check it.
>
> -rb
>
> On Wed, Oct 14, 2015 at 9:33 AM, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:
>
>> On Wed, Oct 14, 2015 at 09:05:05AM -0700, G. Richard Bellamy wrote:
>> > When I have "iommu=1 iommu=pt amd_iommu_dump=1" on my Kernel command
>> line, the
>> > messages spam the log so much neither dmesg nor the journal can keep up.
>>
>> Hmm, the ACPI table looks good, which device(s) are you attaching to the
>> guest(s)?
>>
>> Also, can you try if the attached patch changes anything?
>>
>>
>> Thanks,
>>
>>         Joerg
>>
>>
>

--001a11c3e73ad7c8d5052232e5a0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:verdana,=
sans-serif">Applied the patch, and no longer receiving the kernel error mes=
sages. Haven&#39;t tried to do anything with my VMs yet, but thought you&#3=
9;d want to know sooner than later.</div></div><div class=3D"gmail_extra"><=
br><div class=3D"gmail_quote">On Wed, Oct 14, 2015 at 4:47 PM, G. Richard B=
ellamy <span dir=3D"ltr">&lt;<a href=3D"mailto:rbellamy-1/AleqyZJC8ybS5Ee8rs3A@public.gmane.org" targ=
et=3D"_blank">rbellamy-1/AleqyZJC8ybS5Ee8rs3A@public.gmane.org</a>&gt;</span> wrote:<br><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;=
padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fo=
nt-family:verdana,sans-serif">I don&#39;t think I&#39;m explicitly trying t=
o attach to that PCI bus. As far as my limited understanding goes, I&#39;ve=
 got a vanilla virtualization configuration, where I&#39;m running some vir=
tio and pv drivers, but they&#39;re not attaching directly to any specific =
bus or device.<br></div><div class=3D"gmail_default" style=3D"font-family:v=
erdana,sans-serif"><br>I&#39;ll gladly try this patch - it&#39;ll take me a=
 bit to setup and build a custom kernel, so stay tuned, it&#39;ll probably =
be a few days at least before I am in a place to check it.<span class=3D"HO=
EnZb"><font color=3D"#888888"><br><br></font></span></div><span class=3D"HO=
EnZb"><font color=3D"#888888"><div class=3D"gmail_default" style=3D"font-fa=
mily:verdana,sans-serif">-rb<br></div></font></span></div><div class=3D"HOE=
nZb"><div class=3D"h5"><div class=3D"gmail_extra"><br><div class=3D"gmail_q=
uote">On Wed, Oct 14, 2015 at 9:33 AM, Joerg Roedel <span dir=3D"ltr">&lt;<=
a href=3D"mailto:joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" target=3D"_blank">joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org</a>&gt;=
</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex"><span>On Wed, Oct 14, 2015=
 at 09:05:05AM -0700, G. Richard Bellamy wrote:<br>
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
</div></div></blockquote></div><br></div>

--001a11c3e73ad7c8d5052232e5a0--

--===============3387643864830374063==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3387643864830374063==--
