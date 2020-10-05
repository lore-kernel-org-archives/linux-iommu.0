Return-Path: <SRS0=BXsX=DM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A04C4727D
	for <iommu@archiver.kernel.org>; Mon,  5 Oct 2020 07:13:47 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AE0920796
	for <iommu@archiver.kernel.org>; Mon,  5 Oct 2020 07:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dONUoJUP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AE0920796
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 30D148445E;
	Mon,  5 Oct 2020 07:13:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZDmgk4yjQqJE; Mon,  5 Oct 2020 07:13:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3D3FF84056;
	Mon,  5 Oct 2020 07:13:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 23E80C07FF;
	Mon,  5 Oct 2020 07:13:45 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 726D9C0051
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 07:13:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6038784468
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 07:13:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id peXdUqHVmPSI for <iommu@lists.linux-foundation.org>;
 Mon,  5 Oct 2020 07:13:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
 [209.85.208.67])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 0DCFF84397
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 07:13:43 +0000 (UTC)
Received: by mail-ed1-f67.google.com with SMTP id g4so8113586edk.0
 for <iommu@lists.linux-foundation.org>; Mon, 05 Oct 2020 00:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=9UYGdvvrN9kR7U+w8b3/m+eI7gEt+1auK5RXKAkG5vU=;
 b=dONUoJUPuAg3TUpTEulTTlr+mcBul4FAEH6eUuX3M2CWDrRdvs5wnkkUrA4qfpVaPD
 xw4ZFFTK4lcEMQc/1I+h0VTQ29Dqbtp35K+y9LbwXs/SwCp5DZx/Amoy7FhZPEu2Ys+v
 LIZCWphWu/Be8yCF1SnyPjAgvyv5uRK0Ik42URBnVgCox53wG2JmGoCwDMsHie7hD+7L
 tHukYAe4WCUG/7bL3aTHcxLlKk2TRXSFmJUAVWtWLKvLEWIKePpMZAhguxuLm+MFzL9s
 KgemufbL7cqLhegNFnQ0HY+nkkYDVlL30+ykZs8scCk+yBzo3kVXm3nlqS6xelBrGkM8
 YoWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=9UYGdvvrN9kR7U+w8b3/m+eI7gEt+1auK5RXKAkG5vU=;
 b=jhr0ZaVXf/YB0ZKnRO/MH3WVNPRoYFiFtUJpdIVYXEDLLMVMKr9HIXK8dr+N9iFzSj
 N/8zwcoy2F/nWjD9QpGzRJsF1np8BsICXQ+Zm7Hk3ctqtvCYHZ5YVcxl+2PIz8n24Cc0
 RcfhFaqwnTPrN2UO3Ne55QRW8y+iEgaSmTOOLfWsRj+a69pPCS3BPvJ04UOo1+g1bD99
 LmgDLpws+mGJge8+Rt06MtiZMtRSI1NjS49Xhn/XBXYVOwM33MtyLw3Y9ltYTweCn1TJ
 TZ9yosFHnl2F/qSmFKpAvnJ5KkqhfPTvgJsVRhLy8uU3PhkeBm/LwNlq7hg16AlO3j2b
 tLRw==
X-Gm-Message-State: AOAM531W4zwyM0YbcHKLjVzA0ivR2nZZozbdmedXrat7IPN54PMSjp5Z
 Z8R1kM7irx8jsIS/KH6mo/A=
X-Google-Smtp-Source: ABdhPJyovGGbPEK/etbT03yzqWlL8f2Ix1tRzN+U8k+CQ1WgVaHOqJLnm3jbZhuklNbz3eO1MqT98g==
X-Received: by 2002:aa7:c7cd:: with SMTP id o13mr15521489eds.114.1601882021308; 
 Mon, 05 Oct 2020 00:13:41 -0700 (PDT)
Received: from localhost ([217.111.27.204])
 by smtp.gmail.com with ESMTPSA id a22sm7451720ejs.25.2020.10.05.00.13.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 00:13:39 -0700 (PDT)
Date: Mon, 5 Oct 2020 09:13:38 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v3 2/3] iommu/tegra-smmu: Rework .probe_device and
 .attach_dev
Message-ID: <20201005071338.GA425362@ulmo>
References: <20200930203618.GC2110@Asurada-Nvidia>
 <13746922-0253-cda7-e9ac-2bd20bf1a17f@gmail.com>
 <20200930213244.GA10573@Asurada-Nvidia>
 <5945a63e-79d8-e3ae-ab53-cee8c220ac7d@gmail.com>
 <20201001012630.GA28240@Asurada-Nvidia>
 <72b11925-5857-8ce5-d084-cab01ca1b396@gmail.com>
 <20201001024850.GA28456@Asurada-Nvidia>
 <20201001102316.GF3919720@ulmo> <20201001110425.GB1272@Asurada>
 <b966844e-4289-3ff0-9512-852f8419a664@gmail.com>
