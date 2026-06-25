Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786D55B5AB
	for <iommu@lists.linux.dev>; Thu, 25 Jun 2026 02:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782354190; cv=none; b=g1Hh09PJWv0bsO8pTfdD0GE40+0WZPcA6FZtCWk94MIytQuK0iNTk5C8H0Dg8p8P8LpE3xQ+hPbMGnOv0HYSinQlAnQ62Z7/eQPXfGHTKDGiQWH9fkSlw05htely+eSZIjSpHuCNHTT9MKUW0wQ7Ei1QdjA0nY9fG3jOhGwPCJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782354190; c=relaxed/simple;
	bh=JnOh6DAm+iyJOY8k9lF1wLJxsL5PuyoGuxA7tFKj+gQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D+Y0/pCNhp/ygKe/epzFbk6FjLFpnXjxjnWtbe9bhvJrJ01s5fsGmh7812lTSs82763q9lJi2TzoZ+hGP4jgAQlP8TtZodecKB4VFqbXfU96iY0QhLKeepAbgClFdgwoPrYUnddcaaOEud4BmVwYFTlfswxkEKer0hwqFElvHx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=hC25C7qQ; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="hC25C7qQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=lhjreogzzragvezzbpqetq5pkq.protonmail; t=1782354178; x=1782613378;
	bh=JnOh6DAm+iyJOY8k9lF1wLJxsL5PuyoGuxA7tFKj+gQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=hC25C7qQy5j6iwI4a0K1wmFvikllCXNDl6SKSxdSkhxW0mxWxC6eSr/7iO1N8UWzT
	 2g3rMnIkX2Dtro8UcbuKCPzvYLMi+iegQ4wTwEnFtnQruqOKFmI7LGugF4KOqJOIx9
	 WFdHwFJyvAhX7Dac/lJ8sBMpht9lnNnFFrI00IAuxq/RuQizk4P7vMbGZ7CeUXLP8P
	 v6YresBYDL6L5lvmxQxVU6TC4TWHZ++kFj6zDsUHWxHb1stLECEFDMoX4LF/T2B/EA
	 ihkU8Cl0Nr50OyD5rQij5eitWnQ4EY5qCg/9iqXDc8zcd87hsxWgSj9LBWiLnwREwE
	 B6ud6H57li8IQ==
Date: Thu, 25 Jun 2026 02:22:52 +0000
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>
From: Esteban Urrutia <esteuwu@proton.me>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH 1/8] clk: qcom: dispcc-sm8450: Fix mdss clocks
Message-ID: <9bc524b9-c6da-47a1-a7cf-abeb131416a7@proton.me>
In-Reply-To: <65873506-1a9a-40ec-ac67-60f61a0b4b4c@oss.qualcomm.com>
References: <20260622-sm8450-qol-v1-0-37e2ee8df9da@proton.me> <20260622-sm8450-qol-v1-1-37e2ee8df9da@proton.me> <65873506-1a9a-40ec-ac67-60f61a0b4b4c@oss.qualcomm.com>
Feedback-ID: 147889766:user:proton
X-Pm-Message-ID: 2189097c3afc9ff31fb66855912a0f096fff92fc
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 6/23/26 11:50 AM, Konrad Dybcio wrote:
> This can also be fixed by migrating to use qcom_cc_driver_data,
> which takes a list of alpha PLLs to be configured, and thenthere's
> a switch-statement in clk-alpha-pll.c that always assigns the
> correct function

If this is done, should a patch that migrates to qcom_cc_driver_data and a
patch that fixes the issue be sent, or should only a single patch be sent?

Regards,
Esteban

