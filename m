From: Tom Wimmenhove <tom.wimmenhove-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Kernel hangs when intel_iommu=on on 4.2.0
Date: Tue, 5 Apr 2016 14:39:10 -0400
Message-ID: <CAEDtQEzqdjeG4y5HpW-TNStoCwfmmiGqVzQvWmzbpLrVYLW2Uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8976931724572265834=="
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

--===============8976931724572265834==
Content-Type: multipart/alternative; boundary=001a113eb9304049ca052fc129da

--001a113eb9304049ca052fc129da
Content-Type: text/plain; charset=UTF-8

I am running kernel 4.2.0 on ubuntu 15.10. I have Vt-d enabled in my
BIOS with the latest BIOS version (on a DX58SO board, with a Xeon
W3520).

When I boot with "intel_iommu=on", first the kernel spits out some DMA
remapping messages, sits there for about 10 seconds and then spits a
trace and hangs (no sysrq). On previous kernels (specifically 3.16.0)
I did not have these issues when booting, but sometimes get DMAR
related errors in syslog when using PCI GPU passthrough in a qemu
guest, causing garbage on the screen of the guest.

tom@chef:~$ uname -a
Linux chef 4.2.0-16-generic #19-Ubuntu SMP Thu Oct 8 15:35:06 UTC 2015
x86_64 x86_64 x86_64 GNU/Linux


