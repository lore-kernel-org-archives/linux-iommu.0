Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436EC1EBFE3
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 08:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742544820; cv=none; b=RhWBmWLIcv3VhCjcaAkeD13T2BCO5WqLWNkDawfQilgi5sCe6JpDNUILwAjx2iQSQVmiY0YMlGpDracWcwH/WWhwZySiT5dW6NXiKFC5glmS53uM/VlHJVRw5UgI44iAjaOOptjmr1aD7SXynUO1uRnE1AQ/NSlPCv1Iyh4OHhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742544820; c=relaxed/simple;
	bh=hQF6KGOKBrlIHgbz1bnGZ9MVxRMHm3H7IJHrI4A2bXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNm4JaFUnuOMoIv8RCZvWcmvCoF9KVj5ZPAiEK/02AmIzX537vTaarSYpN3ywVGfWU7rYOwdXezwJ63yM3Eksvszd/pf2Pb4IpzokU7vP/NBFvhk71zCNVzVbx7rCHRdn7nkcwz+ftRuxEYc+dkxTWGmz8CjezaNijrxKntt1hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NvsnJnKr; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NvsnJnKr"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2240aad70f2so173025ad.0
        for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 01:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742544818; x=1743149618; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=r/UF8q54ifPheDiTeE95dMT57ijCKqsuC6+F82IxXhA=;
        b=NvsnJnKr7YGkjn4ya1CuR6FOwn6aVk0FtbAiQjZjgzJEE5OeJx2Emyk20Ts/It5aXA
         ogBRhFBPIwezAF+ADDdY+JrJ7o1y3gz3xLdDSdc4IDX7nOd4rSeq3oSOAJJiG3PceQjg
         QndSwH5EgbhXd55PBb3iF2IzIA5mpY+2jCRMavynyaVEc6MBX/tWuR3zoIbjrTeESn0g
         gNl4Btaq51EulmIZXoZtPrkCPfelMyR9eaC6WGWMr0FHgkzzcVZIuQt3hfF9Er3XcUxg
         nIFDTXUKP2SvCxjbAYYxlpDb7g/tipNup4i0J4ZrHlEJNREp2qVSFyvtblyTz0+St/yv
         qxyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742544818; x=1743149618;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r/UF8q54ifPheDiTeE95dMT57ijCKqsuC6+F82IxXhA=;
        b=pI0rO6N/ItE8L/B1CxFyeOBmCkoDsFBS0y2I5403tJEyVHUdabmBzeO7eF4OXsJQl4
         4DINxwJEUVZjumG4aWlVVxfNLpdHwNim+wCy6P5qQobfihJ/AXYVtDwUcC+MahVf6FFU
         6NSe3OoXK8JHjStjVpYwwG3w4zyppbbF23YeRDq1s3chRxfk7pRmsGnsgzib70Zr/eVP
         Hma+IR7RdnKwMf9Q4IEvGx1gUdlwFLkOtalbGovL2fBihRChcfix7sxUDTfsFvLtmbGD
         HIheZVVOEERzCQgOChvA+1ClKrHECT1pTTEK0Nm2M5TR0HL/dxWsDPH4zGdbxfTWc1r2
         u/Zg==
X-Forwarded-Encrypted: i=1; AJvYcCU5FeIuXA9HF7W6Ikabh5vCt8ExLVb5QOn615dmbLChG0blT2HU97KEqJvZBvwbV+PBIOKEzA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwXwgS5b4m1ewYUAgWo7FNN2W/Jua4n5e9Zr1LOkzUyP6DBOk2h
	Jb6yFC5iD6+JDo2fjxIViOsI9aozTDspp4aYZMY6G/n2x7ZAcP9Pj9zYjsvulQ==
X-Gm-Gg: ASbGncsiDxF706uyrsZ5vnd38kf16zeEoXDKWP7aKLgubtVA9mL5OqkteORbPRUBoTC
	p1/UVCOfglJy66kSQ2Z1LRk9SI7lxOWFNKVZaJ2npDxL8VdUGAEs5qst1kT0embCdlZ1fxjgtVb
	FWKpqub8gtMdVkVFSPzy8ZXSIUlPt56FzDXtgndtn3keAR66OcVbJGF+tunWxwkQvV9am8bcKYg
	r9RUuZs9TXlEeUg5Up122q4ZorDP+yXUhzBy5H2CLLyF4IQ5S/OCCR+FUrBcOzTRHr9A1pAWCTd
	6bUGG19QsfrMfDmDnCdYz3KsduoAbprACVlXZTI09UC99vbJS9ZXiG5j83FuhAeMrooCfNXItn2
	vK2A=
