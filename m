From: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v4 12/20] iommu/tegra: gart: Integrate with Memory
 Controller driver
Date: Mon, 24 Sep 2018 21:22:59 +0300
Message-ID: <b2d283fc-ff52-3166-cd70-42f9cba93948@gmail.com>
References: <20180924004153.8232-1-digetx@gmail.com>
 <20180924004153.8232-13-digetx@gmail.com> <20180924102322.GI21032@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180924102322.GI21032@ulmo>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Joerg Roedel <joro@8bytes.org>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, Rob Herring <robh+dt@kernel.org>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 9/24/18 1:23 PM, Thierry Reding wrote:
> On Mon, Sep 24, 2018 at 03:41:45AM +0300, Dmitry Osipenko wrote:
>> The device-tree binding has been changed. There is no separate GART device
>> anymore, it is squashed into the Memory Controller. Integrate GART module
>> with the MC in a way it is done for the SMMU of Tegra30+.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/iommu/Kconfig      |  1 +
>>  drivers/iommu/tegra-gart.c | 98 ++++++++++----------------------------
>>  drivers/memory/tegra/mc.c  | 41 ++++++++++++++++
>>  include/soc/tegra/mc.h     | 27 +++++++++++
>>  4 files changed, 93 insertions(+), 74 deletions(-)
> 
> I think this could technically have been two patches, but since they'd
> have a compile-time dependency either way they need to be applied in the
> correct order, so some coordination between IOMMU and Tegra trees is
> going to have to happen anyway and might as well just stick this into a
> single patch.

I assume that Joerg will take the whole series once it's ready (no?),
hence your ACK will be needed here and in other patches.
