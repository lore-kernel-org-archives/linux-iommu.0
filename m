Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A79D533587
	for <iommu@lists.linux.dev>; Wed, 23 Sep 2026 14:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790175413; cv=pass; b=YiaaexBdojKmIaejxGP7yQeGY9FFlEw61/jajKY793++3S9dmUwx5eFVJNGvAr/++HiI/Ov3LabbWU9puC+hNm5prukXZa/HjAOzJm3GB/ued4HmSq3VPpN66EJ+pXP4IHTm9J8mfIOLkofOtovp1rs8RO/DbDijiPq+T4+5d1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790175413; c=relaxed/simple;
	bh=UyMSLBvW9tmyx5OoI5WsB7xjvglDq4V9P7yAbnK27AA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ubq6UG07d2MrHlJbZ7I2FP2wB2krG2Y5jBCjneqHqx+zpGroFwc2/aEaYxgHwMvr9QkKOot8gLmdytHte3kC7NRtafhRk2eWC/hdxRABW6zgCSXV7zvbOqWaNuNhLjJ90AYgpnXoXkaAzq1UqCktJ72LHtcJnkVQCe4c5TpACGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oyHvfVm0; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oyHvfVm0"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a99cd5115bso1771618a12.3
        for <iommu@lists.linux.dev>; Wed, 23 Sep 2026 07:56:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790175410; cv=none;
        d=google.com; s=arc-20260327;
        b=V6iWiQNqdqHfbrQmuKhC4OjMy0eh8zhoFQGa2GeOow4vqG0qzL0nQSZ9j8679E9Zcx
         HI6ES7fV+9wLa419veHh8qZLnAj1HpS+i8CLk5pTINA08G+DU0Rtw55caNqduk+Jp7BD
         Ufq9Jc3ZzGZkIEWxVuSP2FdiqkJv6nPz61PImqGRYLc8dwOgS0+E9k6VSoHGVyGBudlu
         +EQRohIJU4zVYu3ME1mfJpxkfPRj7FrD6oIOlJtT4X4xOzWpFqIsQS2UBrapnZxTNBoZ
         tVgc7xEYhU7Nwy4l91llrUEz88Swwpwg/LDl13zwgD/K90ujAtNpHuiNP4bkLrOWK57D
         JKwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=80Q/UmLn++8SJbn/lU8/3FTYgpvMd1cRbPxOu7j8FDU=;
        fh=yQm4B30k+7EAJOFuz9rkMZJE1OSZnrYY7e7sZyDNBC4=;
        b=DmHUfVQhR87B42n1ScF/VkYYHEZo/x9x0uxJhqX1prh+fbU3V3T4UMXZ/SmkjXVct/
         njB7k0xpnMaWz17Ls6O/eyVif9zi5AJGCY4wGubuYPk0uBnYf6LuJgZgm3ESlm+mb/io
         YJwBCfQgyzhcDYW69IudIwytg4lWYkLRSk/b3kxUnD609fIwhPyGH19JQf1TVI7Vv+DQ
         J5xO65PrKNGeg3I7D8FqK+wfcwdqDyvlr4bPl04hS3+6BijC8X6MygoAESW8efx2Ggz1
         GUB9Oj4wB6Y+1D/koKJgbeF98gpK6OSy4oACAfT2oc3JzuY7N7FA1/1ZbKE+2XJD1rbh
         ZvEw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790175410; x=1790780210; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=80Q/UmLn++8SJbn/lU8/3FTYgpvMd1cRbPxOu7j8FDU=;
        b=oyHvfVm07uVv6wAvcM3rC8TuEXaCrxYgYS59IpqZOpwyRDUa0tp5JK50mzUuSpiEzV
         X+mTdKH8nKMvYvJHPGJtpiYbKpTcCMu7YMpHkPrNACNC9RF9UQgLmXoHbOqsKd9BQlK6
         7/AyW9GSIAawe1FaNfSkuXMpb3JV9TbaEW06aCABr/BetDCcBg5x3xndQ01BQmD8u/W1
         BHc8jRtJE8XStDIZ4sMj8U9ra3+njoOeDxx9XGhxJendEyP4Rd5SfdaDDmwOTawwNUmY
         7pIeH7Shq1tZYDAeBSmiJTTlkaFEDCAipuaST3/TpYT2cPl8UkzBkfvodNZRtnqGpcAZ
         APZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790175410; x=1790780210;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=80Q/UmLn++8SJbn/lU8/3FTYgpvMd1cRbPxOu7j8FDU=;
        b=SL4CvGvs2utLRzPtvG0E305agZevk2RzsugzVeL6pSnsdcUCj+7WlgksI11/CC7eZ3
         7jkqhAfyjnofs7PpOBomYTD+YCvLYXU/fgE1y1hmuAMjI+8fJk+LqirI7ic41TWYsm44
         5ixfUGHqxVWvNm5eKuCfbFp47tSiHqIXmTulAWiHYjmrrhZx7bYVbEqRaMSYMZbCpl38
         5GPG6raH5PnG5vO94i7Bi1mwmzwfisCxyyOxIiuuQ261FrP7139EUGCTnVJ2erZ7Qjx7
         p9vmjPiXg/28DxDNXEBfsJXyNDtcsB+GjgV9U46a7AEuijOXJcMmOhjWi5QaRq9qe/XV
         3qzQ==
