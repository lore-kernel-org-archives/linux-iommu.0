From: Christian Zander <christian-dt00mrq0sMmU+1/U8MakDg@public.gmane.org>
Subject: Re: [PATCH] iommu/vt-d: fix range computation when making room for
	large pages
Date: Tue, 13 Oct 2015 13:27:00 -0700
Message-ID: <CAGG72eMgKWT6_bciJNBaX9C-iv4sZHZHK7f+xFY3+iQ7voP_Hg@mail.gmail.com>
References: <20150610164145.GA7583@oriole.nervanasys.com>
	<1444765078.125804.36.camel@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1355930878261075230=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1444765078.125804.36.camel-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Jinpu Wang <jinpu.wang-EIkl63zCoXaH+58JC4qpiA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

--===============1355930878261075230==
Content-Type: multipart/alternative; boundary=047d7b342cfcabdf420522024453

--047d7b342cfcabdf420522024453
Content-Type: text/plain; charset=UTF-8

On Tue, Oct 13, 2015 at 12:37 PM, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
wrote:

> On Wed, 2015-06-10 at 09:41 -0700, Christian Zander wrote:
> > In preparation for the installation of a large page, any small page
> > tables that may still exist in the target IOV address range are
> > removed.  However, if a scatter/gather list entry is large enough to
> > fit more than one large page, the address space for those secondary
> > large pages is not cleared of conflicting small page tables.
> >
> > This can cause legitimate mapping requests to fail with errors of the
> > form below, potentially followed by a series of IOMMU faults:
> >
> > ERROR: DMA PTE for vPFN 0xfde00 already set (to 7f83a4003 not 7e9e00083)
> >
> > In this example, a 4MB scatter/gather list entry resulted in the
> > successful installation of a large page @ vPFN 0xfdc00, followed by
> > a failed attempt to install another large page @ vPFN 0xfde00, due to
> > the presence of a pointer to a small page table @ 0x7f83a4000.
> >
> > To address this problem, compute the number of large pages that fit
> > into a given scatter/gather list entry, and use it to derive the
> > last vPFN covered by the large page(s).
> >
> > Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > Signed-off-by: Christian Zander <christian-dt00mrq0sMmU+1/U8MakDg@public.gmane.org>
>
> Thanks; the fix looks correct. I've pushed it with minor cosmetic fixes
> to my tree, and will send it on to Linus in a few days assuming nothing
> explodes (which of course it shouldn't).
>

Thanks David.


--
> David Woodhouse                            Open Source Technology Centre
> David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org                              Intel Corporation
>
>

--047d7b342cfcabdf420522024453
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On T=
ue, Oct 13, 2015 at 12:37 PM, David Woodhouse <span dir=3D"ltr">&lt;<a href=
=3D"mailto:dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" target=3D"_blank">dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org</a>&g=
t;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">On Wed,=
 2015-06-10 at 09:41 -0700, Christian Zander wrote:<br>
&gt; In preparation for the installation of a large page, any small page<br=
>
&gt; tables that may still exist in the target IOV address range are<br>
&gt; removed.=C2=A0 However, if a scatter/gather list entry is large enough=
 to<br>
&gt; fit more than one large page, the address space for those secondary<br=
>
&gt; large pages is not cleared of conflicting small page tables.<br>
&gt;<br>
&gt; This can cause legitimate mapping requests to fail with errors of the<=
br>
&gt; form below, potentially followed by a series of IOMMU faults:<br>
&gt;<br>
&gt; ERROR: DMA PTE for vPFN 0xfde00 already set (to 7f83a4003 not 7e9e0008=
3)<br>
&gt;<br>
&gt; In this example, a 4MB scatter/gather list entry resulted in the<br>
&gt; successful installation of a large page @ vPFN 0xfdc00, followed by<br=
>
&gt; a failed attempt to install another large page @ vPFN 0xfde00, due to<=
br>
&gt; the presence of a pointer to a small page table @ 0x7f83a4000.<br>
&gt;<br>
&gt; To address this problem, compute the number of large pages that fit<br=
>
&gt; into a given scatter/gather list entry, and use it to derive the<br>
&gt; last vPFN covered by the large page(s).<br>
&gt;<br>
&gt; Cc: <a href=3D"mailto:stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</=
a><br>
&gt; Signed-off-by: Christian Zander &lt;<a href=3D"mailto:christian@nervan=
asys.com">christian-dt00mrq0sMmU+1/U8MakDg@public.gmane.org</a>&gt;<br>
<br>
</span>Thanks; the fix looks correct. I&#39;ve pushed it with minor cosmeti=
c fixes<br>
to my tree, and will send it on to Linus in a few days assuming nothing<br>
explodes (which of course it shouldn&#39;t).<span class=3D"HOEnZb"><font co=
lor=3D"#888888"><br></font></span></blockquote><div><br></div><div>Thanks D=
avid.<br></div><div>=C2=A0<br><br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><spa=
n class=3D"HOEnZb"><font color=3D"#888888">
--<br>
David Woodhouse=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Open Source Technology Centre<br>
<a href=3D"mailto:David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org">David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org</a>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Intel Corporation<br>
<br>
</font></span></blockquote></div><br></div></div>

--047d7b342cfcabdf420522024453--

--===============1355930878261075230==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1355930878261075230==--
