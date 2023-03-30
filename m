Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFA61105
	for <iommu@lists.linux.dev>; Thu, 30 Mar 2023 01:14:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B56DDC433EF;
	Thu, 30 Mar 2023 01:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1680138849;
	bh=FFWdFB2zI6gVwnEprnMCPpcJkq040yxf+K1pV1kS8y0=;
	h=Date:From:To:Cc:Subject:From;
	b=tbsjd8YmKRFVJzHSLXUv5UFhpKKrDJArVE+bxCIkfED6Ol1+L5kWKhkToD0PWR3Cm
	 dhfkjHXwp6LtSGs81ieODh/eZYW7vxjYQL3QzBTG3COitoi95Yjk7uSaUYfR3F5sv9
	 74UJ1CyoWxd2ClQ8EtUGP+NXs4No7J3jVzHF1ArhJjNFAgSjJggN4P4x3i3w91L8z2
	 puvamb1UVtIwq7T5N3EH/xL7w4fS4ChwIfRxuKlfnH/bpJTICJhf3GrRF7TPAjrGQe
	 NW4O6gnErYCOaY+R5cmuES42Gw0J+2SD7q9qIQ8N2nkHkoTl6gIvVNM7xUzuDXaMOk
	 Qhf9fIQLspAaw==
Date: Wed, 29 Mar 2023 18:14:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit
 <suravee.suthikulpanit@amd.com>
Cc: iommu@lists.linux.dev, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Willem de Bruijn <willemb@google.com>, Saeed
 Mahameed <saeed@kernel.org>
Subject: AMD IOMMU problem after NIC uses multi-page allocation
Message-ID: <20230329181407.3eed7378@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Joerg, Suravee,

I see an odd NIC behavior with AMD IOMMU in lazy mode (on 5.19).

The NIC allocates a buffer for Rx packets which is MTU rounded up 
to page size. If I run it with 1500B MTU or 9000 MTU everything is
fine, slight but manageable perf hit.

But if I flip the MTU to 9k, run some traffic and then go back to 1.5k 
- 70%+ of CPU cycles are spent in alloc_iova (and children).

Does this ring any bells?
