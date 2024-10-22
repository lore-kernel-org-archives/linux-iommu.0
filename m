Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7F21A0B0C
	for <iommu@lists.linux.dev>; Tue, 22 Oct 2024 14:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729607425; cv=none; b=dd83KtD3iXwp8avGLxbVmOCJDsawSOOxAIhh91bR1iiDhokyHysrLoX36oBVozzX0fxXV/gKb0paa6bRpUGR8IzSIXkgUzLe0HEGxzkgIiG5kGjlej12Fo8oQurVpF+Ajkv/3bk8IhO/hRoGNkSetO9zpBMT6ImOQhTt9lxQ9Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729607425; c=relaxed/simple;
	bh=k0amHKO6MIntAv5M0SzgajpPonlLOfoo6JXAgIJwIcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d/z2/7pMiHAti2QUcFFxjJh2dStY0munYuZnL+73VqjTryo+Qp+1oQbq+FWnvhUGS0yPIkWyV2FcfW6KI2R0XgGW3Zq1t89//cQLeP82K0dq+EK4CGWvyOTUMmbjZW9NxwtfaecIQbKN/5XMzckn2p9HpD1lxF+gHlC/TEIXsx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=djqdzPhi; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="djqdzPhi"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539e4b7409fso5651946e87.0
        for <iommu@lists.linux.dev>; Tue, 22 Oct 2024 07:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729607422; x=1730212222; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lp8dKdoQIA1w+n8BQQ++9JKmCC1EPM5x54cAk4kCfAY=;
        b=djqdzPhiEoMpbCD11Fadm2YX/B79HY1tJ/arkV904qaYicsWh80/JFtvTwFAaTCyev
         3iXQQhCF2AoYpaasBZpPJ+z0CE6z4/qs9JaDF5uEpLDfkugZ9XlU806Ty6tmBIP8K88e
         yOuDGwKrUZQVQwPMv/B3p1tJhqHQWPQUs4EpSibu7F/WwdZmpd6sK0v5BEK4DT7tIo4/
         CDjf/K98oWKKF8WL/9kZ6q1VP90Z/g+1smPW7yk/Hzx5lMgGnnPCgrPrqsWfYOkQi3Uq
         QFLKbFN1GuJ/6i1SEnj+MJwSKLQQ80kpHqLDtsmY7ZNHpb+7rBvpiBKkjdl2bdIH30O2
         UiJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729607422; x=1730212222;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lp8dKdoQIA1w+n8BQQ++9JKmCC1EPM5x54cAk4kCfAY=;
        b=AD12Pes2oUGZgINUDVjjr5cApeQ9Sb/iYHuwLww2bLv0Ri+3vV2buK6hcMfeQurHzW
         iA3HocCwvPOd79nKWzKSeO3gcn8aU63g8vY6racL2iSb9RafFxLxLTINIfat0SjQHD5Z
         zFXDJi45J/eUpqxLtPpAbpoqbce967lfjurrGY0APnQUOkpRg3RpXcQorMARQ+/Mb9/R
         tt6LRH01l6JViD4koviiWm1lSxcrwgiecjXlzdMxCUiBiWRATf/OoJlcRWow2Rjs5jOO
         +IO84AhGm7hUOD7unhhCHUrqEAqMm6oIrhK4NsuUy7GUVz5zItUTaDYCW9eudF0BBGXo
         uT/g==
X-Forwarded-Encrypted: i=1; AJvYcCUipweTwptu9S3klszQosjqMP5v5VUt2Mnc5huF/9uMAPbC0BiHrUcKveXvMgQG0aO9gwLZkA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwqbwJwUulwBCDkqfqDuep2+Wby8GWuVSPFqrIeiNktliAdDBbS
	uqEnYlKRF+JQUV1MuaQoBvXkO+58/7325huYcwjC2nqFdHIDDQQJtjgiCeI+iyjE9XNGcdKe04v
	Dl/ZF1aKxg/5jc9LP89qePSTux7/r5m3PpzsGIw==
X-Google-Smtp-Source: AGHT+IEmsgyC/7BPZ0DVAIPPJOMrKuG0dVpOFVN4k5ykLXaGddAjQf1rjB9Wpg/JrSZFFy9ylzXvbFdWuCjJSeysOhI=
X-Received: by 2002:a05:6512:3d22:b0:539:ea18:437d with SMTP id
 2adb3069b0e04-53b13181fd5mr1172054e87.25.1729607422263; Tue, 22 Oct 2024
 07:30:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240702063444.105814-1-baolu.lu@linux.intel.com>
 <20240702063444.105814-8-baolu.lu@linux.intel.com> <CABQgh9EeKtYuu+vTTM0fwaKrLxdyC355MQxN8o8_OL9Y1NkE8A@mail.gmail.com>
 <20241015125420.GK1825128@ziepe.ca> <CABQgh9E+AnuyJgcM9tf1gEOUqcC_QSrA__Xha9sKYZp=NVRwhQ@mail.gmail.com>
 <20241016152503.GB4020792@ziepe.ca> <20241018135343.GA1914429@nvidia.com>
In-Reply-To: <20241018135343.GA1914429@nvidia.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Tue, 22 Oct 2024 22:30:10 +0800
Message-ID: <CABQgh9Hd0QCfEtVcMyXG+=KHuZdGGUA=kk5iL_ysOzfOpLh=-w@mail.gmail.com>
Subject: Re: [PATCH v8 07/10] iommufd: Fault-capable hwpt attach/detach/replace
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Nicolin Chen <nicolinc@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, 
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 18 Oct 2024 at 21:53, Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Wed, Oct 16, 2024 at 12:25:03PM -0300, Jason Gunthorpe wrote:
> > > > smmu-v3 needs some more fixing to move that
> > > > arm_smmu_master_enable_sva() logic into domain attachment.
> > >
> > > Will think about this, Thanks Jason
> >
> > Can you test it if a patch is made?
>
> Here it is:
>
> https://github.com/jgunthorpe/linux/commits/smmuv3_nesting/
>
> fa1528253d2210 iommu: Remove IOMMU_DEV_FEAT_SVA
> 5675560a272cf5 iommu/vt-d: Check if SVA is supported when attaching the SVA domain
> 94bc2b9525b508 iommu/arm-smmu-v3: Put iopf enablement in the domain attach path
>
> Let me know..

With these patches, do we still need ops->user_pasid_table?

if (fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID) {
                attach_handle = iommu_attach_handle_get(dev->iommu_group,
                                fault->prm.pasid, 0);

// is attach_handle expected effect value here?
                if (IS_ERR(attach_handle)) {
                        const struct iommu_ops *ops = dev_iommu_ops(dev);

                        if (!ops->user_pasid_table)
                                return NULL;
                        /*
                         * The iommu driver for this device supports user-
                         * managed PASID table. Therefore page faults for
                         * any PASID should go through the NESTING domain
                         * attached to the device RID.
                         */
                        attach_handle = iommu_attach_handle_get(
                                        dev->iommu_group, IOMMU_NO_PASID,
                                        IOMMU_DOMAIN_NESTED);

Now I still need set ops->user_pasid_table, since attach_handle can not
return from the first iommu_attach_handle_get with fault->prm.pasid = 1,
but the second iommu_attach_handle_get with  IOMMU_NO_PASID,
suppose it is not expected?

Thanks
