Return-Path: <SRS0=9AUr=X3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D65EC35280
	for <iommu@archiver.kernel.org>; Wed,  2 Oct 2019 16:18:31 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4369921A4C
	for <iommu@archiver.kernel.org>; Wed,  2 Oct 2019 16:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AaMiU9ll"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4369921A4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 1CD50135B;
	Wed,  2 Oct 2019 16:18:31 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 96DD811F9
	for <iommu@lists.linux-foundation.org>;
	Wed,  2 Oct 2019 16:18:30 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
	[209.85.208.66])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id E09488D8
	for <iommu@lists.linux-foundation.org>;
	Wed,  2 Oct 2019 16:18:29 +0000 (UTC)
Received: by mail-ed1-f66.google.com with SMTP id v8so15825280eds.2
	for <iommu@lists.linux-foundation.org>;
	Wed, 02 Oct 2019 09:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=jpI6Yt4Aabzc1pU0Qm6BvfjugUkT+9WqSHu9chpa9jc=;
	b=AaMiU9llCOuOCzVuMCtvZZbyHXsxo9TXDVn+8kGS8EU77tztkNeDnD/r76KhQ6T2UA
	B9x258ao9jX1dvtqdDaXwAEHp9xU+K6N/T1MewJoh00PaYEvLUUPnqR6nWZ2jrMs8Ztu
	ArV+giXb/5jloKS4VQYdU1esA+mdjo3+Xcjd2OxR2JczcRdbhxHuPLH6qvVpo7xgsuUZ
	a7BpTFzvlCfdtyP/nzjITkOEHUWTJHvgaCpiwcOAAOzGDzm+oM8cCxmAz2r6WphYsaAE
	PuMNDrECbLFS5IKE23FKf+B6XpaNnFgAY6oZJAfUj5LaRh7mnhbfgppK0kYABa1Pg8FA
	+3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=jpI6Yt4Aabzc1pU0Qm6BvfjugUkT+9WqSHu9chpa9jc=;
	b=AHGKkW8QwHKRKMnt0EVomDOoMpeq//CE10mo/bXkqk/F93F+MjRsKWF5VEkR+7DEZa
	25d2d/v+xeT0qRqLaIqCJM0oI8IjbGdkE5/v0jIfBBar9/w0f/lwQReWt+eneSwIfot5
	YYhlyQrpPRdaQRFWxE2/8JCSS0dJfN4WnWcPCoKSq4TLr0dli53hVQqvml81dNwcvWjH
	faqxTsOXwVwYm+o2kI/Ejy+WE89S6TDnR5wpz9pJ6de1KBwwWLg2dHl3zQxP+K0twlMP
	94njJ5ZLhzxT7MMi1fV6ig8uRKmAOds5iz+BJrP7i5/yFeXt52Aq+06CQTRnm7D+03aG
	iDHA==
X-Gm-Message-State: APjAAAUnBeE4k+vZ9me8GizOzDuV6IZtRDYeH8AEtwVrADCBMKGqjL5S
	LymunKAOmnpjh8AcLaaxzc6D1w==
X-Google-Smtp-Source: APXvYqyfE5U1txyp0AZRS8S9j8BdSrmQQDbN2GfHD+L4SjllZBaPJ3fnWb8u9TkXDUHopNzQ5VGj0w==
X-Received: by 2002:a17:906:5c16:: with SMTP id
	e22mr3751787ejq.105.1570033108207; 
	Wed, 02 Oct 2019 09:18:28 -0700 (PDT)
Received: from lophozonia ([85.195.192.192])
	by smtp.gmail.com with ESMTPSA id h1sm1567262ejb.86.2019.10.02.09.18.26
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 02 Oct 2019 09:18:27 -0700 (PDT)
Date: Wed, 2 Oct 2019 18:18:25 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v2 3/4] iommu/ioasid: Add custom allocators
Message-ID: <20191002161825.GA626133@lophozonia>
References: <1569110870-12603-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1569110870-12603-4-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1569110870-12603-4-git-send-email-jacob.jun.pan@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
	David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux-foundation.org,
	LKML <linux-kernel@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.com>,
	Jonathan Cameron <jic23@kernel.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi Jacob,

I have four tiny comments below but the patch looks great otherwise, no
major concern from me.

On Sat, Sep 21, 2019 at 05:07:49PM -0700, Jacob Pan wrote:
> +/*
> + * struct ioasid_allocator_data - Internal data structure to hold information
> + * about an allocator. There are two types of allocators:
> + *
> + * - Default allocator always has its own XArray to track the IOASIDs allocated.
> + * - Custom allocators may share allocation helpers with different private data.
> + *   Custom allocators that share the same helper functions also share the same
> + *   XArray.
> + * Rules:
> + * 1. Default allocator is always available, not dynamically registered. This is
> + *    to prevent race conditions with early boot code that want to register
> + *    custom allocators or allocate IOASIDs.
> + * 2. Custom allocators take precedence over the default allocator.
> + * 3. When all custom allocators sharing the same helper functions are
> + *    unregistered (e.g. due to hotplug), all outstanding IOASIDs must be
> + *    freed. Otherwise, outstand IOASIDs will be lost and orphaned.

                           outstanding

[...]
>  ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
>  		      void *private)
>  {
> -	ioasid_t id;
>  	struct ioasid_data *data;
> +	void *adata;
> +	ioasid_t id;

nit: changing the location of id could be in patch 2/4.

> -	data = kzalloc(sizeof(*data), GFP_KERNEL);
> +	data = kzalloc(sizeof(*data), GFP_ATOMIC);

I don't think that one needs to be GFP_ATOMIC. Otherwise it should
probably be done from the start, by patch 2/4.

>  	if (!data)
>  		return INVALID_IOASID;
>  
>  	data->set = set;
>  	data->private = private;
>  
> -	if (xa_alloc(&ioasid_xa, &id, data, XA_LIMIT(min, max), GFP_KERNEL)) {
> -		pr_err("Failed to alloc ioasid from %d to %d\n", min, max);
> +	/*
> +	 * Custom allocator needs allocator data to perform platform specific
> +	 * operations.
> +	 */
> +	spin_lock(&ioasid_allocator_lock);
> +	adata = active_allocator->flags & IOASID_ALLOCATOR_CUSTOM ? active_allocator->ops->pdata : data;
> +	id = active_allocator->ops->alloc(min, max, adata);
> +	if (id == INVALID_IOASID) {
> +		pr_err("Failed ASID allocation %lu\n", active_allocator->flags);
> +		goto exit_free;
> +	}
> +
> +	if ((active_allocator->flags & IOASID_ALLOCATOR_CUSTOM) &&
> +		xa_alloc(&active_allocator->xa, &id, data, XA_LIMIT(id, id), GFP_ATOMIC)) {

nit: aligning at the "if (" would make this block more readable.

> +		/* Custom allocator needs framework to store and track allocation results */
> +		pr_err("Failed to alloc ioasid from %d\n", id);
> +		active_allocator->ops->free(id, active_allocator->ops->pdata);
>  		goto exit_free;
>  	}

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
