From: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH 6/9] iommu: qcom: initialize secure page table
Date: Wed, 1 Mar 2017 14:14:29 -0800
Message-ID: <3ee2b1b2-ffd8-a1e8-0c14-b5d764a742c0@codeaurora.org>
References: <20170301174258.14618-1-robdclark@gmail.com>
	<20170301174258.14618-7-robdclark@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170301174258.14618-7-robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Stanimir Varbanov <stanimir.varbanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 03/01/2017 09:42 AM, Rob Clark wrote:
> From: Stanimir Varbanov <stanimir.varbanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>
> This bassicaly get the secure page table size, allocate memory

s/bassicaly/basically/
s/get/gets/
s/allocate/allocates/

Heh, bass.

> and return back the physical address to the trusted zone.

s/return/returns/

>
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Signed-off-by: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/iommu/qcom_iommu.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
>
> diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
> index 5d3bb63..082ece7 100644
> --- a/drivers/iommu/qcom_iommu.c
> +++ b/drivers/iommu/qcom_iommu.c
> @@ -608,6 +608,51 @@ static void qcom_iommu_disable_clocks(struct qcom_iommu_dev *qcom_iommu)
>  	clk_disable_unprepare(qcom_iommu->iface_clk);
>  }
>  
> +static int qcom_iommu_sec_ptbl_init(struct device *dev)
> +{
> +	size_t psize = 0;
> +	unsigned int spare = 0;

Why not just pass 0 where it's used?

> +	void *cpu_addr;
> +	dma_addr_t paddr;
> +	unsigned long attrs;
> +	static bool allocated = false;
> +	int ret;
> +
> +	if (allocated)
> +		return 0;
> +
> +	ret = qcom_scm_iommu_secure_ptbl_size(spare, &psize);
> +	if (ret) {
> +		dev_err(dev, "failed to get iommu secure pgtable size (%d)\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	dev_info(dev, "iommu sec: pgtable size: %zu\n", psize);

Debug?

> +
> +	attrs = DMA_ATTR_NO_KERNEL_MAPPING;
> +
> +	cpu_addr = dma_alloc_attrs(dev, psize, &paddr, GFP_KERNEL, attrs);
> +	if (!cpu_addr) {
> +		dev_err(dev, "failed to allocate %zu bytes for pgtable\n",
> +			psize);
> +		return -ENOMEM;
> +	}
> +
> +	ret = qcom_scm_iommu_secure_ptbl_init(paddr, psize, spare);
> +	if (ret) {
> +		dev_err(dev, "failed to init iommu pgtable (%d)\n", ret);
> +		goto free_mem;
> +	}
> +
> +	allocated = true;
> +	return 0;
> +
> +free_mem:
> +	dma_free_attrs(dev, psize, cpu_addr, paddr, attrs);
> +	return ret;
> +}
> +
>  static int qcom_iommu_ctx_probe(struct platform_device *pdev)
>  {
>  	struct qcom_iommu_ctx *ctx;
> @@ -693,6 +738,17 @@ static struct platform_driver qcom_iommu_ctx_driver = {
>  };
>  module_platform_driver(qcom_iommu_ctx_driver);
>  
> +static bool qcom_iommu_has_secure_context(struct qcom_iommu_dev *qcom_iommu)
> +{
> +	struct device_node *child;
> +
> +	for_each_child_of_node(qcom_iommu->dev->of_node, child)
> +		if (of_device_is_compatible(child, "qcom,msm-iommu-v1-sec"))
> +			return true;

Missing an of_node_put(child) here?

> +
> +	return false;
> +}
> +
>  static int qcom_iommu_device_probe(struct platform_device *pdev)
>  {
>  	struct qcom_iommu_dev *qcom_iommu;
> @@ -731,6 +787,14 @@ static int qcom_iommu_device_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
>  
> +	if (qcom_iommu_has_secure_context(qcom_iommu)) {
> +		ret = qcom_iommu_sec_ptbl_init(dev);

Is dev the same dev that's passed to qcom_iommu_has_secure_context()?
Perhaps we can pass dev to has_secure_context instead to make things
clearer.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
