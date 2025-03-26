Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFED14F90
	for <iommu@lists.linux.dev>; Wed, 26 Mar 2025 20:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743019824; cv=none; b=dFYldSI3mQ4xqgZgKUT/vzO7ngCKpUr9/nuWHIXfKIlTUAQQBCsrN2GD2lnIE92xhvXAzKBRn8q9jVH2Qfs2Zq4k/X7h9nAmhU1L3Q0Flo51ePRdYpmmbu/mV4qcilx3qNhjABd+L3IdQ0j6NU6HCUYTSFe3b4uIS42fEa4I6As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743019824; c=relaxed/simple;
	bh=Z+n+uMvnD+Eg8piuYA01NpQE5O+AE7zMMMk4Ug5oyY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ShjtEGrJw7WmMICS/Ov37IA0CRkbuSBx69qftqLq90SAyZs1OsJus2+MqZAmBt6Bxm4bUOgwgzgXIfAoJMnPp1Lmtpcia4ZIQ1EroqSImJGGgNsPEMbUDEGAbNy09v4tO4k5X4E4DCqBushpMmcMFWybqdfTWuEteyMPx1R+QqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D3s+nyBZ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D3s+nyBZ"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2263428c8baso12245ad.1
        for <iommu@lists.linux.dev>; Wed, 26 Mar 2025 13:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743019822; x=1743624622; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gwWGZcmfAr/pg3J6mKmzPku5Udi4+ChJY6I15fQMwg4=;
        b=D3s+nyBZY7QXWhJRJ4C5lFm5Mj9PCWrTcKBN0WBl5n2/yMupL7QMgvdfR+bn7qDk8r
         Dzrcnt5X7nFskmyOhEP2GG/x7YJs9JVYQH/RLwxj2loIGhPipJ/XRoNA2j/fTeILnlNE
         UO9ANCXaSjHmc7SweKe4n/BkVi4y/sqddeFONpept02UI8ni1Z5sQd808ZM20z/lMYuA
         GuYIIpvieB/feqhJyGJIjvrVYkCwIA7tKysNS4m62zhJjoRs0LeV4gYdpis4ZrHuBrFj
         efjXZuoX2nyN6FUP5fJsujQeltt9l235IVnwBoL4NPeG2BVzRmeTSZASXXca8Yq0aY7w
         AdNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743019822; x=1743624622;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gwWGZcmfAr/pg3J6mKmzPku5Udi4+ChJY6I15fQMwg4=;
        b=eLqGVq3E7KtH4QeKubo94U94Bov2U927cHAhcm7jZ0JUpDedXn0Wk9KdSAsjSezKPK
         8rQGBsbv5EUMmxExEafUx0iSTqe2koVM9eOslZVVnPRVB9YWuJv9rhchOniDm3Vjaxba
         b0a0RGNttHyTou1SFAUOo3JGkT6R2o7CYiXSt+0fWv4AcOzvp4xrGI3EnAfJ3GIwLhHO
         DyiTOqXTiePp/wUNWnoepSj7gSZInKhTU4LSmrKxTu7Q4zVQ0e+aQon4W6vUlUTJ2j9Y
         G+hbneps/esi6OQmJHsyepr+ovgwROy3dB/v+2BIs3Ptb4WO10oUqQ/a+EtGb78q5i+f
         Xunw==
X-Forwarded-Encrypted: i=1; AJvYcCUxJ00Rpfw0IZvF6oQh8TJx/xicDnCI8XFfTOx7pIOCu0Va0L0umNp2RiNyT29BYdXegwCjgQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzdBsSCZ6eS060jL8NxOMoRsK4TruOikkPlsp7PmFe4t9HZ9pve
	RSrYCw7JGLiHnxUbIlPoRTD9b5Ke4Cx7Q8ofodxOQbRht403QDMgfO7y8PBm+w==
