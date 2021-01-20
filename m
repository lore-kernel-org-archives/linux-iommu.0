Return-Path: <SRS0=mF+O=GX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CCDC433E0
	for <iommu@archiver.kernel.org>; Wed, 20 Jan 2021 17:55:52 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF57223122
	for <iommu@archiver.kernel.org>; Wed, 20 Jan 2021 17:55:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF57223122
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7A37620357;
	Wed, 20 Jan 2021 17:55:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RcZgTETojqHV; Wed, 20 Jan 2021 17:55:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 3BE432038B;
	Wed, 20 Jan 2021 17:55:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0F18CC088B;
	Wed, 20 Jan 2021 17:55:49 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E38BCC013A
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 17:55:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id DDD0385C20
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 17:55:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4NoU45f-o+mC for <iommu@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 17:55:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 26BF885C7D
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 17:55:45 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id l12so18711806wry.2
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 09:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=u9d5u2rU+oUC3PSlRpvM5/qU7mQebSKD882Pr796bxs=;
 b=wEnitb2FT1wKDf1iNM7t56LriFK4O7jTr2wCXes6P2kZJt+uv2bOsBYl05PBc67RH3
 ki0Mp8eoch3QTMyJQqFtnCTTan938j+tP/G06YgZdIhAkpCxq0yYDC/apO5qVi0ZOpgV
 5cp+DimAxrvWAqyXhlgcq57wD3/c6z26cc7l9+YX5SpA3U1RXHaIopSp64TzfqO3Jm+9
 +43mtK1dITx3LWvkypY1YtZPmHgwt9+T2WyQZLoYzAfZExLHbKOF+4FH8fr8BTEPqhud
 K3fr5ZlvbiOHrRmL7nElGamCR1LC9Il92GcLPi5B7aHUOm0cb2fnWKmwLJJrNJ18BBA5
 2HEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=u9d5u2rU+oUC3PSlRpvM5/qU7mQebSKD882Pr796bxs=;
 b=ixYtLzOZ+aiJg9tWTmXp/SxHIaz9PhejnwKeY4YeomPlgI5ioMvC0hB1jprp/i9vLv
 qo8VP21YnfaiZfEbHZghu08H/Qi8fZSlURKUUBgVVWViXJWuAs4m7V5pNyx9gJ7miYVh
 3vC5kBtKRksOn0cR6ffomnDXf//OkAONCzDV1MIVd2ukDEIjJfgDaZz+qPmE1weaFvUK
 KXZLRfdqWanLi7ziNXsq5b7ORSdGVKsNn5orq4NZxEkHpDRc9Dgv9GhP6lq20Qx1hrMx
 ERSV9vpZBtXbXSNYFNCW9d+2XgmEo8IBp2iplRKLM4ZfXBkaq4u1XtBHy6ePpXKxe/O/
 neAg==
X-Gm-Message-State: AOAM530bBHZlMywDQt2znFqff7xCCnPiGW2+N4g5ebJYIttQvlD+xGpy
 0nh8F8yw0kVqc2Ey60smPDInRQ==
X-Google-Smtp-Source: ABdhPJxYz9wWmfwCtCBcKPiQmZrmimspu6SwMfoxK1Eays8A9xFacgdeujsrMNO5XqeMv6Tbgovf9g==
X-Received: by 2002:a5d:4987:: with SMTP id r7mr10727143wrq.352.1611165343667; 
 Wed, 20 Jan 2021 09:55:43 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id m18sm5608010wrw.43.2021.01.20.09.55.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Jan 2021 09:55:42 -0800 (PST)
Date: Wed, 20 Jan 2021 18:55:23 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v9 10/10] iommu/arm-smmu-v3: Add stall support for
 platform devices
Message-ID: <YAhui7UOw7743shI@myrica>
References: <20210108145217.2254447-1-jean-philippe@linaro.org>
 <20210108145217.2254447-11-jean-philippe@linaro.org>
 <d36d0edd-6762-41e0-2082-d9c08c125524@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d36d0edd-6762-41e0-2082-d9c08c125524@arm.com>
Cc: devicetree@vger.kernel.org, vivek.gautam@arm.com, sudeep.holla@arm.com,
 rjw@rjwysocki.net, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, guohanjun@huawei.com,
 zhangfei.gao@linaro.org, will@kernel.org, linux-accelerators@lists.ozlabs.org,
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

On Tue, Jan 19, 2021 at 05:28:21PM +0000, Robin Murphy wrote:
> On 2021-01-08 14:52, Jean-Philippe Brucker wrote:
> > +#define EVTQ_1_PRIV			(1UL << 33)
> > +#define EVTQ_1_EXEC			(1UL << 34)
> > +#define EVTQ_1_READ			(1UL << 35)
> 
> Nit: personally I'd find it a little clearer if these were named PnU, InD,
> and RnW to match the architecture, but quite possibly that's just me and
> those are gibberish to everyone else...

