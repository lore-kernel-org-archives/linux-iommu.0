From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 4/7] iommu/vt-d: Ignore domain parameter in
 attach_device if device requires identity map
Date: Fri, 15 Mar 2019 10:30:59 +0800
Message-ID: <acf363ab-1e77-d4fc-e66c-95069e182c1a@linux.intel.com>
References: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
 <83B82113-8AE5-4B0C-A079-F389520525BD@arista.com>
 <D8A19A7A-91CB-4297-9445-47DB248B7817@arista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <D8A19A7A-91CB-4297-9445-47DB248B7817@arista.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: James Sewart <jamessewart@arista.com>, iommu@lists.linux-foundation.org
Cc: baolu.lu@linux.intel.com, Tom Murphy <tmurphy@arista.com>, Dmitry Safonov <dima@arista.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi,

On 3/14/19 7:58 PM, James Sewart wrote:
> If a device requires an identity map then it is not safe to attach a
> domain that can remap addresses. Warn the user if this occurs.
> 
> Signed-off-by: James Sewart <jamessewart@arista.com>
> ---
>   drivers/iommu/intel-iommu.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 2e00e8708f06..104d36f225a7 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -5101,6 +5101,11 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
>   		}
>   	}
>   
> +	if (iommu_no_mapping(dev)) {
> +		dmar_domain = si_domain;
> +		dev_warn(dev, "VT-d: Device is required to use identity IOMMU mapping, ignoring domain attached\n");
> +	}

This is awful. :-)

IOMMU generic layer allocated a @domain and tries to bind the @domain
with a device. This code replaces @domain with si_domain without
notifying the upper layer.

Best regards,
Lu Baolu
