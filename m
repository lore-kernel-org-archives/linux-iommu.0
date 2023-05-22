Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D340514AA9
	for <iommu@lists.linux.dev>; Mon, 22 May 2023 15:39:14 +0000 (UTC)
Received: from 8bytes.org (p200300c2773e310086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:773e:3100:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id C828E2434D7;
	Mon, 22 May 2023 17:39:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1684769953;
	bh=n+8sDh7ZCWBHnADUqNRq+iXfL3Ttwr2xopem+ZmkQ6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iG6jVFsxIJGn3t1cYdEx2mIRkvXP/AfeWAYHCqNw3t9EvR5EnEfyPJ/huAPw3PrfT
	 iACKC+nCWneSG5S3TcDVojotJit+ytT2ulc6y0gHn3oHqakubAoT/X1ku7XQchNAeW
	 OYgwXf8WaAWbK6E9L9cRxLVKsn+wUWlqEZO560asedvilplL7FLqgTKzmUSddF4QTD
	 DsjR+uFVaH+MK5vrWAn7zBI6OtcYK8yePt1iv5yQYefJ0QtyadcNHDEeamj3Pq74Hh
	 NWGziWUpAA3zIx36SjRNAKdV4n96FhWP7IZJg0lmPMI+5PedHvfHHu2ttHAenaKW1E
	 RWwzqCqtuU1YQ==
Date: Mon, 22 May 2023 17:39:12 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: jgg@nvidia.com, will@kernel.org, schnelle@linux.ibm.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] iommu: Make flush queues a proper capability
Message-ID: <ZGuMoMec48zUeYkH@8bytes.org>
References: <cover.1683233867.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1683233867.git.robin.murphy@arm.com>

On Thu, May 04, 2023 at 10:10:54PM +0100, Robin Murphy wrote:
> Robin Murphy (2):
>   iommu: Add a capability for flush queue support
>   iommu: Use flush queue capability

Applied, thanks Robin.
