Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9453E3C78;
	Thu, 23 Apr 2026 09:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776936374; cv=none; b=CLIjonesR1zsSxic+Xwqoj8VhqdAwBuZAvIoyrLt7yEH/9KbYGYPiJ3fFTaDZ7RKZ5LDzWciPl3C5NI6qTLH2mNZDXT5H8TuE/6XX4PtiQMzG+xW8Wxa7LOMgq2R6irZxpgk/XatunI4vEnS9ILXE6vl32IbjXbI1BjXZgIRDRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776936374; c=relaxed/simple;
	bh=bTadD+jv9LHiJ5uG3E23q5B3A9o1NoncHmFl/1EQxLo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=idAuTjUP43srUZ5fu/MH8kLyAZqoG/54psPTNYEHHWXslMsep2NzVktxqnO5TIWQwwNAiAJ1R/vNXtjsGlceqJLm5pHY9F6ykq5TXpw2WLKAugmGqppoiviBiScBEfZZKEVQ0OmJKg87fmSkoQ5D1xDS8yUbt5m6LPYsOgS1ZWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=aqDhl9yD; arc=none smtp.client-ip=185.70.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="aqDhl9yD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1776936363; x=1777195563;
	bh=mwZY5DucRwTXoJsKiFxV0MP4yG1k00/Tz8sAf1c7Zys=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=aqDhl9yDazSX273B0wC57PA2H3TYPW/MQbylGHS50ovDEBfJZpDMqaLhUrRuGX9E2
	 Rlgklk0tjr6IJol2wQFMGWEgwNSA9uJ0trqOXkbbVrpYd16GspswTW5MOuMUv1A1vc
	 5gxWaRyS6sPDO+k9I+ih6dpzlaMrqYPd/5yTTfjWLNt8/4mtp/OZ2I4FwDJKK8wTT1
	 xBwwejMHhBCDcqfT6ukam3SN4iAaUpSqROluh1twJLDz5mj2HcAmtzgSmUuRf3/Qu4
	 9t+QtjhCAT4KHVH0wgAsQuWtwZJc7JARHzEmyVHkBRQw6ihg6P5CFnwa2766eir1kA
	 mxV2g+wih3b6w==
Date: Thu, 23 Apr 2026 09:25:58 +0000
To: Baolu Lu <baolu.lu@linux.intel.com>
From: 70sp <70sp@protonmail.com>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [REGRESSION] GPU passes into VM improperly after c376a3456d8b or a98db518dde2
Message-ID: <FhMS_WRKl1GUZqMFEwdeZFpixCICEaQ-NIX6-eC7Nti1H0ZeEzBpWUkP5-t9lrOv-NcmW0iefExkPne5riXNqYZ2IM97uM_sg91cgAh4MNY=@protonmail.com>
In-Reply-To: <C4BK-Bp_FII0EkxSHQxBS2wO-Age-UxFrp_KfmYzb8cnQ8ZndzBBIPD8S9T86wOifBP0tysQGCFtGQsBsBvG2IzIMw3jb3NF5HGbS3tsawA=@protonmail.com>
References: <z7Rkts0EsooZcnCjNfJaK6ursftFU8ubOkH0hcNjzxugEAwGsHLMblOdfoAx-gJzBZ-TMmeUtD7iWBngbFY5UCJCwdSmYqmCVMy-yhbirUk=@protonmail.com> <56ce85d5-e0b9-407c-9a86-708111a8a509@linux.intel.com> <C4BK-Bp_FII0EkxSHQxBS2wO-Age-UxFrp_KfmYzb8cnQ8ZndzBBIPD8S9T86wOifBP0tysQGCFtGQsBsBvG2IzIMw3jb3NF5HGbS3tsawA=@protonmail.com>
Feedback-ID: 144929603:user:proton
X-Pm-Message-ID: 73f9431b3f8899114d03c5ddfa318c374fdad1d9
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

sending a friendly reminder about this ongoing regression.

Thank you for your attention.

On Tuesday, April 14th, 2026 at 11:22 AM, 70sp <70sp@protonmail.com> wrote:

