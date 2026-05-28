Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B184536B043
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 23:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780011038; cv=none; b=KQGIZg2VlL99Ivr30AZUaDcCSBagBfKQhFYtffRnvgo0hYw6fuLN0bT4tsuRkwRo51YerxWcObxIv8eaxjriBtGc1GYWjAChLaqHtLrrqnxE3RuO/NyFc7fXwlqByuc79yVjqYPI54XyoMgX0lMR4lMXalmyOk3Di6UriuHjAN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780011038; c=relaxed/simple;
	bh=+AZWhweYfsHMLx6ATS6Ij3LLkvDeMICWJRjGILRMvoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4t0SDydrhxU5w+ytkGZ1jJ2kJwrPFl4Tk7+7vjzArsU6dqWtKrhzz2JZiIoM9n7T3WnSzsj9cpNeJeCgxj8nd1QsQ7y6MyvrRJ1ooENqMl0OYwu44Yw/m82b1Wa53CsesAnZ+Gw3GNQv0etraWuKJXfQ3etQdWbjenSMCqaecs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C6r6090y; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C6r6090y"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2b46da8c48eso575ad.1
        for <iommu@lists.linux.dev>; Thu, 28 May 2026 16:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780011036; x=1780615836; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/NX5Pfy5zkSh9pOkTgi7qD1BFUzeZBn6TE9LTClbQbA=;
        b=C6r6090ygB+IxVp5uv6XRRDZ9iofCf9xhxyU092pd2zMkOe/KYEXa06ttsZNMH0jIy
         uKgFkF5MUPG61EVNPY4aplxZC3YMZ5gB7p9bxK4lM77ij8cO6QFcNvePvv35dbfirPC2
         QgIJMBxsURTwW46JhD1o3otYGzvMrR6GLUpcvV2mEwVpDvxIB56bperrSu24bKEdCoQV
         SUgORnCrEldyYIDIWaUW9cN1oSO9G6FAaaE9C+GmfgLpol8I2+JCUiBA+VMRu/DqYzrH
         uFcInOjy/EZkMqL7eoRZcdMPZCkqsnP1c/GMvB5/fYgJG2A+WbSWpT+VXAmTUZnvXWOd
         Y8Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780011036; x=1780615836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/NX5Pfy5zkSh9pOkTgi7qD1BFUzeZBn6TE9LTClbQbA=;
        b=YICgp7dPvOyTairrkZbQWZCPI07Y/b3lo/84kuyHdDfHJhazAeQj1J3Ub1RHLQB21H
         75iGdPO5umpNBAXY0+GWvR8FXVpfKQgJCtpxAzxj9RWJWRHt4xOQVnmpF1Mn65690cM5
         8rE0cX41nhUmxC30FXOSH2jF0cmBJR7hLcxNMvTg2kbm41K/VBp1Ym4Q13YmzcQ1I/jh
         gYeQEd9Ng7BYDRMcNLCtWjXmAXuDzl4seXPmn/mcSpUJ2rfFfKeboJKH17+W/gijpHQt
         ARWZ6Ujm4/3Na+MVjKlrN2EA5wBDgohClwHhd6zinjlwID3nn+n8s0anr9N9MVKWG0Wt
         bk4A==
X-Gm-Message-State: AOJu0YydffV330THYYyL7Dm6Rg50INlbiytqNHqcc3pJFf/jR3Zx1tAu
	LscnJrYNt5WQRZDgiHIp3xPDOpzmHvXjeUic8dV8R4XsvarjiRvasQHiZOfzL9RNEw==
