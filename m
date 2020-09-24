Return-Path: <SRS0=ygJE=DB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98798C4363D
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 14:33:17 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EA092311B
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 14:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TwhIrp96"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EA092311B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id CE2A8866EA;
	Thu, 24 Sep 2020 14:33:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OqHBh9ZE5AT9; Thu, 24 Sep 2020 14:33:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 20CEA86BCB;
	Thu, 24 Sep 2020 14:33:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0DFC3C0859;
	Thu, 24 Sep 2020 14:33:14 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D7E36C0051
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 14:33:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id C58182011A
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 14:33:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1IxcsT0pM-ZD for <iommu@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 14:33:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by silver.osuosl.org (Postfix) with ESMTPS id 64EA82D946
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 14:33:09 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id z4so4089528wrr.4
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 07:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=MsatcEHSQFvWMlRInUfKW6BCLff8AD73JZ7rX3OfMM8=;
 b=TwhIrp96H14uVN9tZJjHeh/CQnRq/CUna+Ngssh4dqKiMW/JzDn7qWsKs0QukCvMMc
 dI+GNseO9PoWBM39BHTD7grMnf32mYCdZP1RN4xmYVXaKr0/bc1qkJcOtUtVsEe8LDwa
 x9ZkcFgp3hp1LD4XIoJ/U2ZOZNF6TxcI8wZgZGh9yovlwufNL7rMEHPuXBqiyKOOWUXi
 959w3EGjAfNBOkMrdckhZBrOhnLphzFca0gFXACDQBxvR7Ot7thQPcF8rTUHWsxXU179
 U8EUv+q2ZQk0y7EIXZsx/3xqLP66SCNeI9ZeiYFNdkOk7Xph2TU7AmfW2B2MCAnO0Nax
 MIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=MsatcEHSQFvWMlRInUfKW6BCLff8AD73JZ7rX3OfMM8=;
 b=rNT1paqoQ9M4iTo/qcFL6Mybt/iaPFKArsvjs4PkemaAI8RW3k0qAzWd2y4RK3vZ3u
 EaaRVj9jvDn383xKr/3ydpEU7Hvm95UhaGf4yTJYEGatzEbwwxG292zz17W0GfYDOZfD
 Cc5nlqk/lJ02aVq1hP+nFlXIKYzi5jwPMfLHT7AvG8SHviicOcOapTkAF1fblQCPxzgs
 NlfnAfo6RBzjuZJ2pdZzM9wFfmVH2d7bk/KT5VDqRPuavBLZgQIt51//tWIBBCBirvUf
 Z2B/8rqGsGHeQDgXzPHSIUAS8mUikwU3tnlvwpkkzPXnho6aQ7dRFVfpncIKl4oOUkrJ
 btuA==
X-Gm-Message-State: AOAM530IBsT6cwAjt2cBc6NCZYwkfR0ikEhR47ToO2OSG+PGACwFyqTN
 o3YyR9Mu2NhJt4EPKcMtZnY=
X-Google-Smtp-Source: ABdhPJySTNV3Gh2SLKq9Es0zyjW1sXzUyxQ2vgtBS1NRxfkElGSkiJAlBOiHkgNOtsh9a3+kPF0Lpw==
X-Received: by 2002:adf:f5c7:: with SMTP id k7mr84776wrp.246.1600957987713;
 Thu, 24 Sep 2020 07:33:07 -0700 (PDT)
Received: from localhost ([217.111.27.204])
 by smtp.gmail.com with ESMTPSA id i14sm3993711wro.96.2020.09.24.07.33.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2020 07:33:05 -0700 (PDT)
Date: Thu, 24 Sep 2020 16:33:04 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: IOVA allocation dependency between firmware buffer and remaining
 buffers
Message-ID: <20200924143304.GB2527337@ulmo>
References: <CAEC9eQOX9BHX4v5aY2cfCT=T-ZHA7y0xF7aiZhW9xzG4fme36Q@mail.gmail.com>
 <CAEC9eQPaeF9=Li74x9RrSHyDgRZ6b653yBRu6EYsaU+eSj2wsQ@mail.gmail.com>
 <59cda41f-170c-a1ad-a345-bc38b9ed4d73@arm.com>
 <CGME20200424161534eucas1p29177cad5b4790d392acb69a335a3992e@eucas1p2.samsung.com>
 <CAOD6ATrWYLPT0ydz2vFhNwWhqHum_q_pyCe=oGJWOcEqjmNOqQ@mail.gmail.com>
 <11584d09-5995-6133-3bd3-8f7a0afd0e01@samsung.com>
 <20200924082830.GB27174@8bytes.org>
 <37e767b8-8ec4-ae80-ea0d-1caf3cdab8fa@samsung.com>
 <20200924101640.GE2483160@ulmo>
 <1451f2dc-b64f-e7df-f0fa-f4107e18ee35@samsung.com>
