Return-Path: <SRS0=8mM2=JX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F47C433ED
	for <iommu@archiver.kernel.org>; Mon, 26 Apr 2021 07:14:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6555A611C0
	for <iommu@archiver.kernel.org>; Mon, 26 Apr 2021 07:14:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6555A611C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1756840271;
	Mon, 26 Apr 2021 07:14:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yZgRm-6h5tll; Mon, 26 Apr 2021 07:14:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id EB34640264;
	Mon, 26 Apr 2021 07:14:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D45FBC000E;
	Mon, 26 Apr 2021 07:14:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AE837C000B
 for <iommu@lists.linux-foundation.org>; Mon, 26 Apr 2021 07:14:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A934740306
 for <iommu@lists.linux-foundation.org>; Mon, 26 Apr 2021 07:14:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BrQrUuuvcHon for <iommu@lists.linux-foundation.org>;
 Mon, 26 Apr 2021 07:14:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0D8D040305
 for <iommu@lists.linux-foundation.org>; Mon, 26 Apr 2021 07:14:07 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id i3so38740086edt.1
 for <iommu@lists.linux-foundation.org>; Mon, 26 Apr 2021 00:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=o5YosDAqgcHK5JSw+rSfNotOSlvHjgAK1HQEBC6w8O4=;
 b=tpKrec62Hw8s3i2pcRV4bu4HKWAkT78kqycNK/3PBanAEoLPhbO+yvd0UzcQ1fm9wt
 FlzOgdN2WJ0AyIubw8syOmrqxxtHRN8nK+9G5u0/m38Nkj+9r0oEXSFy6UzbuEbTzMJ6
 l6XI16uici4FlPgkQx+ihGlcHkYjUhUORwTnJkLxYPLBpBudUfRQbL4fGpYyTs+nP+1j
 ZVE9J6DJ00p2+ET5vDUiaL11TyJMxrclw2iktGi+AhUqTqlqu8/s1ZE0WbtxMMxziFrP
 ZvsDDpxh6JunXik8Rg06C6EpcnTql6q74mQrlCosRwxsvaa+BRLDlS8XCNZ/L2lptjrw
 UEpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=o5YosDAqgcHK5JSw+rSfNotOSlvHjgAK1HQEBC6w8O4=;
 b=oI8zf/rIeS1V6Hv6sqczNovV2CZGWjEVZO7kILsIjpEC6a5wMnfTWP/sVgSFTa10GM
 RnimvwKw6CLYC7OGdPs/i+AQ+KmaMjUffzH8kl5M2lCwkU8Qqemw4WRieX38XSTjOrJL
 OiDuNPfFPcK++cWDl54WOtLrP9J4i4wGCT9vwVgeybks+CCcVCRUqDv++QYwXEwVqsFb
 lfzTdHbKQKfug0FFx3OHoQWDMyB4PZG/CFQB2OEFD032RURLQbPn/BEfhfqmbrwYNTUD
 BuWnATYa2MV+MZIffxk43ZbHGC1u+djvL0NfhOif3v7XAJQBbrAG21lkyUqc7MVqgK6i
 2cog==
X-Gm-Message-State: AOAM533vIPxY0s2l2b12R8xTFEIewAhSv37E4vHbxqwa/SpVUZd4YW2q
 /x5ZzFR8AAq0x8jbIxROfWo=
X-Google-Smtp-Source: ABdhPJwoKjHDcmBY3hkB2/ZQchvIWgXSk5emYdxx5mRVLZZ6iEkE33viNcicn1ga/0UHiUMxMY8Log==
X-Received: by 2002:a05:6402:40d6:: with SMTP id
 z22mr19357889edb.275.1619421246066; 
 Mon, 26 Apr 2021 00:14:06 -0700 (PDT)
Received: from localhost (p2e5be10e.dip0.t-ipconnect.de. [46.91.225.14])
 by smtp.gmail.com with ESMTPSA id da25sm6607998edb.38.2021.04.26.00.14.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Apr 2021 00:14:04 -0700 (PDT)
Date: Mon, 26 Apr 2021 09:14:57 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v1 2/2] iommu/tegra-smmu: Revert workaround that was
 needed for Nyan Big Chromebook
Message-ID: <YIZocTpPPM0vF4Wk@orome.fritz.box>
References: <20210328233256.20494-1-digetx@gmail.com>
 <20210328233256.20494-2-digetx@gmail.com>
 <20210401085549.GA31146@Asurada-Nvidia>
 <50a7e4c7-0e72-534a-a317-366e455213c1@gmail.com>
 <d01ccde4-5fa9-2aa7-c28b-b3899cc54c54@collabora.com>
 <724e683f-5317-cdf7-7351-fcfd42b7b607@gmail.com>
 <5ec2be61-a70e-e3b1-9267-414793c32a04@gmail.com>
MIME-Version: 1.0
In-Reply-To: <5ec2be61-a70e-e3b1-9267-414793c32a04@gmail.com>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Cc: Guillaume Tucker <guillaume.tucker@collabora.com>,
 iommu@lists.linux-foundation.org, Jonathan Hunter <jonathanh@nvidia.com>,
 linux-tegra@vger.kernel.org, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org
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
Content-Type: multipart/mixed; boundary="===============2052131639156727153=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============2052131639156727153==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8nVwfCHntELqmzZ3"
Content-Disposition: inline


