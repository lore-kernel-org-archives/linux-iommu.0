Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3303517B433;
	Mon,  2 Dec 2024 15:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733154679; cv=none; b=q2iSPpMUvKCsUTEuTISQsNvYYflKogshRZ/3S7MHDgG0mP9rhVjQR+IJisoCfTum9fuCVTu6yZ0xb9PO7cBcq2emBKE53xRNtvcCsjNP7id2O1Gxz9tlhJ4CZ64j3zN3EpeRwT6CFPmV5f65gj5RKLZg5dB+1EZyIhheRTM6WBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733154679; c=relaxed/simple;
	bh=A9rnm/NTuh/5/erDKeO3kviyPDL09VXlpDFb2ytrlMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qd4rHSs1fyu7eJwX5ZbRENJQjkcKCAOC5piWN7Dw5rlmSL5vXJuY8d+OsRMwhDaQJmHsrdr9slI1l4RsMbqeyJ06WLk2zY/RDoIpW6duq5h1ciC0+qdpi8uYsDSSndU69HVx16YqmnCU19yOommdQQ2bIn8HEErP+jtGkJo36tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KyNMeVfK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KyNMeVfK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABDA9C4CED1;
	Mon,  2 Dec 2024 15:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733154678;
	bh=A9rnm/NTuh/5/erDKeO3kviyPDL09VXlpDFb2ytrlMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KyNMeVfKVc0H5vkEt3MNNfuBV+K5CeZqbVWG2qDhf7H/wMf8v7tFDbMbl+PSh9AtL
	 iO7yhBHXglU9vflqNIAegUb0b9+bkOOjoh5Xdx9ALBsXZpYefFM84uUepGiadiJ0PH
	 9qXy4/onV+2kwtd/4TsxaaTSZZUtdCt1SGqmtMCpuFBHscWcdf8FYASB5yn+eR1oRo
	 fdRao9tnXwTuo3RXO54tWkKdfWNM8q8SWOZ3Qw9sdkGw9bARnfQZ1aBrfbrhAktbzS
	 tz71n2f5fo0zxkSMe1fSkO8zb4pv88wBpXiw37xqpQqYiDYdKkvC7jKqc1BvUtHC1X
	 4oTLJdCfy+83Q==
From: Bjorn Andersson <andersson@kernel.org>
To: konradybcio@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	robimarko@gmail.com,
	will@kernel.org,
	robin.murphy@arm.com,
	joro@8bytes.org,
	Qingqing Zhou <quic_qqzhou@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: (subset) [PATCH v4 0/3] Add support for APPS SMMU on QCS615
Date: Mon,  2 Dec 2024 09:51:04 -0600
Message-ID: <173315466530.263019.10143861935675163068.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241105032107.9552-1-quic_qqzhou@quicinc.com>
References: <20241105032107.9552-1-quic_qqzhou@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 05 Nov 2024 08:51:04 +0530, Qingqing Zhou wrote:
> Enable APPS SMMU function on QCS615 platform. APPS SMMU is required
> for address translation in devices including Ethernet/UFS/USB and
> so on.
> 
> Add the SCM node for SMMU probing normally. SMMU driver probe will
> check qcom_scm ready or not, without SCM node, SMMU driver probe will
> defer.
> The dmesg log without SCM node:
> platform 15000000.iommu: deferred probe pending: arm-smmu: qcom_scm not ready
> 
> [...]

Applied, thanks!

[2/3] arm64: dts: qcom: qcs615: add the SCM node
      commit: 8c7f9d73de1bdb72d114aab053c8f7e3e9b32176
[3/3] arm64: dts: qcom: qcs615: add the APPS SMMU node
      commit: 58241be90050e53b7148a43dafa94c999867cbb7

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
