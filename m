Return-Path: <SRS0=3Hz1=2H=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D1EC2D0D1
	for <iommu@archiver.kernel.org>; Tue, 17 Dec 2019 17:07:42 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49FA921582
	for <iommu@archiver.kernel.org>; Tue, 17 Dec 2019 17:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="biDSYhA7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49FA921582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 18D7085149;
	Tue, 17 Dec 2019 17:07:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PL4HaDCs+00e; Tue, 17 Dec 2019 17:07:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0A13584AF1;
	Tue, 17 Dec 2019 17:07:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E3FAEC1D7D;
	Tue, 17 Dec 2019 17:07:40 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 95558C077D
 for <iommu@lists.linux-foundation.org>; Tue, 17 Dec 2019 17:07:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 836AF207A6
 for <iommu@lists.linux-foundation.org>; Tue, 17 Dec 2019 17:07:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nmdbvAoL9S0E for <iommu@lists.linux-foundation.org>;
 Tue, 17 Dec 2019 17:07:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [205.139.110.61])
 by silver.osuosl.org (Postfix) with ESMTPS id 39E5F204FB
 for <iommu@lists.linux-foundation.org>; Tue, 17 Dec 2019 17:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576602456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MdRymTJlr2MvtgHnglffoNCEP5cidnRw495PTDKXvZY=;
 b=biDSYhA7C+07EH6Ndcv4+GVYA2mXBV/sXVIZYCkRUW74OHHRLkmElxS12LJZ80RgiW0tPp
 q+AajAUWIeMHwUMWqCxfOI26I+uioqapCXpffWR9xQuVWVgTGmWXhgyNWIwsYkm5yobOOm
 K7WBgd9sqpfLQQHJDPT/fQk2lMBYNeI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-kBQCyaImMeyEcJ-ZjTbuPQ-1; Tue, 17 Dec 2019 12:07:34 -0500
X-MC-Unique: kBQCyaImMeyEcJ-ZjTbuPQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1EAC318B6401;
 Tue, 17 Dec 2019 17:07:32 +0000 (UTC)
Received: from [10.36.116.117] (ovpn-116-117.ams2.redhat.com [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 065155C28C;
 Tue, 17 Dec 2019 17:07:27 +0000 (UTC)
Subject: Re: [PATCH v3 08/13] iommu/arm-smmu-v3: Propate ssid_bits
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
 iommu@lists.linux-foundation.org
References: <20191209180514.272727-1-jean-philippe@linaro.org>
 <20191209180514.272727-9-jean-philippe@linaro.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <466bbc57-79d4-274c-67bc-4ed591da9968@redhat.com>
Date: Tue, 17 Dec 2019 18:07:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191209180514.272727-9-jean-philippe@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: mark.rutland@arm.com, robin.murphy@arm.com, guohanjun@huawei.com,
 rjw@rjwysocki.net, robh+dt@kernel.org, sudeep.holla@arm.com,
 bhelgaas@google.com, zhangfei.gao@linaro.org, will@kernel.org, lenb@kernel.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Jean,

On 12/9/19 7:05 PM, Jean-Philippe Brucker wrote:

s/Propate/Propagate in the commit title.
> Now that we support substream IDs, initialize s1cdmax with the number of
> SSID bits supported by a master and the SMMU.
> 
> Context descriptor tables are allocated once for the first master
> attached to a domain. Therefore attaching multiple devices with
> different SSID sizes is tricky, and we currently don't support it.
> 
> As a future improvement it would be nice to at least support attaching a
> SSID-capable device to a domain that isn't using SSID, by reallocating
> the SSID table.
Isn't that use case relevant (I mean using both devices in a non SSID
use case). For platform devices you can work this around with FW but for
PCI devices?

 This would allow supporting a SSID-capable device that
> is in the same IOMMU group as a bridge, for example. Varying SSID size
> is less of a concern, since the PCIe specification "highly recommends"
> that devices supporting PASID implement all 20 bits of it.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Besides, Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

> ---
>  drivers/iommu/arm-smmu-v3.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index a01071123c34..f260abadde6d 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -2279,6 +2279,7 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
>  }
>  
>  static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
> +				       struct arm_smmu_master *master,
>  				       struct io_pgtable_cfg *pgtbl_cfg)
>  {
>  	int ret;
> @@ -2290,6 +2291,8 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
>  	if (asid < 0)
>  		return asid;
>  
> +	cfg->s1cdmax = master->ssid_bits;
> +
>  	ret = arm_smmu_alloc_cd_tables(smmu_domain);
>  	if (ret)
>  		goto out_free_asid;
> @@ -2306,6 +2309,7 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
>  }
>  
>  static int arm_smmu_domain_finalise_s2(struct arm_smmu_domain *smmu_domain,
> +				       struct arm_smmu_master *master,
>  				       struct io_pgtable_cfg *pgtbl_cfg)
>  {
>  	int vmid;
> @@ -2322,7 +2326,8 @@ static int arm_smmu_domain_finalise_s2(struct arm_smmu_domain *smmu_domain,
>  	return 0;
>  }
>  
> -static int arm_smmu_domain_finalise(struct iommu_domain *domain)
> +static int arm_smmu_domain_finalise(struct iommu_domain *domain,
> +				    struct arm_smmu_master *master)
>  {
>  	int ret;
>  	unsigned long ias, oas;
> @@ -2330,6 +2335,7 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
>  	struct io_pgtable_cfg pgtbl_cfg;
>  	struct io_pgtable_ops *pgtbl_ops;
>  	int (*finalise_stage_fn)(struct arm_smmu_domain *,
> +				 struct arm_smmu_master *,
>  				 struct io_pgtable_cfg *);
>  	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>  	struct arm_smmu_device *smmu = smmu_domain->smmu;
> @@ -2384,7 +2390,7 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
>  	domain->geometry.aperture_end = (1UL << pgtbl_cfg.ias) - 1;
>  	domain->geometry.force_aperture = true;
>  
> -	ret = finalise_stage_fn(smmu_domain, &pgtbl_cfg);
> +	ret = finalise_stage_fn(smmu_domain, master, &pgtbl_cfg);
>  	if (ret < 0) {
>  		free_io_pgtable_ops(pgtbl_ops);
>  		return ret;
> @@ -2537,7 +2543,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  
>  	if (!smmu_domain->smmu) {
>  		smmu_domain->smmu = smmu;
> -		ret = arm_smmu_domain_finalise(domain);
> +		ret = arm_smmu_domain_finalise(domain, master);
>  		if (ret) {
>  			smmu_domain->smmu = NULL;
>  			goto out_unlock;
> @@ -2549,6 +2555,13 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  			dev_name(smmu->dev));
>  		ret = -ENXIO;
>  		goto out_unlock;
> +	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
> +		   master->ssid_bits != smmu_domain->s1_cfg.s1cdmax) {
> +		dev_err(dev,
> +			"cannot attach to incompatible domain (%u SSID bits != %u)\n",
> +			smmu_domain->s1_cfg.s1cdmax, master->ssid_bits);
> +		ret = -EINVAL;
> +		goto out_unlock;
>  	}
>  
>  	master->domain = smmu_domain;
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
