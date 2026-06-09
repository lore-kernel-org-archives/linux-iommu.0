Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77F32F747A
	for <iommu@lists.linux.dev>; Tue,  9 Jun 2026 10:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780999781; cv=none; b=dyK/qjPHer23+/wztYrgSgBMlGtgwHaJmVBeOxqI4SvGbrK22++zXM5R0jyWUSr35j/2oyOJGlpZw9nEHoGFMS3GGGJYczP7sUEygYQ3WE2fR6XfP4Xe4VRyaEy+oKIYVQCiCR4Kwp4ruMxE4FSbgsnDRP2FKee7EJnlMQZoGfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780999781; c=relaxed/simple;
	bh=p1rqtOQ0PEswsN6BbN31NwrmlpxAk/8Idm1vzz9lDts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XoP9ZYISWUrGawQdRZKuq74aohwaCNrhq3PnBwmdRXLyi9DMFSPurWYc+Z1XilJVv0cdPJ+ES8CzZVuXG0Jet/9oqcjiAX8mHvGj10qu1dFvjyTqhzq7PqUct3EUM/hngBRFsCqXLTua6j/CXNDS0sY4UU+C6Xd/ExRVNrNPzD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sl/YSXCs; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sl/YSXCs"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2c0b1a48855so493265ad.0
        for <iommu@lists.linux.dev>; Tue, 09 Jun 2026 03:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780999779; x=1781604579; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pOuZ0Un1XyDPA3M8K6DEFfv4qZ9iFnyUgKSvec0q+Kc=;
        b=sl/YSXCsKE273xRgI1WsmSWVUK6x21r/40HpSokdggNahLjIMHkeBzgnwUGu3bn+zM
         I82ztPEIfXRHib+cJdytkF8WYRe+jutp62DpZJWK36GO7tgesHeSkgQEh63AJcY5WICs
         2D+oWMsGaUEeU6uAJtZcW80IefZg/5yvxSzdaXsvlHyajYBHYcuR9n6Am54nr1Pmhio6
         YmQ9n/7AGYAWJzgbcSQIt03LcYd2DIoIO17DMo6xK9qXLT8Cpv2ziR4DOFYq4Pu1FGwI
         AjufRRgyxtIAwazIBdsG7WSS6dx4SXbEoVbc5OcTu0abK6YX4RqkEG5IfBxuuTkRjsb8
         5fgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780999779; x=1781604579;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pOuZ0Un1XyDPA3M8K6DEFfv4qZ9iFnyUgKSvec0q+Kc=;
        b=V8XMI61kJ4t/sb70ZGrqMXI+fZoFw4Gp3DnfO5sqpZWDddxb556GpERj2aMUlucJOT
         81cqpIFr0J76jpFhIHnAeU6v9udbRxSwqmKLP0JMcjeMpNmLsVwd1QNdqINatTUMd03V
         PK07hp/tYTHt6MbDI62fU1wcypzN44b0Zlo4qHSTTHHINny8pXiDcTFc+LhYOa0dHuXX
         jp07/Ki2BT9T7Ao+J7vMLjU672flWEiiSRTllRATQ6YnhSSMDK0dDWMVv1NqfudGq5o9
         mgFr12MAjxB61UQtxKQ20M6zJQUMqRTfnoO71K4u5moE+ZQw8SOo5o5Tm6BGJAon/Baa
         bW1w==
X-Gm-Message-State: AOJu0YwoByITFi0ucuo5fCQPPxL/VX9AaVdgVVusmcT/ZXqMxSr0LJeh
	cNR8a7+bvUiFrbNjeELw2IvYK1yOqOCGRyV7xdmAxqp2SOJluUddDDQF/yv080veEw==
