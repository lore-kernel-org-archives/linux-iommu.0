Return-Path: <SRS0=3Hz1=2H=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3745C43603
	for <iommu@archiver.kernel.org>; Tue, 17 Dec 2019 17:24:35 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D36224655
	for <iommu@archiver.kernel.org>; Tue, 17 Dec 2019 17:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WzgiU9HD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D36224655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4339C858AE;
	Tue, 17 Dec 2019 17:24:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UY4EEmITitB5; Tue, 17 Dec 2019 17:24:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A11F9856C8;
	Tue, 17 Dec 2019 17:24:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8CA9EC1D7D;
	Tue, 17 Dec 2019 17:24:34 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AC48BC077D
 for <iommu@lists.linux-foundation.org>; Tue, 17 Dec 2019 17:24:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 9A9A287C2C
 for <iommu@lists.linux-foundation.org>; Tue, 17 Dec 2019 17:24:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ivue6ZjWpVgU for <iommu@lists.linux-foundation.org>;
 Tue, 17 Dec 2019 17:24:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id BE8B28768F
 for <iommu@lists.linux-foundation.org>; Tue, 17 Dec 2019 17:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576603470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z9EWxVih18eWOWqVZH496crr0Ey2713iPaECnfpP2vE=;
 b=WzgiU9HD/0RIy1KMYHbppXdRk6cUoxVgmi9ADIbNXvDuhlaFrhZY/lDaAocBIR/hzYsYXY
 QaiEOkGBdc1Ur9Mq9bBg+Kp0rE81nJwX3KoTmbC4WRH41qMg0RBwjteAjyiYh3HSXyJylv
 a9FLNw8SS2hJgMuuZRK1jd5W2qfJU08=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-rLIk8wDJP16gfQOgon_8HA-1; Tue, 17 Dec 2019 12:24:26 -0500
X-MC-Unique: rLIk8wDJP16gfQOgon_8HA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42E7E8017DF;
 Tue, 17 Dec 2019 17:24:24 +0000 (UTC)
Received: from [10.36.116.117] (ovpn-116-117.ams2.redhat.com [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 12510620A7;
 Tue, 17 Dec 2019 17:24:19 +0000 (UTC)
Subject: Re: [PATCH v3 09/13] iommu/arm-smmu-v3: Handle failure of
 arm_smmu_write_ctx_desc()
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
 iommu@lists.linux-foundation.org
References: <20191209180514.272727-1-jean-philippe@linaro.org>
 <20191209180514.272727-10-jean-philippe@linaro.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <bff90d55-4f81-aa60-2341-9fb467cfdd59@redhat.com>
Date: Tue, 17 Dec 2019 18:24:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191209180514.272727-10-jean-philippe@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
> Second-level context descriptor tables will be allocated lazily in
> arm_smmu_write_ctx_desc(). Help with handling allocation failure by
> moving the CD write into arm_smmu_domain_finalise_s1().

nit: would rather change the title to something like "Prepare for
arm_smmu_write_ctx_desc() failure"
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

> ---
>  drivers/iommu/arm-smmu-v3.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index f260abadde6d..fc5119f34187 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -2301,8 +2301,15 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
>  	cfg->cd.ttbr	= pgtbl_cfg->arm_lpae_s1_cfg.ttbr[0];
>  	cfg->cd.tcr	= pgtbl_cfg->arm_lpae_s1_cfg.tcr;
>  	cfg->cd.mair	= pgtbl_cfg->arm_lpae_s1_cfg.mair;
> +
> +	ret = arm_smmu_write_ctx_desc(smmu_domain, 0, &cfg->cd);
> +	if (ret)
> +		goto out_free_tables;
> +
>  	return 0;
>  
> +out_free_tables:
> +	arm_smmu_free_cd_tables(smmu_domain);
>  out_free_asid:
>  	arm_smmu_bitmap_free(smmu->asid_map, asid);
>  	return ret;
> @@ -2569,10 +2576,6 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  	if (smmu_domain->stage != ARM_SMMU_DOMAIN_BYPASS)
>  		master->ats_enabled = arm_smmu_ats_supported(master);
>  
> -	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1)
> -		arm_smmu_write_ctx_desc(smmu_domain, 0,
> -					&smmu_domain->s1_cfg.cd);
> -
>  	arm_smmu_install_ste_for_dev(master);
>  
>  	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
