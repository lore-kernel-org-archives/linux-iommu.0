From: JapHack <japhack-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Re: Problem with ethernet/sound with IOMMU enabled on M5A99FX pro
	r2.0 motherboard
Date: Thu, 7 Mar 2013 08:12:45 -0800 (PST)
Message-ID: <1362672765.8229.YahooMailClassic@web120701.mail.ne1.yahoo.com>
References: <5138B15E.6000302@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8454482756947337297=="
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

--===============8454482756947337297==
Content-Type: multipart/alternative; boundary="-795196629-1918051762-1362672765=:8229"

---795196629-1918051762-1362672765=:8229
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

This is in addition to what I just sent.
It is triggered off when I run soundon (loads the oss drivers) with IOMMU o=
n and iommu=3Dpt not enabled.

[=A0=A0 15.096281] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:14.2 dom=
ain=3D0x000e address=3D0x000000009641f000 flags=3D0x0010]
[=A0=A0 15.096285] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D00:14.2 dom=
ain=3D0x000e address=3D0x000000009641f000 flags=3D0x0010]
[=A0=A0 15.096373] oss_hdaudio: HDA codec 0x00000000 not known yet
[=A0=A0 15.096528] oss_hdaudio: HDA codec 0x00000000 not known yet
[=A0=A0 15.096583] oss_hdaudio: No hdaudio codecs were detected
[=A0=A0 15.096589] oss_hdaudio: probe of 0000:00:14.2 failed with error -5


Thanks for looking at this problem
Don

---795196629-1918051762-1362672765=:8229
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" ><tr><td valign=3D"=
top" style=3D"font: inherit;">This is in addition to what I just sent.<br>I=
t is triggered off when I run soundon (loads the oss drivers) with IOMMU on=
 and iommu=3Dpt not enabled.<br><br>[&nbsp;&nbsp; 15.096281] AMD-Vi: Event =
logged [IO_PAGE_FAULT device=3D00:14.2 domain=3D0x000e address=3D0x00000000=
9641f000 flags=3D0x0010]<br>[&nbsp;&nbsp; 15.096285] AMD-Vi: Event logged [=
IO_PAGE_FAULT device=3D00:14.2 domain=3D0x000e address=3D0x000000009641f000=
 flags=3D0x0010]<br>[&nbsp;&nbsp; 15.096373] oss_hdaudio: HDA codec 0x00000=
000 not known yet<br>[&nbsp;&nbsp; 15.096528] oss_hdaudio: HDA codec 0x0000=
0000 not known yet<br>[&nbsp;&nbsp; 15.096583] oss_hdaudio: No hdaudio code=
cs were detected<br>[&nbsp;&nbsp; 15.096589] oss_hdaudio: probe of 0000:00:=
14.2 failed with error -5<br><br><br>Thanks for looking at this problem<br>=
Don<br></td></tr></table>
---795196629-1918051762-1362672765=:8229--

--===============8454482756947337297==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8454482756947337297==--
