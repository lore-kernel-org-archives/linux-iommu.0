Return-Path: <SRS0=ygJE=DB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22F4C4363D
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 10:23:45 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49CD723741
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 10:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKDFs6f1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49CD723741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id CCB23874A0;
	Thu, 24 Sep 2020 10:23:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u27pDfME0Wwh; Thu, 24 Sep 2020 10:23:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 198D38749F;
	Thu, 24 Sep 2020 10:23:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04D7CC0889;
	Thu, 24 Sep 2020 10:23:41 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 54BD5C0051
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 10:23:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 43EC9869ED
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 10:23:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w7UFbiBEuFlN for <iommu@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 10:23:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4A907869DE
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 10:23:38 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id d4so2945320wmd.5
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 03:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=gZTr6jKVJWBT4b9FYe4os7KKq9EIettyh4MTHWoR4TY=;
 b=PKDFs6f19rp55uBqg1s6mc/02OdH3LiLE4xwl102tLJqolty41BUdcS3PJo2zzp+ev
 wXIISPXFCiCYvP576m8UOEGFjEHsmkIMsiDzTC2eVFF/rw8R15A7ofeVpNxEcMaEttuA
 aruUCFs2ZDBJQBNOsEwaKfr9lLIsVHmUh4UaqghCS9OFdZwfqZ7nD6IVLS5p+PWQXSy4
 dKCygqDumJijzPP5I/7wiO17FMS+4tBz9dpKX1nBXMibDCEFSFchXqE5K3eYN+FvoNKX
 IXa3zvXNzgovrGwJ0M5aCu1CfGY8zwe5967rFlhzHAImPIHLPDhgpEr/A1oti/jGxfjq
 K7Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=gZTr6jKVJWBT4b9FYe4os7KKq9EIettyh4MTHWoR4TY=;
 b=sQcggij2W4C0vbKGBbyY/1YoCgxYSKC9Mo8UkTNOUEE2GWldU9w3EZIFD4/FT0T01+
 enRSx4IfGS7VzoqZPEk+hmQVzdFg8tRPDycjDnE34u1yquXFhYl7DAbx6khdZLdUodtd
 dysnkAggsbiEwP1na/NSco6P1mQcR6hTfDHRD6sfS+N9rAqal51tLP4Bg3jJ0a9SsomR
 C0lI/z4RSQnizMjjl9fgmyXWqsFl2VCknEFMaJ4RAxiJ9SeXBonnV+A/youbpWYuxry5
 t2e/td8ZQcN6PQiLqnhgs7A7cvKAKU7/4omxLdg4I2Nq03znNYTZotETyopV+6ZDUVsw
 w8EQ==
X-Gm-Message-State: AOAM533rxhBIE3Jip9cFofaqJSkqeis91UpIJTI9KIGU5DavhLoCSWfa
 zO2YQDRNxYyLc/gk1U5GUjE=
X-Google-Smtp-Source: ABdhPJwhuRMERw9p/nHHMg6pVZuFa6hzITzvP8M0CBrfe0EcJtOoL2dRd+frNm3C7Xww3RN6AFaeew==
X-Received: by 2002:a1c:9c4b:: with SMTP id f72mr3950986wme.188.1600943016827; 
 Thu, 24 Sep 2020 03:23:36 -0700 (PDT)
Received: from localhost ([217.111.27.204])
 by smtp.gmail.com with ESMTPSA id u186sm2895522wmu.34.2020.09.24.03.23.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2020 03:23:35 -0700 (PDT)
Date: Thu, 24 Sep 2020 12:23:33 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH 2/3] iommu/tegra-smmu: Fix iova->phys translation
Message-ID: <20200924102333.GH2483160@ulmo>
References: <20200911071643.17212-1-nicoleotsuka@gmail.com>
 <20200911071643.17212-3-nicoleotsuka@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200911071643.17212-3-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jonathanh@nvidia.com, linux-tegra@vger.kernel.org
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
Content-Type: multipart/mixed; boundary="===============1341033119207535908=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============1341033119207535908==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hAW+M2+FUO+onfmf"
Content-Disposition: inline


--hAW+M2+FUO+onfmf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2020 at 12:16:42AM -0700, Nicolin Chen wrote:
> IOVA might not be always 4KB aligned. So tegra_smmu_iova_to_phys
> function needs to add on the lower 12-bit offset from input iova.
>=20
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>  drivers/iommu/tegra-smmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> index 789d21c01b77..50b962b0647e 100644
> --- a/drivers/iommu/tegra-smmu.c
> +++ b/drivers/iommu/tegra-smmu.c
> @@ -795,7 +795,7 @@ static phys_addr_t tegra_smmu_iova_to_phys(struct iom=
mu_domain *domain,
> =20
>  	pfn =3D *pte & as->smmu->pfn_mask;
> =20
> -	return SMMU_PFN_PHYS(pfn);
> +	return SMMU_PFN_PHYS(pfn) + SMMU_OFFSET_IN_PAGE(iova);
>  }
> =20
>  static struct tegra_smmu *tegra_smmu_find(struct device_node *np)

Acked-by: Thierry Reding <treding@nvidia.com>

--hAW+M2+FUO+onfmf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl9sc6UACgkQ3SOs138+
s6H3aQ//YiyhKfdv1T0l5I+sWJLgPMt5Tv9V3Hul5HxECkRzIWLUFijryp3tLNlU
unup51XBCpV0Y/q1B8S7X0AhIqaoUM7aRXIiAbp6LwZuZDHyAKN7iS2e1IXdZ3lh
gl1c6r6boPVKiMRPcnOYKeukZSMsWO6RsnWlOZO5VgYjcYT2L+a94bCZ0Ogg3vpW
g47FFf22V+RnDF3UOFI/3sROkOLptSqEU7PgNUC67cS3rffTNoiW9FoxHYASJ70J
BapvXPZHDWKovcD4FdEIcoEc0phEO9knjPvh0ssOM07lzWUDqME7I2X1CcGtncd3
z/jmVjw8NwXyZEh50CkN3shUJdOeZ+1jO3jBb0EOAXWjjmK4zbDQgV3qdyC2CQLU
afRp4bq0wprYj+FCWDCA2i3ndNIWTgu3ArObLz5YiSf3Mny5dbO0S+d2pOGwGERZ
oeQEy3C/pK0vhy/ziLsTt6k8byU6JCRA4RMdCuTZSNH2v4Sk7eCwVupdf+QvZk0g
5Sj7nr00b5d1qSJFm8LoVxLAKxVW0AQdmN8x8TYbAiY/R1KzaSBnU+bJMNXZIrqo
iJ2XLQlyYwNyXSzAOPwiYA2FP2k1G/QF8rBUFZgBgP5RVtIiGDcnyw6MSYJpQ88X
qgI6SuOmQqwxYH64pYrThfrVyzZC49sVuf4pqzgDSA3NyDh2QW4=
=W1ct
-----END PGP SIGNATURE-----

--hAW+M2+FUO+onfmf--

--===============1341033119207535908==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============1341033119207535908==--
