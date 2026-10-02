Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA20B37DE8D;
	Fri,  2 Oct 2026 16:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790959616; cv=none; b=MBH0Ab88f2mQjGRl2YqE7MTNaj//09KC51UlHD980y6xdtZU0jAUUbhNyTFpSmNLMyZ4DIdnM639vH3gpCvTsHu5LZDfy9SlTbmjSBrC6r2oH5w7K6/T51hV+5EzaujGkE86dCMSPRGv2mcd6NugZzHiMcXTFLKwXXkRWv3iX54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790959616; c=relaxed/simple;
	bh=kIO15s4RFEZL8Yq+ihwrnHsCzSxNGPQ0MfJIp2HTffQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZhU6/+MTGm0+E1pxkYzpeFIgAJDCppv5Dn3NV/I5A5Lh9Sb+RT7QIJrEpNWGAShkUESWJ3bpejRNHdcuGgaxzXjDjwU/YxVWiS2ScSap1LigfQ5vLzygd12DTSnihcShzyAYAIfHtZ3rgQ8dOxaA/MLM5eGMPZN5POiM3UgE9Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gptaoozJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gptaoozJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 948431F00893;
	Fri,  2 Oct 2026 16:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790959615;
	bh=YAqc7sLlvdB11p/fqTbQZyKaqldWqbPlcsvirlY8+UQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gptaoozJsVlyRpi1v4AMP6xux9F8RC3N/XoMasZaml0QePIxG0lgKEtPsG+deXLHp
	 w4A8nMDwZYObPipk2vYt69kbkg23Q/TNC7jIkNJj+GcYRDk/rItB4B9u95+AbnKJxP
	 Z3BC7nwOGGKxqiOcqcqvmYryHRdw3RfhIeFCzyUevzCySZC81Pwbnt7WBP3R+LfB1W
	 In4spXOffKfk/Rgi+gUulZ+sPHPKTIAuXic2XvE0MbGIMxvLpPrlpCB8rL8DnIOFjf
	 SttCfRoNpjbUPh2JmjrgIsILk70FxlPSwlClcvXuiJ3tiBV6tkG3Lio63yc58ch4Vc
	 xhsawTVWregJA==
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Breno Leitao <leitao@debian.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kiryl Shutsemau <kirill@shutemov.name>
Cc: catalin.marinas@arm.com,
	mark.rutland@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	Krishna Reddy <vdumpa@nvidia.com>,
	Pranjal Shrivastava <praan@google.com>,
	Mostafa Saleh <smostafa@google.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Yuanhe Shu <xiangzao@linux.alibaba.com>,
	Kyle McMartin <jkkm@meta.com>,
	Usama Arif <usama.arif@linux.dev>,
	kernel-team@meta.com,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/2] iommu/arm-smmu-v3: Make the queue depths tunable, and shrink them in a kdump kernel
Date: Fri,  2 Oct 2026 17:46:37 +0100
Message-ID: <179095566175.2076343.2229507765103689715.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260925141532.1274962-1-kirill@shutemov.name>
References: <20260925141532.1274962-1-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 25 Sep 2026 15:15:28 +0100, Kiryl Shutsemau wrote:
> The queues are sized from the IDR1 maxima and allocated at probe, costing
> megabytes per queue per SMMU instance. A kdump capture kernel pays that out
> of a small crashkernel reservation, for queues it barely uses and two of
> which it switches off anyway.
> 
> Patch 1 adds a cmdq_max_n_shift module parameter, decided in a per-queue
> helper and floored at one page. Patch 2 has a kdump kernel size all three
> queues at one page through the same helper. The parameter does not apply
> there.
> 
> [...]

Applied to iommu (arm/smmu/updates), thanks!

[1/2] iommu/arm-smmu-v3: Add a cmdq_max_n_shift module parameter
      https://git.kernel.org/iommu/c/c9b493a312f3
[2/2] iommu/arm-smmu-v3: Default queue depths to one page in a kdump kernel
      https://git.kernel.org/iommu/c/3f9fa6b9520d

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
