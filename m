Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488A26FB2
	for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 01:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708480430; cv=none; b=Bqm/hyax7WNU/mjeBqVp0VijWMpEFx9DQkzJF12tJwSxGdvMRx/AuUwtygPO8ModgXBTdIq5/t0cnF3VOXpZWdMZ5RSE+SSQ0EZE5dWN1+wBpggDvit5ozhnXKUzlztoPbmxIBYy5xy1xZNoA3Oq3L33mx8fdH1mHzPZG2ZG1e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708480430; c=relaxed/simple;
	bh=X7DS4AxqZmwIGaiOTbhL7uSmpzpJXN4zPisSmEhXWzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ylo8lfogLL4ptGzw+j4LzQpp/Je3yuPQXI/fTVj3WtlhoL2p3mNlmGjAGJibhwioYhVvGYukorxPAzaLF1fmdRgp16snHyFz6raOZfVRj6sFdm9xAEBqu9SJJtOwAC53mYpuu9HUcGuKvo0vnbh1iy76cdk751XIUg+OTPhQ2qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vX4WYXeI; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vX4WYXeI"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-511976c126dso151467e87.1
        for <iommu@lists.linux.dev>; Tue, 20 Feb 2024 17:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708480426; x=1709085226; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xNv57wTrROpvBu7D7eRkAMBX/0S6ivveyoxRqXbvKXQ=;
        b=vX4WYXeIvLoLQXUzCUTXJaE4e8uuVkxdfRF++mnxtJG6hLLcLAsIPnBW10bU3n1k5P
         E6tRELbL2/jlWyo/auIIVNildlqYFRX+hvWLkW96xETQq8gVdFdKzPEfjKHPuCMgVLS8
         k9J8nKaL3cL+PrlDp4waLN4fc5CsInma4apxekn60TreWUYG9lytEXomV+Ihkk2a+XYy
         NYL/UQ/BUv70sXLxfVO6iGrr9Rzm2Lhiaa8/D4XtaAjbp6yjZ9pBsU6A1Gjoij0XIAOv
         VzUpyiOcxoaCMdHFxdRoU+Ku4hHDu1oV8wPSTQD8exrO04lsFgJJfAH+NhBtgYFF1pYJ
         c2vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708480426; x=1709085226;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xNv57wTrROpvBu7D7eRkAMBX/0S6ivveyoxRqXbvKXQ=;
        b=lKZUSe7dlS4dMTl8J3dbZ1ANupMvKPmxhOxukqE0hF4+kJeHVITgalfrU1R1K8gaG+
         704H0fbpDV5Sbc57bJd6S0TfY/6YBWtS8cc70OFVVuHbEAlklXinw+8q929f7jCGt9dy
         Q5Nt+R7RfAG9oyOb7GvaWA7rrcVcdT4FXArwlUxPhw/22U9YmJvdtnxgRxsFgoTgRoUV
         sHN8lwSlO8eZE+h1rrC2PvukwjH+j67s7q6mG5Il7ewCmxaEeG8TtJCh26vLmTSRvRm/
         34bNi77BGr65oWe1bTmfiD06OPZE3TysOL51Sb7ONEuuaKV9vXOdO5FLUFfhmh/yFFWZ
         TP2Q==
X-Gm-Message-State: AOJu0Yz/L6FYAfpuIgIJxYKaAlW7w9WyMxSvqw4AVWobfucxaO7MzLte
	kE9rcS8BExDp4gk9T4pH/8rddsQm1QpBf2PbzdBlCW8Oz9EHuYBnaZeVblMpkrQIff8Ui6xg7Wt
	JKr+uVC8dVy0t6sVXB87E9kI7vZ7xiD+IMAp3l2sj8JAA1ILODV93eLQ9RlE=
X-Google-Smtp-Source: AGHT+IF7gRjr9Hk5fW6BUGGbPQ45tQ34I5uYoYOH7wMtdjE5w7kHEwr10LtY/FMpzS+Tfzw5d9v8DCNbOYESwUeLQKk=
X-Received: by 2002:a05:6512:2021:b0:512:b041:d6cc with SMTP id
 s1-20020a056512202100b00512b041d6ccmr5213332lfs.29.1708480426340; Tue, 20 Feb
 2024 17:53:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231027000525.1278806-1-tina.zhang@intel.com>
 <20231027000525.1278806-6-tina.zhang@intel.com> <CABQgh9GWcqUeBkHQCpj5tzu6FnEgpOp3KOQ6s9c0X0KU7Ov1qw@mail.gmail.com>
 <MW5PR11MB5881C5CC15452017867B412889502@MW5PR11MB5881.namprd11.prod.outlook.com>
 <CABQgh9GxQmGU2HR73bSoZLuf4XZFhThXwUs_HJx6KwxDmXrXgg@mail.gmail.com>
