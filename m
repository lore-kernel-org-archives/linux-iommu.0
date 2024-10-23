Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6C51A4B69
	for <iommu@lists.linux.dev>; Wed, 23 Oct 2024 10:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729678977; cv=none; b=M2qnx2cGfLHJbfNbFj7lzygVk1n0uoxLotqhovLmCwuo830iZ8MRGXnqEtEZizuuxqlE8U8qpCQC7Il2Jb621VTm9yDQvwMXiub032WPIfw4Pf8TtAF1ffPeWcTRV8XNc51o9u0hcGkd/uJBS9aJEi1TZSr9klICDX2oPtrKMU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729678977; c=relaxed/simple;
	bh=NS4ilObULb/+LNuO08aUDsktHnNBmiP8ABY85oWc1eI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D023pvrCbiKBE5OB4DURPOx6NovcHRli7E4nxk5qFmYv5DC5Iqw5ThvtyTLyeouh+r7Yt0rU0EE6PVoOCbg/bADJ4Vn0bD/kMv2f6AXd2xx4FD/zdQH9u8GPG236jdQACn58wxUIHVbalH2Njd6pER0B2ufXq11j4Ino4zWYCBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LfVeRAgN; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LfVeRAgN"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53a007743e7so8052792e87.1
        for <iommu@lists.linux.dev>; Wed, 23 Oct 2024 03:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729678974; x=1730283774; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=it5qqymkWGY0OitCSnqR7X8aXYDfuNSva2WMI6HrQ68=;
        b=LfVeRAgNovGrjMuBW79GgUIc6z/9n0Htt8YA/V90B+aNi7lWOcRqU+zrWpHkeHqrRq
         YEpLXPJIQNiNQ38zDdF9tjQ9NgCka2BXc6eGQMc9mftn+9vZiF6pnnTZapYT71eQOncV
         GLXXoFrXi7kuiswzW326NsTBfikyZZwq3V1MIJiYogVZ2VfLnuc4DnrTWZm7oQf6skBC
         O3fiE5BQUbydB6hs348SYkOuvfmp/+xP5NHRqGRaaEBiWsU4AcpxlWl0ATRqO4CTzTWp
         O5MGCvNcZ1ZNSlSV5sXEDoBw+qNOYSbEDJBfTLfyOnD4IwVr9WCIdzxLc68QfCMlUmaK
         sdAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729678974; x=1730283774;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=it5qqymkWGY0OitCSnqR7X8aXYDfuNSva2WMI6HrQ68=;
        b=T3BiWvj4jYl8Ee4DBX7N/scRX3ZXNVQZwpTQrQ39uJWxJGLdfb8JFiaGFjZCLydA0C
         yFufrjgG/CkzUyKe0kJSi0xc1BIysRKlp8myZydfIVddYKGiPZHxWZUTNYH/55viFbPf
         4hRgK0R9ijnrYLULJe/acZynWIRVwYxAapLcuegKgZwa9hgLD9nlh+3/t/Y4yC43fW8p
         Me/pmLhraDvq7xjp+77JFWc3EsIDa9voIwjwt9iTtiQ1yISfimPTMzQkX8zgtS12oSfb
         5rK/PzyZmUVX0p4OTTEhaE8fyaZHeP4ba/TPBwZzlufsHhu59VBxAZkiza66WX1fBU0V
         /s1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVDc/+3BQ5v75LxzImwgBIKXCy/UCpeANL/piaoV55aUDze57ECK8XUWpPTZYvf2165wXQzWQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzLm59vDuHObwDUs6SI1+hBZZX/6kVOI2ciKfBx76wubdUmGEFG
	i5Qrj91gsiOO15s9xlmFl6AdGPvTBi+mfbEvXjoNtWDAYlLJcClreU5SoZrcNww+BBTWyK7/36/
	gqG5skJmrJFF7xk2t/LSqhczed8XRjxcRrALJSpzLUvsDeqHBR6CDnB4QS/A=
