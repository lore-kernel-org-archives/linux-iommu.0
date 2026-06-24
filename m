Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch [109.224.244.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C703624C2
	for <iommu@lists.linux.dev>; Wed, 24 Jun 2026 13:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782307584; cv=none; b=WQKt3rQYA/JfwTcuTMgeul8gknNaQu+0Q4NYk7HeFuYjYZJN8L3w9R1z13cOLjNkRA58pSMP1V6aFcoIz0Bx72vKMQpwKbXUo9GPLMjd4UTZ+xjUmAqHlrNDxvhOk7/RBF/nbqyia5XjDozkc9wV3Sxa9r+LkKujtNEGPwlTxwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782307584; c=relaxed/simple;
	bh=wIb9R7eOTXQ3L9z9i9MDpz2gfdRkQpGrhD1+tSfI5os=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hUnzPAFPhHRg1X7JD6rebI7pH4zEEnY50QF69k1DSxLtFLDlkSYORS0yGRKsd/WTSaMidQUwIuo9pOi7cjfyHb5q98sQL5vKYhjC2GGBll7MdNLj0ezXTUKJlvH3Js8qrb1/xSkWiF9YJ9gfUR4ulkKHNS6VRqf3AdAqM5NKnGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=f2sejHT/; arc=none smtp.client-ip=109.224.244.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="f2sejHT/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1782307573; x=1782566773;
	bh=wIb9R7eOTXQ3L9z9i9MDpz2gfdRkQpGrhD1+tSfI5os=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=f2sejHT/WrS3zPqG/Iq9XEFBDxWynyuPFUJ25mgIiAxiwbD/aNM7z56IwOvNTa0nR
	 Y5g7F63y/jN6cgwYlftaw2XTy2sJhj/G17X7juo32bZ2b5lsFIEtb6pe0pgIuydBCA
	 89xsMu9F0phcow/MV64e2lbCs9A6j+oLpTmTS2sJjIesL41+Q1UshtSkA+6b+gCbFP
	 rwlV6PkYZm967+4L1H7Yuyz3RhO0RfESjr0HZPbSw42AuhPFg65LEKmjtSM8i/RbC4
	 YxM7sW1UEuR9SLsSn41NkWaQhm1uzFzZivQsFUKEbdMeeHrSR8y44skr1uq2awYt3S
	 yZC0lHiUXb/OQ==
Date: Wed, 24 Jun 2026 13:26:06 +0000
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>
From: Esteban Urrutia <esteuwu@proton.me>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH 2/8] arm64: dts: qcom: sm8450: Remove unneeded reserved memory nodes
Message-ID: <b3541802-3035-40ee-8327-a65bd5d2dfee@proton.me>
In-Reply-To: <6123a923-21dd-4f69-9ac5-02165963027c@oss.qualcomm.com>
References: <20260622-sm8450-qol-v1-0-37e2ee8df9da@proton.me> <20260622-sm8450-qol-v1-2-37e2ee8df9da@proton.me> <e1e492ab-884e-442b-8410-cc100c54fd5f@oss.qualcomm.com> <6123a923-21dd-4f69-9ac5-02165963027c@oss.qualcomm.com>
Feedback-ID: 147889766:user:proton
X-Pm-Message-ID: df186333b5a853f68028d7d86cfc27a4db0a8a20
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 6/23/26 7:03 AM, Konrad Dybcio wrote:
>> This is mentioned in the memory map description, but is not part
>> of it.
>>
>> I booted up a 8450 HDK and it doesn't even have MTE, so it's
>> probably valid
>=20
> i.e. it doesn't report MTE to Linux. I don't know if it's Gunyah
> trapping it.
Then, should device trees delete these memory regions on a case-by-case
basis, or be left as is?

Regards,
Esteban

