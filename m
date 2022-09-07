Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BBB53B5
	for <iommu@lists.linux.dev>; Wed,  7 Sep 2022 12:49:08 +0000 (UTC)
Received: from 8bytes.org (p4ff2bb62.dip0.t-ipconnect.de [79.242.187.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id E4F5524000A;
	Wed,  7 Sep 2022 14:49:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1662554947;
	bh=yGOX5Lwpalcu82yNs8ayh8dOtcer41jlk77UdSRJHzA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uE78GVEgI4yTOR9KWvlR6IpZa67YTCKueETuj+yYYkM1pR/p3SMYfJwUC1JIQlv2e
	 2ntTjhAKoTFc7sIl+Vu7+2KELvGsyWVaHSJ3AqSumJvsfUrT3HcwqC38Dl7VcnwroB
	 8BFi6rWMsQWaBAZ6yGKr4LVWwTh2MQqqZIfvRsznMzAr1tqMQ4wbun1jLc6Q3oK5qR
	 4cEjQ7+thJq/JFFPPZao/wMUvReiwhSBhAhxKOJVjYvypVQZSPwSzv7INhTevRqlKz
	 tyLofbz/SQzQ1doEpWKl93VLrcpVkkQeTqcmZ4zf7b9+DgCzs3P+Ahm8FeqJQInzIE
	 YZOdibS6/esUA==
Date: Wed, 7 Sep 2022 14:49:05 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, catalin.marinas@arm.com, jean-philippe@linaro.org,
	inki.dae@samsung.com, sw0312.kim@samsung.com,
	kyungmin.park@samsung.com, tglx@linutronix.de, maz@kernel.org,
	alex.williamson@redhat.com, cohuck@redhat.com,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH 0/3] iommu/dma: Some housekeeping
Message-ID: <YxiTQRbsoJDG2QZJ@8bytes.org>
References: <cover.1660668998.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1660668998.git.robin.murphy@arm.com>

On Tue, Aug 16, 2022 at 06:28:02PM +0100, Robin Murphy wrote:
> Robin Murphy (3):
>   iommu/dma: Clean up Kconfig
>   iommu/dma: Move public interfaces to linux/iommu.h
>   iommu/dma: Make header private

Applied, thanks.

>  include/linux/dma-iommu.h                   | 93 ---------------------

Squashed the updated file path in MAINTAINERS into the last patch.
