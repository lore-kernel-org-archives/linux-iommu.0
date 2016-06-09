From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [RFC PATCH 15/15] iommu/exynos: update to use iommu big-endian
Date: Thu, 9 Jun 2016 09:14:31 +0100
Message-ID: <f3c322a3-b474-ff46-7be3-8fa9c069a51b@codethink.co.uk>
References: <20160608183110.13851-1-matthew@mattleach.net>
 <20160608183110.13851-16-matthew@mattleach.net>
 <338cbdc6-2830-813b-713e-1cc40d23d1f9@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <338cbdc6-2830-813b-713e-1cc40d23d1f9@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>, Matthew Leach <matthew@mattleach.net>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>, Kukjin Kim <kgene@kernel.org>, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On 09/06/16 07:51, Marek Szyprowski wrote:
> Hi
> 
> 
> On 2016-06-08 20:31, Matthew Leach wrote:
>> From: Ben Dooks <ben.dooks@codethink.co.uk>
>>
>> Add initial support for big endian by always writing the pte
>> in le32. Note, revisit if hardware capable of doing big endian
>> fetches.
>>
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> 
> Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
> 
> Just to keep my curiosity satisfied - what's the reason to use
> big-endian on ARM?

Because we can. It was interesting to try.

> Good luck with fixing the kernel and userspace codes, which usually
> assume little-endian is the only possible order!

We did a BE8 build of the baserock userspace a year or two ago
and found mostly it just worked. I think Matt is using that image
for testing the work he's been doing.

I've no idea if we would ever bother trying to build Debian for BE8
or similar, as not sure it would be worth trying.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
