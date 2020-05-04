Return-Path: <SRS0=OemM=6S=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A40C3A5A9
	for <iommu@archiver.kernel.org>; Mon,  4 May 2020 14:26:07 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AF31206D7
	for <iommu@archiver.kernel.org>; Mon,  4 May 2020 14:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z1iuPCF+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AF31206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id DC5C588933;
	Mon,  4 May 2020 14:26:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qQ0X5aiBYWHY; Mon,  4 May 2020 14:26:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3D3FE88914;
	Mon,  4 May 2020 14:26:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 371DAC088C;
	Mon,  4 May 2020 14:26:06 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F3523C0175
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 14:26:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E18BB87D86
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 14:26:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sC-a7Nf55U4D for <iommu@lists.linux-foundation.org>;
 Mon,  4 May 2020 14:26:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by whitealder.osuosl.org (Postfix) with ESMTPS id BB52888039
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 14:26:03 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id d15so21200168wrx.3
 for <iommu@lists.linux-foundation.org>; Mon, 04 May 2020 07:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=F/z0V3mcBGUp+syXehq8FDmPP6eWJmRKpReZL7dY1ho=;
 b=z1iuPCF+taVGKa11c2yjWNjOpHuDo1RB1E7mbiG1WoVCEMCNh5P8g+itjpP3FUb4gs
 mCE66WIAwk3XxYtzkPIlMa2cgsSYqPT/sHmkzg7ZxXM+z96IIV31FcsFHFSq4qIafaMB
 24lM1ATRxsNNtieYoZwGa57aXFJ3ATXi47XR5U3U8SyqHQfieuZVpCa6NuqP10uVhaer
 GlXWtziftzxxoED82b0x2bP5555Q3FS+QQfHvURtC/EZAjTaNVZME8nZQsu/VQSLGBQV
 3URfU7Lb1juS31WTwwRasil1iZl8t0N/SPOSiqBJE6kdXsxH3add7ofJV2qxRW9qCi7T
 V46g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=F/z0V3mcBGUp+syXehq8FDmPP6eWJmRKpReZL7dY1ho=;
 b=rdYvCyEMj/hxcKze2vKkOAMeqEhxelPuKGgT2Udw2SynLZZstRX7tk1HMgsGgYm9E6
 fajfPFUBhJ/vEteIiBGRrb88ahlr9UKM0u5pmmSJIhv+tmhmNDmsbXGO2C4wLjR8JLsB
 NOItp2ntKk0tCXFxHAqCCqTafrQXT98dTxHnFMe22sRtpiGNbzOGwW9lMlnaCZsHvIoV
 jGgc7kZL9apkUxEnmnaDAx+nf+b48HDRrxRv/PWk02GVUp4ulL4BPCvcdJ8qV5EpIRNz
 1MK5mGxFkyEZcVQ/i2sXcX8zeFau4JglsQEqIDE37erGTIrlbksHH/w7baqEJy3OmBum
 qxJA==
X-Gm-Message-State: AGi0PubA+CQrcRxtJcbSFlFbFurVa8bV5Qt+OUGzYvSNRwaQykhXyuPb
 1SWCe0CfU5Uj9NrM3O0tvmvhzA==
X-Google-Smtp-Source: APiQypJvR/uVsrLrYsoae/U5bNYqj69oeGktdTlceIG72vmnH3x2R6717uW94oIHTrpwNOfPUuH1bw==
X-Received: by 2002:adf:e745:: with SMTP id c5mr9977426wrn.263.1588602361937; 
 Mon, 04 May 2020 07:26:01 -0700 (PDT)
Received: from myrica ([2001:171b:226e:c200:c43b:ef78:d083:b355])
 by smtp.gmail.com with ESMTPSA id a205sm14484714wmh.29.2020.05.04.07.25.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 07:26:01 -0700 (PDT)
Date: Mon, 4 May 2020 16:25:48 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v6 02/25] iommu/ioasid: Add ioasid references
Message-ID: <20200504142548.GB170104@myrica>
References: <20200430143424.2787566-1-jean-philippe@linaro.org>
 <20200430143424.2787566-3-jean-philippe@linaro.org>
 <20200430113931.0fbf7a37@jacob-builder>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200430113931.0fbf7a37@jacob-builder>
Cc: devicetree@vger.kernel.org, kevin.tian@intel.com, jgg@ziepe.ca,
 linux-pci@vger.kernel.org, robin.murphy@arm.com, fenghua.yu@intel.com,
 hch@infradead.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 zhangfei.gao@linaro.org, catalin.marinas@arm.com, felix.kuehling@amd.com,
 will@kernel.org, christian.koenig@amd.com,
 linux-arm-kernel@lists.infradead.org
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

On Thu, Apr 30, 2020 at 11:39:31AM -0700, Jacob Pan wrote:
> > +/**
> > + * ioasid_get - obtain a reference to the IOASID
> > + */
> > +void ioasid_get(ioasid_t ioasid)
> why void? what if the ioasid is not valid.

My intended use was for the caller to get an additional reference when
they're already holding one. So this should always succeed and I'd prefer
a WARN_ON if the ioasid isn't valid rather than returning an error. But if
you intend to add a state to ioasids between dropping refcount and free,
then a return value makes sense.

Thanks,
Jean

> 
> > +{
> > +	struct ioasid_data *ioasid_data;
> > +
> > +	spin_lock(&ioasid_allocator_lock);
> > +	ioasid_data = xa_load(&active_allocator->xa, ioasid);
> > +	if (ioasid_data)
> > +		refcount_inc(&ioasid_data->refs);
> > +	spin_unlock(&ioasid_allocator_lock);
> > +}
> > +EXPORT_SYMBOL_GPL(ioasid_get);
> > +
> >  /**
> >   * ioasid_free - Free an IOASID
> >   * @ioasid: the ID to remove
> > + *
> > + * Put a reference to the IOASID, free it when the number of
> > references drops to
> > + * zero.
> > + *
> > + * Return: %true if the IOASID was freed, %false otherwise.
> >   */
> > -void ioasid_free(ioasid_t ioasid)
> > +bool ioasid_free(ioasid_t ioasid)
> >  {
> > +	bool free = false;
> >  	struct ioasid_data *ioasid_data;
> >  
> >  	spin_lock(&ioasid_allocator_lock);
> > @@ -360,6 +383,10 @@ void ioasid_free(ioasid_t ioasid)
> >  		goto exit_unlock;
> >  	}
> >  
> > +	free = refcount_dec_and_test(&ioasid_data->refs);
> > +	if (!free)
> > +		goto exit_unlock;
> > +
> Just FYI, we may need to add states for the IOASID, i.g. mark the IOASID
> inactive after free. And prohibit ioasid_get() after freed. For VT-d,
> this is useful when KVM queries the IOASID.
> 
> >  	active_allocator->ops->free(ioasid,
> > active_allocator->ops->pdata); /* Custom allocator needs additional
> > steps to free the xa element */ if (active_allocator->flags &
> > IOASID_ALLOCATOR_CUSTOM) { @@ -369,6 +396,7 @@ void
> > ioasid_free(ioasid_t ioasid) 
> >  exit_unlock:
> >  	spin_unlock(&ioasid_allocator_lock);
> > +	return free;
> >  }
> >  EXPORT_SYMBOL_GPL(ioasid_free);
> >  
> 
> [Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
