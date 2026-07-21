Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD06A248896;
	Tue, 21 Jul 2026 12:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784636507; cv=none; b=CAj1yPMAIqc3fJb6ZO0cNIo7rvonTclfCcNX03LS1n+PCy8OAfUnfH+F5zcNG7Q6X/iivCYzKHOlJCV2ai6ZJNXmckvyaoxeYHFY/dDbEHyw1zqJeAjk/G84SZd7dfBuNiAIUTGCqIqBz6CP1J4ey92KU5W3IPZJsRrhayWPujM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784636507; c=relaxed/simple;
	bh=oI36CarQfYh7aMDewO/6kyWwgCcgLMSgNlU7hGDyHD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZqIL2UF3uqNJwmr2bxZOIWhSC08xSqmHOtB9aCSifqNet8i8CskWpky5UJQH+0amJKSJVq/z+GJoFjAenqoBgDsyf4M1L9B7OMbnWaJvuxQZR289KuwUugGUbUqIGZjxaK5Hlb9AUclLCy7BcES/XFgopDMu0hvOQFrLAz9xiuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BXE47pnG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXE47pnG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D651F00A3A;
	Tue, 21 Jul 2026 12:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784636506;
	bh=3jzHhYS66mLoqQQh3nh8gfmwafe5BUZEM4fK/7aI8KQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BXE47pnG7oTQSdmXMNKYeTTv5LK/BuenUJrre2TfnJDM1jMDnbLAhgXSJMCmyDqgm
	 k/S/WJruCNPTuBJxG/0feAFk4+ZwyH30EQ0bOY7CWGf6e7XtlUfrrRTgU6cHtoJc+P
	 r3h4rf4OLAbzRODDWzduyVlXYxooZ1JAJbm8dueaVImnhARaYCUt2fLdK32W5XaChJ
	 kBlKAZldVb8X/CNoFEb9/VZr+Ru3oa5gCcTKg0cBrDfNzKqsnk0tyAOGsF9Q72mLXY
	 83bDh5P32DjaaDPJyMxXZuc3iALKgU1yhVHrwDbStYX+h3Q7zsq0BrcICSs3YpPoWG
	 8inW8fG+DeptA==
From: Will Deacon <will@kernel.org>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Ankit Soni <Ankit.Soni@amd.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommu/amd: bound the early ACPI HID map
Date: Tue, 21 Jul 2026 13:21:29 +0100
Message-ID: <178463336959.218309.17091254932434560576.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260720114613.92391-1-pengpeng@iscas.ac.cn>
References: <20260720114613.92391-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 20 Jul 2026 19:46:13 +0800, Pengpeng Hou wrote:
> The ivrs_acpihid command-line parser appends entries to a fixed
> four-element early_acpihid_map array. Unlike the sibling IOAPIC and HPET
> parsers, it does not reject a fifth entry before incrementing the map size.
> 
> Check the capacity at the common found label before parsing the HID and
> UID or writing the entry.
> 
> [...]

Applied to iommu (fixes), thanks!

[1/1] iommu/amd: bound the early ACPI HID map
      https://git.kernel.org/iommu/c/fb80117fddb5

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