tom@chef:~$ lspci
00:00.0 Host bridge: Intel Corporation 5520/5500/X58 I/O Hub to ESI
Port (rev 13)
00:01.0 PCI bridge: Intel Corporation 5520/5500/X58 I/O Hub PCI
Express Root Port 1 (rev 13)
00:03.0 PCI bridge: Intel Corporation 5520/5500/X58 I/O Hub PCI
Express Root Port 3 (rev 13)
00:07.0 PCI bridge: Intel Corporation 5520/5500/X58 I/O Hub PCI
Express Root Port 7 (rev 13)
00:10.0 PIC: Intel Corporation 7500/5520/5500/X58 Physical and Link
Layer Registers Port 0 (rev 13)
00:10.1 PIC: Intel Corporation 7500/5520/5500/X58 Routing and Protocol
Layer Registers Port 0 (rev 13)
00:14.0 PIC: Intel Corporation 7500/5520/5500/X58 I/O Hub System
Management Registers (rev 13)
00:14.1 PIC: Intel Corporation 7500/5520/5500/X58 I/O Hub GPIO and
Scratch Pad Registers (rev 13)
00:14.2 PIC: Intel Corporation 7500/5520/5500/X58 I/O Hub Control
Status and RAS Registers (rev 13)
00:14.3 PIC: Intel Corporation 7500/5520/5500/X58 I/O Hub Throttle
Registers (rev 13)
00:19.0 Ethernet controller: Intel Corporation 82567LM-2 Gigabit
Network Connection
00:1a.0 USB controller: Intel Corporation 82801JI (ICH10 Family) USB
UHCI Controller #4
00:1a.1 USB controller: Intel Corporation 82801JI (ICH10 Family) USB
UHCI Controller #5
00:1a.2 USB controller: Intel Corporation 82801JI (ICH10 Family) USB
UHCI Controller #6
00:1a.7 USB controller: Intel Corporation 82801JI (ICH10 Family) USB2
EHCI Controller #2
00:1b.0 Audio device: Intel Corporation 82801JI (ICH10 Family) HD
Audio Controller
00:1c.0 PCI bridge: Intel Corporation 82801JI (ICH10 Family) PCI
Express Root Port 1
00:1c.1 PCI bridge: Intel Corporation 82801JI (ICH10 Family) PCI Express Port 2
00:1c.4 PCI bridge: Intel Corporation 82801JI (ICH10 Family) PCI
Express Root Port 5
00:1d.0 USB controller: Intel Corporation 82801JI (ICH10 Family) USB
UHCI Controller #1
00:1d.1 USB controller: Intel Corporation 82801JI (ICH10 Family) USB
UHCI Controller #2
00:1d.2 USB controller: Intel Corporation 82801JI (ICH10 Family) USB
UHCI Controller #3
00:1d.7 USB controller: Intel Corporation 82801JI (ICH10 Family) USB2
EHCI Controller #1
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 90)
00:1f.0 ISA bridge: Intel Corporation 82801JIR (ICH10R) LPC Interface Controller
00:1f.2 IDE interface: Intel Corporation 82801JI (ICH10 Family) 4 port
SATA IDE Controller #1
00:1f.3 SMBus: Intel Corporation 82801JI (ICH10 Family) SMBus Controller
00:1f.5 IDE interface: Intel Corporation 82801JI (ICH10 Family) 2 port
SATA IDE Controller #2
02:00.0 VGA compatible controller: NVIDIA Corporation GF108 [GeForce
GT 620] (rev a1)
02:00.1 Audio device: NVIDIA Corporation GF108 High Definition Audio
Controller (rev a1)
03:00.0 VGA compatible controller: NVIDIA Corporation G84GL [Quadro FX
570] (rev a1)
04:00.0 USB controller: VIA Technologies, Inc. VL805 USB 3.0 Host
Controller (rev 01)
06:00.0 IDE interface: Marvell Technology Group Ltd. 88SE6121 SATA II
/ PATA Controller (rev b2)
07:02.0 Communication controller: MosChip Semiconductor Technology
Ltd. PCI 9835 Multi-I/O Controller (rev 01)
07:03.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22A
IEEE-1394a-2000 Controller (PHY/Link) [iOHCI-Lynx]
3f:00.0 Host bridge: Intel Corporation Xeon 5500/Core i7 QuickPath
Architecture Generic Non-Core Registers (rev 05)
3f:00.1 Host bridge: Intel Corporation Xeon 5500/Core i7 QuickPath
Architecture System Address Decoder (rev 05)
3f:02.0 Host bridge: Intel Corporation Xeon 5500/Core i7 QPI Link 0 (rev 05)
3f:02.1 Host bridge: Intel Corporation Xeon 5500/Core i7 QPI Physical 0 (rev 05)
3f:03.0 Host bridge: Intel Corporation Xeon 5500/Core i7 Integrated
Memory Controller (rev 05)
3f:03.1 Host bridge: Intel Corporation Xeon 5500/Core i7 Integrated
Memory Controller Target Address Decoder (rev 05)
3f:03.4 Host bridge: Intel Corporation Xeon 5500/Core i7 Integrated
Memory Controller Test Registers (rev 05)
3f:04.0 Host bridge: Intel Corporation Xeon 5500/Core i7 Integrated
Memory Controller Channel 0 Control Registers (rev 05)
3f:04.1 Host bridge: Intel Corporation Xeon 5500/Core i7 Integrated
Memory Controller Channel 0 Address Registers (rev 05)
3f:04.2 Host bridge: Intel Corporation Xeon 5500/Core i7 Integrated
Memory Controller Channel 0 Rank Registers (rev 05)
3f:04.3 Host bridge: Intel Corporation Xeon 5500/Core i7 Integrated
Memory Controller Channel 0 Thermal Control Registers (rev 05)
3f:05.0 Host bridge: Intel Corporation Xeon 5500/Core i7 Integrated
Memory Controller Channel 1 Control Registers (rev 05)
3f:05.1 Host bridge: Intel Corporation Xeon 5500/Core i7 Integrated
Memory Controller Channel 1 Address Registers (rev 05)
3f:05.2 Host bridge: Intel Corporation Xeon 5500/Core i7 Integrated
Memory Controller Channel 1 Rank Registers (rev 05)
3f:05.3 Host bridge: Intel Corporation Xeon 5500/Core i7 Integrated
Memory Controller Channel 1 Thermal Control Registers (rev 05)
3f:06.0 Host bridge: Intel Corporation Xeon 5500/Core i7 Integrated
Memory Controller Channel 2 Control Registers (rev 05)
3f:06.1 Host bridge: Intel Corporation Xeon 5500/Core i7 Integrated
Memory Controller Channel 2 Address Registers (rev 05)
3f:06.2 Host bridge: Intel Corporation Xeon 5500/Core i7 Integrated
Memory Controller Channel 2 Rank Registers (rev 05)
3f:06.3 Host bridge: Intel Corporation Xeon 5500/Core i7 Integrated
Memory Controller Channel 2 Thermal Control Registers (rev 05)

--001a113eb9304049ca052fc129da
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><pre style=3D"white-space:pre-wrap;color:rgb(0,0,0)"><font=
 face=3D"arial, helvetica, sans-serif">I am running kernel 4.2.0 on ubuntu =
