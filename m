Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.101.131.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795068775;
	b=t5I6Mci818xnRlR44ocVd6zdqx8DcZnUg+XdFOzFmQf6TlviUx9sdR8FApaf/k2gRbe0
	 zbl+zByJYRxB4jjkC0geRSj77/owUS5I1c6W/sUUwPOI07gq4J3WyGX9d4OwJmoxByg/f
	 z+Jbtivr4yHfbzzYpjesA1jcfvI7oJIgIFcrQzHFfbBUjEaoA4IU5EuOYghdiOOnqjUKq
	 goEeyIEMjf1AF+p9HvVh+un9xy4tE/zzZTGH7ejObiNDi/GH6v97EzS9Iax5EVdKZHFWe
	 Ozwn4oqmOcVjMy8JtrSsMOVwKIHDJpmYjeQnitCtW5RHkB9bNXDr6rfTmEetOeE0PnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795068775;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=xuH/DsH2B3m/szVpUJ5yxwbb7c6XFDflQWGSrQEmBsg=;
	b=s0rrhjLhIpbO/ou/C8J4F8lIYckZ98w0OgjH90geoteZeizkMEXYC7hKkEhT9zTsDDDL
	 HeZeaJuX+ifBdHWZrWA7DumLqKvKYc53iMGZOGiylS81Cx9wWPV/S6n2qTnqdOnJZ6UcK
	 DHX/hYtnkL5tjLN3V0Igdp3IOSajfCDm+f+3w/XTkKq0e0lZ9je2KjzJjJ8CRvOnMXUbl
	 WDw/dnAS/ctPxpC8qFdHcgetmEW+KnDbRhAsZhS9gWzRONH6EMheUbQFDpCU4e0ftS10+
	 oEJ1etMnBi2Q+nGKkXh0O3lVepYCgnKy5R/SvBqTCLRLq6zswi/iXwzUeiAj1fU89Ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=citrix.com;
	spf=pass smtp.mailfrom=citrix.com;
	arc=none smtp.remote-ip=160.101.131.9
Received: from na1pdmzitismtp02.tibco.com (na1pdmzitismtp02.tibco.com [160.101.131.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF38606A325
	for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 06:12:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABF38606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=citrix.com
Received: from cdev-nkg (unknown [10.113.40.46])
	by na1pdmzitismtp02.tibco.com (Postfix) with ESMTP id 7FC20852A6EF;
	Thu, 19 Nov 2026 01:11:23 -0500 (EST)
From: Lin Liu <lin.liu01@citrix.com>
To: jgross@suse.com,
	ross.lagerwall@citrix.com
Cc: sstabellini@kernel.org,
	oleksandr_tyshchenko@epam.com,
	andrew.cooper3@citrix.com,
	xen-devel@lists.xenproject.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xen/swiotlb: Check the segment boundary in range_straddles_page_boundary()
Date: Thu, 19 Nov 2026 06:12:48 +0000
Message-ID: <20261119061248.2016804-1-lin.liu01@citrix.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <8262d7e0-75e8-4bc0-932d-1d4e40b716de@suse.com>
References: <807c3b040b02d7d89f1cac76eb137afbee91015d.1794573814.git.lin.liu01@citrix.com> <75f37608-f3ef-48db-8e7b-4a1ba13a9ee0@citrix.com> <8a57f3f6-c649-4be0-8e14-2cc16dd41f8f@suse.com> <20261119043504.2013850-1-lin.liu01@citrix.com> <8262d7e0-75e8-4bc0-932d-1d4e40b716de@suse.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 19/11/2026 05:59, Jürgen Groß wrote:
> Could you please add a comment to the alloc_coherent path that the check
> isn't needed there due to the alignment guaranteed by __get_free_pages()?

Sure, will do in v2.

Lin
