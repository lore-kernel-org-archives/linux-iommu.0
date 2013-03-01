From: Justin Piszcz <jpiszcz-BP4nVm5VUdNhbmWW9KSYcQ@public.gmane.org>
Subject: Re: [PATCH] Quirk to support Marvell 88SE91xx SATA controllers with
	Intel IOMMU.
Date: Fri, 1 Mar 2013 12:51:30 -0500
Message-ID: <CAO9zADxjoP+R9ccz7vMPmcFvdYwNjErSjaWc_RFkW_FY3+SK=w@mail.gmail.com>
References: <1354533387-4110-1-git-send-email-acooks@gmail.com>
	<1355914703-28576-1-git-send-email-acooks@gmail.com>
	<1362126373-32318-1-git-send-email-acooks@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8538770677353943118=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1362126373-32318-1-git-send-email-acooks-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Andrew Cooks <acooks-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: gm.ychu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, "open list:INTEL IOMMU (VT-d)" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, xjtuychu-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org, "open list:PCI SUBSYSTEM" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============8538770677353943118==
Content-Type: multipart/alternative; boundary=14dae93995a94460e604d6e0a81b

--14dae93995a94460e604d6e0a81b
Content-Type: text/plain; charset=ISO-8859-1

On Fri, Mar 1, 2013 at 3:26 AM, Andrew Cooks <acooks-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> This is my third submitted patch to make Marvell 88SE91xx SATA controllers
> work when IOMMU is enabled.[1][2]
>
> What's changed:
> * Adopt David Woodhouse's terminology by referring to the quirky functions
> as 'ghost' functions.
> * Unmap ghost functions when device is detached from IOMMU.
> * Stub function for when CONFIG_PCI_QUIRKS is not enabled.
>
> The bad:
> * Still no AMD support.
> * The table of affected chip IDs is as complete as I can make it by
> googling for bug reports.
>
>
>
Hi,

Against 3.7.10:

# patch -p1 <
../RFC-Fix-Intel-IOMMU-support-for-Marvell-88SE91xx-SATA-controllers..patch
patching file drivers/iommu/intel-iommu.c
patching file drivers/pci/quirks.c
Hunk #1 succeeded at 3230 (offset 3 lines).
patching file include/linux/pci.h
#

Recompile kernel, reboot..

Shutdown host, re-attach to Marvell Controller w/IOMMU.

The host still failed to boot, dmesg/panic here:
http://home.comcast.net/~jpiszcz/20130301/boot_failure.JPG

(The root disk is /dev/sdc)

I recompiled again with IOMMU off and it booted ok:

# uname -a
Linux host 3.7.10 #2 SMP Fri Mar 1 12:44:25 EST 2013 x86_64 GNU/Linux

Here is the part of dmesg (what it looks like when it succeeds with
IOMMU=off)

[    4.288113] input: American Megatrends Inc. Virtual Keyboard and Mouse
as /devices/pci0000:00/0000:00:1a.1/usb4/4-2/4-2:1.0/input/input3
[    4.289025] hid-generic 0003:046B:FF10.0001: input,hidraw0: USB HID
v1.10 Keyboard [American Megatrends Inc. Virtual Keyboard and Mouse] on
usb-0000:00:1a.1-2/input0
[    4.305993] input: American Megatrends Inc. Virtual Keyboard and Mouse
as /devices/pci0000:00/0000:00:1a.1/usb4/4-2/4-2:1.1/input/input4
[    4.307106] hid-generic 0003:046B:FF10.0002: input,hidraw1: USB HID
v1.10 Mouse [American Megatrends Inc. Virtual Keyboard and Mouse] on
usb-0000:00:1a.1-2/input1
[    4.326481] ata6: SATA link down (SStatus 0 SControl 300)
[    4.327324] scsi 7:0:0:0: Direct-Access     ATA      INTEL SSDSC2MH25
PWG4 PQ: 0 ANSI: 5
[    4.329953] sd 7:0:0:0: [sdc] 488397168 512-byte logical blocks: (250
GB/232 GiB)
[    4.330639] scsi 14:0:0:0: Processor         Marvell  91xx Config
 1.01 PQ: 0 ANSI: 5
[    4.333276] sd 7:0:0:0: [sdc] Write Protect is off
[    4.334746] sd 7:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[    4.334921] sd 7:0:0:0: [sdc] Write cache: enabled, read cache: enabled,
doesn't support DPO or FUA
[    4.345622]  sdc: sdc1 sdc2
[    4.347493] sd 7:0:0:0: [sdc] Attached SCSI disk


Justin.

--14dae93995a94460e604d6e0a81b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Fri, Mar 1, 2013 at 3:26 AM, Andrew C=
ooks <span dir=3D"ltr">&lt;<a href=3D"mailto:acooks-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_b=
lank">acooks-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex">

