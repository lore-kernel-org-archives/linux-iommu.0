From: Valerio Passini <valerio.passini-vbqOIlEVYMdeoWH0uzbU5w@public.gmane.org>
Subject: Re: Stability connection problems in ath9k kernel 4.7
Date: Thu, 8 Sep 2016 21:07:56 +0200
Message-ID: <CAC6K2=_Hdkgc_6igoC59J_Cn9=bdye827zbEK7PWtZY6ebh-6Q@mail.gmail.com>
References: <1798564.U2X6r5Zons@automatix> <87wpio155z.fsf@purkki.adurom.net>
	<2596121.7secQ7hYiJ@automatix>
	<87d1kes3qe.fsf@kamboji.qca.qualcomm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2961657067382993921=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <87d1kes3qe.fsf-HodKDYzPHsUD5k0oWYwrnHL1okKdlPRT@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Omer Peleg <omer-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>, David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Adam Morrison <mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============2961657067382993921==
Content-Type: multipart/alternative; boundary=001a113ed61662a223053c03bfc4

--001a113ed61662a223053c03bfc4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I'm hoping having done it right and I can try your first suggestion, but I
really cannot solve this problem by myself: sorry, I have no capabilities
in programming in any known and unknown computer language. Surely, I can
test all the patches you want and report the results but this is the best I
can do. Best regards

Valerio

Il 08/Set/2016 19:25, "Kalle Valo" <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> ha scritto:

