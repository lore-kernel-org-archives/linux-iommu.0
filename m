Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B9F41A921
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 13:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785160446; cv=pass; b=jrh0CNLdl6/u1Y6QsyMmZoEA1DA3PIcZJr/Bba67XgwV0phfF3tFqgmP134DRSCFloOjcoyRWuSQP7a8I6QYBy1JUTZfm4VCy7ioWU4X2j6II2A4SlE3S6A9pJX7zu8lVmnYyFmiyxOJFBaB2GeKGm3GpgVwYu9M9foTUkksIBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785160446; c=relaxed/simple;
	bh=fQJyxDv643pqDMxn0ByaDWbHqZIiq7Rg1W4GA2fAA2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uda1la21B5SLMBQbYcSyfoR20A9Ge08cJ/RhjlhjR3/tCkdHAU90lTElDKA6U78gGHjbJ1gVXBNOVQduyEL/59pxVNkiY6PQOAsq+JzmLfoT9cnIidcvqFLx1zFOIhRDUmoDV+QKJwGGiyvACFQcba6tClO3YWdsmr55VkdsFDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=Yqb5sFBo; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="Yqb5sFBo"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4954c0833b4so20610835e9.1
        for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 06:54:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785160443; cv=none;
        d=google.com; s=arc-20260327;
        b=jk9wrrhL1qyV9a1AJy0e9vwrlphG0+O60VhybSPdsc0K97t7VJunvO/fmzse3DhXge
         XQkroJqcp4cHwms2YznPhqXDdF1sTwd/g2gt3XsYHxVJHsz3ObhEImOLUZ/oCJouEZrE
         oSxmbWLQSD9y03AVgiDgAuOXbVDNOkUdd2QYr2rdhQnt9cMkmCtjJgopn7A7fwNs2HUU
         zmGr0tPQUG0ijHnr6J2+sMBt3mQK5oBT9OFCaGXj59lMjTKtJtGDhLab1eE37gR6JWLf
         S75Z9g8Z0WapMEw18CUZAbnBhqrR5pxyegYUD/VCx69e8KscnKxEm2K1k4PxkBN4cpbe
         6gHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LkTARaNCDvTrxIcriRua7Id7ovFdqPl8CcOFZ930Vas=;
        fh=mE8huzmPmNbBWhO2gRf2s3isvZp/gP+eg/b40h+RiCc=;
        b=ZHQwAd3SNGBKlhlfA3+iIUg94k+LBv8YoUglE7ItwNECPijiSKuZA/20I/2vB8NFif
         70eAoapMIZvtR/lSBzev9BDyzvZuLg5U2NJC3YHUUCEWNSebpQJjwJ3CNCA1THwV2lMv
         W1l1/9t6XzUv+QBgHoYKde2nCnwcmScQSCRL6Q6RUK+P0hmHD3jL5C+7nfGhhDonCipb
         J5f/QjCjvrTw8p0/l8CB9zz7tqalGSS8p3p/MNEXHjzwT509o9qyyuI4iOFEkGi/1bc6
         7a6BWHCXHgIDrlJd5ORQk3iLciJHQobykVkaHCrEj3xnuVwkwWamK9Q7SpnusaEEq6VN
         jL2w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1785160443; x=1785765243; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LkTARaNCDvTrxIcriRua7Id7ovFdqPl8CcOFZ930Vas=;
        b=Yqb5sFBo5iZTonjyZciO5I16vLKV2n9lT/AG0pc9aFHyyMYmBdFtQtgzd2y1J8765N
         Qu2qmcdD5dYfLIR2QhJXR6ruNzd1HQrknPRBeyNtesGLH9F80a3oe4bFxUXvyWiRukNt
         5HEUlDmIPlixLBuWPBHibbJDcxzjvOrHKgWhRnsthl4LNKj8lqmLgeRdMKd5Gg4OXZVz
         eqkv8wbFWa/dtpHtkCmefGTmuDz56Huy4VmK3mdHg15k7JVGMU8qU0Yy+xBg9fZg+uia
         ThTLracJOWkT0bzZYOyg4dTfAM9oEOGfMyoQ4TUVVzXyLWJ3LedYerwNn++HlxVbLzRk
         RR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785160443; x=1785765243;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LkTARaNCDvTrxIcriRua7Id7ovFdqPl8CcOFZ930Vas=;
        b=rMOwUOeLVHthRaOiHRfle88RynFVR2C285dqV2hg4ojs0uIA04R+TnDkrLCLVDzVSb
         7vvow9xytuMCtsRgDjR56/3Jm4UGT7LMKgBeTxlZUxxaFsV8x+W2bYH7HiQLfY2xg5S9
         1i7ua2OJ/n9W2FRL+3Qw+tR/kkJzPelQkiY42t1i3Tb0ARcqabPOiXhI09I6Q3Z0WpF2
         4+lWqnv8O3pMWyixfehGnhGD58kA/axvI9wjVMMO7i0oWpEUQp2FnSz7VdKGaObyhDJ0
         9m02R/+4ZyBMy4DYgWZZqNFdtfQ1x+PwW+r4rzG1mzrDpS+8CiuAE3nnxY9SqlU9tgbT
         crDQ==
