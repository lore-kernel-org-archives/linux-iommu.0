From: Eric Boxer <boxerspam1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v8 06/12] ARM: dts: Add description of System MMU of
	Exynos SoCs
Date: Tue, 6 Aug 2013 11:21:08 -0500
Message-ID: <3BCA86D7-5A34-418E-A468-F7DF62FD1592@gmail.com>
References: <003c01ce89f3$3abc4bc0$b034e340$@samsung.com>
	<27536111.odlCO093Zi@amdc1032>
	<003c01ce91cd$427fad70$c77f0850$@samsung.com>
	<1429191.3FDem6vW0S@amdc1032>
	<002001ce928a$f5a7f390$e0f7dab0$@samsung.com>
	<5200F781.9020300@samsung.com>
	<CANEJEGtQuKG5err-R7SxD6m+aJWVmn47X9NJLx7UzaRkKhUMoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6564920032234426117=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CANEJEGtQuKG5err-R7SxD6m+aJWVmn47X9NJLx7UzaRkKhUMoQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Linux Samsung SOC <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Hyunwoong Kim <khw0178.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Prathyush <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Subash Patel <supash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Keyyoung Park <keyyoung.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Rahul Sharma <rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, kvmarm <kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org>, Linux ARM Kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============6564920032234426117==
Content-Type: multipart/alternative; boundary="52012274_625558ec_13e"

--52012274_625558ec_13e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ok =20

---Sent from Boxer =7C http://getboxer.com

Hi Marek,



On Tue, Aug 6, 2013 at 6:17 AM, Marek Szyprowski

<m.szyprowski=40samsung.com> wrote:

...

> IMHO it is much better to have a simple driver, which binds to a single=


> IOMMU controller and leave it to the driver whether to have a same virt=
ual address

> space for all parts of =46IMC-IS or M=46C submodules/memory ports or no=
t.



I understand this part. I having written the IOMMU support for 4

different IOMMUs, all of which had exactly one IO Page Table and one

IOMMU shared by many devices.



> Just make sure that it will be possible to attach more than one sysmmu
=

> controller to one iommu domain.



I don't understand how this is possible. Can someone explain this

better in the IOMMU documentation please=3F



=22iommu domain=22 to me means one virtual IO address space for attached
=

devices that can master DMA transactions. The IOMMU then uses it's IO

Page Table to translate the DMA address to the system physical address

space and forwards the transaction.



What is the role of the sysmmu in all of this=3F

Is the sysmmu just the MMU (or collection of MMU) for host DRAM=3F

Or is sysmmu responsible for =22other stuff=22=3F (clocks, power domains,=
 MMU, etc)



I can understand we might have multiple MMUs in a system...e.g. every

range of memory might have it's own MMU. But they share the same

physical address space and generally live under one page table.

Because of =22one page table=22 I would consider them one entity from the=


the IOMMUs perspective.



thanks,

grant

--

To unsubscribe from this list: send the line =22unsubscribe linux-kernel=22=
 in

the body of a message to majordomo=40vger.kernel.org

More majordomo info at  http://vger.kernel.org/majordomo-info.html

Please read the =46AQ at  http://www.tux.org/lkml/


--52012274_625558ec_13e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ok<br><br><div id=3D=22boxer-meta=22></div>---<br>Sent from Boxer =7C <a =
href=3D=22http://ad.apps.fm/gEPEBG7WoqY8ykv=5F19bJ2RM8G1T=5FLUvoWYXredpuo=
YBLq62ptJqsuhqD23uAmN=5FARL=5FcKzXIyDOjqo=5F2b16qX-n0fdus8iPp=46XMt8U8Pvj=
oVlhRULf-kbANJPthrZGL0-2YPGhRTe=46uBXMLAgLTeQQ=22><a href=3D=22http://ad.=
apps.fm/RIHNezu2dEvs5l0V4l4ORRM8G1T=5FLUvoWYXredpuoYBLq62ptJqsuhqD23uAmN=5F=
At7Sgf1dqymBCT1gROQwkDziOlpWSWgmzZpGoTMpr7Bg=22>http://getboxer.com</a></=
a><span id=3D=22draft-break=22></span><div><div>On Tue, Aug 06, 2013 at 1=
1:07 AM, Grant Grundler <grundler=40chromium.org> wrote:<br><blockquote t=
ype=3D=22cite=22><div>Hi Marek,<br><br>On Tue, Aug 6, 2013 at 6:17 AM, Ma=
rek Szyprowski<br><m.szyprowski=40samsung.com> wrote:<br>...<br>&gt; IMHO=
 it is much better to have a simple driver, which binds to a single<br>&g=
t; IOMMU controller and leave it to the driver whether to have a same vir=
tual address<br>&gt; space for all parts of =46IMC-IS or M=46C submodules=
/memory ports or not.<br><br>I understand this part. I having written the=
 IOMMU support for 4<br>different IOMMUs, all of which had exactly one IO=
 Page Table and one<br>IOMMU shared by many devices.<br><br>&gt; Just mak=
e sure that it will be possible to attach more than one sysmmu<br>&gt; co=
ntroller to one iommu domain.<br><br>I don't understand how this is possi=
ble. Can someone explain this<br>better in the IOMMU documentation please=
=3F<br><br>=22iommu domain=22 to me means one virtual IO address space fo=
r attached<br>devices that can master DMA transactions. The IOMMU then us=
es it's IO<br>Page Table to translate the DMA address to the system physi=
cal address<br>space and forwards the transaction.<br><br>What is the rol=
e of the sysmmu in all of this=3F<br>Is the sysmmu just the MMU (or colle=
ction of MMU) for host DRAM=3F<br>Or is sysmmu responsible for =22other s=
tuff=22=3F (clocks, power domains, MMU, etc)<br><br>I can understand we m=
ight have multiple MMUs in a system...e.g. every<br>range of memory might=
 have it's own MMU. But they share the same<br>physical address space and=
 generally live under one page table.<br>Because of =22one page table=22 =
I would consider them one entity from the<br>the IOMMUs perspective.<br><=
br>thanks,<br>grant<br>--<br>To unsubscribe from this list: send the line=
 =22unsubscribe linux-kernel=22 in<br>the body of a message to majordomo=40=
vger.kernel.org<br>More majordomo info at  http://vger.kernel.org/majordo=
mo-info.html<br>Please read the =46AQ at  http://www.tux.org/lkml/<br></m=
.szyprowski=40samsung.com></div></blockquote></grundler=40chromium.org></=
div></div>
--52012274_625558ec_13e--


--===============6564920032234426117==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6564920032234426117==--
