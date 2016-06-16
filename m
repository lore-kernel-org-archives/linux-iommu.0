From: Dheeraj CVR <cvr.dheeraj-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [BUGREPORT] Intel X58 Boards don't boot after "iommu/vt-d: Make
	root entry visible for hardware right after allocation"
Date: Thu, 16 Jun 2016 10:26:20 +0400
Message-ID: <CAH-=PyRBZU95f0XPLZQXyaKLPx+K5iNsQs3ucQRj6BPfj9ERBA@mail.gmail.com>
References: <CAH-=PyRpjuKf0XJNyzkVLpggaaYq163AfA84SZ5=DQH2Ys5Lkw@mail.gmail.com>
	<CAH-=PyR-6sY1vuzQSfJyh35Q+WqZKD70Ev7vDns+02h8j=m18Q@mail.gmail.com>
	<20160425110151.GE17926@8bytes.org>
	<CAH-=PyTGF76sq7LvQH0-28DoK1dXGUOdnCF6z9shF_CWosWYwQ@mail.gmail.com>
	<CAH-=PyTaR-xH7D4eOnFkB-7gojdZW08yHEPP2Gw2-0GjWTA4dw@mail.gmail.com>
	<20160615161149.GJ13971@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1832928553645192621=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160615161149.GJ13971-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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

--===============1832928553645192621==
Content-Type: multipart/alternative; boundary=001a113f91e0096d1705355f518d

--001a113f91e0096d1705355f518d
Content-Type: text/plain; charset=UTF-8

I have added some debugging code to see where exactly the hang
happens. The set_root_entry
call works fine without any issues as you have expected. However, the hang
happens when calling flush_context.

flush_context -> qi_flush_context -> qi_submit_sync

The loop "while (qi->desc_status[wait_index] != QI_DONE) {}" in
"qi_submit_sync" executes indefinitely and the control doesn't break.
Hence, "iommu->flush.flush_context()" never returns.

Tested on 2 X58 Motherboards and both hang at the same place with
intel_iommu=on.

Hope this helps.

On Wed, Jun 15, 2016 at 8:11 PM, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:

> On Fri, Apr 29, 2016 at 04:41:23PM +0400, Dheeraj CVR wrote:
> > Hi Joerg,
> >
> > Did you find time to have a look at the dmesg that I have sent to you in
> the
> > earlier email? Please let me know if you need any more debugging info to
> > diagnose this issue.
>
> Yes, I had a look at the dmesg and went through the code again. I have
> no clue yet why that commit causes the issue on your machine. Between
> the two places in the code where the set_root_entry calls are/were,
> there are no other things going on with the iommu hardware, so it
> shouldn't matter when setting the root entry happens earlier.
>
> Can you try to track down (with some debug code) exactly where it is
> hanging? That might bring some more light into the issue.
>
>
>
>         Joerg
>
>


-- 
Regards,
Dheeraj CVR.

--001a113f91e0096d1705355f518d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span style=3D"font-size:12.8px">I have added some debuggi=
ng code to see where exactly the hang happens. The=C2=A0</span><span style=
=3D"font-size:12.8px">set_root_entry call works fine without any issues as =
you have expected. However, the hang happens when calling flush_context.</s=
pan><div><span style=3D"font-size:12.8px"><br></span></div><div><span style=
=3D"font-size:12.8px">flush_context -&gt; qi_flush_context -&gt; qi_submit_=
sync</span><br></div><div><span style=3D"font-size:12.8px"><font face=3D"ar=
ial, helvetica, sans-serif" color=3D"#000000"><br></font></span></div><div>=
<font face=3D"arial, helvetica, sans-serif" color=3D"#000000">The loop &quo=
t;<span class=3D"" style=3D"font-size:12px;line-height:16.8px;white-space:p=
re">while</span><span style=3D"font-size:12px;line-height:16.8px;white-spac=
e:pre"> (qi-&gt;desc_status[wait_index] !=3D QI_DONE) {}&quot; in &quot;qi_=
submit_sync&quot; executes indefinitely and the control doesn&#39;t break. =
Hence, &quot;</span><span style=3D"font-size:12px;line-height:16.8px;white-=
space:pre">iommu-&gt;flush.</span><span class=3D"" style=3D"font-size:12px;=
line-height:16.8px;white-space:pre">flush_context</span><span style=3D"font=
-size:12px;line-height:16.8px;white-space:pre">()&quot; never returns.</spa=
n></font></div><div><font face=3D"arial, helvetica, sans-serif" color=3D"#0=
00000"><span style=3D"font-size:12px;line-height:16.8px;white-space:pre"><b=
r></span></font></div><div><font face=3D"arial, helvetica, sans-serif" colo=
r=3D"#000000"><span style=3D"font-size:12px;line-height:16.8px;white-space:=
pre">Tested on 2 X58 Motherboards and both hang at the same place with inte=
l_iommu=3Don.</span></font></div><div><font face=3D"arial, helvetica, sans-=
serif" color=3D"#000000"><span style=3D"font-size:12px;line-height:16.8px;w=
hite-space:pre"><br></span></font></div><div><font face=3D"arial, helvetica=
, sans-serif" color=3D"#000000"><span style=3D"font-size:12px;line-height:1=
6.8px;white-space:pre">Hope this helps.</span></font></div></div><div class=
=3D"gmail_extra"><br><div class=3D"gmail_quote">On Wed, Jun 15, 2016 at 8:1=
1 PM, Joerg Roedel <span dir=3D"ltr">&lt;<a href=3D"mailto:joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org"=
 target=3D"_blank">joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org</a>&gt;</span> wrote:<br><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex"><span class=3D"">On Fri, Apr 29, 2016 at 04:41:23PM +0400, =
Dheeraj CVR wrote:<br>
&gt; Hi=C2=A0Joerg,<br>
&gt;<br>
&gt; Did you find time to have a look at the dmesg that I have sent to you =
in the<br>
&gt; earlier email? Please let me know if you need any more debugging info =
to<br>
&gt; diagnose this issue.<br>
<br>
</span>Yes, I had a look at the dmesg and went through the code again. I ha=
ve<br>
no clue yet why that commit causes the issue on your machine. Between<br>
the two places in the code where the set_root_entry calls are/were,<br>
there are no other things going on with the iommu hardware, so it<br>
shouldn&#39;t matter when setting the root entry happens earlier.<br>
<br>
Can you try to track down (with some debug code) exactly where it is<br>
hanging? That might bring some more light into the issue.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Joerg<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div di=
r=3D"ltr">Regards,<br>Dheeraj CVR.<br></div></div>
</div>

--001a113f91e0096d1705355f518d--

--===============1832928553645192621==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1832928553645192621==--
