Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BCF4B048C
	for <iommu@lists.linux.dev>; Thu, 27 Aug 2026 17:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787853178; cv=none; b=Jj9hbta+a3svAP1IAx6wHBFDPG0AtZoZGzP4la6I1kPTidS+7CLvNb4BwNoO4kUZksCqsnH9m1Ak1LvBGbEsOm1COApCfL8orx/yxr/ixki5nGrALXAHL+uXZUSQXyeta48BUamNNDI8w+lTtnmTSWeubMOrutXw0hkcnn3CGsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787853178; c=relaxed/simple;
	bh=cF6NYXhDGfB74HoBaloQ4sZUldwQ5oUq/5AOtANebOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XyawY3xKyR6xOtMUsFjEO6xnPUVg6gHpleeTL4ClVEt5azflnzqCGQ9+S8TsxtzxUu6bDg2kUjswYd/lsZn3rkFE9ksSigotp9w3vFED51FRZx4wwj2SCEY9o4+vjFrLJEtbx0nozMY17b6dpAR9sj8Y/lv0tJxkkvLigxCcpJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fl5jdhVU; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fl5jdhVU"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d3b440b97aso10505ad.1
        for <iommu@lists.linux.dev>; Thu, 27 Aug 2026 10:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787853174; x=1788457974; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P+fTw5/xN6iO4FdPKCmZVQ2MDNmjfRNyCIFQIOLN/Mk=;
        b=Fl5jdhVU79aJxf1w+gaCaB5mNkcY1GRYS2mkPzU+7hMLMuMcB4KGtFlUBmm2gem8aK
         E41XszclVoq9gcoGPE4C+A8AwGexMiVguJRXXaU2LDfcM4Dqgw/a6QOvKFkAC0JHyp8n
         Gtvqmzy5b2ryre4Ge94pFTSXIU2f5Qv6HqChCdjKPsccCzhnrCOcc1c1cau2nrfC+/Ry
         CATQdxXMmuWpsA0iHBY6dVVKo3bLcd/MnTq194DyqOJqHCWo1ILcYUtZjowB7yvbVr7Z
         Z+vyJ6zTxiBhmEs+/JXIltz+zAkagZpaeQIkoKOJOpJiwZnzs18k4XwJ8xYjmhmt4W5W
         SdxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787853174; x=1788457974;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P+fTw5/xN6iO4FdPKCmZVQ2MDNmjfRNyCIFQIOLN/Mk=;
        b=J+Wj0ruzWWV9ElTn017Ivt0y0+NwHvb0yJlUZjHPfY5HYBKGhp2tA4Y9BB5GL7VNy6
         swXvTWAbF+0ShWWeDtfC2bIZtS6PYIUC5wnJ1yRdTUAAPBb8h1LtS83jMApR+Rxe1/6h
         W5w45q7jg+9CR37pCgCzpijwfmOkLxQ8sK8SepIdp/ejNeQRtcwlOx4nRaWkrXPHqxKx
         uo3M3QlvqX86lhdNHR0nEW37W0OMYNxbuyEnjHFa2Gkb7Sz91fB2f2aq5Ux5F3lA97ZB
         CJz6fSgGmZeimFzyeMgveMpG7j67oHLn0i2ySu5k82mkVo+xzTtCbV8f6iweHJD5J/fK
         rhVA==
X-Forwarded-Encrypted: i=1; AHgh+RoECls/4UzZmWPNlQhnu3cy3IfNJgQi7bBB0RU7umWWzQB20e8DXNex7ofT8EXDs/XM6AJo5w==@lists.linux.dev
X-Gm-Message-State: AFuF++mIXZW/TaCKX1i+VZhLKDGakuWDqhQGMD9j9FZDxQaSMwonClAE
	pGrDIkGInKVfEZIrV3FfRPqAaT/TdnDAm7ruAVKx+4xsN0bmVJaUQX2Kg6Q+IPseGg==
