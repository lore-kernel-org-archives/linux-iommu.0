Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7C6242D89;
	Tue, 21 Jul 2026 12:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784636505; cv=none; b=Djxx+nK9tvBd3fyrF7vatHnh4mzwUHxOZwaXdIvaGMeopYAyC7xnw2D8nSQ1eWko7AHvdTAfb7Y/ZYCTf8hUlfnwqqjOSrcZZYBiS2NKNB/czx3D2hzL+JyXWSm1sMkJ8yt3Qb3c7Vj4/VwB6rdHKjcIRYGbq0my4LMzyqPuZHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784636505; c=relaxed/simple;
	bh=J4yQo382ZxP9a+wipusO1+rSEqtDYVVPEu5bHf+mvlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j9cVVacOM2c8/Fc+qbLnSdV7R9Yk1nHYCkCU53m2AuZp09RMglxwKMHQIAbFxG6xJKGMBYkcdN6UDn8bGvFXdukD7HQ1K85TiSU348eIoVKnW9VL9I3sfrKQ2Oq7+9YuXCYtSOTxaxP5pJFFuK1VN7UWfIb/g1Fxj8H8HmhKwzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PP/3FFHG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PP/3FFHG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C645B1F000E9;
	Tue, 21 Jul 2026 12:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784636503;
	bh=M6erG6xmIVZCNNJpsWHHodQwAAWDLIRP6W2sNe+aaAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PP/3FFHGgsS2oN4ORsXUiMvtCpP8ogksmphyHC29BFAJxYwuldu8rgvMsjR9X2wrb
	 B2gxvEdncfl6EzdEhXtRwPdmZRIe44UAvt1Gr65Cv92+5bU7lzVdluMJqCaMePek++
	 uowZIL4G8Kn50FQezAXIXP9HrVCMXWJRjsI4Xw5NGtj8cwUBLnCLEIx+ZUgC+lMSde
	 KASLW4CwwT0EzGrTsHFwBhLkxNPdiwZAr39afz9sjn8BHVGThduNT9hzXBegaGIXXG
	 9iMF0Too9dzJz3vcEWe7AGOVgcxUFwQnH2GnXTmSWw5NQ8vzPhpxbMiGypQamoVS8D
	 slUxt+S5Arj8w==
From: Will Deacon <will@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lirongqing <lirongqing@baidu.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH] iommu/intel: fix out-of-bounds memset in dmar_latency_disable()
Date: Tue, 21 Jul 2026 13:21:28 +0100
Message-ID: <178463365358.220184.8467214471810541204.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260721093410.2465-1-lirongqing@baidu.com>
References: <20260721093410.2465-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 21 Jul 2026 17:34:10 +0800, lirongqing wrote:
> dmar_latency_disable() intends to zero out only the single
> latency_statistic entry for the given type, but the memset size was
> computed as sizeof(*lstat) * DMAR_LATENCY_NUM, which clears the entire
> array starting from &lstat[type].
> 
> When type > 0, this writes beyond the end of the allocated array,
> corrupting adjacent memory.
> 
> [...]

Applied to iommu (fixes), thanks!

[1/1] iommu/intel: fix out-of-bounds memset in dmar_latency_disable()
      https://git.kernel.org/iommu/c/754f8efe45f8

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
