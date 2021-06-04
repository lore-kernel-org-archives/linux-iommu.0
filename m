Return-Path: <SRS0=eMD9=K6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90966C4743E
	for <iommu@archiver.kernel.org>; Fri,  4 Jun 2021 19:57:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F1EE613F8
	for <iommu@archiver.kernel.org>; Fri,  4 Jun 2021 19:57:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F1EE613F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EA5DA401E8;
	Fri,  4 Jun 2021 19:57:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lOIwVhMuExz1; Fri,  4 Jun 2021 19:57:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2D2F2401CC;
	Fri,  4 Jun 2021 19:57:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 088B1C000D;
	Fri,  4 Jun 2021 19:57:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 459E1C0001
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 19:57:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 38FDE83D96
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 19:57:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LF8aOZCcePEu for <iommu@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 19:57:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B900F83AFE
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 19:57:38 +0000 (UTC)
Received: by mail-pg1-x52c.google.com with SMTP id i5so8746633pgm.0
 for <iommu@lists.linux-foundation.org>; Fri, 04 Jun 2021 12:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
 :references; bh=XcPLPL/fr76RmVJu1kdzwNFB7f+nFqpQT28G0wE3jrA=;
 b=Z03eeqXllCov4ZbKKSvZJwzywxOvBtX0KkmeJm/UnFw4w9M/faXHfJnRt/hQCu/Vtz
 uG10D8Lh2CqaoSknLHkqyHHZ3iR8ldMRf9MUbgEnEXgsPDoXpyY+hNzgL1zpstNi3uqN
 HxPIva+GVP5z17q6yGB8qmBFSqIu9HvT5J3kKkYcnU8XPhkodQuv190nZfxBPXg6UT3w
 iOIhHuJIfW4Njs0jAtMG9mlyiC380SpiITeHQVhLH+MuFV91eDHeJ7Y3oKul+SlBcqZX
 azZsS+6PRXbMVitb5GO8NUGa9RgaZXNA4IBAaxFLEyEVlP+lTrbTfOKWHKqtMrR1RsG7
 RTcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:message-id:mime-version:subject:date
 :in-reply-to:cc:to:references;
 bh=XcPLPL/fr76RmVJu1kdzwNFB7f+nFqpQT28G0wE3jrA=;
 b=j9+ssXAn606EIxB9JHiFYagQ712NUx2rplDIFHHWFdBMOuvQzR6HCafhpYKdW8Y6Wz
 ifybroCvWevPHzv5ou/CeJKkLjzpmsHMkUyPQZKNgD2w36eCAtBdDar+VlfAMh2/1PU/
 27mQLErL22/dOgQpUDTAMCwaOHADD3PscLlPDYDybpV2tP/f4nlLlFj5jNz8Tv4TWEcJ
 RFkTneFk60KixxUWiyKz9ONRmJ5L5OByKD+GO5IMaW473IjZRMGB7X5Ck7pLNNEuQtDx
 YSwXwS3aonRGLyLQ/5HOevaxgyiXLLTvVUf9PTRKOhYDwbTPyYT8gX3lHUiIFUKh8w4J
 nTPw==
X-Gm-Message-State: AOAM532VaFJehc6QrONB892UvsGQ1FcI0JtIuhzgI+6ULzj29/s6p5zo
 jc/Ot2TkrcuOgHM/2WyJ5c0=
X-Google-Smtp-Source: ABdhPJzu5pmokS497sg/y+deevWmNaTczaDzxfy/K5+lu6yComISI7hRajEbrBsj6OLcZ4/xqm76QQ==
X-Received: by 2002:a05:6a00:be6:b029:2ec:967c:137b with SMTP id
 x38-20020a056a000be6b02902ec967c137bmr3634678pfu.44.1622836657812; 
 Fri, 04 Jun 2021 12:57:37 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net.
 [24.6.216.183])
 by smtp.gmail.com with ESMTPSA id 30sm2609478pgo.7.2021.06.04.12.57.36
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 04 Jun 2021 12:57:37 -0700 (PDT)
From: Nadav Amit <nadav.amit@gmail.com>
Message-Id: <45D949A1-F5F5-4230-A6BC-066CA3030579@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH v2 0/4] iommu/amd: Enable page-selective flushes
Date: Fri, 4 Jun 2021 12:57:35 -0700
In-Reply-To: <2ea809ef-beb5-a2c9-0739-cb236cab196b@arm.com>
To: Robin Murphy <robin.murphy@arm.com>
References: <20210524224159.32807-1-namit@vmware.com>
 <YLpI7tKtsf4l5MlN@8bytes.org>
 <05098022-1ED6-44BE-931D-D16C2D0B2D09@gmail.com>
 <2ea809ef-beb5-a2c9-0739-cb236cab196b@arm.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Cc: Will Deacon <will@kernel.org>, Jiajun Cao <caojiajun@vmware.com>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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
Content-Type: multipart/mixed; boundary="===============6250702496549014802=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============6250702496549014802==
Content-Type: multipart/signed;
	boundary="Apple-Mail=_AD487E4E-BF48-4051-85A3-FCCEB3DC3ED4";
	protocol="application/pgp-signature";
	micalg=pgp-sha256


