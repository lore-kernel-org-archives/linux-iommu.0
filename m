Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541563D3CE4
	for <iommu@lists.linux.dev>; Wed,  5 Aug 2026 17:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785952395; cv=none; b=GXaZYbq1d4THZU3SxmtRHeAzM56HvOhjrjvzeEzD5/aL/iv15JGhephpqOUGnIRFo7pMrWU4hW3vSaux1QbQ5/jVOdAkY+JOG/fTIOs8Lt0hvWImemq9P1t+e3RQ8qu0AMpoSeo12nK13s+rR2Tq3amc+cUKrJV60uUSxXaC4IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785952395; c=relaxed/simple;
	bh=Eef5ElAhvjwYsNQZNCKEkPD1dzKCVhwpMG9f/2c0aao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u0sowFpg+dnS0ICOfD8NjGDGLrFItt9hJzwdmu3+9K5Ip+oBfBBIHfwofyf4pB/NxX4JmQTWiNX0haHUrRxrLxjqMXjUbmdFn3piHQftijpmtNjwIIQcOUfuCsOCA8AtYw31itfTNQCnIy9b5H4SWMqcxRCOv8k3ry7LOoVfkYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ZGMtw73m; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ZGMtw73m"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-92e7632b193so91261385a.2
        for <iommu@lists.linux.dev>; Wed, 05 Aug 2026 10:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1785952390; x=1786557190; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BYujsHKY9Yi0o12oj2KV+6lI8WRPwZwwfuqCSMDtZ80=;
        b=ZGMtw73mGCJYQoJcbb7z8IRUp/jjm94fTkRdphPdyz7GYny3JIkQa7BzBlw3B4Nb0Z
         4LcQvMcLCWNbrpDpUOCu1yqAs37F3Frsbw1uKqBgp+wSvBtdk7UlWTruuGFEOPFp0LpR
         b/EFDWEa0p3ChqK26/fAY1lGJGzH3uouQwSopCIjP3wDZcB8TaXqsS3d7ljT7nR2hm+0
         mZID3rL3yvrYuMSptjzogljmAqy0buDz1wJ/rof5xf9Akf6qKGpR7pbUSwlpcI8rbHzB
         DKbY6UVKYcxOHumsbKDVa8fg2q8iwzRLCn56OYJkDiRR231YJbV8wVq6lOa7lfzO1EiI
         QRFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785952390; x=1786557190;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BYujsHKY9Yi0o12oj2KV+6lI8WRPwZwwfuqCSMDtZ80=;
        b=FBQyK3czkxlLvRuZ22eWNUlg/R0pHh4pcV77PxOY+0x5uvfVLjdOdeOS+5yhFiBXUO
         yosWirXBi1tvM2qECg3AXmFNEIH1Rk/ixn+1VTXwfN8RGBJN/LTo4B5h7TpDc8ZpESJS
         9SzdBRokdEoEVrc+vyW0GzOOfla+JS1UijMuuib0ynIVGss3De+XdWtQiCQGuPuJSc/O
         pix7IljFh1AOzOPrPi4/gdJl34QJZ5KUCePakq1ph/vspRertnwBCthrlA7Zxr8xBpPb
         2Rn3pN3Ar3LysXTvVmdtK17W+HbD8rlU/OgZv3PtD676UyIkymRVrI8gpE82vPAmDl8L
         CxUQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqy/X0a8tjgtWZhBshktEsueFoZNpM3TbBMfK4bwKhvd68EkqxLCckzvq3m4rUaAcYCBUOBUA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwZS8Vp7tD0ELj+VYxUXSMJ6SVWz/ot1+J3WdiqnY9eWtWu2QIb
	VZxtSmC1g2iYwWuA6qRm3k+UpDqDiKlLbls1JK2YoVpbdx3wGqujLjAIKFqBs/NSVWI=
X-Gm-Gg: AR+sD106SKpAY8bavWRxKo2V7NSz3xbvniEqXF57LNAOl242nrzgljja9Krq6KDqYc8
	YJ+e4hCx0wV8MqS/Eq/3j6IVODELW0x7Z2VPVCg5oQ9f0aJA0vTMi5HIIZbLI6CxefcOeq8k6ye
	pHjz8CEAaGm+0rWBJXtMK/J67qGGb8vfY+y6GNvz4PHgVbdqnbhEez/wvCOjcEGeR9l3HxfVYj/
	T2YNcIMDk2Z/vQ9k9aZz7qpQBey5Oi3oAGJTgRjGWY32R79N/5RiRSsv/qzOiH2/yv0e5XKBTpy
	rpcMb+x4VfwY9/Qn+pucC9hCv/wzYgO40D9u3g1Nmy06Q60x7AL5irlWtb9WXtpigZmQOV5Gaub
	CuB4aJEM1KOJsmK5rhcH0ZQMoJmelX48Bgq1yLBw8P1h59ELbIrAKts8+AhNYzCpNB0xfn0y/hq
	h8s6Bt1pYbiQr730CKrnRQmIGHvjOKMVqBjo4/3g==
X-Received: by 2002:a05:620a:40c7:b0:930:cb79:ee65 with SMTP id af79cd13be357-936492066fdmr788993985a.30.1785952390204;
        Wed, 05 Aug 2026 10:53:10 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9364a42a461sm201000685a.12.2026.08.05.10.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 10:53:09 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wrfng-00000000ITS-3vYK;
	Wed, 05 Aug 2026 14:53:08 -0300
Date: Wed, 5 Aug 2026 14:53:08 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "Hegde, Vasant" <Vasant.Hegde@amd.com>,
	"Limonciello, Mario" <Mario.Limonciello@amd.com>,
	"Kuehling, Felix" <Felix.Kuehling@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"Longia, Amandeep Kaur" <AmandeepKaur.Longia@amd.com>
Subject: Re: [PATCH 2/2] iommu/amd: Force identity mode for selected GPUs only
Message-ID: <20260805175308.GD28508@ziepe.ca>
References: <a2f38742-c8a1-4dd5-9fcb-120c1c989203@amd.com>
 <ed296c0d-246f-492b-970b-49c45e25f5f6@amd.com>
 <f4355034-d40a-4d11-ab98-eef0f2991f33@amd.com>
 <838281e9-8ee7-433a-b06c-68675e9b285f@amd.com>
 <2f400c7f-eada-45e3-9079-7b5727ecb5c3@amd.com>
 <bacdf160-8ab2-4bd6-aa9d-ab63b16527fa@amd.com>
 <08f2e48e-6e98-4fde-af71-cb8cde666bdf@amd.com>
 <20260805010706.GC28508@ziepe.ca>
 <39ce2a2f-3bb8-43e7-9446-a67551cce104@amd.com>
 <BN9PR12MB5146934D584CF0A2A9DD8CFCF7D32@BN9PR12MB5146.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR12MB5146934D584CF0A2A9DD8CFCF7D32@BN9PR12MB5146.namprd12.prod.outlook.com>

On Wed, Aug 05, 2026 at 05:22:22PM +0000, Deucher, Alexander wrote:

> IIRC, they supported SME, but it wasn't usable due to other
> limitations (e.g., the requirement for identity mappings due to the
> display hw bug and the latency impact of encryption for displays in
> system memory).  Do you could effectively pick either SME or
> displays.

IMHO the GPU driver should fail if it cannot work because it can't
reach the IOVA space requried for SME ...

I don't think this should be a iommu problem to deal with

Jason
