Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3AC8F40;
	Mon, 11 Sep 2023 22:00:27 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA3971007;
	Mon, 11 Sep 2023 15:01:03 -0700 (PDT)
Received: from [10.57.0.19] (unknown [10.57.0.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A98F3F5A1;
	Mon, 11 Sep 2023 15:00:25 -0700 (PDT)
Message-ID: <15a0de3a-086a-b30d-0512-02e3bbf69662@arm.com>
Date: Mon, 11 Sep 2023 23:00:18 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] iommu/sun50i: Allow page sizes between 4K and 1M
Content-Language: en-GB
To: =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@gmail.com>,
 joro@8bytes.org, will@kernel.org
Cc: wens@csie.org, samuel@sholland.org, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20230911190218.1758812-1-jernej.skrabec@gmail.com>
 <40649946-739b-fec6-d743-f7828613fec5@arm.com> <5707055.DvuYhMxLoT@archlinux>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <5707055.DvuYhMxLoT@archlinux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2023-09-11 20:29, Jernej Škrabec wrote:
> On Monday, September 11, 2023 9:06:12 PM CEST Robin Murphy wrote:
>> On 2023-09-11 20:02, Jernej Skrabec wrote:
>>> While peripheral supports only 4K page sizes, we can easily emulate
>>> support for bigger page sizes, up to 1M. This is done by making multiple
>>> entries in map function or clearing multiple entries in unmap.
>>
>> No, it's done by converting over to the {map,unmap}_pages ops. There's
>> no need to resurrect this horrible bodge.
> 
> Missed those, thanks! In any case, logic to implement those isn't that
> different than here.

Indeed, if anything it should be even simpler since you don't need to 
worry about specific sizes at all - any tricky boundary you don't want 
to iterate through, just return short at that point and let the core 
call you back again with the remainder.

(In fact this reminds me one of the low-priority cleanup jobs 
outstanding was to trivially convert all the remaining drivers and 
retire the old interfaces altogether)

Cheers,
Robin.
