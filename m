Return-Path: <SRS0=A+5j=IY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADF8C433DB
	for <iommu@archiver.kernel.org>; Fri, 26 Mar 2021 09:50:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 081C961A45
	for <iommu@archiver.kernel.org>; Fri, 26 Mar 2021 09:50:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 081C961A45
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9175740499;
	Fri, 26 Mar 2021 09:50:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3q-2oWT6xuNr; Fri, 26 Mar 2021 09:50:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 11561403D4;
	Fri, 26 Mar 2021 09:50:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ECAB9C000E;
	Fri, 26 Mar 2021 09:50:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1D40FC000A
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 09:50:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F30FC40249
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 09:50:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yhTb23aRLBHe for <iommu@lists.linux-foundation.org>;
 Fri, 26 Mar 2021 09:50:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E85CC40239
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 09:50:17 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id v11so4987352wro.7
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 02:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=MnI8RxXoHJw/2x8+1FFQSE5mboYTNfWyq0YhdaWKJtM=;
 b=quboBXKApWPPi+Sz+/0FkCmAg6Kixg1YdFbqHA178/Imd3WpW8k4YpPnDU3AYAZE1U
 rC+Ro1J3QVilPT4PwBMfYdVDZH7wz57EBkcZblYlFx15hruu5y4qR2vlnNHHETe/WtcI
 uyVKWYqEj8LFhnEuLeyGExbTpH692wtLRoQSiSbr0LrzyVM6FVKsEYAEO7T2ZdmHFNQl
 idPnV8krrh1WKw9A4izsTq80vIBW+1zP2qxvWYDpkS9yx0yoJ81ydGOZsjDLkYKidqJo
 vFyHyh6IRCsxZzSHsfDvs+RCVME7Lv75nUZ/VVIkp5mJt28scLPXIztaS3sNbN/X3XdQ
 3KFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=MnI8RxXoHJw/2x8+1FFQSE5mboYTNfWyq0YhdaWKJtM=;
 b=sQ0YUF0ZvdBVvvoLjTM4RICdMI/s/7N8fPq2FyUZiKracHD/uowrMZaWFs1Oym7zuu
 aBfk+UWt1rRkU4V1V8/lmUT5ymhp6QEBopRk2H2tahxPj+nVzvGbWc0kOgXk6c4VY1tk
 xlLvidM53HD4mTl7TPZtsqEJDz+aaGteR0uAjKA5ILWm++wUt++Zo9VXhDIZg4yqqLY1
 Br/R9vReIbNpXgtauZwNN1lcdTeyLijL/7Icel3PZO7ZlRI0ZvQUk76Yg7kcl80ytPuP
 oP6tIS70Hhzew1Ih3vB8aKK6NTm8VM5tKJ9OZeJZ35y1Sd/+O+hGgJw6zt54bSeSyXwq
 M5eQ==
X-Gm-Message-State: AOAM531CelUb98UDnk0uxEeWEV3/hwC3CTH055tBeNy5xFoYq8m6O48P
 RMl7e0ID8eM9ukEYxTYQfBy2mw==
X-Google-Smtp-Source: ABdhPJy8IdrF20cvgAfp2ESQn+iJIkj1mkaWU5rGBnF/yaYKd5OSC6h+yUhCzFWqiLVTmxHEe4956A==
X-Received: by 2002:a5d:6381:: with SMTP id p1mr13820517wru.266.1616752216009; 
 Fri, 26 Mar 2021 02:50:16 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id o7sm12079801wrs.16.2021.03.26.02.50.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Mar 2021 02:50:15 -0700 (PDT)
Date: Fri, 26 Mar 2021 10:49:57 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v13 07/10] iommu/arm-smmu-v3: Maintain a SID->device
 structure
Message-ID: <YF2uRXoUwFSAmQWI@myrica>
References: <20210302092644.2553014-1-jean-philippe@linaro.org>
 <20210302092644.2553014-8-jean-philippe@linaro.org>
 <20210325174807.GD15504@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210325174807.GD15504@willie-the-truck>
