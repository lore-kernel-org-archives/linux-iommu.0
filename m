Return-Path: <SRS0=OemM=6S=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3666AC47259
	for <iommu@archiver.kernel.org>; Mon,  4 May 2020 16:25:58 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC13E20707
	for <iommu@archiver.kernel.org>; Mon,  4 May 2020 16:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NPOSWeTN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC13E20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BAD4286670;
	Mon,  4 May 2020 16:25:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VSAlFO9BKj3V; Mon,  4 May 2020 16:25:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4293B86277;
	Mon,  4 May 2020 16:25:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C47AC088C;
	Mon,  4 May 2020 16:25:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D6D3EC0175
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 16:25:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id C4E6488058
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 16:25:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a2mXf+MXAhxP for <iommu@lists.linux-foundation.org>;
 Mon,  4 May 2020 16:25:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 8238988055
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 16:25:53 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id x17so21702848wrt.5
 for <iommu@lists.linux-foundation.org>; Mon, 04 May 2020 09:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=GL2JHfWb2mPYeSgeIH5WeIgVbATF3Ra0zLGdb9HxWZQ=;
 b=NPOSWeTNC3Un3eskvozXKMxNnsJ6r9fc/sgBE1d6gnYLdALaK8wjIX/j58IvqfxFmC
 cJ7U5u96OPGUoehpQYLz0ggsicjiGrgSLC1dqZkfAjTE0uE8MD2K1WFx/8y4Pzbpbd5R
 z1XLioC0bjQNb3+Z6msYsAptNDoFZ4CqIP/741UwHR5xz+ADrwIsStOoAMCNc23vCn0O
 CkGZuVDFZP0sdQAJ3dIDW/VXYBbjPmqlBAyRLYt21m9Bo4iyUVDnyUPUU+K5e2tYxPpF
 W5ts90uOmnfyFrIy99D6BSUc9rUBir+ZREIxahMT07HpDKv5DXmykWAMqamGEhd1zCAa
 cW9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=GL2JHfWb2mPYeSgeIH5WeIgVbATF3Ra0zLGdb9HxWZQ=;
 b=O1HnFiSD1JSlNq+HOb656HbDrRWMozo1PBaLTzcWvcqU5cAT9e1Y/E9a1U1bWQc2T/
 cBkH386ZQe2dAfNChz0bZctERtyF6kmLaNe7RXmXX4OrTA6Jxw1h0WkQfvpPk1HEx5A0
 uY8DMDatwgvl84bO9V9VWk6zN+fF4seNctB7OnOaDs+2D5B6xnZUsfZNGPMDywlSoTn4
 Oglch85/0cSWb9XgZKUqwR+hNnPh4y+KZx4VNzXyV+kQgGMYHsaNMUWavOEsbiYC09dx
 HYV67LwPn6duvY0x1osB51cH35ZHeNjuHwR1srJm2Ij5kEOKmwlzMqWtYqBvhxa7NDJ6
 Gjyg==
X-Gm-Message-State: AGi0Pua18v0bgslbs/9CkQxRu1PCRDn/+X0qdVxb4SDLPEpcI1uUnJ3+
 X/fh3J7B+mZTsZkPZy+AhHIJZg==
X-Google-Smtp-Source: APiQypJewC2A5eJu+LlIEsZxNgowtLfUPSFwzAN1NtAObzTj2fsi/+uiw7oQbS2F9/ABw1GE+6Cvxw==
X-Received: by 2002:adf:f606:: with SMTP id t6mr7882808wrp.321.1588609551965; 
 Mon, 04 May 2020 09:25:51 -0700 (PDT)
Received: from myrica ([2001:171b:226e:c200:c43b:ef78:d083:b355])
 by smtp.gmail.com with ESMTPSA id r15sm6980383wrq.93.2020.05.04.09.25.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 09:25:51 -0700 (PDT)
Date: Mon, 4 May 2020 18:25:41 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v6 05/25] iommu/iopf: Handle mm faults
Message-ID: <20200504162541.GG170104@myrica>
References: <20200430143424.2787566-1-jean-philippe@linaro.org>
 <20200430143424.2787566-6-jean-philippe@linaro.org>
 <9fc0e4cc-1242-bf96-5328-cc9039dcc9b6@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9fc0e4cc-1242-bf96-5328-cc9039dcc9b6@linux.intel.com>
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

On Sun, May 03, 2020 at 01:54:36PM +0800, Lu Baolu wrote:
> On 2020/4/30 22:34, Jean-Philippe Brucker wrote:
> > When a recoverable page fault is handled by the fault workqueue, find the
> > associated mm and call handle_mm_fault.
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > ---
> > v5->v6: select CONFIG_IOMMU_SVA
> > ---
> >   drivers/iommu/Kconfig      |  1 +
> >   drivers/iommu/io-pgfault.c | 79 +++++++++++++++++++++++++++++++++++++-
> >   2 files changed, 78 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > index 4f33e489f0726..1e64ee6592e16 100644
> > --- a/drivers/iommu/Kconfig
> > +++ b/drivers/iommu/Kconfig
> > @@ -109,6 +109,7 @@ config IOMMU_SVA
> >   config IOMMU_PAGE_FAULT
> >   	bool
> > +	select IOMMU_SVA
> 
> It would be better to move this to the previous patch.
> 
[...]
> > @@ -104,6 +156,29 @@ static void iopf_handle_group(struct work_struct *work)
> >    *
> >    * Add a fault to the device workqueue, to be handled by mm.
> >    *
> > + * This module doesn't handle PCI PASID Stop Marker; IOMMU drivers must discard
> > + * them before reporting faults. A PASID Stop Marker (LRW = 0b100) doesn't
> > + * expect a response. It may be generated when disabling a PASID (issuing a
> > + * PASID stop request) by some PCI devices.
> > + *
> > + * The PASID stop request is issued by the device driver before unbind(). Once
> > + * it completes, no page request is generated for this PASID anymore and
> > + * outstanding ones have been pushed to the IOMMU (as per PCIe 4.0r1.0 - 6.20.1
> > + * and 10.4.1.2 - Managing PASID TLP Prefix Usage). Some PCI devices will wait
> > + * for all outstanding page requests to come back with a response before
> > + * completing the PASID stop request. Others do not wait for page responses, and
> > + * instead issue this Stop Marker that tells us when the PASID can be
> > + * reallocated.
> > + *
> > + * It is safe to discard the Stop Marker because it is an optimization.
> > + * a. Page requests, which are posted requests, have been flushed to the IOMMU
> > + *    when the stop request completes.
> > + * b. We flush all fault queues on unbind() before freeing the PASID.
> > + *
> > + * So even though the Stop Marker might be issued by the device *after* the stop
> > + * request completes, outstanding faults will have been dealt with by the time
> > + * we free the PASID.
> > + *
> >    * Return: 0 on success and <0 on error.
> >    */
> >   int iommu_queue_iopf(struct iommu_fault *fault, void *cookie)
> > 
> 
> The same for the comments.

I think I'll squash both patches, probably doesn't make it harder to
review.

Thanks,
Jean

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
