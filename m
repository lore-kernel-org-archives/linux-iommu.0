Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B3E273C3
	for <iommu@lists.linux.dev>; Tue, 26 Sep 2023 12:01:40 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4CC951FB;
	Tue, 26 Sep 2023 05:02:12 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0AE833F6C4;
	Tue, 26 Sep 2023 05:01:32 -0700 (PDT)
Message-ID: <d88b244f-75b2-6b22-109e-7429b4c8d77c@arm.com>
Date: Tue, 26 Sep 2023 13:01:28 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 0/8] iommu: Clean up map/unmap ops
Content-Language: en-GB
To: Joerg Roedel <joro@8bytes.org>, =?UTF-8?Q?Jernej_=c5=a0krabec?=
 <jernej.skrabec@gmail.com>
Cc: will@kernel.org, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com,
 heiko@sntech.de, thierry.reding@gmail.com, vdumpa@nvidia.com
References: <cover.1694525662.git.robin.murphy@arm.com>
 <ZRFbbyxB0AwC-V_5@8bytes.org> <2360630.NG923GbCHz@jernej-laptop>
 <ZRKjI12cdRikwlTu@8bytes.org>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ZRKjI12cdRikwlTu@8bytes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26/09/2023 10:23 am, Joerg Roedel wrote:
> On Mon, Sep 25, 2023 at 05:33:58PM +0200, Jernej Škrabec wrote:
>> sun50i is meant to be placeholder (as mentioned in cover letter). It's
>> replaced by:
>> https://lore.kernel.org/linux-sunxi/20230912181941.2971036-1-jernej.skrabec@gmail.com/
> 
> Is the placeholder patch actually breaking the driver or just not
> optimal yet?

No functional issue, and TBH I think there's no harm in avoiding the 
dependency (I was kind of assuming you would pick this series to the 
core branch, so the "placeholder" status might extend that far too) - it 
should just mean that when you pick Jernej's patch to a topic branch 
you'll get a conflict merging it to core, and the correct resolution 
will be to take everything from that branch and replace my patch.

Cheers,
Robin.
