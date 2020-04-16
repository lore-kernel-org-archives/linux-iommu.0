Return-Path: <SRS0=meaX=6A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99198C352BE
	for <iommu@archiver.kernel.org>; Thu, 16 Apr 2020 08:54:16 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E89620784
	for <iommu@archiver.kernel.org>; Thu, 16 Apr 2020 08:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LLp5LveC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E89620784
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 365BA84785;
	Thu, 16 Apr 2020 08:54:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GR2ZhzV6Kygw; Thu, 16 Apr 2020 08:54:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 31C7A845D5;
	Thu, 16 Apr 2020 08:54:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 14028C1AE8;
	Thu, 16 Apr 2020 08:54:15 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4B1BCC0172
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 08:54:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 3C86E20499
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 08:54:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3w3BeEmwR0nN for <iommu@lists.linux-foundation.org>;
 Thu, 16 Apr 2020 08:54:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by silver.osuosl.org (Postfix) with ESMTPS id 056032033E
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 08:54:12 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id j2so3839055wrs.9
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 01:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=ZEfcdbyCoFlwcBaVZ+sf0k9hPs9ies0vbK3IcfLzskw=;
 b=LLp5LveCwz1C/4FgavId+LAMO+lPQeQAh5i6g/dwBkd5KRmxdDAOZ9/FDSM6LaE2DO
 Td6D1PD2vfJMUfU418BKIvqN2n542k0/GOSD1zFfk3KEg6YVnVpiYcQElgtfTWfhW1Hc
 pyRHcoAoIzLIeqmthE1eiaqNblTBPZh2QK//NuiYOH4m49CJlMjlge+Af8W0dLnPXfDM
 TI6i6FGWr2uL3dkWfiES2q+uTGrtmI8VH2eWwpnuQoWS1aDfIKdtLlIrcAMs/dkatob5
 C2RU6qFiWHenxSdOpD61IuhKr0PagtaYgwqeoLijcAccCZ9r8LhwudjqfQNZwoQRmc4d
 jdrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ZEfcdbyCoFlwcBaVZ+sf0k9hPs9ies0vbK3IcfLzskw=;
 b=JQXpSfnPBlmLpTjG10fgqxHakm3wozOZLggqT/umU3yp/G1CFNZ3ZGcafMLgzWIU8M
 VzAtQAyjsZGPlcVCZ3SZmkrdRFoSjeZ8riDDFlRVQbUxsI905Cq+wUkwq6n8K4t4gNJt
 rmOYv2GwQ0MZiyaqA2V3zn87380HmbSCKyB2oFniRtdk9ovmmGQP5qYtwNQ1wsTwJ/PM
 Tpa/2fvCJmTE55AvNCIFh3Qs8OrjXnrMN1LC6j77lGRCCBKD6XIb8y+zLacZL9uam3Js
 E4FhC52izi+1W3qopqDXHlrhUiUHYV3buGyAVVOomrG7xKnXFeNa7oWIjzydZP1S/Gw9
 ZQ5A==
X-Gm-Message-State: AGi0PubqVfFVKJujoZrjchyqyVFbEwtqi4POzAb198cPkNvocznk7ZRS
 OvaFemoh8kAcJUCsgjX9PLkmvA==
X-Google-Smtp-Source: APiQypL1oyr16FXQx+dkfWQBU6EhMLZhnOgOJbCMSB0gnYSQVADLx4g3CAzdUNtaCRw76OTkBu7LoA==
X-Received: by 2002:a5d:6305:: with SMTP id i5mr34790010wru.203.1587027251542; 
 Thu, 16 Apr 2020 01:54:11 -0700 (PDT)
Received: from myrica ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id u7sm3027041wmg.41.2020.04.16.01.54.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2020 01:54:11 -0700 (PDT)
Date: Thu, 16 Apr 2020 10:54:02 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v5 02/25] iommu/sva: Manage process address spaces
Message-ID: <20200416085402.GB1286150@myrica>
References: <20200414170252.714402-1-jean-philippe@linaro.org>
 <20200414170252.714402-3-jean-philippe@linaro.org>
 <20200416072852.GA32000@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200416072852.GA32000@infradead.org>
Cc: devicetree@vger.kernel.org, kevin.tian@intel.com, jgg@ziepe.ca,
 linux-pci@vger.kernel.org, robin.murphy@arm.com, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, catalin.marinas@arm.com,
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

On Thu, Apr 16, 2020 at 12:28:52AM -0700, Christoph Hellwig wrote:
> > +	rcu_read_lock();
> > +	hlist_for_each_entry_rcu(bond, &io_mm->devices, mm_node)
> > +		io_mm->ops->invalidate(bond->sva.dev, io_mm->pasid, io_mm->ctx,
> > +				       start, end - start);
> > +	rcu_read_unlock();
> > +}
> 
> What is the reason that the devices don't register their own notifiers?
> This kinds of multiplexing is always rather messy, and you do it for
> all the methods.

This sends TLB and ATC invalidations through the IOMMU, it doesn't go
through device drivers

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
