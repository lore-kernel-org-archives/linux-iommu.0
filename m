Return-Path: <SRS0=51CA=XO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139F3C49ED7
	for <iommu@archiver.kernel.org>; Thu, 19 Sep 2019 15:06:42 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D91E521924
	for <iommu@archiver.kernel.org>; Thu, 19 Sep 2019 15:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sm1kYe9P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D91E521924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 9E391CA1;
	Thu, 19 Sep 2019 15:06:41 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 78AA1C83
	for <iommu@lists.linux-foundation.org>;
	Thu, 19 Sep 2019 15:06:40 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
	[209.85.208.66])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B3D0A876
	for <iommu@lists.linux-foundation.org>;
	Thu, 19 Sep 2019 15:06:37 +0000 (UTC)
Received: by mail-ed1-f66.google.com with SMTP id c4so3558263edl.0
	for <iommu@lists.linux-foundation.org>;
	Thu, 19 Sep 2019 08:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=oUQUKfGGLyoufGiv0FoEyuW3RCfv5lyXYP4LRA9yUnI=;
	b=sm1kYe9P5pTViCKFjNk/d6ebqMWyJNooZxf91TSUePYb/5i7/VaEYPsMPIc2wfZVi8
	P/ooqN0dZaXdOGopagPyYfk47lN5uurdLwK5TuwLmyhYW1FITstvFCYOZDjE+2XBbEGs
	DVxBofb6ZPhP/lrm+qE4xpNtlFMAcMZAd1Ca6mP8mwuQVxEQi5Rsqjk+fTKinMoccU00
	yhhDKLGlRrtw55fnv6F+DBvplwGlSB8NUvnA7oH0UD9rik/SsDa/qisHAdtFxMcNHJ5E
	poqcqtsjOyIKhSbiF+IAS/z0wbnfXeBUqDE1jU6R7i186QYsRgMIkQLl1pqPo1r1IhhB
	MT4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=oUQUKfGGLyoufGiv0FoEyuW3RCfv5lyXYP4LRA9yUnI=;
	b=VyDLuoNwr8PIb3A4VmPXtgTJq5RJDVUxDREJ4y/EqOBWVC7nJv2xoEjgiDN7UIDbCa
	LfxKKtVx4xaTRUVAoqg3HqhhcD+pVENJ5hXuu9AKwHf0RoBcjrXX/flNTakmuxYFvf/q
	je9bWITL03ZjKFN1NIBoioKCWezgdOKPor+05ncn0mFr6RA1CuYecxKB0kfyBVv9Pntg
	CmNEKi+p5VZf/+QR/lZh24qLBgz3WnruvMupJ5/ca/qePvQRX1bF/KJmZoL4jC5sQi1N
	sU1IgBILGb02OdcuiwMUlTKoQmLSB3j2koCuKbpK16BeiwSjvQrljkV2Yw3L1HkJhs4z
	bDNw==
X-Gm-Message-State: APjAAAXCD0cGe3mDTZfWgtd54iAU8lokl4OUt6S1I6ccffxrhNfcTarE
	O7/MMFVKlui2joGbzdKOGIpjeQ==
X-Google-Smtp-Source: APXvYqyS7bkpasvboOin36PhpvvHG70FNN59FYjP0q8duVqRlwWW9FcPkvkPkK/8rnvVy/QAXxBLOw==
X-Received: by 2002:aa7:d295:: with SMTP id w21mr9488517edq.302.1568905596363; 
	Thu, 19 Sep 2019 08:06:36 -0700 (PDT)
Received: from lophozonia ([85.195.192.192]) by smtp.gmail.com with ESMTPSA id
	a19sm1374424edy.37.2019.09.19.08.06.35
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Thu, 19 Sep 2019 08:06:35 -0700 (PDT)
Date: Thu, 19 Sep 2019 17:06:34 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH 6/8] iommu/arm-smmu-v3: Support auxiliary domains
Message-ID: <20190919150634.GE1013538@lophozonia>
References: <20190610184714.6786-1-jean-philippe.brucker@arm.com>
	<20190610184714.6786-7-jean-philippe.brucker@arm.com>
	<20190626175959.ubxvb2qn4taclact@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190626175959.ubxvb2qn4taclact@willie-the-truck>
