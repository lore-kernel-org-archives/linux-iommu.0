From: Konrad Rzeszutek Wilk <konrad-Gq0aWv8utHQdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/1] swiotlb: save io_tlb_used to local variable before
	leaving critical section
Date: Mon, 15 Apr 2019 07:26:28 -0400
Message-ID: <CAPbh3rvyVd_D9tMfE-Bo2JmdabaiQnaipmmadc67tUt_Lrt2gw@mail.gmail.com>
References: <1555069106-2964-1-git-send-email-dongli.zhang@oracle.com>
	<5bdc3265-e5a4-e8c8-9098-0bba18a66f19@oracle.com>
	<38f6f868-013e-5619-b939-a8273fc64ee4@oracle.com>
Reply-To: konrad-Gq0aWv8utHQdnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6932956733148858444=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <38f6f868-013e-5619-b939-a8273fc64ee4-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Dongli Zhang <dongli.zhang-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, joe.jin-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, haakon.bugge-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

--===============6932956733148858444==
Content-Type: multipart/alternative; boundary="0000000000001ae7b505868fedb0"

--0000000000001ae7b505868fedb0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2019, 2:50 AM Dongli Zhang <dongli.zhang-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org> wrote:

> As the patch to be fixed is still in Konrad's own tree, I will send the v=
2
> for
> the patch to be fixed, instead of an incremental fix.
>

I squashed it in.


> Dongli Zhang
>
> On 4/12/19 10:13 PM, Joe Jin wrote:
> > I'm good to have this patch, which helps identify the cause of failure =
is
> > fragmentation or it really been used up.
> >
> > On 4/12/19 4:38 AM, Dongli Zhang wrote:
> >> When swiotlb is full, the kernel would print io_tlb_used. However, the
> >> result might be inaccurate at that time because we have left the
> critical
> >> section protected by spinlock.
> >>
> >> Therefore, we backup the io_tlb_used into local variable before leavin=
g
> >> critical section.
> >>
> >> Fixes: 83ca25948940 ("swiotlb: dump used and total slots when swiotlb
> buffer is full")
> >> Suggested-by: H=C3=A5kon Bugge <haakon.bugge-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
> >> Signed-off-by: Dongli Zhang <dongli.zhang-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
> >
> > Reviewed-by: Joe Jin <joe.jin-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
> >
> > Thanks,
> > Joe
> >
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu

--0000000000001ae7b505868fedb0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Mon, Apr 15, 2019, 2:50 AM Dongli Zhang &lt;<a href=
=3D"mailto:dongli.zhang-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org">dongli.zhang-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org</a>&gt; wrote:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex">As the patch to be fixed is still i=
n Konrad&#39;s own tree, I will send the v2 for<br>
the patch to be fixed, instead of an incremental fix.<br></blockquote></div=
></div><div dir=3D"auto"><br></div><div dir=3D"auto">I squashed it in.</div=
><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">
<br>
Dongli Zhang<br>
<br>
On 4/12/19 10:13 PM, Joe Jin wrote:<br>
&gt; I&#39;m good to have this patch, which helps identify the cause of fai=
lure is<br>
&gt; fragmentation or it really been used up.<br>
&gt; <br>
&gt; On 4/12/19 4:38 AM, Dongli Zhang wrote:<br>
&gt;&gt; When swiotlb is full, the kernel would print io_tlb_used. However,=
 the<br>
&gt;&gt; result might be inaccurate at that time because we have left the c=
ritical<br>
&gt;&gt; section protected by spinlock.<br>
&gt;&gt;<br>
&gt;&gt; Therefore, we backup the io_tlb_used into local variable before le=
aving<br>
&gt;&gt; critical section.<br>
&gt;&gt;<br>
&gt;&gt; Fixes: 83ca25948940 (&quot;swiotlb: dump used and total slots when=
 swiotlb buffer is full&quot;)<br>
&gt;&gt; Suggested-by: H=C3=A5kon Bugge &lt;<a href=3D"mailto:haakon.bugge@=
oracle.com" target=3D"_blank" rel=3D"noreferrer">haakon.bugge-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org</a=
>&gt;<br>
&gt;&gt; Signed-off-by: Dongli Zhang &lt;<a href=3D"mailto:dongli.zhang@ora=
cle.com" target=3D"_blank" rel=3D"noreferrer">dongli.zhang-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org</a>&g=
t;<br>
&gt; <br>
&gt; Reviewed-by: Joe Jin &lt;<a href=3D"mailto:joe.jin-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org" target=
=3D"_blank" rel=3D"noreferrer">joe.jin-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org</a>&gt; <br>
&gt; <br>
&gt; Thanks,<br>
&gt; Joe<br>
&gt; <br>
_______________________________________________<br>
iommu mailing list<br>
<a href=3D"mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" target=3D"_blank" rel=
=3D"noreferrer">iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org</a><br>
<a href=3D"https://lists.linuxfoundation.org/mailman/listinfo/iommu" rel=3D=
"noreferrer noreferrer" target=3D"_blank">https://lists.linuxfoundation.org=
/mailman/listinfo/iommu</a></blockquote></div></div></div>

--0000000000001ae7b505868fedb0--

--===============6932956733148858444==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6932956733148858444==--
