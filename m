Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1CA2F36
	for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 02:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708483515; cv=none; b=kMfc3OsBdyXkQDlD35LyYj3+On3NhPTPQvJ525nmnUl7gqLYZBF66GB6J5CTWDLBBlGrWApWWE5YFycfZ7+BGaqZCAQsbBgseZy869E8nhMnKDDZ9fjlYoozjNfQtV/DRdDOT19dHH+PkoqVrm4/DWdpYaz3XyNgqgWjPaMDN48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708483515; c=relaxed/simple;
	bh=p4WjEooW4ErxBw+WqcK/RzKhb/ec6O5a1jY5Hxvm4JY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=reMvRIpB2eZc6b3UjSRgoslIH/wR8NaI9Y5BDrgBoBANmAiIZ1P7e059tjaRal2IqKMdpKn3vn0lsHDe59qOQJZkKKlQr61TwIxj92LrkWPqVEUsfgfhYUexKm9GAYbyFVcq4mOuFZLwXgjoy7/hM2qKZEXBN8Pnc7z3crB9w70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D/nZ4H5Z; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D/nZ4H5Z"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d208d0b282so82738681fa.0
        for <iommu@lists.linux.dev>; Tue, 20 Feb 2024 18:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708483512; x=1709088312; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lxtvdPikO0D3wFK3zR7keTqhktStBJy3OKU49D/C2cg=;
        b=D/nZ4H5ZmN93pc0YmRdrJE6EMf+OaBURLwtuh1jL19VwECDPls2qUG/HmjfutHNgq4
         CQM8m2l596EAJBu412iu3MOYTBrU6qsepX3D3s/P3navouWctnZg2ulq9KMTdHBIGP/G
         Tw7sYMFGzIxQlUiHWzgwRJLSsXlIS0EsHGqEUdieSSxsK8m19bWYFG0TZbQ/H0CjEWXQ
         P3MUyPdBZaTRMteCnG1cQaOpJl8W6BQveJnuQAOKB2ZVtBW36AGZlrpxTjkX93Izo0cK
         ZgPUMBrEvbt2VkgvQwY9VARCFNcSb4JyjDnG9Cb15UIq8BKRYtwixbLouDlD08L8IC0j
         UNvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708483512; x=1709088312;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lxtvdPikO0D3wFK3zR7keTqhktStBJy3OKU49D/C2cg=;
        b=NG5UR9OUaJMGZLcUa/A7Ao0h0wY3jK3eBsPkm9geC588IP/zMTum7nDWATGkqI/7qY
         rRgsUYF3jbKttbwrfntnSyVyX/YHEIr2HwyIplgaTvM0038aH/mZZ6XnBlVu4j0GfvEA
         JtGOhNTbeE4ojVGmabNXaqDFSc+ECMQlJLypZOHHWuWq7OiAskOSqeBrjTtYi6V5lgM5
         dp1dvL1PM/xiCA2a7jsRE8A4kH6Td2fKAyGRJsmwCd5lRLVgJbtpZvMFH/Tuose0KeCi
         js2/qSMxZVQO6JXEu/EafmOPh+lLU25xIVThWZHA6dDTTWXtElRm0UezOY9LUwslabsQ
         JCsg==
X-Forwarded-Encrypted: i=1; AJvYcCUHjFXE31HccBOIN919GfLFRlLVUgy4a4S7IsnxWteoLCeJKxSU2CJBdILFh//IrfEKAl+8Nnel8AA0FWwU/6Q00qyIdew=
X-Gm-Message-State: AOJu0Yzltib+82z1QKqXhJUtkREu8zT75TQj/u/cnnrujlQu73MaYT28
	2e5Xfk5q5Q/xmkQHM3vX9VcbuXGpeRrissSEzSI8a9WVWNJxWZ0kg+TNWUCQOWCLToR24OFaV4F
	PH22MQRKwcijWWL7Jd1suF4p2/HeKa6f7bfPe5g==
X-Google-Smtp-Source: AGHT+IGjXuTMUG1kXRX/31qJY0wYEFOFWhe40srwxbcSRkzPHwrvJtnHGBqXlSxDymCVPTCRB6AYtrWwdvjN5BN6gqw=
X-Received: by 2002:a05:651c:1a26:b0:2d2:4450:92 with SMTP id
 by38-20020a05651c1a2600b002d244500092mr4283969ljb.20.1708483512158; Tue, 20
 Feb 2024 18:45:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231027000525.1278806-1-tina.zhang@intel.com>
 <20231027000525.1278806-6-tina.zhang@intel.com> <CABQgh9GWcqUeBkHQCpj5tzu6FnEgpOp3KOQ6s9c0X0KU7Ov1qw@mail.gmail.com>
 <MW5PR11MB5881C5CC15452017867B412889502@MW5PR11MB5881.namprd11.prod.outlook.com>
 <CABQgh9GxQmGU2HR73bSoZLuf4XZFhThXwUs_HJx6KwxDmXrXgg@mail.gmail.com> <b05958ba-0c47-45ba-8159-372779f9cc8b@linux.intel.com>
