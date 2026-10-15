Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DD151815C;
	Thu, 15 Oct 2026 10:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792061470; cv=none; b=B5zszry0LmS8P+VaCemfxQY3BxHqk9pn0manMezSZUyUG/xeqQ8h4FARJWD972qxjAApy24fennHYFNYCbLzYer74qpnAFASuA3Y0L4p5/n9qEK3l61FhLq4zXO2/ModzAW5eXPpzp5RF+m4WN1HqrwTDGeiPx460r1SsNXMARU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792061470; c=relaxed/simple;
	bh=iATAZQNpwLiLA6uzvSr9O8Gp6IjloaF2SO3MNPYTggQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rWByeMWCWmiNNBlwMyndyPa/5TQJUoM9QGQeB4w3G1aqaWBRcPEXDO/V8dh2rEDpvpupGMOdc8p6cSyZc7Q8RryN1DKm8h/z7fClUOd73eXxJzTHKrn/6/iGWCtm/wxBvTsohmRyCzjXxV8jxQAzk5NHWyJ7Idw/TBwXwDIfoTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eI00sS55; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eI00sS55"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47A061F000C4;
	Thu, 15 Oct 2026 10:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792061465;
	bh=bFFn0cRn6AsMOpftXDuldzKxv+UaZPVlY/652IOEEvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eI00sS55Iy3s9dl4hDFDl3vJAJSGRnw1ZcAx7y1Ox7wH6ID+qeZkJc7dXm9qlM+Bt
	 ZqIHQxJlHxS0aggNGh3Y1yINK2NpmPHTiZuCLHVn2iiIEjguDBRLdjtJv93FDUX+JB
	 OO85Nula9BWRO+ArMXHaE6CdaBQhuh86CSUMahrEoO6bmFLd6Q6ChJTmAO6AdCpJ61
	 yrrD5zzOxE3+brjgCPXRJe0G1VvoCPuC1hGPs+VCvu0nDwMakBRtYLXQ8m2zlPzBPF
	 R/Lbh76mSki0DMATkeeyUxSsQkrivw/BRdWQDnDVijBaKXbbsQJzc/tacZw2ApyYqR
	 It0q9fLzbF18g==
Date: Thu, 15 Oct 2026 12:50:59 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, 
	Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
	Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
	Philipp Stanner <phasta@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev
Subject: Re: [PATCH 01/13] dt-bindings: display: msm: Add Qualcomm DCP
 bindings
Message-ID: <20261015-heavy-clam-of-sunshine-8fe831@quoll>
References: <20261015-jshekhar-drm-msm-dcp-v1-v1-0-48aad0fe4f72@oss.qualcomm.com>
 <20261015-jshekhar-drm-msm-dcp-v1-v1-1-48aad0fe4f72@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261015-jshekhar-drm-msm-dcp-v1-v1-1-48aad0fe4f72@oss.qualcomm.com>

On Thu, Oct 15, 2026 at 01:08:21PM +0530, Jayant Shekhar wrote:
> DCP platforms place the display pipeline under firmware control, so Linux
> cannot discover display resources through direct register access. The DRM
> driver therefore needs device-tree descriptions of the firmware transport,
> display topology, IOMMU contexts, and panel connections.

Due to dependencies this cannot be tested, so limited review.

A nit, subject: drop second/last, redundant "bindings". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v7.1-rc7/source/Documentation/devicetree/bindings/submitting-patches.rst#L23

> 
> Add bindings for the Qualcomm DCP VirtIO display function, including the
> INTF graph and DSI host outputs. Document the framebuffer IOMMU context,
> IPCC power-notify mailbox and interrupts, firmware display topology, and
> firmware-visible IOVA window supplied by the parent VirtIO-MMIO transport.
> 
> Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
> Assisted-by: LLM
> ---
>  .../bindings/display/msm/qcom,dcp-dsi.yaml         |  75 +++++++++++++
>  .../bindings/display/msm/qcom,dcp-virtio.yaml      | 113 +++++++++++++++++++
>  .../devicetree/bindings/display/msm/qcom,dcp.yaml  | 119 +++++++++++++++++++++
>  3 files changed, 307 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,dcp-dsi.yaml b/Documentation/devicetree/bindings/display/msm/qcom,dcp-dsi.yaml
> new file mode 100644
> index 000000000000..f7178c66c09e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,dcp-dsi.yaml
> @@ -0,0 +1,75 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/msm/qcom,dcp-dsi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm DCP DSI host
> +
> +maintainers:
> +  - Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
> +
> +description: |
> +  A MIPI DSI host exposed by the Qualcomm DCP VirtIO device (see
> +  qcom,dcp.yaml). DCP is a firmware protocol shared across multiple
> +  Qualcomm SoCs, not specific to any one of them; Hawi is its first
> +  platform. The DSI host and its connection to a panel are described
> +  using the standard DSI controller and OF graph properties.
> +
> +allOf:
> +  - $ref: /schemas/display/dsi-controller.yaml#
> +
> +properties:
> +  reg:
> +    maxItems: 1
> +    description: Index of this DSI host among its siblings.
> +
> +  status: true

I see slop, I finished here. Mind this maintainers summit words - if you
use AI, you must use good one, not the shloppy slop.

Best regards,
Krzysztof

