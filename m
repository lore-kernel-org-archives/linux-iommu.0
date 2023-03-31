Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254C01FB1;
	Fri, 31 Mar 2023 08:02:48 +0000 (UTC)
Received: from 8bytes.org (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 9A614244F13;
	Fri, 31 Mar 2023 10:02:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1680249762;
	bh=HhNt/vf0jJLpApM2a8CXLarqNpXt1SlWBho4pzL7iyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=56hwbbzU761AwpD69MbRihRBiQQoeH3NTg9qiGBW/D1DgCtMhCKCMziSN01J6Fl23
	 9b/Y/GwSZua/dgn1MSocXyeo1/UcKyQXn5j4RP9Qm0j+OfOxsoozYaKimJUZkIEcQM
	 +itRz2SSFAKa6ogBGBHGgoFjSu4bU72jbWccFF5ripuFT7iy4Uqc0fuHd7DqXPSy7x
	 JIa4qAuvo2+TkcWE118aA8aflUW5dL2BYZfy0qNo0AnLAjjKB4WgnUHxiGtcL5dSMz
	 472kWknwpAKwJ/JTnvJkTfJwXlLOb6oPujqeJ5F4cWmgmHb655GjNVqk/rPJOliKgD
	 ZRe0kVywMiYIA==
Date: Fri, 31 Mar 2023 10:02:40 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Will Deacon <will@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
	Jon Nettleton <jon@solid-run.com>, Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>, Jason Gunthorpe <jgg@ziepe.ca>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Nicolin Chen <nicolinc@nvidia.com>, Rob Clark <robdclark@gmail.com>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Yong Wu <yong.wu@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	kernel@pengutronix.de, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	asahi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 00/10] iommu: Convert to platform remove callback
 returning void
Message-ID: <ZCaToJfq6CSsgpB+@8bytes.org>
References: <20230321084125.337021-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230321084125.337021-1-u.kleine-koenig@pengutronix.de>

On Tue, Mar 21, 2023 at 09:41:15AM +0100, Uwe Kleine-König wrote:
> Uwe Kleine-König (10):
>   iommu/arm-smmu: Drop if with an always false condition
>   iommu/apple-dart: Convert to platform remove callback returning void
>   iommu/arm-smmu-v3: Convert to platform remove callback returning void
>   iommu/arm-smmu: Convert to platform remove callback returning void
>   iommu/ipmmu-vmsa: Convert to platform remove callback returning void
>   iommu/msm: Convert to platform remove callback returning void
>   iommu/mtk: Convert to platform remove callback returning void
>   iommu/mtk_iommu_v1: Convert to platform remove callback returning void
>   iommu/omap: Convert to platform remove callback returning void
>   iommu/sprd: Convert to platform remove callback returning void

Applied, thanks.