> Valerio Passini <valerio.passini-vbqOIlEVYMdeoWH0uzbU5w@public.gmane.org> writes:
>
> > On mercoled=C3=AC 7 settembre 2016 11:32:24 CEST Kalle Valo wrote:
> >> Valerio Passini <valerio.passini-vbqOIlEVYMdeoWH0uzbU5w@public.gmane.org> writes:
> >> > I have found some connection problems since 4.7 release using ath9k
> that
> >> > turn the wifi pretty useless, I think it might be something in the
> power
> >> > management because the signal seems really low. Previously, up to
> kernel
> >> > 4.6.7 everything worked very well.
> >> >
> >> > This is a sample of dmesg in kernel 4.7.2:
> >> >  239.898935] wlp4s0: authenticate with XX:XX:XX:XX:XX:XX
> >> >
> >> > [  239.919995] wlp4s0: send auth to XX:XX:XX:XX:XX:XX  (try 1/3)
> >> > [  239.931877] wlp4s0: authenticated
> >> > [  239.932357] wlp4s0: associate with XX:XX:XX:XX:XX:XX  (try 1/3)
> >> > [  239.942171] wlp4s0: RX AssocResp from XX:XX:XX:XX:XX:XX
> (capab=3D0x431
> >> > status=3D0 aid=3D2)
> >> > [  239.942301] wlp4s0: associated
> >> > [  244.802853] ath: phy0: DMA failed to stop in 10 ms AR_CR=3D0x0000=
0024
> >> > AR_DIAG_SW=3D0x02000020 DMADBG_7=3D0x0000
> >> > 6100
> >> > [  245.931832] wlp4s0: authenticate with XX:XX:XX:XX:XX:XX
> >> > [  245.953028] wlp4s0: send auth to XX:XX:XX:XX:XX:XX  (try 1/3)
> >> > [  245.958702] wlp4s0: authenticated
> >> > [  245.960386] wlp4s0: associate withXX:XX:XX:XX:XX:XX  (try 1/3)
> >> > [  245.980543] wlp4s0: RX AssocResp from XX:XX:XX:XX:XX:XX
> (capab=3D0x431
> >> > status=3D0 aid=3D2)
> >> >
> >> > lspci on 4.6.7 kernel:
> >> > 04:00.0 Network controller: Qualcomm Atheros AR9485 Wireless Network
> >> > Adapter (rev 01)
> >> >
> >> >         Subsystem: AzureWave AR9485 Wireless Network Adapter
> >> >         Flags: bus master, fast devsel, latency 0, IRQ 18
> >> >         Memory at f7900000 (64-bit, non-prefetchable) [size=3D512K]
> >> >         Expansion ROM at f7980000 [disabled] [size=3D64K]
> >> >         Capabilities: [40] Power Management version 2
> >> >         Capabilities: [50] MSI: Enable- Count=3D1/4 Maskable+ 64bit+
> >> >         Capabilities: [70] Express Endpoint, MSI 00
> >> >         Capabilities: [100] Advanced Error Reporting
> >> >         Capabilities: [140] Virtual Channel
> >> >         Capabilities: [160] Device Serial Number
> 00-00-00-00-00-00-00-00
> >> >         Kernel driver in use: ath9k
> >> >         Kernel modules: ath9k
> >> >
> >> > Probably you need some debugging output, but before recompiling the
> kernel
> >> > I would like to know if you are interested in any kind of help from =
me
> >> > and what steps I should take (I'm able to help in testing patches bu=
t
> I'm
> >> > not familiar with git). Thank you
> >>
> >> Usually it's really helpful if you can find the commit id which broke
> >> it. 'git bisect' is a great tool to do that and this seems to be a nic=
e
> >> tutorial how to use it:
> >>
> >> http://webchick.net/node/99
> >>
> >> Instead of commit ids you can use release tags like v4.6 and v4.7 to
> >> make it easier to start the bisect. Just make sure that v4.7 is really
> >> broken and v4.6 works before you start the bisection.
> >
> > Hi Kalle,
> >
> > I tried to understand the whole procedure related to git and git bisect=
,
> and
> > this is the first time I try it, so I can have done some mistake. In th=
e
> git
> > log you'll find the commit that could be guilty for the behaviour I
> reported
> > yesterday. Anyhow, the resulting commit doesn't make any sense to me.
>
> So your bisect found this as the bad commit:
>
> commit 9257b4a206fc0229dd5f84b78e4d1ebf3f91d270
> Author: Omer Peleg <omer-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
> Date:   Wed Apr 20 11:34:11 2016 +0300
>
>     iommu/iova: introduce per-cpu caching to iova allocation
>
> The ath9k log you provided has a DMA warning and iommu problems can
> cause DMA problems but I cannot make any conclusions yet. To confirm
> that this commit really is the problem you could try to revert it with
> 'git revert -n 9257b4a206fc0229dd5f84b78e4d1ebf3f91d270'. For some
> reason I got conflicts but if you are good enough with C you could try
> to fix those yourself. Another option is that you disable iommu and see
> if that helps.
>
> I'm adding more people and mailing lists related to this commit,
> hopefully they have better ideas.
>
> This is Valerio's bisect log:
>
> git bisect start
> # good: [2dcd0af568b0cf583645c8a317dd12e344b1c72a] Linux 4.6
> git bisect good 2dcd0af568b0cf583645c8a317dd12e344b1c72a
> # bad: [523d939ef98fd712632d93a5a2b588e477a7565e] Linux 4.7
> git bisect bad 523d939ef98fd712632d93a5a2b588e477a7565e
> # good: [0694f0c9e20c47063e4237e5f6649ae5ce5a369a] radix tree test suite:
> remove dependencies on height
> git bisect good 0694f0c9e20c47063e4237e5f6649ae5ce5a369a
> # good: [e4f7bdc2ec0d0dcc27f7d70db27a620dfdc1f697] Merge branch
> 'for-4.7-zac'
> of git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata
> git bisect good e4f7bdc2ec0d0dcc27f7d70db27a620dfdc1f697
> # bad: [049ec1b5a76d34a6980cccdb7c0baeb4eed7a993] Merge tag
> 'drm-fixes-for-
> v4.7-rc2' of git://people.freedesktop.org/~airlied/linux
> git bisect bad 049ec1b5a76d34a6980cccdb7c0baeb4eed7a993
> # good: [a10c38a4f385f5d7c173a263ff6bb2d36021b3bb] Merge branch
> 'for-linus' of
> git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client
> git bisect good a10c38a4f385f5d7c173a263ff6bb2d36021b3bb
> # bad: [9ba55cf7cfbfd12a7e914d0d55b7581e896b3f0d] Merge branch 'for-next'
> of
> git://git.kernel.org/pub/scm/linux/kernel/git/nab/target-pending
> git bisect bad 9ba55cf7cfbfd12a7e914d0d55b7581e896b3f0d
> # bad: [c61b49c79e1c1d4bc0c2fdc053ef56e65759b5fd] Merge tag
> 'drm-fixes-v4.7-
> rc1' of git://people.freedesktop.org/~airlied/linux
> git bisect bad c61b49c79e1c1d4bc0c2fdc053ef56e65759b5fd
> # good: [dc03c0f9d12d85286d5e3623aa96d5c2a271b8e6] Merge branch 'misc' of
> git://git.kernel.org/pub/scm/linux/kernel/git/mmarek/kbuild
> git bisect good dc03c0f9d12d85286d5e3623aa96d5c2a271b8e6
> # good: [e28e909c36bb5d6319953822d84df00fce7cbd18] Merge tag 'for-linus'
> of
> git://git.kernel.org/pub/scm/virt/kvm/kvm
> git bisect good e28e909c36bb5d6319953822d84df00fce7cbd18
> # good: [79b3c7164c18e2fe9e69b0dcc0d45bab7ae3c968] Merge branch
> 'drm-next-4.7'
> of git://people.freedesktop.org/~agd5f/linux into drm-next
> git bisect good 79b3c7164c18e2fe9e69b0dcc0d45bab7ae3c968
> # bad: [1e8143db755f745a9842984de5e8b423f583aea2] Merge tag
> 'platform-drivers-
> x86-v4.7-1' of git://git.infradead.org/users/
> dvhart/linux-platform-drivers-x86
> git bisect bad 1e8143db755f745a9842984de5e8b423f583aea2
> # good: [afcedebc6a094224973534f43b396bbbf33fe44e] thinkpad_acpi: save
> kbdlight state on suspend and restore it on resume
> git bisect good afcedebc6a094224973534f43b396bbbf33fe44e
> # good: [2aac630429d986a43ac59525a4cff47a624dc58e] iommu/vt-d: change
> intel-
> iommu to use IOVA frame numbers
> git bisect good 2aac630429d986a43ac59525a4cff47a624dc58e
> # bad: [2566278551d3db875bc3bbfc41b42f2e80392108] Merge git://
> git.infradead.org/intel-iommu
> git bisect bad 2566278551d3db875bc3bbfc41b42f2e80392108
> # bad: [22e2f9fa63b092923873fc8a52955151f4d83274] iommu/vt-d: Use per-cpu
> IOVA
> caching
> git bisect bad 22e2f9fa63b092923873fc8a52955151f4d83274
> # bad: [9257b4a206fc0229dd5f84b78e4d1ebf3f91d270] iommu/iova: introduce
> per-
> cpu caching to iova allocation
> git bisect bad 9257b4a206fc0229dd5f84b78e4d1ebf3f91d270
> # first bad commit: [9257b4a206fc0229dd5f84b78e4d1ebf3f91d270] iommu/iova=
:
> introduce per-cpu caching to iova allocation
>
> --
> Kalle Valo
>

