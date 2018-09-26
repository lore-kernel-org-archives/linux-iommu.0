From: Jordan Glover <Golden_Miller83@protonmail.ch>
Subject: Re: Linux 4.19-rc5: Missing iommu fix
Date: Wed, 26 Sep 2018 20:47:00 +0000
Message-ID: <1eoZuKZCC_M_pHNio6_-AJoLPBDTI_RoPWKupVF0ge7XQ1DDM_HkLXiyzPIR-Ly2c5RvtW-mdDDn0R0q1X_usrnJYLDWqndqwu2I7OBElU4=@protonmail.ch>
References: <CA+icZUUdxjVe4p-9aui0cqj_EiHD3O2VZ=dW8HqWf-+9jqnWCA@mail.gmail.com>
 <20180926195917.GB20689@kroah.com>
Reply-To: Jordan Glover <Golden_Miller83@protonmail.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180926195917.GB20689@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sedat Dilek <sedat.dilek@gmail.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Joerg Roedel <jroedel@suse.de>, LKML <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Wednesday, September 26, 2018 9:59 PM, Greg Kroah-Hartman <gregkh@linuxf=
oundation.org> wrote:

> On Mon, Sep 24, 2018 at 11:33:39AM +0200, Sedat Dilek wrote:
>
> > Hi Greg,
> > thanks and congrats for this release.
> > Me and several other people have an issue with "intel_iommu=3Don" (see
> > [1]) and a patch is pending in [2].
> > Unfortunately, it is not in linux-iommu Git.
> > Hope this will soon happen.
> > Just want to inform you and let people know if they have a similiar pro=
blem.
>
> Is this all now merged properly?
>
> thanks,
>
> greg k-h
>

Yes it is:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3Dbe9e6598aeb0db70a7927d6b3bb4d3d6fb1c3e18

Thank you.

Jordan