X-Gm-Gg: ASbGncs7QKByVygXVzVyPFGhAvjUXy+G3M8e6r40LGRSbxDIy/Uj1mD7KSYk6YNDLtd
	IhcMFOCwWFjDAbSdj8VHy0Co8zafJ8X/KluOF/RUxUIfRptLmo0nHF63Qf/IGlDT9HG8JOGC84o
	LBlNypUxvcZ2tts8p2dnhvOga4yZZABjucnHskaEL9CxWZTVETzdGniWeVymYzto/nFbtkZHqQI
	HREwP6ytJAPKfBhRodKcUMlaPC8iGMMFTEQR4rLrgCGMpYZfFLnt+FSkgcboUMYTJcwn7Jtlm4Q
	hJ7rfXFxa4jd/0PutzdAUpIXXHaJblXecqX8w0eXlEVVj/D4axaGJ7fiAJWkxMCaqS8Y4ZBOkzQ
	awy4=
X-Google-Smtp-Source: AGHT+IGAIgjOJBg98VEZEhpU9JfzHYu6Ov4sG8pUpqtEe4iEhD8UDoLf5qtB0pK09dONSMAfcIscqQ==
X-Received: by 2002:a17:902:e88f:b0:216:201e:1b63 with SMTP id d9443c01a7336-22806f64c35mr55535ad.11.1743019821463;
        Wed, 26 Mar 2025 13:10:21 -0700 (PDT)
Received: from google.com (188.152.87.34.bc.googleusercontent.com. [34.87.152.188])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390600a501sm12667023b3a.79.2025.03.26.13.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 13:10:20 -0700 (PDT)
Date: Wed, 26 Mar 2025 20:10:13 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Daniel Mentz <danielmentz@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 2/5] iommu/arm-smmu-v3: Add a helper to wait till
 cmdq drains
Message-ID: <Z-RfJd0gLxEA9CTr@google.com>
References: <20250319004254.2547950-1-praan@google.com>
 <20250319004254.2547950-3-praan@google.com>
 <CAE2F3rAnRa0zCBrPv6THUQ6mMbjoPf5xZWejPnXNBhq_oKADdw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2F3rAnRa0zCBrPv6THUQ6mMbjoPf5xZWejPnXNBhq_oKADdw@mail.gmail.com>

On Tue, Mar 25, 2025 at 09:51:52PM -0700, Daniel Mentz wrote:
> On Tue, Mar 18, 2025 at 5:43 PM Pranjal Shrivastava <praan@google.com> wrote:
> > +/*
> > + * Wait until the SMMU cmdq is empty
> > + * Must be called with the cmdq lock held in some capacity.
> > + */
> > +static int arm_smmu_cmdq_poll_until_empty(struct arm_smmu_device *smmu,
> > +                                         struct arm_smmu_cmdq *cmdq,
> > +                                         struct arm_smmu_ll_queue *llq)
> > +{
> > +       struct arm_smmu_queue_poll qp;
> > +       int ret = 0;
> > +
> > +       queue_poll_init(smmu, &qp);
> > +       llq->val = READ_ONCE(cmdq->q.llq.val);
> 
> In a later patch, I believe you're calling this function with llq
> pointing to cmdq->q.llq in which case this assignment would be
> redundant.
> 

Ack. Will fix it.

> As an alternative approach, I'm wondering if you can reuse the
> function __arm_smmu_cmdq_poll_until_consumed. Just take the current
> producer index and wait for it to get consumed.
>

Actually, that could cause some trouble because the function,
__arm_smmu_cmdq_poll_until_consumed, waits till the cons __crosses__ the
prod by relying on `queue_consumed`. This could cause trouble as, when
the queue is empty, the cons won't cross prod and hence we'll keep
waiting in suspend... 

Instead, the `arm_smmu_cmdq_poll_until_empty` relies on `queue_empty` to
confirm that the queue has been drained before suspending..

>
> 
> > +       do {
> > +               if (queue_empty(llq))
> > +                       break;
> > +
> > +               ret = queue_poll(&qp);
> > +               llq->cons = readl(cmdq->q.cons_reg);
> > +       } while (!ret);
> > +
> > +       return ret;
> > +}
> > +
> >  static void arm_smmu_cmdq_write_entries(struct arm_smmu_cmdq *cmdq, u64 *cmds,
> >                                         u32 prod, int n)
> >  {
> > --
> > 2.49.0.rc1.451.g8f38331e32-goog
> >

Thanks,
Praan
