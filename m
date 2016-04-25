From: Dheeraj CVR <cvr.dheeraj-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [BUGREPORT] Intel X58 Boards don't boot after "iommu/vt-d: Make
	root entry visible for hardware right after allocation"
Date: Mon, 25 Apr 2016 07:19:52 +0400
Message-ID: <CAH-=PyR-6sY1vuzQSfJyh35Q+WqZKD70Ev7vDns+02h8j=m18Q@mail.gmail.com>
References: <CAH-=PyRpjuKf0XJNyzkVLpggaaYq163AfA84SZ5=DQH2Ys5Lkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7000127866150006344=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAH-=PyRpjuKf0XJNyzkVLpggaaYq163AfA84SZ5=DQH2Ys5Lkw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

--===============7000127866150006344==
Content-Type: multipart/alternative; boundary=001a113ed2ec655acf053146a644

--001a113ed2ec655acf053146a644
Content-Type: text/plain; charset=UTF-8

I have tried to grab details about the kernel panic stack trace to make it
easier for Joerg to identify and fix the issue. I have downloaded the
latest Kubuntu Live ISO image which is based on kernel 4.2.0. I have
changed the boot parameters to boot with intel_iommu=on. I was able to
capture the kernel panic with slow motion video recording. The hard lockup
appears to occur when calling "flush_context".

Testing with:
Intel I7 980
MSI Big Bang X-Power (X58)

Here are the images of the kernel panic.
http://s31.postimg.org/5s0zzdu63/Screenshot_from_2016_04_23_00_04_32.png
http://s31.postimg.org/juris3oxn/Screenshot_from_2016_04_23_00_47_00.png

Exactly same kernel panic happens on Intel DX58SO board with a Xeon
processor when using intel_iommu=on commandline parameter.

On Sat, Apr 23, 2016 at 12:35 AM, Dheeraj CVR <cvr.dheeraj-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> I am currently running the following 2 setups.
>
> Intel Xeon X5670
> Intel DX58SO (x58)
>
> Intel I7 980
> MSI Big Bang X-Power (x58)
>
> I am using IOMMU along with VFIO to passthrough a VGA card on both of my
> setups. Everything worked fine till kernel 4.1, but after the introduction
> of "iommu/vt-d: Make root entry visible for hardware right after
> allocation", both the boards no longer boot with "intel_iommu=on"
> commandline parameter.
>
> The logs show the following:
> DMAR: RMRR base: 0x000000bf7e8000 end: 0x000000bf7fffff
> DMAR: ATSR flags: 0x0
> DMAR: dmar0: Using Queued invalidation
> ------------[ cut here ]------------
> WARNING: CPU: 4: PID: 1 at /home/dhiru1602/linux-git/kernel/watchdog.c:311
> watchdog_overflow_callback+0x79/0xa0()
> Watchdog detected hard LOCKUP on cpu 4
> Modules Linked in:
> CPU: 4 PID: 1 Comm: swapper/0 Tainted: G              I
> 4.2.0-iommu-test
>
> The kernel panic occurs very early in the boot process and I was not able
> to grab the full kernel panic log.
>
> I have reverted the patch and recompiled the kernel. I was able to boot
> fine on both the boards with intel_iommu=on and I was able to see the IOMMU
> groups.
>
> On a sidenote, Both the boards have broken interrupt remapping and the
> vendors have not provided BIOS updates to fix this problem. There was a
> report for the Intel board made on the Intel Community Forums here:
> https://communities.intel.com/thread/44752 but there hasn't been an
> updated BIOS released by Intel to fix this issue.
>
> Please let me know if more information is needed to diagnose this issue.
> --
> Regards,
> Dheeraj CVR.
>



-- 
Regards,
Dheeraj CVR.

--001a113ed2ec655acf053146a644
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I have tried to grab details about the kernel panic stack =
trace to make it easier for Joerg to identify and fix the issue. I have dow=
nloaded the latest Kubuntu Live ISO image which is based on kernel 4.2.0. I=
 have changed the boot parameters to boot with intel_iommu=3Don. I was able=
 to capture the kernel panic with slow motion video recording. The hard loc=
