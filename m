Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26474182DB
	for <iommu@lists.linux.dev>; Thu, 31 Aug 2023 17:03:02 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1bf6ea270b2so7428565ad.0
        for <iommu@lists.linux.dev>; Thu, 31 Aug 2023 10:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1693501382; x=1694106182; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LHgjjj35OJGXCjuPasaEGJ/b/jcHEmhkYoXcUVIk7ww=;
        b=fERy1P+RpHYldUxVeRf7Sbq7ssnBUZLcaaOdHDxTwbqy+fNwxPe5FP18k1IGHkhBOs
         pGOdGfrs7o4b8U0kK4FVSfNA8diPVXxo8djlxJ3pyLrPgR9tslcYue2aC9bHibOXSuhU
         dBMoK8EqXc09wYjljc1NoSDXqtDTN30AKRxAZrSbcP9xaY71PFnf8ycNSakks889VpRK
         7H10YmmtBeU/cjbNtVgbDe5DooWOyM01W1zY092aVdAWZj5e2ywN8sTkPU+J2N6HkfKq
         7Ln9i/GVSGM5tDTnPgfiql4bcNmHe7jSCXY6qVIIOVlK5yX9paxiRneuHXpyptJjT2N5
         ILnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693501382; x=1694106182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LHgjjj35OJGXCjuPasaEGJ/b/jcHEmhkYoXcUVIk7ww=;
        b=DzWI1+yF7y+f21XImGHhnYzQlO9Gu4MYBqpViF50+JUunfSL7LXIBEaPhFZFSzsSfo
         GkRhDaH8hOVICUoswlJP75akqlOXB9yeOHcK4edU5zt9um/24/RC/8HBh6kJTwXmOv/9
         opveDOl2AMSRPwe9N+ZxwC7MPqYlWJ0/sFcIXkJin1viNHNtEn1VxCC2+Jz2yZ8ukPdO
         qGSDWwjfoF7asVLusagkFHSJXrhpvN296FIV29HzIZT64BLx3V+6LgiEBU8CbbSgBkH8
         /z4+DLbaXbDhNMyL9d8zor1nB5N6lR3tzwL0mZ+2X3n5dOmv+gKWy/ctxL32Nc5L3Ujs
         5V8g==
X-Gm-Message-State: AOJu0YzwZMgPO8s3EssA9+LxTu4QrHtA2K7qEGcp9PJ6oJX7sGdRDgW/
	ep5WtaeYg9ESF6QoVIdFV+A63A==
X-Google-Smtp-Source: AGHT+IF+htXs2E3/1dWO3dXoakLSbjGOY+B/JfHkO5GVPE7OJGYw2rF1HEEP9wx5/tbOWtsOFEQO4g==
X-Received: by 2002:a17:902:b588:b0:1b6:649b:92cc with SMTP id a8-20020a170902b58800b001b6649b92ccmr185987pls.69.1693501382283;
        Thu, 31 Aug 2023 10:03:02 -0700 (PDT)
Received: from ziepe.ca ([207.140.200.197])
        by smtp.gmail.com with ESMTPSA id jw14-20020a170903278e00b001b9d95945afsm1482930plb.155.2023.08.31.10.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 10:03:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qbl4M-000IVp-Uu;
	Thu, 31 Aug 2023 14:02:58 -0300
Date: Thu, 31 Aug 2023 14:02:58 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Tina Zhang <tina.zhang@intel.com>, Kevin Tian <kevin.tian@intel.com>,
	Michael Shavit <mshavit@google.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] iommu: Introduce mm_get_pasid() helper function
Message-ID: <ZPDHwseKQ3IC8dT9@ziepe.ca>
References: <20230827084401.819852-1-tina.zhang@intel.com>
 <20230827084401.819852-3-tina.zhang@intel.com>
 <7000c8d5-6989-0329-05ad-b96ed68631c0@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7000c8d5-6989-0329-05ad-b96ed68631c0@linux.intel.com>

On Thu, Aug 31, 2023 at 01:14:20PM +0800, Baolu Lu wrote:
> On 2023/8/27 16:43, Tina Zhang wrote:
> > diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> > index e95b339e9cdc0..e6377cff6a935 100644
> > --- a/drivers/iommu/intel/svm.c
> > +++ b/drivers/iommu/intel/svm.c
> > @@ -306,13 +306,13 @@ static int intel_svm_bind_mm(struct intel_iommu *iommu, struct device *dev,
> >   	unsigned long sflags;
> >   	int ret = 0;
> > -	svm = pasid_private_find(mm->pasid);
> > +	svm = pasid_private_find(mm_get_pasid(mm));
> >   	if (!svm) {
> >   		svm = kzalloc(sizeof(*svm), GFP_KERNEL);
> >   		if (!svm)
> >   			return -ENOMEM;
> > -		svm->pasid = mm->pasid;
> > +		svm->pasid = mm_get_pasid(mm);
> >   		svm->mm = mm;
> >   		INIT_LIST_HEAD_RCU(&svm->devs);
> > @@ -350,7 +350,7 @@ static int intel_svm_bind_mm(struct intel_iommu *iommu, struct device *dev,
> >   	/* Setup the pasid table: */
> >   	sflags = cpu_feature_enabled(X86_FEATURE_LA57) ? PASID_FLAG_FL5LP : 0;
> > -	ret = intel_pasid_setup_first_level(iommu, dev, mm->pgd, mm->pasid,
> > +	ret = intel_pasid_setup_first_level(iommu, dev, mm->pgd, mm_get_pasid(mm),
> >   					    FLPT_DEFAULT_DID, sflags);
> >   	if (ret)
> >   		goto free_sdev;
> > @@ -364,7 +364,7 @@ static int intel_svm_bind_mm(struct intel_iommu *iommu, struct device *dev,
> >   free_svm:
> >   	if (list_empty(&svm->devs)) {
> >   		mmu_notifier_unregister(&svm->notifier, mm);
> > -		pasid_private_remove(mm->pasid);
> > +		pasid_private_remove(mm_get_pasid(mm));
> >   		kfree(svm);
> >   	}
> 
> There is no need to use mm_get_pasid(mm) in the set_dev_pasid path. The
> pasid has already passed as a parameter. Perhaps, pass domain and pasid
> to intel_svm_bind_mm(), or simply merge intel_svm_bind_mm() to
> intel_svm_set_dev_pasid()?
> 
> Something like below?

Yes please! As a prep patch 'remove mm->pasid references from vt-d'

Jason