X-Gm-Gg: AR+sD10KTsv2kwuvJBedMfDXliCPCfvDxBJNUprqqh1OwKJxmeJBOmoSijcG6igwoRU
	ZgpNRqrKaBJMPylpXrklbNhoQL7nC3J0YRJcHmw1kP9RGGF8gH8TMTNYeKPwdRakDlHtCAYerMv
	sApndGUr0tbJ5yIYi4BjjiPwfyOB9mFIeifyJf5/wWQ8bifPuqg+9Qu8m9B0HH++4iG/E38vJaa
	XcltegINRCrC4/g93i4uw9ctybxn5ltFjQrbdmavwncT1pnsAZTqDKuTLEiY9zqKhBPA6f7yUVk
	wh21G7zyxXQ1AIfIm7qxnmak4+n7999tO43Ni/bnGcjIlZdvELDzOJT60HuYvNYMrgMmViRY7o+
	3lfweXhR8HrRqMnLxT+9HaZFZQG1ifEtoFJ1dTvw8ReRlLzvojHdB6K2hccrHF2vrXs+EdWiPWG
	kG5+MCCaeT6/9QRWBQJdMz3SHx60rRLousUA1zG6xAsyZTvJJmTYlSXBavkrC4QAD+HxpyrBepN
	GMwqlleiqx4Nk+zliB6050M9YjG4uu3FmXgYKzwn/ra5Wzc9kpndIJMyZo=
X-Received: by 2002:a17:903:1b48:b0:2ca:6bf:5bac with SMTP id d9443c01a7336-2d74f53de42mr551995ad.8.1787853173817;
        Thu, 27 Aug 2026 10:52:53 -0700 (PDT)