MIME-Version: 1.0
In-Reply-To: <1451f2dc-b64f-e7df-f0fa-f4107e18ee35@samsung.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Cc: jean-philippe@linaro.org, will@kernel.org, linux-mm@kvack.org,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Ajay kumar <ajaynumb@gmail.com>, Shaik Ameer Basha <shaik.ameer@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, hch@lst.de
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
Content-Type: multipart/mixed; boundary="===============5559351634925888515=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============5559351634925888515==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GID0FwUMdk1T2AWN"
Content-Disposition: inline


--GID0FwUMdk1T2AWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2020 at 12:41:29PM +0200, Marek Szyprowski wrote:
> Hi Thierry,
>=20
> On 24.09.2020 12:16, Thierry Reding wrote:
> > On Thu, Sep 24, 2020 at 10:46:46AM +0200, Marek Szyprowski wrote:
> >> On 24.09.2020 10:28, Joerg Roedel wrote:
> >>> On Wed, Sep 23, 2020 at 08:48:26AM +0200, Marek Szyprowski wrote:
> >>>> It allows to remap given buffer at the specific IOVA address, althou=
gh
> >>>> it doesn't guarantee that those specific addresses won't be later us=
ed
> >>>> by the IOVA allocator. Probably it would make sense to add an API for
> >>>> generic IOMMU-DMA framework to mark the given IOVA range as
> >>>> reserved/unused to protect them.
> >>> There is an API for that, the IOMMU driver can return IOVA reserved
> >>> regions per device and the IOMMU core code will take care of mapping
> >>> these regions and reserving them in the IOVA allocator, so that
> >>> DMA-IOMMU code will not use it for allocations.
> >>>
> >>> Have a look at the iommu_ops->get_resv_regions() and
> >>> iommu_ops->put_resv_regions().
> >> I know about the reserved regions IOMMU API, but the main problem here,
> >> in case of Exynos, is that those reserved regions won't be created by
> >> the IOMMU driver but by the IOMMU client device. It is just a result h=
ow
> >> the media drivers manages their IOVA space. They simply have to load
> >> firmware at the IOVA address lower than the any address of the used
> >> buffers.
> > I've been working on adding a way to automatically add direct mappings
> > using reserved-memory regions parsed from device tree, see:
> >
> >      https://lore.kernel.org/lkml/20200904130000.691933-1-thierry.redin=
g@gmail.com/
> >
> > Perhaps this can be of use? With that you should be able to add a
> > reserved-memory region somewhere in the lower range that you need for
> > firmware images and have that automatically added as a direct mapping
> > so that it won't be reused later on for dynamic allocations.
>=20
> Frankly, using that would be even bigger hack than what I've proposed in=
=20
> my workaround. I see no point polluting DT with such artificial regions=
=20
> just to ensure specific IOVA space layout.

I think I misunderstood the requirements that you have. Sounds like
there are no actual restrictions for where exactly the memory resides
for the firmware, it just has to be lower than any of the buffer
allocations. I agree, in that case using reserved memory regions does
not make sense at all.

Thierry

--GID0FwUMdk1T2AWN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl9srhwACgkQ3SOs138+
s6Fc7g/6A2Cp3eZpcHF0cd3eW5gVBXB88kLcUUeD0VxSf5Iv2XUJESqQnWe/l8ok
VL6RyHOFTBJYP85WadEyoGoeWfCCIqjTCRQ822jYCuDYyd9b+gbiPMgt9jpT+K9R
0dyFGPQ+cGFpRyW0wAqEOS0aSXx3/CGkFaRYtKW2F8r0lzisjfkGB4FFAp1qMzsQ
VCLt+fKrLGXJn6QGcAyoI5q9oQxQKdvMd3ezpMaLMig6zZRgXQXn/ozx0zUQBhmO
WiOeQg3S8dBV1wxEH9IldweFBxo7DHCoIDp+n3UNpBIAYgfXeyFX90rZpqxC7oyB
allMlErNm1yQNfKz6dt+cbnO9sujnL1jSEBVLp3LCpxNGxjKn7oIXXHL4k4v+HlD
FpPgfjN4YR9Eb154uYQ6Vu68eDFce/iDLLEQU76o1kXapMRFl/r3KYij95sZPOe3
KyqXN9h+MBOvcFCxXszm3bCl+bWZY+++duRd6fq8ipccjWTU61Dvz4/mtQaSIIS6
u23k/dExNW719AqL/cTck0NnAHOSJZHwuiDOP2a8P1jPwzOeo26+tTQRoo/bLenC
GpwZfonqUshLZtvxzQM4R0+OyApWBn+9CMyUKACnvc2Nj3o4drswpBtmMlvNHTv/
rBAupHSkMW31kAEI7dsBUmEJbsrC3XEbSn0G45iu+oOpggYc6bc=
=+L/4
-----END PGP SIGNATURE-----

--GID0FwUMdk1T2AWN--

--===============5559351634925888515==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============5559351634925888515==--
