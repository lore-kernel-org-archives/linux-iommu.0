Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202F65393
	for <iommu@lists.linux.dev>; Tue, 19 Jul 2022 19:57:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79776C341CE;
	Tue, 19 Jul 2022 19:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1658260631;
	bh=ttr13LeCzuWb0mQqZMCxUwMmOqVOMkpEHDBdwO513xY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tIIL85hj56Is7sR+SPakwhka9ukvoxiTzAWPskjP2Qa8yF8YZN+0zCaHUuNu9uehN
	 mwylr9+YuUhvL412WqlCUMP6DgdbxFALCLh++U1sU2BmW5VA2sYC5x7JtltaWfwPkf
	 37w/KdCKA5gau7xHNm0jXRNEDipWseFYG1KNjOseoplrAMBH033Ld9i8uhu2ZmrD/G
	 oGc6ZpNbHJkKudwdiGmGI/63UY4Txt65sBndbXozpSFMSZRknNyOdeFKj93pI+kNb0
	 GKeKBv01WK9mZbSC5szPlcCVPEVLi6z53bHeVSU3qWA2W3wFlo3Hk5oqmImvTWXzg1
	 4xwCzUGe6H/OA==
From: Will Deacon <will@kernel.org>
To: Konrad Dybcio <konrad.dybcio@somainline.org>,
	~postmarketos/upstreaming@lists.sr.ht
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	marijn.suijten@somainline.org,
	Joerg Roedel <joro@8bytes.org>,
	iommu@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	devicetree@vger.kernel.org,
	jamipkettunen@somainline.org,
	Rob Herring <robh+dt@kernel.org>,
	martin.botka@somainline.org,
	angelogioacchino.delregno@somainline.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: arm-smmu: Add compatible for Qualcomm SM6375
Date: Tue, 19 Jul 2022 20:56:53 +0100
Message-Id: <165825146901.2951100.17739649475708755118.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220716193223.455859-1-konrad.dybcio@somainline.org>
References: <20220716193223.455859-1-konrad.dybcio@somainline.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sat, 16 Jul 2022 21:32:22 +0200, Konrad Dybcio wrote:
> Add a compatible for Qualcomm SM6375's broken-as-usual MMU500 impl.
> 
> 

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/2] dt-bindings: arm-smmu: Add compatible for Qualcomm SM6375
      https://git.kernel.org/will/c/743302d4ad6c
[2/2] iommu/arm-smmu-qcom: Add SM6375 SMMU compatible
      https://git.kernel.org/will/c/ef660de424cf

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