X-Google-Smtp-Source: AGHT+IHSlBLk0S83wm+5RZnogzP4oUfDRPvMnigWOthmmvnTrPqpN9jwiZcT3cwHLQu70zUFj7sVT87cHsqqjLDYfWw=
X-Received: by 2002:a05:6512:308a:b0:536:56d8:24b4 with SMTP id
 2adb3069b0e04-53b1a30c28cmr1039048e87.5.1729678974140; Wed, 23 Oct 2024
 03:22:54 -0700 (PDT)
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
 <CABQgh9Hd0QCfEtVcMyXG+=KHuZdGGUA=kk5iL_ysOzfOpLh=-w@mail.gmail.com> <20241022145257.GB864191@nvidia.com>
In-Reply-To: <20241022145257.GB864191@nvidia.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Wed, 23 Oct 2024 18:22:42 +0800
Message-ID: <CABQgh9E4XE6G7cK6_77ZsXgvfdOfa4rXXU2VUVxkqRd01tG+Rw@mail.gmail.com>
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

On Tue, 22 Oct 2024 at 22:53, Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Tue, Oct 22, 2024 at 10:30:10PM +0800, Zhangfei Gao wrote:
> > On Fri, 18 Oct 2024 at 21:53, Jason Gunthorpe <jgg@nvidia.com> wrote:
> > >
> > > On Wed, Oct 16, 2024 at 12:25:03PM -0300, Jason Gunthorpe wrote:
> > > > > > smmu-v3 needs some more fixing to move that
> > > > > > arm_smmu_master_enable_sva() logic into domain attachment.
> > > > >
> > > > > Will think about this, Thanks Jason
> > > >
> > > > Can you test it if a patch is made?
> > >
> > > Here it is:
> > >
> > > https://github.com/jgunthorpe/linux/commits/smmuv3_nesting/
> > >
> > > fa1528253d2210 iommu: Remove IOMMU_DEV_FEAT_SVA
> > > 5675560a272cf5 iommu/vt-d: Check if SVA is supported when attaching the SVA domain
> > > 94bc2b9525b508 iommu/arm-smmu-v3: Put iopf enablement in the domain attach path
> > >
> > > Let me know..
> >
> > With these patches, do we still need ops->user_pasid_table?
>
> It makes no change - you need user_pasid_table to make
> IOMMU_DOMAIN_NESTED work.
>
> If you aren't using IOMMU_DOMAIN_NESTED you shouldn't need it.

OK, I misunderstood.

Then with user_pasid_table=1
both with these patches and without patches, user page fault is OK.

>
> > if (fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID) {
> >                 attach_handle = iommu_attach_handle_get(dev->iommu_group,
> >                                 fault->prm.pasid, 0);
> >
> > // is attach_handle expected effect value here?
> >                 if (IS_ERR(attach_handle)) {
> >                         const struct iommu_ops *ops = dev_iommu_ops(dev);
> >
> >                         if (!ops->user_pasid_table)
> >                                 return NULL;
> >                         /*
> >                          * The iommu driver for this device supports user-
> >                          * managed PASID table. Therefore page faults for
> >                          * any PASID should go through the NESTING domain
> >                          * attached to the device RID.
> >                          */
> >                         attach_handle = iommu_attach_handle_get(
> >                                         dev->iommu_group, IOMMU_NO_PASID,
> >                                         IOMMU_DOMAIN_NESTED);
> >
> > Now I still need set ops->user_pasid_table, since attach_handle can not
> > return from the first iommu_attach_handle_get with fault->prm.pasid = 1,
> > but the second iommu_attach_handle_get with  IOMMU_NO_PASID,
> > suppose it is not expected?
>
> The second handle_get will always fail unless you are using
> IOMMU_DOMAIN_NESTED in userspace with iommufd.
>
> What testing are you doing exactly?

I am testing vsva based on Nico's iommufd_viommu_p2-v3 branch,
which requires IOMMU_DOMAIN_NESTED in user space with iommufd.

About the three patches
1. Tested host sva, OK
2. Simply tested vsva on guests, OK, will do more tests.

Thanks
