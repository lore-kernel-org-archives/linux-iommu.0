Return-Path: <SRS0=Z7Xn=ZO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE62C432C0
	for <iommu@archiver.kernel.org>; Fri, 22 Nov 2019 15:29:03 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D8602071C
	for <iommu@archiver.kernel.org>; Fri, 22 Nov 2019 15:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q9GzTlqV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D8602071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 42A272634D;
	Fri, 22 Nov 2019 15:29:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vZrPHhNYIgXj; Fri, 22 Nov 2019 15:29:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 854DD26316;
	Fri, 22 Nov 2019 15:29:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7B4B7C1D74;
	Fri, 22 Nov 2019 15:29:02 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EAAF1C18DA
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 15:29:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E06202634A
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 15:29:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u2p-gG8h2psf for <iommu@lists.linux-foundation.org>;
 Fri, 22 Nov 2019 15:29:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by silver.osuosl.org (Postfix) with ESMTPS id CC21F26316
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 15:28:59 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id z10so9048660wrs.12
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 07:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=bulVco3x5RbtgZKCmOeZiFAb5Gkkb3vLwxv8AF+VAkY=;
 b=Q9GzTlqVYlBDZzMNegrITDii27IgR3IK5WfFZHntNMd+fNndRTZvnF0Y9JXBAp02j4
 Q3utWX2LIc6T71HyM443zyXV0xcbCnl+7tukYnqFwJc40A9d02yrOs1la2NUbRKNCzHc
 IoAjBkwePqj9yyEES+NAqG4qSs4BbjDNH0lJH5BxANRbRJaZc6M9jxWOfwf7FAMgGZqa
 IY/IfM2G+F4zOvbk1MFrxQzo4GdIgvSZStHTXJ6+8FpSzNlFpmCsO6KzRp9YXbjUGGsk
 Ech/tSuTMEFaXw+1Hv0u5F0mEbnjnjC0uk2C+xWaC7ZQ4JPuvhOun/zz9+4v8SAroEss
 72Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=bulVco3x5RbtgZKCmOeZiFAb5Gkkb3vLwxv8AF+VAkY=;
 b=eoTO/2GTQdFnnfkwzijP2gT8iGKikJRf+sE2vQHu55z0xYYJLZvbVjRYajESl56mpV
 OP9aOa/thK61aextINqiVant7G3VAtbDxI72WmTowdGv7h8FqEhbqUFdELXpArcihsgR
 KBzvwAMJbwr/yYamOEAsuWgwqUcVSu4Ii2KdIIBWPMfuBJU9Q2t3E8QNM1WwtWsZ8TcV
 mb29ZT/lGu1M02MdFqmBSb7PQSFVuG3vrTszhHfd6ZxArWWhhb87miyjawZpdLhgrDa/
 pUnfQohwYeCb2N/8ib30T6ilbDagHvJT0fcP9bb+pUpEjMHS7JH7b0qBD1JdvuNDBybX
 wqsA==
X-Gm-Message-State: APjAAAWPq19/Gje+VCK6driAFH/hFz3JWtXwIvL3q5y5nLM9ckjRyMC4
 YdwE/6mdVW5yo7O+43vrq2vV2g==
X-Google-Smtp-Source: APXvYqwOX0Dilhgc/nDjGbOaBj9FTyzevqPcc87fg5C6SHcB5UJa1/dVicXnsRQ/Z3QR3D9DkVOWGQ==
X-Received: by 2002:a5d:5308:: with SMTP id e8mr10812570wrv.77.1574436538287; 
 Fri, 22 Nov 2019 07:28:58 -0800 (PST)
Received: from lophozonia (xdsl-188-155-204-106.adslplus.ch. [188.155.204.106])
 by smtp.gmail.com with ESMTPSA id o21sm3789117wmc.17.2019.11.22.07.28.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2019 07:28:57 -0800 (PST)
Date: Fri, 22 Nov 2019 16:28:55 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [PATCH v2 4/8] iommu/arm-smmu-v3: Prepare for SSID support
Message-ID: <20191122152855.GA810215@lophozonia>
References: <20191108152508.4039168-1-jean-philippe@linaro.org>
 <20191108152508.4039168-5-jean-philippe@linaro.org>
 <20191111143811.000006cc@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191111143811.000006cc@huawei.com>
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

On Mon, Nov 11, 2019 at 02:38:11PM +0000, Jonathan Cameron wrote:
> Hmm. There are several different refactors in here alongside a few new
> bits.  Would be nice to break it up more to make life even easier for
> reviewers.   It's not 'so' complex that it's really a problem though
> so could leave it as is if you really want to.

Sure, I'll see if I can split it more in next version.

> > +	table->ptr = dmam_alloc_coherent(smmu->dev, size, &table->ptr_dma,
> > +					 GFP_KERNEL | __GFP_ZERO);
> 
> We dropped dma_zalloc_coherent because we now zero in dma_alloc_coherent
> anyway.  Hence I'm fairly sure that __GFP_ZERO should have no effect.
> 
> https://lore.kernel.org/patchwork/patch/1031536/
> 
> Am I missing some special corner case here?

Here I just copied the GFP flags already in use. But removing all
__GFP_ZERO from the driver would make a good cleanup patch.

> > -	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1)
> > -		arm_smmu_write_ctx_desc(smmu, &smmu_domain->s1_cfg);
> > -
> 
> Whilst it seems fine, perhaps a note on the 'why' of moving this into
> finalise_s1 would be good in the patch description.

Ok. Since it's only to simplify the handling of allocation failure in a
subsequent patch, I think I'll move that part over there.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
