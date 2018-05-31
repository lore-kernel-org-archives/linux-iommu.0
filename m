From: Yizhuo Zhai <yzhai003-3vSkeFsW7jA@public.gmane.org>
Subject: Re: [patch] /drivers/iommu/amd_iommu.c: variable unmap_size could be
	uninitialized
Date: Thu, 31 May 2018 11:21:48 -0700
Message-ID: <CABvMjLTh_CGaPnDYPRAX7Wi12eOSzXrtNxpLRiM0nhKsfWztvw@mail.gmail.com>
References: <CABvMjLS3xMmMCSk4Y9Q1rd3398B4kqRi69mn7igPzx6Kt=83cw@mail.gmail.com>
	<20180531094415.GR18595@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2000442818723583208=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180531094415.GR18595-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: Chengyu Song <csong-OqvYMq7jYtE3uPMLIKxrzw@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Zhiyun Qian <zhiyunq-OqvYMq7jYtE3uPMLIKxrzw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

--===============2000442818723583208==
Content-Type: multipart/alternative; boundary="000000000000671fa5056d848a0b"

--000000000000671fa5056d848a0b
Content-Type: text/plain; charset="UTF-8"

Yes, thank you for your advice. The new patch's been sent.

On Thu, May 31, 2018 at 2:44 AM, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:

> Hi Yizhuo Zhai,
>
> thanks for your patch, but I think there is a better way to fix that.
> Please see below.
>
> On Wed, May 30, 2018 at 11:02:54PM -0700, Yizhuo Zhai wrote:
> > Variable "unmap_size" is supposed to be initialized in function
> fetch_pte.
> > However, it's uninitialized if fetch_pte returns NULL. And "unmap_size"
> is used
> > outside the return check.
> >
> > From 377ccb647d3c6c6747f20a242b035bafc775c3be Mon Sep 17 00:00:00 2001
> >
> > Signed-off-by: From: "yzhai003-3vSkeFsW7jA@public.gmane.org" <yzhai003-3vSkeFsW7jA@public.gmane.org>
> > ---
> >  drivers/iommu/amd_iommu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> > index 8fb8c73..774e057 100644
> > --- a/drivers/iommu/amd_iommu.c
> > +++ b/drivers/iommu/amd_iommu.c
> > @@ -1500,7 +1500,7 @@ static unsigned long iommu_unmap_page(struct
> > protection_domain *dom,
> >        unsigned long page_size)
> >  {
> >   unsigned long long unmapped;
> > - unsigned long unmap_size;
> > + unsigned long unmap_size = 0;
>
> That is not sufficient because fetch_pte is called in a loop, and when
> it returns NULL then unmap_size keeps the value of the previous
> invocation.
>
> So from looking at the code, it is better to set page_size=0 in
> fetch_pte at the very beginning, before the function can return NULL.
>
>
> Thanks,
>
>         Joerg
>
>


-- 
Kind Regards,

*Yizhuo Zhai*

*Computer Science, Graduate Student*
*University of California, Riverside *

--000000000000671fa5056d848a0b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Yes, thank you for your advice. The new patch&#39;s been s=
ent.</div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Thu,=
 May 31, 2018 at 2:44 AM, Joerg Roedel <span dir=3D"ltr">&lt;<a href=3D"mai=
lto:joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" target=3D"_blank">joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org</a>&gt;</span> wrote=
:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex">Hi Yizhuo Zhai,<br>
<br>
thanks for your patch, but I think there is a better way to fix that.<br>
Please see below.<br>
<span class=3D""><br>
On Wed, May 30, 2018 at 11:02:54PM -0700, Yizhuo Zhai wrote:<br>
&gt; Variable &quot;unmap_size&quot; is supposed to be initialized in funct=
ion fetch_pte.<br>
&gt; However, it&#39;s uninitialized if fetch_pte returns NULL. And &quot;u=
nmap_size&quot; is used<br>
&gt; outside the return check.=C2=A0<br>
&gt; <br>
&gt; From 377ccb647d3c6c6747f20a242b035b<wbr>afc775c3be Mon Sep 17 00:00:00=
 2001<br>
&gt; <br>
&gt; Signed-off-by: From: &quot;<a href=3D"mailto:yzhai003-3vSkeFsW7jA@public.gmane.org">yzhai00=
3@ucr.edu</a>&quot; &lt;<a href=3D"mailto:yzhai003-3vSkeFsW7jA@public.gmane.org">yzhai003-Kj4AhJ8wZtA@public.gmane.org=
u</a>&gt;<br>
&gt; ---<br>
&gt; =C2=A0drivers/iommu/amd_iommu.c | 2 +-<br>
&gt; =C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c<br>
&gt; index 8fb8c73..774e057 100644<br>
&gt; --- a/drivers/iommu/amd_iommu.c<br>
&gt; +++ b/drivers/iommu/amd_iommu.c<br>
&gt; @@ -1500,7 +1500,7 @@ static unsigned long iommu_unmap_page(struct<br>
&gt; protection_domain *dom,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long page_size)<br>
&gt; =C2=A0{<br>
&gt; =C2=A0 unsigned long long unmapped;<br>
&gt; - unsigned long unmap_size;<br>
&gt; + unsigned long unmap_size =3D 0;<br>
<br>
</span>That is not sufficient because fetch_pte is called in a loop, and wh=
en<br>
it returns NULL then unmap_size keeps the value of the previous<br>
invocation.<br>
<br>
So from looking at the code, it is better to set page_size=3D0 in<br>
fetch_pte at the very beginning, before the function can return NULL.<br>
<br>
<br>
Thanks,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Joerg<br>
<br>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><s=
pan style=3D"font-size:14px">Kind Regards,</span><div style=3D"font-size:14=
px"><br><div><font face=3D"arial, helvetica, sans-serif" size=3D"2"><b>Yizh=
uo Zhai</b></font></div></div><div style=3D"font-size:14px"><br></div><div =
style=3D"font-size:14px"><b>Computer Science, Graduate Student</b></div><di=
v style=3D"font-size:14px"><b>University of California, Riverside=C2=A0</b>=
</div></div></div>
</div>

--000000000000671fa5056d848a0b--

--===============2000442818723583208==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2000442818723583208==--