No problem, I think it's still decipherable without a spec

> > +bool arm_smmu_master_iopf_enabled(struct arm_smmu_master *master)
> > +{
> > +	bool enabled;
> > +
> > +	mutex_lock(&sva_lock);
> > +	enabled = master->iopf_enabled;
> > +	mutex_unlock(&sva_lock);
> 
> Forgive me for being dim, but what's the locking synchronising against here?
> If we're expecting that master->iopf_enabled can change at any time, isn't
> whatever we've read potentially already invalid as soon as we've dropped the
> lock?

Right, no reason to lock this. I doubt the lock in sva_enabled() is
necessary either, I could remove it in a separate patch.

> > +static int arm_smmu_page_response(struct device *dev,
> > +				  struct iommu_fault_event *unused,
> > +				  struct iommu_page_response *resp)
> > +{
> > +	struct arm_smmu_cmdq_ent cmd = {0};
> > +	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> > +	int sid = master->streams[0].id;
> 
> If that's going to be the case, should we explicitly prevent multi-stream
> devices from opting in to faults at all?

Sure I'll add a check in iopf_supported(). Dealing with multi-stream
devices should be easy enough (record the incoming SID into
iommu_fault_event and fetch it back here), it just didn't seem necessary
for the moment.

> > +	if (evt[1] & EVTQ_1_STALL) {
> > +		flt->type = IOMMU_FAULT_PAGE_REQ;
> > +		flt->prm = (struct iommu_fault_page_request) {
> > +			.flags = IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE,
> > +			.grpid = FIELD_GET(EVTQ_1_STAG, evt[1]),
> > +			.perm = perm,
> > +			.addr = FIELD_GET(EVTQ_2_ADDR, evt[2]),
> > +		};
> > +
> > +		if (ssid_valid) {
> > +			flt->prm.flags |= IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
> > +			flt->prm.pasid = FIELD_GET(EVTQ_0_SSID, evt[0]);
> > +		}
> 
> So if we get a bad ATS request with R=1, or a TLB/CFG conflict or any other
> imp-def event which happens to have bit 95 set, we might try to report it as
> something pageable? I would have thought we should look at the event code
> before *anything* else.

Yes I definitely need to fix this

> > @@ -2250,6 +2383,12 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
> >   			smmu_domain->s1_cfg.s1cdmax, master->ssid_bits);
> >   		ret = -EINVAL;
> >   		goto out_unlock;
> > +	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
> > +		   smmu_domain->stall_enabled != master->stall_enabled) {
> 
> I appreciate that it's probably a fair bit more complex, but it would be
> nice to at least plan for resolving this decision later (i.e. at a point
> where a caller shows an interest in actually using stalls) in future.
> Obviously the first devices advertising stall capabilities will be the ones
> that do want to use it for their primary functionality, that are driving the
> work here. However once this all matures, firmwares may start annotating any
> stallable devices as such for completeness, rather than assuming any
> specific usage. At that point it would be a pain if, say, assigning two
> devices to the same VFIO domain for old-fashioned pinned DMA, was suddenly
> prevented for irrelevant reasons just because of a DT/IORT update.

It is more complex but possible. Device drivers signal their intent to use
stall by enabling IOMMU_DEV_FEAT_IOPF, so we can postpone setting CD.S
until then. We'll still need to make sure all devices attached to a domain
support it, and prevent attaching a device that can't handle stall to a
stall-enabled domain since it would inherit all CDs. Then there will be
drivers wanting to receive stall events for context #0 and handle them by
issuing iommu_map() calls (unpinned VFIO, mentioned by Baolu on patch
3). That requires setting and clearing CD.S live. So it is doable but I'd
rather leave it for later.

> > @@ -2785,6 +2943,7 @@ static int arm_smmu_cmdq_init(struct arm_smmu_device *smmu)
> >   static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
> >   {
> >   	int ret;
> > +	bool sva = arm_smmu_sva_supported(smmu);
> >   	/* cmdq */
> >   	ret = arm_smmu_init_one_queue(smmu, &smmu->cmdq.q, ARM_SMMU_CMDQ_PROD,
> > @@ -2804,6 +2963,12 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
> >   	if (ret)
> >   		return ret;
> > +	if (sva && smmu->features & ARM_SMMU_FEAT_STALLS) {
> 
> Surely you could just test for ARM_SMMU_FEAT_SVA by now rather than go
> through the whole of arm_smmu_sva_supported() again?

Oh right, that was dumb

Thanks for the review
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
