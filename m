From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 2/3] Initial skeleton of VFIO support for Device Tree
 based devices
Date: Mon, 5 Aug 2013 14:50:09 +0100
Message-ID: <20130805135009.GG9910@e106331-lin.cambridge.arm.com>
References: <1375708632-26356-1-git-send-email-a.motakis@virtualopensystems.com>
 <1375708632-26356-3-git-send-email-a.motakis@virtualopensystems.com>
 <20130805133757.GF9910@e106331-lin.cambridge.arm.com>
 <CAG8rG2yCix04ZHq_rydRVfjfSh15U=LZ38mf_a4ECEUAgvRMbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAG8rG2yCix04ZHq_rydRVfjfSh15U=LZ38mf_a4ECEUAgvRMbQ@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Antonios Motakis <a.motakis@virtualopensystems.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "agraf@suse.de" <agraf@suse.de>, "B08248@freescale.com" <B08248@freescale.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>, Pawel Moll <Pawel.Moll@arm.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "tomasz.figa@gmail.com" <tomasz.figa@gmail.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>
List-Id: iommu@lists.linux-foundation.org

>      > +static const struct of_device_id vfio_dt_match[] =3D {
>      > + =EF=BF=BD =EF=BF=BD /* In the future, we can implement a bet=
ter mechanism to bind
>      the
>      > + =EF=BF=BD =EF=BF=BD =EF=BF=BD* module to any device. For now=
 add the compatible property to
>      the
>      > + =EF=BF=BD =EF=BF=BD =EF=BF=BD* dtb of the devices we want to=
 use. =EF=BF=BD */
>      > + =EF=BF=BD =EF=BF=BD {
>      > + =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =
=2Ecompatible =3D "vfio-dt",
>      > + =EF=BF=BD =EF=BF=BD },
>      > + =EF=BF=BD =EF=BF=BD {},
>      > +};
>=20
>      This definitely doesn't belong in the dt. It's purely a Linux
>      abstraction and does not represent a piece of hardware or common
>      interface.
>=20
>      We need to think of a better mechanism for binding the module to=
 these
>      devices now.
>=20
>    I already make this remark in the cover letter; thanks for confirm=
ing it.
>    =EF=BF=BD
>    Antonios

Sorry, I found the cover letter a little unclear in that regard.

Thanks for the clarification :)

Mark.