X-Google-Smtp-Source: AGHT+IFNnQeEmkzCFk7+czoz8B9x5jdfWZ0XD1ukykO9y2a9FOkKFI4gW95YZ7YuFJTwVqi0wQ3E/Q==
X-Received: by 2002:a17:902:e94f:b0:224:6c8:8d84 with SMTP id d9443c01a7336-227819ebf92mr2443575ad.4.1742544818204;
        Fri, 21 Mar 2025 01:13:38 -0700 (PDT)
Received: from google.com (188.152.87.34.bc.googleusercontent.com. [34.87.152.188])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af8a284825esm1153581a12.43.2025.03.21.01.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 01:13:37 -0700 (PDT)
Date: Fri, 21 Mar 2025 08:13:30 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 3/5] iommu/arm-smmu-v3: Implement pm_runtime & system
 sleep ops
Message-ID: <Z90fqiVVuMnxX0W6@google.com>
References: <20250319004254.2547950-1-praan@google.com>
 <20250319004254.2547950-4-praan@google.com>
 <CAFgf54pNbmb75LKnaqbD4o9xZF4sm7ssrki1Srq-mYfrVJwBAQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFgf54pNbmb75LKnaqbD4o9xZF4sm7ssrki1Srq-mYfrVJwBAQ@mail.gmail.com>

