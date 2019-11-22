Return-Path: <SRS0=Z7Xn=ZO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A8FC432C0
	for <iommu@archiver.kernel.org>; Fri, 22 Nov 2019 15:32:13 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E7B220715
	for <iommu@archiver.kernel.org>; Fri, 22 Nov 2019 15:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cmkuqhGj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E7B220715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 48E4E882AC;
	Fri, 22 Nov 2019 15:32:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IQjwPttDSYu8; Fri, 22 Nov 2019 15:32:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0237F882B5;
	Fri, 22 Nov 2019 15:32:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E6D14C1D74;
	Fri, 22 Nov 2019 15:32:11 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 81231C18DA
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 15:32:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6A62D889CC
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 15:32:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Uvwd1TYNU7xz for <iommu@lists.linux-foundation.org>;
 Fri, 22 Nov 2019 15:32:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 153C98894D
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 15:32:09 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id z19so8088713wmk.3
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 07:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=o0Nf3geLcg9Iv2VN5DaVX7zHaQKSf02VaMj3Oj40g7s=;
 b=cmkuqhGjOwfdSwkZ3ss+85BQf54k5DwK5drxsgJ59aUf6B/dAvLhdQ3svBWsyNuhOR
 t2lOL5vWRytQrNu3oBk9S+q/yVsjrSNyFPIvcSDyEH0XASpUvwUBRwMKkEC1LAZxJK8Z
 /jLp+8jON45HOASnNIf9x/9YrfeFqw4v+CfizFYbWJl38eWeYg4fKmj/JSRzGxPqARQI
 C3t1Tm6A/E8EBhc2zA6gmdoNjPZ6fky+ZGuvqVqW6QoSuHMZ5BwEcLEnmAIVWkFHxzhj
 L8t4ZzVHn/mU77X5BkPc7byb8I4PVtKasmkxJwwzQs+FjoJ6wEfFg584rN3oNW7pyahH
 8igA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=o0Nf3geLcg9Iv2VN5DaVX7zHaQKSf02VaMj3Oj40g7s=;
 b=os3p2Pozz8AwoWABhL5LLTxQXURF9vMPi0rGaKNRDTozCOkIBxvUqekR3Ws3vqDpiJ
 8WNdvGTkH+j+QPMXt5SH4c13RdPe7QRIT1dqNVrTSc8B8UOZ6aCr7wdpj5wiBE+ivUt5
 FJJ278Lkn6uiwzVCQwVh4M86SoDxjcPwUcLolyI5/NuTxbsfzsKqR6swFdSRyYJDhVyr
 KGgncNpB7Qheo06fevp6ofk8dOnwR+GXB9yKVRpt/w5oQZufiBxd7k0up6/B3hjYIsHV
 dmoWXKVOZO4Z/GvWyrGNc03A4qBdBja4DAH+F+rOjvaqhi1WAwS2V6q3TjwemrX38Dbf
 8tCQ==
X-Gm-Message-State: APjAAAW8aPl7F/z/MwDKaxBdXhR1OPLq2beYsP4yXpOlXCdF6rGnAd44
 GekqsmSQQJ/Ntcuzuf4bFrEeJw==
X-Google-Smtp-Source: APXvYqxY6pHuhUWCVcZneY2M7eICkz+5eYgu7XtNfAm4R2SBBRGwg3zyF3DJRrQll9z97xbxElVU6Q==
X-Received: by 2002:a1c:6485:: with SMTP id y127mr3164184wmb.19.1574436726287; 
 Fri, 22 Nov 2019 07:32:06 -0800 (PST)
Received: from lophozonia (xdsl-188-155-204-106.adslplus.ch. [188.155.204.106])
 by smtp.gmail.com with ESMTPSA id o7sm6578349wrv.63.2019.11.22.07.32.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2019 07:32:05 -0800 (PST)
Date: Fri, 22 Nov 2019 16:32:03 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [PATCH v2 6/8] iommu/arm-smmu-v3: Add second level of context
 descriptor table
