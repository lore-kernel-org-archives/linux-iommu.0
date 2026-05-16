Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBB5224F3;
	Sat, 16 May 2026 09:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778923882; cv=none; b=aVQo8aUL6byWtrDI8wDG9Tt7DtoG3j/oxXwyitzehoHJApJGJFKe8cEDQprxsUrDkBL0sxW9HVLxWT7wXUcxirws5gZkTdXcTtyPXyfjBwyqQy22yA3fxMU/GRnQ7arYef31TZRLxRtzruXXZGXM/h2IAKKlCiJLUvyGuwWntxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778923882; c=relaxed/simple;
	bh=07tFM4GgR2mex77HZnUNUD3uSo1xqKjOVmg7IZfsO+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mHMXUdwIbSdblNSUtqPEu1HJkJmokh1DMGHe2v8pT1Q0K5YUxUCnH9hszz+4l839MnSHyfuB+ffX66T847mYuRI5HiHvds2lTV1oBjZP3yDfxb8FzlUgM3uoDCrFDfBHezLf5yeSzWHgx7QVIkNsPPqoLYcEe5s26qY7bU3Wz/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhcamQN3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhcamQN3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D22C19425;
	Sat, 16 May 2026 09:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778923881;
	bh=07tFM4GgR2mex77HZnUNUD3uSo1xqKjOVmg7IZfsO+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YhcamQN3C6wTT8JrgYrm8tRFkXuie4lahRem2zOdXWgvrR8FFfAYtvKy1mLnQUQl2
	 PnSqjoGgcYFGROj1VDsuM6hoTNWpIDECVdDMklO9UMA5cR/0LUONn7Hi+BH1roz1Ly
	 C3uKe7OpMJRfp/W65lvVRhgz4TQQrD870Ts6qSdQkng0cFrLn6wjPyKCar9ayX+sjD
	 OegPYMCOZfnzF5qn/l2hTZH1UKmw94aNXLcOm2WTXa8lhh/KEglulQG7KxtOmZDTQ8
	 CV4FzaYSjXI0XrvX/PWwASF3HcrEXYmuXQcgsmIIjN13Mqmlh1BaOSWb4p8TQ+SsEn
	 z/n4q9i1tGuLg==
Date: Sat, 16 May 2026 11:31:19 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>, 
	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
	Bryan O'Donoghue <bod@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Hans Verkuil <hverkuil@kernel.org>, 
	Stefan Schmidt <stefan.schmidt@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 04/14] dt-bindings: media: qcom,venus-common: Raise
 maxItems for clocks and power-domains
Message-ID: <20260516-bald-versatile-wallaby-bcac6c@quoll>
References: <20260515-glymur-v6-0-f6a99cb43a24@oss.qualcomm.com>
 <20260515-glymur-v6-4-f6a99cb43a24@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260515-glymur-v6-4-f6a99cb43a24@oss.qualcomm.com>

On Fri, May 15, 2026 at 04:51:19PM +0530, Vishnu Reddy wrote:
> The current maxItems constraints for clocks and power-domains in the
> common venus schema were sized for platforms available at the time of
> authoring. The glymur platform introduces a dual core architecture
> that requires more clocks and power domains, exceeding these limits.
> 
> Raise maxItems for clocks, clock-names, power-domains and
> power-domain-names to accommodate the glymur platform.
> 
> The glymur platform-specific schema have fixed constraints for these
> properties, so the common schema only acts as an upper bound.
> 
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/media/qcom,venus-common.yaml | 8 ++++----

This commit alone makes no sense. Do not introduce commits which have no
meaning. Why it has no meaning? Because imagine we stop the patchset
here and we do not apply the rest.

Squash the patches.

Best regards,
Krzysztof

