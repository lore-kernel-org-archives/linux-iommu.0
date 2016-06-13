From: M G Berberich <berberic-vmG2aq7wDA3mFSIgyKwhw7NAH6kLmebB@public.gmane.org>
Subject: Re: BUG: using smp_processor_id() in preemptible [00000000] code]
Date: Mon, 13 Jun 2016 15:06:51 +0200
Message-ID: <20160613130651.GA8662@invalid>
References: <Pine.LNX.4.44L0.1606091410580.1353-100000@iolanthe.rowland.org>
 <50F437E3-85F7-4034-BAAE-B2558173A2EA@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <50F437E3-85F7-4034-BAAE-B2558173A2EA-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nadav Amit <nadav.amit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Adam Morrison <mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hello,

Am Donnerstag, den 09. Juni schrieb Nadav Amit:
> Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org> wrote:
>=20
> > On Thu, 9 Jun 2016, M G Berberich wrote:
> >=20
> >> With 4.7-rc2, after detecting a USB Mass Storage device
> >>=20
> >>  [   11.589843] usb-storage 4-2:1.0: USB Mass Storage device detec=
ted
> >>=20
> >> a constant flow of kernel-BUGS is reported (several per second).

[=E2=80=A6]

> > This looks like a bug in the memory management subsystem.  It shoul=
d be=20
> > reported on the linux-mm mailing list (CC'ed).
>=20
> This bug is IOMMU related (mailing list CC=E2=80=99ed) and IIUC alrea=
dy fixed.

Not fixed in 4.7-rc3

	MfG
	bmg

--=20
=E2=80=9EDes is v=C3=B6llig wurscht, was heut beschlos- | M G Berberich
 sen wird: I bin sowieso dagegn!=E2=80=9C          | mail@m-berberich.d=
e
(SPD-Stadtrat Kurt Schindler; Regensburg)  |=20
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
