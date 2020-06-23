Return-Path: <SRS0=bNYQ=AE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593EDC433DF
	for <iommu@archiver.kernel.org>; Tue, 23 Jun 2020 08:38:34 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25E3820707
	for <iommu@archiver.kernel.org>; Tue, 23 Jun 2020 08:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oba7UMxu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25E3820707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id DC89C8852D;
	Tue, 23 Jun 2020 08:38:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1bH4vqLDtQ33; Tue, 23 Jun 2020 08:38:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 804C787726;
	Tue, 23 Jun 2020 08:38:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6E091C0891;
	Tue, 23 Jun 2020 08:38:33 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1A1E0C016F
 for <iommu@lists.linux-foundation.org>; Tue, 23 Jun 2020 08:38:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 05E208852D
 for <iommu@lists.linux-foundation.org>; Tue, 23 Jun 2020 08:38:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vQEt-rxlwLkw for <iommu@lists.linux-foundation.org>;
 Tue, 23 Jun 2020 08:38:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
 [209.85.208.66])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 7A95087726
 for <iommu@lists.linux-foundation.org>; Tue, 23 Jun 2020 08:38:31 +0000 (UTC)
Received: by mail-ed1-f66.google.com with SMTP id m21so15694432eds.13
 for <iommu@lists.linux-foundation.org>; Tue, 23 Jun 2020 01:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=KGfmCcP5g2L4qhGcwuqQFp+/Ilq6uH2EI6aUHJQmZb8=;
 b=oba7UMxue4VkTJ6mnnTKqhdJABWrSTnwFBTGl0KzioFLdPw3lwKD/Wuudpgq6qwgss
 u68UZq76S+MaP3bmQZ7yPjwL5HvsyQKWA0K8DQf3GHtC8OrjtPw4zB95umuoaf+LPQ7H
 NZe32Z9B1ACwnmiZYofgATmfVXLr+AZO6ok1dzTgBPx78gKul/+wqvn5fA3TOdDvHRX4
 RpzQqyP9mkREb90SppGg7pIsKWv8NppMkn7HS5zKfTFAt5cWa58plrLHAF7HDtYvfDel
 DSvI+XQDZyC+nzEhjetHe2yx5pJVEj667BCgEFrR9fSqmaZIONgza34Ni25NkmZThNW4
 zPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=KGfmCcP5g2L4qhGcwuqQFp+/Ilq6uH2EI6aUHJQmZb8=;
 b=irBG/uF5eistyJobDbTDMJhGQMrIU3lYpC9UzhOXQCHIJOIVuE9cwTIMRcoY3gD75J
 EfYbfVLET5wFHvl5zSOFOX7hJMuNeWq6meSthRvXEYOI9cjhbxmw1jJOunFs7IFk2Fpg
 RJjnnRVzt6hODMwtSPLTPNu6+/lYImvHrTEtdqFjHP9CRT/NBEi3Dqvl6sNCASCkN0Y4
 3qMLTyiZpc3Rg4h9cQcyuZdfPOXFZZb0a5mWYtRSqW0NnPlUMbZf1fKGZq1LwJr7ezEl
 7/k43IZY1mwPnnPTXr9kW7UNhdRqXI7KmTp0VRJrslfjyA+STXZUC+Y6bJlSrhPXPfY6
 vvtA==
X-Gm-Message-State: AOAM5335Ih28jPiWGr4zF8tnx9PTZg7cb+0UV58Q4+RlCFqEIHy53fgF
 5oi3UqHu6D/CeP0uO+hhDIk=
X-Google-Smtp-Source: ABdhPJwSBbh0R7MdzbdnGq7YVNkE+unXplKitsfBGfmOeW1hwWfXdt/wX9bCOi9oqEIcFQUXxRV33w==
X-Received: by 2002:aa7:d7cf:: with SMTP id e15mr5330879eds.236.1592901509923; 
 Tue, 23 Jun 2020 01:38:29 -0700 (PDT)
Received: from localhost ([62.96.65.119])
 by smtp.gmail.com with ESMTPSA id f10sm8753967edx.5.2020.06.23.01.38.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 01:38:28 -0700 (PDT)