Cc: devicetree@vger.kernel.org, kevin.tian@intel.com,
 linux-acpi@vger.kernel.org, sudeep.holla@arm.com, rjw@rjwysocki.net,
 vivek.gautam@arm.com, iommu@lists.linux-foundation.org, robh+dt@kernel.org,
 linux-accelerators@lists.ozlabs.org, guohanjun@huawei.com,
 zhangfei.gao@linaro.org, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org, lenb@kernel.org
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

On Thu, Mar 25, 2021 at 05:48:07PM +0000, Will Deacon wrote:
> > +/* smmu->streams_mutex must be held */
> 
> Can you add a lockdep assertion for that?

Sure

> > +__maybe_unused
> > +static struct arm_smmu_master *
> > +arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
> > +{
> > +	struct rb_node *node;
> > +	struct arm_smmu_stream *stream;
> > +
> > +	node = smmu->streams.rb_node;
> > +	while (node) {
> > +		stream = rb_entry(node, struct arm_smmu_stream, node);
> > +		if (stream->id < sid)
> > +			node = node->rb_right;
> > +		else if (stream->id > sid)
> > +			node = node->rb_left;
> > +		else
> > +			return stream->master;
> > +	}
> > +
> > +	return NULL;
> > +}
> 
> [...]
> 
> > +static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
> > +				  struct arm_smmu_master *master)
> > +{
> > +	int i;
> > +	int ret = 0;
> > +	struct arm_smmu_stream *new_stream, *cur_stream;
> > +	struct rb_node **new_node, *parent_node = NULL;
> > +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(master->dev);
> > +
> > +	master->streams = kcalloc(fwspec->num_ids, sizeof(*master->streams),
> > +				  GFP_KERNEL);
> > +	if (!master->streams)
> > +		return -ENOMEM;
> > +	master->num_streams = fwspec->num_ids;
> > +
> > +	mutex_lock(&smmu->streams_mutex);
> > +	for (i = 0; i < fwspec->num_ids; i++) {
> > +		u32 sid = fwspec->ids[i];
> > +
> > +		new_stream = &master->streams[i];
> > +		new_stream->id = sid;
> > +		new_stream->master = master;
> > +
> > +		/*
> > +		 * Check the SIDs are in range of the SMMU and our stream table
> > +		 */
> > +		if (!arm_smmu_sid_in_range(smmu, sid)) {
> > +			ret = -ERANGE;
> > +			break;
> > +		}
> > +
> > +		/* Ensure l2 strtab is initialised */
> > +		if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) {
> > +			ret = arm_smmu_init_l2_strtab(smmu, sid);
> > +			if (ret)
> > +				break;
> > +		}
> > +
> > +		/* Insert into SID tree */
> > +		new_node = &(smmu->streams.rb_node);
> > +		while (*new_node) {
> > +			cur_stream = rb_entry(*new_node, struct arm_smmu_stream,
> > +					      node);
> > +			parent_node = *new_node;
> > +			if (cur_stream->id > new_stream->id) {
> > +				new_node = &((*new_node)->rb_left);
> > +			} else if (cur_stream->id < new_stream->id) {
> > +				new_node = &((*new_node)->rb_right);
> > +			} else {
> > +				dev_warn(master->dev,
> > +					 "stream %u already in tree\n",
> > +					 cur_stream->id);
> > +				ret = -EINVAL;
> > +				break;
> > +			}
> > +		}
> > +		if (ret)
> > +			break;
> > +
> > +		rb_link_node(&new_stream->node, parent_node, new_node);
> > +		rb_insert_color(&new_stream->node, &smmu->streams);
> > +	}
> > +
> > +	if (ret) {
> > +		for (i--; i >= 0; i--)
> 
> Is 'i--' really what you want for the initial value? Doesn't that correspond
> to the ID you *didn't* add to the tree?

In case of error we break out of the loop, with i corresponding to the
stream that caused a fault but wasn't yet added to the tree. So i-- is
the last stream that was successfully added, or -1 in which case we don't
enter this for loop.

> > +			rb_erase(&master->streams[i].node, &smmu->streams);
> > +		kfree(master->streams);
> 
> Do you need to NULLify master->streams and/or reset master->num_streams
> after this? Seems like they're left dangling.

master is freed by arm_smmu_probe_device() when we return an error. Since
this function is unlikely to ever have another caller I didn't bother
cleaning up here

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