--001a113ed61662a223053c03bfc4
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">I&#39;m hoping having done it right and I can try your first=
 suggestion, but I really cannot solve this problem by myself: sorry, I hav=
e no capabilities in programming in any known and unknown computer language=
. Surely, I can test all the patches you want and report the results but th=
is is the best I can do. Best regards </p>
<p dir=3D"ltr">Valerio </p>
<div class=3D"gmail_extra"><br><div class=3D"gmail_quote">Il 08/Set/2016 19=
:25, &quot;Kalle Valo&quot; &lt;<a href=3D"mailto:kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org">kva=
lo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org</a>&gt; ha scritto:<br type=3D"attribution"><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;=
padding-left:1ex">Valerio Passini &lt;<a href=3D"mailto:valerio.passini@uni=
cam.it">valerio.passini-vbqOIlEVYMdeoWH0uzbU5w@public.gmane.org</a>&gt; writes:<br>
<br>
&gt; On mercoled=C3=AC 7 settembre 2016 11:32:24 CEST Kalle Valo wrote:<br>
&gt;&gt; Valerio Passini &lt;<a href=3D"mailto:valerio.passini-vbqOIlEVYMdeoWH0uzbU5w@public.gmane.org">v=
alerio.passini-vbqOIlEVYMdeoWH0uzbU5w@public.gmane.org</a>&gt; writes:<br>
&gt;&gt; &gt; I have found some connection problems since 4.7 release using=
 ath9k that<br>
