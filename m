Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19075346AC0;
	Wed, 21 Jan 2026 04:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768971061; cv=none; b=IkHOqb9ysXC1LPnoV8S2yvYOjWBPOW8vAx98O1CmkaLskwWWzmz3eFxvdIwb+eJYDdhHAAAb5xTsvPNI7hZAgDNu3NJjjs8QlOoq66JFgdRu/cFDU0bu0XtXsJhZ1v5KIOg7L4e9tUMNyqtY7+2S3YVotq65XJrCheqQpOtoae0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768971061; c=relaxed/simple;
	bh=F8Tc/zNV5Kph5qSSBVjvztstQbGY8i+UW4ESNWCwSQ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eHpbdd+KKh2wt+RfG7iyHG2Oo4yHnRosF0lxSJUIO7aP8etO8dy2PODAnjCQhIC+zKhnk6b1j34nSxL3JyR2nkxQTQTV3mXe0pVwpSExMq6B/ekcWiGbLPLQ4kSo9sBsJC6kV9M/15Eor0A6BNlkSivYVo62Prr4D7DLOslpIak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=erewZ10v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="erewZ10v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F07FEC116D0;
	Wed, 21 Jan 2026 04:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768971060;
	bh=F8Tc/zNV5Kph5qSSBVjvztstQbGY8i+UW4ESNWCwSQ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=erewZ10v7o9RK0gdYrvm0xOx4XfsHALdC13Iu5akdfQy7QK5hwf5K9KKQHj2xRVTL
	 0s1VxlouTLnp/sNF9Kdp3fJH6CXfMdoPTeKUsFH8S2kvUX3kua6HGiHELfO9ml2zg1
	 boJW9jFIPe8VQH4ILQBxxyPVEK5Q8esaBKBrMCrkzJa9erHKvmaevu0W/zTm/r2ToV
	 bc19cKO1uikBhBqJf/NWjJFODwELhe/DRwpOnLSNZWxK+Ga691Reufy+N5eo5wtj9J
	 0EdijE27as602Dm0V8baGICJ4pFg1bQJ1u91Tfq9WJ7aO05J4SApttywDa/Pe+DVe2
	 MU7m5h5s3rZpw==
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
In-Reply-To: <b662e137-5d2a-4ee7-b1f7-b4545388d4fe@arm.com>
References: <20260120064255.179425-1-aneesh.kumar@kernel.org>
 <2a0b6d1b-875a-4075-8fc9-a8534afc9168@arm.com>
 <893a6503-d33f-41d8-8966-19b9f251d9da@arm.com>
 <yq5aqzrkjr9e.fsf@kernel.org>
 <b662e137-5d2a-4ee7-b1f7-b4545388d4fe@arm.com>
Date: Wed, 21 Jan 2026 10:20:48 +0530
Message-ID: <yq5ajyxbk1qv.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Robin Murphy <robin.murphy@arm.com> writes:

