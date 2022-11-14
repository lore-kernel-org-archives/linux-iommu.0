Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878564C78
	for <iommu@lists.linux.dev>; Mon, 14 Nov 2022 14:23:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B84CC43470;
	Mon, 14 Nov 2022 14:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1668435814;
	bh=9E255QG+3FQ8gHO/W6Krz66A4Vs6SmwNv5u1uPI2t3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=japqIyjyyhj7IK10C+Wcni5A0JAKXPbZnQvXNcTtsDTr1J+r+mzPXrkTv/XAbO0wN
	 sLoaHRvi/44QaD6WMUXHQg0OY7Lk97o8GZOhq/BXi98vof6YBpOl1/RqMxv456NvqO
	 zk7GiIz/6Tone8q8Yc3bbJ/47mIkAEIjX7nRfhauF+TWf38iqmkXly8zC8m88oh/3x
	 Ksxn8119brgKtT2bC1VBIlTr41y8eO/aODIyl/W1Wqorb7TRL/pEMfmdIs2YgVL+/E
	 Go/md/MDpP9T9nD9ZUCm90Bgn1TO2rppcmT5HVi8Jext3ow6gWObzlo/zwLN6/0qsx
	 CWUhGLJABRgng==
Date: Mon, 14 Nov 2022 14:23:27 +0000
From: Will Deacon <will@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Rob Clark <robdclark@gmail.com>, Vinod Koul <vkoul@kernel.org>,
	Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	iommu@lists.linux.dev, devicetree@vger.kernel.org,
	freedreno@lists.freedesktop.org
Subject: Re: [RFC PATCH v2 00/11] iommu/arm-smmu-qcom: Rework Qualcomm SMMU
 bindings and implementation
Message-ID: <20221114142326.GH30263@willie-the-truck>
References: <20221102184420.534094-1-dmitry.baryshkov@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102184420.534094-1-dmitry.baryshkov@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Nov 02, 2022 at 09:44:09PM +0300, Dmitry Baryshkov wrote:
> The main goal of this patchset is to define a generic qcom,smmu-500
> binding to be used by newer Qualcomm platforms instead of defining each
> and every SoC line with no actual differences between the compats.

Thanks for doing this, I really like the cleanup and the possibility
that we can stop adding all these pointless strings every release!

It looks like Bjorn picked up patch 1, so could you please rebase the
rest of the series onto my SMMU bindings queue:

https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=for-joerg/arm-smmu/bindings

and address the minor review comments you had so that I can pick this up?

Cheers,

Will