X-Forwarded-Encrypted: i=1; AHgh+RpDstIzqfBNpPeb+fDiq9S47cDVF/n3+4Csy2sXN9cb5z3gU3QAVkExCFWeFk7m5IEUOozEyw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwTU5K0xL526wvUKjn1zTH+x/8hcwuQv9rJXVyNDzvE8MCPqLap
	CP+vplmLd3igrjAB1XZSiFI/JUJgZdSSagCYL5pXFgkIhuDaaf0jLbBH0yD+YoM/5a5wqF3PBaM
	uVB4exjvkka0RmnzTGY4pL8QDPlqFbTPpoI0rmV/vYw==
X-Gm-Gg: AR+sD1108q8852Uh34kwFIHnEgByF817qsn520Egtrq0zl0o6uWrRhmEQh9T4uqvJpI
	1zz5fHrDuyGPEbWGRZZ/egpjowQrMjHvOQFbnQwt9DUx8M9lmz/FAWvmTJsrtAKjp5RHZZNzqy+
	z1qYUUVkZfavDs1Wi1zJH7xAEutJTqYb6xmmuB1ZbsPW3ZHx+xubQ/QEZ2SHH5kynNtNsO8ooiv
	jfIM9PD7jI1UKccd9LICvVmuJ1Aie0woCNYswIHH9/YcDDk8hIcQyI8e3du2mGJB9QlcTv/hEHa
	R6rjYr84RrGEULDRrHFin5X/KC6d5DrwaSz8xXWPtN3b14LzvtdYTrRYNBMk/fyHc/x1cPcULnO
	L//0z
X-Received: by 2002:a05:600c:a12:b0:493:eccb:8cb2 with SMTP id
 5b1f17b1804b1-496b57297b8mr114877045e9.30.1785160442437; Mon, 27 Jul 2026
 06:54:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260727084003.1951324-1-anup.patel@oss.qualcomm.com> <71fd5b46-4388-4106-aee9-b4510069975f@arm.com>
In-Reply-To: <71fd5b46-4388-4106-aee9-b4510069975f@arm.com>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 27 Jul 2026 19:23:50 +0530
X-Gm-Features: AUfX_my4QjrER3hRFjzxXael861bKnyaiQylY-XLFhSCxIc_XNnqTG1sq5MogY4
Message-ID: <CAAhSdy2cDHO2w8VX34WV1kBxHQ6N0H0Ra_r6aDKK86250nWFSA@mail.gmail.com>
Subject: Re: [PATCH v2] driver core: platform: Setup device MSI domain just
 before driver probe
