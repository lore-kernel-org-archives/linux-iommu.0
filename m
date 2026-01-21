Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3632B2DE1E0;
	Wed, 21 Jan 2026 16:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769011543; cv=none; b=LJTc7AuPgmvEcJTF81IGFtiFW8I+PCWqeFG1i3CcvN/B8/vjXU5J+6fs0e4m930FAJ44qR/RqGZsQdEHhnv/asBJ1kWwb4jyFivhA5heeGjNT98AQetKdTLv/+EW7d6+59VHOLvcap9lbI2hzUAUrpolUKxIjcFP86b9lZYF4gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769011543; c=relaxed/simple;
	bh=+XXifxIzgcTJ3aqY5fFJg3+/NCrXj9uBQTF3nUjPP9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OeC1nHaGaqMX8S2m9s7E3Nf3crlQeLBlO7ICiK4mGd9TT/Nt+U3fAd5lbChgoEAJLKk84ShZGOZyPyncqZqncZ4yBQQR+n9Xp47aRFWf/yE0rEM4W8BgR8Q69UuziAN9cYTUHIQvFTTqs6qGe5QctfflxsdxgnnpCEWG/n2Bv+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUn5CB4I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUn5CB4I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C317C116D0;
	Wed, 21 Jan 2026 16:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769011542;
	bh=+XXifxIzgcTJ3aqY5fFJg3+/NCrXj9uBQTF3nUjPP9c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hUn5CB4IDHqmXukCU9BcL26Tvfs2z2HQcgoOZ8LRzJonMdVZcU/eZXWSiWPRappxn
	 ZOiCU1bbToiOU2MroEzxliimiv3Pdoc2iN4ELl5E61Y5DZtgNfCk/knferG74NiWuU
	 napIpiKCyCo9VEhy0x1y6DDWS7nDGv3WaNs6xothT8Ra3LVzfkRregRCUC2xW2iEAt
	 HSYQ6z+qjgpEUWEsXrvQXmjBBKAiGoNfoDE6+cKOCg+zAp14ys+OaFww0eEWrhHdIP
	 yT/yEtNKoM6vtt1Bqwo5Qrkx7IMrTd74qeTCrxO+ZQ7A2qrU7srGVFwkZ4uywFL10z
	 esSnPABlYVSjA==
Date: Wed, 21 Jan 2026 16:05:37 +0000
From: Mark Brown <broonie@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, robin.clark@oss.qualcomm.com,
	hanguidong02@gmail.com, quic_c_gdjako@quicinc.com,
	dmitry.baryshkov@oss.qualcomm.com, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-qcom: do not register driver in probe()
Message-ID: <02db754c-b689-45f0-92da-521e273f025e@sirena.org.uk>
References: <20260121141215.29658-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ChzoroEYYxNMitxq"
Content-Disposition: inline
In-Reply-To: <20260121141215.29658-1-dakr@kernel.org>
X-Cookie: Eschew obfuscation.


--ChzoroEYYxNMitxq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 21, 2026 at 03:12:01PM +0100, Danilo Krummrich wrote:
> Commit 0b4eeee2876f ("iommu/arm-smmu-qcom: Register the TBU driver in
> qcom_smmu_impl_init") intended to also probe the TBU driver when
> CONFIG_ARM_SMMU_QCOM_DEBUG is disabled, but also moved the corresponding
> platform_driver_register() call into qcom_smmu_impl_init() which is
> called from arm_smmu_device_probe().

This fixes the boot lockup on Juno for me:

Tested-by: Mark Brown <broonie@kernel.org>

--ChzoroEYYxNMitxq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmlw+VAACgkQJNaLcl1U
h9C2Awf+JTlEPX5L1eRIkZ1G0xUwbjSgqn3cw2vE2R6ou1mn1B+Zg7AQrliouFA1
lhr4dlAVlvMhPb0Pj855r6Xr2F7UPxR3rX203ecrbXUQoCN/NjEZkIMBFGy4Cxpr
tvLQyKjpbijfqqPARYEke+46IlJyaykzK3175jQkx3z+tNXMfB84dbJXOntcTBwM
adtPwEAraVaenGkGmW22AkSE1WdKPItAwic6142MyHpJHEzwc3k1ssAFmHPWuV5h
lsdJpfidJto6uoI7BgDkZ7ufFYGgQQIQE82CG/l2lAVVlt6NtXRrzARRGlazDLSt
viADbl4xQiZLJW5dZwom6oP7pcoS6w==
=Sdwb
-----END PGP SIGNATURE-----

--ChzoroEYYxNMitxq--
