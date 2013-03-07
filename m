From: JapHack <japhack-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Re: Problem with ethernet/sound with IOMMU enabled on M5A99FX pro
	r2.0 motherboard
Date: Thu, 7 Mar 2013 07:58:10 -0800 (PST)
Message-ID: <1362671890.8814.YahooMailClassic@web120703.mail.ne1.yahoo.com>
References: <5138B15E.6000302@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2457683216670349775=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5138B15E.6000302-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Suravee Suthikulanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

--===============2457683216670349775==
Content-Type: multipart/alternative; boundary="-1480336445-136746299-1362671890=:8814"

---1480336445-136746299-1362671890=:8814
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

acpi.dump http://pastebin.com/2wEYXykY
dmesg.dump http://pastebin.com/ugfpRjxc
lspci -nnk http://pastebin.com/W5HdqQia

I have the onboard ethernet shut off in the bios
but the soundcard is still not being seen with oss4,=20
if iommu is enabled in bios and iommu=3Dpt is not entered in grub.

Thanks, Don

--- On Thu, 3/7/13, Suravee Suthikulanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org> wr=
ote:

From: Suravee Suthikulanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: Re: Problem with ethernet/sound with IOMMU enabled on M5A99FX pro =
r2.0 motherboard
To: japhack-/E1597aS9LQAvxtiuMwx3w@public.gmane.org
Cc: ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Date: Thursday, March 7, 2013, 9:25 AM

=0A  =0A=0A    =0A  =0A  =0A    Hi,
=0A   =20
=0A    Would you please provide the kernel log and the dump of ACPI (from=
=0A    tools like "acpidump")?=A0 These should help debugging the issue.
=0A   =20
=0A    Thank you,
=0A   =20
=0A    Suravee
=0A    =0A      =0A        From: Donald Dutile <ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
=0A          Date: March 7, 2013, 3:08:57 AM GMT+08:00
=0A          To: JapHack <japhack-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
=0A          Cc: <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
=0A          Subject: Re: Problem with ethernet/sound with IOMMU=0A        =
    enabled on M5A99FX pro r2.0 motherboard
=0A         =20
=0A        =0A      =0A      =0A        Probably a missing IVMD block for t=
he sound device.
=0A         =20
=0A          The ethernet device issue could be a driver issue --=20
=0A          DMA write to a page that was mapped for read-only.
=0A          Providing the IO page fault message would help to
=0A          diagnose further.
=0A         =20
=0A          - DonD
=0A         =20
=0A          ----- Original Message -----
=0A          From: "JapHack" <japhack-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
=0A          To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
=0A          Sent: Tuesday, March 5, 2013 2:10:52 PM
=0A          Subject: Problem with ethernet/sound with IOMMU enabled=0A    =
        on M5A99FX pro r2.0 =A0 =A0motherboard
=0A         =20
=0A         =20
=0A          I recently bought this board as I wanted to start doing=0A    =
        pci passthrough emulation.=0A         =20
=0A         =20
=0A          I noticed that after I had installed it and booted up,=0A     =
       with IOMMU enabled =0A         =20
=0A          the network would work fine for a while then I would get=0A   =
         an AMD-Vi IO page fault=0A         =20
=0A          and the driver would crash.=20
=0A          IF I turn off IOMMU there is no problem with using=0A         =
   ethernet,=20
=0A         =20
=0A          The onboard ethernet chip is a RTL8111F/8168F.=20
=0A          For now I've turned off the network adapter in the bios=0A    =
        and am using an add on card.=0A         =20
=0A         =20
=0A          Then I noticed that I could not use the onboard audio=0A      =
      with oss (4.2.2007) with IOMMU=0A         =20
=0A          enabled. Alsa works ok, but I prefer to use oss. As with=0A   =
         the ethernet card if I turn off=0A         =20
=0A          IOMMU in the bios the onboard audio is recognized and=0A      =
      works fine.=20
