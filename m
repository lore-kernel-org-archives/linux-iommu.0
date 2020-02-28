Return-Path: <SRS0=BxgK=4Q=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80AADC3F2D2
	for <iommu@archiver.kernel.org>; Fri, 28 Feb 2020 14:44:38 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AF6E246A3
	for <iommu@archiver.kernel.org>; Fri, 28 Feb 2020 14:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JCRrLIEo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AF6E246A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 12416833C6;
	Fri, 28 Feb 2020 14:44:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ePF1EYujoi5B; Fri, 28 Feb 2020 14:44:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9D2E6873B8;
	Fri, 28 Feb 2020 14:44:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84299C08A0;
	Fri, 28 Feb 2020 14:44:33 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D506C0177
 for <iommu@lists.linux-foundation.org>; Fri, 28 Feb 2020 14:44:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id EBB9D2267B
 for <iommu@lists.linux-foundation.org>; Fri, 28 Feb 2020 14:44:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7u+qpnqguyne for <iommu@lists.linux-foundation.org>;
 Fri, 28 Feb 2020 14:44:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by silver.osuosl.org (Postfix) with ESMTPS id CF28B2075B
 for <iommu@lists.linux-foundation.org>; Fri, 28 Feb 2020 14:44:28 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id d138so1856681wmd.5
 for <iommu@lists.linux-foundation.org>; Fri, 28 Feb 2020 06:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=EaNst+hWQycMu0KGsnv4CxZ9Si7qKvgKxC1mvggZU4w=;
 b=JCRrLIEo6Jpe8dHIBFGmuTXIFtETxczvLzWf5uy8Y4Rm9R7wgxKO+2afcz/GNnH0Y3
 q0tqjcxhgffbbsl10LWkrDKFYFGroNVipFdobpiY+ORfr6InAZrnVRnUUJdKxAKtACEM
 dTxklEFgeMyTkRclu9MCF6ibbvsenPwWRDYZLFrWvg+m8RzwfWoY6XELfqEtrbGkmQ5q
 TgpYmhbgZkm0bFXzLd85KOOeaNDPUJQuCrD90Ya9ovii8HTS+dVU1eWttG0owswwOm8u
 MFcNQWUAz9eoCClWH9QiIu0LftzF5ZzkomXsU1JPNJCynNEi1BYGHsYrU8xBnhT/OP6K
 8hMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=EaNst+hWQycMu0KGsnv4CxZ9Si7qKvgKxC1mvggZU4w=;
 b=q+6F/03/Ov25EFuz7sWGZQvxfVLkeyU2zYEgS2oNV96o/cU5kgPDzY+Md6A0G/5TTq
 lhatUkU1OBXQpuklMaBMXfvB6F/hSWwSTZspPOI70VaOBEF9o9wf8PFwob1huo56rKZl
 Il2uKoqkuvslt2wtZmq9EvWO6WUPOGkEiNB+I9+2GuV/umUcCik3pnteRxTCwUkF5zgG
 Gxtq0otKI/2KFv7cheItKITiXtpMV41L/0k4hEyHRaukFA8PU5/8TEgR6upVWDIITzmv
 zurCjAC03JX1GNjh3i++qWosudagE56wrv2BIQxP5dPoQCxDVFi5FN/F6qxurDP627YC
 SsxQ==
X-Gm-Message-State: APjAAAUdpTpe60a7eLweJorqI5+X/vbzr0zfyH1IuP2hEQKpLGJkZp6S
 hTft9LfL6UHfCKkJKcs0vWM+Qw==
X-Google-Smtp-Source: APXvYqwmzNWF57lJGnnMPvJ7KLRmrlfEQjMUS3cUSNh6ONuPqWLfuhP1DtkFcJz13ydjNSUlBxXNAQ==
X-Received: by 2002:a7b:c4d0:: with SMTP id g16mr3359111wmk.3.1582901067287;
 Fri, 28 Feb 2020 06:44:27 -0800 (PST)
Received: from myrica ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id n11sm2001521wrq.40.2020.02.28.06.44.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 06:44:26 -0800 (PST)
Date: Fri, 28 Feb 2020 15:44:20 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v4 06/26] iommu/sva: Register page fault handler
Message-ID: <20200228144420.GE2156@myrica>
References: <20200224182401.353359-1-jean-philippe@linaro.org>
 <20200224182401.353359-7-jean-philippe@linaro.org>
 <20200226113959.62621098@jacob-builder>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200226113959.62621098@jacob-builder>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, kevin.tian@intel.com,
 Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
 linux-pci@vger.kernel.org, robin.murphy@arm.com, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org, catalin.marinas@arm.com,
 zhangfei.gao@linaro.org, will@kernel.org, christian.koenig@amd.com,
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

On Wed, Feb 26, 2020 at 11:39:59AM -0800, Jacob Pan wrote:
> > @@ -442,11 +444,20 @@ static void iommu_sva_unbind_locked(struct
> > iommu_bond *bond) 
> >  void iommu_sva_unbind_generic(struct iommu_sva *handle)
> >  {
> > +	int pasid;
> >  	struct iommu_param *param = handle->dev->iommu_param;
> >  
> >  	if (WARN_ON(!param))
> >  		return;
> >  
> > +	/*
> > +	 * Caller stopped the device from issuing PASIDs, now make
> > sure they are
> > +	 * out of the fault queue.
> > +	 */
> > +	pasid = iommu_sva_get_pasid_generic(handle);
> > +	if (pasid != IOMMU_PASID_INVALID)
> > +		iopf_queue_flush_dev(handle->dev, pasid);
> > +
> I have an ordering concern.
> The caller can only stop the device issuing page request but there will
> be in-flight request inside the IOMMU. If we flush here before clearing
> the PASID context, there might be new request coming in before the
> detach.

The goal of this flush is also to clear the IOMMU PRI queue. It calls the
IOMMU's flush() callback before flushing the workqueue. So when this
returns, there shouldn't be any more pending fault.

Thanks,
Jean

> How about detach first then flush? Then anything come after the detach
> would be faults. Flush will be clean.
> 
> >  	mutex_lock(&param->sva_lock);
> >  	mutex_lock(&iommu_sva_lock);
> >  	iommu_sva_unbind_locked(to_iommu_bond(handle));
> > @@ -484,6 +495,10 @@ int iommu_sva_enable(struct device *dev, struct
> > iommu_sva_param *sva_param) goto err_unlock;
> >  	}
> >  
> > +	ret = iommu_register_device_fault_handler(dev,
> > iommu_queue_iopf, dev);
> > +	if (ret)
> > +		goto err_unlock;
> > +
> >  	dev->iommu_param->sva_param = new_param;
> >  	mutex_unlock(&param->sva_lock);
> >  	return 0;
> > @@ -521,6 +536,7 @@ int iommu_sva_disable(struct device *dev)
> >  		goto out_unlock;
> >  	}
> >  
> > +	iommu_unregister_device_fault_handler(dev);
> >  	kfree(param->sva_param);
> >  	param->sva_param = NULL;
> >  out_unlock:
> 
> [Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
