From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Linux crash when using FTDI FT232R USB to serial converter on
	AMD boards.
Date: Mon, 29 Apr 2019 11:48:47 +0200
Message-ID: <20190429094847.GI26546@localhost>
References: <04503197-a0a9-8b35-6c65-c10f296aab57@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <04503197-a0a9-8b35-6c65-c10f296aab57-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "StarostaCZ-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <starostacz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Mathias Nyman <mathias.nyman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Apr 26, 2019 at 03:47:15PM +0200, StarostaCZ-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> Hello all,
> we are development and manufacturing company that use your FT232R serial =

> converter for couple of years with our software. We consume about a =

> hundreds pcs of FT232R per yer. We use FT232R as USB serial converter =

> with direct access (no virtual serial port) and as a "hardware key" =

> using FTDIChip-ID. We operate our software with FT232R converters on =

> Windows and Debian Linux operating system.
> =

> We have used Intel motherboards with Intel processors so far. We want to =

> use AMD motherboards with AMD processors too. *We made a couple of tests =

> on AMD motherboards with AMD processors and Debian Linux 9.6, but we =

> have come across a big problem.
> **When we open internal EEPROM of FT232R for reading, there will arise =

> many error messages in system log files. And then Debian Linux crash =

> after some time!*
> =

> =

> _1) Hardware configurations:_
> - motherboards with AMD A320M chipset:
>  =A0 - MSI A320M PRO-VD PLUS, =

> https://www.msi.com/Motherboard/support/A320M-PRO-VD-PLUS
>  =A0 - ASUS PRIME A320M-K, https://www.asus.com/Motherboards/PRIME-A320M-K
>  =A0 - GIGABYTE A320M-S2H, =

> https://www.gigabyte.com/Motherboard/GA-A320M-S2H-rev-1x#kf
> - latest bios installed, default bios configuration loaded,
> - CPU AMD Athlon 200GE, AMD Ryzen 3 2200G
> - 4GB RAM, SSD drive Kingston A400 120GB
> =

> _2a) Operating system A:_
> - Debian Linux 9.6 64bit, https://www.debian.org/distrib/, =

> https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-9.6.0-am=
d64-netinst.iso
> - installed from Netinst installer WITHOUT graphic dekstop, default =

> configuration
> - tested kernels
>  =A0 - default kernel 4.9.0.8-amd64, =

> https://packages.debian.org/stretch/linux-image-4.9.0-8-amd64
>  =A0 - backports kernel 4.18.0-0.bpo.1-amd64, =

> https://packages.debian.org/stretch-backports/linux-image-4.18.0-0.bpo.1-=
amd64
> =

> _2b) Operating system B:_
> - Ubuntu server 19.04 64bit, http://releases.ubuntu.com/19.04/, =

> http://releases.ubuntu.com/19.04/ubuntu-19.04-live-server-amd64.iso
> - installed WITHOUT graphic dekstop, default configuration
> - tested kernels
>  =A0 - default kernel 5.0.0-amd64, =

> https://packages.debian.org/stretch/linux-image-4.9.0-8-amd64
>  =A0 - experimental kernel 5.0.9-050009-generic amd64, =

> https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.0.9/
> =

> _3) Drivers_
> - libftd2xx drivers version 1.4.8, https://www.ftdichip.com/Drivers/D2XX.=
htm
> =

> _4) Performed tests_
> You can repeat this test:
> - connect FT232R into USB2.0 port (not USB3 port!)
> - use examples in directory: ...\libftd2xx-i386-1.4.8.tar\release\example=
s\
> - add parameter "-m32" to "CFLAGS" variable into "Rules.make" file
> - compiled "\examples\EEPROM\user\read\"
> - run script "test.sh" - see attached file
> - *Debian Linux or Ubuntu server crashes after some minutes* - see =

> attached kernel logs from our system
> - see "kern.log" https://paste.ee/p/xxIZ2

So this is a debian 4.18 kernel seemingly crashing due to a xhci or
iommu issue.

Can you reproduce this on a mainline kernel?

If so, please post the corresponding logs to the lists and CC the xhci
and iommu maintainers (added to CC).

> _5) Very important note_
> *This problem occurs when FT232R is connected into USB2.0 port only!*
> When it is connected into USB3 port, all works fine, no error messages, =

> no crash.
> =

> _6) Other test that we made_
> - we made other tests on Windows 10
>  =A0 - same configuration with ASUS PRIME A320M-K motherboard
>  =A0 - latest drivers + latest FTDI drivers
>  =A0 - FT232R connected to USB2.0 or USB3 - no problem
> =

> - we made the same tests on Intel architecture (that we use now)
>  =A0 - motherboard MSI B250M PRO-VH, CPU Intel Pentium G4560, 4GB RAM, SS=
D =

> drive Kingston A400 120GB
>  =A0 - same operating system Debian Linux 9.6 64bit as descripted above
>  =A0 - FT232R connected to USB2.0 or USB3 - no problem

Johan
