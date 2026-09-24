Received: from mail-ed2-f18.google.com (mail-ed2-f18.google.com [74.125.228.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A084A090B
	for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 15:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790264965; cv=pass; b=QqMLbzSyXF+314NKsPaySWPMZACdkUyBNUAbbjHMZnDsZKi1zOZEEgD+UFqvmnDncDt2Dz07hDlTkPT8Zl0VJOW8p/dbEmJEbs7HNE1u6Gx2xMHMfjfqQbpH1nF3EIhJp55BvGhk4zZyR2q+t0mUzENYA/2MkaWbQsbhNLC82qw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790264965; c=relaxed/simple;
	bh=l1Q0IiZDk6Qcq0311vlsTK2bjC6s/OA42Brr4EFRw/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UvlY7rtJ500IkAKAtQduAkr0BcOqQ+XzTK5t3h+gJFC2FQNzqd3Ykj+FsA1voeIjB7ERMuO8hAXdptjL6Mf+5BaQxYiHaGE6ItnZYQPUSInWxdKaEfn6C44s/arlTiOTej4RSkN8ZpGNVviEWez869sNC4g7u+wdyMJwyWFI/jY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y8PEPhaD; arc=pass smtp.client-ip=74.125.228.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y8PEPhaD"
Received: by mail-ed2-f18.google.com with SMTP id 4fb4d7f45d1cf-6a9adea43b6so6045a12.0
        for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 08:49:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790264961; cv=none;
        d=google.com; s=arc-20260327;
        b=Bj3Hmh+IU1Wd1E9v9nYs2Fb8uIYrtsjW+2Zh9E+BsbewyNF+zsBdawupAJ0iVteeX5
         XwsIFLvtQJyf9Y99JJaNI1IBNYnOCq62CR9pqLoCbT/q7hDZIpbuiOq8huT9JdJdtl4t
         2t4G3sfiOsIsBS0QiDs/UTp4NhC9juyNM/H4R8JXlbR2lCVKEC8GwWk30Nz3seRd4IKk
         VlpgzuAXHJxleQ+pT60Dsrs3IsuK2BsVH8klbmQskblrMrT/riYrNak4vVJJPMGAw2RZ
         l3m1x2BiPow5EczcVpJP9uM8ERYsJtYKh0IX4LGQNJfxrepO0u43PQfqvCY1wWoATjzA
         mTZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ni9MwLgYZlL3v8+dEAMfhbtgbNrk2WDN56GHtl6Py64=;
        fh=0C02XnkMm2tBv7w3QbpJmv9FUH+XZix8AXQFxEwvJBk=;
        b=OinFpgStPoW11Gy3SqHsvjzC7fMU6/yxiIa9smx9cNgYtNKfe/pfo8bdMlwRiTXA86
         +LYYSkEfsGhAmb314Uub/TuZred/NNbKgAfYQIcACTQYFNDh/XEGRD2rzl2oxkp5ttp3
         gtthMUhO4ABj+GZbJxgGEgSYqYT9NLruJ9FkieegDxYXey7I2GazP4w5Fw2oKfwWtDPZ
         6UG18lqzEoNk1EsofI5ugzKSlNOl/6w4OF3WLEEN5aLuzY/Yw3dO0KWsMgijzmg1tv9p
         woZ3hE9Gexg9/bjJj24PsDLu+tvkITRUv0FRPpfXPlFjt7CCaBr7gv9Aq2b1dGWmsEKr
         eUrA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790264961; x=1790869761; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ni9MwLgYZlL3v8+dEAMfhbtgbNrk2WDN56GHtl6Py64=;
        b=y8PEPhaDjvjI4C/Rbzf7x7W0xwpVJlf3nAuLBrZm9M98z7YNHQ2mVOfFZJ2niA5Z1T
         15AYv4j0w21MqpTnSARKbGC5r99b7h1wFSmOwzRe8Dzm9T/CW+98hb4zCvIoiTd5PV5L
         8f3YirQ6ipe9k8d2XlRn1Ul7/6nHCJBWfZVqKyZGNj0/pzXZ+1d64T78QdQG4wSvMByP
         uDH/gTeEUtUZO69jodjVI0vZnAsbUHmQYUJEZaq3dwp6i9DePtAxUjWSK96rCn3BeiT5
         6AavUYFIbm6ohFupkOGoQJ9Vlu6UNdUBvBkY2GHlP15Qh7GZJOFTSMCo+0QLF39xw6EE
         MRyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790264961; x=1790869761;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ni9MwLgYZlL3v8+dEAMfhbtgbNrk2WDN56GHtl6Py64=;
        b=SM1wDWeuMUuLe8JAGtLbNzwG2PKC+7nWlZATFQ9qyrX06uis2Qdh7On2WZAMZ8wW5I
         iTxGbwv2bdO+qN3Iwvk9Mo4rMTa/zRiwtftlDvoZlYbqaYo/mUFKD/xJBoUD4HQo/6px
         kgt8zkBOm+DGLHwt6ng0wUguHTgo6ZLDHRTvRr2ps8zkS1uAgCL2LStsM+/Rvwmj5sGm
         65WVT+Kkkoii9UjfUhoOoE8ar5Xf51lrw1twM7zTlpkb5yjcX+4iPO4+CqLtDUfIj3rq
         x0Gmd/WVkFDO63Eg2HDdhVklLkTvs6UhCg5G+8oRTSwNTuObtuTZ/9kmFP7SJFIshM+i
         sFaA==
X-Forwarded-Encrypted: i=1; AKwUvBzNXmJzEEwyWzA29OLkRMdJw3dFDi+UC3inUhKZg+mOmaFHL8Whl5sT/d70NXtN7jyFdQh4eA==@lists.linux.dev
X-Gm-Message-State: AFuF++nB/KGbFSKEBza3sCvGhJLZTsbt88NBeUYPrbiIQ/pXE3ToySOZ
	oiA49h1paKdOomUH7fgvBlqtsROpjbIAfp7yvak6SF9TUfZJ+oYKnaFmECkecaz1LAUndbeHIL9
	0hh10xoa6E3OwL9P3p6N5majrln0n2jkZRS+5WnSxAw==
X-Gm-Gg: AYBFou1N/z3wVe075y+TJXACYUMgDFFEPk38xzsv7pQMorNgF7R593JDOrjQhaGfgs/
	T7JKJeWj7BP6KtZnZmsqygZR+Nf8cSiAbTNGqoQMe01Z+EEprN8cFtV4DCeC7CIMizS3MbgH9Nc
	Oeemw9yBhOGwAwrpvepH74ykqfvZl776Efh4l7gX9ovphvi09R2rQosLfCEtCGC4H9ok7ur9t67
	yFmK3pHLdZPgspzcR/bN5XxYWZDBp9Wg6gTs7x2iRl7FZQloULCBGg1FqFYAuEPzUDN4tKFh3bz
	Scawg8IIkxALdajBymV7WSrcBx1WcqJ+UDrtR9IGtyltyia/2HxDeakU2DytB8465+NZOHxLz6H
	79XMiQ1eonyHl4YQcLcoTg2O2
X-Received: by 2002:a05:6402:3548:b0:6a9:b549:701d with SMTP id
 4fb4d7f45d1cf-6aacc508f6amr2199041a12.15.1790264960542; Thu, 24 Sep 2026
 08:49:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260916-remoteproc_virtio_map-v1-0-dac8c5eb4aa9@valla.it>
 <20260916-remoteproc_virtio_map-v1-12-dac8c5eb4aa9@valla.it>
 <arKiOCGrWAKyc-bc@p14s> <arLawAw6kgFT2e0W@bywater> <arP06mWDehsIDh5s@p14s> <arP5AvA51GHrI8aN@bywater>
In-Reply-To: <arP5AvA51GHrI8aN@bywater>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Thu, 24 Sep 2026 09:49:08 -0600
X-Gm-Features: AclHuK9rmhqK1cH6j-fLQ3mp9InwiyRIAYoT3KXZouMAk75cYXsRA4d_MaQA2vI
Message-ID: <CANLsYkyT3NopaQy8CpTUrD-MTbif1dvyjaUUcQUWLzcTL7GpcQ@mail.gmail.com>
Subject: Re: [PATCH RFC 12/12] PoC: arm64: dts: imx93-11x11-frdm: add multiple vdevs
To: Francesco Valla <francesco@valla.it>
Cc: Bjorn Andersson <andersson@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Peng Fan <peng.fan@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, virtualization@lists.linux.dev, 
	imx@lists.linux.dev, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 23 Sept 2026 at 12:42, Francesco Valla <francesco@valla.it> wrote:
>
> On Wed, Sep 23, 2026 at 09:48:58AM -0600, Mathieu Poirier wrote:
> > On Tue, Sep 22, 2026 at 10:19:48PM +0200, Francesco Valla wrote:
> > > On Tue, Sep 22, 2026 at 09:43:52AM -0600, Mathieu Poirier wrote:
> > > > On Wed, Sep 16, 2026 at 11:10:57PM +0200, Francesco Valla wrote:
> > > > > Add rings for multiple vdevs, as well as the required virtio nodes for
> > > > > I2C, SPI and GPIO functionalities. On top of that, add example
> > > > > peripherals using all of them.
> > > > >
> > > > > NOTE: this is a Proof-Of-Concept, not meant to be integrated!
> > > > >
> > > > > Signed-off-by: Francesco Valla <francesco@valla.it>
> > > > > ---
> > > > >  arch/arm64/boot/dts/freescale/imx93-11x11-frdm.dts | 128 +++++++++++++++++++--
> > > > >  1 file changed, 119 insertions(+), 9 deletions(-)
> > > > >
> > > > > diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-frdm.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-frdm.dts
> > > > > index bd14ba28690c..dfa3b122ac5f 100644
> > > > > --- a/arch/arm64/boot/dts/freescale/imx93-11x11-frdm.dts
> > > > > +++ b/arch/arm64/boot/dts/freescale/imx93-11x11-frdm.dts
> > > > > @@ -53,6 +53,32 @@ button-k3 {
> > > > >                 };
> > > > >         };
> > > > >
> > > > > +       gpio-keys-virtio {
> > > > > +               compatible = "gpio-keys-polled";
> > > > > +               poll-interval = <100>;
> > > > > +
> > > > > +               button-v1 {
> > > > > +                       label = "Button V1";
> > > > > +                       linux,code = <BTN_3>;
> > > > > +                       gpios = <&v_gpio 23 GPIO_ACTIVE_LOW>;
> > > > > +               };
> > > > > +
> > > > > +               button-v2 {
> > > > > +                       label = "Button V2";
> > > > > +                       linux,code = <BTN_4>;
> > > > > +                       gpios = <&v_gpio 24 GPIO_ACTIVE_LOW>;
> > > > > +               };
> > > > > +       };
> > > > > +
> > > > > +       leds {
> > > > > +               compatible = "gpio-leds";
> > > > > +
> > > > > +               led {
> > > > > +                       gpios = <&v_gpio 18 GPIO_ACTIVE_HIGH>;
> > > > > +                       label = "LED V";
> > > > > +               };
> > > > > +       };
> > > > > +
> > > > >         reg_usdhc2_vmmc: regulator-usdhc2 {
> > > > >                 compatible = "regulator-fixed";
> > > > >                 off-on-delay-us = <12000>;
> > > > > @@ -89,11 +115,6 @@ linux,cma {
> > > > >                         linux,cma-default;
> > > > >                 };
> > > > >
> > > > > -               rsc_table: rsc-table@2021e000 {
> > > > > -                       reg = <0 0x2021e000 0 0x1000>;
> > > > > -                       no-map;
> > > > > -               };
> > > > > -
> > > >
> > > > Why is the resource table removed?  There is no mention of that in the
> > > > changelog...
> > > >
> > >
> > > You are obviously right, the commit message here should have been a
> > > poem, not a form of hermetic poetry. My bad.
> > >
> > > The resource table here is causing problems with how Zephyr is managing
> > > it at its side. If it is kept in a separate memory location and copied
> > > there at runtime by the remote processor firmware during its startup
> > > (which is the current Zephyr behavior), then there might be a race
> > > condition when the aforesaid firmware is loaded and started by Linux
> > > *and* at least one of the vdev drivers (here including rpmsg_bus) is
> > > built-in. In this case, the copy of the resource table done by the
> > > remote processor might - depending on the async execution of the two
> > > processors - overwrite the status bit set by the Linux driver:
> > >
> > >   Firmware load and startup (echo start > /sys/.../state)
> > >                            |
> > >                        |
> > >                        V
> > >   The vdev devices get registered (by register_virtio_device())
> > >                            |
> > >                        |
> > >                        V
> > >   If a driver is built-in, it probes and sets the vdev status
> > >   inside the resource table @rsc-table.
> > >                            .
> > >                        . (in the mean time)
> > >                        .
> > >   The remote processor starts up and copies the resource table from its
> > >   dedicated section to @rsc-table.
> > >
> > > Depending on the system load and the complexity of the firmware, the two
> > > operations can happen in whatever sequence, causing a race condition.
> >
> > This would happen regardless of this patchset.
> >
>
> Correct, *if* the remote processor is copying the resource table to a
> specific location and expects the host to use that. On Zephyr (which is
> clearly outside the scope here) this can be enabled through the
> CONFIG_OPENAMP_COPY_RSC_TABLE option. I am keeping that disabled, and
> removing the rsc-table node here.
>
> I am planning to reason on this and propose a proper fix in a separate
> patchset.
>

It seems like we need two solutions here, one for imx and another
applicable to everyone.

> > >
> > > This is somewhat masked if vdev drivers are built as modules, as the
> > > devices does not probe immediately but only after the modules have been
> > > loaded, giving the remote processor time to start. Note that this is not
> > > a solution! but a workaround.
> > >
> > > If the rsc-table node is not there, the startup logic falls back to the
> > > classic rproc_elf_find_loaded_rsc_table().
> >
> > We can't remove @rsc-table to make a problem go away.
> >
>
> I need to re-take a look at the NXP SDK to understand what's the real
> purpose of having the rsc-table here. Judging from the commit message
> that introduced support for such facility [1], it seems the SDK is not
> really using it.
>
> Maybe someone from NXP can comment on this?
>
> > >
> > > This is specific to i.MX platforms [1] and is probably not normally an
> > > issue because - as stated in [1] - the offical SDK from NXP seems not
> > > to check the status inside the resource table.
> > >
> > > > >                 vdev0vring0: vdev0vring0@a4000000 {
> > > > >                         reg = <0 0xa4000000 0 0x8000>;
> > > > >                         no-map;
> > > > > @@ -105,12 +126,42 @@ vdev0vring1: vdev0vring1@a4008000 {
> > > > >                 };
> > > > >
> > > > >                 vdev1vring0: vdev1vring0@a4010000 {
> > > > > -                       reg = <0 0xa4010000 0 0x8000>;
> > > > > +                       reg = <0 0xa4010000 0 0x1000>;
> > > > > +                       no-map;
> > > > > +               };
> > > > > +
> > > > > +               vdev2vring0: vdev2vring0@a4011000 {
> > > > > +                       reg = <0 0xa4011000 0 0x2000>;
> > > > > +                       no-map;
> > > > > +               };
> > > > > +
> > > > > +               vdev2vring1: vdev2vring1@a4013000 {
> > > > > +                       reg = <0 0xa4013000 0 0x2000>;
> > > > > +                       no-map;
> > > > > +               };
> > > > > +
> > > > > +               vdev3vring0: vdev3vring0@a4015000 {
> > > > > +                       reg = <0 0xa4015000 0 0x2000>;
> > > > > +                       no-map;
> > > > > +               };
> > > > > +
> > > > > +               vdev4vring0: vdev4vring0@a4017000 {
> > > > > +                       reg = <0 0xa4017000 0 0x4000>;
> > > > > +                       no-map;
> > > > > +               };
> > > > > +
> > > > > +               vdev5vring0: vdev5vring0@a401B000 {
> > > > > +                       reg = <0 0xa401B000 0 0x2000>;
> > > > > +                       no-map;
> > > > > +               };
> > > > > +
> > > > > +               vdev5vring1: vdev5vring1@a401D000 {
> > > > > +                       reg = <0 0xa401D000 0 0x2000>;
> > > > >                         no-map;
> > > > >                 };
> > > > >
> > > > > -               vdev1vring1: vdev1vring1@a4018000 {
> > > > > -                       reg = <0 0xa4018000 0 0x8000>;
> > > > > +               vdev5vring2: vdev5vring2@a401F000 {
> > > > > +                       reg = <0 0xa401F000 0 0x1000>;
> > > > >                         no-map;
> > > > >                 };
> > > > >
> > > > > @@ -149,8 +200,67 @@ &cm33 {
> > > > >                  <&mu1 3 1>;
> > > > >         mbox-names = "tx", "rx", "rxdb";
> > > > >         memory-region = <&vdevbuffer>, <&vdev0vring0>, <&vdev0vring1>,
> > > > > -                       <&vdev1vring0>, <&vdev1vring1>, <&rsc_table>;
> > > > > +                       <&vdev1vring0>, <&vdev2vring0>, <&vdev2vring1>,
> > > > > +                       <&vdev3vring0>, <&vdev4vring0>,
> > > > > +                       <&vdev5vring0>, <&vdev5vring1>, <&vdev5vring2>;
> > > >
> > > > Who is using vdev5 vrings?
> > > >
> > >
> > > Another thing that should have been in the commit message. Vdevs are
> > > defined, in the Zephyr application I am using as PoC, as follows:
> > >
> > >  - vdev0: RPMSG (tx and rx vrings)
> >
> > To be backward compatible, there has to be a way to make vdev0 defaulting to
> > RPMSG.  It would also be nice if bindings were define for RPMSG so that it can
> > show up in the list of remoteproc-virtio devices like i2c, gpio and others.
> >
>
> What vdev type is inside vdev0 is up to the resource table (i.e., to the
> firmware running on the remote processor), not the remoteproc-virtio
> framework.
>

We are of the same opinion.  Up to now vdev0 was automatically
assigned to RPMSG but with this new feature, it can be anywhere in the
list.  I see your point about RPMSG not requiring hardware
description.

> Defining bindings for rpmsg would today be... pointless? Since no
> hardware needs to be described for it. The same goes for virtio-can and
> virtio-entropy.
>

Just to make sure we understand each other, there are entries in the
resource table for virtio-can and virtio-entropy.  Please confirm.

> >
> > >  - vdev1: entropy (single request vring)
> > >  - vdev2: GPIO (request and event vrings)
> > >  - vdev3: I2C (single request vring)
> > >  - vdev4: SPI (single request vring)
> > >  - vdev5: CAN (tx, rx and control vrings)
> > >
> > > vdev5 is not represented inside the devicetree because the can-virtio
> > > driver registers a single CAN network device and has thus no need for
> > > such representation.
> >
> > Then why is it part of the remoteproc's memory-regions?
> >
>
> Because a vring description needs to be present for it, or the
> remoteproc-virtio won't be able to fill the entry inside the resource
> table.
>
> > >
> > > > >         status = "okay";
> > > > > +
> > > > > +       virtio {
> > > > > +               #address-cells = <1>;
> > > > > +               #size-cells = <0>;
> > > > > +
> > > > > +               vdev@2 {
> > > > > +                       reg = <2>;
> > > > > +
> > > > > +                       v_gpio: gpio {
> > > > > +                               compatible = "virtio,device29";
> > > > > +                               gpio-controller;
> > > > > +                               #gpio-cells = <2>;
> > > > > +                               interrupt-controller;
> > > > > +                               #interrupt-cells = <2>;
> > > > > +                       };
> > > > > +               };
> > > > > +
> > > > > +               vdev@3 {
> > > > > +                       reg = <3>;
> > > > > +
> > > > > +                       i2c {
> > > > > +                               compatible = "virtio,device22";
> > > > > +                               #address-cells = <1>;
> > > > > +                               #size-cells = <0>;
> > > > > +
> > > > > +                               eeprom@50 {
> > > > > +                                       compatible = "atmel,24c1025";
> > > > > +                                       reg = <0x50>;
> > > > > +                               };
> > > > > +                       };
> > > > > +               };
> > > > > +
> > > > > +               vdev@4 {
> > > > > +                       reg = <4>;
> > > > > +
> > > > > +                       spi {
> > > > > +                               compatible = "virtio,device2d";
> > > > > +                               #address-cells = <1>;
> > > > > +                               #size-cells = <0>;
> > > > > +
> > > > > +                               sram@0 {
> > > > > +                                       compatible = "microchip,mchp23k256";
> > > > > +                                       reg = <0>;
> > > > > +                                       spi-max-frequency = <20000000>;
> > > > > +                               };
> > > > > +
> > > > > +                               lcd@1 {
> > > > > +                                       compatible = "adafruit,yx240qv29", "ilitek,ili9341";
> > > > > +                                       reg = <1>;
> > > > > +                                       spi-max-frequency = <10000000>;
> > > > > +                                       dc-gpios = <&v_gpio 21 GPIO_ACTIVE_HIGH>;
> > > > > +                                       reset-gpios = <&v_gpio 20 GPIO_ACTIVE_HIGH>;
> > > > > +                                       rotation = <90>;
> > > > > +                               };
> > > > > +                       };
> > > > > +               };
> > > > > +       };
> > > > >  };
> > > > >
> > > > >  &eqos {
> > > > >
> > > > > --
> > > > > 2.55.0
> > > > >
> > >
> > > Thank you!
> > >
> > > Regards,
> > > Francesco
> > >
> > >
>
> Thank you for the discussion - is helping in defining further
> requirements and constraints.
>

Well, I certainly appreciate that you are willing to have a discussion.

> Regards,
> Francesco
>
> [1] https://lore.kernel.org/all/20240719-imx_rproc-v2-2-10d0268c7eb1@nxp.com/
>
>
