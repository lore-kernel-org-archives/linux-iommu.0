Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [5.144.164.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5E123AD
	for <iommu@lists.linux.dev>; Sun,  4 Jun 2023 18:33:56 +0000 (UTC)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 40D0C3EBD0;
	Sun,  4 Jun 2023 20:23:47 +0200 (CEST)
Date: Sun, 4 Jun 2023 20:23:45 +0200
From: Marijn Suijten <marijn.suijten@somainline.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Krishna Manikandan <quic_mkrishn@quicinc.com>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Subject: Re: [PATCH v5 08/12] drm/msm/dpu: Add SM6375 support
Message-ID: <lgxlvfsagaddlib3m2agcdltjwt55e244zguzdwgavwlgltivm@nmwaur4xj3zu>
References: <20230411-topic-straitlagoon_mdss-v5-0-998b4d2f7dd1@linaro.org>
 <20230411-topic-straitlagoon_mdss-v5-8-998b4d2f7dd1@linaro.org>
 <h56lpxfxujaia6jfgvbpu2dp3dqdilaormxr5plms44vev2qdf@qhkrsuhlarga>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <h56lpxfxujaia6jfgvbpu2dp3dqdilaormxr5plms44vev2qdf@qhkrsuhlarga>

On 2023-06-01 16:56:53, Marijn Suijten wrote:
<snip>
> > +static const struct dpu_intf_cfg sm6375_intf[] = {
> > +	INTF_BLK("intf_0", INTF_0, 0x00000, 0x280, INTF_NONE, 0, 0, 0, 0, 0),
> > +	INTF_BLK_DSI_TE("intf_1", INTF_1, 0x6a800, 0x2c0, INTF_DSI, 0, 24, INTF_SC7280_MASK,
> 
> Did you forget to set this back to SC7180?  This will be enabling
> DPU_INTF_DATA_COMPRESS otherwise, which is a DPU 7.x feature.

For completeness, once this fix is applied (either in a new revision or
when this patch is packed), this patch is also:

Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
