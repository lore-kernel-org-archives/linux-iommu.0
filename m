From: M G Berberich <berberic@fmi.uni-passau.de>
Subject: Re: BUG: using smp_processor_id() in preemptible [00000000] code]
Date: Tue, 14 Jun 2016 11:08:09 +0200
Message-ID: <20160614090809.GA6723@invalid>
References: <Pine.LNX.4.44L0.1606091410580.1353-100000@iolanthe.rowland.org>
 <50F437E3-85F7-4034-BAAE-B2558173A2EA@gmail.com>
 <20160613130651.GA8662@invalid>
 <CAHMfzJktLSPZuLJ0R90Zaa6tj+awX9NDO2DPzjxEEJuY0CFV+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <CAHMfzJktLSPZuLJ0R90Zaa6tj+awX9NDO2DPzjxEEJuY0CFV+g@mail.gmail.com>
Sender: owner-linux-mm@kvack.org
To: Adam Morrison <mad@cs.technion.ac.il>
Cc: Nadav Amit <nadav.amit@gmail.com>, iommu@lists.linux-foundation.org, USB list <linux-usb@vger.kernel.org>, linux-mm@kvack.org, Alan Stern <stern@rowland.harvard.edu>
List-Id: iommu@lists.linux-foundation.org

Hello,

Am Montag, den 13. Juni schrieb Adam Morrison:
> On Mon, Jun 13, 2016 at 4:06 PM, M G Berberich
> <berberic@fmi.uni-passau.de> wrote:
>=20
> > Hello,
> >
> >> >> With 4.7-rc2, after detecting a USB Mass Storage device
> >> >>
> >> >>  [   11.589843] usb-storage 4-2:1.0: USB Mass Storage device dete=
cted
> >> >>
> >> >> a constant flow of kernel-BUGS is reported (several per second).
> >
> > [=E2=80=A6]
> >
> >> > This looks like a bug in the memory management subsystem.  It shou=
ld be
> >> > reported on the linux-mm mailing list (CC'ed).
> >>
> >> This bug is IOMMU related (mailing list CC=E2=80=99ed) and IIUC alre=
ady fixed.
> >
> > Not fixed in 4.7-rc3
>=20
> These patches should fix the issue:
>=20
>     https://lkml.org/lkml/2016/6/1/310
>     https://lkml.org/lkml/2016/6/1/311

FYIO: They do, indeed.

> I'm not sure why they weren't applied... will ping the maintainers.

	MfG
	bmg

--=20
=E2=80=9EDes is v=C3=B6llig wurscht, was heut beschlos- | M G Berberich
 sen wird: I bin sowieso dagegn!=E2=80=9C          | mail@m-berberich.de
(SPD-Stadtrat Kurt Schindler; Regensburg)  |=20

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=3Dmailto:"dont@kvack.org"> email@kvack.org </a>