This is my third submitted patch to make Marvell 88SE91xx SATA controllers =
work when IOMMU is enabled.[1][2]<br>
<br>
What&#39;s changed:<br>
* Adopt David Woodhouse&#39;s terminology by referring to the quirky functi=
ons as &#39;ghost&#39; functions.<br>
* Unmap ghost functions when device is detached from IOMMU.<br>
* Stub function for when CONFIG_PCI_QUIRKS is not enabled.<br>
<br>
The bad:<br>
* Still no AMD support.<br>
* The table of affected chip IDs is as complete as I can make it by googlin=
g for bug reports.<br>
<br>
<span><font color=3D"#888888"><br></font></span></blockquote><div><br></div=
><div>Hi,</div><div><br></div><div>Against 3.7.10:</div><div><br></div><div=
><div># patch -p1 &lt; ../RFC-Fix-Intel-IOMMU-support-for-Marvell-88SE91xx-=
SATA-controllers..patch=A0</div>

<div>patching file drivers/iommu/intel-iommu.c</div><div>patching file driv=
ers/pci/quirks.c</div><div>Hunk #1 succeeded at 3230 (offset 3 lines).</div=
><div>patching file include/linux/pci.h</div></div><div>#</div><div><br>

</div><div>Recompile kernel, reboot..</div><div><br></div><div>Shutdown hos=
t, re-attach to Marvell Controller w/IOMMU.</div><div><br></div><div>The ho=
st still failed to boot, dmesg/panic here:</div><div><a href=3D"http://home=
.comcast.net/~jpiszcz/20130301/boot_failure.JPG">http://home.comcast.net/~j=
piszcz/20130301/boot_failure.JPG</a></div>
<div><br></div><div>(The root disk is /dev/sdc)</div><div><br></div><div>I =
recompiled again with IOMMU off and it booted ok:</div><div><div><br></div>=
<div># uname -a</div><div>Linux host 3.7.10 #2 SMP Fri Mar 1 12:44:25 EST 2=
013 x86_64 GNU/Linux</div>
</div><div><br></div><div>Here is the part of dmesg (what it looks like whe=
n it succeeds with IOMMU=3Doff)</div><div><br></div><div><div>[ =A0 =A04.28=
8113] input: American Megatrends Inc. Virtual Keyboard and Mouse as /device=
s/pci0000:00/0000:00:1a.1/usb4/4-2/4-2:1.0/input/input3</div>
<div>[ =A0 =A04.289025] hid-generic 0003:046B:FF10.0001: input,hidraw0: USB=
 HID v1.10 Keyboard [American Megatrends Inc. Virtual Keyboard and Mouse] o=
n usb-0000:00:1a.1-2/input0</div><div>[ =A0 =A04.305993] input: American Me=
gatrends Inc. Virtual Keyboard and Mouse as /devices/pci0000:00/0000:00:1a.=
1/usb4/4-2/4-2:1.1/input/input4</div>
<div>[ =A0 =A04.307106] hid-generic 0003:046B:FF10.0002: input,hidraw1: USB=
 HID v1.10 Mouse [American Megatrends Inc. Virtual Keyboard and Mouse] on u=
sb-0000:00:1a.1-2/input1</div><div>[ =A0 =A04.326481] ata6: SATA link down =
(SStatus 0 SControl 300)</div>
<div>[ =A0 =A04.327324] scsi 7:0:0:0: Direct-Access =A0 =A0 ATA =A0 =A0 =A0=
INTEL SSDSC2MH25 PWG4 PQ: 0 ANSI: 5</div><div>[ =A0 =A04.329953] sd 7:0:0:0=
: [sdc] 488397168 512-byte logical blocks: (250 GB/232 GiB)</div><div>[ =A0=
 =A04.330639] scsi 14:0:0:0: Processor =A0 =A0 =A0 =A0 Marvell =A091xx Conf=
ig =A0 =A0 =A01.01 PQ: 0 ANSI: 5</div>
<div>[ =A0 =A04.333276] sd 7:0:0:0: [sdc] Write Protect is off</div><div>[ =
=A0 =A04.334746] sd 7:0:0:0: [sdc] Mode Sense: 00 3a 00 00</div><div>[ =A0 =
=A04.334921] sd 7:0:0:0: [sdc] Write cache: enabled, read cache: enabled, d=
oesn&#39;t support DPO or FUA</div>
<div>[ =A0 =A04.345622] =A0sdc: sdc1 sdc2</div><div>[ =A0 =A04.347493] sd 7=
:0:0:0: [sdc] Attached SCSI disk</div></div><div><br></div><div><br></div><=
div>Justin.</div><div>=A0</div></div><br>

--14dae93995a94460e604d6e0a81b--

--===============8538770677353943118==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8538770677353943118==--
