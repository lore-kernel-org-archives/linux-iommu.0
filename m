Return-Path: <SRS0=KoUT=IC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09719C433E0
	for <iommu@archiver.kernel.org>; Thu,  4 Mar 2021 07:56:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D6F964EFC
	for <iommu@archiver.kernel.org>; Thu,  4 Mar 2021 07:56:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D6F964EFC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A5ACA4EBCC;
	Thu,  4 Mar 2021 07:56:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6H93kSTA8TAY; Thu,  4 Mar 2021 07:56:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id C955E4EBC8;
	Thu,  4 Mar 2021 07:56:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A83AAC000B;
	Thu,  4 Mar 2021 07:56:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B664C0001
 for <iommu@lists.linux-foundation.org>; Thu,  4 Mar 2021 07:56:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 594DB6F5B8
 for <iommu@lists.linux-foundation.org>; Thu,  4 Mar 2021 07:56:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DMyJQFUbGJei for <iommu@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 07:56:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0C32B6F5B4
 for <iommu@lists.linux-foundation.org>; Thu,  4 Mar 2021 07:56:09 +0000 (UTC)
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Drjn91ccYz7swm;
 Thu,  4 Mar 2021 15:54:21 +0800 (CST)
Received: from [127.0.0.1] (10.40.193.166) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.498.0; Thu, 4 Mar 2021
 15:55:53 +0800
Subject: Re: [PATCH v14 07/13] iommu/smmuv3: Implement cache_invalidate
To: Eric Auger <eric.auger@redhat.com>, <eric.auger.pro@gmail.com>,
 <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
 <kvm@vger.kernel.org>, <kvmarm@lists.cs.columbia.edu>, <will@kernel.org>,
 <maz@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
 <alex.williamson@redhat.com>, <tn@semihalf.com>, <zhukeqian1@huawei.com>
References: <20210223205634.604221-1-eric.auger@redhat.com>
 <20210223205634.604221-8-eric.auger@redhat.com>
From: "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <c10c6405-5efe-5a41-2b3a-f3af85a528ba@hisilicon.com>
Date: Thu, 4 Mar 2021 15:55:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20210223205634.604221-8-eric.auger@redhat.com>
X-Originating-IP: [10.40.193.166]
X-CFilter-Loop: Reflected
Cc: jean-philippe@linaro.org, wangxingang5@huawei.com, lushenming@huawei.com,
 jiangkunkun@huawei.com, linuxarm@openeuler.org, vsethi@nvidia.com,
 vivek.gautam@arm.com, zhangfei.gao@linaro.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
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
Content-Type: multipart/mixed; boundary="===============0983890096392754869=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============0983890096392754869==
Content-Type: multipart/alternative;
	boundary="------------38F5B11153F44543AD4AF9C9"

--------------38F5B11153F44543AD4AF9C9
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

Hi Eric,