--8nVwfCHntELqmzZ3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 24, 2021 at 11:27:10PM +0300, Dmitry Osipenko wrote:
> 23.04.2021 18:23, Dmitry Osipenko =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > 23.04.2021 18:01, Guillaume Tucker =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >> On 02/04/2021 15:40, Dmitry Osipenko wrote:
> >>> 01.04.2021 11:55, Nicolin Chen =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>>> On Mon, Mar 29, 2021 at 02:32:56AM +0300, Dmitry Osipenko wrote:
> >>>>> The previous commit fixes problem where display client was attachin=
g too
> >>>>> early to IOMMU during kernel boot in a multi-platform kernel config=
uration
> >>>>> which enables CONFIG_ARM_DMA_USE_IOMMU=3Dy. The workaround that hel=
ped to
> >>>>> defer the IOMMU attachment for Nyan Big Chromebook isn't needed any=
more,
> >>>>> revert it.
> >>>>
> >>>> Sorry for the late reply. I have been busy with downstream tasks.
> >>>>
> >>>> I will give them a try by the end of the week. Yet, probably it'd
> >>>> be better to include Guillaume also as he has the Nyan platform.
> >>>>
> >>>
> >>> Indeed, thanks. Although, I'm pretty sure that it's the same issue wh=
ich
> >>> I reproduced on Nexus 7.
> >>>
> >>> Guillaume, could you please give a test to these patches on Nyan Big?
> >>> There should be no EMEM errors in the kernel log with this patches.
> >>>
> >>> https://patchwork.ozlabs.org/project/linux-tegra/list/?series=3D236215
> >>
> >> So sorry for the very late reply.  I have tried the patches but
> >> hit some issues on linux-next, it's not reaching a login prompt
> >> with next-20210422.  So I then tried with next-20210419 which
> >> does boot but shows the IOMMU error:
> >>
> >> <6>[    2.995341] tegra-dc 54200000.dc: Adding to iommu group 1
> >> <4>[    3.001070] Failed to attached device 54200000.dc to IOMMU_mappi=
ng =20
> >>
> >>   https://lava.collabora.co.uk/scheduler/job/3570052#L1120
> >>
> >> The branch I'm using with the patches applied can be found here:
> >>
> >>   https://gitlab.collabora.com/gtucker/linux/-/commits/next-20210419-n=
yan-big-drm-read/
> >>
> >> Hope this helps, let me know if you need anything else to be
> >> tested.
> >=20
> >=20
> > Hello Guillaume,
> >=20
> > The current linux-next doesn't boot on all ARM (AFAIK), the older
> > next-20210413 works. The above message should be unrelated to the boot
> > problem. It should be okay to ignore that message as it should be
> > harmless in yours case.
> >=20
>=20
> Although, the 20210419 should be good.
>=20
> Thierry, do you know what those SOR and Nouveau issues are about?

There's a use-after-free (though it's really a use-before-init) issue in
linux-next at the moment, but a fix has been suggested. The fix for this
along with an additional leak plug is here:

	http://patchwork.ozlabs.org/project/linux-tegra/list/?series=3D240569

I'm not aware of any Nouveau issues. What version and platform are those
happening on? Are there any logs? I can't seem to find them in this
thread.

Thierry

--8nVwfCHntELqmzZ3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmCGaHEACgkQ3SOs138+
s6GG8w/8Dru/37L+I4463P/zyNgJnBU4GvCHytaoIIoRaH6Ku5fg2O723riz10ES
Sq4K03sPrtRDVhgZxUPF2wYP6yI4e5R7D/2Dc11Yren8VDJHeoafikpzb9LWUEJ0
xAVKj5dDtAJlCAMmdnHTtOxNdl6UB7d22hMY0fXlqzc7Grk+JYIey3ZXLUz0AHEq
OCvOxHBmDzSVMYKXR+It/RYcmLC3PKCwHJe37DVF0pa/pfR7vBzCVl/xVuKQ0Ww2
M8+sm4ilfMel6eNQvsDFzrAZNXiPFCNArVETJxWGl3Mq+PndBewozyn6GyLqlx74
Tnqr8wtsI4TgcEiOqaEWJC1/NGOGDat14OGtqwCOPZlzm5QwUjOCfo01tJn8vD8R
/47l6gK6rDp4oQEErGuHpnQgk4eLLJ+2M/CN6p5nXE+ArjuxNvz2mmoBpENj0jSv
ShsT9h7CrFtwsauOkOlEDfRpUUstZz79m51mQaWRMR17CFOiNsLH/08Qyoyo1CSa
ViNB9Uo/pKl3l2DYG2LtpHoTt76vpgAiHCyRRuW4ij6a3gVevsnXHSmHNKKRAsMi
garQt5W+iyjdgosEQsVEcfLjm5ZNqXyoYKmn7UnKDPmZ+yeRLy8WBHyb2DnzAAb3
1m6AxV/uzkUQVb+xFbrpSAmx96VRgCj/484RO6zt4HdfLbxsK3g=
=o6eo
-----END PGP SIGNATURE-----

--8nVwfCHntELqmzZ3--

--===============2052131639156727153==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============2052131639156727153==--
