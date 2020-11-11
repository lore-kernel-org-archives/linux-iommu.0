Return-Path: <SRS0=hwFB=ER=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D391C55ABD
	for <iommu@archiver.kernel.org>; Wed, 11 Nov 2020 13:58:07 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D7BC2072C
	for <iommu@archiver.kernel.org>; Wed, 11 Nov 2020 13:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OIo6Gpxu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D7BC2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B5A062A128;
	Wed, 11 Nov 2020 13:58:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TUKwl9MsreSM; Wed, 11 Nov 2020 13:58:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id B9503203B8;
	Wed, 11 Nov 2020 13:58:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 80E4FC0889;
	Wed, 11 Nov 2020 13:58:04 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 12278C016F
 for <iommu@lists.linux-foundation.org>; Wed, 11 Nov 2020 13:58:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id CB298228B4
 for <iommu@lists.linux-foundation.org>; Wed, 11 Nov 2020 13:58:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Lm1vrZsz1MBk for <iommu@lists.linux-foundation.org>;
 Wed, 11 Nov 2020 13:58:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by silver.osuosl.org (Postfix) with ESMTPS id 4875A203B8
 for <iommu@lists.linux-foundation.org>; Wed, 11 Nov 2020 13:58:01 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id p1so2588042wrf.12
 for <iommu@lists.linux-foundation.org>; Wed, 11 Nov 2020 05:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=nQxC580B2FGMz7fwoWGS/qV6OQLc0KLPED3qOpuBky8=;
 b=OIo6GpxukW3iK2MLSyvALt9frkeXd0ZXiyBWhhzmAxpU0yk9P7jOnHruqZKBQccZFO
 pi2tyWBjPtyBjL5dZIjocD5ciZf7y4jaSEPp7AQg7jVQhBrcZUkooG6dMykqfIKrnwAm
 cmTpHvTYivjJDMqffwVQNg3EIBx4N6ItwiIASsWC7oJFIABzF84mUeLhNduPpkE/B5fD
 zU74Wu3AXxpByDpPLbPJvtqj5iCgSkmn2qtMTKJ496VYWlXJFryVRfSUhAyN/CXGuD78
 QJiksGLXHFV1oaOcVmLLsBMjUdF+nYRlOKoiB/1ocK79gkEdbrKkmG95wo2oynjwhkmg
 RIqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=nQxC580B2FGMz7fwoWGS/qV6OQLc0KLPED3qOpuBky8=;
 b=Wo0zv6DEzw1OAwOIy/3ogRI9JBb4QX1MS0ePvlchP/+X3ZDo9EmTtKMJreNF8RvA2N
 7SPlfE4z/W4BucciGTe8fyZvezP81mw8WlmBka4YcNE0PxGVhUAIsy8mC38IachlSd/m
 wqyUNU11vxkWuasX/YXpSOY/vDZqoWuCLgNPyc4dqEUdIQsZRmwZuLRoGiVq7P5ix9gJ
 UwC1SNJKIWltwYDmoNV6HdBIm1T4TaLFDSCrml+ZI04YQfjOAt/6s60B9PuP7M2DrSah
 /Ei7mQLVzXK8oeo4ZGepyZO55Fn8UUtfoaGNB0syhrusDKjpeCb27ZFbAwhJ4NnpewGH
 127A==
X-Gm-Message-State: AOAM5311KNs8t+eFtYqr9Pjd32AkbteKbUoALGqo/Vp6CJOWF6WNbVu9
 ZIcRNhuepm4cPnRWN76CK076ig==
X-Google-Smtp-Source: ABdhPJz8B46qAy3mH7K7M4xppHiXb//CHwuj/RA8IyjLL/yHeGrjXZ21yZsM7l6s4djLyiLVXJ69Cg==
X-Received: by 2002:adf:e3cf:: with SMTP id k15mr13899007wrm.259.1605103079627; 
 Wed, 11 Nov 2020 05:57:59 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id b14sm2550433wrq.47.2020.11.11.05.57.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2020 05:57:58 -0800 (PST)
Date: Wed, 11 Nov 2020 14:57:40 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v7 04/24] iommu: Add a page fault handler
Message-ID: <20201111135740.GA2622074@myrica>
References: <20200519175502.2504091-1-jean-philippe@linaro.org>
 <20200519175502.2504091-5-jean-philippe@linaro.org>
 <c840d771-188d-9ee5-d117-e4b91d29b329@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c840d771-188d-9ee5-d117-e4b91d29b329@linux.intel.com>
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

Hi Baolu,

Thanks for the review. I'm only now reworking this and realized I've never
sent a reply, sorry about that.

On Wed, May 20, 2020 at 02:42:21PM +0800, Lu Baolu wrote:
> Hi Jean,
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
> > +static enum iommu_page_response_code
> > +iopf_handle_single(struct iopf_fault *iopf)
> > +{
> > +	vm_fault_t ret;
> > +	struct mm_struct *mm;
> > +	struct vm_area_struct *vma;
> > +	unsigned int access_flags = 0;
> > +	unsigned int fault_flags = FAULT_FLAG_REMOTE;
> > +	struct iommu_fault_page_request *prm = &iopf->fault.prm;
> > +	enum iommu_page_response_code status = IOMMU_PAGE_RESP_INVALID;
> > +
> > +	if (!(prm->flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID))
> > +		return status;
> > +
> > +	mm = iommu_sva_find(prm->pasid);
> > +	if (IS_ERR_OR_NULL(mm))
> > +		return status;
> > +
> > +	down_read(&mm->mmap_sem);
> > +
> > +	vma = find_extend_vma(mm, prm->addr);
> > +	if (!vma)
> > +		/* Unmapped area */
> > +		goto out_put_mm;
> > +
> > +	if (prm->perm & IOMMU_FAULT_PERM_READ)
> > +		access_flags |= VM_READ;
> > +
> > +	if (prm->perm & IOMMU_FAULT_PERM_WRITE) {
> > +		access_flags |= VM_WRITE;
> > +		fault_flags |= FAULT_FLAG_WRITE;
> > +	}
> > +
> > +	if (prm->perm & IOMMU_FAULT_PERM_EXEC) {
> > +		access_flags |= VM_EXEC;
> > +		fault_flags |= FAULT_FLAG_INSTRUCTION;
> > +	}
> > +
> > +	if (!(prm->perm & IOMMU_FAULT_PERM_PRIV))
> > +		fault_flags |= FAULT_FLAG_USER;
> > +
> > +	if (access_flags & ~vma->vm_flags)
> > +		/* Access fault */
> > +		goto out_put_mm;
> > +
> > +	ret = handle_mm_fault(vma, prm->addr, fault_flags);
> > +	status = ret & VM_FAULT_ERROR ? IOMMU_PAGE_RESP_INVALID :
> 
> Do you mind telling why it's IOMMU_PAGE_RESP_INVALID but not
> IOMMU_PAGE_RESP_FAILURE?

PAGE_RESP_FAILURE maps to PRI Response code "Response Failure" which
indicates a catastrophic error and causes the function to disable PRI.
Instead PAGE_RESP_INVALID maps to PRI Response code "Invalid request",
which tells the function that the address is invalid and there is no point
retrying this particular access.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
