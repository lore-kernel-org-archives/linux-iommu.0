Return-Path: <SRS0=Rmex=HD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7BEC433E6
	for <iommu@archiver.kernel.org>; Mon,  1 Feb 2021 11:14:48 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD9AF60295
	for <iommu@archiver.kernel.org>; Mon,  1 Feb 2021 11:14:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD9AF60295
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7F23786961;
	Mon,  1 Feb 2021 11:14:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6yWfv4-rexVz; Mon,  1 Feb 2021 11:14:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id BE4578694B;
	Mon,  1 Feb 2021 11:14:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 96930C0FA7;
	Mon,  1 Feb 2021 11:14:46 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 002CDC013A
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 11:14:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id E8F3186F72
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 11:14:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L1TmxYx+iohM for <iommu@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 11:14:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 1164286F66
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 11:14:45 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id f16so12278935wmq.5
 for <iommu@lists.linux-foundation.org>; Mon, 01 Feb 2021 03:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=L2OCKKQQHglqUwYJM9UBUI+jPzsS7a6jZ5mkXorxUPk=;
 b=N5BZOmcQ5eaoia0uXY2fCg9xo8VYDzkvrXIaWmQwtR+0Z8YRR6TlUeDokPLVe5BCAW
 H3DC+wWCtna8njs76VVMhasaFKCAmpk4MXeFzqZT20bYlATjWYenkCVu1g/0mPrjcl0j
 vnUIqMT+MDwaZrWmgHMw2Sm12ewqP8o6plvIvTPhLqrOZ3p5Yi21gzjj/uR53DxDIbI2
 ADPvi5zgh2zFy7ir5STtR3+suU4Ff1pwnOABA6sqUUNBYg1DDwphrMiys69QC5ku3nEm
 +L2ZMenCdJkhpE9TKQV1cBrKC0bGo/JGER5i3i9dpNa/XF2aCYYWDNo7jd7jF/w5ofp8
 Zicg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=L2OCKKQQHglqUwYJM9UBUI+jPzsS7a6jZ5mkXorxUPk=;
 b=W1+sQxJIrBDncOdpDGwy1Ubdra5qCwsZkLcPa8w08WmcDcUMROA/7zUEhrsIwvOBC8
 ZDlAKbRmxh8Wyis9vGDTaB1EOKf/upAOyCFdzhk3ZkTdnk4dkF4Dri45lB4MRWSkx1RA
 0SAbEQjwcK8Ebt9uyRsB64ZPu9ATEWz8LjlyncF/fIc4yXv9MPSF1Z1MbmaVlnNutu5g
 irs/LhvwVfyoyhC55Bfg5hEm56BFrmWaOpSQMkdSW8qgAFWfcNPx1MmbqjMn4b0s3lGr
 schkqZInwOryU7KXF310l1wBi/+LSSx60Wsh4TFX3/drslq5gYI8luoEdwuROX08r+sQ
 8e8A==
X-Gm-Message-State: AOAM532ehiSiCmfcTQ7lLSNU2lp0VEXaTcdm+OPHWccITsjfAfzrqe3m
 by5RqHAw9DCe5xrYIRkQ2RLrdA==
X-Google-Smtp-Source: ABdhPJxHrA/jAlwYZxpdhywNDQAzvWYPSxBihzr6oYOFEMnHxFQec2SJ/QJ9CVoDRLEeW3uaLbQm5w==
X-Received: by 2002:a7b:c09a:: with SMTP id r26mr1165953wmh.60.1612178083354; 
 Mon, 01 Feb 2021 03:14:43 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id e4sm27187437wrw.96.2021.02.01.03.14.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Feb 2021 03:14:42 -0800 (PST)
Date: Mon, 1 Feb 2021 12:14:23 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Zhou Wang <wangzhou1@hisilicon.com>
Subject: Re: [PATCH v12 10/10] iommu/arm-smmu-v3: Add stall support for
 platform devices
Message-ID: <YBfij71tyYvh8LhB@myrica>
References: <20210127154322.3959196-1-jean-philippe@linaro.org>
 <20210127154322.3959196-11-jean-philippe@linaro.org>
 <8adc79cc-7afb-dfe8-4f7b-07fa6dc5b905@hisilicon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8adc79cc-7afb-dfe8-4f7b-07fa6dc5b905@hisilicon.com>
Cc: devicetree@vger.kernel.org, kevin.tian@intel.com,
 linux-acpi@vger.kernel.org, robin.murphy@arm.com, sudeep.holla@arm.com,
 rjw@rjwysocki.net, vivek.gautam@arm.com, iommu@lists.linux-foundation.org,
 robh+dt@kernel.org, linux-accelerators@lists.ozlabs.org, guohanjun@huawei.com,
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

Hi Zhou,

On Mon, Feb 01, 2021 at 09:18:42AM +0800, Zhou Wang wrote:
> > @@ -1033,8 +1076,7 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
> >  			FIELD_PREP(CTXDESC_CD_0_ASID, cd->asid) |
> >  			CTXDESC_CD_0_V;
> >  
> > -		/* STALL_MODEL==0b10 && CD.S==0 is ILLEGAL */
> > -		if (smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
> > +		if (smmu_domain->stall_enabled)
> 
> Could we add ssid checking here? like: if (smmu_domain->stall_enabled && ssid).
> The reason is if not CD.S will also be set when ssid is 0, which is not needed.

Some drivers may want to get stall events on SSID 0:
https://lore.kernel.org/kvm/20210125090402.1429-1-lushenming@huawei.com/#t

Are you seeing an issue with stall events on ssid 0?  Normally there
shouldn't be any fault on this context, but if they happen and no handler
is registered, the SMMU driver will just abort them and report them like a
non-stall event.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
