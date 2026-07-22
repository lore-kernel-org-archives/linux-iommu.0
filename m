Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FA243B3CC;
	Wed, 22 Jul 2026 21:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784756419; cv=none; b=HTmBQHIqOXBLJ1hQ89gvrWl+MFgVRICvCHnFjzIL0BvM/PXMGulGrvM7mEuL0fcQzOK064eBT5IapVuBY7gGzz1jjgdOxo26USzxafr3sZnXXDb+RXpPVVlWG1lAD7Nq894X24Lm5AnvoLwAViMs+gIOBEn8mSohO0CFHYticF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784756419; c=relaxed/simple;
	bh=B2AieRQjmNsCYhlv3dnKrmCE+NXpZHH2UZaqHYyHTFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qwl3y3ZyfSHawzhDPkatdpySeoViyYOLVpctfhxne1TwweiytYGZ9hAezPxSWEN+3A0zahQrzPbBVLqj/Wen5N6aWXgxzW6YgWLBrfgwc4AQtwvWbtU4dSJoCSSzEogYDUag5PtOqZor1APoa1SfYF63x5P8GVKSMl8V21B3Et0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWq32WqV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWq32WqV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 171E11F00A3A;
	Wed, 22 Jul 2026 21:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784756416;
	bh=i2PBsDBT7W9UmWyflEORLKtWJxT93D5ckxn7eveqgmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mWq32WqV6l186tO2OqrQDUwjihMaVEX2wTrGsG97yyeQdPrsdoW1IWvTMppQD7mwf
	 0zEvYOMXS8JmRd6FjOfDtzO4vbF3ZGyduVzOPq6KVG9fJNFPM4fl4Aon/F3xaegTh/
	 WG9F6NSUW3eaZcnQ4OrnQR0cIVWpw4lMLBxe1yvX0vlkFxVBlrSHiW/qMjz4bB0G0l
	 uqvCOKa+GwLrqvCj/+TDR6l1Bg5ceZ1+JZM4Yi8NRbDJJkdBSsfCgVJmd3F2OyYt1Q
	 Jsaj699uqQh/L6sc0ifgdaUTd1lX6jDLiapIqS74XP8uELK9pApV44vI5hBt2iPOkp
	 fFzGKnctloK4A==
From: Will Deacon <will@kernel.org>
To: Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lirongqing <lirongqing@baidu.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH] iommu/amd: Fix undefined behavior in devid_write debugfs function
Date: Wed, 22 Jul 2026 22:39:26 +0100
Message-ID: <178472357092.2860701.3018630153871589753.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260601121240.2474-1-lirongqing@baidu.com>
References: <20260601121240.2474-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 01 Jun 2026 08:12:40 -0400, lirongqing wrote:
> When for_each_pci_segment() loop completes without finding a matching
> segment, the pci_seg pointer is not NULL but points to an invalid memory
> location (the list head). Accessing pci_seg->id after the loop causes
> undefined behavior.
> 
> Fix this by handling the successful case inside the loop and returning
> -EINVAL after the loop if no matching segment is found.
> 
> [...]

Applied to iommu (amd/amd-vi), thanks!

[1/1] iommu/amd: Fix undefined behavior in devid_write debugfs function
      https://git.kernel.org/iommu/c/843e14998966

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
