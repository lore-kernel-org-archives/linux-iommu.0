From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2 3/6] iommu/amd: Introduce amd_iommu_get_num_iommus()
Date: Thu, 7 Jan 2016 13:15:51 +0100
Message-ID: <20160107121550.GE19149@8bytes.org>
References: <1451672020-2150-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1451672020-2150-4-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1451672020-2150-4-git-send-email-Suravee.Suthikulpanit@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: bp@alien8.de, peterz@infradead.org, mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Jan 01, 2016 at 12:13:37PM -0600, Suravee Suthikulpanit wrote:
> +int amd_iommu_get_num_iommus(void)
> +{
> +	return amd_iommus_present;
> +}
> +EXPORT_SYMBOL(amd_iommu_get_num_iommus);

Is this export needed? The perf code can't be build as a module.

Otherwise it looks good.
