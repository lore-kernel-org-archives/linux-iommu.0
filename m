Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87A028E7
	for <iommu@lists.linux.dev>; Tue,  6 Dec 2022 09:56:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B61C433C1;
	Tue,  6 Dec 2022 09:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1670320609;
	bh=H4M/+p7AkJ/i6ORamRR1po4sDDc3p/wTeEVuAunv+9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ja6ECJdGE0y7qkbILuEeOYDwyaeyhKoITYR4QfZwUlHu2ON/5zDL8k0QgGa06UiXK
	 IjIFFgene1o3lkGrmu+ONTuSNB5V/FNRP3ujN2RI8AVDM91aVSnoFP0rhnIBZG3G3G
	 SOlOTjp/G5FwIShX9WSSjZikSAAHgL9VOuQLzb+VU3HOFWJlkLSkZ80qeI4p4c+G+w
	 zajPUQTlekWnMRwZ35kLKm+DMKfl/7ElvavxqktpdjzZ7ohuX199wlmYHmE9o7R63h
	 HMVZYjHACzD9nxLr8NAMI/0vN5SSVV303THnGrbDcI4RIYnxfoCI7cSB+1dbUJFeYN
	 HPFWN/VzHQKPg==
Date: Tue, 6 Dec 2022 09:56:43 +0000
From: Will Deacon <will@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, linux-arm-msm@vger.kernel.org,
	agross@kernel.org, krzysztof.kozlowski@linaro.org,
	patches@linaro.org, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/9] dt-bindings: arm-smmu: Allow 3 power domains on
 SM6375 MMU500
Message-ID: <20221206095642.GA317@willie-the-truck>
References: <20221115152727.9736-1-konrad.dybcio@linaro.org>
 <20221115152727.9736-2-konrad.dybcio@linaro.org>
 <20221118133855.GB4046@willie-the-truck>
 <20221205205640.kawreo3yyeh2meci@builder.lan>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205205640.kawreo3yyeh2meci@builder.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Bjorn,

On Mon, Dec 05, 2022 at 02:56:40PM -0600, Bjorn Andersson wrote:
> On Fri, Nov 18, 2022 at 01:38:56PM +0000, Will Deacon wrote:
> > On Tue, Nov 15, 2022 at 04:27:19PM +0100, Konrad Dybcio wrote:
> > > The SMMU on SM6375 requires 3 power domains to be active. Add an
> > > appropriate description of that.
> > > 
> > > Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > > ---
> > >  .../devicetree/bindings/iommu/arm,smmu.yaml   | 23 ++++++++++++++++++-
> > >  1 file changed, 22 insertions(+), 1 deletion(-)
> > 
> > Acked-by: Will Deacon <will@kernel.org>
> > 
> > Let me know if you'd like me to take this one via the Arm SMMU tree.
> > 
> 
> Yes, please pick this through the SMMU tree.

I've already sent my pull request for 6.2, so this will have to wait until
6.3 now (unless somebody else takes it in the meantime).

Will
