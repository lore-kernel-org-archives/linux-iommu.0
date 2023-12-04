Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCB424B41
	for <iommu@lists.linux.dev>; Mon,  4 Dec 2023 13:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BnHuMh9H"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-77dcf6330f3so172895285a.0
        for <iommu@lists.linux.dev>; Mon, 04 Dec 2023 05:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701696454; x=1702301254; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D9LwUnJIABIYXynmRpnw8pFA/pix8HVAwnnjKzJe6go=;
        b=BnHuMh9HW97WhlkcT/VCFs1ZUX5TthVtVHbL8nVy1PyZQC8V+gtfazyv5dGCoUuGwZ
         XUj+xAUMwYfEWXygYBeXI6uO8GrXpTilFNPRHGdU/4ljDkinVoTsOSqTus+bTQPAUHWU
         QX3kL7SAQP1tneW1TMb08+KmdPiTtm6yy7pD5wrktm0kR/Nj6FvOfstxIlgLs2OacYgb
         Ppu2YTuL3W9BwRtmx0vgaEUxmcxIz4dv+g4sjPR+dsDPCum9IJfuL+kcE6ycybyEgix/
         Wj8XYJpqOI3i6qt8Dpee/w8CPCbTkd9p9iAUMjcMS2BZFllt5UmvX2wCH6YEzMg/YiJH
         yynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701696454; x=1702301254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D9LwUnJIABIYXynmRpnw8pFA/pix8HVAwnnjKzJe6go=;
        b=gEYTN8v7QIQEOy0iy8Qg9ae2Fa8BfSsAiBO5TKSY+n+SL/kXPh9Xa4f44Akpz5DAsI
         x1tIesq9ecgjyP/v22dwci137z+Guulovyl/ZxT7UM23WIi+qE9n35LDbd6cYWFkY1z4
         nL0r/+brv91jGpwupi3Bh9F+uctnTfLOOLR+wT6HSYWaV4OuSWxkG7dowfdKHvIGIc2y
         tMkwTXGI0RuwtqzZWc2l5WwA3zYRCmBmqNo7eVXAz6g/hL7FhXjiuKAMh09+5KeCjOrP
         XXLXKR0jKyi2oV+r07o46yRG1MXBtQcqYu5ik6e0NafDPeyaBn7CKJag3QUPuj4cScLr
         KC8A==
X-Gm-Message-State: AOJu0Ywjd5vUBwufPbFIOpdUFLiXyK/zBczZDOYREKHdCz4tij5B1Ihq
	7lAxCC6fNPJEGJv5HFrg+JDrAg==
X-Google-Smtp-Source: AGHT+IFwJd+mm5yr9E/Hib/UfERIuq8yXaFwHF06npvbzKqM7QtB126feDLE1ZVHpqSCvPB5b1ED4w==
X-Received: by 2002:a05:620a:1913:b0:77e:fba3:a787 with SMTP id bj19-20020a05620a191300b0077efba3a787mr2055508qkb.101.1701696454008;
        Mon, 04 Dec 2023 05:27:34 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id l15-20020ae9f00f000000b0077da8c0936asm4239213qkg.107.2023.12.04.05.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 05:27:33 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rA8yz-00AsTP-01;
	Mon, 04 Dec 2023 09:27:33 -0400
Date: Mon, 4 Dec 2023 09:27:32 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Yan Zhao <yan.y.zhao@intel.com>, iommu@lists.linux.dev,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 12/12] iommu: Improve iopf_queue_flush_dev()
Message-ID: <20231204132732.GM1489931@ziepe.ca>
References: <20231115030226.16700-1-baolu.lu@linux.intel.com>
 <20231115030226.16700-13-baolu.lu@linux.intel.com>
 <20231201203536.GG1489931@ziepe.ca>
 <93a57e63-352c-407c-ac3f-4b91c11d925d@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93a57e63-352c-407c-ac3f-4b91c11d925d@linux.intel.com>

On Mon, Dec 04, 2023 at 11:46:30AM +0800, Baolu Lu wrote:
> On 12/2/23 4:35 AM, Jason Gunthorpe wrote:

> I am wondering whether we can take patch 1/12 ~ 10/12 of this series as
> a first step, a refactoring effort to support delivering iopf to
> userspace? I will follow up with one or multiple series to add the
> optimizations.

I think that is reasonable, though I would change the earlier patch to
use RCU to obtain the fault data.

Jason