X-Gm-Gg: Acq92OGJ/tp+V1D4WsP/V5zIJD2ks0F/iXc+RXYDCm+MWxXxIzFzuONUmbtYx0trusv
	LJSuH8SA+3YsCJ6oo2A5QO1mXJBVKeQgLUARaPvxgPcsORSTOm8yFog0gSMYT7fbj1wAhFsRuIW
	Pts3xhQ+ANvzwpaT8tFJ0TirCmtVnCIctjh8taKLkZ6Wy0+yQZ8919waEueV+8Pq8lu1T0PmyAS
	C4HRKMr7Gt8N2RxVBiKP54Ll7/I7uLzmxGlg32BxfvHVeA3pHdNKmTcgSA51vqOU2lqohx/6Nev
	E/ta1ChisnjCZnC4bktaskflrDljA+qircYMdoSh/5w9ILsJM0IPzScUXqWd0la7csjyrhaqySV
	Od3Nc7MQ+zQ3j0vfRvMggRzaRbucyWwOD1gdYySNcJM/2EvqPsMqHTojnMclK/oF8p7PMsgCKmN
	OdtdzoeHygp7YVMACPYttBcJL1bjn4eWH0QRTv3Hx7XqRs2PfvaO7OTHDtZUobKJvbIh9B1ks=
X-Received: by 2002:a17:902:ced0:b0:2c1:ee6e:be20 with SMTP id d9443c01a7336-2c1ee6ec4f3mr7161455ad.30.1780999778681;
        Tue, 09 Jun 2026 03:09:38 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828e21c8sm24873083b3a.49.2026.06.09.03.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 03:09:38 -0700 (PDT)
Date: Tue, 9 Jun 2026 10:09:32 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Daniel Mentz <danielmentz@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 09/12] iommu/arm-smmu-v3: Implement pm_runtime &
 system sleep ops
Message-ID: <aifmXP7y90dv8uS9@google.com>
References: <20260601215909.3958732-1-praan@google.com>
 <20260601215909.3958732-10-praan@google.com>
 <CAE2F3rC4a55Hfg+JZZora4UYxJyz9WgUV_kqBt_ejUy+9RLzYQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2F3rC4a55Hfg+JZZora4UYxJyz9WgUV_kqBt_ejUy+9RLzYQ@mail.gmail.com>

On Sun, Jun 07, 2026 at 03:30:00PM -0700, Daniel Mentz wrote:
> On Mon, Jun 1, 2026 at 2:59 PM Pranjal Shrivastava <praan@google.com> wrote:
> > +static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
> > +{
> > +       struct arm_smmu_device *smmu = dev_get_drvdata(dev);
> > +       struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
> > +       int timeout = ARM_SMMU_SUSPEND_TIMEOUT_US;
> > +       u32 enables, target;
> > +       int ret;
> > +
> > +       /* Abort all transactions before disable to avoid spurious bypass */
> > +       arm_smmu_update_gbpa(smmu, GBPA_ABORT, 0);
> > +
> > +       /* Disable the SMMU via CR0.EN and all queues except CMDQ */
> > +       enables = CR0_CMDQEN;
> > +       ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0, ARM_SMMU_CR0ACK);
> > +       if (ret) {
> > +               dev_err(smmu->dev, "failed to disable SMMU\n");
> > +               return ret;
> > +       }
> > +
> > +       /*
> > +        * At this point the SMMU is completely disabled and won't access
> > +        * any translation/config structures, even speculative accesses
> > +        * aren't performed as per the IHI0070 spec (section 6.3.9.6).
> > +        */
> > +
> > +       /* Mark the CMDQ to stop and get the target index before the stop */
> > +       target = atomic_fetch_or_relaxed(CMDQ_PROD_STOP_FLAG, &cmdq->q.llq.atomic.prod);
> 
> I'm wondering if we need the non-relaxed version of atomic_fetch_or()
> here to benefit from the barrier guarantees. Otherwise, how do you
> ensure that CMDQ_PROD_STOP_FLAG isn't set before SMMUEN is cleared?

Ack. I agree we need a non-relaxed version, I missed that the STOP_FLAG
is purely RAM & was focused on the _relaxed variants to keep things
ordered as all were MMIO. I'll drop the relaxed semantics with the
STOP_FLAG.

> 
> > +       target &= CMDQ_PROD_IDX_MASK;

Thanks,
Praan
