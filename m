Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EA77C
	for <iommu@lists.linux.dev>; Mon,  5 Dec 2022 20:56:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EB2CC433D6;
	Mon,  5 Dec 2022 20:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1670273803;
	bh=vk+UZ6tUq7mNy/roi7+hY87YUI/a6jLm+DDd/E/E9ig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nfpXJ0XLZ6VnzsONDET4qRF8KKe1UDuxi1Nh+q7Ae++1QZJiRrm0zOIgndJ5K8pNy
	 TL4JXQC8g0vGKe5fU3D/z0pAA3aTe57OFvds3PBNCnhcJaLldHonUGLDKefB4rFlhj
	 jihBMagbzyn3mdMOSYlxg5+Tgp2brE9ZWVgodaO2c5WoD+cbLuesyioEdkvWAcxF4N
	 jq1WVg5SqP5FK/24raToNWF52w0et/m79ZAaMaqg2wl8HS/RgPuMKbfh+W2bGub4Ch
	 Yb1+er4kRdChZrMRKdEjOWJ01tiCORUGQMG6iaN3+kr5c3A6WpP0AB34I/KJseAW7v
	 tEZEItD1jkfeA==
Date: Mon, 5 Dec 2022 14:56:40 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Will Deacon <will@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, linux-arm-msm@vger.kernel.org,
	agross@kernel.org, krzysztof.kozlowski@linaro.org,
	patches@linaro.org, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/9] dt-bindings: arm-smmu: Allow 3 power domains on
 SM6375 MMU500
Message-ID: <20221205205640.kawreo3yyeh2meci@builder.lan>
References: <20221115152727.9736-1-konrad.dybcio@linaro.org>
 <20221115152727.9736-2-konrad.dybcio@linaro.org>
 <20221118133855.GB4046@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118133855.GB4046@willie-the-truck>

On Fri, Nov 18, 2022 at 01:38:56PM +0000, Will Deacon wrote:
> On Tue, Nov 15, 2022 at 04:27:19PM +0100, Konrad Dybcio wrote:
> > The SMMU on SM6375 requires 3 power domains to be active. Add an
> > appropriate description of that.
> > 
> > Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > ---
> >  .../devicetree/bindings/iommu/arm,smmu.yaml   | 23 ++++++++++++++++++-
> >  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> Acked-by: Will Deacon <will@kernel.org>
> 
> Let me know if you'd like me to take this one via the Arm SMMU tree.
> 

Yes, please pick this through the SMMU tree.

Bjorn
