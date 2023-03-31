Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4631FB1
	for <iommu@lists.linux.dev>; Fri, 31 Mar 2023 08:06:58 +0000 (UTC)
Received: from 8bytes.org (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id ACCEC244EFC;
	Fri, 31 Mar 2023 10:06:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1680250017;
	bh=89B8Z+Vvc0fsq53CV+d3qeFh5WYgM/QfWoN+C2pAxTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uHxgu3jkjaWw6pnZ3jXyQYMMKYypE0z9PSwZpb8GNc1UIpK2R8mCaEfWJDJSaUr3K
	 cZmdGV4fhUmyR2i6+jfKTKFvus1Q2BxSSV2FUPK9/aUKJBYrP2P+knEawug+C8ewCn
	 3EX6Iepu7waPRbC1gOs9FrrlNPkx6wUesp+x/AM9XkjSbc0K8m1CSSmJLgglDVGe+Q
	 raUpv68cf46Sw16s344r3sqPd4ZGk137jlyvUobD26JNeeFhDanejcBXw9UkqfpY1p
	 tIzzH/njp6NSlZK3ebP5FV5ndD9KlNv4xQ/mzWFLMniMxr5cPm17xqwbfWfbzwA6xe
	 0igxVYH3sYJXA==
Date: Fri, 31 Mar 2023 10:06:56 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] [PULL REQUEST] iommu/vt-d: Fixes for v6.3-rc4
Message-ID: <ZCaUoPMdgyWtPt2O@8bytes.org>
References: <20230329134721.469447-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329134721.469447-1-baolu.lu@linux.intel.com>

On Wed, Mar 29, 2023 at 09:47:18PM +0800, Lu Baolu wrote:
> Kan Liang (1):
>   iommu/vt-d: Fix an IOMMU perfmon warning when CPU hotplug
> 
> Lu Baolu (2):
>   iommu/vt-d: Remove unnecessary locking in intel_irq_remapping_alloc()
>   iommu/vt-d: Allow zero SAGAW if second-stage not supported

Queued to the fixes branch, thanks.