User-Agent: Mutt/1.12.1 (2019-06-15)
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	robh+dt@kernel.org, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org
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

On Wed, Jun 26, 2019 at 06:59:59PM +0100, Will Deacon wrote:
> > @@ -666,8 +668,14 @@ struct arm_smmu_domain {
> >  
> >  	struct iommu_domain		domain;
> >  
> > +	/* Unused in aux domains */
> >  	struct list_head		devices;
> >  	spinlock_t			devices_lock;
> > +
> > +	/* Auxiliary domain stuff */
> > +	struct arm_smmu_domain		*parent;
> > +	ioasid_t			ssid;
> > +	unsigned long			aux_nr_devs;
> 
> Maybe use a union to avoid comments about what is used/unused?

OK

> > +static void arm_smmu_aux_detach_dev(struct iommu_domain *domain, struct device *dev)
> > +{
> > +	struct iommu_domain *parent_domain;
> > +	struct arm_smmu_domain *parent_smmu_domain;
> > +	struct arm_smmu_master *master = dev_to_master(dev);
> > +	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> > +
> > +	if (!arm_smmu_dev_feature_enabled(dev, IOMMU_DEV_FEAT_AUX))
> > +		return;
> > +
> > +	parent_domain = iommu_get_domain_for_dev(dev);
> > +	if (!parent_domain)
> > +		return;
> > +	parent_smmu_domain = to_smmu_domain(parent_domain);
> > +
> > +	mutex_lock(&smmu_domain->init_mutex);
> > +	if (!smmu_domain->aux_nr_devs)
> > +		goto out_unlock;
> > +
> > +	if (!--smmu_domain->aux_nr_devs) {
> > +		arm_smmu_write_ctx_desc(parent_smmu_domain, smmu_domain->ssid,
> > +					NULL);
> > +		/*
> > +		 * TLB doesn't need invalidation since accesses from the device
> > +		 * can't use this domain's ASID once the CD is clear.
> > +		 *
> > +		 * Sadly that doesn't apply to ATCs, which are PASID tagged.
> > +		 * Invalidate all other devices as well, because even though
> > +		 * they weren't 'officially' attached to the auxiliary domain,
> > +		 * they could have formed ATC entries.
> > +		 */
> > +		arm_smmu_atc_inv_domain(smmu_domain, 0, 0);
> 
> I've been struggling to understand the locking here, since both
> arm_smmu_write_ctx_desc and arm_smmu_atc_inv_domain take and release the
> devices_lock for the domain. Is there not a problem with devices coming and
> going in-between the two calls?

Yes, I need to think about this more. I bet there are plenty more issues
like this. For example I don't think I currently prevent the parent
domain from disappearing while auxiliary domains are attached.

> >  static struct iommu_ops arm_smmu_ops = {
> >  	.capable		= arm_smmu_capable,
> >  	.domain_alloc		= arm_smmu_domain_alloc,
> > @@ -2539,6 +2772,13 @@ static struct iommu_ops arm_smmu_ops = {
> >  	.of_xlate		= arm_smmu_of_xlate,
> >  	.get_resv_regions	= arm_smmu_get_resv_regions,
> >  	.put_resv_regions	= arm_smmu_put_resv_regions,
> > +	.dev_has_feat		= arm_smmu_dev_has_feature,
> > +	.dev_feat_enabled	= arm_smmu_dev_feature_enabled,
> > +	.dev_enable_feat	= arm_smmu_dev_enable_feature,
> > +	.dev_disable_feat	= arm_smmu_dev_disable_feature,
> 
> Why can't we use the existing ->capable and ->dev_{get,set}_attr callbacks
> for this?

->capable isn't very useful because it applies to all SMMUs in the
system. The existing ->{get,set}_attr callbacks apply to an
iommu_domain. I think the main reason for doing it on endpoints was that
it would be tedious to keep track of capabilities when attaching and
detaching devices to a domain, especially for drivers that allow
multiple IOMMUs per domain [1]. There were more discussions, and in the
end we agreed on this API for device attributes [2].

Thanks,
Jean

[1] https://lore.kernel.org/lkml/aa1ff748-c2ec-acc0-f1d9-cdff2b131e58@linux.intel.com/
[2] https://lore.kernel.org/linux-iommu/20181207102926.GM16835@8bytes.org/

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
