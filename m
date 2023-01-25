Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A941C29
	for <iommu@lists.linux.dev>; Wed, 25 Jan 2023 10:44:55 +0000 (UTC)
Received: from 8bytes.org (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 84CC0262B81;
	Wed, 25 Jan 2023 11:44:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1674643488;
	bh=Ilub4utYrtn510+vgmeCYSL2yOYdmVh9IKnzwy00Ee0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QCNsFEJPFAJYAyhhp7zelWTtZ9GUm8HUPteiuXl1wKrqCuzLw5BN8A6iYkPssrCig
	 W3D+pE4WbY7mjEyRR7EDrhmB+2Izv+JZhz9T0uLGE7fukhPwBU9IKM05ZtYQWEx2fz
	 CH5TubfzxR2hFoD2YMM3Lww9qMvl5yLRP55RiJrctJjcjpgYqKnqErrGgw1b45fm4X
	 Bk97tp2PPT9AMVWlXc36+51mkzmmVrjW5OfwvYYkG5HMJ0bEY7Djogk1vQ4fAZt0Zu
	 Zc5XHIb4JrqLIQ1fkNokdlkoRTn9LiQh49FF6MqaBGijZjUib6WnU62eTqUchM9Q54
	 J6f8UGtEkdtDg==
Date: Wed, 25 Jan 2023 11:44:47 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	kernel-team@android.com
Subject: Re: [GIT PULL v2] iommu/arm-smmu: Updates for 6.3
Message-ID: <Y9EIHxU21Alud4qo@8bytes.org>
References: <20230124142957.GA26873@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124142957.GA26873@willie-the-truck>

On Tue, Jan 24, 2023 at 02:29:59PM +0000, Will Deacon wrote:
>   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates

Pulled. Thanks a lot, Will.