=0A         =20
=0A          Any clues or help would be appreciated=20
=0A          Thanks, Don=20
=0A         =20
=0A          _______________________________________________
=0A          iommu mailing list
=0A          iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
=0A          https://lists.linuxfoundation.org/mailman/listinfo/iommu
=0A          _______________________________________________
=0A          iommu mailing list
=0A          iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
=0A          https://lists.linuxfoundation.org/mailman/listinfo/iommu
=0A         =20
=0A        =0A      =0A    =0A   =20
=0A  =0A=0A
---1480336445-136746299-1362671890=:8814
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" ><tr><td valign=3D"=
top" style=3D"font: inherit;">acpi.dump http://pastebin.com/2wEYXykY<br>dme=
sg.dump http://pastebin.com/ugfpRjxc<br>lspci -nnk http://pastebin.com/W5Hd=
qQia<br><br>I have the onboard ethernet shut off in the bios<br>but the sou=
ndcard is still not being seen with oss4, <br>if iommu is enabled in bios a=
nd iommu=3Dpt is not entered in grub.<br><br>Thanks, Don<br><br>--- On <b>T=
hu, 3/7/13, Suravee Suthikulanit <i>&lt;suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org&gt;</=
i></b> wrote:<br><blockquote style=3D"border-left: 2px solid rgb(16, 16, 25=
5); margin-left: 5px; padding-left: 5px;"><br>From: Suravee Suthikulanit &l=
t;suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org&gt;<br>Subject: Re: Problem with ethernet/s=
ound with IOMMU enabled on M5A99FX pro r2.0 motherboard<br>To: japhack@yaho=
o.com<br>Cc: ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org<br>Date: =
Thursday, March 7, 2013, 9:25 AM<br><br><div id=3D"yiv1208139767">=0A  =0A=
=0A    =0A  =0A  <div>=0A    Hi,<br>=0A    <br>=0A    Would you please prov=
ide the kernel log and the dump of ACPI (from=0A    tools like "acpidump")?=
&nbsp; These should help debugging the issue.<br>=0A    <br>=0A    Thank yo=
u,<br>=0A    <br>=0A    Suravee<br>=0A    <blockquote type=3D"cite">=0A    =
  <blockquote type=3D"cite">=0A        <div><b>From:</b> Donald Dutile &lt;=
<a rel=3D"nofollow" ymailto=3D"mailto:ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" target=3D"_blank"=
 href=3D"/mc/compose?to=3Dddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;<br=
>=0A          <b>Date:</b> March 7, 2013, 3:08:57 AM GMT+08:00<br>=0A      =
    <b>To:</b> JapHack &lt;<a rel=3D"nofollow" ymailto=3D"mailto:japhack@ya=
hoo.com" target=3D"_blank" href=3D"/mc/compose?to=3Djaphack-/E1597aS9LQAvxtiuMwx3w@public.gmane.org">japh=
ack-/E1597aS9LQAvxtiuMwx3w@public.gmane.org</a>&gt;<br>=0A          <b>Cc:</b> &lt;<a rel=3D"nofollow" ym=
ailto=3D"mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" target=3D"_blank" href=3D=
"/mc/compose?to=3Diommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org">iommu-cunTk1MwBs9QetFLy7KEm2CgeU+1il2p@public.gmane.org=
ation.org</a>&gt;<br>=0A          <b>Subject:</b> <b>Re: Problem with ether=
net/sound with IOMMU=0A            enabled on M5A99FX pro r2.0 motherboard<=
/b><br>=0A          <br>=0A        </div>=0A      </blockquote>=0A      <bl=
ockquote type=3D"cite">=0A        <div><span>Probably a missing IVMD block =
for the sound device.</span><br>=0A          <span></span><br>=0A          =
<span>The ethernet device issue could be a driver issue -- </span><br>=0A  =
        <span>DMA write to a page that was mapped for read-only.</span><br>=
=0A          <span>Providing the IO page fault message would help to</span>=
<br>=0A          <span>diagnose further.</span><br>=0A          <span></spa=
n><br>=0A          <span>- DonD</span><br>=0A          <span></span><br>=0A=
          <span>----- Original Message -----</span><br>=0A          <span>F=
