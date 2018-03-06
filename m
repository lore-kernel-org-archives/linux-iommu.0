From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC 1/5] dt-bindings: iommu: Add reserved-dma-region for IOMMU
	device
Date: Tue, 6 Mar 2018 11:41:01 +0000
Message-ID: <23f7c879-2dfe-dbdf-f259-dcc44f045c96@arm.com>
References: <1520312368-7068-1-git-send-email-jitendra.bhivare@broadcom.com>
	<1520312368-7068-2-git-send-email-jitendra.bhivare@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1520312368-7068-2-git-send-email-jitendra.bhivare-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jitendra Bhivare <jitendra.bhivare-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 06/03/18 04:59, Jitendra Bhivare wrote:
> Certain regions in IO virtual address space may need to be reserved to be
> not used for devices configured behind IOMMU.
> 
> Add documentation of the property to allow such regions to be specified in
> DT to be reserved using IOMMU_RESV_RESERVED type.

That sounds like software policy; DT is for describing hardware.

> Reviewed-by: Ray Jui <ray.jui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> Reviewed-by: Vikram Prakash <vikram.prakash-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> Reviewed-by: Scott Branden <scott.branden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> Signed-off-by: Jitendra Bhivare <jitendra.bhivare-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> ---
>   Documentation/devicetree/bindings/iommu/iommu.txt | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/iommu.txt b/Documentation/devicetree/bindings/iommu/iommu.txt
> index 5a8b462..5a58ef2 100644
> --- a/Documentation/devicetree/bindings/iommu/iommu.txt
> +++ b/Documentation/devicetree/bindings/iommu/iommu.txt
> @@ -98,6 +98,20 @@ requirements of that use-case haven't been fully determined yet. Implementing
>   this is therefore not recommended without further discussion and extension of
>   this binding.
>   
> +Optional properties:
> +--------------------
> +- reserved-dma-region: This specifies DMA region to be reserved with specific
> +  prot in IOVA space. It is in tuples of (busno,prot,bus_addr,size).

What do busno and prot actually mean, and what are valid values for them?

Robin.

> +- #region-address-cells: specifies number of cells needed to encode bus_addr
> +
> +- #region-size-cells: specifies number of cells needed to encode size
> +
> +Notes:
> +======
> +This can be applied to IOMMU master node or to children (such as PCI host
> +bridges) on the bus behind IOMMU.
> +
>   
>   Examples:
>   =========
> @@ -173,6 +187,9 @@ Multiple-master IOMMU with configurable DMA window:
>   			 * master (i.e. the I/O virtual address space).
>   			 */
>   			#iommu-cells = <4>;
> +			#region-address-cells = <2>;
> +			#region-size-cells = <2>;
> +			reserved-dma-region = <0x0 0x0 0x04 0x0 0x04 0x0>;
>   		};
>   
>   		master {
> 
