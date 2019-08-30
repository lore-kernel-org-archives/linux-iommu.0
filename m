Return-Path: <SRS0=ODk1=W2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BC0C3A5A4
	for <iommu@archiver.kernel.org>; Fri, 30 Aug 2019 11:19:36 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 836F621897
	for <iommu@archiver.kernel.org>; Fri, 30 Aug 2019 11:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpTPS/qp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 836F621897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6C61B5D75;
	Fri, 30 Aug 2019 11:19:36 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 0E14B5BE4
	for <iommu@lists.linux-foundation.org>;
	Fri, 30 Aug 2019 11:18:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
	[209.85.221.68])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 6BBFCE6
	for <iommu@lists.linux-foundation.org>;
	Fri, 30 Aug 2019 11:18:14 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id t16so6582901wra.6
	for <iommu@lists.linux-foundation.org>;
	Fri, 30 Aug 2019 04:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=MK/N1cs3pdVNjWhCaPYV2nk00LMCO2TH7MeXQEm9duU=;
	b=kpTPS/qpbp1aEb7nmI4LVVZ4pEMAsKJqWpjCrqIr+UAxhkA2CXIgIiiTijIfIyutJQ
	hMXbsuJDlzf4dLQ7EVji2Uioj0DT2WFYFatYTpHxAbzBPuibsMhONt3YfF+KEuTdqRs7
	8MMUVr6Zwlz42z5B/q/HWyRXekXfbW/KPKrr+4iLy32n2z4NVMtv5asWfMXRrBNfKzTx
	uYvbGQD4Rsdf7pSQdNXpR0DWQQ7uNgyLdW5JCfeGwuk7Kuxlb1iYzZlkpgDdNp6elV7i
	IDigCMGRS1o4gn9GaBYQdYLkAkAq16T84+f47W2X1RhXlpN4fPCnHLkkkDtieLGiBvpV
	cKlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=MK/N1cs3pdVNjWhCaPYV2nk00LMCO2TH7MeXQEm9duU=;
	b=G2zYVnaLAbdL+fvI8iS+0ko0NDYMbN9rVDo+4D/cWAwiWV2bW8lvxPZsFHxHJQL8vR
	hf6YAbwdKLJNfdflGPjn9e2VvKVhsSAQ3zHP6uZJ9VtRPQ0pmkBcbg/uvrgD0cDpCwP2
	ViLLNO5PO+FdPP6IzztGa/Wc9CpuDEi1gr9u+oSNMHk0WUSjgB+5qGsliuVB4nZUlep8
	rAl3SNGERLtMQsrOymvM1BBq/Alz0EUo0qhEqRFXfskUTqGxuyk98qXhcZ5WK21qz+i0
	SOZu62KlvmcQnD6rsBP9eGgA0V0mlVWPv/hz49/33k+d7ZYea+1YI2unbCYBcbxEig78
	X2qA==
X-Gm-Message-State: APjAAAU/PG0AsKY0lQ36BcLvd/hkaTESlIYGgXXBpPFbuD4Qv0y7EkrK
	7to1Zoq4pqKNAH6RLQQmW8o=
X-Google-Smtp-Source: APXvYqyUz++sgTIOKGKI3gAlM6O7DdeIyQLVj5+xMRalBzdvkmqakR32MzGUi7HYRzHpxQR8Gfe0MA==
X-Received: by 2002:a5d:51c6:: with SMTP id n6mr1641558wrv.206.1567163893010; 
	Fri, 30 Aug 2019 04:18:13 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
	by smtp.gmail.com with ESMTPSA id n18sm4446870wru.2.2019.08.30.04.18.11
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 30 Aug 2019 04:18:11 -0700 (PDT)
Date: Fri, 30 Aug 2019 13:18:10 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Krishna Reddy <vdumpa@nvidia.com>
Subject: Re: [PATCH 5/7] arm64: tegra: Add Memory controller DT node on T194
Message-ID: <20190830111810.GE23902@ulmo>
References: <1567118827-26358-1-git-send-email-vdumpa@nvidia.com>
	<1567118827-26358-6-git-send-email-vdumpa@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <1567118827-26358-6-git-send-email-vdumpa@nvidia.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Cc: snikam@nvidia.com, thomasz@nvidia.com, jtukkinen@nvidia.com,
	mperttunen@nvidia.com, praithatha@nvidia.com,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	talho@nvidia.com, yhsu@nvidia.com, linux-tegra@vger.kernel.org,
	treding@nvidia.com, avanbrunt@nvidia.com,
	linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: multipart/mixed; boundary="===============6467593598916130860=="
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org