&gt;&gt; &gt; turn the wifi pretty useless, I think it might be something i=
n the power<br>
&gt;&gt; &gt; management because the signal seems really low. Previously, u=
p to kernel<br>
&gt;&gt; &gt; 4.6.7 everything worked very well.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; This is a sample of dmesg in kernel 4.7.2:<br>
&gt;&gt; &gt;=C2=A0 239.898935] wlp4s0: authenticate with XX:XX:XX:XX:XX:XX=
<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; [=C2=A0 239.919995] wlp4s0: send auth to XX:XX:XX:XX:XX:XX=C2=
=A0 (try 1/3)<br>
&gt;&gt; &gt; [=C2=A0 239.931877] wlp4s0: authenticated<br>
&gt;&gt; &gt; [=C2=A0 239.932357] wlp4s0: associate with XX:XX:XX:XX:XX:XX=
=C2=A0 (try 1/3)<br>
&gt;&gt; &gt; [=C2=A0 239.942171] wlp4s0: RX AssocResp from XX:XX:XX:XX:XX:=
XX=C2=A0 (capab=3D0x431<br>
&gt;&gt; &gt; status=3D0 aid=3D2)<br>
&gt;&gt; &gt; [=C2=A0 239.942301] wlp4s0: associated<br>
&gt;&gt; &gt; [=C2=A0 244.802853] ath: phy0: DMA failed to stop in 10 ms AR=
_CR=3D0x00000024<br>
&gt;&gt; &gt; AR_DIAG_SW=3D0x02000020 DMADBG_7=3D0x0000<br>
&gt;&gt; &gt; 6100<br>
&gt;&gt; &gt; [=C2=A0 245.931832] wlp4s0: authenticate with XX:XX:XX:XX:XX:=
XX<br>
&gt;&gt; &gt; [=C2=A0 245.953028] wlp4s0: send auth to XX:XX:XX:XX:XX:XX=C2=
=A0 (try 1/3)<br>
&gt;&gt; &gt; [=C2=A0 245.958702] wlp4s0: authenticated<br>
&gt;&gt; &gt; [=C2=A0 245.960386] wlp4s0: associate withXX:XX:XX:XX:XX:XX=
=C2=A0 (try 1/3)<br>
&gt;&gt; &gt; [=C2=A0 245.980543] wlp4s0: RX AssocResp from XX:XX:XX:XX:XX:=
XX=C2=A0 (capab=3D0x431<br>
&gt;&gt; &gt; status=3D0 aid=3D2)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; lspci on 4.6.7 kernel:<br>
&gt;&gt; &gt; 04:00.0 Network controller: Qualcomm Atheros AR9485 Wireless =
Network<br>
&gt;&gt; &gt; Adapter (rev 01)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Subsystem: AzureWave AR9485 =
Wireless Network Adapter<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Flags: bus master, fast devs=
el, latency 0, IRQ 18<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Memory at f7900000 (64-bit, =
non-prefetchable) [size=3D512K]<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Expansion ROM at f7980000 [d=
isabled] [size=3D64K]<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Capabilities: [40] Power Man=
agement version 2<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Capabilities: [50] MSI: Enab=
le- Count=3D1/4 Maskable+ 64bit+<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Capabilities: [70] Express E=
ndpoint, MSI 00<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Capabilities: [100] Advanced=
 Error Reporting<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Capabilities: [140] Virtual =
Channel<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Capabilities: [160] Device S=
erial Number 00-00-00-00-00-00-00-00<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Kernel driver in use: ath9k<=
br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Kernel modules: ath9k<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Probably you need some debugging output, but before recompili=
ng the kernel<br>
&gt;&gt; &gt; I would like to know if you are interested in any kind of hel=
p from me<br>
&gt;&gt; &gt; and what steps I should take (I&#39;m able to help in testing=
 patches but I&#39;m<br>
&gt;&gt; &gt; not familiar with git). Thank you<br>
&gt;&gt;<br>
&gt;&gt; Usually it&#39;s really helpful if you can find the commit id whic=
h broke<br>
&gt;&gt; it. &#39;git bisect&#39; is a great tool to do that and this seems=
 to be a nice<br>
