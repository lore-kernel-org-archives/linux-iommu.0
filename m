Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F7D409278;
	Wed,  8 Jul 2026 15:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783524368; cv=none; b=rTMPgHrarOQdXy8uglHDL9YVKu9kMSYcAZ+p7AN9AcEDamiFqhLMBqfT+mKlQJEAGwA7WjBpLdK86be785tS//88IJLX6iGCbTH5aka2lBUriaHCBSoB54xwNOLYMrTRVD/R8/WCiesgjvLWFKTi4p2CnFt/Cgw+Q4d4NP4pQG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783524368; c=relaxed/simple;
	bh=whlFHqnb1XuOYu2Xd8sn/x0N9b/+58vwnkVIRaGYQjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uvIh6RO+hpmgBVCIWTDh9D9+gqqXh66+gYjz4bLV4II0bmbWx3vy9ktOMWkEoEL0kah7wdN+FlgV4f9QYnw1E81zyOX2wwTYZAUr+BeGkW0K2Oj1BpDDC6MuZUlfWsAwARNymLotJjNEQCRSW4jae4j+BrZ1x5DyhSUck+hLUV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDhSlbSN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDhSlbSN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB831F000E9;
	Wed,  8 Jul 2026 15:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783524367;
	bh=yVimvhatc65Owlde0V/MOtWQPfIwkXZ1GniY6IYK8AE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gDhSlbSNBaBZGjTVhSc1SE3KOE3xKeG78VYrDpRrru2etALr/MsRqmirN0OVpkj+B
	 r0jxEk5eOPYRfs7gNNz20QzeEpCMd3qJLCiHIMamEUhAshXSST0xAIm2ulX+kSvuJj
	 z0pGxmnsA4gtthbkijOWfdGOyC+iJO8S/0q2aKZl3OWK1PJ8DYq4vEFr8e2NbpLJvr
	 ZkkZ+/D38zBTHOQlRYJUk4bpYIca2QNQ0dzRlxjeV9/7SboZhKKnpC0G5dwS6+HvQh
	 9PEWb92P9Tdn1mR9Aww2bI7QTMZiDDDjohTYDQbNe8iddTLQLml1O5Z4Z6RdUKl2gJ
	 3qF+zxxgUhNVQ==
Date: Wed, 8 Jul 2026 10:26:03 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Clark <robin.clark@oss.qualcomm.com>, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 3/6] arm64: dts: qcom: kodiak: Add GEM_NOC
 interconnect for adreno SMMU
Message-ID: <ak5qkRKk2eHHLYmo@baldur>
References: <20260706-smmu_interconnect_addition-v3-0-afdca0125a65@oss.qualcomm.com>
 <20260706-smmu_interconnect_addition-v3-3-afdca0125a65@oss.qualcomm.com>
 <h6opbtr2ced3sannj3ym573qc2sjk7ek3clpto5j5mtqfrfk6w@34sk2zraoqtj>
 <807f145d-88d3-460a-9862-b63fe2a52cf7@oss.qualcomm.com>
 <a4f5sod3aflubxkk4mm4k5ozddydqcnqeac4s6vnozkd2nvxbi@hmh6zclsw5z3>
 <4e5a3d82-b946-4490-885a-ea7061939c32@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e5a3d82-b946-4490-885a-ea7061939c32@oss.qualcomm.com>

On Wed, Jul 08, 2026 at 03:31:07PM +0530, Bibek Kumar Patro wrote:
> 
> 
> On 7/7/2026 10:14 PM, Dmitry Baryshkov wrote:
> > On Tue, Jul 07, 2026 at 06:37:24PM +0530, Bibek Kumar Patro wrote:
> > > 
> > > 
> > > On 7/6/2026 11:12 PM, Dmitry Baryshkov wrote:
> > > > On Mon, Jul 06, 2026 at 10:26:36PM +0530, Bibek Kumar Patro wrote:
> > > > > On Kodiak platforms, the Adreno SMMU requires a bandwidth vote on
> > > > > the GEM_NOC path (MASTER_GPU_TCU -> SLAVE_EBI1) before its registers
> > > > > are accessible. Without this vote, the SMMU may become unreachable,
> > > > > leading to intermittent probe failures and runtime issues.
> > > > > 
> > > > > Add the required interconnect to ensure reliable register access.
> > > > > 
> > > > > Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
> > > > > ---
> > > > >    arch/arm64/boot/dts/qcom/kodiak.dtsi | 2 ++
> > > > >    1 file changed, 2 insertions(+)
> > > > > 
> > > > > diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
> > > > > index 90e50c245c0c..721526f023dd 100644
> > > > > --- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
> > > > > +++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
> > > > > @@ -3389,6 +3389,8 @@ adreno_smmu: iommu@3da0000 {
> > > > >    			power-domains = <&gpucc GPU_CC_CX_GDSC>;
> > > > >    			dma-coherent;
> > > > > +			interconnects = <&gem_noc MASTER_GPU_TCU QCOM_ICC_TAG_ALWAYS
> > > > > +					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
> > > > 
> > > > Why is it ALWAYS? Would it be better to declare it as ACTIVE_ONLY and
> > > 
> > > Added QCOM_ICC_TAG_ALWAYS, to hold the vote in SLEEP bucket as well
> > > preventing gem_noc going to sleep when icc_set_bw is being called.
> > 
> > _why_?
> > 
> 
> Now when i think of where we implemented the hooks, ALWAYS is not needed. We
> should keep it ACTIVE_ONLY since we are already voting it
> back in resume pah. I'll fix it in next revision.
> 

The path is between the SMMU and DDR, so clearly it has to do with the
TCU's ability to fetch things from DDR.

ACTIVE_ONLY states that the vote should only be applied when the
application subsystem (CPUSS) is not in low-power mode (CPU is active).

So, are you saying that in all cases that cpuidle might select such
low-power state the GPU TCU is "stopped", and does not need to perform
any memory transactions?


To me these two are orthogonal and TAG_ALWAYS is logically correct, but
perhaps there's some practical dependency that I'm missing?

Regards,
Bjorn

> > > 
> > > > then drop the extra suspend/resume play?
> > > 
> > > Not sure if I understood it correctly.
> > > Did you mean the extra suspend/resume play in arm_smmu_runtime_suspend
> > > or in arm_smmu_device_shutdown() path?
> > 
> > runtime_suspend/resume. I might be incorrect here, but I think it is
> > exactly what you need.
> > 
> 
> Yes, I think we should go with the ACTIVE_ONLY flag and we would need
> this voting in suspend resume path (For the same reason mentioned in commit
> description and cover letter of the series).
> 
> ALWAYS would avoid the need for this handling, it would keep the vote active
> unnecessarily, but still that would have been nondeterministic.
> 
> Thanks & regards,
> Bibek
> 
> > > 
> > > Thanks & regards,
> > > Bibek
> > > 
> > > > 
> > > > >    		};
> > > > >    		gfx_0_tbu: tbu@3dd9000 {
> > > > > 
> > > > > -- 
> > > > > 2.34.1
> > > > > 
> > > > 
> > > 
> > 
> 
