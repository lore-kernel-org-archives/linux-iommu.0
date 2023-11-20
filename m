Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18EB12E4A
	for <iommu@lists.linux.dev>; Mon, 20 Nov 2023 14:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="LMzvLS4O"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6ce353df504so2644207a34.3
        for <iommu@lists.linux.dev>; Mon, 20 Nov 2023 06:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1700491566; x=1701096366; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hKGlpsR4MZQ4PbPAr4iKvpD/NWTg43d9w2WorVRFaEM=;
        b=LMzvLS4O1ib5P5gw30LVdXKiWIgyy7KcN1whorf1jsldu/1FOf37u+HRF0pdxNQPYw
         ZrT+1Ob9K3Pz7KuAa1JLYmvQrID/2uAr5rCSFaaIq+17VR4JIccB+3lXFd36UbhWygY2
         zLTm8fNJiXBtafbKehFxTPX/J79gi/obTOZsImq96cNj7DsDDj2h2dKcQOT7tf6Mmhog
         nmE5pRfMmTCi01VYuYNlg49XIBm8cTuZMLJgtU4ZMZgtwvNOEQch7z3RNC0dA1LSXDKp
         4pLqHUscQXys1f7gI76SMYBG+irxQBPUJu2qRnOLeaX8Ah2VL/4FwDLyBWl/v88UjYbk
         4xXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700491566; x=1701096366;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hKGlpsR4MZQ4PbPAr4iKvpD/NWTg43d9w2WorVRFaEM=;
        b=VkTPXgLAQBAA/wftAaX0XLJ/eFMeKnkefadDdAevr2M7wqcDOhcZQqsZvG3d8CatRW
         cpf+QsRUPFI9QSYcqQvtmBGtASQ2GTjmBQE2dgKnp1Obb1sWlOcJ8d6xVPNLepK5i/Vm
         JoDQo8srrRX9xx/AUJall+u1D4SlwDKOiNTZybsRxF6M1kzKYDn12vHVwX4/luArxBts
         PkUkLQIP/QzReUd7Mlr/g1dbelhe3iD9eYe0Cbj39NC3g1fyeVbXbz4Czf7jCMUL1Gqo
         k7708Oc+8/v092cjVRFz+stl+kySwR3Eag+FOu4QveI1zC5juSfaQUV4lKnYSL8+D0eF
         Km3Q==
X-Gm-Message-State: AOJu0YygH0FerWsBBQE9MiOB8Km1A0q+c+qnh5RftmVX1Ehf4vAEC8ae
	4lfOgfTJm8ZW7/AELlq7YpHiOw==
X-Google-Smtp-Source: AGHT+IFzZWviPZZa03nWXuOFzGQ0tzH2Ne9zQ6glH9lIYEu9EVAdXzYpaCSS1UB1eu0G4bKU3Pfz2A==
X-Received: by 2002:a05:6870:288a:b0:1f4:a122:6b02 with SMTP id gy10-20020a056870288a00b001f4a1226b02mr9420967oab.45.1700491566071;
        Mon, 20 Nov 2023 06:46:06 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id y1-20020a056870a34100b001f949c5a757sm220261oak.38.2023.11.20.06.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 06:46:05 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r55XI-000bho-Hg;
	Mon, 20 Nov 2023 10:46:04 -0400
Date: Mon, 20 Nov 2023 10:46:04 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Rob Clark <robdclark@gmail.com>,
	Gaurav Kohli <quic_gkohli@quicinc.com>,
	Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v2 0/2] iommu: Allow passing custom allocators to pgtable
 drivers
Message-ID: <20231120144604.GD10140@ziepe.ca>
References: <20231110094352.565347-1-boris.brezillon@collabora.com>
 <20231110151428.GJ4634@ziepe.ca>
 <20231110164809.270f82bc@collabora.com>
 <20231110161229.GA462657@nvidia.com>
 <20231110201652.629b7228@collabora.com>
 <20231110194215.GR4488@nvidia.com>
 <20231113101103.1cc05c8c@collabora.com>
 <ZVOgBBEetWf1PFxX@nvidia.com>
 <20231120140425.GA10140@ziepe.ca>
 <20231120153838.2166e7b8@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120153838.2166e7b8@collabora.com>

On Mon, Nov 20, 2023 at 03:38:38PM +0100, Boris Brezillon wrote:

> > At LPC there was quite a lot if interest in improving the io page
> > table stuff to work better. Based on that I'm even more against adding
> > an external allocator at this time. :\
> 
> I'm sure this has been discussed with the IOMMU maintainers, but I'd
> really like to hear it from them if you don't mind. Especially since,
> as I mentioned, the custom allocator idea comes from Robin, not me...

It is a community effort - this is my opinion. We now understand this
io page table area needs a lot of work to meet all the new needs. I'm
against hacking it up like this and making that work harder.

> v1, was a sign this was good to go. If the final call is to reject the
> custom allocator approach, and there's no updates on your generic
> solution in the next couple weeks, I'll probably copy the pgtable code
> in panthor so I can implement my own stuff, and later switch back to
> the generic io-pgtable implementation when things have settled down.

That's horrible, DRM should refuse that too, yet I expect you will
probably end up merging like that.

I would not expect a resolution in a few weeks.

> Nothing against you or your solution (I actually commit to move to the
> new approach when it's ready), but we have different priorities, and I
> can't really delay the driver merging by several months unless there's
> a very good reason to do it.

Welcome to Linux, nothing runs fast :(

Jason