X-Gm-Gg: Acq92OEy+PnhWMGwBNMS/GTjmAofprq3ky7yuPnX/o6z9RP9FGTGE3TV9o2yRz5hphq
	RBxy11VM4eEF8RvGVZ7PY2UfLP6ulBU5ttD/0ivSKRdB0ox47t3O5Lv2FtPSe+NrVONAPUS1MLO
	1TmGKxFZrMWg/aJ0wo8DxXTHdzrgY0wuw1gD1BlhzidXqCGHiBER4275yau4/6aQBfnNpzM/9Om
	/nZ0183J+KVCzVEY6D6f1NsqhkpHz5Umrli/OhVtIJFl0hzp/ytg5FZCXw5HQVyhGyAVsxOvF0G
	PmfVwcSMo0YQleGNvYI6uZV/waPPyHFEOQXigD14kOeNDJ2D8FzGDFWaUOVqA5LALKFYPj5ArSS
	UDZ222wOmkJTgnR7Ky9S1RXC7PXqmzqd3mWbJCltbqYr5+JYHaLJx6pomkgpJEKqfrgbhv50vba
	bcDF2qDHT0AljHzkYEVt797ARwEtUw+b/3tdBCDksV9Z1X2K2xlBMAQZPx1ROmmhhcCMgA
X-Received: by 2002:a17:903:2a8f:b0:2bd:6727:d689 with SMTP id d9443c01a7336-2bf20bc476amr580475ad.12.1780011034865;
        Thu, 28 May 2026 16:30:34 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf216425b9sm1617985ad.1.2026.05.28.16.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 16:30:33 -0700 (PDT)
Date: Thu, 28 May 2026 23:30:28 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 08/11] iommu/arm-smmu-v3: Implement pm_runtime &
 system sleep ops
Message-ID: <ahjQFDvCYdCmV8Lr@google.com>
References: <20260527221407.1756491-1-praan@google.com>
 <20260527221407.1756491-9-praan@google.com>
 <ahiaApzK1/nBwr2R@Asurada-Nvidia>
 <ahix0vUm03lxDwAC@google.com>
 <ahi+HFgBDYmByAtb@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahi+HFgBDYmByAtb@Asurada-Nvidia>

On Thu, May 28, 2026 at 03:13:48PM -0700, Nicolin Chen wrote:
> On Thu, May 28, 2026 at 09:21:22PM +0000, Pranjal Shrivastava wrote:
> > On Thu, May 28, 2026 at 12:39:46PM -0700, Nicolin Chen wrote:
> > > On Wed, May 27, 2026 at 10:14:04PM +0000, Pranjal Shrivastava wrote:
> > > > @@ -789,7 +822,8 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
> > > >  		/* b. Stop gathering work by clearing the owned flag */
> > > >  		prod = atomic_fetch_andnot_relaxed(CMDQ_PROD_OWNED_FLAG,
> > > >  						   &cmdq->q.llq.atomic.prod);
> > > > -		prod &= ~CMDQ_PROD_OWNED_FLAG;
> > > > +		/* Strip all metadata flags */
> > > > +		prod &= CMDQ_PROD_IDX_MASK;
> > > 
> > > Should its prior atomic_fetch_andnot_relaxed() call do something
> > > about the CMDQ_PROD_STOP_FLAG as well?
> > 
> > Umm.. No, the atomic_fetch_andnot_relaxed() call must leave the STOP_FLAG.
> > This block is the owner-publish phase, which occurs *after* the Point of
> > Commitment. If a submission successfully reserved its indices before the
> > gate closed, it shall be allowed to finish.
> > 
> > If the owner thread cleared the STOP_FLAG here in the global memory, it
> > would prematurely re-open the gate, allowing new racing submissions to 
> > leak in during the suspend sequence. 
> > 
> > The algorithm works mainly because the RPM callbacks are the only ones
> > that are allowed to manipulate this flag.
> 
> That reads plausible to me. It would be nicer to leave a brief note
> inline.

Ack.

> 
> > > Should it handle a secondary_cmdq?
> > 
> > No, I don't think we need to check secondary queues here. The STOP_FLAG
> > being set on the primary CMDQ during the suspend should suffice to 
> > indicate the entire SMMU's power state. That's why the function takes in
> > the smmu ptr and not the cmdq.
> 
> But if we don't set STOP flag to the secondary_cmdq, wouldn't the
> drain() timeout on the secondary_cmdq that does not elide?

I believe you're right..

I was banking on the fact that the ellision would work based on the
primary queue alone as we check the call-sites *before* the cmdq is
chosen. However, I see the need for setting the STOP_FLAG to secondary
CMDQs too (especially when we remove the check from the call-sites).

I'll add setting the FLAG on secondary queues too!

Thanks,
Praan
