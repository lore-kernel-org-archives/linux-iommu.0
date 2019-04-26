From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] iommu/dmar: Use struct_size() helper
Date: Fri, 26 Apr 2019 09:58:22 -0500
Message-ID: <b7b18f6a-9f5b-7f01-a5d3-6f77faa57eb5@embeddedor.com>
References: <20190418184624.GA17025@embeddedor>
 <20190426144457.GH24576@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190426144457.GH24576@8bytes.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org



On 4/26/19 9:44 AM, Joerg Roedel wrote:
> On Thu, Apr 18, 2019 at 01:46:24PM -0500, Gustavo A. R. Silva wrote:
>> Make use of the struct_size() helper instead of an open-coded version
>> in order to avoid any potential type mistakes, in particular in the
>> context in which this code is being used.
>>
>> So, replace code of the following form:
>>
>> size = sizeof(*info) + level * sizeof(info->path[0]);
>>
>> with:
>>
>> size = struct_size(info, path, level);
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> Applied, thanks.
> 

Great. :)

Thanks, Joerg.
--
Gustavo
