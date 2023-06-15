Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550F153BA
	for <iommu@lists.linux.dev>; Thu, 15 Jun 2023 09:39:14 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA20B1FB;
	Thu, 15 Jun 2023 02:39:57 -0700 (PDT)
Received: from [10.57.85.251] (unknown [10.57.85.251])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5317E3F71E;
	Thu, 15 Jun 2023 02:39:12 -0700 (PDT)
Message-ID: <685ec543-56d0-7a9c-4a15-3072746c2f91@arm.com>
Date: Thu, 15 Jun 2023 10:39:06 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] iommu: export iommu_set_default_translated function
Content-Language: en-GB
To: Anvesh Jain P <quic_ajainp@quicinc.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Venkata Rao Kakani <quic_vkakani@quicinc.com>,
 Vagdhan Kumar <quic_vagdhank@quicinc.com>
References: <20230615093308.24989-1-quic_ajainp@quicinc.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230615093308.24989-1-quic_ajainp@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-06-15 10:33, Anvesh Jain P wrote:
> export iommu_set_default_translated function to be used by other modules.

Which modules? The only reason these functions are public at all is to 
support the legacy x86 command-line options. No *new* code outside the 
core API should have any reason to be messing with core API policy. If 
an IOMMU driver needs to special-case particular devices we have 
.def_domain_type for that.

Thanks,
Robin.

> Signed-off-by: Anvesh Jain P <quic_ajainp@quicinc.com>
> Signed-off-by: Venkata Rao Kakani <quic_vkakani@quicinc.com>
> Signed-off-by: Vagdhan Kumar <quic_vagdhank@quicinc.com>
> ---
>   drivers/iommu/iommu.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index f1dcfa3f1a1b..1b4a5db58d66 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2730,6 +2730,7 @@ void iommu_set_default_translated(bool cmd_line)
>   		iommu_cmd_line |= IOMMU_CMD_LINE_DMA_API;
>   	iommu_def_domain_type = IOMMU_DOMAIN_DMA;
>   }
> +EXPORT_SYMBOL_GPL(iommu_set_default_translated);
>   
>   bool iommu_default_passthrough(void)
>   {
> 
> base-commit: b6dad5178ceaf23f369c3711062ce1f2afc33644
