Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9715F3EDE78;
	Tue,  9 Jun 2026 08:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780993832; cv=none; b=YhCJmscedpmGwyFWxX6LFsXxAoudjqN4UxsrF09gP6ktgpuDF669SCMptmgx7gglwM0tOnV9pnWYyGgF6KzMWoLLRGb6H8RdmCegmC6E1StrljQdtypV9o7CI9ztVTyFsnzxUHo21ZazngzETz2/KCnbk0fIvLwRPxQGWrI96Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780993832; c=relaxed/simple;
	bh=fV/mSUSMN+IR3hfQCKA+oyVYGTrTlFzqieFQ4/zy5ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VJ7EcSNzgApoKJA5dsTCuQc43RbMQJlyFf0LyuIATiyy5acfUJ7sNi1bLZFS/cPg8YIsu86QNZwYvaP70CDOHlbQlcqwbgcVBdmMFMsbr8aR60uudNsF+w6IqtVFa8YWSoZcYiUrWfiiPonus/y5GOphwDCisijTgcX+iCCxkAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SuiDaMZa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SuiDaMZa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6863C1F00893;
	Tue,  9 Jun 2026 08:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780993831;
	bh=vAPy2awkQcYnVSy1fnfZF/v+f5XqDfdm+3r4Ry3/eo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SuiDaMZaogYBR8IVKecr1WRDmd0oh7gOCSew3JZXv71uXuTavPzO4IU4gRbQsSmNn
	 qQetzE7dOzFT3erHs1SLTkF04XuKJ2TW2CPaleBL6Uv2QcFZ9Mbf1vDelfu3FMIqn+
	 Qy2S5RqNGtNCgJi58UkuQZlRHbe2qHkYtlm2c0lKlCsBycvw5fm93rh/+vxHqFE4pN
	 xgH49PxObrEDObWNR5RF09uykuJ/vue7yrvMkrNUm+W4AmxAuTtKtp+TfiFLfRUhsj
	 gZKRud0Z8HoYdKIeKhfjJopcMyxn1H5iuKfsDpSOQCPF4s9UZYHq0qspNc/CDnCM1k
	 UbI7Eul1/SgPw==
Date: Tue, 9 Jun 2026 10:30:27 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Nabige Aala <nabige.aala@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, 
	Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
	Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Krishna Manikandan <quic_mkrishn@quicinc.com>, 
	Loic Poulain <loic.poulain@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/2] dt-bindings: display: msm: qcm2290: Add Shikra
 MDSS
Message-ID: <20260609-nimble-beige-swift-eb1846@quoll>
References: <20260608-shikra-display-v4-0-88a846afdd5d@oss.qualcomm.com>
 <20260608-shikra-display-v4-1-88a846afdd5d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260608-shikra-display-v4-1-88a846afdd5d@oss.qualcomm.com>

On Mon, Jun 08, 2026 at 12:31:42PM +0530, Nabige Aala wrote:
> Shikra reuses the same MDSS/DPU 6.5 hardware as QCM2290. Extend
> the existing qcm2290 bindings to cover Shikra by adding fallback
> compatible chains for MDSS, DPU and DSI controller nodes rather
> than introducing a separate binding file.
> 
> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

