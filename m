Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42FD2E401;
	Tue, 28 Apr 2026 06:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777359070; cv=none; b=XZVvDF0zbIb5jdgjvLDPNib80yuGbB9eqi9PZWzR8dg4wZ3XW/pqodYkpLenloTQpB0lFHaDnwNkCusXGHK/huw6GHXr84QMQsiQJVq20QNX5eMj+ftnklBHU4EXIaJYN3zbUQwGz5/JBrFRzNi91XWljNI6xsPu8TWd0TProqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777359070; c=relaxed/simple;
	bh=xRCvIjFm1qRPY86c8XK+wqrLdiC4ZGv6pNeFUGIqFMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qHHxD/PRbCKJYux/CWehBKwlPpS4NrCjU4ZcbZKlCpCg08PEvUku4faB7nJY41ENeiJ63S04eVBxOVv0M2jEA/xCQvdcn7nhHPgfP2OAjr4FVJmdx/RS+i56WL78rZVyuCvSOXyWkzsppnuA4Wk038nWgrXg68omFtYq/LLKQvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ISl2U9pc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ISl2U9pc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C34C7C2BCAF;
	Tue, 28 Apr 2026 06:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777359070;
	bh=xRCvIjFm1qRPY86c8XK+wqrLdiC4ZGv6pNeFUGIqFMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ISl2U9pcz5S+w16MG1ZHzMg58ZG8NpDuh9JFPoQtHaqXTAKKIMUo0oQZ4rqCm8tSY
	 KX0XzV1X9O0F2DSTrfcSvPowRgmSQbMKhq+NXyJlg3tg9HD5lmxn9U2FXnIjp1itlS
	 QQ88a1yAoS3C+cHOdQPxFF1+nTaD3WP7BRssmiymvP0LPO2vZjrVcthGlZzeDkYg+1
	 dc6XkOSBYNlwfzR5QyyXJdvjAPOd2LUQ9fq/SO2nkJvy+gTsqjrMsiE4ZD25W7E5kr
	 MyFVA6JBG174k92s65x/c1KJzYgen8KYkxXtgLmQcOaM4wrOF5knc4ru497Y/G6/VY
	 CrraCjnoIc04A==
Date: Tue, 28 Apr 2026 08:51:07 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Robin Murphy <Robin.Murphy@arm.com>, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: arm-smmu: qcom: Add Hawi compatible for
 Application processor
Message-ID: <20260428-pristine-rose-whale-35db39@quoll>
References: <20260427174915.3639641-1-mukesh.ojha@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260427174915.3639641-1-mukesh.ojha@oss.qualcomm.com>

On Mon, Apr 27, 2026 at 11:19:15PM +0530, Mukesh Ojha wrote:
> Commit 5e8323c3d528 ("dt-bindings: arm-smmu: qcom: Add compatible for
> Hawi SoC") was intended for the APSS SMMU but was mistakenly placed

Would be nice to see explanation what is APSS. We do ask for that every
couple of months.

> under the Adreno GPU SMMU section. Since that compatible is also valid
> for the Hawi GPU SMMU, keep that commit as-is and add proper
> documentation for the Hawi APSS SMMU here.
> 
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> ---
> Changes in v2: https://lore.kernel.org/lkml/20260422083329.885979-1-mukesh.ojha@oss.qualcomm.com/
>  - Not a fix commit after discussion.
>  - Not removing the earlier commit change instead add one for APSS
>    SMMU.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