To: Robin Murphy <robin.murphy@arm.com>
Cc: Anup Patel <anup.patel@oss.qualcomm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <pjw@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>, Thomas Gleixner <tglx@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Tomasz Jeznach <tomasz.jeznach@linux.dev>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Saket Dumbre <saket.dumbre@intel.com>, Rahul Pathak <rahul@summations.net>, 
	Atish Patra <atish.patra@linux.dev>, Andrew Jones <andrew.jones@oss.qualcomm.com>, 
	linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	driver-core@lists.linux.dev, iommu@lists.linux.dev, 
	acpica-devel@lists.linux.dev, Sunil V L <sunilvl@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 5:46=E2=80=AFPM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> On 27/07/2026 9:40 am, Anup Patel wrote:
> > On RISC-V, the MSI controller (aka RISC-V IMSIC) is probed as a regular
> > platform device and MSI client drivers are always probed after the MSI
> > controller driver using fw_devlink. Unfortunately, this is not sufficie=
nt
> > to ensure device MSI domain is set for MSI client devices before driver
> > probe because OF framework sets device MSI domain at the time of platfo=
rm
> > device creation whereas ACPI framework expects arch specific code to se=
t
> > the device MSI domain at the time of platform device creation.
> >
> > Currently, to address the problem of device MSI domain being not set
> > correctly, various RISC-V MSI client drivers explicitly set device
> > MSI domain in the driver probe function using below code pattern:
> >
> >       /*
> >        * The device MSI domain for platform devices on RISC-V architect=
ure
> >        * is only available after the MSI controller driver is probed so=
,
> >        * explicitly configure here.
> >        */
> >       if (!dev_get_msi_domain(dev)) {
> >               /*
> >                * The device MSI domain for OF devices is only set at th=
e
> >                * time of populating/creating OF device. If the device M=
SI
> >                * domain is discovered later after the OF device is crea=
ted
> >                * then we need to set it explicitly before using any pla=
tform
> >                * MSI functions.
> >                */
> >               if (is_of_node(fwnode)) {
> >                       of_msi_configure(dev, dev_of_node(dev));
> >               } else if (is_acpi_device_node(fwnode)) {
> >                       struct irq_domain *msi_domain;
> >                       msi_domain =3D irq_find_matching_fwnode(imsic_acp=
i_get_fwnode(dev),
> >                                                             DOMAIN_BUS_=
PLATFORM_MSI);
> >                       dev_set_msi_domain(dev, msi_domain);
> >               }
> >
> >               if (!dev_get_msi_domain(dev))
> >                       return -EPROBE_DEFER;
>
> I stand by my previous comment that relying on ACPI initcall order and
> assuming fw_devlink is enabled doesn't really seem robust enough to
> justify dropping proper handling of this case, especially if pretending
> it's a generic interface.

I think you still fail to understand the root-cause of the msi_domain not
being set correctly in the struct device. There is no issue with the probe
order (or probe deferral) rather the issue is msi_domain being set very
early by OF / ACPI framework at the time of device creation when there
is no MSI domain registered.

Let's take the case of OF based platform devices with RISC-V:

1) The OF framework set the msi_domain at the time of platform
    device creation but unfortunately the RISC-V MSI controller
    driver is also a platform device (aka RISC-V IMSIC driver) which
    is probed much latter hence the msi_domain for all OF platform
    devices is set to NULL.
    (Refer call path,  of_platform_device_create_pdata() ->
of_msi_configure() -> dev_set_msi_domain()

2) The fw_devlink based probe ordering in the Linux DD framework
    ensures that RISC-V MSI controller driver is probed before the
    MSI client drivers (such as RISC-V APLIC MSI driver, RISC-V
    system MSI driver, etc) but still when these MSI client drivers
    are probed the msi_domain remains NULL for the platform device
    of MSI client.

3) Due to #1 and #2 above, the MSI client driver have to explicitlly
    call of_msi_configure() on RISC-V because no one updates the
    msi_domain of all platform devices after RISC-V MSI controller
    registers a MSI irqdomain.

This patch eliminates the #3 above by calling of_msi_configure()
right before probing the OF platform device.

Regards,
Anup