rom: "JapHack" &lt;<a rel=3D"nofollow" ymailto=3D"mailto:japhack-/E1597aS9LQAvxtiuMwx3w@public.gmane.org"=
 target=3D"_blank" href=3D"/mc/compose?to=3Djaphack-/E1597aS9LQAvxtiuMwx3w@public.gmane.org">japhack@yaho=
o.com</a>&gt;</span><br>=0A          <span>To: <a rel=3D"nofollow" ymailto=
=3D"mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" target=3D"_blank" href=3D"/mc/=
compose?to=3Diommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org">iommu-cunTk1MwBs9QetFLy7KEmy65B3kUBaIG@public.gmane.org=
.org</a></span><br>=0A          <span>Sent: Tuesday, March 5, 2013 2:10:52 =
PM</span><br>=0A          <span>Subject: Problem with ethernet/sound with I=
OMMU enabled=0A            on M5A99FX pro r2.0 &nbsp; &nbsp;motherboard</sp=
an><br>=0A          <span></span><br>=0A          <span></span><br>=0A     =
     <span>I recently bought this board as I wanted to start doing=0A      =
      pci passthrough emulation.=0A          </span><br>=0A          <span>=
</span><br>=0A          <span>I noticed that after I had installed it and b=
ooted up,=0A            with IOMMU enabled </span>=0A          <br>=0A     =
     <span>the network would work fine for a while then I would get=0A     =
       an AMD-Vi IO page fault=0A          </span><br>=0A          <span>an=
d the driver would crash. </span><br>=0A          <span>IF I turn off IOMMU=
 there is no problem with using=0A            ethernet, </span><br>=0A     =
     <span></span><br>=0A          <span>The onboard ethernet chip is a RTL=
8111F/8168F. </span><br>=0A          <span>For now I've turned off the netw=
ork adapter in the bios=0A            and am using an add on card.=0A      =
    </span><br>=0A          <span></span><br>=0A          <span>Then I noti=
ced that I could not use the onboard audio=0A            with oss (4.2.2007=
) with IOMMU=0A          </span><br>=0A          <span>enabled. Alsa works =
ok, but I prefer to use oss. As with=0A            the ethernet card if I t=
urn off=0A          </span><br>=0A          <span>IOMMU in the bios the onb=
oard audio is recognized and=0A            works fine. </span><br>=0A      =
    <span></span><br>=0A          <span>Any clues or help would be apprecia=
ted </span><br>=0A          <span>Thanks, Don </span><br>=0A          <span=
></span><br>=0A          <span>____________________________________________=
___</span><br>=0A          <span>iommu mailing list</span><br>=0A          =
<span><a rel=3D"nofollow" ymailto=3D"mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cUBSOeVevoDU@public.gmane.org=
g" target=3D"_blank" href=3D"/mc/compose?to=3Diommu-cunTk1MwBs9QetFLy7KEmxxBWXNxL4zz@public.gmane.org=
org">iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org</a></span><br>=0A          <span><a r=
el=3D"nofollow" target=3D"_blank" href=3D"https://lists.linuxfoundation.org=
/mailman/listinfo/iommu">https://lists.linuxfoundation.org/mailman/listinfo=
/iommu</a></span><br>=0A          <span>___________________________________=
____________</span><br>=0A          <span>iommu mailing list</span><br>=0A =
         <span><a rel=3D"nofollow" ymailto=3D"mailto:iommu-cunTk1MwBs9QetFLy7KEmw@public.gmane.org=
dation.org" target=3D"_blank" href=3D"/mc/compose?to=3Diommu-cunTk1MwBs+XwC/5MpYmKg@public.gmane.org=
undation.org">iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org</a></span><br>=0A          <=
span><a rel=3D"nofollow" target=3D"_blank" href=3D"https://lists.linuxfound=
ation.org/mailman/listinfo/iommu">https://lists.linuxfoundation.org/mailman=
/listinfo/iommu</a></span><br>=0A          <span></span><br>=0A        </di=
v>=0A      </blockquote>=0A    </blockquote>=0A    <br>=0A  </div>=0A=0A</d=
iv></blockquote></td></tr></table>
---1480336445-136746299-1362671890=:8814--

--===============2457683216670349775==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2457683216670349775==--
