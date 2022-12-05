Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55537C
	for <iommu@lists.linux.dev>; Mon,  5 Dec 2022 12:36:00 +0000 (UTC)
Received: from 8bytes.org (p5b00664c.dip0.t-ipconnect.de [91.0.102.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 5673D220316;
	Mon,  5 Dec 2022 13:35:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1670243759;
	bh=JmjGyGgFbEPCHfCKnomLro85Cn13iOUcjUEX60upBhw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2gEWG5PZW7/JK/XVunOJxtWTX99r1jC8p4WwNLWWyCTadLkF4intiLocaQgjl9FEI
	 YOY5dIgmnr9N2KcIHFdsnyAFZpr0p/yPl80INWMKLmkuv7fJFAmZasli4TwWNOCoD+
	 o0u7nIL4BGXfjVppE6XjhYtDzFkssHepXW9HUZuDIe47/8J7w19HpiuQsu7jfhb9Nn
	 8W+neZP4cWxfJP0X5TgMPIh4iUuxOeAR6wdVblgxOCVk6S4RR+2Q9nq/BVfBGsJgek
	 OR6o6+ejWSUb54auqEPQCeC7Pa3AMITBXE5GKzCjx8McNEbJd4fhQnQJfnVF5S0tia
	 Rxy6pUflmC18Q==
Date: Mon, 5 Dec 2022 13:35:58 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>,
	LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Raj Ashok <ashok.raj@intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	Yuzhang Luo <yuzhang.luo@intel.com>
Subject: Re: [PATCH v3] iommu/vt-d: Add a fix for devices need extra dtlb
 flush
Message-ID: <Y43lrlOGNm7XdyZ7@8bytes.org>
References: <20221130062449.1360063-1-jacob.jun.pan@linux.intel.com>
 <Y43LUVS1heMxGBC7@8bytes.org>
 <b64c5b16-79bd-182d-354b-73a74430a8cc@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b64c5b16-79bd-182d-354b-73a74430a8cc@linux.intel.com>

On Mon, Dec 05, 2022 at 06:59:19PM +0800, Baolu Lu wrote:
> But this patch has already been merged in v6.1-rc7.
> 
> https://lore.kernel.org/linux-iommu/Y4oF8e7quzjm2kzD@8bytes.org/

Ah right, Linus did pull it. I though it wasn't pulled because I didn't
get a bot message about it. I will merge the fix.

Thanks,

	Joerg
