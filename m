Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0481586CD;
	Tue, 23 Jul 2024 16:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721752395; cv=none; b=A3eAjlcCeb3HUSUasmtf779TQjbB8c9jpDqf4fJwx6tpBH30wzyLztAGikQ5/8ojRxh0AhdbgtXuS/c9LdDE2I34xh0DV7Q5cBtkf5ycRe/ck29YV9mSf9hu7V95vUETU3ECrPD8j35C/DGp8i52K/UmGKVmCKXIk8FfMsBCD3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721752395; c=relaxed/simple;
	bh=zhkYcpwtRl7kvq7yhQQMLre+/s3ijld362JBsIgw208=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pdg0F8KkP2tNeUa5RQAttMSWWOz2IHP8odL5H3SwvpwKF1xiDw3jLmCgcUtrcvkBw/81TELDhK4egeJPFwikllI903vczJosUYCierMFosCc+TUC3YBsCt4xc9zRCiGakLD33P3yBUo8PzcgcMUs7q43U2YYNPuQ4YdZ5wBcRbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xgh6rBpY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xgh6rBpY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8959BC4AF0C;
	Tue, 23 Jul 2024 16:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721752395;
	bh=zhkYcpwtRl7kvq7yhQQMLre+/s3ijld362JBsIgw208=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xgh6rBpY6AS1tYerJtAYOMWa1qSYUnoG1NBl0aaeRUMaD/oJS/Gs6Yyz67mzIVBKe
	 goTXuQO7aQngmc8migWMQwFRGR6yHS92hDtO2i4cwPcYRueVLVytDw7tUdvNEWVLec
	 Xx9sCDi2n7mlWBjK/SZOaf054kPEBkBs2THSa/pVN7RaPuYCWfie1bPIvYfAHuOkul
	 n7t55hOO5kkDOeDu77et6Z6AyE6AorvDA9u67L3q524+dazByj6KaKo7A9/kng9QV+
	 kY+ghwFhYZeFDztF+EpWZAI95XMlq9467Zic1qbaTYDj7BDEcQdlYDU2LS5nGQ+s6l
	 +MgT97V/dYANw==
From: Will Deacon <will@kernel.org>
To: joro@8bytes.org,
	suravee.suthikulpanit@amd.com,
	robin.murphy@arm.com,
	Chen Ni <nichen@iscas.ac.cn>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: Convert comma to semicolon
Date: Tue, 23 Jul 2024 17:33:07 +0100
Message-Id: <172175100786.2359750.8965125460138667335.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240716072545.968690-1-nichen@iscas.ac.cn>
References: <20240716072545.968690-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 16 Jul 2024 15:25:45 +0800, Chen Ni wrote:
> Replace a comma between expression statements by a semicolon.
> 
> 

Applied to iommu (next), thanks!

[1/1] iommu/amd: Convert comma to semicolon
      https://git.kernel.org/iommu/c/86c5eac3c4c4

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