15.10. I have Vt-d enabled in my BIOS with the latest BIOS version (on a DX=
58SO board, with a Xeon=C2=A0W3520).</font></pre><pre style=3D"white-space:=
pre-wrap;color:rgb(0,0,0)"><font face=3D"arial, helvetica, sans-serif">When=
 I boot with &quot;intel_iommu=3Don&quot;, first the kernel spits out some =
DMA remapping messages, sits there for about 10 seconds and then spits a tr=
ace and hangs (no sysrq). On previous kernels (specifically 3.16.0) I did n=
ot have these issues when booting, but sometimes get DMAR related errors in=
 syslog when using PCI GPU passthrough in a qemu guest, causing garba</font=
><span style=3D"font-family:arial,sans-serif">ge on the screen of the guest=
.</span></pre><pre style=3D""><font face=3D"arial, sans-serif" style=3D""><=
font color=3D"#000000"><span style=3D"white-space:pre-wrap">tom@chef:~$ una=
me -a
Linux chef 4.2.0-16-generic #19-Ubuntu SMP Thu Oct 8 15:35:06 UTC 2015 x86_=
64 x86_64 x86_64 GNU/Linux</span></font></font></pre><pre style=3D""><font =
face=3D"arial, sans-serif" style=3D""><font color=3D"#000000"><span style=
=3D"white-space:pre-wrap">
tom@chef:~$ lspci
00:00.0 Host bridge: Intel Corporation 5520/5500/X58 I/O Hub to ESI Port (r=
ev 13)
00:01.0 PCI bridge: Intel Corporation 5520/5500/X58 I/O Hub PCI Express Roo=
t Port 1 (rev 13)
00:03.0 PCI bridge: Intel Corporation 5520/5500/X58 I/O Hub PCI Express Roo=
t Port 3 (rev 13)
00:07.0 PCI bridge: Intel Corporation 5520/5500/X58 I/O Hub PCI Express Roo=
t Port 7 (rev 13)
00:10.0 PIC: Intel Corporation 7500/5520/5500/X58 Physical and Link Layer R=
egisters Port 0 (rev 13)
00:10.1 PIC: Intel Corporation 7500/5520/5500/X58 Routing and Protocol Laye=
r Registers Port 0 (rev 13)
00:14.0 PIC: Intel Corporation 7500/5520/5500/X58 I/O Hub System Management=
 Registers (rev 13)
00:14.1 PIC: Intel Corporation 7500/5520/5500/X58 I/O Hub GPIO and Scratch =
Pad Registers (rev 13)
00:14.2 PIC: Intel Corporation 7500/5520/5500/X58 I/O Hub Control Status an=
d RAS Registers (rev 13)
00:14.3 PIC: Intel Corporation 7500/5520/5500/X58 I/O Hub Throttle Register=
s (rev 13)
00:19.0 Ethernet controller: Intel Corporation 82567LM-2 Gigabit Network Co=
nnection
00:1a.0 USB controller: Intel Corporation 82801JI (ICH10 Family) USB UHCI C=
ontroller #4
00:1a.1 USB controller: Intel Corporation 82801JI (ICH10 Family) USB UHCI C=
ontroller #5
00:1a.2 USB controller: Intel Corporation 82801JI (ICH10 Family) USB UHCI C=
ontroller #6
00:1a.7 USB controller: Intel Corporation 82801JI (ICH10 Family) USB2 EHCI =
Controller #2
00:1b.0 Audio device: Intel Corporation 82801JI (ICH10 Family) HD Audio Con=
troller
00:1c.0 PCI bridge: Intel Corporation 82801JI (ICH10 Family) PCI Express Ro=
ot Port 1
00:1c.1 PCI bridge: Intel Corporation 82801JI (ICH10 Family) PCI Express Po=
rt 2
00:1c.4 PCI bridge: Intel Corporation 82801JI (ICH10 Family) PCI Express Ro=
ot Port 5
00:1d.0 USB controller: Intel Corporation 82801JI (ICH10 Family) USB UHCI C=
ontroller #1
00:1d.1 USB controller: Intel Corporation 82801JI (ICH10 Family) USB UHCI C=
ontroller #2
00:1d.2 USB controller: Intel Corporation 82801JI (ICH10 Family) USB UHCI C=
ontroller #3
00:1d.7 USB controller: Intel Corporation 82801JI (ICH10 Family) USB2 EHCI =
Controller #1
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 90)
00:1f.0 ISA bridge: Intel Corporation 82801JIR (ICH10R) LPC Interface Contr=
oller
00:1f.2 IDE interface: Intel Corporation 82801JI (ICH10 Family) 4 port SATA=
 IDE Controller #1
