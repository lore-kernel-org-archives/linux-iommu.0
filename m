Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8994433
	for <iommu@lists.linux.dev>; Wed, 12 Jul 2023 09:45:24 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-31441dfbf97so7560024f8f.1
        for <iommu@lists.linux.dev>; Wed, 12 Jul 2023 02:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689155123; x=1691747123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BeHjmBMqae1zfZ9d1o7CDW2GBVL1eDyXHOBTuOaNFYg=;
        b=AH7cKSqAEvP2fqllKNUyTI6gGKtCoyOQcYze+d458Wne9rqOzCSA2nbNX0VOORk2ey
         jm7uZ2EG4i5+/RqwbtiPmiCHkqW7dNCfzEO2d0C6p++7CSaBagms4S+DBb0SWWvWfR52
         1fJNHgSiLTnlE+FwxtySO/TCT3WcfE1ztbhyFusZQiljr8ILDyysnD94riJoZrQv7RUw
         WoVPS4vXtlpt8mLHgAaDbGh21i1VHozDdmS3E9wTRYRM3Z2s5mjMequ4pgQV272XdcYj
         WYtXphFKBsU+NLbyj8H5Dysp2/YaIY/8mteiWJN7toASik1RaH7KY1LdrxZTXkZWKg29
         wXrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689155123; x=1691747123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BeHjmBMqae1zfZ9d1o7CDW2GBVL1eDyXHOBTuOaNFYg=;
        b=NIZyJ5FBjWyJKR8EFZjB4DPCVcekYK5dFVEHmUOgN09khEHr3c2CEkBMuh6xmR2rbR
         vcoAzNvWPzCv80uAxKq9z4PR69VGh7Fr2IE4MRU6LLTOMYsSfdbTkFowS/BM9/UJIbZ5
         kATXdLSE1W9HolFwdpw9ZTuevgNleWeyvwYcY9JBhyi7KKAgDkTyudnJDlx5Z7SDrNML
         +9HBF2DAUS1WBelpWg6G1Md64RUswO5G3Z9J3r/L24C1Me0oV+yzgTip5tY588YniRG8
         MIRLvlm+iGFrOWbueRStKy5/wPSufS4nlidLtil80zlYpgH+6DMDWmSMzzmXFPv7qAi6
         NXZA==
X-Gm-Message-State: ABy/qLYJ/ypi0OIu5DBySghVSRSOSh2wuM+kl0ilTHieA0Ya0TEN1/E+
	XXeJN60+Chc9XovFZQekw6rU7g==
X-Google-Smtp-Source: APBJJlHrEeMT+kJGs1oHD4HOzLI6iswJjrdlJA8OCycHTa0XqhhKKvXc0gGBPcdwUB5hP77AXSiBZQ==
X-Received: by 2002:a5d:56cd:0:b0:314:3983:1465 with SMTP id m13-20020a5d56cd000000b0031439831465mr18892557wrw.31.1689155123166;
        Wed, 12 Jul 2023 02:45:23 -0700 (PDT)
Received: from myrica ([2.219.138.198])
        by smtp.gmail.com with ESMTPSA id t12-20020a5d6a4c000000b00314329f7d8asm4577438wrw.29.2023.07.12.02.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 02:45:22 -0700 (PDT)
Date: Wed, 12 Jul 2023 10:45:22 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/9] iommu: Add common code to handle IO page faults
Message-ID: <20230712094522.GB507884@myrica>
References: <20230711010642.19707-1-baolu.lu@linux.intel.com>
 <20230711010642.19707-4-baolu.lu@linux.intel.com>
 <BN9PR11MB52761F71BA509501C1766E9A8C31A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <cbbe1175-40f3-805e-02c2-f887b3289f04@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbbe1175-40f3-805e-02c2-f887b3289f04@linux.intel.com>

On Wed, Jul 12, 2023 at 10:32:13AM +0800, Baolu Lu wrote:
> > btw is there value of moving the group handling logic from
> > iommu_queue_iopf() to this common function?
> > 
> > I wonder whether there is any correctness issue if not forwarding
> > partial request to iommufd. If not this can also help reduce
> > notifications to the user until the group is ready.
> 
> I don't think there's any correctness issue. But it should be better if
> we can inject the page faults to vm guests as soon as possible. There's
> no requirement to put page requests to vIOMMU's hardware page request
> queue at the granularity of a fault group. Thoughts?

Not sure I understand you correctly, but we can't inject partial fault
groups: if the HW PRI queue overflows, the last fault in a group may be
lost, so the non-last faults in that group already injected won't be
completed (until PRGI reuse), leaking PRI request credits and guest
resources.

Thanks,
Jean
