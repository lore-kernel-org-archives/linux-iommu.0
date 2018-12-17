From: Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH 2/9] ACPI/IORT: Use helper functions to access
 dev->iommu_fwspec
Date: Mon, 17 Dec 2018 17:17:56 +0800
Message-ID: <20f1319b-c9f7-888c-51f8-31ead4c58dde@huawei.com>
References: <20181211121910.5604-1-joro@8bytes.org>
 <20181211121910.5604-3-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181211121910.5604-3-joro@8bytes.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Rob Clark <robdclark@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
List-Id: iommu@lists.linux-foundation.org

On 2018/12/11 20:19, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Use the new helpers dev_iommu_fwspec_get()/set() to access
> the dev->iommu_fwspec pointer. This makes it easier to move
> that pointer later into another struct.
> 
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  drivers/acpi/arm64/iort.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)

Acked-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
