Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B001DA4C
	for <iommu@lists.linux.dev>; Sun,  1 Sep 2024 02:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725158366; cv=none; b=m4ypWMzzNh0L1Ebtuu6kfcD1EI6mpVEVEihVkmV+THxQc6LCZd6e7g072LtO2CYPHHA0CacoMQcGqTP/en+0ubduBhAtHWpDutkG1a5UaFxvJHrr7DKyov21pLCTf0xW1poT453i7n/5yLEkVj6H6mkK/RKnR5ePG4xZ3XwQgU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725158366; c=relaxed/simple;
	bh=ljvgU3al89OxEVEIUqvIWyRhZNDvLLNUvd8ePVYiWME=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=u09vuOBiggwTc/6SPRShOs0JL1jHJXEXP1AtVSVc9XY2XXuG0STo9evAgns58l6FnTOCr/NTuSblidHVxOoQM7HnFuSDGsxTQfcTvz3SxZ1zt9GsGGyTDlRNtMfzNjNbh4RDlNMeb3vYRn5/6B899xeqRgdya8HcajxzCI8bp28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OoamIpIG; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OoamIpIG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725158364; x=1756694364;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ljvgU3al89OxEVEIUqvIWyRhZNDvLLNUvd8ePVYiWME=;
  b=OoamIpIGc5GgjA3xWA/tg2wewyAY9j9+Y3TrNfJudNKVkS2tGFKQW2rB
   l5sAZ80BJybM/grpjvV+BADUxj+wJ1qQ+rybEMQF0Ru2HP8uHMgdIFSNB
   oZdRFA/le/oC4usmKM7eds/igcS6vIEOs7mNekxKKVkjEU4vEK4QcaDjT
   05vd3xG2UQtCCqtFyjNZka4hQU6z99J2UwINWkvx6SuqlNulo/GfF9N3/
   unFFkT5f9rs1SL9Cv6oZJ38cpSTrkRbeMD4ASPkNkrNcCf8nAW3Sv2PSp
   qKQwr2BdD03rGu2AgTDz4xLzHQQykCwL2++yOG/KSUwk7SAuWl8XQLkQ8
   g==;
X-CSE-ConnectionGUID: MlxuS5dCRQipvKc7zRYywA==
X-CSE-MsgGUID: yb9tZApcQ+K4UT3xJJLQ+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11181"; a="41262807"
X-IronPort-AV: E=Sophos;i="6.10,193,1719903600"; 
   d="scan'208";a="41262807"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2024 19:39:24 -0700
X-CSE-ConnectionGUID: 7wSriv9+TWiJh/xQdZiVmg==
X-CSE-MsgGUID: Wof8a319TkuK6wiSPuTG1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,193,1719903600"; 
   d="scan'208";a="64264177"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.125.248.220]) ([10.125.248.220])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2024 19:39:19 -0700
Message-ID: <55918c41-65c4-435c-860b-b2a177b0d364@linux.intel.com>
Date: Sun, 1 Sep 2024 10:39:17 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 robin.murphy@arm.com, dwmw2@infradead.org, shuah@kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org,
 eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
 mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
 smostafa@google.com, yi.l.liu@intel.com
Subject: Re: [PATCH v2 02/19] iommufd/viommu: Add IOMMUFD_OBJ_VIOMMU and
 IOMMU_VIOMMU_ALLOC ioctl
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, kevin.tian@intel.com,
 will@kernel.org
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <c6ac7dc5031e96abb4634db504a0bf4a0c82ca66.1724776335.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <c6ac7dc5031e96abb4634db504a0bf4a0c82ca66.1724776335.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/8/28 0:59, Nicolin Chen wrote:
> +int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_viommu_alloc *cmd = ucmd->cmd;
> +	struct iommufd_hwpt_paging *hwpt_paging;
> +	struct iommufd_viommu *viommu;
> +	struct iommufd_device *idev;
> +	int rc;
> +
> +	if (cmd->flags)
> +		return -EOPNOTSUPP;
> +
> +	idev = iommufd_get_device(ucmd, cmd->dev_id);

Why does a device reference count is needed here? When is this reference
count released after the VIOMMU is allocated?

> +	if (IS_ERR(idev))
> +		return PTR_ERR(idev);
> +
> +	hwpt_paging = iommufd_get_hwpt_paging(ucmd, cmd->hwpt_id);
> +	if (IS_ERR(hwpt_paging)) {
> +		rc = PTR_ERR(hwpt_paging);
> +		goto out_put_idev;
> +	}
> +
> +	if (!hwpt_paging->nest_parent) {
> +		rc = -EINVAL;
> +		goto out_put_hwpt;
> +	}
> +
> +	if (cmd->type != IOMMU_VIOMMU_TYPE_DEFAULT) {
> +		rc = -EOPNOTSUPP;
> +		goto out_put_hwpt;
> +	}
> +
> +	viommu = iommufd_object_alloc(ucmd->ictx, viommu, IOMMUFD_OBJ_VIOMMU);
> +	if (IS_ERR(viommu)) {
> +		rc = PTR_ERR(viommu);
> +		goto out_put_hwpt;
> +	}
> +
> +	viommu->type = cmd->type;
> +	viommu->ictx = ucmd->ictx;
> +	viommu->hwpt = hwpt_paging;
> +
> +	refcount_inc(&viommu->hwpt->common.obj.users);
> +
> +	cmd->out_viommu_id = viommu->obj.id;
> +	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
> +	if (rc)
> +		goto out_abort;
> +	iommufd_object_finalize(ucmd->ictx, &viommu->obj);
> +	goto out_put_hwpt;
> +
> +out_abort:
> +	iommufd_object_abort_and_destroy(ucmd->ictx, &viommu->obj);
> +out_put_hwpt:
> +	iommufd_put_object(ucmd->ictx, &hwpt_paging->common.obj);
> +out_put_idev:
> +	iommufd_put_object(ucmd->ictx, &idev->obj);
> +	return rc;
> +}

Thanks,
baolu
