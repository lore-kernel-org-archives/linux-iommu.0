Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947BF360;
	Tue,  6 Jun 2023 05:33:36 +0000 (UTC)
Received: from [IPV6:2a0c:5a83:9203:ad00:6f2e:82dd:9a04:a2e5] (unknown [IPv6:2a0c:5a83:9203:ad00:6f2e:82dd:9a04:a2e5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: rcn)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 964B666003B1;
	Tue,  6 Jun 2023 06:33:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1686029614;
	bh=jW2QzKdWyriO8SRFnigos0KPZxwCwcXsEMTvj9Md6oI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZRbuJWBWca2FwsExoZmlnThqAcRp/hU91IPhB2QDUuHdsyh7E6zMjKG82D19xYuKh
	 pH3zfzJEJFawm6vvVh5NOf/oC0NFFdHgpyOTeeXjt/u4+uhzxhnYNkAdhm7r4bC0gW
	 HC2dAgEdbcETm3LJqwrAiaAIcys4TKkhBc78dky9RtemIzANITTVeC6NaXHCmVmoev
	 HoOehKq6SwJJUxTCXMCREatoNJaYh3NrxAhV+eqgKACRE3Qq9j734RUB9bfFrk94fJ
	 diHB5L5+mDgyUKzC/vYkNZxExG5t6NqFTKdHxf67wcc2IXgrVdBPXIl/k4lRLXShyo
	 YHzEQeQ5qh0Hg==
Message-ID: <6561c295-f98b-8930-9368-1a225acdca16@collabora.com>
Date: Tue, 6 Jun 2023 07:33:30 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 10/17] iommu: Do iommu_group_create_direct_mappings()
 before attach
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Yong Wu <yong.wu@mediatek.com>, linux-mediatek@lists.infradead.org
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
 llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>,
 Lu Baolu <baolu.lu@linux.intel.com>, Heiko Stuebner <heiko@sntech.de>,
 Kevin Tian <kevin.tian@intel.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Niklas Schnelle <schnelle@linux.ibm.com>
References: <0-v5-1b99ae392328+44574-iommu_err_unwind_jgg@nvidia.com>
 <10-v5-1b99ae392328+44574-iommu_err_unwind_jgg@nvidia.com>
 <20230605070959.moupivvi7wr4nibu@rcn-XPS-13-9305>
 <ZH3nXbVFR6JfUKpV@nvidia.com> <01dee34c-5663-22f4-0d88-90f87b1fe879@arm.com>
From: =?UTF-8?Q?Ricardo_Ca=c3=b1uelo?= <ricardo.canuelo@collabora.com>
In-Reply-To: <01dee34c-5663-22f4-0d88-90f87b1fe879@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

On 5/6/23 16:00, Robin Murphy wrote:
> The log says it's next-20230530 - the fix you're seeing there from commit b3fc95709c54 landed 2 days later :)

Thanks for checking that out Robin, KernelCI still hasn't run
that build but I tested it manually and the issue is not there
anymore.

#regzbot fix: b3fc95709c54

Cheers,
Ricardo