On Thu, Mar 20, 2025 at 10:33:41PM +0000, Mostafa Saleh wrote:
> On Wed, Mar 19, 2025 at 12:43 AM Pranjal Shrivastava <praan@google.com> wrote:
> >
> > Implement pm_runtime and system sleep ops for arm-smmu-v3. The smmu is
> > disabled as part of the suspend callbacks after ensuring the completion
> > of all pending commands and is configured to abort any transactions that
> > happen after disabling the smmu. The smmu shall be reinitialized in the
> > resume callback by invoking the `arm_smmu_device_reset` helper.
> >
> > The MSIs are freed as part of the suspend and are re-allocated during
> > the resume operation.
> >
> > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> > ---
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 106 ++++++++++++++++++++
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |   2 +
> >  2 files changed, 108 insertions(+)
> >
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > index f65d9bca0392..caf750470772 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -26,6 +26,7 @@
> >  #include <linux/pci.h>
> >  #include <linux/pci-ats.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> >  #include <linux/string_choices.h>
> >  #include <kunit/visibility.h>
> >  #include <uapi/linux/iommufd.h>
> > @@ -108,6 +109,32 @@ static const char * const event_class_str[] = {
> >
> >  static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master);
> >
> > +static int arm_smmu_rpm_get(struct arm_smmu_device *smmu)
> > +{
> > +       int ret;
> > +
> > +       if (pm_runtime_enabled(smmu->dev)) {
> > +               ret = pm_runtime_resume_and_get(smmu->dev);
> > +               if (ret < 0) {
> > +                       dev_err(smmu->dev, "Failed to resume device: %d\n", ret);
> > +                       return ret;
> > +               }
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
> > +{
> > +       int ret;
> > +
> > +       if (pm_runtime_enabled(smmu->dev)) {
> > +               ret = pm_runtime_put_autosuspend(smmu->dev);
> > +               if (ret < 0)
> > +                       dev_err(smmu->dev, "Failed to suspend device: %d\n", ret);
> > +       }
> > +}
> > +
> >  static void parse_driver_options(struct arm_smmu_device *smmu)
> >  {
> >         int i = 0;
> > @@ -4850,6 +4877,84 @@ static void arm_smmu_device_shutdown(struct platform_device *pdev)
> >         arm_smmu_device_disable(smmu);
> >  }
> >
> > +
> > +static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
> > +{
> > +       struct arm_smmu_device *smmu = dev_get_drvdata(dev);
> > +
> > +       /* We might get the vcmdq */
> > +       struct arm_smmu_cmdq_ent cmd = {
> > +               .opcode = smmu->features & ARM_SMMU_FEAT_E2H ?
> > +                       CMDQ_OP_TLBI_EL2_VA : CMDQ_OP_TLBI_NH_VA,
> > +       };
> > +
> > +       struct arm_smmu_cmdq *cmdq = arm_smmu_get_cmdq(smmu, &cmd);
> > +       struct arm_smmu_ll_queue *llq = &cmdq->q.llq;
> > +
> > +       /*
> > +        * Since suspend is invoked when all clients have been
> > +        * we don't expect more commands to be added to the cmdq.
> > +        * Thus, wait for all existing commands to complete.
> > +        */
> > +       arm_smmu_cmdq_shared_lock(cmdq);
> > +       arm_smmu_cmdq_poll_until_empty(smmu, cmdq, llq);
> > +       arm_smmu_cmdq_shared_unlock(cmdq);
> > +
> > +       /* Disable all queues */
> > +       arm_smmu_device_disable(smmu);
> > +
> > +       /* Abort all transactions to avoid spurious bypass */
> > +       arm_smmu_update_gbpa(smmu, GBPA_ABORT, 0);
> > +
> > +       /* Free all MSIs (re-allocated on resume) */
> > +       arm_smmu_free_msis(dev);
> > +
> > +       dev_dbg(dev, "Suspending smmu\n");
> > +       return 0;
> > +}
> > +
> > +static int __maybe_unused arm_smmu_runtime_resume(struct device *dev)
> > +{
> > +       int ret;
> > +       struct arm_smmu_device *smmu = dev_get_drvdata(dev);
> > +
> > +       dev_dbg(dev, "Resuming device\n");
> > +
> > +       /*
> > +        * The reset will re-initialize all the queues with the base addr,
> > +        * prod and cons maintained within struct arm_smmu_device as well as
> > +        * re-wire the IRQs and/or enable MSIs and install relevant handlers.
> > +        */
> > +       ret = arm_smmu_device_reset(smmu);
> > +
> > +       if (ret)
> > +               dev_err(dev, "Failed to reset during resume operation: %d\n", ret);
> > +
> > +       return ret;
> > +}
> > +
> > +static int __maybe_unused arm_smmu_pm_suspend(struct device *dev)
> > +{
> > +       if (pm_runtime_suspended(dev))
> > +               return 0;
> > +
> > +       return arm_smmu_runtime_suspend(dev);
> > +}
> > +
> > +static int __maybe_unused arm_smmu_pm_resume(struct device *dev)
> > +{
> > +       if (pm_runtime_suspended(dev))
> > +               return 0;
> > +
> > +       return arm_smmu_runtime_resume(dev);
> > +}
> > +
> > +static const struct dev_pm_ops arm_smmu_pm_ops = {
> > +       SET_SYSTEM_SLEEP_PM_OPS(arm_smmu_pm_suspend, arm_smmu_pm_resume)
> 
> I guess, as there is no specific logic in the system suspend/resume handlers,
> SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
> would be enough?

Ack. Thanks for this! :)

> 
> Thanks,
> Mostafa
> 

-Praan

> > +       SET_RUNTIME_PM_OPS(arm_smmu_runtime_suspend,
> > +                          arm_smmu_runtime_resume, NULL)
> > +};
> > +
> >  static const struct of_device_id arm_smmu_of_match[] = {
> >         { .compatible = "arm,smmu-v3", },
> >         { },
> > @@ -4866,6 +4971,7 @@ static struct platform_driver arm_smmu_driver = {
> >         .driver = {
> >                 .name                   = "arm-smmu-v3",
> >                 .of_match_table         = arm_smmu_of_match,
> > +               .pm                     = &arm_smmu_pm_ops,
> >                 .suppress_bind_attrs    = true,
> >         },
> >         .probe  = arm_smmu_device_probe,
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > index bd9d7c85576a..6bac83a511e2 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > @@ -505,6 +505,8 @@ static inline unsigned int arm_smmu_cdtab_l2_idx(unsigned int ssid)
> >  #define MSI_IOVA_BASE                  0x8000000
> >  #define MSI_IOVA_LENGTH                        0x100000
> >
> > +#define RPM_AUTOSUSPEND_DELAY_MS       15
> > +
> >  enum pri_resp {
> >         PRI_RESP_DENY = 0,
> >         PRI_RESP_FAIL = 1,
> > --
> > 2.49.0.rc1.451.g8f38331e32-goog
> >