&gt;&gt; tutorial how to use it:<br>
&gt;&gt;<br>
&gt;&gt; <a href=3D"http://webchick.net/node/99" rel=3D"noreferrer" target=
=3D"_blank">http://webchick.net/node/99</a><br>
&gt;&gt;<br>
&gt;&gt; Instead of commit ids you can use release tags like v4.6 and v4.7 =
to<br>
&gt;&gt; make it easier to start the bisect. Just make sure that v4.7 is re=
ally<br>
&gt;&gt; broken and v4.6 works before you start the bisection.<br>
&gt;<br>
&gt; Hi Kalle,<br>
&gt;<br>
&gt; I tried to understand the whole procedure related to git and git bisec=
t, and<br>
&gt; this is the first time I try it, so I can have done some mistake. In t=
he git<br>
&gt; log you&#39;ll find the commit that could be guilty for the behaviour =
I reported<br>
&gt; yesterday. Anyhow, the resulting commit doesn&#39;t make any sense to =
me.<br>
<br>
So your bisect found this as the bad commit:<br>
<br>
commit 9257b4a206fc0229dd5f84b78e4d1e<wbr>bf3f91d270<br>
Author: Omer Peleg &lt;<a href=3D"mailto:omer-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org">omer-5iY8+1pvdbE@public.gmane.org=
chnion.ac.il</a>&gt;<br>
Date:=C2=A0 =C2=A0Wed Apr 20 11:34:11 2016 +0300<br>
<br>
=C2=A0 =C2=A0 iommu/iova: introduce per-cpu caching to iova allocation<br>
<br>
The ath9k log you provided has a DMA warning and iommu problems can<br>
cause DMA problems but I cannot make any conclusions yet. To confirm<br>
that this commit really is the problem you could try to revert it with<br>
&#39;git revert -n 9257b4a206fc0229dd5f84b78e4d1e<wbr>bf3f91d270&#39;. For =
some<br>
reason I got conflicts but if you are good enough with C you could try<br>
to fix those yourself. Another option is that you disable iommu and see<br>
if that helps.<br>
<br>
I&#39;m adding more people and mailing lists related to this commit,<br>
hopefully they have better ideas.<br>
<br>
This is Valerio&#39;s bisect log:<br>
<br>
git bisect start<br>
# good: [<wbr>2dcd0af568b0cf583645c8a317dd12<wbr>e344b1c72a] Linux 4.6<br>
git bisect good 2dcd0af568b0cf583645c8a317dd12<wbr>e344b1c72a<br>
# bad: [<wbr>523d939ef98fd712632d93a5a2b588<wbr>e477a7565e] Linux 4.7<br>
git bisect bad 523d939ef98fd712632d93a5a2b588<wbr>e477a7565e<br>
# good: [<wbr>0694f0c9e20c47063e4237e5f6649a<wbr>e5ce5a369a] radix tree tes=
t suite:<br>
remove dependencies on height<br>
git bisect good 0694f0c9e20c47063e4237e5f6649a<wbr>e5ce5a369a<br>
# good: [<wbr>e4f7bdc2ec0d0dcc27f7d70db27a62<wbr>0dfdc1f697] Merge branch &=
#39;for-4.7-zac&#39;<br>
of git://<a href=3D"http://git.kernel.org/pub/scm/linux/kernel/git/tj/libat=
a" rel=3D"noreferrer" target=3D"_blank">git.kernel.org/pub/scm/<wbr>linux/k=
ernel/git/tj/libata</a><br>
git bisect good e4f7bdc2ec0d0dcc27f7d70db27a62<wbr>0dfdc1f697<br>
# bad: [<wbr>049ec1b5a76d34a6980cccdb7c0bae<wbr>b4eed7a993] Merge tag &#39;=
drm-fixes-for-<br>
v4.7-rc2&#39; of git://<a href=3D"http://people.freedesktop.org/~airlied/li=
nux" rel=3D"noreferrer" target=3D"_blank">people.freedesktop.org/~<wbr>airl=
ied/linux</a><br>
git bisect bad 049ec1b5a76d34a6980cccdb7c0bae<wbr>b4eed7a993<br>
# good: [<wbr>a10c38a4f385f5d7c173a263ff6bb2<wbr>d36021b3bb] Merge branch &=
#39;for-linus&#39; of<br>
git://<a href=3D"http://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-c=
lient" rel=3D"noreferrer" target=3D"_blank">git.kernel.org/pub/scm/<wbr>lin=
ux/kernel/git/sage/ceph-<wbr>client</a><br>
git bisect good a10c38a4f385f5d7c173a263ff6bb2<wbr>d36021b3bb<br>
# bad: [<wbr>9ba55cf7cfbfd12a7e914d0d55b758<wbr>1e896b3f0d] Merge branch &#=
39;for-next&#39; of<br>
git://<a href=3D"http://git.kernel.org/pub/scm/linux/kernel/git/nab/target-=
pending" rel=3D"noreferrer" target=3D"_blank">git.kernel.org/pub/scm/<wbr>l=
inux/kernel/git/nab/target-<wbr>pending</a><br>
git bisect bad 9ba55cf7cfbfd12a7e914d0d55b758<wbr>1e896b3f0d<br>
# bad: [<wbr>c61b49c79e1c1d4bc0c2fdc053ef56<wbr>e65759b5fd] Merge tag &#39;=
drm-fixes-v4.7-<br>
rc1&#39; of git://<a href=3D"http://people.freedesktop.org/~airlied/linux" =
rel=3D"noreferrer" target=3D"_blank">people.freedesktop.org/~<wbr>airlied/l=
inux</a><br>
git bisect bad c61b49c79e1c1d4bc0c2fdc053ef56<wbr>e65759b5fd<br>
# good: [<wbr>dc03c0f9d12d85286d5e3623aa96d5<wbr>c2a271b8e6] Merge branch &=
#39;misc&#39; of<br>
git://<a href=3D"http://git.kernel.org/pub/scm/linux/kernel/git/mmarek/kbui=
ld" rel=3D"noreferrer" target=3D"_blank">git.kernel.org/pub/scm/<wbr>linux/=
kernel/git/mmarek/kbuild</a><br>
git bisect good dc03c0f9d12d85286d5e3623aa96d5<wbr>c2a271b8e6<br>
# good: [<wbr>e28e909c36bb5d6319953822d84df0<wbr>0fce7cbd18] Merge tag &#39=
;for-linus&#39; of<br>
git://<a href=3D"http://git.kernel.org/pub/scm/virt/kvm/kvm" rel=3D"norefer=
rer" target=3D"_blank">git.kernel.org/pub/scm/<wbr>virt/kvm/kvm</a><br>
git bisect good e28e909c36bb5d6319953822d84df0<wbr>0fce7cbd18<br>
# good: [<wbr>79b3c7164c18e2fe9e69b0dcc0d45b<wbr>ab7ae3c968] Merge branch &=
#39;drm-next-4.7&#39;<br>
of git://<a href=3D"http://people.freedesktop.org/~agd5f/linux" rel=3D"nore=
ferrer" target=3D"_blank">people.freedesktop.org/~<wbr>agd5f/linux</a> into=
 drm-next<br>