Message-ID: <20191122153203.GB810215@lophozonia>
References: <20191108152508.4039168-1-jean-philippe@linaro.org>
 <20191108152508.4039168-7-jean-philippe@linaro.org>
 <20191111155007.00002021@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191111155007.00002021@huawei.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, robin.murphy@arm.com,
 sudeep.holla@arm.com, rjw@rjwysocki.net, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org, guohanjun@huawei.com,
 zhangfei.gao@linaro.org, will@kernel.org, linux-arm-kernel@lists.infradead.org,
 lenb@kernel.org
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

On Mon, Nov 11, 2019 at 03:50:07PM +0000, Jonathan Cameron wrote:
> > +		cfg->l1ptr = dmam_alloc_coherent(smmu->dev, size,
> > +						 &cfg->l1ptr_dma,
> > +						 GFP_KERNEL | __GFP_ZERO);
> 
> As before.  Fairly sure __GFP_ZERO doesn't give you anything extra.

Indeed

> > +		if (!cfg->l1ptr) {
> > +			dev_warn(smmu->dev, "failed to allocate L1 context table\n");
> > +			return -ENOMEM;
> > +		}
> > +	}
> > +
> > +	cfg->tables = devm_kzalloc(smmu->dev, sizeof(struct arm_smmu_cd_table) *
> > +				   cfg->num_tables, GFP_KERNEL);
> > +	if (!cfg->tables) {
> > +		ret = -ENOMEM;
> > +		goto err_free_l1;
> > +	}
> > +
> > +	/* With two levels, leaf tables are allocated lazily */
> This comment is a kind of odd one.  It is actually talking about what
> 'doesn't' happen here I think..
> 
> Perhaps /*
>          * Only allocate a leaf table for linear case.
>          * With two levels, the leaf tables are allocated lazily.
> 	 */

Yes, that's clearer

> > +	if (!cfg->l1ptr) {
> > +		ret = arm_smmu_alloc_cd_leaf_table(smmu, &cfg->tables[0],
> > +						   max_contexts);
> > +		if (ret)
> > +			goto err_free_tables;
> > +	}
> > +
> > +	return 0;
> > +
> > +err_free_tables:
> > +	devm_kfree(smmu->dev, cfg->tables);
> > +err_free_l1:
> > +	if (cfg->l1ptr)
> > +		dmam_free_coherent(smmu->dev, size, cfg->l1ptr, cfg->l1ptr_dma);
> 
> This cleanup only occurs if we have had an error.
> Is there potential for this to rerun at some point later?  If so we should
> be careful to also reset relevant pointers - e.g. cfg->l1ptr = NULL as
> they are used to control the flow above.

Yes we should definitely clear l1ptr. The domain may be managed by a
device driver, and if attach_dev() fails they will call domain_free(),
which checks this pointer. Plus nothing prevents them from calling
attach_dev() again with the same domain.

> If there is no chance of a rerun why bother cleaning them up at all?  Something
> has gone horribly wrong so let the eventual smmu cleanup deal with them.

The domain is much shorter-lived than the SMMU device, so we need this
cleanup.

> > +	return ret;
> >  }
> >  
> >  static void arm_smmu_free_cd_tables(struct arm_smmu_domain *smmu_domain)
> >  {
> > +	int i;
> >  	struct arm_smmu_device *smmu = smmu_domain->smmu;
> >  	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
> > +	size_t num_leaf_entries = 1 << cfg->s1cdmax;
> > +	struct arm_smmu_cd_table *table = cfg->tables;
> >  
> > -	arm_smmu_free_cd_leaf_table(smmu, &cfg->table, 1 << cfg->s1cdmax);
> > +	if (cfg->l1ptr) {
> > +		size_t size = cfg->num_tables * (CTXDESC_L1_DESC_DWORDS << 3);
> > +
> > +		dmam_free_coherent(smmu->dev, size, cfg->l1ptr, cfg->l1ptr_dma);
> 
> 		As above, if we can call this in a fashion that makes sense
> 		other than in eventual smmu tear down, then we need to be
> 		careful to reset the pointers.   If not, then why are we clearing
> 		managed resourced by hand anyway?

Yes, we call this on the error cleanup path (not only domain_free()), so
it needs to leave the domain in a usable state.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
