Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9C54307B8;
	Wed,  8 Jul 2026 14:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783522671; cv=none; b=hglZNiY9zr3o0Chaw3+gVSUgR+EaJgXSDVrfbslHcDG06wtfn162IjxVZ7hzgZm9mg+Epj4Ov4/OZej8hPf6Nnp+mhPvOUYtdtdfzQ3s9VzK6JmyIO15cGK4EhEacZgFithQsyU5tC5MOBKkwZrY74oyZ6xd6hetN2ABFFg25nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783522671; c=relaxed/simple;
	bh=1dcoxn1lXpSxYHzEYS9CoCmo0mQcoW25U7jrhXCDhP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ip7I/gjMBzfQFhG/h9RS+hm38DnxjDAG24W15NiN0py84T0DWIg+0eCbrH4Nes1h7WRMx4JEp/DOotfQ5h1eeAxOBTbNPgoPLiZyKzEkdb53W7+IKTlWLNXdx7YrrXd7aiTeFMHqn32GBaRL99eBtN8ct9H8vfzaI7+JP2nv7Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3BIonws; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3BIonws"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B9E41F00A3E;
	Wed,  8 Jul 2026 14:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783522670;
	bh=0nyjPP7mSe9HiaUk/UAjsc7FDqovQ36jWq3u/Ghh3NU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b3BIonws6GBU1JlnYzyiZS/8iEvoaxqney15cIDK3RkmmOj4j5bZdMGC5paED25nz
	 /2Ri3AWkQsGJecEMUFNXlXujo1tV7DxJ6Lf055izNHe0fPZpLBtfEdpSq3HJjk083p
	 dLkrSU+Qs97qjXu5qZNTw0h7FALgy9HRdiVUxVajCLB4rbCZJaGvhJhdyxIIWnIFGm
	 App7+l94x6euzXqdRhoZWPaeW6oMqG/g7lGZBrTKbYtXXr8TctkFQ6JB6awqWIltuR
	 qd6SGRDYqnxZFD34DyZPLez2qqn0EruDnyEZv5D48zYudajBfv4Gr5jbr1/PtS9UMl
	 sohNRmBnfPm8g==
From: Bjorn Andersson <andersson@kernel.org>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Jessica Zhang <jesszhan0024@gmail.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krishna Manikandan <quic_mkrishn@quicinc.com>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Nabige Aala <nabige.aala@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v4 0/2] Add Shikra (QCM2390) display support
Date: Wed,  8 Jul 2026 09:56:50 -0500
Message-ID: <178352261601.2235436.270088747516489288.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608-shikra-display-v4-0-88a846afdd5d@oss.qualcomm.com>
References: <20260608-shikra-display-v4-0-88a846afdd5d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 08 Jun 2026 12:31:41 +0530, Nabige Aala wrote:
> Shikra (QCM2390) is a Qualcomm SoC based on the QCM2290 family that
> reuses the same MDSS/DPU 6.5 hardware as QCM2290. This series enables
> the display subsystem for Shikra by adding DT binding updates for MDSS,
> DSI controller and DPU and UBWC configuration mapping Shikra to
> qcm2290_data.
> 
> Driver and SMMU support are covered by the existing qcom,qcm2290-mdss
> fallback compatible string — no separate drm/msm or IOMMU patches are
> required.
> 
> [...]

Applied, thanks!

[2/2] soc: qcom: ubwc: Add Shikra UBWC config
      commit: a45af9d6e6175473c8744c0f1cf2348f641e3029

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
