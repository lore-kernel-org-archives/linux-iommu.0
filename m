Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A78D58103
	for <iommu@lists.linux.dev>; Fri,  8 Mar 2024 18:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709921017; cv=none; b=HpwbMA2fqfqrdFqt/Uk6uZH6Zvv/dBVmucNUE55aaZlwrUs2DrI7RqnlQdWcl3ykzkQot+eWlly+DbP8gNnShz3wnnL1U1kG/VaP6z5KlR9iTZJjSkx4RRjGO6Kx+/HN5uurdG0WdknY4oUClNgqvX0wZYqhi4mSkE/vn56TqiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709921017; c=relaxed/simple;
	bh=3LVj4/dvr7RiYytJk6zXL+ousuVGoUmlE+T+FQANLJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MQIXfdBidJJmm0LOT9/9PJUA597INZAmtE1ZkZNNCmFHvzwdX1+YKCDhQUY28Vo8BuaoxxTW8uCDLnQP90pIhs8gFTbb0+6i7a0qCAcQEaxVBrgZqJjIXruf/5o2ugkjGGaDnLECOJxD/nHh7QJug8yuDyvw40b6K1ztdZ2Dojs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=mEN6yjLS; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mEN6yjLS"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-21e6be74db4so1439034fac.2
        for <iommu@lists.linux.dev>; Fri, 08 Mar 2024 10:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1709921014; x=1710525814; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oZzrM6BbRqgMpeBTx8YDf05PpuvDd3fYcXNtVCqPsiw=;
        b=mEN6yjLSeVO+lsiNmtn6MTMICuTOpOArNK5/uglj0dG7X6kqCnS/yfnmSGkLf2uM+M
         OUsotptluOeQQWlYFAEFWYrfWS2GJ7UDowSrfGIW/dEZgl9XpBt6lpny/Gb0A8/vbyJt
         MwLy+Q1/bqgzkxo/lPVbfZYfXJt5ZklvoquKqQ+RA/CoRyDnciEqlappC/xeLY4aUB7g
         Wu7RpHcn+9jeykuZh2IlfoMZnXZYBj+dN+AVeGTXSPwLm2Th6kAgbh5RCOfA57bibBT9
         Yygha559/v3jtrrUTk3DaOsHtEXvklKFiynjZBR6w1glvwiqx37O76+iFgvXbpG13NUB
         RZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709921014; x=1710525814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZzrM6BbRqgMpeBTx8YDf05PpuvDd3fYcXNtVCqPsiw=;
        b=qqjYli9stOQ/NC83csYOvzPgZW5Jk3nQQ7UCwsBBrf0+coyJmBZwlmGnEvMLH1kKwB
         +ITzdp5Tr9i+/BIvg0ofC8wN0nZsWBBsVBXUSzQpc4Cc211pUyq0gFxiOkekKcS4FhjX
         L7FHg3LqZNIFhDjjgeKO6FGoCd6hNnt6kjRCX4QBc0HjnJxtYphwZ4k71zFrYbUI2gq8
         KqnTuGplNfcfeJyeRkd30qFndRLu9Eb1wMUqTtCBusRSGUmKrXdGpYzylcaJxgG1LflS
         zMTDCSeYswRGTtCqmbqM8y5Mo8ICALz0hFGI/1r+WjMdIg4q1wa6/9DQ2PDo5jOwGhzj
         JfDg==
X-Forwarded-Encrypted: i=1; AJvYcCVXVKzZ0yF4BnMyu15LWPdDTMQrhbZtiUPR+Sb2aXUoRVtZMWTZygNSnHkn2Iz/VF4oJT1Rq1zpigzKNWiTjQ/SMOhPtJU=
X-Gm-Message-State: AOJu0YyOakmlTynejP8Hc6dMRmmtAo0BX0tTKBWRhS2yibGyC/VhefZz
	/YNzgVFXO7HQJwr72AHKrDqWfmqs21ICwM6XIBk70Y8HzwlwHKfPCmtRQGxA550=
X-Google-Smtp-Source: AGHT+IF7pWjtuz8Xb3cQKQtapSRXtT6lbKWY4ydmQ4LB9QhAYAFvk6sa+sebdrqQhb+hD17nUWsTIA==
X-Received: by 2002:a05:6870:171a:b0:21e:c3a4:8dd9 with SMTP id h26-20020a056870171a00b0021ec3a48dd9mr3833215oae.10.1709921014517;
        Fri, 08 Mar 2024 10:03:34 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id oo24-20020a0568715a9800b0022138173901sm1968607oac.45.2024.03.08.10.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 10:03:34 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rieZA-007b0V-V9;
	Fri, 08 Mar 2024 14:03:32 -0400
