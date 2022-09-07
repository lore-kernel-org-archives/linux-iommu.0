Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E697E
	for <iommu@lists.linux.dev>; Wed,  7 Sep 2022 08:45:46 +0000 (UTC)
Received: from 8bytes.org (p4ff2bb62.dip0.t-ipconnect.de [79.242.187.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 7C8B42405F1;
	Wed,  7 Sep 2022 10:37:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1662539867;
	bh=8IVdbekt/J76mnSaLtAMZgVjG1Z8HFBk+8tCH/hMZgA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=3xo0tMnN+UbnHuyXz3bbgyPKTxFDnThHyxZ+zHV8YVIECtquvuHZvA7SEXRiXIoFI
	 VGQQqPEmPH2tWYiZgonsbmT+8nC9xAR6zFCQ9YbWoGoyYa7dJr4ak1MQAzQ4Oj4ewT
	 raMuaO4igCgGwxeUZbsfspKOLrwXykSSzlZRJSPcAAgYGVq0CJTy5PZu1jVvOxP+Fs
	 7+UAAAEn/vrm4NDG8mr51cPiuw5lxj8qlMAut5+ym4YpmrdVQGGs3uX4nExaAtHBT7
	 CIsBv/xgaQtW/sgXMjEtz/aHFKZUFKyeUKUnRUwNMDVLaLravWGUSsyKtCOGU7G49P
	 fmKge2JVIHwPg==
Date: Wed, 7 Sep 2022 10:37:46 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Joerg Roedel <jroedel@suse.de>, Lu Baolu <baolu.lu@linux.intel.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v1 1/1] iommu: Do not dereference fwnode in struct device
Message-ID: <YxhYWlbHPNdI4n//@8bytes.org>
References: <20220801164758.20664-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801164758.20664-1-andriy.shevchenko@linux.intel.com>

On Mon, Aug 01, 2022 at 07:47:58PM +0300, Andy Shevchenko wrote:
>  drivers/iommu/iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.
