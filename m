Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EC8C2D6
	for <iommu@lists.linux.dev>; Thu, 30 Mar 2023 05:41:37 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id iw3so17085890plb.6
        for <iommu@lists.linux.dev>; Wed, 29 Mar 2023 22:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680154896;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TAnOB62ctYJ+xcEWyxTBLF5P3A7lopNUPybiMwLxhiM=;
        b=DTUrhqlp4U3R4lE552xBdl6Uc+TbMd6p8lMlbl3NjzDuTayKTinFKrApFHtf7OcIRH
         bUHI+FW26gqUrW0FsC2iL+vNGMZTxR7qVckNlZM/HNF0GCu3DMyIyZF+5xhGbufvIpYp
         FRZCp3xm611OkXsJKCmXIsGnRIgm1Bh4tZPmj/Zt9MuVogc2DrrC84VWLJfQjbmcfMaA
         fF5+vyQluAzErZ36nR2lJfkW/X1OUT8kP80n0ZEIytT5H3mxFffBPv9CsXN8bS/GTC2E
         y5zwKankCvXB37XjmwcatDeTjV2CSa7Vktt4EY1MvtGz00ZPX5p/MsXttBDL4oU881AI
         Rr8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680154896;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TAnOB62ctYJ+xcEWyxTBLF5P3A7lopNUPybiMwLxhiM=;
        b=H0pxErEK5ML7kAxQF+FbcDPUbnUxePmIXNdtKL9Z6BodQD3tdJKmWdnGPeYbO25SZc
         wPA+ltxSL9lkZgSyW5c68wBDadKcZ5JCbtM8MAsfsvph6MtxORxuCY91Isid8pimCTvz
         e1ySB0If7rtPPVVTcX71f97ML5X+yWAQ2chE81MVoeay14f+6UKLRgJNJXLeoTa48357
         qU3g7mP6FMpEYj5FPDT/mfgTeGlM7zOfHrOOMf56s8UjxQN7dRotH9aWeCjRP1ZglRZ8
         gszZ8gASXF/ImjP6Cibn/y5x4A6q3pptJHZhIqkK3VYOKWDmsSsVMqcnIUU+w/h+FfBB
         kkaA==
X-Gm-Message-State: AAQBX9drLl7TjejuhEQG4BMGhgXOrNKF0zq2xbvljdrMwZSfaSTsBEL+
	cb3kBFFLHU3ssqjIf87xqBNU
X-Google-Smtp-Source: AKy350aX6sHQt/xsMqLk0oB5MMOu2GEEt7EWROffMK/zg7fgAZiw32FaOUuJxhy2awLRaeopdDNM3Q==
X-Received: by 2002:a17:903:2442:b0:19a:9dab:3438 with SMTP id l2-20020a170903244200b0019a9dab3438mr5523514pls.2.1680154896628;
        Wed, 29 Mar 2023 22:41:36 -0700 (PDT)
Received: from thinkpad ([117.216.120.213])
        by smtp.gmail.com with ESMTPSA id c10-20020a170902b68a00b0019edf07eb06sm23926181pls.122.2023.03.29.22.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 22:41:36 -0700 (PDT)
Date: Thu, 30 Mar 2023 11:11:27 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Will Deacon <will@kernel.org>
Cc: joro@8bytes.org, catalin.marinas@arm.com, kernel-team@android.com,
	linux-kernel@vger.kernel.org, steev@kali.org, iommu@lists.linux.dev,
	johan+linaro@kernel.org, andersson@kernel.org,
	linux-arm-kernel@lists.infradead.org, robin.murphy@arm.com
Subject: Re: [PATCH v5] iommu/arm-smmu-qcom: Limit the SMR groups to 128
Message-ID: <20230330054127.GA9876@thinkpad>
References: <20230327080029.11584-1-manivannan.sadhasivam@linaro.org>
 <167991987524.1305084.466646756285487652.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <167991987524.1305084.466646756285487652.b4-ty@kernel.org>

On Mon, Mar 27, 2023 at 01:52:01PM +0100, Will Deacon wrote:
> On Mon, 27 Mar 2023 13:30:29 +0530, Manivannan Sadhasivam wrote:
> > Some platforms support more than 128 stream matching groups than what is
> > defined by the ARM SMMU architecture specification. But due to some unknown
> > reasons, those additional groups don't exhibit the same behavior as the
> > architecture supported ones.
> > 
> > For instance, the additional groups will not detect the quirky behavior of
> > some firmware versions intercepting writes to S2CR register, thus skipping
> > the quirk implemented in the driver and causing boot crash.
> > 
> > [...]
> 
> Applied to will (for-joerg/arm-smmu/updates), thanks!
> 

Thanks Will! Could you please tag this patch for 6.3-rcS? Even though this patch
is not fixing any issue introduced in 6.3, the affected platform (SC8280XP) has
reasonable upstream support in 6.3 and the distro folks would like to stick to
it for some time. This patch will allow them to boot mainline without any
additional out-of-tree patches.

- Mani

> [1/1] iommu/arm-smmu-qcom: Limit the SMR groups to 128
>       https://git.kernel.org/will/c/122611347326 
> 
> Cheers,
> -- 
> Will
> 
> https://fixes.arm64.dev
> https://next.arm64.dev
> https://will.arm64.dev

-- 
மணிவண்ணன் சதாசிவம்