> On 2026-01-20 2:25 pm, Aneesh Kumar K.V wrote:
>> Robin Murphy <robin.murphy@arm.com> writes:
>>=20
>>> On 2026-01-20 9:59 am, Suzuki K Poulose wrote:
>>>> On 20/01/2026 06:42, Aneesh Kumar K.V (Arm) wrote:
>>>>> On systems that apply an address encryption tag or mask to DMA addres=
ses,
>>>>> DMA mask validation must be performed against the canonical DMA addre=
ss.
>>>>> Using a non-canonical (e.g. encrypted or unencrypted) DMA address
>>>>> can incorrectly fail capability checks, since architecture-specific
>>>>> encryption bits are not part of the device=E2=80=99s actual DMA addre=
ssing
>>>>> capability. For example, arm64 adds PROT_NS_SHARED to unencrypted DMA
>>>>> addresses.
>>>>>
>>>>> Fix this by validating device DMA masks against __phys_to_dma(), ensu=
ring
>>>>> that the architecture encryption mask does not influence the check.
>>>>>
>>>>> Fixes: b66e2ee7b6c8 ("dma: Introduce generic dma_addr_*crypted helper=
s")
>>>>
>>>>
>>>>> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>>>>> ---
>>>>>  =C2=A0 kernel/dma/direct.c | 4 ++--
>>>>>  =C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
>>>>> index 8e04f72baaa3..a5639e9415f5 100644
>>>>> --- a/kernel/dma/direct.c
>>>>> +++ b/kernel/dma/direct.c
>>>>> @@ -580,12 +580,12 @@ int dma_direct_supported(struct device *dev, u64
>>>>> mask)
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * This check needs to be agains=
t the actual bit mask value, so use
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0 * phys_to_dma_unencrypted() here so that th=
e SME encryption mask
>>>>> isn't
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * __phys_to_dma() here so that the arch spe=
cific encryption mask
>>>>> isn't
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * part of the check.
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ENABLED(CONFIG_ZONE_DMA))
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 min_mask =3D =
min_t(u64, min_mask, zone_dma_limit);
>>>>> -=C2=A0=C2=A0=C2=A0 return mask >=3D phys_to_dma_unencrypted(dev, min=
_mask);
>>>>> +=C2=A0=C2=A0=C2=A0 return mask >=3D __phys_to_dma(dev, min_mask);
>>>>
>>>> This is wrong, isn't it ? For e.g., for CCA, even though the "Flag" is
>>>> added to the PA, it is really part of the actual "PA" and thus must be
>>>> checked against the full PA ?
>>>
>>> Yes, it's much the same as for AMD SEV (albeit the other way round) -
>>> the encryption/decryption bit is part of the DMA address because it
>>> needs to be driven by the device, so it is crucial that the device's DMA
>>> mask is capable of expressing that.
>>>
>>=20
>> Commit c92a54cfa0257e8ffd66b2a17d49e9c0bd4b769f explains these details.
>
> See x86's force_dma_unencrypted() implementation - the reason dma-direct=
=20
> doesn't need to be so strict for that is because things are the right=20
> way round that it can always fall back to shared/untrusted DMA as the=20
> general case, and a device can only access an encrypted page directly if=
=20
> it *can* drive the SME bit in the input address to trigger the inline=20
> encryption engine.
>
> For CCA we have rather the opposite, where dma-direct requires a device=20
> to be able to address any IPA directly to be sure of working at all, but=
=20
> if we do happen to have a stage 1 IOMMU then we could rely on that to=20
> map smaller IOVAs to the upper IPA space.
>
>> I was wondering whether the DMA-enable operation should live outside the
>> set_mask operation. Conceptually, set_mask should be derived purely from
>> max_pfn, while the DMA enablement path could additionally verify whether
>> the device requires access to an alias address, depending on whether it
>> is operating in trusted or untrusted mode?
>
> No, the point of the set_mask check is "is this mask big enough to=20
> accommodate any *DMA address* we might need to give the device?" - that=20
> includes offsets, magic bits, magic bits encoded as fake offsets (yes=20
> you, Raspberry Pi...) and whatever else might comprise an actual DMA=20
> address as handed off to the hardware. It is *not* directly a "can this=20
> device DMA to all RAM we know about?" check - that is in the assumption=20
> that if necessary the SWIOTLB buffer will be reachable at a <=3D32-bit DM=
A=20
> address, and thus we should not *need* to give >32-bit addresses to=20
> devices. It is only that assumption which fundamentally falls apart for=20
> CCA (with more than 2GB of IPA space, at least).
>

We need the below change then? commit 91ef26f914171cf753330f13724fd9142b5b1=
640
discuss some hardware that is broken with the usage of phys_to_dma conversi=
on.=20

modified   kernel/dma/direct.c
@@ -14,6 +14,7 @@
 #include <linux/set_memory.h>
 #include <linux/slab.h>
 #include <linux/pci-p2pdma.h>
+#include <linux/cc_platform.h>
 #include "direct.h"
=20
 /*
@@ -579,17 +580,23 @@ int dma_direct_mmap(struct device *dev, struct vm_are=
a_struct *vma,
=20
 int dma_direct_supported(struct device *dev, u64 mask)
 {
-	u64 min_mask =3D (max_pfn - 1) << PAGE_SHIFT;
+	u64 min_mask =3D DMA_BIT_MASK(32);
=20
 	/*
-	 * Because 32-bit DMA masks are so common we expect every architecture
-	 * to be able to satisfy them - either by not supporting more physical
-	 * memory, or by providing a ZONE_DMA32.  If neither is the case, the
-	 * architecture needs to use an IOMMU instead of the direct mapping.
+	 * Only do the conversion for CC platform, to be compatible
+	 * commit 91ef26f914171cf753330f13724fd9142b5b1640
 	 */
-	if (mask >=3D DMA_BIT_MASK(32))
+	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
+		min_mask =3D phys_to_dma_unencrypted(dev, min_mask);
+
+	/*
+	 * if we support ZONE_DMA32 and device mask can cover the DMA32 range,
+	 * then we can support direct dma for any max_pfn value using swiotlb.
+	 */
+	if (IS_ENABLED(CONFIG_ZONE_DMA32) && mask >=3D min_mask)
 		return 1;
=20
+	min_mask =3D (max_pfn - 1) << PAGE_SHIFT;
 	/*
 	 * This check needs to be against the actual bit mask value, so use
 	 * __phys_to_dma() here so that the arch specific encryption mask isn't


-aneesh
