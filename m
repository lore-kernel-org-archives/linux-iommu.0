Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1B34C85
	for <iommu@lists.linux.dev>; Mon,  5 May 2025 15:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746458100; cv=none; b=sSuiwqqmwcnChipG9Rn0qN5Mh6MQSJIoMUGj9bRBnX2ytS8MVWMy7hfu53F9ijfcnHJF1ahqX0U4r4WDvhfohq5ayO0XOIIlhGHRJrAjtdIsjnPWCKSWwFCtye19N4QNTp9roHCPjGZll5Uw8P77dgvDvbFHxhlCMLkABaqTUGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746458100; c=relaxed/simple;
	bh=HSZs8kRQuPwEeccBesmfB9vShUgkZ1JMiIWQfkwnyJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rPFYzdJHYofmghuyBVPsfis+g//YPvX8OkcnHysIeMwNvL+9PF+EPC/eUlnfo7P7cflrc5qIRKcK6JEMZCCvxvwcLkXlNh+6wxd6gI30J+utE4K9a1MAtq3XwGfQHAhl6T4ZlgrP+zGPf/dJBMr0eosrDy7cUC4L4BzeFgMQ2KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CK1hWFuB; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CK1hWFuB"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2242ac37caeso222525ad.1
        for <iommu@lists.linux.dev>; Mon, 05 May 2025 08:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746458098; x=1747062898; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fLy6SfLH9tHYtqAXS1rHIdkgA5H88KafWhLxPdGceFY=;
        b=CK1hWFuBIn6xYiRjZW9GMO6kCTiOyj8+ijStS+THjtD4WQA6V4/AQQDg7iN9Z7DO0X
         WS6uQk2bWnoU3QmrNhGosoUt6qv2RiaCAeiIDm3GDzty3pp+Pfe05nlDgcTKtWMRbtRo
         Yr7KAmvz9qpKEIMuBgFc29029YsaupLpREhHwG3zqtrMA6ikf2VVB+5Od2L5Y8TYLFFz
         jVo0UwpPRTdo+LDJa6WHpadq7vSq7WS+02pm/SvHRBN2nfl9qIW9TUcRlIHw/ymsRlT6
         stiug12/rxOQS9dXT8cSmrLOmekQxKpdw/DTkLbh/zEV2OLRTr6DO+63NDH9VX7xdSOQ
         llYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746458098; x=1747062898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fLy6SfLH9tHYtqAXS1rHIdkgA5H88KafWhLxPdGceFY=;
        b=KlbkRQ5n+EPJjkNQSBGWwAb6SyQUeH2Bl2WePVghlmPVS8s21Nj63ubZGOUS2jjxd4
         R5jH7T3ZkTfQf9UgswFEijusEEob5apwDTRoAxcxFDLjcvBq/ywVSGk+AW7d6MOOALUs
         nc9YJmof5DIfV7/8GnDQwJORNG/jLTALouC8YY1yqSPxdnGNOq3Qt2uuwMk7nG6mQeZj
         97IC59yp8IR36kziOiCmyhN3galygrPA9WNnT3BR8ATILrwgjrOSsPJxN0r4Js+3USYN
         xXFXN+8hnoCvGyCGEt8La8xV3tYmoLC9cpBqmlK8CfBmp8KoxSwE7Oe2EO3gRQjV2bf8
         MuIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLrLBehLpK/ZNT7aURu5q2w1tKJ/dzIwR2EnxP2xeMswUxcVftx6ClJm+WdHjQMW0ZfeY8JA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxCvRFy/B7qacAzQYIydXxycBoyKL71ujS/QmG64j5/3kkTh1Sm
	ndV9aWOifbV/dnRe+0dozI3kXmCIj/OQKjQ9Nxp6e8RZIEI4xDo2jlod/Ypgbw==
X-Gm-Gg: ASbGncvDe3gNZgjRNQZ4X8pbhewt59J3mXPkZQL/vG+MUaSYwpIzf3ZAtAqijWu66zG
	3+b7quBvlRlYpa+x6HwDqgbm4vMsWyUiIb5UpnxWMHoTQ7u+8QblEBiqDsb2+0upZx0uFvG67vw
	u49+vkIERzd4QI22VCAEEnSuplzvw13SWFObIyBG4HUZ8zOPQleiNba0GHv9cuIw8OiOxAZT36L
	zmc658sPTeH0Jo10q1VlI/fZwPBgmq8En2EZwihM5Q/gZVd2tmRA9nK6Zr++CGpmkU4MUnotWjZ
	jKY7L6poFi6aIdczEsqHyHuY3zaG7/Co44YzkUpME6KB16IfPFE6WSmC3r41U9djuWDtQxP7PSF
	F/URRfXU=
X-Google-Smtp-Source: AGHT+IErY+BqXQPTRt7px96HcrmwVXo1Fg7/6hSpX+4eVzMK6hLuAcEoKHGUrbLqxwTF2vc6CxxgHg==
X-Received: by 2002:a17:902:eccb:b0:22e:1858:fc25 with SMTP id d9443c01a7336-22e316fd14dmr137315ad.9.1746458098231;
        Mon, 05 May 2025 08:14:58 -0700 (PDT)
Received: from google.com (2.210.143.34.bc.googleusercontent.com. [34.143.210.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74058ded103sm6886237b3a.77.2025.05.05.08.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 08:14:57 -0700 (PDT)
Date: Mon, 5 May 2025 15:14:50 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH v2 02/10] iommu/arm-smmu-v3: Add a helper to drain
 all queues
Message-ID: <aBjV6lS1GqaRt7sf@google.com>
References: <20250418233409.3926715-1-praan@google.com>
 <20250418233409.3926715-3-praan@google.com>
 <aBUd0/NmzFmeOosd@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBUd0/NmzFmeOosd@Asurada-Nvidia>

On Fri, May 02, 2025 at 12:32:35PM -0700, Nicolin Chen wrote:
> On Fri, Apr 18, 2025 at 11:34:01PM +0000, Pranjal Shrivastava wrote:
> > +static int arm_smmu_queue_poll_until_empty(struct arm_smmu_device *smmu,
> > +					   struct arm_smmu_queue *q)
> > +{
> > +	struct arm_smmu_queue_poll qp;
> > +	struct arm_smmu_ll_queue *llq = &q->llq;
> > +	int ret = 0;
> > +
> > +	queue_poll_init(smmu, &qp);
> > +	llq->val = READ_ONCE(q->llq.val);
> 
> llq points to q->llq, but here it overwrites the value from itself?

Ack. This seems redundant, will remove.

> 
> Nicolin

Thanks
Praan
