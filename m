From: Gary R Hook <ghook-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] iommu/amd: remove redundant variable tag
Date: Mon, 2 Jul 2018 15:21:28 -0500
Message-ID: <57a38891-d811-17af-a544-cfeea9476160@amd.com>
References: <20180702163752.16418-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180702163752.16418-1-colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Colin King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 07/02/2018 11:37 AM, Colin King wrote:
> From: Colin Ian King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
> 
> Variable tag is being assigned but is never used hence it is
> redundant and can be removed.
> 
> Cleans up clang warning:
> warning: variable 'tag' set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Colin Ian King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
> ---
>   drivers/iommu/amd_iommu.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index 596b95c50051..c6aed1b088e9 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -547,7 +547,7 @@ static void amd_iommu_report_page_fault(u16 devid, u16 domain_id,
>   static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
>   {
>   	struct device *dev = iommu->iommu.dev;
> -	int type, devid, pasid, flags, tag;
> +	int type, devid, pasid, flags;
>   	volatile u32 *event = __evt;
>   	int count = 0;
>   	u64 address;
> @@ -615,7 +615,6 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
>   	case EVENT_TYPE_INV_PPR_REQ:
>   		pasid = ((event[0] >> 16) & 0xFFFF)
>   			| ((event[1] << 6) & 0xF0000);
> -		tag = event[1] & 0x03FF;
>   		dev_err(dev, "INVALID_PPR_REQUEST device=%02x:%02x.%x pasid=0x%05x address=0x%016llx flags=0x%04x]\n",
>   			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
>   			pasid, address, flags);
> 

If it's all the same to you, the intent was to print the tag as well. 
Could we add that to the message, rather than removing the variable, please?
