Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6720720ADE2;
	Tue,  8 Oct 2024 18:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728411856; cv=none; b=sXbEDOQn6V+GVIWalnsA0xe3emUF0sEkEOGk1SKXdhHufzppL951yUf+meDgDTiNvvtI4v68hYi9RxIQSbhwj4tKWq0VTDyiRm4A8dpH1f4byleHWWEh7PzsVAR5U1sj4ICi/b5An5VH1/h4UxTVHmPuS04Jz8SjpfRMic72Xvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728411856; c=relaxed/simple;
	bh=XQgtMSU1T6/9qw4C71yOhvNbkERpgiqPaf4dwMPdm80=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jPvGSbzP8mvZgd/jy+dXaOjtZf1aKstKcJRUxFu9BrS9CcIYVORRfG6WMWuBHNA0Re1ViaHI3RJWYcm4Q4w3Y1htDdg8WsQ2GEqbJ3ypxg61VCEP9iof2QaWfTCc/TL1ZekMIUt+o3L5FXKB4aC6OmgRdpEQGs9sPsNIxuWWZqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkS/0Bfw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkS/0Bfw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06341C4CEC7;
	Tue,  8 Oct 2024 18:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728411855;
	bh=XQgtMSU1T6/9qw4C71yOhvNbkERpgiqPaf4dwMPdm80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gkS/0Bfw8bcTCckGe5dDYONvxh5YkZq6Lt0jObtd7ECBlWTdkKpGJp39MykhWJekF
	 JwdvXe4eJDfjx7XtI40WVmqyWow5CEBQAZQ2duu9boTgPL569QDfsvn6wjPDafxrlc
	 POtA9/tv3jDhC7l5YCgVTJRHdGYF6guX9ToRTuvopjU0dqqenax95EgD9KiRGhO7oF
	 N+jzB6JBelFczVB8ulJQdAsO8L8/7Ob3EQy5sI1ErwDgCwEbmHLAqw2ADqvifvOqIL
	 IBT31LAiE5Z74FKAohp8HK5qwlKa73gpFsFywr0lRDORz37RwR2A9m5M1SxxWM7TFA
	 BWFFus+XplQVw==
From: Will Deacon <will@kernel.org>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Daniel Mentz <danielmentz@google.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Ryan Huang <tzukui@google.com>,
	Mostafa Saleh <smostafa@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fix last_sid_idx calculation for sid_bits==32
Date: Tue,  8 Oct 2024 19:24:08 +0100
Message-Id: <172840906883.3011353.5847751267067117740.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241002015357.1766934-1-danielmentz@google.com>
References: <20241002015357.1766934-1-danielmentz@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 01 Oct 2024 18:53:57 -0700, Daniel Mentz wrote:
> The function arm_smmu_init_strtab_2lvl uses the expression
> 
> ((1 << smmu->sid_bits) - 1)
> 
> to calculate the largest StreamID value. However, this fails for the
> maximum allowed value of SMMU_IDR1.SIDSIZE which is 32. The C standard
> states:
> 
> [...]

Applied to will (for-joerg/arm-smmu/fixes), thanks!

[1/1] iommu/arm-smmu-v3: Fix last_sid_idx calculation for sid_bits==32
      https://git.kernel.org/will/c/f63237f54cf1

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
