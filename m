Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147D779C5
	for <iommu@lists.linux.dev>; Tue, 28 Mar 2023 13:42:23 +0000 (UTC)
Received: from 8bytes.org (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 88A31243A61;
	Tue, 28 Mar 2023 15:42:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1680010942;
	bh=GInBziKvtEogBV1elNmgxf142ivXpDC0HtkgqB8iyuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=soO+PB/HbalbOwJ4qmES6cmHSZT9LGYy0TkPprp/o2qXYJNV4/P/W+fLbqC4m2glB
	 73WN06/Wx0eIf3Zn3W98rV437FLs/xBAWj9Y+Y5sMYWLMxRbGB/9JmB7REvitEZNaC
	 wbzx8Hdxl9q4lK8tkzXEbZkNw3GFpTWdUbN2ylh0aSd67Wts6gfLid1cDpfoRBquhi
	 XRDtk/+49gYfij/i9fcqZrwdPT+jANOdjUFzW9SBiX508DMrRc0D4b1t2oeXRM5h9G
	 ukpvJmu65iYfxr17Dk03H4byw/ucBO0bINM5HIrHNd7IXijh0swKr5Nai1bVQSlmBH
	 EqSaTZaKsOnFw==
Date: Tue, 28 Mar 2023 15:42:21 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Will Deacon <will@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
	Jon Nettleton <jon@solid-run.com>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	kernel@pengutronix.de
Subject: Re: [PATCH 01/10] iommu/arm-smmu: Drop if with an always false
 condition
Message-ID: <ZCLuvQv3wzG+SLZh@8bytes.org>
References: <20230321084125.337021-1-u.kleine-koenig@pengutronix.de>
 <20230321084125.337021-2-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230321084125.337021-2-u.kleine-koenig@pengutronix.de>

On Tue, Mar 21, 2023 at 09:41:16AM +0100, Uwe Kleine-König wrote:
> The remove and shutdown callback are only called after probe completed
> successfully. In this case platform_set_drvdata() was called with a
> non-NULL argument and so smmu is never NULL. Other functions in this
> driver also don't check for smmu being non-NULL before using it.
> 
> Also note that returning an error code from a remove callback doesn't
> result in the device staying bound. It's still removed and devm allocated
> resources are freed (among others *smmu and the register mapping). So
> after an early exit to iommu device stayed around and using it probably
> oopses.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu.c | 6 ------
>  1 file changed, 6 deletions(-)

Need an ack or review by either Will or Robin on this patch.

Regards,

	Joerg
