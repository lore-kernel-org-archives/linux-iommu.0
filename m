From: Eric Yang <yu.yang_3@nxp.com>
Subject: RE: No check of the size passed to unmap_single in  swiotlb
Date: Wed, 22 Nov 2017 03:23:33 +0000
Message-ID: <VI1PR04MB3071FBA364C78317F3C3A25D8C200@VI1PR04MB3071.eurprd04.prod.outlook.com>
References: <VI1PR04MB30715EA7212DC661481041438C220@VI1PR04MB3071.eurprd04.prod.outlook.com>
 <20171120162652.GR24312@char.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171120162652.GR24312@char.us.oracle.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Andrey Ryabinin <aryabinin@virtuozzo.com>, David Miller <davem@davemloft.net>, Ingo Molnar <mingo@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Al Viro <viro@zeniv.linux.org.uk>, Kees Cook <keescook@chromium.org>, Daniel Borkmann <daniel@iogearbox.net>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Konrad Rzeszutek Wilk [mailto:konrad.wilk@oracle.com]
> Sent: Tuesday, November 21, 2017 12:27 AM
> To: Eric Yang <yu.yang_3@nxp.com>; iommu@lists.linux-foundation.org
> Cc: linux-kernel@vger.kernel.org; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>; Andrew Morton <akpm@linux-foundation.org>;
> Andrey Ryabinin <aryabinin@virtuozzo.com>; David Miller
> <davem@davemloft.net>; Ingo Molnar <mingo@kernel.org>; Geert
> Uytterhoeven <geert+renesas@glider.be>; Al Viro <viro@zeniv.linux.org.uk>=
;
> Kees Cook <keescook@chromium.org>; Daniel Borkmann
> <daniel@iogearbox.net>
> Subject: Re: No check of the size passed to unmap_single in swiotlb
>=20
> On Mon, Nov 20, 2017 at 08:17:14AM +0000, Eric Yang wrote:
> > Hi all,
>=20
> Hi!

Hi  Konrad,
> >
> > During debug a  device only support 32bits DMA(Qualcomm Atheros AP) in =
our
> LS1043A 64bits ARM  SOC, we found that the invoke of dma_unmap_single -->
> swiotlb_tbl_unmap_single  will unmap the passed "size" anyway even when t=
he
> "size" is incorrect.
> >
> > If the size is larger than it should, the extra entries in io_tlb_orig_=
addr array
> will be refilled by INVALID_PHYS_ADDR, and it will cause the bounce buffe=
r copy
> not happen when the one who really used the mis-freed entries doing  DMA =
data
> transfers, and this will cause further unknow behaviors.
> >
> > Here we just fix it temporarily by adding a judge of the "size" in the
> swiotlb_tbl_unmap_single, if it is larger than it deserves, just unmap th=
e right
> size only. Like the code:
>=20
> Did the DMA debug API (CONFIG_DMA_API_DEBUG) help in figuring this issue =
as
> well?
>=20

I have just enabled this config and move off the kernel fix and test, there=
 seems the debug API=20
has no output for this size incorrect issue. For I only enable the config a=
nd no other operations=20
and my kernel is 4.9, do I missed something?

I confirm that the debug API is working, for there are other drivers trigge=
red its warning output=20
like:
=20
caam_jr 1710000.jr: DMA-API: device driver tries to free DMA memory it has =
not allocated=20
[device address=3D0x6800458400000000]

> >
> > [yangyu@titan dash-lts]$ git diff ./lib/swiotlb.c diff --git
> > a/lib/swiotlb.c b/lib/swiotlb.c index ad1d2962d129..58c97ede9d78
> > 100644
> > --- a/lib/swiotlb.c
> > +++ b/lib/swiotlb.c
> > @@ -591,7 +591,10 @@ void swiotlb_tbl_unmap_single(struct device *hwdev=
,
> phys_addr_t tlb_addr,
> >                  */
> >                 for (i =3D index + nslots - 1; i >=3D index; i--) {
> >                         io_tlb_list[i] =3D ++count;
> > -                       io_tlb_orig_addr[i] =3D INVALID_PHYS_ADDR;
> > +                      if(io_tlb_orig_addr[i]  !=3D orig_addr)
> > +                          printk("=3D=3D=3D=3D=3D=3Dsize wrong, ally d=
own ally down!=3D=3D=3D\n");
> > +                      else
> > +                         io_tlb_orig_addr[i] =3D INVALID_PHYS_ADDR;
> >                 }
> >                 /*
> >                  * Step 2: merge the returned slots with the preceding
> > slots,
> >
> > Although pass a right size of DMA buffer is the responsibility of  the =
drivers, but
> Is it useful to add some size check code to prevent  real damage happen?
> >
> > Regards,
> > Eric