git bisect good 79b3c7164c18e2fe9e69b0dcc0d45b<wbr>ab7ae3c968<br>
# bad: [<wbr>1e8143db755f745a9842984de5e8b4<wbr>23f583aea2] Merge tag &#39;=
platform-drivers-<br>
x86-v4.7-1&#39; of git://<a href=3D"http://git.infradead.org/users/dvhart/l=
inux-platform-drivers-x86" rel=3D"noreferrer" target=3D"_blank">git.infrade=
ad.org/users/<wbr>dvhart/linux-platform-drivers-<wbr>x86</a><br>
git bisect bad 1e8143db755f745a9842984de5e8b4<wbr>23f583aea2<br>
# good: [<wbr>afcedebc6a094224973534f43b396b<wbr>bbf33fe44e] thinkpad_acpi:=
 save<br>
kbdlight state on suspend and restore it on resume<br>
git bisect good afcedebc6a094224973534f43b396b<wbr>bbf33fe44e<br>
# good: [<wbr>2aac630429d986a43ac59525a4cff4<wbr>7a624dc58e] iommu/vt-d: ch=
ange intel-<br>
iommu to use IOVA frame numbers<br>
git bisect good 2aac630429d986a43ac59525a4cff4<wbr>7a624dc58e<br>
# bad: [<wbr>2566278551d3db875bc3bbfc41b42f<wbr>2e80392108] Merge git://<br=
>
<a href=3D"http://git.infradead.org/intel-iommu" rel=3D"noreferrer" target=
=3D"_blank">git.infradead.org/intel-iommu</a><br>
git bisect bad 2566278551d3db875bc3bbfc41b42f<wbr>2e80392108<br>
# bad: [<wbr>22e2f9fa63b092923873fc8a529551<wbr>51f4d83274] iommu/vt-d: Use=
 per-cpu IOVA<br>
caching<br>
git bisect bad 22e2f9fa63b092923873fc8a529551<wbr>51f4d83274<br>
# bad: [<wbr>9257b4a206fc0229dd5f84b78e4d1e<wbr>bf3f91d270] iommu/iova: int=
roduce per-<br>
cpu caching to iova allocation<br>
git bisect bad 9257b4a206fc0229dd5f84b78e4d1e<wbr>bf3f91d270<br>
# first bad commit: [<wbr>9257b4a206fc0229dd5f84b78e4d1e<wbr>bf3f91d270] io=
mmu/iova:<br>
introduce per-cpu caching to iova allocation<br>
<br>
--<br>
Kalle Valo<br>
</blockquote></div></div>

--001a113ed61662a223053c03bfc4--

--===============2961657067382993921==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2961657067382993921==--