--===============6467593598916130860==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/2994txjAzEdQwm5"
Content-Disposition: inline


--/2994txjAzEdQwm5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2019 at 03:47:05PM -0700, Krishna Reddy wrote:
> Add Memory controller DT node on T194 and enable it.
> This patch is a prerequisite for SMMU enable on T194.
>=20
> Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi | 4 ++++
>  arch/arm64/boot/dts/nvidia/tegra194.dtsi       | 7 +++++++
>  2 files changed, 11 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi b/arch/arm64/=
boot/dts/nvidia/tegra194-p2888.dtsi
> index 62e07e11..4b3441b 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
> @@ -47,6 +47,10 @@
>  			};
>  		};
> =20
> +		memory-controller@2c00000 {
> +			status =3D "okay";
> +		};
> +
>  		serial@3110000 {
>  			status =3D "okay";
>  		};
> diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/d=
ts/nvidia/tegra194.dtsi
> index adebbbf..d906958 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> @@ -6,6 +6,7 @@
>  #include <dt-bindings/reset/tegra194-reset.h>
>  #include <dt-bindings/power/tegra194-powergate.h>
>  #include <dt-bindings/thermal/tegra194-bpmp-thermal.h>
> +#include <dt-bindings/memory/tegra186-mc.h>
> =20
>  / {
>  	compatible =3D "nvidia,tegra194";
> @@ -130,6 +131,12 @@
>  			};
>  		};
> =20
> +		memory-controller@2c00000 {
> +			compatible =3D "nvidia,tegra186-mc";

I think we need to make this "nvidia,tegra194-mc" and then enhance the
Tegra186 driver to match on that compatible string.

Nothing to worry about just yet and I can make that change when
applying.

Thierry

> +			reg =3D <0x02c00000 0xb0000>;
> +			status =3D "disabled";
> +		};
> +
>  		uarta: serial@3100000 {
>  			compatible =3D "nvidia,tegra194-uart", "nvidia,tegra20-uart";
>  			reg =3D <0x03100000 0x40>;
> --=20
> 2.1.4
>=20

--/2994txjAzEdQwm5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl1pBfIACgkQ3SOs138+
s6F3pw/3cgWOBb8LS08yjsbxQJkSYr3KYazBB/0FtFlaIBLaASqL+2XxQRNgHKsx
pdXxkOABv6ltpV7L06zNs3HJZG6jkDpBy0Glpo0J6B8QEFqlNnZNVkLp2AzXZO/K
pkXadSzvUq9pBh8nJJ8V1FvVnj4pj+dgzVE7JO7+1onjG195Hd2dyTmYysvtgvGr
m92kq+YsBZDPoqVq3XhWcrKGpnQq+mXqseg4InEfcCb35Kn0mhgguiYDh9QcfbfF
+TOnm/A5ddPV+qXy4WMGHBZyqADRVrtMJh4o7/NyAfYEwL6f+DSGKLcP6nBJRZ1S
DPsSDwQE1v2RHjYVhflHnfx4VEGL81+Twvn5RcNghOZqi6vzWbcYMSE+edwQHNwC
rcFUtMMNuW1M1NdcgvgzHLdCyCa5EREVr28SPuAFIDtdYyYgc2PVaYNdx/zu3oN9
y9uPmwcsvydOZzQHylsAgBt21EvmvijdOVayTIMe+M8ZZzKDIWmsb2NlCjAUG/Uw
z7pUuHLwtZywFYAWP9r/8xp+M7PQNyMPyTqR3iF7p1+IzAQ0gLb6k4HKzejkIVV9
jZ3Jpe7la3Q6i9o0vBX/NQw4WoxS4V7oBLuSXlOrEXNdx2naO+JjUYifqj6DZNP5
T/yXjA3RJM/77CvrxXafkTG1EO68lceZeZPQgUpV9NOocRY9IQ==
=7ECF
-----END PGP SIGNATURE-----

--/2994txjAzEdQwm5--

--===============6467593598916130860==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============6467593598916130860==--
