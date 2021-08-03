Return-Path: <SRS0=qwh6=M2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8452CC4338F
	for <iommu@archiver.kernel.org>; Tue,  3 Aug 2021 21:47:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 330E261029
	for <iommu@archiver.kernel.org>; Tue,  3 Aug 2021 21:47:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 330E261029
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 04670401FD;
	Tue,  3 Aug 2021 21:47:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4-7oXi72yFkh; Tue,  3 Aug 2021 21:47:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 98A0B400C7;
	Tue,  3 Aug 2021 21:47:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 64526C001A;
	Tue,  3 Aug 2021 21:47:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9182C000E;
 Tue,  3 Aug 2021 21:47:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 90566400C8;
 Tue,  3 Aug 2021 21:47:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cjXhIJLKmund; Tue,  3 Aug 2021 21:47:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9EF0D400C7;
 Tue,  3 Aug 2021 21:47:22 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 l34-20020a05600c1d22b02902573c214807so2635941wms.2; 
 Tue, 03 Aug 2021 14:47:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=NO+JU9UzRMwitUxOBD7sMCGKQLIhbf2Foco5VWOK1Z4=;
 b=XQssMW3rPbyvv3PvNF+AJ86T20iFMx5AcSpP8LucaGrMMzFXnR3i67Bc8izDjx6Pl0
 hQHgBceAVW6iIVCRW0B/8EfUNKxnBocxR6zxtqnpDOHy7zwLUj4MG5QibYeY4pigO+Wn
 f0IRZBdV4lytEws3nghT3dQTQttlRwq3t1FFVw+yhTxVS2HL2nscrcxFM+rZzlrzxu2s
 X1eLsl4VDDxdKVd0d9TBDLGZi2wVylUPOxZr/I+zfP6aYjJlEfPOZ0KlBX6IIlhzjZg2
 AmoxWIXB84Og0eVSYo028gHut2kCaZwHzBJeLUN2VGptXbMIClFohtR+GTNhsPrCAB3i
 ZPQQ==
X-Gm-Message-State: AOAM531qmLi7nMBnzBEhpvpKNhmcAYK4SHhZYa+FAIIeOXP71QDCrUwn
 3Jhtgh8NNSZxv8c6brU/CIk=
X-Google-Smtp-Source: ABdhPJxKVZaGEKq0W06B3ndgni2gnDr15UMxeozYYtoe6oJ0dR7qwn8iMp7dsEVgP13d0k8hAPltQQ==
X-Received: by 2002:a05:600c:4f42:: with SMTP id
 m2mr6587287wmq.47.1628027240884; 
 Tue, 03 Aug 2021 14:47:20 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
 by smtp.gmail.com with ESMTPSA id t8sm240744wmj.5.2021.08.03.14.47.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Aug 2021 14:47:20 -0700 (PDT)
Date: Tue, 3 Aug 2021 21:47:18 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Praveen Kumar <kumarpraveen@linux.microsoft.com>
Subject: Re: [RFC v1 5/8] mshv: add paravirtualized IOMMU support
Message-ID: <20210803214718.hnp3ejs35lh455fw@liuwe-devbox-debian-v2>
References: <20210709114339.3467637-1-wei.liu@kernel.org>
 <20210709114339.3467637-6-wei.liu@kernel.org>
 <77670985-2a1b-7bbd-2ede-4b7810c3e220@linux.microsoft.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <77670985-2a1b-7bbd-2ede-4b7810c3e220@linux.microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Stephen Hemminger <sthemmin@microsoft.com>, pasha.tatashin@soleen.com,
 Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
 Will Deacon <will@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 Linux Kernel List <linux-kernel@vger.kernel.org>,
 Michael Kelley <mikelley@microsoft.com>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 virtualization@lists.linux-foundation.org,
 Vineeth Pillai <viremana@linux.microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>
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