在 2021/2/24 4:56, Eric Auger 写道:
> Implement domain-selective, pasid selective and page-selective
> IOTLB invalidations.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>
> ---
>
> v13 -> v14:
> - Add domain invalidation
> - do global inval when asid is not provided with addr
>    granularity
>
> v7 -> v8:
> - ASID based invalidation using iommu_inv_pasid_info
> - check ARCHID/PASID flags in addr based invalidation
> - use __arm_smmu_tlb_inv_context and __arm_smmu_tlb_inv_range_nosync
>
> v6 -> v7
> - check the uapi version
>
> v3 -> v4:
> - adapt to changes in the uapi
> - add support for leaf parameter
> - do not use arm_smmu_tlb_inv_range_nosync or arm_smmu_tlb_inv_context
>    anymore
>
> v2 -> v3:
> - replace __arm_smmu_tlb_sync by arm_smmu_cmdq_issue_sync
>
> v1 -> v2:
> - properly pass the asid
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 74 +++++++++++++++++++++
>   1 file changed, 74 insertions(+)
>
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 4c19a1114de4..df3adc49111c 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2949,6 +2949,79 @@ static void arm_smmu_detach_pasid_table(struct iommu_domain *domain)
>   	mutex_unlock(&smmu_domain->init_mutex);
>   }
>   
> +static int
> +arm_smmu_cache_invalidate(struct iommu_domain *domain, struct device *dev,
> +			  struct iommu_cache_invalidate_info *inv_info)
> +{
> +	struct arm_smmu_cmdq_ent cmd = {.opcode = CMDQ_OP_TLBI_NSNH_ALL};
> +	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> +	struct arm_smmu_device *smmu = smmu_domain->smmu;
> +
> +	if (smmu_domain->stage != ARM_SMMU_DOMAIN_NESTED)
> +		return -EINVAL;
> +
> +	if (!smmu)
> +		return -EINVAL;
> +
> +	if (inv_info->version != IOMMU_CACHE_INVALIDATE_INFO_VERSION_1)
> +		return -EINVAL;
> +
> +	if (inv_info->cache & IOMMU_CACHE_INV_TYPE_PASID ||
> +	    inv_info->cache & IOMMU_CACHE_INV_TYPE_DEV_IOTLB) {
> +		return -ENOENT;
> +	}
> +
> +	if (!(inv_info->cache & IOMMU_CACHE_INV_TYPE_IOTLB))
> +		return -EINVAL;
> +
> +	/* IOTLB invalidation */
> +
> +	switch (inv_info->granularity) {
> +	case IOMMU_INV_GRANU_PASID:
> +	{
> +		struct iommu_inv_pasid_info *info =
> +			&inv_info->granu.pasid_info;
> +
> +		if (info->flags & IOMMU_INV_ADDR_FLAGS_PASID)
> +			return -ENOENT;
> +		if (!(info->flags & IOMMU_INV_PASID_FLAGS_ARCHID))
> +			return -EINVAL;
> +
> +		__arm_smmu_tlb_inv_context(smmu_domain, info->archid);
> +		return 0;
> +	}
> +	case IOMMU_INV_GRANU_ADDR:
> +	{
> +		struct iommu_inv_addr_info *info = &inv_info->granu.addr_info;
> +		size_t size = info->nb_granules * info->granule_size;
> +		bool leaf = info->flags & IOMMU_INV_ADDR_FLAGS_LEAF;
> +
> +		if (info->flags & IOMMU_INV_ADDR_FLAGS_PASID)
> +			return -ENOENT;
> +
> +		if (!(info->flags & IOMMU_INV_ADDR_FLAGS_ARCHID))
> +			break;
> +
> +		arm_smmu_tlb_inv_range_domain(info->addr, size,
> +					      info->granule_size, leaf,
> +					      info->archid, smmu_domain);

Is it possible to add a check before the function to make sure that 
info->granule_size can be recognized by SMMU?
There is a scenario which will cause TLBI issue: RIL feature is enabled 
on guest but is disabled on host, and then on
host it just invalidate 4K/2M/1G once a time, but from QEMU, 
info->nb_granules is always 1 and info->granule_size = size,
if size is not equal to 4K or 2M or 1G (for example size = granule_size 
is 5M), it will only part of the size it wants to invalidate.

I think maybe we can add a check here: if RIL is not enabled and also 
size is not the granule_size (4K/2M/1G) supported by
SMMU hardware, can we just simply use the smallest granule_size 
supported by hardware all the time?

> +
> +		arm_smmu_cmdq_issue_sync(smmu);
> +		return 0;
> +	}
> +	case IOMMU_INV_GRANU_DOMAIN:
> +		break;

I check the qemu code 
(https://github.com/eauger/qemu/tree/v5.2.0-2stage-rfcv8), for opcode 
CMD_TLBI_NH_ALL or CMD_TLBI_NSNH_ALL from guest OS
it calls smmu_inv_notifiers_all() to unamp all notifiers of all mr's, 
but it seems not set event.entry.granularity which i think it should set 
IOMMU_INV_GRAN_ADDR.
BTW, for opcode CMD_TLBI_NH_ALL or CMD_TLBI_NSNH_ALL, it needs to unmap 
size = 0x1000000000000 on 48bit system (it may spend much time),  maybe 
it is better
to set it as IOMMU_INV_GRANU_DOMAIN, then in host OS, send TLBI_NH_ALL 
directly when IOMMU_INV_GRANU_DOMAIN.


> +	default:
> +		return -EINVAL;
> +	}
> +
> +	/* Global S1 invalidation */
> +	cmd.tlbi.vmid   = smmu_domain->s2_cfg.vmid;
> +	arm_smmu_cmdq_issue_cmd(smmu, &cmd);
> +	arm_smmu_cmdq_issue_sync(smmu);
> +	return 0;
> +}
> +
>   static bool arm_smmu_dev_has_feature(struct device *dev,
>   				     enum iommu_dev_features feat)
>   {
> @@ -3048,6 +3121,7 @@ static struct iommu_ops arm_smmu_ops = {
>   	.put_resv_regions	= generic_iommu_put_resv_regions,
>   	.attach_pasid_table	= arm_smmu_attach_pasid_table,
>   	.detach_pasid_table	= arm_smmu_detach_pasid_table,
> +	.cache_invalidate	= arm_smmu_cache_invalidate,
>   	.dev_has_feat		= arm_smmu_dev_has_feature,
>   	.dev_feat_enabled	= arm_smmu_dev_feature_enabled,
>   	.dev_enable_feat	= arm_smmu_dev_enable_feature,


--------------38F5B11153F44543AD4AF9C9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <p>Hi Eric, <br>
    </p>
    <br>
    <div class="moz-cite-prefix">在 2021/2/24 4:56, Eric Auger 写道:<br>
    </div>
    <blockquote cite="mid:20210223205634.604221-8-eric.auger@redhat.com"
      type="cite">
      <pre wrap="">Implement domain-selective, pasid selective and page-selective
IOTLB invalidations.

Signed-off-by: Eric Auger <a class="moz-txt-link-rfc2396E" href="mailto:eric.auger@redhat.com">&lt;eric.auger@redhat.com&gt;</a>

---

v13 -&gt; v14:
- Add domain invalidation
- do global inval when asid is not provided with addr
  granularity

v7 -&gt; v8:
- ASID based invalidation using iommu_inv_pasid_info
- check ARCHID/PASID flags in addr based invalidation
- use __arm_smmu_tlb_inv_context and __arm_smmu_tlb_inv_range_nosync

v6 -&gt; v7
- check the uapi version

v3 -&gt; v4:
- adapt to changes in the uapi
- add support for leaf parameter
- do not use arm_smmu_tlb_inv_range_nosync or arm_smmu_tlb_inv_context
  anymore

v2 -&gt; v3:
- replace __arm_smmu_tlb_sync by arm_smmu_cmdq_issue_sync

v1 -&gt; v2:
- properly pass the asid
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 74 +++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 4c19a1114de4..df3adc49111c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2949,6 +2949,79 @@ static void arm_smmu_detach_pasid_table(struct iommu_domain *domain)
 	mutex_unlock(&amp;smmu_domain-&gt;init_mutex);
 }
 
+static int
+arm_smmu_cache_invalidate(struct iommu_domain *domain, struct device *dev,
+			  struct iommu_cache_invalidate_info *inv_info)
+{
+	struct arm_smmu_cmdq_ent cmd = {.opcode = CMDQ_OP_TLBI_NSNH_ALL};
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct arm_smmu_device *smmu = smmu_domain-&gt;smmu;
+
+	if (smmu_domain-&gt;stage != ARM_SMMU_DOMAIN_NESTED)
+		return -EINVAL;
+
+	if (!smmu)
+		return -EINVAL;
+
+	if (inv_info-&gt;version != IOMMU_CACHE_INVALIDATE_INFO_VERSION_1)
+		return -EINVAL;
+
+	if (inv_info-&gt;cache &amp; IOMMU_CACHE_INV_TYPE_PASID ||
+	    inv_info-&gt;cache &amp; IOMMU_CACHE_INV_TYPE_DEV_IOTLB) {
+		return -ENOENT;
+	}
+
+	if (!(inv_info-&gt;cache &amp; IOMMU_CACHE_INV_TYPE_IOTLB))
+		return -EINVAL;
+
+	/* IOTLB invalidation */
+
+	switch (inv_info-&gt;granularity) {
+	case IOMMU_INV_GRANU_PASID:
+	{
+		struct iommu_inv_pasid_info *info =
+			&amp;inv_info-&gt;granu.pasid_info;
+
+		if (info-&gt;flags &amp; IOMMU_INV_ADDR_FLAGS_PASID)
+			return -ENOENT;
+		if (!(info-&gt;flags &amp; IOMMU_INV_PASID_FLAGS_ARCHID))
+			return -EINVAL;
+
+		__arm_smmu_tlb_inv_context(smmu_domain, info-&gt;archid);
+		return 0;
+	}
+	case IOMMU_INV_GRANU_ADDR:
+	{
+		struct iommu_inv_addr_info *info = &amp;inv_info-&gt;granu.addr_info;
+		size_t size = info-&gt;nb_granules * info-&gt;granule_size;
+		bool leaf = info-&gt;flags &amp; IOMMU_INV_ADDR_FLAGS_LEAF;
+
+		if (info-&gt;flags &amp; IOMMU_INV_ADDR_FLAGS_PASID)
+			return -ENOENT;
+
+		if (!(info-&gt;flags &amp; IOMMU_INV_ADDR_FLAGS_ARCHID))
+			break;
+
+		arm_smmu_tlb_inv_range_domain(info-&gt;addr, size,
+					      info-&gt;granule_size, leaf,
+					      info-&gt;archid, smmu_domain);</pre>
    </blockquote>
    <br>
    Is it possible to add a check before the function to make sure that
    info-&gt;granule_size can be recognized by SMMU?<br>
    There is a scenario which will cause TLBI issue: RIL feature is
    enabled on guest but is disabled on host, and then on<br>
    host it just invalidate 4K/2M/1G once a time, but from QEMU,
    info-&gt;nb_granules is always 1 and info-&gt;granule_size = size, <br>
    if size is not equal to 4K or 2M or 1G (for example size =
    granule_size is 5M), it will only part of the size it wants to
    invalidate.<br>
    <br>
    I think maybe we can add a check here: if RIL is not enabled and
    also size is not the granule_size (4K/2M/1G) supported by <br>
    SMMU hardware, can we just simply use the smallest granule_size
    supported by hardware all the time?<br>
    <br>
    <blockquote cite="mid:20210223205634.604221-8-eric.auger@redhat.com"
      type="cite">
      <pre wrap="">
+
+		arm_smmu_cmdq_issue_sync(smmu);
+		return 0;
+	}
+	case IOMMU_INV_GRANU_DOMAIN:
+		break;</pre>
    </blockquote>
    <br>
    I check the qemu code (<span style="color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: normal; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: pre-wrap; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;"><a class="moz-txt-link-freetext" href="https://github.com/eauger/qemu/tree/v5.2.0-2stage-rfcv8">https://github.com/eauger/qemu/tree/v5.2.0-2stage-rfcv8</a></span>),
    for opcode CMD_TLBI_NH_ALL or CMD_TLBI_NSNH_ALL from guest OS <br>
    it calls smmu_inv_notifiers_all() to unamp all notifiers of all
    mr's, but it seems not set event.entry.granularity which i think it
    should set IOMMU_INV_GRAN_ADDR.<br>
    BTW, for opcode CMD_TLBI_NH_ALL or CMD_TLBI_NSNH_ALL, it needs to
    unmap size = 0x1000000000000 on 48bit system (it may spend much
    time),  maybe it is better<br>
    to set it as IOMMU_INV_GRANU_DOMAIN, then in host OS, send
    TLBI_NH_ALL directly when IOMMU_INV_GRANU_DOMAIN.<br>
    <br>
    <br>
    <blockquote cite="mid:20210223205634.604221-8-eric.auger@redhat.com"
      type="cite">
      <pre wrap="">
+	default:
+		return -EINVAL;
+	}
+
+	/* Global S1 invalidation */
+	cmd.tlbi.vmid   = smmu_domain-&gt;s2_cfg.vmid;
+	arm_smmu_cmdq_issue_cmd(smmu, &amp;cmd);
+	arm_smmu_cmdq_issue_sync(smmu);
+	return 0;
+}
+
 static bool arm_smmu_dev_has_feature(struct device *dev,
 				     enum iommu_dev_features feat)
 {
@@ -3048,6 +3121,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.put_resv_regions	= generic_iommu_put_resv_regions,
 	.attach_pasid_table	= arm_smmu_attach_pasid_table,
 	.detach_pasid_table	= arm_smmu_detach_pasid_table,
+	.cache_invalidate	= arm_smmu_cache_invalidate,
 	.dev_has_feat		= arm_smmu_dev_has_feature,
 	.dev_feat_enabled	= arm_smmu_dev_feature_enabled,
 	.dev_enable_feat	= arm_smmu_dev_enable_feature,
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------38F5B11153F44543AD4AF9C9--

--===============0983890096392754869==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============0983890096392754869==--
