From: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v6 00/21] IOMMU: Tegra GART driver clean up and
 optimization
Date: Wed, 12 Dec 2018 15:49:35 +0300
Message-ID: <e0eee0b5-5513-6f38-7b18-ca7a00255ff6@gmail.com>
References: <20181209202950.31486-1-digetx@gmail.com>
 <20181211095317.tv43aaefnsezmic7@8bytes.org> <20181212102415.GM15092@ulmo>
 <20181212104331.GW16835@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181212104331.GW16835@8bytes.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 12.12.2018 13:43, Joerg Roedel wrote:
> Hi Thierry, Hi Dmitry,
> 
> On Wed, Dec 12, 2018 at 11:24:15AM +0100, Thierry Reding wrote:
>> So appart from the one issue in the "memory controller integration"
>> patch this looks good and I've acked the remaining patches. Once the one
>> remaining issue is fixed I think this is ready to be merged.
>>
>> Joerg, given the dependencies between the various parts of the series, I
>> think it may be better for you to merge everything through the IOMMU
>> tree if you don't mind.
> 
> Sounds good. Dmitry, can you please address Thierry's comments on patch
> 13, add his Acks on the other patches and re-send? I'll queue it in the
> iommu-tree then.

Sure, thanks to you both!
