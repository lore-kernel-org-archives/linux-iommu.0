Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A947E
	for <iommu@lists.linux.dev>; Wed,  7 Sep 2022 08:38:45 +0000 (UTC)
Received: from 8bytes.org (p4ff2bb62.dip0.t-ipconnect.de [79.242.187.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 54BC52409B6;
	Wed,  7 Sep 2022 10:38:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1662539924;
	bh=nOn6shJVTZ6sNK9EG+u/jFwGvsp+qz77qiGYk51nsWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2ndHMTTwS1xKk76GeUchpnoKHAigOAQZIQS/NYfDoDKNXR6BMa2PV74/w5+cC9N9c
	 TJ7dH/90A/IBjaUnjW+t42pV3X769VFh98qZo8x9bK7yPcR+i1v0+jqwJuv1kpiFcn
	 w54W8Ajh2bIDy9LgdjLuM/GZka/84tZNWsz6B7LT1N4tkYhU3ODusroJTeMQlQpnF+
	 EuAmfa+JXHVvIOsDeoCn+l9D8xkcfmmGWMeIz3O4N8JgN7J5JzoMXp9jdy1d6A/J5d
	 bQnBvN/FWcUdz1hY9DtaBMSrttQIamN7XPsg7JxMfQMRxQFeFgUg1diQK782R2mIjO
	 UHrUsTEk/738w==
Date: Wed, 7 Sep 2022 10:38:43 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Joerg Roedel <jroedel@suse.de>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v1 1/1] iommu/virtio: Do not dereference fwnode in struct
 device
Message-ID: <YxhYkzApbU7Wm2Kb@8bytes.org>
References: <20220801165142.20898-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801165142.20898-1-andriy.shevchenko@linux.intel.com>

On Mon, Aug 01, 2022 at 07:51:42PM +0300, Andy Shevchenko wrote:
>  drivers/iommu/virtio-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.