X-Forwarded-Encrypted: i=1; AKwUvBxitVDqiDksU5IperT5+SfZrAwroTSyd3Fr+bVPoeTkWbrP+jClH5dN3dmFpMBeJk4wnoBQ4g==@lists.linux.dev
X-Gm-Message-State: AFuF++muJpXMgoScTFibrr0GuOYvz0C3+Ev3t1k+6IduWcM8Nnsb6bS6
	eu3KeeZM7HsuvVuYdOP7BeQ1QlvUqVF0GrxatgjQwW3gmLaJvtiYgD/DZRN+/6/cLRAMN5+d65n
	mqGytmEyQBqu8KL+GXuM41aBIg7OafUNxG7hbGwAnZg==
X-Gm-Gg: AYBFou3gn0ndS6tAKJfukt2lNJmnvIC+0/bKW/2fXxOgI+xr4196T4ETdvoCGhdOmUS
	0ysKbVI0veFEIl0xVJ8Uvq3xGPW5bHbpiv9aoyQrE8Nn6lwGX62eoGAnMVelAO77Ny8/L3giaLm
	uQyYGcCGA3ILo9pWAOiwvhkTA0+6xbSH2hDdS+Hi6EBXcyAGJ+SvpFGqHmGmpA87JvgjARqajQD
	KlsOdwVUu+jaqtK3PWH3Np0DhOGi1Z/eilcSklTarZuReIjQ5XMTRwstszT5YKTQyx83v+/DCic
	z2hdqCPXbR6o0LUUKvB6IvCgJY+r9K9FgLtReqPltMoEaUD8PmqDcWIpgn44+VT2BfBdKY0D5Oj
	WakC8/xauLQw=
X-Received: by 2002:a05:6402:5514:b0:6aa:129a:1f70 with SMTP id
 4fb4d7f45d1cf-6aab3b647e8mr2420276a12.43.1790175409790; Wed, 23 Sep 2026
 07:56:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260916-remoteproc_virtio_map-v1-0-dac8c5eb4aa9@valla.it>
 <20260916-remoteproc_virtio_map-v1-8-dac8c5eb4aa9@valla.it>
 <arKhbxi3Snbt1_Mn@p14s> <arLZj2DxBazf3wMd@bywater>
In-Reply-To: <arLZj2DxBazf3wMd@bywater>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Wed, 23 Sep 2026 08:56:38 -0600
X-Gm-Features: AclHuK883D6T5DYJIUEwz22c4TjWkQLK7CcGTqdjz7jqNMirfKCdfrjOT14z4v4
Message-ID: <CANLsYkzC5DU8j_QJLkuUcV2tYb=G86L_G4yiBZTePKSqiRdd6w@mail.gmail.com>
Subject: Re: [PATCH RFC 08/12] dt-bindings: remoteproc: add remoteproc-virtio
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

