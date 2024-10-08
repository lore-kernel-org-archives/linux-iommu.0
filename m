Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE08212D19;
	Tue,  8 Oct 2024 18:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728411859; cv=none; b=QQC+hKzdP2dlGZvVIlDkkBJ/Tl+Is8msU9AE3OgCF0cku3Y60aqJY5Uflhl9uo5sszBXTB6J+AUsp1rqX1AJX00tLXPOClEGx+kk8y57VeV0j2AEm+zTb5QcJoq97SNvE1AKbjaQxlV+f0ffIwogGzN8hpL+hKlRNUuY/Ls0M/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728411859; c=relaxed/simple;
	bh=HZlnqo+1ZAcu5d/47LtzTbNi6jaK0jMUp+f63esCaGw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ichdCrcLQk6JEwKfK439wZtq+COGzEcouJ1ijbb1hkKLuD6GTPT5r36OtjmB0HQ8hn7Vu8sEcIntFe98WQw4sQpWeC5FwmxFlxbF053JQXSMXH5QBvxGtyKEwoebDYPxsQnPpt8WbzHL6kZqFaSzJDds0QWJIJq0u2oIeV9IMfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zb1hKXUC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zb1hKXUC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57678C4CECE;
	Tue,  8 Oct 2024 18:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728411858;
	bh=HZlnqo+1ZAcu5d/47LtzTbNi6jaK0jMUp+f63esCaGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zb1hKXUChH8iNdBE6a4Ea7EdE1gcoboPgumc2L7H2g705QaAwK6qzSLPDM0wNAZAK
	 bE1OncLFVga6S5YJd9cyEISMbKXVce1/Jov1ed+tSZ7st/OqMyKFPHgzMnl/m4ie90
	 s2gYOorirYdVfUt02UjBpP8zIpscaOz2wh6UdsfrOgx+Lp0vnIkENasY2cVG1w006K
	 DvDP0fFwewKWISoOEkvfX8xZhiTDOSon9ofaUdAW0UJpdoUIvcYYt1Fyus8VemBcG+
	 NCWj7dW6M73MxhPg5Twb4BILMhm6zdxl5l360+6bdfk5e2bkBU+RSl5oQts4SRxjc8
	 5/kbzhMRsRoBw==
From: Will Deacon <will@kernel.org>
To: robin.murphy@arm.com,
	joro@8bytes.org,
	jgg@ziepe.ca,
	nicolinc@nvidia.com,
	mshavit@google.com,
	smostafa@google.com,
	baolu.lu@linux.intel.com,
	Chen Ni <nichen@iscas.ac.cn>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommu/arm-smmu-v3: Convert comma to semicolon
Date: Tue,  8 Oct 2024 19:24:09 +0100
Message-Id: <172840911539.3011557.12588658852433747200.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240923021557.3432068-1-nichen@iscas.ac.cn>
References: <20240923021557.3432068-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 23 Sep 2024 10:15:57 +0800, Chen Ni wrote:
> Replace comma between expressions with semicolons.
> 
> Using a ',' in place of a ';' can have unintended side effects.
> Although that is not the case here, it is seems best to use ';'
> unless ',' is intended.
> 
> Found by inspection.
> No functional change intended.
> Compile tested only.
> 
> [...]

Applied to will (for-joerg/arm-smmu/fixes), thanks!

[1/1] iommu/arm-smmu-v3: Convert comma to semicolon
      https://git.kernel.org/will/c/7de7d35429aa

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
