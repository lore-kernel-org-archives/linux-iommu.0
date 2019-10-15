Return-Path: <SRS0=BRyA=YI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3563FECE58C
	for <iommu@archiver.kernel.org>; Tue, 15 Oct 2019 02:36:00 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C299A20673
	for <iommu@archiver.kernel.org>; Tue, 15 Oct 2019 02:35:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C299A20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 7227F108B;
	Tue, 15 Oct 2019 02:35:59 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 62623107E
	for <iommu@lists.linux-foundation.org>;
	Tue, 15 Oct 2019 02:35:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D1FC15D3
	for <iommu@lists.linux-foundation.org>;
	Tue, 15 Oct 2019 02:35:57 +0000 (UTC)
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
	by Forcepoint Email with ESMTP id 12163C3C80012EDBF0CF;
	Tue, 15 Oct 2019 10:35:48 +0800 (CST)
Received: from [127.0.0.1] (10.177.223.23) by DGGEMS412-HUB.china.huawei.com
	(10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Tue, 15 Oct 2019
	10:35:40 +0800
Subject: Re: [RFC PATCH 1/6] ACPI/IORT: Set PMCG device parent
To: John Garry <john.garry@huawei.com>, <lorenzo.pieralisi@arm.com>,
	<sudeep.holla@arm.com>, <robin.murphy@arm.com>, <mark.rutland@arm.com>, 
	<will@kernel.org>
References: <1569854031-237636-1-git-send-email-john.garry@huawei.com>
	<1569854031-237636-2-git-send-email-john.garry@huawei.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <ae9a1c8a-d84b-95ab-9a6b-87a7c89c68d9@huawei.com>
Date: Tue, 15 Oct 2019 10:35:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
	Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1569854031-237636-2-git-send-email-john.garry@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
Cc: nleeder@codeaurora.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
	linuxarm@huawei.com, iommu@lists.linux-foundation.org,
	linux-arm-kernel@lists.infradead.org, lenb@kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Development issues for Linux IOMMU support
	<iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi John,

On 2019/9/30 22:33, John Garry wrote:
> In the IORT, a PMCG node includes a node reference to its associated
> device.
> 
> Set the PMCG platform device parent device for future referencing.
> 
> For now, we only consider setting for when the associated component is an
> SMMUv3.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  drivers/acpi/arm64/iort.c | 34 ++++++++++++++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 8569b79e8b58..0b687520c3e7 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -1455,7 +1455,7 @@ static __init const struct iort_dev_config *iort_get_dev_cfg(
>   * Returns: 0 on success, <0 failure

...

>   */
>  static int __init iort_add_platform_device(struct acpi_iort_node *node,
> -					   const struct iort_dev_config *ops)
> +					   const struct iort_dev_config *ops, struct device *parent)

Since you added a input for this function, could you please update
the comments of this function as well?

>  {
>  	struct fwnode_handle *fwnode;
>  	struct platform_device *pdev;
> @@ -1466,6 +1466,8 @@ static int __init iort_add_platform_device(struct acpi_iort_node *node,
>  	if (!pdev)
>  		return -ENOMEM;
>  
> +	pdev->dev.parent = parent;
> +
>  	if (ops->dev_set_proximity) {
>  		ret = ops->dev_set_proximity(&pdev->dev, node);
>  		if (ret)
> @@ -1573,6 +1575,11 @@ static void __init iort_enable_acs(struct acpi_iort_node *iort_node)
>  static inline void iort_enable_acs(struct acpi_iort_node *iort_node) { }
>  #endif
>  
> +static int iort_fwnode_match(struct device *dev, const void *fwnode)
> +{
> +	return dev->fwnode == fwnode;
> +}
> +
>  static void __init iort_init_platform_devices(void)
>  {
>  	struct acpi_iort_node *iort_node, *iort_end;
> @@ -1594,11 +1601,34 @@ static void __init iort_init_platform_devices(void)
>  				iort_table->length);
>  
>  	for (i = 0; i < iort->node_count; i++) {
> +		struct device *parent = NULL;
> +
>  		if (iort_node >= iort_end) {
>  			pr_err("iort node pointer overflows, bad table\n");
>  			return;
>  		}
>  
> +		/* Fixme: handle parent declared in IORT after PMCG */
> +		if (iort_node->type == ACPI_IORT_NODE_PMCG) {
> +			struct acpi_iort_node *iort_assoc_node;
> +			struct acpi_iort_pmcg *pmcg;
> +			u32 node_reference;
> +
> +			pmcg = (struct acpi_iort_pmcg *)iort_node->node_data;
> +
> +			node_reference = pmcg->node_reference;
> +			iort_assoc_node = ACPI_ADD_PTR(struct acpi_iort_node, iort,
> +				 node_reference);
> +
> +			if (iort_assoc_node->type == ACPI_IORT_NODE_SMMU_V3) {
> +				struct fwnode_handle *assoc_fwnode;
> +
> +				assoc_fwnode = iort_get_fwnode(iort_assoc_node);
> +
> +				parent = bus_find_device(&platform_bus_type, NULL,
> +				      assoc_fwnode, iort_fwnode_match);
> +			}
> +		}

How about using a function to include those new added code to make this
function (iort_init_platform_devices()) a bit cleaner?

>  		iort_enable_acs(iort_node);
>  
>  		ops = iort_get_dev_cfg(iort_node);
> @@ -1609,7 +1639,7 @@ static void __init iort_init_platform_devices(void)
>  
>  			iort_set_fwnode(iort_node, fwnode);
>  
> -			ret = iort_add_platform_device(iort_node, ops);
> +			ret = iort_add_platform_device(iort_node, ops, parent);

This function is called if ops is valid, so retrieve the parent
can be done before this function I think.

Thanks
Hanjun

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