On Tue, 22 Sept 2026 at 13:44, Francesco Valla <francesco@valla.it> wrote:
>
> On Tue, Sep 22, 2026 at 09:40:31AM -0600, Mathieu Poirier wrote:
> > On Wed, Sep 16, 2026 at 11:10:53PM +0200, Francesco Valla wrote:
> > > Add a new binding to describe remoteproc-provided virtio devices; while
> > > these are discovered through a resource table parsed by the remoteproc
> > > infrastructure at runtime, their description can be needed to probe
> > > non-discoverable buses (such as I2C) or to link consumers and suppliers.
> > >
> > > Each vdev is described by a dedicated "group" node, which then includes
> > > a virtio-device node, which binding is already existent and used by
> > > virtio-mmio. Each vdev shall be stattically linked to a "group" node
> > > using its index inside the resource table as the reg property of the
> > > node; this permits to have multiple instances of the same type of
> > > device.
> > >
> > > The binding is intended to be generic and adopted by any remoteproc
> > > provider.
> > >
> > > Signed-off-by: Francesco Valla <francesco@valla.it>
> > > ---
> > >  .../bindings/remoteproc/remoteproc-virtio.yaml     | 89 ++++++++++++++++++++++
> > >  1 file changed, 89 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/remoteproc/remoteproc-virtio.yaml b/Documentation/devicetree/bindings/remoteproc/remoteproc-virtio.yaml
> > > new file mode 100644
> > > index 000000000000..c4a0d84b1460
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/remoteproc/remoteproc-virtio.yaml
> > > @@ -0,0 +1,89 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/remoteproc/remoteproc-virtio.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Virtio devices over remoteproc
> > > +
> > > +description: |
> > > +  Virtio devices ("vdevs") can be exposed using the remoteproc infrastructure
> > > +  and its resource table. For some of them, a device tree node might be needed
> > > +  to describe remote undiscoverable hardware and/or connect consumers and
> > > +  providers.
> > > +
> > > +maintainers:
> > > +  - Francesco Valla <francesco@valla.it>
> > > +
> > > +properties:
> > > +  virtio:
> > > +    description: Contains a group of Virtio devices exposed by the remoteproc.
> > > +
> > > +    properties:
> > > +      '#address-cells':
> > > +        const: 1
> > > +
> > > +      '#size-cells':
> > > +        const: 0
> > > +
> > > +    patternProperties:
> > > +      "^vdev@[0-9a-f]+$":
> > > +        type: object
> > > +
> > > +        properties:
> > > +          reg:
> > > +            description: Virtio device index inside the resource table.
> > > +            maxItems: 1
> > > +
> > > +        additionalProperties:
> > > +          type: object
> > > +          $ref: /schemas/virtio/virtio-device.yaml
> > > +          maxItems: 1
> > > +
> > > +        required:
> > > +          - reg
> > > +
> > > +    additionalProperties: false
> > > +
> > > +    required:
> > > +      - '#address-cells'
> > > +      - '#size-cells'
> > > +
> > > +additionalProperties: true
> > > +
> > > +examples:
> > > +  - |
> > > +    remoteproc-cm33 {
> > > +      virtio {
> > > +          #address-cells = <1>;
> > > +          #size-cells = <0>;
> > > +
> > > +          vdev@0 {
> > > +              reg = <0>;
> > > +
> >
> > Do we need the 'reg' since we already have vdev@X?  I'll let the DT people
> > provide their input on this.
> >
>
> AFAIK yes, because the rproc_get_vdev_fwnode() helpers search for indexed
> child nodes using the 'reg' property, not the node name. This I believe
> is the preferred way of doing things.
>
> > > +              gpio {
> > > +                  compatible = "virtio,device29";
> > > +
> > > +                  gpio-controller;
> > > +                  #gpio-cells = <2>;
> > > +              };
> > > +          };
> > > +
> > > +          vdev@1 {
> > > +              reg = <1>;
> > > +
> > > +              i2c {
> > > +                  compatible = "virtio,device22";
> > > +
> > > +                  #address-cells = <1>;
> > > +                  #size-cells = <0>;
> > > +
> > > +                  eeprom@50 {
> > > +                      compatible = "atmel,24c1025";
> > > +                      reg = <0x50>;
> > > +                  };
> >
> > The previous patch introduced bindings for virtio SPI while the above two are
> > for GPIO and I2c, which is very confusing.  I suggest you pick one and apply
> > everywhere.
> >
>
> This is because both GPIO and I2C bindings are already defined - even if
> not used in the devicetree files part of the kernel tree.
>
> Moving forward, I plan to submit at least the spi-virtio bindings as a
> separate patch set, as they can be used independently of this one.

I suggest you leave spi-virtio out of this patchset.  That way we can
concentrate on doing only one thing.

>
> > > +              };
> > > +          };
> > > +      };
> > > +    };
> > > +...
> > >
> > > --
> > > 2.55.0
> > >
>
> Regards,
> Francesco
>
