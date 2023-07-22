Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BCA10E4
	for <iommu@lists.linux.dev>; Sat, 22 Jul 2023 05:14:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 624E7C433C8;
	Sat, 22 Jul 2023 05:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690002849;
	bh=l2etnZvJ9/hffs2X1dtEQe8kxdMzW6IwoomkjJCKvgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oRwMosP0cDm7zISdBQOn5gTODekBtT5qZz2mJEqGhRgUtMP6QjQQLpvyZYye9a8qw
	 JqpqPxO1QQ4A8REvqUaAFGBaPV5ae1A6m3KQWMWzrLHW4C3JPG6Woyijf5mbIRLuPs
	 DE77/Fp+akBc3kwP+1RHcDuTd1ovzKN4ikiOASfi6gXjdOn419XPdmMdHHompNMSQc
	 DyZ0StHl3a2SR5l4ZAK6ysqAo7GmX9lyd9VlS+K9GFCVLCcIbBETS5VFnbEn7AEezf
	 o4pB76MUH2ElP7ehWRMTYocFo3TxU54F26V1bZIcVPOHua6ipyWD6RwQG5rX9IV3e5
	 KoI3e2DF+X1uA==
From: Bjorn Andersson <andersson@kernel.org>
To: cros-qcom-dts-watchers@chromium.org,
	Andy Gross <agross@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Benjamin Li <benl@squareup.com>,
	James Willcox <jwillcox@squareup.com>,
	Joseph Gates <jgates@squareup.com>,
	Stephan Gerhold <stephan@gerhold.net>,
	Zac Crosby <zac@squareup.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Xu Yang <xu.yang_2@nxp.com>,
	Peng Fan <peng.fan@nxp.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	Jun Nie <jun.nie@linaro.org>,
	Max Chen <mchen@squareup.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	Vivek Gautam <vivek.gautam@codeaurora.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vincent Knecht <vincent.knecht@mailoo.org>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	alsa-devel@alsa-project.org,
	iommu@lists.linux.dev,
	linux-usb@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Leo Yan <leo.yan@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Andy Gross <andy.gross@linaro.org>
Subject: Re: (subset) [PATCH 00/11] Even more msm bindings fixes
Date: Fri, 21 Jul 2023 22:17:08 -0700
Message-ID: <169000304212.3611206.847521612980089108.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230627-topic-more_bindings-v1-0-6b4b6cd081e5@linaro.org>
References: <20230627-topic-more_bindings-v1-0-6b4b6cd081e5@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 27 Jun 2023 18:24:16 +0200, Konrad Dybcio wrote:
> This series contains couple more random dt schema warning fixes, centered
> around linux-msm.
> 
> All of the patches (except) the last two are pretty much independent.
> Patch 1 is not only a bindings fix, but also a functional one.
> 
> 
> [...]

Applied, thanks!

[09/11] dt-bindings: arm: msm: kpss-acc: Make the optional reg truly optional
        commit: 981be238e1d28e156aa9da2a8722f86f02fd0453

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
