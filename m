Return-Path: <SRS0=bNYQ=AE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF063C433DF
	for <iommu@archiver.kernel.org>; Tue, 23 Jun 2020 12:33:52 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A352220716
	for <iommu@archiver.kernel.org>; Tue, 23 Jun 2020 12:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Km8eT+/N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A352220716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 603F5895D5;
	Tue, 23 Jun 2020 12:33:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cuehaVoAMAX7; Tue, 23 Jun 2020 12:33:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id CF499895CC;
	Tue, 23 Jun 2020 12:33:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A58DEC088E;
	Tue, 23 Jun 2020 12:33:51 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 40CE2C016F
 for <iommu@lists.linux-foundation.org>; Tue, 23 Jun 2020 12:33:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 171F72078C
 for <iommu@lists.linux-foundation.org>; Tue, 23 Jun 2020 12:33:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jd+9i5g+eBpy for <iommu@lists.linux-foundation.org>;
 Tue, 23 Jun 2020 12:33:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com
 [209.85.218.65])
 by silver.osuosl.org (Postfix) with ESMTPS id 2B908204DB
 for <iommu@lists.linux-foundation.org>; Tue, 23 Jun 2020 12:33:44 +0000 (UTC)
Received: by mail-ej1-f65.google.com with SMTP id w16so21440813ejj.5
 for <iommu@lists.linux-foundation.org>; Tue, 23 Jun 2020 05:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=30SAKFPQimrg7HfeM0k4d4h70bpCAoDQ381GiN74sfg=;
 b=Km8eT+/N1jc92cnH+YZIZ6aDEoV1S3U7kSMdPsd/xGkisGOsDInQgjCTyAvnN3Kdgs
 nJg9ogu5wXRKgqIMab77gh+9asX43rx3A/QlqRDBk85P46Z3EaxD+pB6adpD08r8KGjQ
 q7g4xj/IdLkqm7NgldBzvTjIz6nQQdFC4eDEUrr7S2UJ9Itag/aWtwXWhfelIAiKp2cs
 bHo901xTd/T/Q2uw/JtEJAJrLpOziIcyfHtJRLmLgoUZ5FBLCGEU2MBybyNjpqm3OR00
 n+1f8GDYFnnKWAiTE4Nm1Ahn5Uno3/hlmQaJISnRv6sD6JsBXXsnCwywP8d1JWCZQlxP
 2MBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=30SAKFPQimrg7HfeM0k4d4h70bpCAoDQ381GiN74sfg=;
 b=faFjwTlx0IY1bBa5BioDDDXPa2/EtL08Eif3keZWoIgtAt1SjeUojMNE/EozK5Ooux
 LGQfIk1GHet+C/G35ZyuX7FquaPRkLTw8oBQLWJZCJ8Eh8yrDI7l09LVS2kwEjMCv1OV
 hdPv+hi7ExJNzr1aR++PyWQ3/d0y2hSL3aotBYLw6+/QSxpgRminrnHb8ExKvXzJRPm0
 lo6ejHbz59OxdTnCpIdGSYRtW9DUmqASFYCD7wpqqEyoVSqzClQg9K3mADR4hRR7s4ut
 1whkhxmFGL58FvbSN5xIRYfH5w5ND4vTT0mvIQH53y7vHAquNXSrZK9pZpdotQFxWv3k
 lI0g==
X-Gm-Message-State: AOAM531RVJOc9GQeerJi+jTX/nQpfiENwlHaooBRuYQOKydXX2zyNFeS
 rGeHcQoiRbaubE+CAlzvvZo=
X-Google-Smtp-Source: ABdhPJzwuKRc487tG9XzHN2VHGlbJ03At5WFM+NxaEuJoR2uuR0SVg6pjfA1LNVllF3OnwURr2VfvA==
X-Received: by 2002:a17:907:abb:: with SMTP id
 bz27mr20983635ejc.170.1592915622280; 
 Tue, 23 Jun 2020 05:33:42 -0700 (PDT)
Received: from localhost ([62.96.65.119])
 by smtp.gmail.com with ESMTPSA id lw11sm13134042ejb.58.2020.06.23.05.33.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 05:33:40 -0700 (PDT)
Date: Tue, 23 Jun 2020 14:33:39 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v6 3/4] iommu/arm-smmu: Add global/context fault
 implementation hooks
Message-ID: <20200623123339.GA696655@ulmo>
References: <20200604234414.21912-1-vdumpa@nvidia.com>
 <20200604234414.21912-4-vdumpa@nvidia.com>
 <20200623083643.GB4098287@ulmo>
 <2dda4530-39cc-d549-1124-26337dd9afbe@arm.com>
