Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32D51B969;
	Tue, 28 May 2024 03:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716867183; cv=none; b=JMg/7zxHFIKj+30LcGwQINv3sVNEejz3PxaQfZJQsfa85kHsBTRIG10q3tCgp6IphlPybgHivZcrONR6HNzuMMcU1c5WtRNb4hLQsOA4WriXJCZ4NzpKILSRF3lBQJ01MlekaCs48pjczsDbjmzQfmj2JeIbP5ZnKB4Me4FI7CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716867183; c=relaxed/simple;
	bh=pQ5kqq5Khr38bUh82CqcyAYaKhfyiCZiDnWlNVGwWGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HPmV1cxHGsS4xYr8FWftpdKB/Ju8EAeSDl8zGZUdXviIfqDCbM9ihUQ047fPKOCrDWwvuJSwZjm/yZBAFKla2Rkkupfh/uS9omt0c4mN3/BNuhvI5e9WNZ0kfhBGqOTsURQxezKFzJaUY9OLhJ0ukK7Yy7XFEXuprOYI6fVqvh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFHYyIsQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFHYyIsQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85977C4AF0B;
	Tue, 28 May 2024 03:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716867183;
	bh=pQ5kqq5Khr38bUh82CqcyAYaKhfyiCZiDnWlNVGwWGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nFHYyIsQSpHGzLwGhGjrUVAGHsRq1Lzw7fq/fTGDzQbjG8KjT6ZRyFjBk0sdf9+LU
	 GfTPkzqiBaCp1BD3AGYy2uph13ewRM05yZBrW+Fd3hnTXcMP7lNTlBxk9GY+YcTYpr
	 36L4VF9FJWssPo9vyx2+jcjrLTw//ui8ys6xpwmhlrZ00/BruKp4MfdVgkAf2oj4zz
	 iQF4vHe2sD8ynnE9UFFvx6sXNOIFmzt+sP+QPlBwFoHvlSMQwMFYpbqgtg79dv1WbI
	 zalOoAKWnghxSp0wb10P3zJssbjuhc/UuISD6z1Wql/7w7Z3Wdl4M4tlMjHMCdGSnq
	 vi47Lb3P35JSg==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: (subset) [PATCH 0/3] arm64: qcom: sdm450: add initial support for Lenovo Smart Tab M10
Date: Mon, 27 May 2024 22:32:24 -0500
Message-ID: <171686715145.523693.1150554836658138912.b4-ty@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240523-topic-sdm450-upstream-tbx605f-v1-0-e52b89133226@linaro.org>
References: <20240523-topic-sdm450-upstream-tbx605f-v1-0-e52b89133226@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 23 May 2024 09:59:32 +0200, Neil Armstrong wrote:
> Add initial support for the WiFi version of the Lenovo Smart Tab M10,
> model TB-X605F with:
> - SDM450 SoC
> - Up to 3GiB of DDR
> - 10.1" LCD Touch Panel
> - eMMC
> - Bluetooth & WiFi
> - SDcard Slot
> - Camera (unsupported)
> 
> [...]

Applied, thanks!

[3/3] arm64: dts: qcom: sdm450: add Lenovo Smart Tab M10 DTS
      commit: 7ddab80e115086c0f2f37fa5a95466d0885d66d2

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
