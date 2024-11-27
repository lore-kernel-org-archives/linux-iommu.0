Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6E62500D5
	for <iommu@lists.linux.dev>; Wed, 27 Nov 2024 10:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732702604; cv=none; b=dUUUFIv9lpVyguf5Yu+F0gFLZG+anQWDLE9B4MOd+8qUOMqgMTK4X+FCqPUafaXzPhvbAaJaHwRuOEad4vKXt1Y1BXVfFwDXxH873sKYl/Q2kD0tdPfOIgFYDhEh8mNmo9Dwi3jVgX15mYY/KxSN9CynWJkIy7NEBfI5QCWPcKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732702604; c=relaxed/simple;
	bh=VkRNeM2/5fIWf81N1V6VE+yQWrnwJGOLqMu1b90ApgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IzAXEmF4zonvzTXP+pmRANRVFpzm8zoHLCpaYiU9vxnuBxfmM+cnCbOz6mtclCp2LdhPS7siMiqS1k8zFML0jax9pm9c71RPr93EnxtwfgorPuribNW6HCXd2V1echpAq4DpEVW2w2OgCzkusiBk2RgnidkmjyhY1jl4lnlwQ2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tFwFrs2r; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tFwFrs2r"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-211eb2be4a8so109635ad.1
        for <iommu@lists.linux.dev>; Wed, 27 Nov 2024 02:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732702603; x=1733307403; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uFMozoNHEhYdNzuNw57AvT2mQLmh971ujCBeS9mClJU=;
        b=tFwFrs2rZS6N/qAj38I3AHSJkZPYn+Pvl8RupXoG2NCQKmzDp6j1CbwkX5yvfH3Mk5
         PqtFYEZD2aQ8Qb3ykqth6yhOkTr3nnBet90I4p21cBlr9Jnq7frd/+kj10Ge4JzcG9HU
         JmBkc4N+qRAI3Z8nuFxj+VnRuevEeJDpDYRt/Xq1GFJsSNxIti3seK6wVXRvi3+GiAvP
         Aa8r4oVxv7NX+8kzlRLVl8VWoS0SDzAvqBWz2tZhTacpao6H0a3amxNasRQihIdX3vNK
         MUoqcmSaahD3MhZlbJQxLY7pjc1JSEQYfIiwl5kdGMwuR2sGl/XtMFg3REp324aC2/3x
         6hFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732702603; x=1733307403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFMozoNHEhYdNzuNw57AvT2mQLmh971ujCBeS9mClJU=;
        b=b2JlOsH9+5vI8lrXQbGlHXSJP59fbiEEs4RCfil5uLLSeTUoGIoHMJkwNa2jlSBSil
         kYAr+VjMW7UIfDFX/BRIXSRqso4U8384xyJ8mBAXqt/cVjsPnAj+Ql1ArlUD8DBV2JrY
         fr40WwWmsPHVvR2O6sU8Kk4CqWfDzLK0aP+GdSyj2DXZzrySB7RoIYZzjaL51DPz5H7u
         K1bOhInl0AUdRN6S8yg542hdZktkLSD1fSKmRYmgaybcChxVMyhMBBG9vvnf+p26Wf/c
         BEbNG5uUOsrAjBEPzoMKqjn0XTLJLj7wzs4EZn6wyM6V/wYpbWjOgbJ0zA+yt/WB04Y3
         hBFA==
X-Forwarded-Encrypted: i=1; AJvYcCULoJEoLPJ7v4IkAzou6d3LLvwv24tF2HvKnwvUT3+qBPSAPyK7QonWP15/SNGJdwPuBquWBg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxyn5VsXqr3xSZOgX9zhPOlEeR38OjLmOeZ35dYpE0dOse5Cz3a
	aKyWormgoq+gGfVa7rFdQ69I39pob5KasZpsh8A4BR2jEoq/KeZTsZPXHE4ARg==
X-Gm-Gg: ASbGncvI6cFBHfAl/HQ+oNi0IMU9wK8kv27XwuXBERNXHWa6UOnWnILA0wWmLZfLO1A
	n5H5mBpZloQktJmGkiCtF0+iNVCFtWBrokI9d6uGolH80j6qqTMZd3QyVX4OaPuLq+Pz0AIUudA
	5xt8/1JbDsBO7aQmePPryX6nziHJPSGKiEjzB3UPw7lXXZ6VZFwKZPTbEHx0XZYA+mXFQOa4RBC
	gCL/9Annx/o4RNIyJyn8GKsK9vQUahj9G+qARUv3+ixfVeoq0gJR91i41uNjADwXgsHRgpWUD9p
	6o0o/yXO5kg=
