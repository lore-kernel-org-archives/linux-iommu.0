Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0887B1FBE8A
	for <iommu@lists.linux.dev>; Fri, 11 Jul 2025 14:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752244796; cv=none; b=tRVpPT5tBbUqNCYhyfFvLcRkYX81Q2/ek3o7eguZpflOgazDNc7eNsA7IU92T68er2j4wTjqg+LO9xE3Suqr3GNcyfPd+FpKFrtgR/tFk4xl1Fkw4ZbCWB9UJGqn/NC5NuBMuyCEACjkCAzMea6XzNw2SHtmn6KBcIc02/1eGJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752244796; c=relaxed/simple;
	bh=6AOIsIB3pyeQbmfZDgyv3i7yQmjnugb9ayp2v9EWghg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=un/SBcqvfjAG2pISji+Qj/BSugTlINzhHNDA+cPUj74E/1sLvUa+kMjgcfbhcttdsTisiyC0qZpV1wHktBvVyHCBWRikiRs6sPkOlTW/fKCfMF2bJDnRMHIQvViLLMAOa49txOM2D2rhcpmdpZzZToGCNGmTkzgR3yCYv0d53ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=NOARghuh; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="NOARghuh"
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 6738B503D5;
	Fri, 11 Jul 2025 16:39:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1752244787;
	bh=6AOIsIB3pyeQbmfZDgyv3i7yQmjnugb9ayp2v9EWghg=;
	h=Date:From:To:Cc:Subject:From;
	b=NOARghuhLKzT9RCk8N409b6flFkR5WnuZ9e9F7fP1b3BxOTvnzqXycgzmS+LZ8HvF
	 9h4N9f+t8Dsc3XcR1HfTM/R2CV2LsC/rNHwa6qvjxZXE5MVsxzyZWHfjlj/+joqkJ1
	 +KkknW4lpfKRvbW2WjgtxfetAJR5AJHBonUIUnm0sCEg8KgcKGk8gcylaKBxPPotEo
	 wq+rlCToYHI0W56eqUZfRY8nZoQZ+kdqoQ+IalVgwPvOuu1dU8tOunI8c3Q9f9eSE8
	 hUcuRmpFM4WQD5eFiFIaHn0LgbVbDrqQuosdZBvYmIC7jf/Us2GWqdxWXkNQZlQJ3G
	 Bh4RIjtO2l5Bg==
Date: Fri, 11 Jul 2025 16:39:46 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: iommu@lists.linux.dev
Cc: Lu Baolu <baolu.lu@linux.intel.com>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@nvidia.com>, Will Deacon <will@kernel.org>
Subject: Off for two weeks
Message-ID: <ojjm5wbqi44t5v2qo752u7q36uvbrda7au5coskjbnxgaom6t5@ebbfcm7zmwfa>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

Just a note that I will be out for the next two weeks and not do any updates to
the IOMMU tree. Will Deacon thankfully takes over during this time, so please
send everything his way :) I will be back on July 28th.

Cheers,

	Joerg