kup appears to occur when calling &quot;flush_context&quot;.<div><br></div>=
<div>Testing with:</div><div>Intel I7 980</div><div>MSI Big Bang X-Power (X=
58)</div><div><br><div>Here are the images of the kernel panic.<br></div><d=
iv><a href=3D"http://s31.postimg.org/5s0zzdu63/Screenshot_from_2016_04_23_0=
0_04_32.png" target=3D"_blank">http://s31.postimg.org/5s0zzdu63/Screenshot_=
from_2016_04_23_00_04_32.png</a><br></div><div><a href=3D"http://s31.postim=
g.org/juris3oxn/Screenshot_from_2016_04_23_00_47_00.png" target=3D"_blank">=
http://s31.postimg.org/juris3oxn/Screenshot_from_2016_04_23_00_47_00.png</a=
><br></div></div><div><br></div><div>Exactly same kernel panic happens on I=
ntel DX58SO board with a Xeon processor when using intel_iommu=3Don command=
line parameter.</div><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Sat, Apr 23, 2016 at 12:35 AM, Dheeraj CVR <span dir=3D"ltr">&lt;<a =
href=3D"mailto:cvr.dheeraj-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">cvr.dheeraj@gmail.c=
om</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"=
>I am currently running the following 2 setups.<div><br></div><div><div>Int=
el Xeon X5670<br></div><div>Intel DX58SO (x58)</div></div><div><br></div><d=
iv>Intel I7 980</div><div>MSI Big Bang X-Power (x58)</div><div><br clear=3D=
"all"><div>I am using IOMMU along with VFIO to passthrough a VGA card on bo=
th of my setups. Everything worked fine till kernel 4.1, but after the intr=
oduction of &quot;iommu/vt-d: Make root entry visible for hardware right af=
ter allocation&quot;, both the boards no longer boot with &quot;intel_iommu=
=3Don&quot; commandline parameter.</div><div><br></div><div>The logs show t=
he following:</div><div>DMAR: RMRR base: 0x000000bf7e8000 end: 0x000000bf7f=
ffff</div><div>DMAR: ATSR flags: 0x0</div><div>DMAR: dmar0: Using Queued in=
validation</div><div>------------[ cut here ]------------</div><div>WARNING=
: CPU: 4: PID: 1 at /home/dhiru1602/linux-git/kernel/watchdog.c:311 watchdo=
g_overflow_callback+0x79/0xa0()</div><div>Watchdog detected hard LOCKUP on =
cpu 4</div><div>Modules Linked in:</div><div>CPU: 4 PID: 1 Comm: swapper/0 =
Tainted: G =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0I =C2=A0 =C2=A0 =
=C2=A0 4.2.0-iommu-test</div><div><br></div><div>The kernel panic occurs ve=
ry early in the boot process and I was not able to grab the full kernel pan=
ic log.=C2=A0</div><div><br></div><div>I have reverted the patch and recomp=
iled the kernel. I was able to boot fine on both the boards with intel_iomm=
u=3Don and I was able to see the IOMMU groups.</div><div><br></div><div>On =
a sidenote, Both the boards have broken interrupt remapping and the vendors=
 have not provided BIOS updates to fix this problem. There was a report for=
 the Intel board made on the Intel Community Forums here:=C2=A0<a href=3D"h=
ttps://communities.intel.com/thread/44752" target=3D"_blank">https://commun=
ities.intel.com/thread/44752</a> but there hasn&#39;t been an updated BIOS =
released by Intel to fix this issue.</div><div><br></div><div>Please let me=
 know if more information is needed to diagnose this issue.</div><span><fon=
t color=3D"#888888">-- <br><div><div dir=3D"ltr">Regards,<br>Dheeraj CVR.<b=
r></div></div>
</font></span></div></div>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div><div di=
r=3D"ltr">Regards,<br>Dheeraj CVR.<br></div></div>
</div></div>

--001a113ed2ec655acf053146a644--

--===============7000127866150006344==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7000127866150006344==--
