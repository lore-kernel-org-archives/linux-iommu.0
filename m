Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED6443F4C3;
	Wed, 22 Jul 2026 21:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784756411; cv=none; b=dt7c+kJoZXQwNLwidivV2KXh3aJwZYdiQsdksP3XSqTrozUnruWnsLPJ/riN0h/mIkqrQBd9gjfanKtt0kJtk1mlO6S2BD4pb9sAIGiY/+wizNuNUmdXjUwun3YzO0k6OppuFanFfkp9+YTwIBJ16Q5jvqksgd3tqMcCSMp/oLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784756411; c=relaxed/simple;
	bh=iO2C2TCzTYyoOfr+nBCShMJNsYZhomSajQ5SesrpfY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KRRY2kyb7/rnYYZa42/uTmhZzAze4zmKvFUHxXE69Qx6jdJIqqOLnULzd+QEOXWvRXI+8ChG68dMwof8qyAD8tGfKMJQyFwqX2bVm7z34Me+lmWPY76DAPEQSx5sObuYR6dRurtDMgaV+aOeZVZ8AKGdlhGGj8hDO530/JKaYXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8hbSMwb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8hbSMwb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7134D1F00A3A;
	Wed, 22 Jul 2026 21:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784756405;
	bh=05DcLXUDBODwTIC/vFQe4/Jl8OY9tG5M3Vtaqo3cTGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G8hbSMwbhorpP8YW6MEw1xzEr2qN/8gxtpYyBUGh/eaMySTyxcshoFe9w/jvSvWtW
	 I8lIoDXg3yO83foGab+2Vsr59WmDNU6UsnsU/NOdQh8Qc3FGUC9Hhijm27GEZ/6d1A
	 t+fYoeb3xEjZunSXmICB3QIpJZyA7Rob9bOHNLYTpYHB3E8cYoQP2vecQ+NF6FPj7E
	 6zhKHGH8VQu47v1eOLz2iUtUjfpKzOQOozHZf90kVIz6ai7YF9ON3BtHeL+hzWH++a
	 vpoWV9LECDQWSU0WOq7BO5Dc7si6bFz2pVVo+c+GzmwIqNEF/+y3rR1w0hFXro2NgZ
	 3jBXoJnYtSjtg==
From: Will Deacon <will@kernel.org>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bhargav Joshi <j.bhargav.u@gmail.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	goledhruva@gmail.com,
	m-chawdhry@ti.com,
	daniel.baluta@gmail.com,
	simona.toaca@nxp.com
Subject: Re: [PATCH v2] dt-bindings: iommu: ti,omap-iommu: Convert to DT schema
Date: Wed, 22 Jul 2026 22:39:23 +0100
Message-ID: <178472680334.2885136.1405870694545530359.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260708-ti-omap-iommu-v2-1-612d4a6644ba@gmail.com>
References: <20260708-ti-omap-iommu-v2-1-612d4a6644ba@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 08 Jul 2026 22:21:43 +0530, Bhargav Joshi wrote:
> Convert Texas Instruments OMAP2+ IOMMU from text to DT schema. Make the
> 'ti,hwmods' property optional and mark it deprecated as it is no longer
> used, it is kept to support legacy dtbs.
> 
> 

Applied to iommu (ti/omap), thanks!

[1/1] dt-bindings: iommu: ti,omap-iommu: Convert to DT schema
      https://git.kernel.org/iommu/c/57f63e7082f6

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
