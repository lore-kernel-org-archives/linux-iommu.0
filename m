Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8B53A8FE2;
	Wed, 21 Jan 2026 11:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768993340; cv=none; b=eTwpc0AUmQuvNz1kOrk9+x/hkDvbTv/YRRH3UjQMDFitE7bTKFllYSsW+ip4qu2zi0A1Njy8zUBsBGtnwqhrmXFR+c3wHUbOs+zoRoIHKRc6rzWh0fQhRaM+yt+QNL8GgjLNIv1heAEsXYGCQsNDaHWP0QaYSkwzu0NNi6UO8IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768993340; c=relaxed/simple;
	bh=8kyC71C1fYKyMdKH2TUs0LV7M6/6LOJ7dZNuLy9ltdg=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=OtmyHonA5pBowyT7VHMp1SII6AfH+GTpgl7z/lQ6k8LJ7muSrUiYmMwJEuZKtDvbcM67JjKSXI6dgp6BaQvZ/9bHH1p7dw5F1AjnD8qUvnewsxhR7+07fjvw6Wlyrohu1qm053TNGMBrW+mgsixk196mffufmhO2R4ln3hQwDxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TH6aZXwp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TH6aZXwp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 498F8C19422;
	Wed, 21 Jan 2026 11:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768993340;
	bh=8kyC71C1fYKyMdKH2TUs0LV7M6/6LOJ7dZNuLy9ltdg=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=TH6aZXwpd3Uek/qsHM85TdeOnxZVE0llSoWc/tB172GDFJ2/1qaGhL9sXiHzXK6St
	 vPLS3NGMLaF8zR+GcWTOy6MA70OcbwlU9KaacMMaaJNhciegMpXssNj9ZayqMQ6cdj
	 WqKSLa53bijebmX0vvu0CXtgnh51ExG5B4nIrEbsmDlVlvtGiGpbUo496Dm9JesPiH
	 cNA92tULgSjXqq07j9sl5IPok0B3DJis93APKcPxU+7/rq4+Po9FNpeQ9OtHcksx1/
	 po8Yksq18BANZ9kxoFDWZJwCDTMRBE4TCEiRA2iBmf6QwQhDctDEkDFr5cy3S+DYRH
	 dM0Qs1AjE5WLQ==
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Jan 2026 12:02:15 +0100
Message-Id: <DFU7SVI5SYE5.3MJP2ECGGZK5P@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v5] driver core: enforce device_lock for
 driver_match_device()
Cc: <Aishwarya.TCV@arm.com>, <broonie@kernel.org>, <chenqiuji666@gmail.com>,
 <linux-kernel@vger.kernel.org>, <m.szyprowski@samsung.com>,
 <robin.clark@oss.qualcomm.com>, <will@kernel.org>, <robin.murphy@arm.com>,
 <joro@8bytes.org>, <iommu@lists.linux.dev>
To: "Wang Jiayue" <akaieurus@gmail.com>, <hanguidong02@gmail.com>,
 <gregkh@linuxfoundation.org>, <rafael@kernel.org>
References: <CALbr=LYt-MqGM0ua78Rt7M679WR9hNnk0Or-WrB2myZ=KhaN0w@mail.gmail.com> <20260121085549.165428-1-akaieurus@gmail.com> <DFU7CEPUSG9A.1KKGVW4HIPMSH@kernel.org>
In-Reply-To: <DFU7CEPUSG9A.1KKGVW4HIPMSH@kernel.org>

On Wed Jan 21, 2026 at 11:40 AM CET, Danilo Krummrich wrote:
> So, the problem is that in the callstack of the arm-smmu driver's (a plat=
form
> driver) probe() function, the QCOM specific code (through arm_smmu_impl_i=
nit())
> registers another platform driver. Since we are still in probe() of arm-s=
mmu the
> call to platform_driver_register() happens with the device lock of the ar=
m-smmu
> platform device held.
>
> platform_driver_register() eventually results in driver_attach() which it=
erates
> over all the devices of a bus. Since the device we are probing and the dr=
iver we
> are registering are for the same bus (i.e. the platform bus) it can now h=
appen
> that by chance that we also match the exact same device that is currently=
 probed
> again. And since we take the device lock for matching now, we actually ta=
ke the
> same lock twice.
>
> Now, we could avoid this by not matching bound devices, but we check this
> through dev->driver while holding the device lock, so that doesn't help.
>
> But on the other hand, I don't see any reason why a driver would call
> platform_driver_register() from probe() in the first place. I think drive=
rs
> should not do that and instead just register the driver through a normal
> initcall.
>
> (If, however, it turns out that registering drivers from probe() is somet=
hing we
> really need for some reason, it is probably best to drop the patch and do=
n't
> make any guarantees about whether match() is called with the device lock =
held or
> not.
>
> Consequently, driver_override must be protected with a separate lock (whi=
ch
> would be the cleaner solution in any case).)

I assume that this should resolve the problem (unless there are more driver=
s
that register drivers in probe()):

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm=
/arm-smmu/arm-smmu-qcom.c
index 573085349df3..9bb793efc35f 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -774,10 +774,6 @@ struct arm_smmu_device *qcom_smmu_impl_init(struct arm=
_smmu_device *smmu)
 {
        const struct device_node *np =3D smmu->dev->of_node;
        const struct of_device_id *match;
-       static u8 tbu_registered;
-
-       if (!tbu_registered++)
-               platform_driver_register(&qcom_smmu_tbu_driver);

 #ifdef CONFIG_ACPI
        if (np =3D=3D NULL) {
@@ -802,3 +798,5 @@ struct arm_smmu_device *qcom_smmu_impl_init(struct arm_=
smmu_device *smmu)

        return smmu;
 }
+
+builtin_platform_driver(qcom_smmu_tbu_driver);

@qcom maintainers: I'm aware of commit 0b4eeee2876f ("iommu/arm-smmu-qcom:
Register the TBU driver in qcom_smmu_impl_init"), but I think the above pat=
ch
should work fine as it is still *not only* registered when
CONFIG_ARM_SMMU_QCOM_DEBUG?
