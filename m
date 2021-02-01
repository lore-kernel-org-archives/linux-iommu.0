Return-Path: <SRS0=Rmex=HD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F08C433E6
	for <iommu@archiver.kernel.org>; Mon,  1 Feb 2021 15:15:56 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94FAA64EA3
	for <iommu@archiver.kernel.org>; Mon,  1 Feb 2021 15:15:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94FAA64EA3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5DA3A8512E;
	Mon,  1 Feb 2021 15:15:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dS_3iv9F50kp; Mon,  1 Feb 2021 15:15:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DE1AA8511F;
	Mon,  1 Feb 2021 15:15:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C0967C0FA7;
	Mon,  1 Feb 2021 15:15:54 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB43EC013A
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 15:15:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id BE3528511F
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 15:15:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dqzHq8yH64Vh for <iommu@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 15:15:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 10FC78511B
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 15:15:51 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id e15so13493105wme.0
 for <iommu@lists.linux-foundation.org>; Mon, 01 Feb 2021 07:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=iCud/oZ0jp00VRdDLSDWa/VPzMcKe48VJwPVpyKJcE8=;
 b=bljmv40viwV5v57+TtBOFwGAaz54F5a9tDXB2PSZe5+LMS1pOd9d8QiRNcEEtmVfmT
 pdNUcTuIXIUH3CaAc+wpyhYC5hKvmCSEj3iNLAZHozaqd/vHgd82MB0cpAg+LE90lF16
 4P26uy+BK3EEMlaZGLfJlDisoXkiQ0huHLkrVAmKcmxDHmxRD8LzSGmdL2Cr3wzW5T7M
 zg97INgmlfCsvWBOEZA+9NcyNVwamwDVUFyds+AxAL8QQh5KBvfc3PUTwvICN//HHTDZ
 qkNaJJ1NQUcUnxMsjuP69oEL1TAKNDjTmwV8/PCUe7VrMoqb6akq/NuC0JNy5Wkan48Y
 G81A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=iCud/oZ0jp00VRdDLSDWa/VPzMcKe48VJwPVpyKJcE8=;
 b=FTHLXz7UbN7p7Rf8OOWMvheJFHOTgM+H5sWQKLTJN2UpQMHb9dmJMx+dgc9iA6keAJ
 h25knZJJCuJYDRp4ygFYmrqULcV4HQpif+ETcaF0NpWMD4Bo7XqyeAL6delkGGdTD3YV
 N2e8xUyxQeeJTdLPdig1Kd/WPZSpunPhIfP9sW1wlGG9WyHXJU3G1Nb+9WHUk7dB1lAE
 /gOGpzxkf8oO89u+VkGrQBTFjaArAjVPslhGQi5ur92DS5lLNlg/RssFo7n0ekhfwpir
 I9WGJlmbjpTVIsKGNRDDMgJZhEpBqvzrEQUcJqz35UcRhOFFWEj/Ilq03qXWdP1Wdm46
 9G9w==
X-Gm-Message-State: AOAM533kxfY6qLHhh4HElA40nvRxNUZtXzQvzk5TqSiRHZUFx1cZajgD
 ApInVjPLZj69z16f64Ee7flkbQ==
X-Google-Smtp-Source: ABdhPJxyP1BG+oDXc31HY7CW5MYwKqTaLbVBSjGD3rpSrDcbzKlD5YRXlGtJCbFbmp87GaK0VAFutQ==
X-Received: by 2002:a7b:c8c3:: with SMTP id f3mr15569794wml.110.1612192549227; 
 Mon, 01 Feb 2021 07:15:49 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id y11sm26855292wrh.16.2021.02.01.07.15.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Feb 2021 07:15:48 -0800 (PST)
Date: Mon, 1 Feb 2021 16:15:29 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH v13 03/15] iommu/arm-smmu-v3: Maintain a SID->device
 structure
Message-ID: <YBgbESEyReLV124Z@myrica>
References: <20201118112151.25412-1-eric.auger@redhat.com>
 <20201118112151.25412-4-eric.auger@redhat.com>
 <a5cc1635-b69b-50a6-404a-5bf667296669@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a5cc1635-b69b-50a6-404a-5bf667296669@huawei.com>
Cc: alex.williamson@redhat.com, kvm@vger.kernel.org, vivek.gautam@arm.com,
 maz@kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 zhangfei.gao@linaro.org, robin.murphy@arm.com, will@kernel.org,
 kvmarm@lists.cs.columbia.edu, eric.auger.pro@gmail.com
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

On Mon, Feb 01, 2021 at 08:26:41PM +0800, Keqian Zhu wrote:
> > +static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
> > +				  struct arm_smmu_master *master)
> > +{
> > +	int i;
> > +	int ret = 0;
> > +	struct arm_smmu_stream *new_stream, *cur_stream;
> > +	struct rb_node **new_node, *parent_node = NULL;
> > +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(master->dev);
> > +
> > +	master->streams = kcalloc(fwspec->num_ids,
> > +				  sizeof(struct arm_smmu_stream), GFP_KERNEL);
> > +	if (!master->streams)
> > +		return -ENOMEM;
> > +	master->num_streams = fwspec->num_ids;
> This is not roll-backed when fail.

No need, the caller frees master

> > +
> > +	mutex_lock(&smmu->streams_mutex);
> > +	for (i = 0; i < fwspec->num_ids && !ret; i++) {
> Check ret at here, makes it hard to decide the start index of rollback.
> 
> If we fail at here, then start index is (i-2).
> If we fail in the loop, then start index is (i-1).
> 
[...]
> > +	if (ret) {
> > +		for (; i > 0; i--)
> should be (i >= 0)?
> And the start index seems not correct.

Indeed, this whole bit is wrong. I'll fix it while resending the IOPF
series.

Thanks,
Jean

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