X-Google-Smtp-Source: AGHT+IHsPshmxQeK/tKtkwSbkgtQZ1kYlWSJdBx5dui+MBMNYn3LhkRQukaQ1ABLvX0ccyx9S4FHWA==
X-Received: by 2002:a17:903:1450:b0:206:ae0b:bfcb with SMTP id d9443c01a7336-21502319e57mr1857955ad.28.1732702602617;
        Wed, 27 Nov 2024 02:16:42 -0800 (PST)
Received: from google.com (104.132.143.34.bc.googleusercontent.com. [34.143.132.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dba2e9csm99683855ad.93.2024.11.27.02.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 02:16:42 -0800 (PST)
Date: Wed, 27 Nov 2024 10:16:35 +0000
From: Pranjal Shrivastava <praan@google.com>
To: "Li,Rongqing" <lirongqing@baidu.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: =?utf-8?B?562U5aSNOiBb5aSW6YOo6YKu5Lu2?=
 =?utf-8?B?XSBSZTogW1BBVENI?= =?utf-8?Q?=5D?= iommu: Downgrade print level
 for iommu group information
Message-ID: <Z0bxg0P9AtSHW82A@google.com>
References: <20241126072339.25714-1-lirongqing@baidu.com>
 <84cb9155-4793-45f9-bb67-6926e103dc84@arm.com>
 <e790f039210f4bd78a015a6fa439c607@baidu.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e790f039210f4bd78a015a6fa439c607@baidu.com>

On Tue, Nov 26, 2024 at 12:09:03PM +0000, Li,Rongqing wrote:
> 
> > On 26/11/2024 7:23 am, Li RongQing wrote:
> > > This per device log is becoming longer with more and more PCI devices
> > > in system, which slows down the boot process due to the serializing
> > > nature of printk().
> > >
> > > Downgrade dev_info() to dev_dbg() so it is still accessible for debug
> > > purposes.
> > 
> > Previously discussed 4 and a half years ago:
> > 
> > https://lore.kernel.org/linux-iommu/20200302154426.GC6540@8bytes.org/
> > 

Hmm.. I'm wondering if ratelimiting might help here? 
We can define a rate_limit for the iommu subsystem that can be tuned
accordingly to control verbosity. We can keep the rate_limit to a min.
as we'd like and maintain it upstream and give users an option to tune
it as per their requirement.

> > Also, given that the iommu_probe_device() path is inherently serialised anyway,
> > if logging a message from there significantly slows down your boot process, how
> > slow is your console device?
> > 
> 
> 
> There are 482 in my machine, spends nearly about 3 seconds
> 
> [   40.083614] DMAR: dmar1: Using Queued invalidation
> [   40.089008] DMAR: dmar0: Using Queued invalidation
> [   40.094402] DMAR: dmar19: Using Queued invalidation
> [   40.100816] pci 0000:79:00.4: Adding to iommu group 0
> [   40.106586] pci 0000:79:01.0: Adding to iommu group 1
> [   40.112346] pci 0000:79:02.0: Adding to iommu group 2
> [   40.118315] pci 0000:74:00.4: Adding to iommu group 3
> [   40.124074] pci 0000:74:01.0: Adding to iommu group 4
> [   40.129830] pci 0000:74:02.0: Adding to iommu group 5
------------------------------->8-----------------------------
			snip
------------------------------->8-----------------------------
> [   43.140538] pci 0000:ff:1e.6: Adding to iommu group 482
> [   43.146522] pci 0000:ff:1e.7: Adding to iommu group 482
> [   43.153222] DMAR: Intel(R) Virtualization Technology for Directed I/O
> [   43.160471] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
> [   43.167715] software IO TLB: mapped [mem 0x000000006123e000-0x000000006523e000] (64MB)
> [   43.178633] RAPL PMU: API unit is 2^-32 Joules, 3 fixed counters, 655360 ms ovfl timer
> [   43.187540] RAPL PMU: hw unit of domain package 2^-14 Joules
> [   43.193906] RAPL PMU: hw unit of domain dram 2^-14 Joules
> [   43.199984] RAPL PMU: hw unit of domain psys 2^-0 Joules
> 

Thanks,
Praan
