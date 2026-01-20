Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E0838F946;
	Tue, 20 Jan 2026 14:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768919247; cv=none; b=Ex9dees7wkksy3VYhQlmYeUwjDcKdcjoMNwmEFMxmCrI650cdLopc6TUrCrkdxmnpXV12kQak+JRUdjsrP0jVy1nbKGhq8Zns/jgvRCtENVQyELb8aqHosWQCH9OyEy4Jl19L75OC6opTT/01Frd0pfppObLKkea89wXdlMLshk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768919247; c=relaxed/simple;
	bh=RfyOja/qZmCGr/jYafKpgxD1MIXYyLKj1fQpTNb+o3c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KHrFp+CtBF/wNbox5DpstgOMuRhYOC1XFM5sZEFuxeGADa4DmRMEw0mgRnMr9z9sPMXAt+nidFExV/shjVVS9gXsDfLdCQW0gjIyf7jvbXIgcIMhNYMpr/YZWY0PqHi9TzG+n/FEmsXGXukP3AXhfqh04S2MxsNbrbzKIQ0fkmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMgmhc6X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMgmhc6X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E77FC16AAE;
	Tue, 20 Jan 2026 14:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768919246;
	bh=RfyOja/qZmCGr/jYafKpgxD1MIXYyLKj1fQpTNb+o3c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=IMgmhc6X9WJ/dl0TcFpwQnYjeNjew2Oy1ZkhXLUFaqnBKkzAyp9C3OeogfNWp6ePe
	 P+XwOywdFwhfX+jszHcSKt74M2YYe5gbR/+Gs8zdReOoq9YvDLNXzR8X0oJoDjU9Xx
	 74KN0g91S4ODK1oNQiTga3FCEEciebV0OItUpU6uZ7Yz/3bK7Wq4W90gJrihQcINfh
	 bipEcc+lGNOuiR6/R7XNl2EpuIedIpJ9FFxW/anTKiLk+gHLik3U1L3blQu/6N5RG+
	 NB0lrWZcgb6/2QCN+PipfLQqP6U9TiNj9Nxv9qX1346ZBtT7ucQdYn0LjJyBJTdCVH
	 DPHZezWO8/ObA==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-coco@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
	jgg@ziepe.ca, steven.price@arm.com,
	Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 1/2] dma-direct: Validate DMA mask against canonical DMA
 addresses
In-Reply-To: <893a6503-d33f-41d8-8966-19b9f251d9da@arm.com>
References: <20260120064255.179425-1-aneesh.kumar@kernel.org>
 <2a0b6d1b-875a-4075-8fc9-a8534afc9168@arm.com>
 <893a6503-d33f-41d8-8966-19b9f251d9da@arm.com>
Date: Tue, 20 Jan 2026 19:55:01 +0530
Message-ID: <yq5aqzrkjr9e.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Robin Murphy <robin.murphy@arm.com> writes:

> On 2026-01-20 9:59 am, Suzuki K Poulose wrote:
>> On 20/01/2026 06:42, Aneesh Kumar K.V (Arm) wrote:
>>> On systems that apply an address encryption tag or mask to DMA addresse=
s,
>>> DMA mask validation must be performed against the canonical DMA address.
>>> Using a non-canonical (e.g. encrypted or unencrypted) DMA address
>>> can incorrectly fail capability checks, since architecture-specific
>>> encryption bits are not part of the device=E2=80=99s actual DMA address=
ing
>>> capability. For example, arm64 adds PROT_NS_SHARED to unencrypted DMA
>>> addresses.
>>>
>>> Fix this by validating device DMA masks against __phys_to_dma(), ensuri=
ng
>>> that the architecture encryption mask does not influence the check.
>>>
>>> Fixes: b66e2ee7b6c8 ("dma: Introduce generic dma_addr_*crypted helpers")
>>=20
>>=20
>>> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>>> ---
>>> =C2=A0 kernel/dma/direct.c | 4 ++--
>>> =C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
>>> index 8e04f72baaa3..a5639e9415f5 100644
>>> --- a/kernel/dma/direct.c
>>> +++ b/kernel/dma/direct.c
>>> @@ -580,12 +580,12 @@ int dma_direct_supported(struct device *dev, u64=
=20
>>> mask)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * This check needs to be against t=
he actual bit mask value, so use
>>> -=C2=A0=C2=A0=C2=A0=C2=A0 * phys_to_dma_unencrypted() here so that the =
SME encryption mask=20
>>> isn't
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * __phys_to_dma() here so that the arch speci=
fic encryption mask=20
>>> isn't
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * part of the check.
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ENABLED(CONFIG_ZONE_DMA))
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 min_mask =3D min=
_t(u64, min_mask, zone_dma_limit);
>>> -=C2=A0=C2=A0=C2=A0 return mask >=3D phys_to_dma_unencrypted(dev, min_m=
ask);
>>> +=C2=A0=C2=A0=C2=A0 return mask >=3D __phys_to_dma(dev, min_mask);
>>=20
>> This is wrong, isn't it ? For e.g., for CCA, even though the "Flag" is
>> added to the PA, it is really part of the actual "PA" and thus must be
>> checked against the full PA ?
>
> Yes, it's much the same as for AMD SEV (albeit the other way round) -=20
> the encryption/decryption bit is part of the DMA address because it=20
> needs to be driven by the device, so it is crucial that the device's DMA=
=20
> mask is capable of expressing that.
>

Commit c92a54cfa0257e8ffd66b2a17d49e9c0bd4b769f explains these details.

I was wondering whether the DMA-enable operation should live outside the
set_mask operation. Conceptually, set_mask should be derived purely from
max_pfn, while the DMA enablement path could additionally verify whether
the device requires access to an alias address, depending on whether it
is operating in trusted or untrusted mode?

>
> Hence, as I think we've discussed before, for CCA we can't really=20
> support 32-bit devices doing DMA to shared pages at all, unless the=20
> whole VM is limited to a 31-bit IPA space.
>

-aneesh
