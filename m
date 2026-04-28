Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3153E322A;
	Tue, 28 Apr 2026 06:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777356893; cv=none; b=e3RtAiSoduqJg/fd9+Ab6hqr9X7PEgC0ajgb9ygUNKh579X/RTXun8Pc7mii6fGfQ74yxmaGkxxWXv+eXKvqYFzPzApzELPHCrxW+sa2K4285WlvH0+VYhlz3dFFdrFs4ai/NmNP2RixWzlyL+TYpPlBMn+cQpa2+zu6ghSoi8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777356893; c=relaxed/simple;
	bh=ZtNEEwE/C9cL26Tuda4aj88/aIU5hPbhP1JSjoFn+EU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/YWZGaomQtGTh9zNxqkVytnyqO6+NB29Aqg2QZ1F/pWfqQVSnCzo8HbMm0cvMhwS5Z0BJfB40Ey4bwI6KOQTeNQOuaO1uhelpygMQr/uuv0+AoEYlENhynzFejXXLlopSvUpU9Om/jUnv8fleKio9SHHzawRdMWT6z7/JkMbok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WWOSwsps; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWOSwsps"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F14DC2BCAF;
	Tue, 28 Apr 2026 06:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777356892;
	bh=ZtNEEwE/C9cL26Tuda4aj88/aIU5hPbhP1JSjoFn+EU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WWOSwsps2UaCyLidZ43a2fT7AZWHkqGM0pcS1f5LES2h643yzai4q1nKtbd0FlGSs
	 NbN5rl99ASQhfoCLWJdjbT5CYuCV5mor1cVGWIRWcsvE33/YzkxGCLFGusZCkPLU24
	 wsX6h5BJV25uO2nOTBlJvqabdm/1chBlSUZFQmRneugpKnSR+yQBc8PhCGfQVSkmdC
	 mEfDwkntQ5ffLsho4B5fhOyXREGE5a56I++lElJYZofKTcShIk+ZBo1+SI18GkakYE
	 W9adFmN1UuHhqtX2nhbH+/raYNR/JWj/l4nlcLHPl9A+P/sbvWR1D/PvWjS9UcoTxA
	 gjFAJIWKwKg7g==
Date: Tue, 28 Apr 2026 08:14:49 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>, 
	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
	Bryan O'Donoghue <bod@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Hans Verkuil <hverkuil@kernel.org>, Stefan Schmidt <stefan.schmidt@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH v3 02/12] dt-bindings: media: qcom,glymur-iris: Add
 glymur video codec
Message-ID: <20260428-nifty-quaint-hoatzin-6de65d@quoll>
References: <20260428-glymur-v3-0-8f28930f47d3@oss.qualcomm.com>
 <20260428-glymur-v3-2-8f28930f47d3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260428-glymur-v3-2-8f28930f47d3@oss.qualcomm.com>

On Tue, Apr 28, 2026 at 09:24:08AM +0530, Vishnu Reddy wrote:
> Add device tree binding for the Qualcomm Glymur Iris video codec. Glymur
> is a new generation of video IP that introduces a dual-core architecture.
> The second core brings its own power domain, clocks, and reset lines,
> requiring additional power domains and clocks in the power sequence.
> 
> To accommodate glymur clock and power resources requirement, the maxItems
> constraints in qcom,venus-common.yaml are relaxed. This allows the glymur

This is a very confusing part of commit msg. You cannot relax the
constraints. Each device MUST have a specific, fixed constraint. It is
your task to be sure they are not relaxed.


> binding to inherit from the common venus schema without duplicating shared
> properties.

That's obvious. Why would new iris device schema not use common venus
schema? What is different here then that such possibility exists?

Best regards,
Krzysztof

