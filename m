From: Dheeraj CVR <cvr.dheeraj-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [BUGREPORT] Intel X58 Boards don't boot after "iommu/vt-d: Make root
	entry visible for hardware right after allocation"
Date: Sat, 23 Apr 2016 00:35:51 +0400
Message-ID: <CAH-=PyRpjuKf0XJNyzkVLpggaaYq163AfA84SZ5=DQH2Ys5Lkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3472504637934138200=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
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

--===============3472504637934138200==
Content-Type: multipart/alternative; boundary=001a113f998cd2831f053118c5e2

--001a113f998cd2831f053118c5e2
Content-Type: text/plain; charset=UTF-8

I am currently running the following 2 setups.

Intel Xeon X5670
Intel DX58SO (x58)

Intel I7 980
MSI Big Bang X-Power (x58)

I am using IOMMU along with VFIO to passthrough a VGA card on both of my
setups. Everything worked fine till kernel 4.1, but after the introduction
of "iommu/vt-d: Make root entry visible for hardware right after
allocation", both the boards no longer boot with "intel_iommu=on"
commandline parameter.

The logs show the following:
DMAR: RMRR base: 0x000000bf7e8000 end: 0x000000bf7fffff
DMAR: ATSR flags: 0x0
DMAR: dmar0: Using Queued invalidation
------------[ cut here ]------------
WARNING: CPU: 4: PID: 1 at /home/dhiru1602/linux-git/kernel/watchdog.c:311
watchdog_overflow_callback+0x79/0xa0()
Watchdog detected hard LOCKUP on cpu 4
Modules Linked in:
CPU: 4 PID: 1 Comm: swapper/0 Tainted: G              I
4.2.0-iommu-test

The kernel panic occurs very early in the boot process and I was not able
to grab the full kernel panic log.

I have reverted the patch and recompiled the kernel. I was able to boot
fine on both the boards with intel_iommu=on and I was able to see the IOMMU
groups.

On a sidenote, Both the boards have broken interrupt remapping and the
vendors have not provided BIOS updates to fix this problem. There was a
report for the Intel board made on the Intel Community Forums here:
https://communities.intel.com/thread/44752 but there hasn't been an updated
BIOS released by Intel to fix this issue.

Please let me know if more information is needed to diagnose this issue.
-- 
Regards,
Dheeraj CVR.

--001a113f998cd2831f053118c5e2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I am currently running the following 2 setups.<div><br></d=
iv><div><div>Intel Xeon X5670<br></div><div>Intel DX58SO (x58)</div></div><=
div><br></div><div>Intel I7 980</div><div>MSI Big Bang X-Power (x58)</div><=
div><br clear=3D"all"><div>I am using IOMMU along with VFIO to passthrough =
a VGA card on both of my setups. Everything worked fine till kernel 4.1, bu=
t after the introduction of &quot;iommu/vt-d: Make root entry visible for h=
ardware right after allocation&quot;, both the boards no longer boot with &=
quot;intel_iommu=3Don&quot; commandline parameter.</div><div><br></div><div=
>The logs show the following:</div><div>DMAR: RMRR base: 0x000000bf7e8000 e=
nd: 0x000000bf7fffff</div><div>DMAR: ATSR flags: 0x0</div><div>DMAR: dmar0:=
 Using Queued invalidation</div><div>------------[ cut here ]------------</=
div><div>WARNING: CPU: 4: PID: 1 at /home/dhiru1602/linux-git/kernel/watchd=
og.c:311 watchdog_overflow_callback+0x79/0xa0()</div><div>Watchdog detected=
 hard LOCKUP on cpu 4</div><div>Modules Linked in:</div><div>CPU: 4 PID: 1 =
Comm: swapper/0 Tainted: G =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
I =C2=A0 =C2=A0 =C2=A0 4.2.0-iommu-test</div><div><br></div><div>The kernel=
 panic occurs very early in the boot process and I was not able to grab the=
 full kernel panic log.=C2=A0</div><div><br></div><div>I have reverted the =
patch and recompiled the kernel. I was able to boot fine on both the boards=
 with intel_iommu=3Don and I was able to see the IOMMU groups.</div><div><b=
r></div><div>On a sidenote, Both the boards have broken interrupt remapping=
 and the vendors have not provided BIOS updates to fix this problem. There =
was a report for the Intel board made on the Intel Community Forums here:=
=C2=A0<a href=3D"https://communities.intel.com/thread/44752">https://commun=
ities.intel.com/thread/44752</a> but there hasn&#39;t been an updated BIOS =
released by Intel to fix this issue.</div><div><br></div><div>Please let me=
 know if more information is needed to diagnose this issue.</div>-- <br><di=
v class=3D"gmail_signature"><div dir=3D"ltr">Regards,<br>Dheeraj CVR.<br></=
div></div>
</div></div>

--001a113f998cd2831f053118c5e2--

--===============3472504637934138200==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3472504637934138200==--