On Wed, Aug 04, 2021 at 12:10:45AM +0530, Praveen Kumar wrote:
> On 09-07-2021 17:13, Wei Liu wrote:
> > +static void hv_iommu_domain_free(struct iommu_domain *d)
> > +{
> > +	struct hv_iommu_domain *domain = to_hv_iommu_domain(d);
> > +	unsigned long flags;
> > +	u64 status;
> > +	struct hv_input_delete_device_domain *input;
> > +
> > +	if (is_identity_domain(domain) || is_null_domain(domain))
> > +		return;
> > +
> > +	local_irq_save(flags);
> > +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> > +	memset(input, 0, sizeof(*input));
> > +
> > +	input->device_domain= domain->device_domain;
> > +
> > +	status = hv_do_hypercall(HVCALL_DELETE_DEVICE_DOMAIN, input, NULL);
> > +
> > +	local_irq_restore(flags);
> > +
> > +	if (!hv_result_success(status))
> > +		pr_err("%s: hypercall failed, status %lld\n", __func__, status);
> 
> Is it OK to deallocate the resources, if hypercall has failed ?

It should be fine. We leak some resources in the hypervisor, but Linux
is in a rather wedged state anyway. Refusing to free up resources in
Linux does not much good.

> Do we have any specific error code EBUSY (kind of) which we need to wait upon ?
> 

I have not found a circumstance that can happen.

> > +
> > +	ida_free(&domain->hv_iommu->domain_ids, domain->device_domain.domain_id.id);
> > +
> > +	iommu_put_dma_cookie(d);
> > +
> > +	kfree(domain);
> > +}
> > +
> > +static int hv_iommu_attach_dev(struct iommu_domain *d, struct device *dev)
> > +{
> > +	struct hv_iommu_domain *domain = to_hv_iommu_domain(d);
> > +	u64 status;
> > +	unsigned long flags;
> > +	struct hv_input_attach_device_domain *input;
> > +	struct pci_dev *pdev;
> > +	struct hv_iommu_endpoint *vdev = dev_iommu_priv_get(dev);
> > +
> > +	/* Only allow PCI devices for now */
> > +	if (!dev_is_pci(dev))
> > +		return -EINVAL;
> > +
> > +	pdev = to_pci_dev(dev);
> > +
> > +	dev_dbg(dev, "Attaching (%strusted) to %d\n", pdev->untrusted ? "un" : "",
> > +		domain->device_domain.domain_id.id);
> > +
> > +	local_irq_save(flags);
> > +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> > +	memset(input, 0, sizeof(*input));
> > +
> > +	input->device_domain = domain->device_domain;
> > +	input->device_id = hv_build_pci_dev_id(pdev);
> > +
> > +	status = hv_do_hypercall(HVCALL_ATTACH_DEVICE_DOMAIN, input, NULL);
> > +	local_irq_restore(flags);
> > +
> > +	if (!hv_result_success(status))
> > +		pr_err("%s: hypercall failed, status %lld\n", __func__, status);
> 
> Does it make sense to vdev->domain = NULL ?
>

It is already NULL -- there is no other code path that sets it and the
detach path always sets the field to NULL.

> > +	else
> > +		vdev->domain = domain;
> > +
> > +	return hv_status_to_errno(status);
> > +}
> > +
[...]
> > +static size_t hv_iommu_unmap(struct iommu_domain *d, unsigned long iova,
> > +			   size_t size, struct iommu_iotlb_gather *gather)
> > +{
> > +	size_t unmapped;
> > +	struct hv_iommu_domain *domain = to_hv_iommu_domain(d);
> > +	unsigned long flags, npages;
> > +	struct hv_input_unmap_device_gpa_pages *input;
> > +	u64 status;
> > +
> > +	unmapped = hv_iommu_del_mappings(domain, iova, size);
> > +	if (unmapped < size)
> > +		return 0;
> 
> Is there a case where unmapped > 0 && unmapped < size ?
> 

There could be such a case -- hv_iommu_del_mappings' return value is >= 0.
Is there a problem with this predicate?

Wei.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