MIME-Version: 1.0
In-Reply-To: <2dda4530-39cc-d549-1124-26337dd9afbe@arm.com>
User-Agent: Mutt/1.14.4 (2020-06-18)
Cc: treding@nvidia.com, bhuntsman@nvidia.com, linux-kernel@vger.kernel.org,
 snikam@nvidia.com, iommu@lists.linux-foundation.org, mperttunen@nvidia.com,
 talho@nvidia.com, nicolinc@nvidia.com, linux-tegra@vger.kernel.org,
 yhsu@nvidia.com, praithatha@nvidia.com, will@kernel.org,
 linux-arm-kernel@lists.infradead.org, bbiswas@nvidia.com
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
Content-Type: multipart/mixed; boundary="===============3708246895008767214=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============3708246895008767214==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2020 at 12:30:16PM +0100, Robin Murphy wrote:
> On 2020-06-23 09:36, Thierry Reding wrote:
> [...]
> > > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > > index 243bc4cb2705b..d720e1e191176 100644
> > > --- a/drivers/iommu/arm-smmu.c
> > > +++ b/drivers/iommu/arm-smmu.c
> > > @@ -673,6 +673,7 @@ static int arm_smmu_init_domain_context(struct io=
mmu_domain *domain,
> > >   	enum io_pgtable_fmt fmt;
> > >   	struct arm_smmu_domain *smmu_domain =3D to_smmu_domain(domain);
> > >   	struct arm_smmu_cfg *cfg =3D &smmu_domain->cfg;
> > > +	irqreturn_t (*context_fault)(int irq, void *dev);
> > >   	mutex_lock(&smmu_domain->init_mutex);
> > >   	if (smmu_domain->smmu)
> > > @@ -835,7 +836,9 @@ static int arm_smmu_init_domain_context(struct io=
mmu_domain *domain,
> > >   	 * handler seeing a half-initialised domain state.
> > >   	 */
> > >   	irq =3D smmu->irqs[smmu->num_global_irqs + cfg->irptndx];
> > > -	ret =3D devm_request_irq(smmu->dev, irq, arm_smmu_context_fault,
> > > +	context_fault =3D (smmu->impl && smmu->impl->context_fault) ?
> > > +			 smmu->impl->context_fault : arm_smmu_context_fault;
> >=20
> > A simpler way might have been to assign arm_smmu_context_fault to all
> > implementations. That way we wouldn't have to perform this check here
> > and instead just always using smmu->impl->context_fault.
>=20
> But smmu->impl can still be NULL...
>=20
> Everything in impl, including the presence of impl itself, is optional, so
> the notion of overriding a default with the same default doesn't really m=
ake
> much sense, and would go against the pattern everywhere else.

True. I had assumed that every implementation would set smmu->impl
anyway, in which case there'd be little reason to use these default
fallbacks since each implementation could simply directly refer to the
exact implementation that it wants.

Perhaps the above could be made a bit more palatable by using a standard
if/else rather than the ternary operator? That would also more closely
match the pattern elsewhere.

Thierry

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl7x9p8ACgkQ3SOs138+
s6FZPg/9HSAfgoaJNJaXTtNi/OEDZY+VElZLtUMvcQUqt0cbrIEJaGnYnsoTWi6K
K6p9wrmkmVs6D4yT8I84B+Fe34KFdITXA8NPGPD3g2YFSVCGwr1YzW9gtEwYliG2
c0q9TuA4tr1NF1F1Hy6B2vTgT22UIvXR38IXp9MP+Ti8EoM1VTcQL4S8ABruWT89
rUxYHWxWTOiBx401M2oyQY/ToahL1V/tjnS/muOpqxbAEl41NnHXQfdUcfjytZgg
uKMQZRvNCTufFFI3UWrW9vfimBnZWSTqtVtBC/0/c32e7sJvvf5HHXxaZ8+5roGw
trzSaZg4qbK3jq6TZSO/fIcWqrzdhO9ERBHUZt2MgvzBKAIX6VkRMlyPvoYLrVwv
Tto5T2vkq9XTMZB+vYqHMg54/3zntpoMA7BzHGXFItjebOXlkgCVGbJpDOCrxi2v
YIGPkFmV+RwOjf5oEsBAkQZ82trHmpjXJlu6Qx2IDiQpo9Lg3+YCyDRkFLODlRli
iS0jeeQzD0JoRjm7pnv8Yllop8VfPsYMA9WiURza8DQ6ccf8xFNpzlOB+CIa7zoA
PLUnvNCTsfxN5QzClaQ9mkyKq0YB9WXWgmJ2vaKIWMJp/vJkh9k+ZBfMJd1AgrFo
H12y1uz7qUlU94llCeiaLwgYnh02QiKDjLWT5+gDKhXuHMm5tcs=
=8o7I
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--

--===============3708246895008767214==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============3708246895008767214==--