MIME-Version: 1.0
In-Reply-To: <b966844e-4289-3ff0-9512-852f8419a664@gmail.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 krzk@kernel.org, jonathanh@nvidia.com, linux-tegra@vger.kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2107190085648226115=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============2107190085648226115==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 01, 2020 at 11:33:38PM +0300, Dmitry Osipenko wrote:
> 01.10.2020 14:04, Nicolin Chen =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Thu, Oct 01, 2020 at 12:23:16PM +0200, Thierry Reding wrote:
> >  > > >>>>>> It looks to me like the only reason why you need this new g=
lobal API is
> >>>>>>>>>> because PCI devices may not have a device tree node with a pha=
ndle to
> >>>>>>>>>> the IOMMU. However, SMMU support for PCI will only be enabled =
if the
> >>>>>>>>>> root complex has an iommus property, right? In that case, can'=
t we
> >>>>>>>>>> simply do something like this:
> >>>>>>>>>>
> >>>>>>>>>> 	if (dev_is_pci(dev))
> >>>>>>>>>> 		np =3D find_host_bridge(dev)->of_node;
> >>>>>>>>>> 	else
> >>>>>>>>>> 		np =3D dev->of_node;
> >=20
> >>> I personally am not a fan of adding a path for PCI device either,
> >>> since PCI/IOMMU cores could have taken care of it while the same
> >>> path can't be used for other buses.
> >>
> >> There's already plenty of other drivers that do something similar to
> >> this. Take a look at the arm-smmu driver, for example, which seems to =
be
> >> doing exactly the same thing to finding the right device tree node to
> >> look at (see dev_get_dev_node() in drivers/iommu/arm-smmu/arm-smmu.c).
> >=20
> > Hmm..okay..that is quite convincing then...
>=20
> Not very convincing to me. I don't see a "plenty of other drivers",
> there is only one arm-smmu driver.

There's ARM SMMU, ARM SMMU v3 and at least FSL PAMU. Even some of the
x86 platforms use dev_is_pci() to special-case PCI devices. That's just
because PCI is fundamentally different from fixed devices such as those
on a platform bus.

> The dev_get_dev_node() is under CONFIG_ARM_SMMU_LEGACY_DT_BINDINGS (!).
> Guys, doesn't it look strange to you? :)

See above, there are other cases where PCI devices are treated special.
For example, pretty much every driver that supports PCI differentiates
between PCI and other devices in their ->device_group() callback.

> The arm-smmu driver does a similar thing for the modern bindings to what
> Nicolin's v3 is doing.

I don't really have any objections to doing something similar to what
ARM SMMU does. My main objection is to the use of a global pointer that
is used to look up the SMMU. As you see, the ARM SMMU driver also does
this lookup via driver_find_device_by_fwnode() rather than storing a
global pointer.

Also you can't quite equate ARM SMMU with Tegra SMMU. ARM SMMU can
properly deal with devices behind a PCI host bridge, whereas on Tegra
all those devices are thrown in the same bucket with the same IOMMU
domain. So it's to be expected that some things will have to be
different between the two drivers.

> >>> If we can't come to an agreement on globalizing mc pointer, would
> >>> it be possible to pass tegra_mc_driver through tegra_smmu_probe()
> >>> so we can continue to use driver_find_device_by_fwnode() as v1?
> >>>
> >>> v1: https://lkml.org/lkml/2020/9/26/68
> >>
> >> tegra_smmu_probe() already takes a struct tegra_mc *. Did you mean
> >> tegra_smmu_probe_device()? I don't think we can do that because it isn=
't
> >=20
> > I was saying to have a global parent_driver pointer: similar to
> > my v1, yet rather than "extern" the tegra_mc_driver, we pass it
> > through egra_smmu_probe() and store it in a static global value
> > so as to call tegra_smmu_get_by_fwnode() in ->probe_device().
> >=20
> > Though I agree that creating a global device pointer (mc) might
> > be controversial, yet having a global parent_driver pointer may
> > not be against the rule, considering that it is common in iommu
> > drivers to call driver_find_device_by_fwnode in probe_device().
>=20
> You don't need the global pointer if you have SMMU OF node.
>=20
> You could also get driver pointer from mc->dev->driver.
>=20
> But I don't think you need to do this at all. The probe_device() could
> be invoked only for the tegra_smmu_ops and then seems you could use
> dev_iommu_priv_set() in tegra_smmu_of_xlate(), like sun50i-iommu driver
> does.

Have you also seen that sun50i-iommu does look up the SMMU from a
phandle using of_find_device_by_node()? So I think you've shown yourself
that even "modern" drivers avoid global pointers and look up via
phandle.

Thierry

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl96x58ACgkQ3SOs138+
s6Hfqw/7B/INAr45UG7ZsLTRvp3N71EyInAaBUIUOAPBFkbeYyCUVXvprTSg0b7B
U4lUcYRYeuk/mMA2qHEBhDU9lJEgF2VGcR2IV9WmmZlzw81pst/LfnWx+2QFPgf2
U65wX6W+bFfw2mjnqng9Zd5a2DN2LT0hrnubqHLHd7tdJmvZSfaKzeU6HBMXQhou
LYBUt7EKJxXp9JyShzKQIX7sOkBkHNxCfNHyPuzdZDA+wvzObuswOOraJQBo1tdt
AyFyiFSK07qCJaHChDjjiZs+ZKTJK9/nhEaoOihnuaBxXc6ChQ/+TT2xrivzbsfz
c/lwcqE2jMFD/bYlzR4mnAtBwV+3R+n0thCaOzwfuY73wQ2Zgn16memCG4xgmUcg
Eiynic9UIuyJ1tCXYeuuiyeKLlhppvP/wYw7TKUJ1Ngn68gaqo+LmJk3UoH6Pcbu
zySppMLphqozxDGjTVdO9SR7DLw+ZKNsqWis/ZPtOdleSQzkyzkSI15q5kZfBoCf
EBmYDBRpjTnoLxbm8Mpr+uckqvITDoaP3FtXNDNTXfZtw/KbTzD1pWE5nVzZ8x00
SfZmvn7IjVp62pEORdm3/Z+PKZkoAq5/spXUl5SsSZpuOZ7I+hhZ1w8HqIng8v3+
72Gmm5kg3V5xBsGxoT6+qF6i996VWCRmB4LPGltMi7l3vmmtYxI=
=i1bH
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--

--===============2107190085648226115==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============2107190085648226115==--
