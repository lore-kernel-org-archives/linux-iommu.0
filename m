Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D311C8FBA;
	Wed, 10 Dec 2025 00:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765327379; cv=none; b=tnd501kwji9WL0WkMjW59c68u44u/WKL+HYqfcaDHnm+0ccHW8zfhMlNdY6l/9mWbNX5waHuM/cGljC3WH/LRS3jYXzUkBXiME8LZhNF1FvYk/sEIOSbdWxLuZxnEfUgxKnrQ4POcmAPaSukRSij0W8TbQa9WHPJoLJrw/tcBWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765327379; c=relaxed/simple;
	bh=xOgCRFP+4w6YG6S/mNVatZH0mEsx/CiZR0vSHkmK4ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kiR/2xZrnj/mqEtxIF0QFTeSaYk+geCUsbjZpzO8RG9hQ0MUVuafOEDSfD9ev1Fsv5g9cneHMbmjrLmFConBJ7j6BNNioOVLtR26sTfi+u8OZd0NlZ3h53obY7XUKZqJBn+RW+MJf67Mm16Im5T5YYYz9pCVmGgkdQEILzo1YoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ObvfvVfy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ObvfvVfy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E16E4C4CEF5;
	Wed, 10 Dec 2025 00:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765327378;
	bh=xOgCRFP+4w6YG6S/mNVatZH0mEsx/CiZR0vSHkmK4ow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ObvfvVfymT8TZ9aiwyV18VidBzybvNOlNWfWZdtQlEQcb4ETc7caTqzSRPzoojxtK
	 QL0VJCC3ncA8FwUOSsiyod3oPakTuWSyvc9Tbsk6nKEbKPntCO0HydfEWy4wYxU093
	 2ap/GM2bfMfaY+/1lWnOzEjo/i+lHfB4tEmxEYJpPDOutWHrzO3/6yIEXDYeQdYjjZ
	 n2G2LbkdQDCintGnBakeBn5e9av7i6d/jaDIxU4AgbUikSpB3myNVzPNIlCR1wNUxM
	 yEwSQ2G0pIGAeFY6xe870byBEkHwAIZBphL8+1uMmUWHRlu3FOxcuEOMlpwBSKvDS+
	 jox2BIMND2HPQ==
Date: Wed, 10 Dec 2025 09:42:54 +0900
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	joro@8bytes.org, Tomasz Nowicki <tnowicki@google.com>
Subject: Re: [PATCH] iommu/io-pgtable-arm: Add misisng concatenated PGD cases
Message-ID: <aTjCDvtANr2WIv3L@google.com>
References: <20251130194506.593700-1-smostafa@google.com>
 <18a39079-2285-47fb-b306-040f2bc1bbaa@arm.com>
 <aTgX9qhaLyrQ5iye@google.com>
 <498bbad4-ea64-4a24-a63f-e131d271990a@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <498bbad4-ea64-4a24-a63f-e131d271990a@arm.com>

On Tue, Dec 09, 2025 at 01:33:36PM +0000, Robin Murphy wrote:
> On 2025-12-09 12:37 pm, Mostafa Saleh wrote:
> > On Tue, Dec 09, 2025 at 11:34:34AM +0000, Robin Murphy wrote:
> > > On 2025-11-30 7:45 pm, Mostafa Saleh wrote:
> > > > arm_lpae_concat_mandatory() assumes that OAS >= IAS which is not
> > > > correct for SMMUs supporting AArch32, and have OAS = 32/36 bits,
> > > > as IAS would be 40 bits.
> > > 
> > > But that is only when *using* AArch32 format. The bit in chapter 3.4 of the
> > > SMMU architecture is talking about the maximum IAS that an SMMU
> > > implementation needs to be able to accommodate based on its configuration,
> > > but it does then attempt to clarify that the actual IPA size in use by any
> > > given context should depend on the VMSA format in use:
> > > 
> > > "VMSAv8-32 LPAE always supports an IPA size of 40 bits, whereas VMSAv8-64
> > > and VMSAv9-128 limits the maximum IPA size to the maximum PA size."
> > > 
> > > Rule R_SRKBC in the Arm ARM lays out the exact T0SZ constraints with this
> > > AArch32/AArch64 detail.
> > 
> > I see, thanks a lot for the explanation, I got confused by the this
> > statement:
> > Note: If AArch32 is implemented, IAS == MAX(40, OAS), otherwise IAS == OAS.
> 
> Indeed, that appears confusingly contradictory; I've filed a bug.

I think the spec has always been worded like this. My reading is that, in
isolation:

  - VMSAv8-32 LPAE always uses a 40-bit IAS
  - VMSAv8-64 has IAS == OAS and this can be smaller than 40 bits

so if AArch32 is implemented, we know that the hardware supports at
least a 40-bit IAS and in that case the VMSAv8-64 IAS can be bigger
than the OAS.

That seems consistent to me; where is the contradiction?

Will (jet-lagged so may well be talking rubbish!)
