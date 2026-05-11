Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34ACA36E46E;
	Mon, 11 May 2026 11:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778498327; cv=none; b=klCMayiJ0pqTa/yff6tNfM268qJa5ZvPjGap6EcXcYxha5IHryJg7rz2LtrS0C6tsCO4/IOC3p4rlxQvDb9wfmTet+jiCngd7pm8/jooMKnh5HlhNpFfnVmyi3wtyKRMoRqagSsQ97shWBrH9EoFj717SJNk1+RxBwlNKbI14/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778498327; c=relaxed/simple;
	bh=4SJQe9/0G4pdLMhT5c/jy6OdJnu0csbyG2XiyP+BPII=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LKtTiSCVm07MoeMAMGk0ZIcmupCQ28U4m5mp1Wk/MVXSt7IBNNU6abpxOe2tUoRHSHvStMRO6y25k55KzqdQQolb2zmoG0U8/M82U1ly4jDGkO0iaOfZS2Ke18pvHc08BriMr4CTYtAwlFIDazU50vm0L7j5ivxr2r7GMyVOXGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=raFBujDZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="raFBujDZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A56C2BCB0;
	Mon, 11 May 2026 11:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778498326;
	bh=4SJQe9/0G4pdLMhT5c/jy6OdJnu0csbyG2XiyP+BPII=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=raFBujDZrev1ikLnmMjAb2LRXd7eEiCYq4YLaIGDjKpPfQR+pR02tqMumNfPpI2Ky
	 zheS/kWgloyB0YF3ZJ5yM5mnms8L2RFB1P2Rm/qaRtLn6Lk1vFQk+3PoiMQmW+2jkp
	 n0tvxbxH2ALtv5XcB2tjr5o1a5RL5ZJIdOZbkxCpysSUy6rN+XzS//pcDCwvdCwWmC
	 ZLF7A9zrLAp/eZjErHAWQg/WidvSbvboeCdRMK0/5B4eyqSLZuywqmSwhlPDByRonL
	 wlsEJM0eJsQ4llku4wlhICsX1xmuPNvcixnRGtofvna44mTZdeQAKHxM6u2tWqFP4H
	 x843i+arPK6FQ==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: Re: [PATCH v3 0/9] dma-mapping: Use DMA_ATTR_CC_SHARED through
 direct, pool and swiotlb paths
In-Reply-To: <af4dK-0HEsKdPAvM@arm.com>
References: <20260427055509.898190-1-aneesh.kumar@kernel.org>
 <af4dK-0HEsKdPAvM@arm.com>
Date: Mon, 11 May 2026 16:48:37 +0530
Message-ID: <yq5acxz2tcs2.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Catalin Marinas <catalin.marinas@arm.com> writes:

> On Mon, Apr 27, 2026 at 11:25:00AM +0530, Aneesh Kumar K.V (Arm) wrote:
>> This series propagates DMA_ATTR_CC_SHARED through the dma-direct,
>> dma-pool, and swiotlb paths so that encrypted and decrypted DMA buffers
>> are handled consistently.
>
> I think this series makes sense, using DMA_ATTR_CC_SHARED throughout the
> DMA API, either for alloc or for streaming to decide/check what bouncing
> does. Sashiko has a few interesting reports, it probably breaks s390 as
> well (it might be similar to the pKVM case).
>

I will address Shahiko=E2=80=99s review comments in the next revision.

With respect to s390/powerpc, I can drop SWIOTLB_FORCE from this series.
However, I was not sure whether we would get enough testing for that
soon. Both architectures are similar to x86/arm in forcing dma
unencrypted.

powerpc:
static inline bool force_dma_unencrypted(struct device *dev)
{
	return is_secure_guest();
}

s390:
/* are we a protected virtualization guest? */
bool force_dma_unencrypted(struct device *dev)
{
	return is_prot_virt_guest();
}


>
> I don't think it addresses earlier Mostafa's issues with pKVM, although
> I'd rather base additional pKVM related fixes on top of this series.
> With pKVM, cc_platform_has(CC_ATTR_MEM_ENCRYPT) returns false, as does
> force_dma_unencrypted(). I think we should update protected guests to
> return true for these if they need shared buffers (the whole
> decrypted/shared terminology is messy but in most places it just means
> buffer not private to the protected guest, whether encryption is
> available or not).
>
> That said, does CC_ATTR_GUEST_MEM_ENCRYPT actually make more sense than
> CC_ATTR_MEM_ENCRYPT throughout this series? We'd need to change arm64
> realms as well to use this one.
>

x86 memory encryption can use swiotlb boucing even on the host right?

+       if (cc_platform_has(CC_ATTR_MEM_ENCRYPT)) {
+               io_tlb_default_mem.decrypted =3D true;
+               set_memory_decrypted((unsigned long)mem->vaddr, bytes >> PA=
GE_SHIFT);
+       } else {
+               io_tlb_default_mem.decrypted =3D false;
+       }
+


-aneesh
