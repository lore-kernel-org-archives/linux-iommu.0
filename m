Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0223DA2D
	for <iommu@lists.linux.dev>; Mon, 16 Oct 2023 07:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="wCDHL8rf"
Received: from 8bytes.org (p4ffe149c.dip0.t-ipconnect.de [79.254.20.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id C0F6A1A45AE;
	Mon, 16 Oct 2023 09:35:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1697441731;
	bh=f6vgjRWU0QyKNDLv/KAm7cH3YOd4McoY7nD9XRt9FkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wCDHL8rfWK46B4orPzg2Z5Fo58Gc+jYzkYeFIUnXVClC5dIu7oSCZBQaXO3w9C9vS
	 Is6iIKJrc6uAyHwGSA3kQmgqUahC1g1F9hQcJdEHmNroTfMpSbQRmpLDQaBKAY11oc
	 ZJGPLBx+fD0AaLAJd1nJcGyG2bYaI6KP7BEWkEDAnQI26kqbMGyD/sRBYhhEdqyCqv
	 n7V2kkIRCDbub3ee0CT74+dQuPC1FXhjWi3CsD+h5qBUpByBZ39QY2esJ84jDZAVdh
	 Sd1zx5NLDL6rlEPrkiRwxXmtmPuhw2/FfFZ8FD8IBRC7lba1kc6wOCdTWMt6MS8O1O
	 vuADtzWr72dGA==
Date: Mon, 16 Oct 2023 09:35:30 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	kernel-team@android.com
Subject: Re: [GIT PULL] iommu/arm-smmu: Updates for 6.7
Message-ID: <ZSznwiSYnoan17F6@8bytes.org>
References: <20231013120205.GA13843@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013120205.GA13843@willie-the-truck>

On Fri, Oct 13, 2023 at 01:02:06PM +0100, Will Deacon wrote:
>   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates

Pulled, thanks Will.
