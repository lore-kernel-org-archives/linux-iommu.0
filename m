From: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 07/16] iommu/amd: Add IRTE invalidation routine
Date: Fri, 28 Sep 2012 10:20:18 -0400
Message-ID: <20120928142017.GE7483@localhost.localdomain>
References: <1348835046-3262-1-git-send-email-joerg.roedel@amd.com>
	<1348835046-3262-8-git-send-email-joerg.roedel@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1348835046-3262-8-git-send-email-joerg.roedel-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Sep 28, 2012 at 02:23:57PM +0200, Joerg Roedel wrote:
> Add routine to invalidate the IOMMU cache for interupt
> translations. Also include the IRTE caches when flushing all
> IOMMU caches.
> 
> Signed-off-by: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/iommu/amd_iommu.c       |   27 +++++++++++++++++++++++++++
>  drivers/iommu/amd_iommu_types.h |    1 +
>  2 files changed, 28 insertions(+)
> 
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index b6a8079..a2c1f7a 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -902,6 +902,13 @@ static void build_inv_all(struct iommu_cmd *cmd)
>  	CMD_SET_TYPE(cmd, CMD_INV_ALL);
>  }
>  
> +static void build_inv_irt(struct iommu_cmd *cmd, u16 devid)
> +{
> +	memset(cmd, 0, sizeof(*cmd));
> +	cmd->data[0] = devid;
> +	CMD_SET_TYPE(cmd, CMD_INV_IRT);
> +}
> +
>  /*
>   * Writes the command to the IOMMUs command buffer and informs the
>   * hardware about the new command.
> @@ -1023,12 +1030,32 @@ static void iommu_flush_all(struct amd_iommu *iommu)
>  	iommu_completion_wait(iommu);
>  }
>  
> +static void iommu_flush_irt(struct amd_iommu *iommu, u16 devid)
> +{
> +	struct iommu_cmd cmd;
> +
> +	build_inv_irt(&cmd, devid);
> +
> +	iommu_queue_command(iommu, &cmd);
> +}
> +
> +static void iommu_flush_irt_all(struct amd_iommu *iommu)
> +{
> +	u32 devid;
> +
> +	for (devid = 0; devid <= 0xffff; ++devid)

Should this be #define? Or perhaps based of sizeof?

Is there a specific reason that it is u16 in the build_inv_irt but here it is u32?

> +		iommu_flush_irt(iommu, devid);
> +
> +	iommu_completion_wait(iommu);
> +}
> +
>  void iommu_flush_all_caches(struct amd_iommu *iommu)
>  {
>  	if (iommu_feature(iommu, FEATURE_IA)) {
>  		iommu_flush_all(iommu);
>  	} else {
>  		iommu_flush_dte_all(iommu);
> +		iommu_flush_irt_all(iommu);
>  		iommu_flush_tlb_all(iommu);
>  	}
>  }
> diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
> index 1a7d480..b183306 100644
> --- a/drivers/iommu/amd_iommu_types.h
> +++ b/drivers/iommu/amd_iommu_types.h
> @@ -152,6 +152,7 @@
>  #define CMD_INV_DEV_ENTRY       0x02
>  #define CMD_INV_IOMMU_PAGES	0x03
>  #define CMD_INV_IOTLB_PAGES	0x04
> +#define CMD_INV_IRT		0x05
>  #define CMD_COMPLETE_PPR	0x07
>  #define CMD_INV_ALL		0x08
>  
> -- 
> 1.7.9.5
> 
> 
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