Date: Tue, 23 Jun 2020 10:38:27 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Krishna Reddy <vdumpa@nvidia.com>
Subject: Re: [PATCH v6 2/4] dt-bindings: arm-smmu: Add binding for Tegra194
 SMMU
Message-ID: <20200623083827.GC4098287@ulmo>
References: <20200604234414.21912-1-vdumpa@nvidia.com>
 <20200604234414.21912-3-vdumpa@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20200604234414.21912-3-vdumpa@nvidia.com>
User-Agent: Mutt/1.14.4 (2020-06-18)
Cc: treding@nvidia.com, bhuntsman@nvidia.com, robin.murphy@arm.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 mperttunen@nvidia.com, talho@nvidia.com, snikam@nvidia.com,
 nicolinc@nvidia.com, linux-tegra@vger.kernel.org, yhsu@nvidia.com,
 praithatha@nvidia.com, will@kernel.org, linux-arm-kernel@lists.infradead.org,
 bbiswas@nvidia.com
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
Content-Type: multipart/mixed; boundary="===============6687887963704442739=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============6687887963704442739==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xo44VMWPx7vlQ2+2"
Content-Disposition: inline


--xo44VMWPx7vlQ2+2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 04, 2020 at 04:44:12PM -0700, Krishna Reddy wrote:
> Add binding for NVIDIA's Tegra194 Soc SMMU that is based
> on ARM MMU-500.
>=20
> Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Docu=
mentation/devicetree/bindings/iommu/arm,smmu.yaml
> index e3ef1c69d1326..8f7ffd248f303 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> @@ -37,6 +37,11 @@ properties:
>                - qcom,sc7180-smmu-500
>                - qcom,sdm845-smmu-500
>            - const: arm,mmu-500
> +      - description: NVIDIA SoCs that use more than one "arm,mmu-500"
> +        items:
> +          - enum:
> +              - nvdia,tegra194-smmu-500

The -500 suffix here seems a bit redundant since there's no other type
of SMMU in Tegra194, correct?

Thierry

--xo44VMWPx7vlQ2+2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl7xv4MACgkQ3SOs138+
s6FMxg//ZuFzYh2293V3nX16k17CojdDjbyvYLsHgQcpJrsaFK2aAj0N7VRrvSee
E3d1/nAy1MfyeGet+xDtsdVqJliFDdV+I0IsClmxHLWxoGwjzIs1J/y0IwK8I9vo
Hk5U3Mr2bnUHf71mtLC90Axy0OMJXuNkVCSZ+Xri+0pGneI4ESkPJ8yg8h4L9bRM
m7+igCtqvn/pzT2CnzHNfhop+DC2VVgOcFgsF2yn0jRvjwcN3rLg8u4Xy1Y2dXmg
MWByT7aNi/BnfBQ4IBe5IBRoyw3jpNRof6g/6G0jZDQbUFA1qv5w5nvjlQ/m6Y1M
/mHGfPXtQMrz9LP+GTQHgHlzWNKgx78wUBbQTEs/Sc/QhCte4i+cyvHuFHSLjhQT
QVGJga23p9VOLoGsStBCUSz0m6dRlyt9e5/O2NedofW+9LEOFyzo+LhGA9TkOokw
kGfqwwVkGoc08ytVzxYR21sCNwLWa3TWalgbpFU4dVX0WTWFKKd052aK+eHoYjJr
TSBmX8+xF0RVPikYTtYqe3HrThqTjnERePhDuf9SWAerjLEDFeP/7RgbdC+xK3O/
20ijfFT82UADr+5pjdZpbkXd6YCRniccMw3iFb0NlCDVTJHcsAJOSvCa2p8InLei
XkuHU0wQAEPJ101mL8m6S7BP241bnGS8lmlV0a3tyvZ01M3+OOs=
=pSyW
-----END PGP SIGNATURE-----

--xo44VMWPx7vlQ2+2--

--===============6687887963704442739==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============6687887963704442739==--
