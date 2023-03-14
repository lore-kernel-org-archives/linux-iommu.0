Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932BC33EC
	for <iommu@lists.linux.dev>; Tue, 14 Mar 2023 11:26:34 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id h11-20020a17090a2ecb00b00237c740335cso14801337pjs.3
        for <iommu@lists.linux.dev>; Tue, 14 Mar 2023 04:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678793194;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CL2m5QJSCrBqCt1t0/+z74nTRJXZajDsckBb/Qqy+2U=;
        b=qCnBXJLD7xKIUQcuuxEe6d3U8ZPd04JvcUn3U78D0Y7ivGUvv0hAY2txCdo9INAH8e
         /N35QXRYe86s9Cp4Ti3Th5WfO5kA5s6BJWE2J9Ew5NFvLbXg4JNBEvOL7PbOB/MSDyNv
         bHisUR19w4HM0Rl4Q9cogACq3JiAlLsfq85EF6TKy57CqqQ1VJnGVAgE6ALmH4MXqcRJ
         YlDVkzEuLi1cdA/ZJDymtkYgv8FcN965DK/WFfNHLIgEStzPrjHenqgVqMpdmrHoav28
         w/ov8fBpySuBPrj6YOhqEMzQRLbWIvxiF/tpvH2KU8Qiox8Sy0kfVQ0IrOPgBxcoK5HS
         4E6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678793194;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CL2m5QJSCrBqCt1t0/+z74nTRJXZajDsckBb/Qqy+2U=;
        b=7ATtHJ+rida/qXNoZa9UKzFLy7hVtT+syAcLx9q64moHghJQhAhsJMyo8qFoh9Mlhk
         3y3VJZIg3Dfxw01fDg+p+cp1cOD009E1gozuKAhgWpnV31yH6C+GlJsGIt6pmf7EyBSY
         frnUe0UC+nv3W3hmvspjXCj+VdzE/B6URbYIksmC6nmnTAMrqJ2U2i2eiQKeggjAlTFn
         2byJD5T4zJSEfJk/NMK5gFwFl/8iejxhShC0+w+GwRWJzNB87dl3VftsSQKZ+4OZ63Ob
         jTldjyYNrSn+pTqzhh89xA5xTrMOrZsg51hrslMm+T1oRw4HVbYCjSTr2Xta8uRZGGCM
         MrIw==
X-Gm-Message-State: AO0yUKViTHaLZ3FW4Jzgoh2VRtXalHhP8pP03tCMafTJte+Ar2OXGb2V
	2ukad0XSOQhbHowUAf13CLwA/m/spF5C9iDEGg==
X-Google-Smtp-Source: AK7set8u7KqlkfrMDgYmtIWW+7fCkQiPY32aBeWBgi+e3AEITQmWhDiSXofs7zaMfCL945Efb+t1zg==
X-Received: by 2002:a17:903:32cb:b0:19e:7f89:b3a7 with SMTP id i11-20020a17090332cb00b0019e7f89b3a7mr44278152plr.31.1678793193960;
        Tue, 14 Mar 2023 04:26:33 -0700 (PDT)
Received: from thinkpad ([117.217.177.49])
        by smtp.gmail.com with ESMTPSA id ko7-20020a17090307c700b0019b06263bcasm1516985plb.247.2023.03.14.04.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 04:26:33 -0700 (PDT)
Date: Tue, 14 Mar 2023 16:56:20 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Johan Hovold <johan@kernel.org>
Cc: will@kernel.org, joro@8bytes.org, robin.murphy@arm.com,
	andersson@kernel.org, johan+linaro@kernel.org, steev@kali.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommu/arm-smmu-qcom: Rework the logic finding the
 bypass quirk
Message-ID: <20230314112620.GB137001@thinkpad>
References: <20230314105905.137241-1-manivannan.sadhasivam@linaro.org>
 <ZBBX0n4S2QBYB3Pi@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZBBX0n4S2QBYB3Pi@hovoldconsulting.com>

On Tue, Mar 14, 2023 at 12:17:38PM +0100, Johan Hovold wrote:
> On Tue, Mar 14, 2023 at 04:29:05PM +0530, Manivannan Sadhasivam wrote:
> > The logic used to find the quirky firmware that intercepts the writes to
> > S2CR register to replace bypass type streams with a fault, and ignore the
> > fault type, is not working with the firmware on newer SoCs like SC8280XP.
> > 
> > The current logic uses the last stream mapping group (num_mapping_groups
> > - 1) as an index for finding quirky firmware. But on SC8280XP, NUSMRG
> > reports a value of 162 (possibly emulated by the hypervisor) and logic is
> > not working for stream mapping groups > 128. (Note that the ARM SMMU
> > architecture specification defines NUMSMRG in the range of 0-127).
> > 
> > So the current logic that checks the (162-1)th S2CR entry fails to detect
> > the quirky firmware on these devices and SMMU triggers invalid context
> > fault for bypass streams.
> > 
> > To fix this issue, rework the logic to find the first non-valid (free)
> > stream mapping register group (SMR) within 128 groups and use that index
> > to access S2CR for detecting the bypass quirk. If no free groups are
> > available, then just skip the quirk detection.
> > 
> > While at it, let's move the quirk detection logic to a separate function
> > and change the local variable name from last_s2cr to free_s2cr.
> > 
> > Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> > 
> > Changes in v2:
> > 
> > * Limited the check to 128 groups as per ARM SMMU spec's NUMSMRG range
> > * Moved the quirk handling to its own function
> > * Collected review tag from Bjorn
> > 
> >  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 48 ++++++++++++++++++----
> >  1 file changed, 40 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > index d1b296b95c86..48362d7ef451 100644
> > --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > @@ -266,25 +266,49 @@ static int qcom_smmu_init_context(struct arm_smmu_domain *smmu_domain,
> >  	return 0;
> >  }
> >  
> > -static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
> > +static void qcom_smmu_bypass_quirk(struct arm_smmu_device *smmu)
> >  {
> > -	unsigned int last_s2cr = ARM_SMMU_GR0_S2CR(smmu->num_mapping_groups - 1);
> >  	struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
> > -	u32 reg;
> > -	u32 smr;
> > +	u32 free_s2cr;
> > +	u32 reg, smr;
> >  	int i;
> >  
> > +	/*
> > +	 * Find the first non-valid (free) stream mapping register group and
> > +	 * use that index to access S2CR for detecting the bypass quirk.
> > +	 *
> > +	 * Note that only the first 128 stream mapping groups are considered for
> > +	 * the check. This is because the ARM SMMU architecture specification
> > +	 * defines NUMSMRG (Number of Stream Mapping Register Groups) in the
> > +	 * range of 0-127, but some Qcom platforms emulate more stream mapping
> > +	 * groups with the help of hypervisor. And those groups don't exhibit
> > +	 * the quirky behavior.
> > +	 */
> > +	for (i = 0; i < 128; i++) {
> 
> This may now access registers beyond smmu->num_mapping_groups. Should
> you not use the minimum of these two values here (and below)?
> 

Doh! yeah, you're right. Will fix it in v3.

Thanks,
Mani

> > +		smr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_SMR(i));
> > +
> > +		if (!FIELD_GET(ARM_SMMU_SMR_VALID, smr))
> > +			break;
> > +	}
> > +
> > +	/* If no free stream mapping register group is available, skip the check */
> > +	if (i == 128)
> > +		return;
> 
> Johan

-- 
மணிவண்ணன் சதாசிவம்