In-Reply-To: <CABQgh9GxQmGU2HR73bSoZLuf4XZFhThXwUs_HJx6KwxDmXrXgg@mail.gmail.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Wed, 21 Feb 2024 09:53:34 +0800
Message-ID: <CABQgh9HTH9Utx1CGfni42VykJAFDoYChVbucSA0tmCpeV6Wpxg@mail.gmail.com>
Subject: Re: [PATCH v10 5/6] iommu: Support mm PASID 1:n with sva domains
To: "Zhang, Tina" <tina.zhang@intel.com>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	"Tian, Kevin" <kevin.tian@intel.com>, Nicolin Chen <nicolinc@nvidia.com>, 
	Michael Shavit <mshavit@google.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Feb 2024 at 09:28, Zhangfei Gao <zhangfei.gao@linaro.org> wrote:
>
> Hi, Tina
>
> On Wed, 21 Feb 2024 at 07:58, Zhang, Tina <tina.zhang@intel.com> wrote:
>
> > > >  struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct
> > > > mm_struct *mm)  {
> > > > +       struct iommu_mm_data *iommu_mm;
> > > >         struct iommu_domain *domain;
> > > >         struct iommu_sva *handle;
> > > >         int ret;
> > > >
> > > > +       mutex_lock(&iommu_sva_lock);
> > > > +
> > > >         /* Allocate mm->pasid if necessary. */
> > > > -       ret = iommu_sva_alloc_pasid(mm, dev);
> > > > -       if (ret)
> > > > -               return ERR_PTR(ret);
> > > > +       iommu_mm = iommu_alloc_mm_data(mm, dev);
> > > > +       if (IS_ERR(iommu_mm)) {
> > > > +               ret = PTR_ERR(iommu_mm);
> > > > +               goto out_unlock;
> > > > +       }
> > > >
> > > >         handle = kzalloc(sizeof(*handle), GFP_KERNEL);
> > > > -       if (!handle)
> > > > -               return ERR_PTR(-ENOMEM);
> > > > -
> > > > -       mutex_lock(&iommu_sva_lock);
> > > > -       /* Search for an existing domain. */
> > > > -       domain = iommu_get_domain_for_dev_pasid(dev, mm->pasid,
> > > > -                                               IOMMU_DOMAIN_SVA);
> > > > -       if (IS_ERR(domain)) {
> > > > -               ret = PTR_ERR(domain);
> > > > +       if (!handle) {
> > > > +               ret = -ENOMEM;
> > > >                 goto out_unlock;
> > > >         }
> > > >
> > > > -       if (domain) {
> > > > -               domain->users++;
> > > > -               goto out;
> > >
> > > Our multi bind test case broke since 6.8-rc1.
> > > The test case can use same domain & pasid, return different handle,
> > > 6.7 simply  domain->users ++ and return.
> > >
> > > > +       /* Search for an existing domain. */
> > > > +       list_for_each_entry(domain, &mm->iommu_mm->sva_domains, next)
> > > {
> > > > +               ret = iommu_attach_device_pasid(domain, dev,
> > > > + iommu_mm->pasid);
> > >
> > > Now iommu_attach_device_pasid return BUSY since the same pasid.
> > > And then iommu_sva_bind_device attach ret=-16
> > Sounds like the test case tries to bind a device to a same mm multiple times without unbinding the device and the expectation is that it can always return a valid handle to pass the test. Right?
>
> Yes
>
> The device can bind to the same mm multi-times and return different handle,
> Since the refcount, no need to unbind and bind sequently,
> The unbind can happen later with the handle.


With this diff can solve the issue, what's your suggestion?

@@ -88,10 +94,12 @@ struct iommu_sva *iommu_sva_bind_device(struct
device *dev, struct mm_struct *mm
        /* Search for an existing domain. */
        list_for_each_entry(domain, &mm->iommu_mm->sva_domains, next) {
                ret = iommu_attach_device_pasid(domain, dev, iommu_mm->pasid);
-               if (!ret) {
+               if (!ret || ret == -EBUSY) {
                        domain->users++;
                        goto out;
                }
@@ -141,8 +151,8 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
        struct device *dev = handle->dev;
        mutex_lock(&iommu_sva_lock);
-       iommu_detach_device_pasid(domain, dev, iommu_mm->pasid);
        if (--domain->users == 0) {
+               iommu_detach_device_pasid(domain, dev, iommu_mm->pasid);
                list_del(&domain->next);
                iommu_domain_free(domain);
        }

Thanks
