Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F4E23B1
	for <iommu@lists.linux.dev>; Tue, 22 Nov 2022 13:06:22 +0000 (UTC)
Received: from 8bytes.org (p5b00664c.dip0.t-ipconnect.de [91.0.102.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id E35AB2A0308;
	Tue, 22 Nov 2022 14:06:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1669122381;
	bh=mCHSdsRwpuZh3QLwIr7aRxs1rgmxCwXJdIv+s3VxO8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xxbLxI04D5G7CG83YKavDCODaZnuz0lL0op3YelEbD6SqtpSxIRgSl8+4GYVCLgI+
	 7AXD0psUopYSwOTQJi0kDiWXZsamuh/cA5JVRX7XXqUr75wjb8LJwY05WQ6cdaqtEE
	 wXkC7Y+tYpp3ssEdc1kQannjDfQcSVjB8Aor8xIGKkBeTcfAVPPu+Aw0sdSoctOVAk
	 W8sJ04+9CFgx1B6R0Jt1IxlBQcPyyERQciUHcwznOH5+nIKNI9oPBlqLFDOMWrEsKy
	 mn9LgZkC9bFvw1QvpNSSAHp9lCREzte6pt8ijUZNgQKjk+VH1SX/XF/TtTezyDngcb
	 iehjUqgyAcqDw==
Date: Tue, 22 Nov 2022 14:06:19 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] [PULL REQUEST] Intel IOMMU updates for Linux v6.2
Message-ID: <Y3zJS3ueloJmie/G@8bytes.org>
References: <20221122002949.148140-1-baolu.lu@linux.intel.com>
 <Y3yRMXGPcYbXH9uL@8bytes.org>
 <25981cc9-243e-bece-4e85-86f3c880d96f@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25981cc9-243e-bece-4e85-86f3c880d96f@linux.intel.com>

On Tue, Nov 22, 2022 at 05:41:19PM +0800, Baolu Lu wrote:
> which was merged in v6.1-rc6. Can you please bring the x86/vt-d branch
> to v6.1-rc6, or do you want me to rebase that patch on the existing top
> of the branch?

Okay, moved the vt-d branch to be based on rc6 and applied these
changes. Thanks, Baolu!
