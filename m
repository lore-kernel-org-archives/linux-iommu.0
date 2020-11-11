Return-Path: <SRS0=hwFB=ER=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11E0C388F9
	for <iommu@archiver.kernel.org>; Wed, 11 Nov 2020 13:58:15 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C3FF2074B
	for <iommu@archiver.kernel.org>; Wed, 11 Nov 2020 13:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PX5YSlcx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C3FF2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7B6AA8753F;
	Wed, 11 Nov 2020 13:58:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ht4yyV-WTy3z; Wed, 11 Nov 2020 13:58:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id CEF2B87544;
	Wed, 11 Nov 2020 13:58:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BE288C0889;
	Wed, 11 Nov 2020 13:58:13 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 98EA3C016F
 for <iommu@lists.linux-foundation.org>; Wed, 11 Nov 2020 13:58:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 935C887544
 for <iommu@lists.linux-foundation.org>; Wed, 11 Nov 2020 13:58:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F5gIlwDABGyK for <iommu@lists.linux-foundation.org>;
 Wed, 11 Nov 2020 13:58:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id AA2138753F
 for <iommu@lists.linux-foundation.org>; Wed, 11 Nov 2020 13:58:10 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id c17so2584076wrc.11
 for <iommu@lists.linux-foundation.org>; Wed, 11 Nov 2020 05:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Bg58Nuvlkki+FL9k9rnhWH9yWYXQkDaY8dFISymQNf4=;
 b=PX5YSlcxcGmSZg8r/sp2D0I5JTHOJyKFcuVZxLO1fiouCfjYWFBADilQDWAd0Zg9Sd
 HIfJ/J4cOjkRzfvjnj1WMh/LKncrPEtfWeva76W8jYJ5GBV9QsvF6eKzhO5TLf58/h3Y
 9SHRXS3ggYLKFZJgaiWZUr0gnAEq+xCsESwyC2lrlYNo+T1yDCho+DSiFZax7SLWk8Kc
 qS+/kEN2EY8zDLbcFnyYa3Hzli6iLHqYJh3b8/FneQUgK84gqG6h1k7T94Ji4UfDLetv
 p3Xs14pIjTNueMnPgMl2lVXzAS9+JjhDnXFy1NouXt6C7VZY0sEXk+8MnG75YWkKX/C+
 MxRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Bg58Nuvlkki+FL9k9rnhWH9yWYXQkDaY8dFISymQNf4=;
 b=i2Hd8juNycpBGVkOhRrzQqarnBGac2uB+vDIMM/ffGiSq8E+Xn9kAKwe2MWUtLKjcf
 FOevTGhuSqOa3GLla0yd/qEmvH+aoJzBeUSj0zdI1MNvDw1LHnQel5PDRwwSBBkXgbJu
 PTyMesApf3iQCRd7O2grvifVGhEE6aI8tS9Rjv86UupCHIbtoRXUSP22VJJNuYkIf0vb
 MvGnLZF7RLWXR57jMKeR4ihyKPSoULzzNI8edeGl5FXBUvPVyqgEuVD7p0b1byLZcsr+
 16QiMPrHA02TTZQyyprl7JPfvFVFkJbo6HxImw/rgrvNoP3fcXphIzfBw0dAyjvpHemB
 CrZw==
X-Gm-Message-State: AOAM530Mbv8dgNqrpLg8XPa+3+bmiDGnmBr7Un5TvawA2thcTaa2/8bb
 pQd55qAJFV6sN69yY+Cx7srpwg==
X-Google-Smtp-Source: ABdhPJw6IjBDWuhoEyhqDsHpEgNzVVOxVUrrMBm3b8SRWwCRsVl0IlzCByu/s34c5pnWmTrWJJOQPA==
X-Received: by 2002:adf:f9cb:: with SMTP id w11mr26381611wrr.1.1605103089202; 
 Wed, 11 Nov 2020 05:58:09 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id b8sm2551407wmj.9.2020.11.11.05.58.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2020 05:58:08 -0800 (PST)
Date: Wed, 11 Nov 2020 14:57:50 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Xiang Zheng <zhengxiang9@huawei.com>
Subject: Re: [PATCH v7 04/24] iommu: Add a page fault handler
Message-ID: <20201111135750.GA2617489@myrica>
References: <20200519175502.2504091-1-jean-philippe@linaro.org>
 <20200519175502.2504091-5-jean-philippe@linaro.org>
 <422e84da-9ccb-5452-8cbf-f472d2ad16b5@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <422e84da-9ccb-5452-8cbf-f472d2ad16b5@huawei.com>
Cc: devicetree@vger.kernel.org, kevin.tian@intel.com, will@kernel.org,
 fenghua.yu@intel.com, jgg@ziepe.ca, linux-pci@vger.kernel.org,
 christian.koenig@amd.com, hch@infradead.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Wang Haibin <wanghaibin.wang@huawei.com>,
 catalin.marinas@arm.com, zhangfei.gao@linaro.org, robin.murphy@arm.com,
 felix.kuehling@amd.com, linux-arm-kernel@lists.infradead.org
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

Hi Xiang,

Thank you for reviewing this. I forgot to send a reply, sorry for the
delay.

On Fri, May 29, 2020 at 05:18:27PM +0800, Xiang Zheng wrote:
> Hi,
> 
> On 2020/5/20 1:54, Jean-Philippe Brucker wrote:
> > Some systems allow devices to handle I/O Page Faults in the core mm. For
> > example systems implementing the PCIe PRI extension or Arm SMMU stall
> > model. Infrastructure for reporting these recoverable page faults was
> > added to the IOMMU core by commit 0c830e6b3282 ("iommu: Introduce device
> > fault report API"). Add a page fault handler for host SVA.
> > 
> > IOMMU driver can now instantiate several fault workqueues and link them
> > to IOPF-capable devices. Drivers can choose between a single global
> > workqueue, one per IOMMU device, one per low-level fault queue, one per
> > domain, etc.
> > 
> > When it receives a fault event, supposedly in an IRQ handler, the IOMMU
> > driver reports the fault using iommu_report_device_fault(), which calls
> > the registered handler. The page fault handler then calls the mm fault
> > handler, and reports either success or failure with iommu_page_response().
> > When the handler succeeded, the IOMMU retries the access.
> > 
> > The iopf_param pointer could be embedded into iommu_fault_param. But
> > putting iopf_param into the iommu_param structure allows us not to care
> > about ordering between calls to iopf_queue_add_device() and
> > iommu_register_device_fault_handler().
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
[...]
> > +/**
> > + * iopf_queue_free - Free IOPF queue
> > + * @queue: queue to free
> > + *
> > + * Counterpart to iopf_queue_alloc(). The driver must not be queuing faults or
> > + * adding/removing devices on this queue anymore.
> > + */
> > +void iopf_queue_free(struct iopf_queue *queue)
> > +{
> > +	struct iopf_device_param *iopf_param, *next;
> > +
> > +	if (!queue)
> > +		return;
> > +
> > +	list_for_each_entry_safe(iopf_param, next, &queue->devices, queue_list)
> > +		iopf_queue_remove_device(queue, iopf_param->dev);
> > +
> > +	destroy_workqueue(queue->wq);
> 
> Do we need to free iopf_group(s) here in case the work queue of the group(s) are not
> scheduled yet? If that occurs, we might leak memory here.

Partial groups are freed by iopf_queue_remove_device(), and all other
groups are freed when destroy_workqueue() executes the remaining work.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
