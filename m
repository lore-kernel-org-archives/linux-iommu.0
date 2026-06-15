Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2DB1B4F09
	for <iommu@lists.linux.dev>; Mon, 15 Jun 2026 12:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781527981; cv=none; b=a/ypeoNmH8awhdl1XILO8UTogbiPeXEEU/xIWSBDYmPj+i8nnHOi2nbXSqB0heJ2nWc7MW+m1pJjvqK76uip6KFIAf1jP6JieghJ+0EAtSRpzqDmPmwpoVOrKOvlsTYRN59rCOXcxed0z1W/p9XhYdBvWLqv+gWBOl8sGapUM20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781527981; c=relaxed/simple;
	bh=s96ccR8Om1I0iIAfjhwlWNvcJJx/1nhwDO14q6/sSI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b3MgyC+LDL623szXaXiL3Suka6lalA6RDT/ii+wQ2wnJxoB9xvQS5yTwpF+I58JXU47HI/ccDbyya1i5aKY/qRuw+FGFKTdPNwLKN6XONUzmys7k0pFLHi172DYl+gZV0ZL00GkWve3zr8nBQ1tibGv6BNTO3ipmFAzHpT+yCoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ik6v283B; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ik6v283B"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-517583cb07aso38219651cf.2
        for <iommu@lists.linux.dev>; Mon, 15 Jun 2026 05:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781527979; x=1782132779; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/U++F8LMHjutudC/6qjVGvOhdK/NsDBOF4e5HFz5STo=;
        b=ik6v283BIQDUWJv59L8hCfP8at+dxoSOZKb1AP4NOyJWuXlycofc1vpaK3ReL7Ol9I
         TpfSC21UKGY4zJOkU4myG8750NY0eiggK5xoyHEEFNp3k4Ym9FjXSpd6cQ/wUGMTT2dC
         dRGsJvnniEFSYnKhThyb2q+2nUOErIJ3Ut1iWasz7+rZmfWR6QA1pUGRX0NylVbv2WsT
         EVU79GmzDncnjSOGPCkh7YBiynmoPQDLfkl9QL8aqw5APivIUeKxp5/RffB2UntQ9dDh
         2MhlPvQdOO3GfUCaAh7fbxjFZeoYWBLgNZWR2cZ1KWSbh291lYsJjbf1UaErCre7HkCe
         6D9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781527979; x=1782132779;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/U++F8LMHjutudC/6qjVGvOhdK/NsDBOF4e5HFz5STo=;
        b=NmW0hx8bDF4FhU9/VP+ce7eba5h0YoftFCO5KAyxEh/IfKbJ0fRQmd58zRvqrOfkhN
         cBBPClpF42hT73+SV+hWXtUgrtqFYJLMvahTSscF7W+B5yxpNF3WHfrfUkrJ9G8veomu
         6T8D4Egq6zE8pKeXZ2ZyH4o7se3QP/QqvgRZjs7TfLEt1H3840zXGFxS34JhWct4sQWy
         7TvXJzqTzNS3R0M/WXIti0oyRlHUNmW9bleDe2+0/30I0V9Ze7UXWHY7sqp4+rb61ePa
         i5QbFsQynToBal5HYWFy55sNvmpuoAgt2MHFhB6gNEqHYKed97ZThmGlZ2o5Do989k1E
         vGKA==
X-Forwarded-Encrypted: i=1; AFNElJ+EIUPEnMbgz+x9Z5qX/fEeHwm0Fkn5/xv2iO4ntF+KgHLmBRnU5dP1ZgrunBWk6Fv3HrS8sA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw4FHRiuAvc/Y98IE4wBhUwmG1bgA0VF77dvEULYjNBcbVsw9bd
	qqH1zPw9iB96UXm4O6hiO7XNP+GXYiEgqk4WEumLLV/0VYWL+vtclZhjAs/LFayQ4sjJOOEaqhW
	QLe4g
X-Gm-Gg: Acq92OHK3VHQ/4eDsUPEHAYxwTDmktexRoUd70CCH6HCpyJGG64KO/WgyQSNs7gRaPV
	z60kfcU7Q/czcWR810CJqds7UeKHvkMuUrdA3ESdQQnikbft8MpJCB1ZqFHiUyvrW2IJoGT1/4m
	WKL/1H0SR/CmCQI7QsCwcHABSAgbVIijl0X6LIZDqOu/n6BREbpIs4YeigTuvs138GL0sVHU9Cz
	Y2pkkisUOXVHO0Qber2zbs7aW0Hj+ECbsU6+G9m/OZN7lYddYHhDLeUqitdF7Td8xVLARSxAxo6
	zaACITXxF0R6Xzq5sqlxMDiET0h4711l/gOhgVbENtkOuW1hgN2DNEnJeWm8CwrPuz+ta2Eg3Qp
	RKhTlV+h0sZkhM9u4nvHftkYN3FGAlsWrOHnS+YlLu/SG7u2429kvGs6mbrmzhP6rpmO3l02nlC
	CXawfy57xLB5aM0s79myeGnD5x7l+6ROtljiK+0pfri3UQh6COXWXJFimLVDjNYdO7AGuadx/0I
	CfaQQ==
X-Received: by 2002:ac8:58d0:0:b0:517:87c4:2a95 with SMTP id d75a77b69052e-519534dbb14mr172028331cf.5.1781527979043;
        Mon, 15 Jun 2026 05:52:59 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb61d948sm103230391cf.1.2026.06.15.05.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 05:52:58 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wZ6oD-0000000DQjI-3VJy;
	Mon, 15 Jun 2026 09:52:57 -0300
Date: Mon, 15 Jun 2026 09:52:57 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
	Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
	will@kernel.org, m.szyprowski@samsung.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, dikshita.agarwal@oss.qualcomm.com
Subject: Re: [PATCH] dma-iommu: Introduce API to reserve IOVA regions for
 dynamically created devices
Message-ID: <20260615125257.GS1066031@ziepe.ca>
References: <20260119054936.3350128-1-busanna.reddy@oss.qualcomm.com>
 <cfd23f75-8952-4463-abd5-815b995031b0@arm.com>
 <bb59f07e-ca7e-f012-6a4b-0a148350b69c@oss.qualcomm.com>
 <20260612172649.GM1066031@ziepe.ca>
 <da77c21d-25b3-46c3-a48f-71f0549e9f5f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da77c21d-25b3-46c3-a48f-71f0549e9f5f@oss.qualcomm.com>

On Mon, Jun 15, 2026 at 12:26:25PM +0530, Vikash Garodia wrote:

> To handle such case, we create the device dynamically and associated the
> distinct IOVA range to them,via the api introduced in this patch.
> This was prototyped in recent SOC here [1]
> 
> [1] https://lore.kernel.org/linux-media/20260313-kaanapali-iris-v3-1-9c0d1a67af4b@oss.qualcomm.com/

Well, I'm not enthused by this:

+static int iris_vpu_bus_dma_configure(struct device *dev)
+{
+       struct iris_context_bank *cb = dev_get_drvdata(dev);
+
+       if (!cb)
+               return -ENODEV;
+
+       return of_dma_configure_id(dev, dev->parent->of_node, true, &cb->f_id);
+}

A custom bus and then calling configure_id on the parent which would
have already called of_dma_configure on that same of_node seems very
hacky to me.

Jason
