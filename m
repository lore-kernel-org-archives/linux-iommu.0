From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] perf/x86/amd: Adding support for new IOMMU performance
 event
Date: Mon, 14 Dec 2015 16:05:42 +0100
Message-ID: <20151214150542.GD11292@8bytes.org>
References: <1449874397-27056-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1449874397-27056-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Dec 11, 2015 at 04:53:17PM -0600, Suravee Suthikulpanit wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> This patch adds new IOMMU performance event based on
> the information in table 74 of the AMD I/O Virtualization Technology
> (IOMMU) Specification (Document Id: 4882, Rev 2.62, Feb 2015)
> 
> Link: http://support.amd.com/TechDocs/48882_IOMMU.pdf
> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> ---
>  arch/x86/kernel/cpu/perf_event_amd_iommu.c | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Joerg Roedel <jroedel@suse.de>
Acked-by: Joerg Roedel <jroedel@suse.de>

> 
> diff --git a/arch/x86/kernel/cpu/perf_event_amd_iommu.c b/arch/x86/kernel/cpu/perf_event_amd_iommu.c
> index 97242a9..86f8259 100644
> --- a/arch/x86/kernel/cpu/perf_event_amd_iommu.c
> +++ b/arch/x86/kernel/cpu/perf_event_amd_iommu.c
> @@ -118,6 +118,11 @@ static struct amd_iommu_event_desc amd_iommu_v2_event_descs[] = {
>  	AMD_IOMMU_EVENT_DESC(cmd_processed,           "csource=0x11"),
>  	AMD_IOMMU_EVENT_DESC(cmd_processed_inv,       "csource=0x12"),
>  	AMD_IOMMU_EVENT_DESC(tlb_inv,                 "csource=0x13"),
> +	AMD_IOMMU_EVENT_DESC(ign_rd_wr_mmio_1ff8h,    "csource=0x14"),
> +	AMD_IOMMU_EVENT_DESC(vapic_int_non_guest,     "csource=0x15"),
> +	AMD_IOMMU_EVENT_DESC(vapic_int_guest,         "csource=0x16"),
> +	AMD_IOMMU_EVENT_DESC(smi_recv,                "csource=0x17"),
> +	AMD_IOMMU_EVENT_DESC(smi_blk,                 "csource=0x18"),
>  	{ /* end: all zeroes */ },
>  };
>  
> -- 
> 1.9.1
> 