Received: from google.com (210.87.127.34.bc.googleusercontent.com. [34.127.87.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b1123142sm3639572a91.15.2026.08.27.10.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 10:52:52 -0700 (PDT)
Date: Thu, 27 Aug 2026 17:52:49 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Pranjal Shrivastava <praan@google.com>, 
	Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v4 12/18] iommu/vt-d: Handle reattach of the restored
 domain
Message-ID: <apBso6So7UqwR3AX@google.com>
References: <20260808022723.3893618-1-skhawaja@google.com>
 <20260808022723.3893618-13-skhawaja@google.com>
 <5b920299-260b-4025-ac4f-e8f83beebf95@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <5b920299-260b-4025-ac4f-e8f83beebf95@linux.intel.com>

On Thu, Aug 27, 2026 at 04:12:01PM +0800, Baolu Lu wrote:
>On 8/8/26 10:27, Samiullah Khawaja wrote:
>>Reattach the restored domain to the preserved device using restored
>>domain ID. While reattaching do not setup the context and PASID entries
>>as those are preserved during liveupdate.
>>
>>Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>>---
>>  drivers/iommu/intel/iommu.c      |   9 ++-
>>  drivers/iommu/intel/iommu.h      |  10 +++
>>  drivers/iommu/intel/liveupdate.c | 120 +++++++++++++++++++++++++++++++
>>  3 files changed, 136 insertions(+), 3 deletions(-)
>>

[snip]

>>+
>>+static int domain_reattach_iommu(struct dmar_domain *domain,
>>+				 struct intel_iommu *iommu,
>>+				 struct iommu_device_ser *device_ser)
>>+{
>>+	struct iommu_domain_info *info, *curr;
>>+	int restored_did;
>>+	int ret;
>>+
>>+	if (!iommu_domain_restored_state(&domain->domain))
>>+		return -EINVAL;
>>+
>>+	restored_did = device_ser->domain_iommu_ser.attachment_id;
>>+	if (!ida_exists(&iommu->domain_ida, restored_did))
>>+		return -EINVAL;
>
>It seems that checking only whether the domain ID is reserved on this
>IOMMU may not be sufficient. It would be safer to also verify that:
>
>- device_ser->domain_iommu_ser.iommu_phys matches iommu->reg_phys, and
>- device_ser->domain_iommu_ser.domain_phys matches @domain.
>
>?

Interesting.. The caller of this attach from core fetches the correct
domain based on the checks you mentioned. But you are right, adding a
check here makes sense to prevent anyone else calling attach with a
mismatch.
>
>>+
>>+	info = kzalloc_obj(*info);
>>+	if (!info)
>>+		return -ENOMEM;
>>+
>>+	guard(mutex)(&iommu->did_lock);
>>+	curr = xa_load(&domain->iommu_array, iommu->seq_id);
>>+	if (curr) {
>>+		curr->refcnt++;
>>+		kfree(info);
>>+		return 0;
>>+	}
>>+
>>+	info->refcnt	= 1;
>>+	info->did	= restored_did;
>>+	info->iommu	= iommu;
>>+	curr = xa_cmpxchg(&domain->iommu_array, iommu->seq_id,
>>+			  NULL, info, GFP_KERNEL);
>>+	if (curr) {
>>+		ret = xa_err(curr) ? : -EBUSY;
>>+		goto err_unlock;
>>+	}
>>+
>>+	return 0;
>>+
>>+err_unlock:
>>+	kfree(info);
>>+	return ret;
>>+}
>>+
>>+/**
>>+ * intel_iommu_restore_device() - Restore device domain attachment after live update
>>+ * @domain: Restored domain
>>+ * @dev: Restored device
>>+ *
>>+ * Return: 0 on success, or negative error code.
>>+ */
>>+int intel_iommu_restore_device(struct iommu_domain *domain,
>>+			       struct device *dev)
>>+{
>>+	struct iommu_device_ser *device_ser = dev_iommu_restored_state(dev);
>>+	struct device_domain_info *info = dev_iommu_priv_get(dev);
>>+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
>>+	struct intel_iommu *iommu = info->iommu;
>>+	unsigned long flags;
>>+	int ret;
>>+
>>+	if (!device_ser)
>>+		return -EINVAL;
>>+
>>+	if (dev_is_real_dma_subdevice(dev))
>>+		return -EOPNOTSUPP;
>
>... or, move above check here to ensure the attachment relationship
>between the @device and @domain?

I think it is good to keep it in the domain_reattach_iommu() as that
does the iommu <-> domain association.
>
>>+
>>+	ret = domain_reattach_iommu(dmar_domain, iommu, device_ser);
>>+	if (ret)
>>+		return ret;
>>+
>>+	info->domain = dmar_domain;
>>+	info->domain_attached = true;
>>+	spin_lock_irqsave(&dmar_domain->lock, flags);
>>+	list_add(&info->link, &dmar_domain->devices);
>>+	spin_unlock_irqrestore(&dmar_domain->lock, flags);
>>+
>>+	if (!sm_supported(iommu))
>>+		intel_iommu_enable_pci_ats(info);
>
>Could you please clarify the PCI ATS behavior across live update?
>
>My understanding is that PCI devices may bypass reset during kexec and
>are then re-initialized by the new kernel (is that correct?). If so, ATS
>state in hardware would depend on its state before kexec in the old
>kernel.
>
>In a normal reboot, ATS is expected to be disabled and the device ATC is
>empty. But that assumption may not hold for live update. If that is
>true, can we still use the same approach to keep hardware ATS state and
>info->ats_enabled in sync?

Regarding ATS, it remains enabled in the preserved device during kexec
and we should keep it in sync with the info->ats_enabled here. We might
have to disable it in the next kernel if it is unsupported (or disabled
globally) in the next kernel. I will put those changes here in next
revision.
>
>>+
>>+	ret = cache_tag_assign_domain(dmar_domain, dev, IOMMU_NO_PASID);
>>+	if (ret)
>>+		goto err;
>>+
>>+	ret = iopf_for_domain_set(domain, dev);
>>+	if (ret)
>>+		goto err;
>>+
>>+	return 0;
>>+
>>+err:
>>+	/*
>>+	 * Detach the restored domain from device and iommu on failure, but keep
>>+	 * the hardware state intact.
>>+	 */
>>+	info->domain_attached = false;
>>+	cache_tag_unassign_domain(info->domain, dev, IOMMU_NO_PASID);
>>+	spin_lock_irqsave(&info->domain->lock, flags);
>>+	list_del(&info->link);
>>+	spin_unlock_irqrestore(&info->domain->lock, flags);
>>+
>>+	domain_detach_reattached_iommu(info->domain, iommu);
>>+	info->domain = NULL;
>>+	return ret;
>>+}
>>+
>>  /**
>>   * intel_iommu_preserve_device() - Intel IOMMU callback to preserve device state
>>   * @dev: Target device
>
>Thanks,
>baolu

Thanks,
Sami