--Apple-Mail=_AD487E4E-BF48-4051-85A3-FCCEB3DC3ED4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On Jun 4, 2021, at 11:53 AM, Robin Murphy <robin.murphy@arm.com> =
wrote:
>=20
> On 2021-06-04 18:10, Nadav Amit wrote:
>>> On Jun 4, 2021, at 8:38 AM, Joerg Roedel <joro@8bytes.org> wrote:
>>>=20
>>> Hi Nadav,
>>>=20
>>> [Adding Robin]
>>>=20
>>> On Mon, May 24, 2021 at 03:41:55PM -0700, Nadav Amit wrote:
>>>> Nadav Amit (4):
>>>>  iommu/amd: Fix wrong parentheses on page-specific invalidations
>>>=20
>>> This patch is already upstream in v5.13-rc4. Please rebase to that
>>> version.
>> I guess it would be rc5 by the time I send it.
>>>=20
>>>>  iommu/amd: Selective flush on unmap
>>>>  iommu/amd: Do not sync on page size changes
>>>>  iommu/amd: Do not use flush-queue when NpCache is on
>>>=20
>>> And I think there have been objections from Robin Murphy on Patch 3,
>>> have those been worked out?
>> I am still waiting for Robin=E2=80=99s feedback on my proposed =
changes. If he does not respond soon, I will drop this patch for now.
>=20
> Apologies, it feels like I've spent most of this week fighting fires,
> and a great deal of email got skimmed and mentally filed under =
"nothing
> so wrong that I need to respond immediately"...
>=20
> FWIW I would have written the simpler patch below, but beyond that I
> think it might start descending into bikeshedding - if you still =
prefer
> your more comprehensive refactoring, or something in between, then =
don't
> let my personal preference in style/complexity trade-offs stand in the
> way of getting a useful functional change into the AMD driver. =
Whichever
> way, though, I *am* now sold on the idea of having some kerneldoc to
> clarify these things.

Thanks, I appreciate your feedback.

I will add kerneldoc as you indicated.

I see you took some parts of the patch I did for MediaTek, but I think =
this is not good enough for AMD, since AMD behavior should be different =
than MediaTek - they have different needs:

MediaTek wants as few IOTLB flushes as possible, even if it results in =
flushing of many irrelevant (unmodified) entries between start and end. =
That=E2=80=99s the reason it can just use =
iommu_iotlb_gather_update_range().

In contrast, for AMD we do not want to flush too many irrelevant =
entries, specifically if the the IOMMU is virtualized. When an IOTLB =
flush is initiated by the VM, the hypervisor needs to scan the IOMMU =
page-tables for changes and synchronize it with the physical IOMMU. You =
don=E2=80=99t want this range to be too big, and that is the reason I =
needed iommu_iotlb_gather_is_disjoint().

I will add documentation, since clearly this information was not =
conveyed well enough.

Thanks again,
Nadav

--Apple-Mail=_AD487E4E-BF48-4051-85A3-FCCEB3DC3ED4
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEESJL3osl5Ymx/w9I1HaAqSabaD1oFAmC6ha8ACgkQHaAqSaba
D1oUdw//Zw9j2taQ/67+TP9CPtxNUz9ALG90MIoxNVs1xI2G/va/uaEHnIjN6C7v
aWhIDNKU8+MKizMwe7T0rfU82MOaPNgrVQwt22tbb+uyQlM59lVRoEvfnRaqz9YU
E12mPrtN8eB/wTvCIL33dIDptdebpExzYD5I7WI3XSH1KsoCVF73MjLqfe+gHRnq
hSr3Jpjpmg1/4W0f16bQkUgybuchtylSPZwloF3QCeRiLG2bRJb7VVgceESFrqmH
PZH3gubZx97PCUOSxFg6halUnEtMiWBKm7sJUhUikqUU1oOYrfxOjAxLF+fJ+2a+
sVB4qNs0KWyGjuT2C4nvbPGB6Ne4Axq96bVbV9PALJbmECEryAQoqwUANOxouvEk
liwIBe14BmDlw0zin19ueG4EO6/B/ehX5acLvBy19c4k74h03w1hk+RXyHcw5Qz9
R/c5Q5o1dLjUQstNvRcSs2Tx98SBaFwz9NoZI/UwIA/meEjK3xiotrKAwoWJnrLb
BoC0YN1jBJAmejVXhSJPcR/ZSlOmpAiFpOy6ADH0Q+DUmsLmnUDmtffl8eNi7X+Z
gsWSUyF+btaP7rRKrZyuLAlXLA+xTddE57rMyPP6DLc4kvBaRsHawTOauCJbOKGH
HEH11jorUMe+TUSjW0YVcpqKL1kubTaImjLf0s53gb0RtVvCZtQ=
=48Cc
-----END PGP SIGNATURE-----

--Apple-Mail=_AD487E4E-BF48-4051-85A3-FCCEB3DC3ED4--

--===============6250702496549014802==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============6250702496549014802==--