00:1f.3 SMBus: Intel Corporation 82801JI (ICH10 Family) SMBus Controller
00:1f.5 IDE interface: Intel Corporation 82801JI (ICH10 Family) 2 port SATA=
 IDE Controller #2
02:00.0 VGA compatible controller: NVIDIA Corporation GF108 [GeForce GT 620=
] (rev a1)
02:00.1 Audio device: NVIDIA Corporation GF108 High Definition Audio Contro=
ller (rev a1)
03:00.0 VGA compatible controller: NVIDIA Corporation G84GL [Quadro FX 570]=
 (rev a1)
04:00.0 USB controller: VIA Technologies, Inc. VL805 USB 3.0 Host Controlle=
r (rev 01)
06:00.0 IDE interface: Marvell Technology Group Ltd. 88SE6121 SATA II / PAT=
A Controller (rev b2)
07:02.0 Communication controller: MosChip Semiconductor Technology Ltd. PCI=
 9835 Multi-I/O Controller (rev 01)
07:03.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22A IEEE-1394a-2000 =
Controller (PHY/Link) [iOHCI-Lynx]
3f:00.0 Host bridge: Intel Corporation Xeon 5500/Core i7 QuickPath Architec=
ture Generic Non-Core Registers (rev 05)
3f:00.1 Host bridge: Intel Corporation Xeon 5500/Core i7 QuickPath Architec=
ture System Address Decoder (rev 05)
3f:02.0 Host bridge: Intel Corporation Xeon 5500/Core i7 QPI Link 0 (rev 05=
)
3f:02.1 Host bridge: Intel Corporation Xeon 5500/Core i7 QPI Physical 0 (re=
v 05)
3f:03.0 Host bridge: Intel Corporation Xeon 5500/Core i7 Integrated Memory =
Controller (rev 05)
3f:03.1 Host bridge: Intel Corporation Xeon 5500/Core i7 Integrated Memory =
Controller Target Address Decoder (rev 05)
3f:03.4 Host bridge: Intel Corporation Xeon 5500/Core i7 Integrated Memory =
Controller Test Registers (rev 05)
3f:04.0 Host bridge: Intel Corporation Xeon 5500/Core i7 Integrated Memory =
Controller Channel 0 Control Registers (rev 05)
3f:04.1 Host bridge: Intel Corporation Xeon 5500/Core i7 Integrated Memory =
Controller Channel 0 Address Registers (rev 05)
3f:04.2 Host bridge: Intel Corporation Xeon 5500/Core i7 Integrated Memory =
Controller Channel 0 Rank Registers (rev 05)
3f:04.3 Host bridge: Intel Corporation Xeon 5500/Core i7 Integrated Memory =
Controller Channel 0 Thermal Control Registers (rev 05)
3f:05.0 Host bridge: Intel Corporation Xeon 5500/Core i7 Integrated Memory =
Controller Channel 1 Control Registers (rev 05)
3f:05.1 Host bridge: Intel Corporation Xeon 5500/Core i7 Integrated Memory =
Controller Channel 1 Address Registers (rev 05)
3f:05.2 Host bridge: Intel Corporation Xeon 5500/Core i7 Integrated Memory =
Controller Channel 1 Rank Registers (rev 05)
3f:05.3 Host bridge: Intel Corporation Xeon 5500/Core i7 Integrated Memory =
Controller Channel 1 Thermal Control Registers (rev 05)
3f:06.0 Host bridge: Intel Corporation Xeon 5500/Core i7 Integrated Memory =
Controller Channel 2 Control Registers (rev 05)
3f:06.1 Host bridge: Intel Corporation Xeon 5500/Core i7 Integrated Memory =
Controller Channel 2 Address Registers (rev 05)
3f:06.2 Host bridge: Intel Corporation Xeon 5500/Core i7 Integrated Memory =
Controller Channel 2 Rank Registers (rev 05)
3f:06.3 Host bridge: Intel Corporation Xeon 5500/Core i7 Integrated Memory =
Controller Channel 2 Thermal Control Registers (rev 05)</span></font></font=
></pre></div>

--001a113eb9304049ca052fc129da--

--===============8976931724572265834==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8976931724572265834==--
