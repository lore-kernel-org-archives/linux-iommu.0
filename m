Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6073248866;
	Mon, 14 Jul 2025 11:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752494082; cv=none; b=IMSIrnlz0jxrN/aRPGYqY2PN6hOVKB92hUzfpxgoQqRNE4Qr2QxzkF0WQm7mP46Cq24YWydqw78o1+4pf4DYBXR1U1UNoU7yQvbxsEeK5JLmig34HlDn5G70BCvjRmWbYGCVOX/g0jXNGeqKGqpV//eoHXxIhAE9fSNmVs6fglI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752494082; c=relaxed/simple;
	bh=TSHbcaDaHk8XLek2I6xVF/1e1x2tIiEugFze3uWtuII=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I4sjiQJVG2SPWviuKSV+mxkoVb7y+uRzfOiIiwR24nDKKlSgpzribAe/gB9SLkwM/yV9PHAPFhvZs06/VtX56oUqRd+xSciBG4s5umhtNcmaTewpYH1Unjf6X+TTKrUVTO0K7c4bGK1Nw7mVZlVaxBeZf4UsIfqZSP3rXEABqec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=so/w8d75; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="so/w8d75"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C318AC4CEF6;
	Mon, 14 Jul 2025 11:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752494082;
	bh=TSHbcaDaHk8XLek2I6xVF/1e1x2tIiEugFze3uWtuII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=so/w8d759MvtheFhieCw/D6jCSa6bH2LW25YiYfUqOrz6CFTgP79H6Se6kE4v0cCq
	 /zMMJrhB5b0vAn8VDm6dvkMeRiffu0/kJ5hF7QX6hOlm4KD3epNbBZcPywMQFbKdWS
	 dkqmlk/vgz9AyIZSrb7eoVMzTvgmcVjpsk9InRAGeN7Ghkm5zTyNiYSRuokQkiXA8A
	 qoRZqWorc7C1c6JFUhkcUwdxZrlomBW6bI2Uvd9HFUgHPNu4EsJrXQZzbbt/hhpf69
	 yvDBUlXhGKgjKCuGg44Hdg4CfSDij3kJwrPiOgPDH6Oqfz9lbioGJqETY5oMye2VuV
	 tGDUUb2MZ8hCQ==
From: Will Deacon <will@kernel.org>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Daniel Mentz <danielmentz@google.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Liviu Dudau <liviu.dudau@arm.com>
Subject: Re: [PATCH] iommu/io-pgtable-arm: Remove unused macro iopte_prot
Date: Mon, 14 Jul 2025 12:54:28 +0100
Message-Id: <175249154312.1453294.15769567354311184199.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250708211705.1567787-1-danielmentz@google.com>
References: <20250708211705.1567787-1-danielmentz@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 08 Jul 2025 21:17:05 +0000, Daniel Mentz wrote:
> Commit 33729a5fc0ca ("iommu/io-pgtable-arm: Remove split on unmap
> behavior") removed the last user of the macro iopte_prot. Remove the
> macro definition of iopte_prot as well as three other related
> definitions.
> 
> 

Applied to iommu (arm/smmu/updates), thanks!

[1/1] iommu/io-pgtable-arm: Remove unused macro iopte_prot
      https://git.kernel.org/iommu/c/ec7ca73144e9

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
