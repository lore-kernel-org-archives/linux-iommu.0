Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA4B2F2A
	for <iommu@lists.linux.dev>; Fri, 13 Jan 2023 16:00:21 +0000 (UTC)
Received: from 8bytes.org (p549ad69d.dip0.t-ipconnect.de [84.154.214.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id B895E2623AF;
	Fri, 13 Jan 2023 17:00:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1673625620;
	bh=6UgEeZfypijkoo3PztRyuMsS24lvtANyFUKlMuqxB9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NuMaFOnEefXYbug3xL8t5rtQ7Y8hK0ej/NBtOdLF41bwQ6y/yEDDZFEUQsJ7hKxl0
	 ksBwC0nP3Yqo1TC0LgKxhGOn31MVF+vhNSFAeSQSKRNg/kV1FjaNfCT5EGX7L6ygla
	 ymEoPwGAPNms1+Z5+o6TCcYmGUG40G811D1SbZCUmnpt+2MFc+u0CI/Cz2RyAw1ozR
	 NdhCGVYdKl8+pnDzLBRlxpDh2ZscQSLn/q9+ItvIA+guSQQKbWbm3klK3YNGZOJdAX
	 A4lXgYI+Sp0QOnH+Afd/bntSOw2kgA2hPhzvl2206s1LjFPxLbFLyYDG/bJnhvtljT
	 +X5OPOQ4PfUUQ==
Date: Fri, 13 Jan 2023 17:00:19 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] iommu: Tidy up io-pgtable dependencies
Message-ID: <Y8GAE09nkUv8NwOr@8bytes.org>
References: <51d8c78e2ecc6696ac5907526580209ea6da167f.1673553587.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51d8c78e2ecc6696ac5907526580209ea6da167f.1673553587.git.robin.murphy@arm.com>

On Thu, Jan 12, 2023 at 07:59:47PM +0000, Robin Murphy wrote:
>  drivers/iommu/Kconfig | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)

Applied, thanks Robin.