> I can confirm, that the "domain is not compatible with device" message is=
 nowhere to be seen.
>=20
> I have double checked by also adding an else statement with a different m=
essage and that one showed up several times. (by pci (iGPU) 0000:00:02.0, p=
cieport 0000:00:01.0 and vfio-pci (GTX 970) 0000:01:00.0, 0000:01:00.1). re=
t =3D 0.
>=20
>=20
>=20
> Sent with Proton Mail secure email.
>=20
> On Monday, April 13th, 2026 at 8:49 AM, Baolu Lu <baolu.lu@linux.intel.co=
m> wrote:
>=20
> > On 4/12/26 19:17, 70sp wrote:
> > > Hello,
> > >
> > > I have been dealing with a regression launching a Windows QEMU/KVM
> > > virtual machine with a GPU passed through.
> > >
> > > The issue consists of launching a QEMU/KVM VM, which gets stuck for
> > > about 2 minutes on booting with a white screen and then having NVIDIA=
=E2=80=99s
> > > code 43 in Windows.
> > >
> > > I=E2=80=99m certain, that the issue is not caused by anything in Wind=
ows or
> > > related software in Linux, because I tried reinstalling my whole PC
> > > including the Windows VM. I tried to reproduce the bug on an out-of-t=
he-
> > > box Arch Linux install and the bug is still present.
> > >
> > > The first bad commit is either a98db518dde246e01ead53617dc0a30d6aaa37=
52
> > > or c376a3456d8bef43ec556a98c0a04c35086c2737. I don=E2=80=99t know for=
 sure which
> > > one introduced it, because during bisection I had to skip
> > > a98db518dde246e01ead53617dc0a30d6aaa3752 due to it being unable to
> > > launch the virtual machine resulting in a different error (didn=
=E2=80=99t even
> > > start booting). In kernels before these commits, the VM works flawles=
sly.
> > >
> > > I have tested it on latest mainline kernel and the issue is still
> > > present. I have been experiencing the issue since kernel 6.13, so I j=
ust
> > > switched to the 6.12 LTS kernel instead which doesn=E2=80=99t have th=
is issue.
> > >
> > > Configuration of my Linux install and hardware: https://pastebin.com/
> > > rcsyyYiK
> > > .config: https://pastebin.com/RTQCBduD
> > > dmesg errors: https://pastebin.com/84jPP81E
> > > lspci: https://pastebin.com/qi29BSWi
> > >
> > > #regzbot introduced:
> > > a98db518dde246e01ead53617dc0a30d6aaa3752..c376a3456d8bef43ec556a98c0a=
04c35086c2737
> >
> > Before these commits, if a device was attached to a domain that didn't
> > perfectly match the hardware's capabilities (such as address width or
> > coherency), the kernel would dynamically adjust the domain to
> > accommodate the hardware.
> >
> > Following these two commits, the driver now applies a "match or fail"
> > policy. If the domain is incompatible with the device's hardware
> > capabilities, it returns -EINVAL. This expects the caller to allocate a
> > new domain dedicated to that specific device and attempt the attachment
> > again.
> >
> > Can you please add a message line in paging_domain_compatible() to
> > verify whether it's a domain compatibility issue?
> >
> > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > index 205debd76989..c7e1e0dfa250 100644
> > --- a/drivers/iommu/intel/iommu.c
> > +++ b/drivers/iommu/intel/iommu.c
> > @@ -3111,8 +3111,10 @@ int paging_domain_compatible(struct iommu_domain
> > *domain, struct device *dev)
> >                  ret =3D
> > paging_domain_compatible_second_stage(dmar_domain, iommu);
> >          else if (WARN_ON(true))
> >                  ret =3D -EINVAL;
> > -       if (ret)
> > +       if (ret) {
> > +               dev_info(dev, "domain is not compatible with device, re=
t
> > =3D %d", ret);
> >                  return ret;
> > +       }
> >
> >          if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev) &&
> >              context_copied(iommu, info->bus, info->devfn))
> >
> > Thanks,
> > baolu
> >