In-Reply-To: <b05958ba-0c47-45ba-8159-372779f9cc8b@linux.intel.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Wed, 21 Feb 2024 10:45:00 +0800
Message-ID: <CABQgh9FFpL=mEZ-7PqRRVg1eniYV176B7USbGP5MLPvhJaGo9A@mail.gmail.com>
Subject: Re: [PATCH v10 5/6] iommu: Support mm PASID 1:n with sva domains
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: "Zhang, Tina" <tina.zhang@intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, "Tian, Kevin" <kevin.tian@intel.com>, Nicolin Chen <nicolinc@nvidia.com>, 
	Michael Shavit <mshavit@google.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, 
	Hao Fang <fanghao11@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Feb 2024 at 10:06, Baolu Lu <baolu.lu@linux.intel.com> wrote:
>
> On 2024/2/21 9:28, Zhangfei Gao wrote:
> > On Wed, 21 Feb 2024 at 07:58, Zhang, Tina<tina.zhang@intel.com>  wrote:
> >
> >>>>   struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct
> >>>> mm_struct *mm)  {
> >>>> +       struct iommu_mm_data *iommu_mm;
> >>>>          struct iommu_domain *domain;
> >>>>          struct iommu_sva *handle;
> >>>>          int ret;
> >>>>
> >>>> +       mutex_lock(&iommu_sva_lock);
> >>>> +
> >>>>          /* Allocate mm->pasid if necessary. */
> >>>> -       ret = iommu_sva_alloc_pasid(mm, dev);
> >>>> -       if (ret)
> >>>> -               return ERR_PTR(ret);
> >>>> +       iommu_mm = iommu_alloc_mm_data(mm, dev);
> >>>> +       if (IS_ERR(iommu_mm)) {
> >>>> +               ret = PTR_ERR(iommu_mm);
> >>>> +               goto out_unlock;
> >>>> +       }
> >>>>
> >>>>          handle = kzalloc(sizeof(*handle), GFP_KERNEL);
> >>>> -       if (!handle)
> >>>> -               return ERR_PTR(-ENOMEM);
> >>>> -
> >>>> -       mutex_lock(&iommu_sva_lock);
> >>>> -       /* Search for an existing domain. */
> >>>> -       domain = iommu_get_domain_for_dev_pasid(dev, mm->pasid,
> >>>> -                                               IOMMU_DOMAIN_SVA);
> >>>> -       if (IS_ERR(domain)) {
> >>>> -               ret = PTR_ERR(domain);
> >>>> +       if (!handle) {
> >>>> +               ret = -ENOMEM;
> >>>>                  goto out_unlock;
> >>>>          }
> >>>>
> >>>> -       if (domain) {
> >>>> -               domain->users++;
> >>>> -               goto out;
> >>> Our multi bind test case broke since 6.8-rc1.
> >>> The test case can use same domain & pasid, return different handle,
> >>> 6.7 simply  domain->users ++ and return.
> >>>
> >>>> +       /* Search for an existing domain. */
> >>>> +       list_for_each_entry(domain, &mm->iommu_mm->sva_domains, next)
> >>> {
> >>>> +               ret = iommu_attach_device_pasid(domain, dev,
> >>>> + iommu_mm->pasid);
> >>> Now iommu_attach_device_pasid return BUSY since the same pasid.
> >>> And then iommu_sva_bind_device attach ret=-16
> >> Sounds like the test case tries to bind a device to a same mm multiple times without unbinding the device and the expectation is that it can always return a valid handle to pass the test. Right?
> > Yes
> >
> > The device can bind to the same mm multi-times and return different handle,
> > Since the refcount, no need to unbind and bind sequently,
> > The unbind can happen later with the handle.
>
> Is there any real use case to bind an mm to the pasid of a device
> multiple times? If there are cases, is it better to handle this in the
> uacce driver?

Yes, it is required for multi-thread, the device can provide
multi-queue to speed up.

>
>  From iommu core's perspective, it doesn't make sense to attach the same
> domain to the same device (or pasid) multiple times.

But is it the refcount domain->user++ used for?
Is there any reason not doing this.

Thanks
