From: Konrad Rzeszutek Wilk <konrad-Gq0aWv8utHQdnm+yROfE0A@public.gmane.org>
Subject: Re: use generic dma-direct and swiotlb code for x86 V3
Date: Tue, 20 Mar 2018 11:25:21 +0000
Message-ID: <CAPbh3rspsGE3i=WzxC4DL=EDTEbhVZVb29j-fyhAXZRwk=Xncg@mail.gmail.com>
References: <20180319103826.12853-1-hch@lst.de>
	<20180319152737.GK1110@char.us.oracle.com>
	<20180319152840.GA28041@lst.de>
	<20180320083751.nrpt64dsmpqbhzc6@gmail.com>
	<20180320084412.GA16337@lst.de>
	<20180320090351.2qnwcsauhodrqxdj@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8357999266012035886=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180320090351.2qnwcsauhodrqxdj-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Tom Lendacky <thomas.lendacky-5C7GfCeVMHo@public.gmane.org>, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Muli Ben-Yehuda <mulix-BzGcCpaT2IbYtjvyW6yDsg@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============8357999266012035886==
Content-Type: multipart/alternative; boundary="94eb2c1990fe2489f80567d65520"

--94eb2c1990fe2489f80567d65520
Content-Type: text/plain; charset="UTF-8"

On Tue, Mar 20, 2018, 5:03 AM Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

>
> * Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org> wrote:
>
> > On Tue, Mar 20, 2018 at 09:37:51AM +0100, Ingo Molnar wrote:
> > > > git://git.infradead.org/users/hch/misc.git dma-direct-x86
> > >
> > > Btw., what's the upstreaming route for these patches?
> > >
> > > While it's a multi-arch series it's all pretty x86-heavy as well so we
> can host it
> > > in -tip (in tip:core/dma or such), but feel free to handle it yourself
> as well:
> > >
> > >   Reviewed-by: Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> >
> > Either way is fine with me.  The dma-mapping tree is pretty light this
> > cycles, so I don't expect any conflicts.  If you want it feel free to
> grab
> > it, otherwise I'll queue it up.
>
> Ok, I picked your series up into tip:core/dma:
>
>  - added the newly arrived Tested-by's and Reviewed-by's
>  - some minor edits to titles/changelogs, no functional changes
>
> will push it all out after testing.
>


Are you testing with swiotlb=force?

Thanks

>
> Thanks,
>
>         Ingo
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
>

--94eb2c1990fe2489f80567d65520
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr">=
On Tue, Mar 20, 2018, 5:03 AM Ingo Molnar &lt;<a href=3D"mailto:mingo@kerne=
l.org">mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex"><br>
* Christoph Hellwig &lt;<a href=3D"mailto:hch-jcswGhMUV9g@public.gmane.org" target=3D"_blank" rel=
=3D"noreferrer">hch-jcswGhMUV9g@public.gmane.org</a>&gt; wrote:<br>
<br>
&gt; On Tue, Mar 20, 2018 at 09:37:51AM +0100, Ingo Molnar wrote:<br>
&gt; &gt; &gt; git://<a href=3D"http://git.infradead.org/users/hch/misc.git=
" rel=3D"noreferrer noreferrer" target=3D"_blank">git.infradead.org/users/h=
ch/misc.git</a> dma-direct-x86<br>
&gt; &gt;<br>
&gt; &gt; Btw., what&#39;s the upstreaming route for these patches?<br>
&gt; &gt;<br>
&gt; &gt; While it&#39;s a multi-arch series it&#39;s all pretty x86-heavy =
as well so we can host it<br>
&gt; &gt; in -tip (in tip:core/dma or such), but feel free to handle it you=
rself as well:<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0Reviewed-by: Ingo Molnar &lt;<a href=3D"mailto:mingo@=
kernel.org" target=3D"_blank" rel=3D"noreferrer">mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org</a>&gt;<b=
r>
&gt;<br>
&gt; Either way is fine with me.=C2=A0 The dma-mapping tree is pretty light=
 this<br>
&gt; cycles, so I don&#39;t expect any conflicts.=C2=A0 If you want it feel=
 free to grab<br>
&gt; it, otherwise I&#39;ll queue it up.<br>
<br>
Ok, I picked your series up into tip:core/dma:<br>
<br>
=C2=A0- added the newly arrived Tested-by&#39;s and Reviewed-by&#39;s<br>
=C2=A0- some minor edits to titles/changelogs, no functional changes<br>
<br>
will push it all out after testing.<br></blockquote></div></div><div dir=3D=
"auto"><br></div><div dir=3D"auto"><br></div><div dir=3D"auto">Are you test=
ing with swiotlb=3Dforce?</div><div dir=3D"auto"><br></div><div dir=3D"auto=
">Thanks</div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex">
<br>
Thanks,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Ingo<br>
_______________________________________________<br>
iommu mailing list<br>
<a href=3D"mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" target=3D"_blank" rel=
=3D"noreferrer">iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org</a><br>
<a href=3D"https://lists.linuxfoundation.org/mailman/listinfo/iommu" rel=3D=
"noreferrer noreferrer" target=3D"_blank">https://lists.linuxfoundation.org=
/mailman/listinfo/iommu</a><br>
</blockquote></div></div></div>

--94eb2c1990fe2489f80567d65520--

--===============8357999266012035886==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8357999266012035886==--