Date: Fri, 8 Mar 2024 14:03:32 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/8] iommufd: Add iommufd fault object
Message-ID: <20240308180332.GX9225@ziepe.ca>
References: <20240122073903.24406-1-baolu.lu@linux.intel.com>
 <20240122073903.24406-5-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122073903.24406-5-baolu.lu@linux.intel.com>

On Mon, Jan 22, 2024 at 03:38:59PM +0800, Lu Baolu wrote:
> --- /dev/null
> +++ b/drivers/iommu/iommufd/fault.c
> @@ -0,0 +1,255 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (C) 2024 Intel Corporation
> + */
> +#define pr_fmt(fmt) "iommufd: " fmt
> +
> +#include <linux/file.h>
> +#include <linux/fs.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/iommufd.h>
> +#include <linux/poll.h>
> +#include <linux/anon_inodes.h>
> +#include <uapi/linux/iommufd.h>
> +
> +#include "iommufd_private.h"
> +
> +static int device_add_fault(struct iopf_group *group)
> +{
> +	struct iommufd_device *idev = group->cookie->private;
> +	void *curr;
> +
> +	curr = xa_cmpxchg(&idev->faults, group->last_fault.fault.prm.grpid,
> +			  NULL, group, GFP_KERNEL);
> +
> +	return curr ? xa_err(curr) : 0;
> +}
> +
> +static void device_remove_fault(struct iopf_group *group)
> +{
> +	struct iommufd_device *idev = group->cookie->private;
> +
> +	xa_store(&idev->faults, group->last_fault.fault.prm.grpid,
> +		 NULL, GFP_KERNEL);

xa_erase ?

Is grpid OK to use this way? Doesn't it come from the originating
device?

> +void iommufd_fault_destroy(struct iommufd_object *obj)
> +{
> +	struct iommufd_fault *fault = container_of(obj, struct iommufd_fault, obj);
> +	struct iopf_group *group, *next;
> +
> +	mutex_lock(&fault->mutex);
> +	list_for_each_entry_safe(group, next, &fault->deliver, node) {
> +		list_del(&group->node);
> +		iopf_group_response(group, IOMMU_PAGE_RESP_INVALID);
> +		iopf_free_group(group);
> +	}
> +	list_for_each_entry_safe(group, next, &fault->response, node) {
> +		list_del(&group->node);
> +		device_remove_fault(group);
> +		iopf_group_response(group, IOMMU_PAGE_RESP_INVALID);
> +		iopf_free_group(group);
> +	}
> +	mutex_unlock(&fault->mutex);
> +
> +	mutex_destroy(&fault->mutex);

It is really weird to lock a mutex we are about to destroy? At this
point the refcount on the iommufd_object is zero so there had better
not be any other threads with access to this pointer!

> +static ssize_t iommufd_fault_fops_read(struct file *filep, char __user *buf,
> +				       size_t count, loff_t *ppos)
> +{
> +	size_t fault_size = sizeof(struct iommu_hwpt_pgfault);
> +	struct iommufd_fault *fault = filep->private_data;
> +	struct iommu_hwpt_pgfault data;
> +	struct iommufd_device *idev;
> +	struct iopf_group *group;
> +	struct iopf_fault *iopf;
> +	size_t done = 0;
> +	int rc;
> +
> +	if (*ppos || count % fault_size)
> +		return -ESPIPE;
> +
> +	mutex_lock(&fault->mutex);
> +	while (!list_empty(&fault->deliver) && count > done) {
> +		group = list_first_entry(&fault->deliver,
> +					 struct iopf_group, node);
> +
> +		if (list_count_nodes(&group->faults) * fault_size > count - done)
> +			break;
> +
> +		idev = (struct iommufd_device *)group->cookie->private;
> +		list_for_each_entry(iopf, &group->faults, list) {
> +			iommufd_compose_fault_message(&iopf->fault, &data, idev);
> +			rc = copy_to_user(buf + done, &data, fault_size);
> +			if (rc)
> +				goto err_unlock;
> +			done += fault_size;
> +		}
> +
> +		rc = device_add_fault(group);

See I wonder if this should be some xa_alloc or something instead of
trying to use the grpid?

> +	while (!list_empty(&fault->response) && count > done) {
> +		rc = copy_from_user(&response, buf + done, response_size);
> +		if (rc)
> +			break;
> +
> +		idev = container_of(iommufd_get_object(fault->ictx,
> +						       response.dev_id,
> +						       IOMMUFD_OBJ_DEVICE),
> +				    struct iommufd_device, obj);

It seems unfortunate we do this lookup for every iteration of the loop,
I would lift it up and cache it..

> +		if (IS_ERR(idev))
> +			break;
> +
> +		group = device_get_fault(idev, response.grpid);

This looks locked wrong, it should hold the fault mutex here and we
should probably do xchng to zero it at the same time we fetch it.

> +		if (!group ||
> +		    response.addr != group->last_fault.fault.prm.addr ||
> +		    ((group->last_fault.fault.prm.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID) &&
> +		      response.pasid != group->last_fault.fault.prm.pasid)) {

Why? If grpid is unique then just trust it.

> +			iommufd_put_object(fault->ictx, &idev->obj);
> +			break;
> +		}
> +
> +		iopf_group_response(group, response.code);
> +
> +		mutex_lock(&fault->mutex);
> +		list_del(&group->node);
> +		mutex_unlock(&fault->mutex);
> +
> +		device_remove_fault(group);
> +		iopf_free_group(group);
> +		done += response_size;
> +
> +		iommufd_put_object(fault->ictx, &idev->obj);
> +	}
> +
> +	return done;
> +}
> +
> +static __poll_t iommufd_fault_fops_poll(struct file *filep,
> +					struct poll_table_struct *wait)
> +{
> +	struct iommufd_fault *fault = filep->private_data;
> +	__poll_t pollflags = 0;
> +
> +	poll_wait(filep, &fault->wait_queue, wait);
> +	mutex_lock(&fault->mutex);
> +	if (!list_empty(&fault->deliver))
> +		pollflags = EPOLLIN | EPOLLRDNORM;
> +	mutex_unlock(&fault->mutex);
> +
> +	return pollflags;
> +}
> +
> +static const struct file_operations iommufd_fault_fops = {
> +	.owner		= THIS_MODULE,
> +	.open		= nonseekable_open,
> +	.read		= iommufd_fault_fops_read,
> +	.write		= iommufd_fault_fops_write,
> +	.poll		= iommufd_fault_fops_poll,
> +	.llseek		= no_llseek,
> +};

No release? That seems wrong..

> +static int get_fault_fd(struct iommufd_fault *fault)
> +{
> +	struct file *filep;
> +	int fdno;
> +
> +	fdno = get_unused_fd_flags(O_CLOEXEC);
> +	if (fdno < 0)
> +		return fdno;
> +
> +	filep = anon_inode_getfile("[iommufd-pgfault]", &iommufd_fault_fops,
> +				   fault, O_RDWR);
                                   ^^^^^^

See here you stick the iommufd_object into the FD but we don't
refcount it...

And iommufd_fault_destroy() doesn't do anything about this, so it just
UAFs the fault memory in the FD.

You need to refcount the iommufd_object here and add a release
function for the fd to put it back

*and* this FD needs to take a reference on the base iommufd_ctx fd too
as we can't tolerate them being destroyed out of sequence.

> +int iommufd_fault_alloc(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_fault_alloc *cmd = ucmd->cmd;
> +	struct iommufd_fault *fault;
> +	int rc;
> +
> +	if (cmd->flags)
> +		return -EOPNOTSUPP;
> +
> +	fault = iommufd_object_alloc(ucmd->ictx, fault, IOMMUFD_OBJ_FAULT);
> +	if (IS_ERR(fault))
> +		return PTR_ERR(fault);
> +
> +	fault->ictx = ucmd->ictx;
> +	INIT_LIST_HEAD(&fault->deliver);
> +	INIT_LIST_HEAD(&fault->response);
> +	mutex_init(&fault->mutex);
> +	init_waitqueue_head(&fault->wait_queue);
> +
> +	rc = get_fault_fd(fault);
> +	if (rc < 0)
> +		goto out_abort;

And this is ordered wrong, fd_install has to happen after return to
user space is guarenteed as it cannot be undone.

> +	cmd->out_fault_id = fault->obj.id;
> +	cmd->out_fault_fd = rc;
> +
> +	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
> +	if (rc)
> +		goto out_abort;
> +	iommufd_object_finalize(ucmd->ictx, &fault->obj);

fd_install() goes here

> +	return 0;
> +out_abort:
> +	iommufd_object_abort_and_destroy(ucmd->ictx, &fault->obj);
> +
> +	return rc;
> +}

Jason
