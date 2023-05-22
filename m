Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D301B1428D
	for <iommu@lists.linux.dev>; Mon, 22 May 2023 15:01:10 +0000 (UTC)
Received: from 8bytes.org (p200300c2773e310086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:773e:3100:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id C3F3E2434D7;
	Mon, 22 May 2023 17:01:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1684767669;
	bh=5VQBXOpnwnQTeAxZ+dp1+XASSAtMPtkiirJfrWe6bl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=03RYkTt17CrSBLQ9nOIq3wBrkPUHFrAEy327KzA5mFoaCdAh8B+Z2GKVYooEqprz9
	 NkozzoPUon4rTbN4txKaZMxvdMsb2w/KcAuOa9VmJQFCF6pZg2sVRFNiyhhnUqwM+q
	 2pdzXhox5WivPPx7Te6w8IEhizHrv+/QbwOuL7QVUUB5uMO2+eHK/XD9zjU0WugPDz
	 piqKDVAclWlnQgrqJzVjOO0It1XPMrFDBHxj/U/s2NSWZFBz0u7XCnIn9QZmBNFR91
	 +SdAiaqwfLqBS9RYIxOTJN+izI848s0bJGiFc6y4XkatWbIOdLw+hXuAPvg7tPmZuI
	 u8/Tr4RP20CTw==
Date: Mon, 22 May 2023 17:01:08 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, Conor Dooley <conor@kernel.org>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v2] iommu: make IPMMU_VMSA dependencies more strict
Message-ID: <ZGuDtM22nay0NC2z@8bytes.org>
References: <20230330165817.21920-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330165817.21920-1-rdunlap@infradead.org>

On Thu, Mar 30, 2023 at 09:58:17AM -0700, Randy Dunlap wrote:
> ---
>  drivers/iommu/Kconfig |    1 +
>  1 file changed, 1 insertion(+)

Applied for 6.4, thanks.
