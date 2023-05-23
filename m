Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0AE1B908
	for <iommu@lists.linux.dev>; Tue, 23 May 2023 06:19:45 +0000 (UTC)
Received: from 8bytes.org (p200300c2773e310086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:773e:3100:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 73B1724819E;
	Tue, 23 May 2023 08:19:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1684822784;
	bh=kk/rFcdM8uF58TGv8EhNODC2C+pt9UnXaiEp3keQBfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=palNgPOeKPv3PXx6QZMklOulatBhRHQxs5jXZngY/YtcLVHszbcxq5C/iJ6TmHN2Q
	 q/MBLKy5BSIlMsm861xR7QindUM9cASw3BaJtUrTNzfm2twD07Pou1BPHzk+P5gREe
	 FPBH6lkebIpLRmnvt0MIGkg9QeV5MMDd4JMSPPxuISOJBe6T/Po/aImOyupkuEBP4h
	 pOvPMWfTqujYlQK/7esSoE0aHcq3yg6FF2L5igVq16BpgFRJrI7CQ4yuWYo4hSJZlh
	 MME1iV727/sAqz7drmziV/yaxg/SZDYBu8QiOJrMgLOuP2gQPtAA30NLXMwHZeOIi5
	 /L9T6MXTddJbA==
Date: Tue, 23 May 2023 08:19:43 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: will@kernel.org, robin.murphy@arm.com, eric.auger@redhat.com,
	virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
	akihiko.odaki@daynix.com
Subject: Re: [PATCH v2 0/2] iommu/virtio: Fixes
Message-ID: <ZGxa_-jkf1olFYXK@8bytes.org>
References: <20230515113946.1017624-1-jean-philippe@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515113946.1017624-1-jean-philippe@linaro.org>

On Mon, May 15, 2023 at 12:39:46PM +0100, Jean-Philippe Brucker wrote:
> One fix reported by Akihiko, and another found while going over the
> driver.
> 
> Jean-Philippe Brucker (2):
>   iommu/virtio: Detach domain on endpoint release
>   iommu/virtio: Return size mapped for a detached domain
> 
>  drivers/iommu/virtio-iommu.c | 57 ++++++++++++++++++++++++++----------
>  1 file changed, 41 insertions(+), 16 deletions(-)

Applied, thanks.
