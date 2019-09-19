Return-Path: <SRS0=51CA=XO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB1CC3A5A6
	for <iommu@archiver.kernel.org>; Thu, 19 Sep 2019 15:05:36 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 979EA21848
	for <iommu@archiver.kernel.org>; Thu, 19 Sep 2019 15:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RxBIEWkz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 979EA21848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 5D944CA1;
	Thu, 19 Sep 2019 15:05:36 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 75FB7C83
	for <iommu@lists.linux-foundation.org>;
	Thu, 19 Sep 2019 15:05:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
	[209.85.208.67])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id CA613876
	for <iommu@lists.linux-foundation.org>;
	Thu, 19 Sep 2019 15:05:25 +0000 (UTC)
Received: by mail-ed1-f67.google.com with SMTP id c4so3554278edl.0
	for <iommu@lists.linux-foundation.org>;
	Thu, 19 Sep 2019 08:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=yic2bDSQvOGyK05i6zWexPg+z8iu2akZCAIBwfSlM4U=;
	b=RxBIEWkzx/5W626K0TPy3NrQD+9xUc2EtjQq5wij6HuQ4p6J8/jo5dqn0wVA5Xnd18
	m6jKndTL7m3KJWdcqYOd4bsX0jZ7Vpbu5CEpsnoYfC/es2QHVjlN1+TMtJpntIs21qlr
	O11fuKKCW0K7V+2I6q9rIXJZFLDAbAN7KSxiBeGQmspKYs5LogftnMCA/QSS4D+5fbOf
	AKHw+EUSbdFxbZeYccacevGazTtWWjnf3dPhGTeBsBgjYaCXheAf3LA/dFJlW8vnlUeK
	e6jlulH6fQf0bErESyCyq7GoPE2/efqefs5t7xY6Sd2zGC8XeaCm1KufYPTcGcBnoC/D
	QXdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=yic2bDSQvOGyK05i6zWexPg+z8iu2akZCAIBwfSlM4U=;
	b=uNMwJnmoJNj0zmrKUXsPlv5YYZ/ofwuVBe44lKBME7aZUoGf0K+o8XxW4P+Iv2/tUm
	JF0gjRTk46WSRHeCok8CtkuSkxXc10EK8CPRQa/95NolikevZirJnNov2Ri+hAfMPRRe
	hqAIGCJVKzWQFN5Dm4d1sG1injTKMUeJmWVi+he/yG1OV44VRNWLJnyVPQYE9U7O2Rcp
	4SM/b9NGucPhLcwqxSCJcO/oLGb2mvB9qFN0Ri4AI+oWBAg1JiWiTU93Ggm9KnuXJqZC
	wXCXyaWyQuVIRgpdIprjF2JVXGMDUxQ+ajcHpDDolKP2QypdczNSxPNdVRAIux3jOCW0
	/eig==
X-Gm-Message-State: APjAAAXZGtmpQmma/UpNpt+JAC8Psxf9LEmPox2bOLH/BFQVFQI0SDz3
	SixUGc9lMkiQ8sliI4e2zVL1Ew==
X-Google-Smtp-Source: APXvYqxNqq5i16Ldy9K5kJrRzW5FWYXXym5RB8VVgZepY0ldECJaTECor9Qc5brFdyWW9WM/8SUoEA==
X-Received: by 2002:a17:906:76c2:: with SMTP id
	q2mr14903775ejn.202.1568905524420; 
	Thu, 19 Sep 2019 08:05:24 -0700 (PDT)
Received: from lophozonia ([85.195.192.192]) by smtp.gmail.com with ESMTPSA id
	e39sm1689919edb.69.2019.09.19.08.05.23
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Thu, 19 Sep 2019 08:05:23 -0700 (PDT)
Date: Thu, 19 Sep 2019 17:05:21 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH 5/8] iommu/arm-smmu-v3: Add second level of context
	descriptor table
Message-ID: <20190919150521.GD1013538@lophozonia>
References: <20190610184714.6786-1-jean-philippe.brucker@arm.com>
	<20190610184714.6786-6-jean-philippe.brucker@arm.com>
	<3e69caf7-4e8a-4bce-7a89-51e21a0134b1@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3e69caf7-4e8a-4bce-7a89-51e21a0134b1@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	robh+dt@kernel.org, robin.murphy@arm.com
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

On Mon, Jul 08, 2019 at 05:13:05PM +0200, Auger Eric wrote:
> >  #define STRTAB_STE_0_S1FMT		GENMASK_ULL(5, 4)
> >  #define STRTAB_STE_0_S1FMT_LINEAR	0
> > +#define STRTAB_STE_0_S1FMT_4K_L2	1
> As you only use 64kB L2, I guess you can remove the 4K define?

I prefer defining all values, but I suppose I can get rid of it.

> > +	cfg->tables = devm_kzalloc(smmu->dev, sizeof(struct arm_smmu_cd_table) *
> > +				   cfg->num_tables, GFP_KERNEL);
> > +	if (!cfg->tables)
> > +		return -ENOMEM;
> goto err_free_l1
> > +
> > +	ret = arm_smmu_alloc_cd_leaf_table(smmu, &cfg->tables[0], num_leaf_entries);
> don't you want to do that only in linear case. In 2-level mode, I
> understand arm_smmu_get_cd_ptr() will do the job.

OK, that might be better

> 
> > +	if (ret)
> > +		goto err_free_l1;
> > +
> > +	if (cfg->l1ptr)
> > +		arm_smmu_write_cd_l1_desc(cfg->l1ptr, &cfg->tables[0]);
> that stuff could be removed as well?

Yes

> By the way I can see that
> arm_smmu_get_cd_ptr() does a arm_smmu_sync_cd after. wouldn't it be
> needed here as well?

No context table is reachable from a STE at this point, so we don't have
to invalidate anything.

> > @@ -1815,7 +1935,7 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
> >  	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
> >  		struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
> >  
> > -		if (cfg->table.ptr) {
> > +		if (cfg->tables) {
> >  			arm_smmu_free_cd_tables(smmu_domain);
> >  			arm_smmu_bitmap_free(smmu->asid_map, cfg->cd.asid);
> I don't get why the arm_smmu_bitmap_free is dependent on cfg->tables.

Simply because arm_smmu_bitmap_alloc() and arm_smmu_alloc_cd_tables()
are both performed in arm_smmu_domain_finalise_s1(). A domain returned
by arm_smmu_domain_alloc() is not fully initialized, it still needs to
be finalized by arm_smmu_attach_dev(). So here we check whether the
domain has been finalized or not. Zero being a valid ASID in this
driver, we can't check whether cfg->cd.asid is valid, so we check
cfg->tables instead.

And I forgot to clear cfg->tables after failure of domain_finalise in
this series, I'll need to fix it.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
