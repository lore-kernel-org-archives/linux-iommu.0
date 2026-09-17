Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A2B581234
	for <iommu@lists.linux.dev>; Thu, 17 Sep 2026 14:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789653778; cv=none; b=aexNEbtZMahaXz3ed5PV8eanihy4Q8PlU44bq3U8o1yi/d5fYQQkuBV07hTMCjdqOfW5X14/8pT+iSsRV8ZdHtcDXzNORXXQS4YQyH39OoAIxGz1XUIyYgRm1ssvJ1D3Fl2BuLr7hFrx+IpQqFK2+zveOJVrEJYFITnFovhiKgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789653778; c=relaxed/simple;
	bh=5WF8VcNkm/QhAqH+TgnbaHxVovZYWfwOqxhhljrRvjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gu43u6G0SS2fuGo8AokClcrKURaLCFloBBcdLEMD/iJiYflHMDdmvtGFgnQ0d3yMQd0gQn15U+ZcL2PiMeEL8JbvOswyQmPNHcdpI9oGsGt2llpZmZuPB89w1Vnu4u0/PIq3X8Aavo93YITLP1fi7u2j6wohH9Vihqc1vO95D40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=FLVDsYGg; arc=none smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="FLVDsYGg"
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-97e7c7bc5bfso234167241.2
        for <iommu@lists.linux.dev>; Thu, 17 Sep 2026 07:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1789653775; x=1790258575; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5WF8VcNkm/QhAqH+TgnbaHxVovZYWfwOqxhhljrRvjc=;
        b=FLVDsYGggxw3MzsJip0UNZwThMYJNCAWZPDS7+4teA4psaZMFxercotEjygrTVNYj4
         PJqJrAYxsZDPpVkvDn1Sln6cBAq58w0KRS6AgARBgu+SpOrbWiN5Din5oDuzsuK0rVGU
         b7cHgnBQilq8Do/xRkT3CtJitmZMEIad54aFHPUqbS5p3K8o/uH3Y5Alqr4X+txu9F2F
         +HgI3gN6qekkeLF7ZhwTuHGFFOYZga3L0NIFpSsMmQYPl3u4wQclnCn50kEAn1Dk2bp4
         6cTZBu+WQQ/mzysAs5sEBO/YklXa2h0D9TqA5HAkza5ThEO7pZs3MZAal1Uz49OY4tje
         Z0HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789653775; x=1790258575;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5WF8VcNkm/QhAqH+TgnbaHxVovZYWfwOqxhhljrRvjc=;
        b=Qu3wnK8wd7Jq9b255N9utOzj55avgFWzen51XNb4ee64MbLLzBSQHIuaqmKOTUtUbO
         zNX4bEvLucZk3vUnzSR+AAlrqn6gPZs/H1zNEQh0fX73DmuR3O35HiO7Wo1tX5m3+Xh0
         9Lg3WG2BwxuGB3X/CKHIDcMN9DNp36XSkL0HhQ6qiV1XkFkt9PE2R6Fr3c+jVVH9P4Fv
         tnjJYGyxeKgm3wnAY1AyF8xxuKRaqNwdnnxYxlBtz0JJZnu9XADyHA3djzVO4QcI8ump
         3jgtATIEabFpo+R+GRXFbdYX+u1e+SrwsvPj95LAZds9Zx85LNTLkEZN2/aTU5lsoUwl
         wdYA==
X-Forwarded-Encrypted: i=1; AKwUvBweRTXN5U0FGMd7u4SeP+y7/F9mrLoBGLqFKoaZ714/f/sm3Qtv7FUz97iwx/brQU7y/gRNkg==@lists.linux.dev
X-Gm-Message-State: AFuF++naVXna9+tZYSdVVFalW4H8YoOlFV9/SJ7QnGZ2s4halBe55On7
	d2I+hTgomcciWhy7KqyZ4knoRoTiD1I1/YZ5Xp+A84hBVZTDCxO19aQOEGRNn2L458U=
X-Gm-Gg: AYBFou2UT3MuK7Q8cjcUugFy8PJrP3L1YWCniw7lDMf+zHXPlt35HpLADLmgi5I9YEd
	FkwfaFiZXIEFefCF/T0qMEZzdWBv7YST5mh0hscQbYq41eso8IO7qjmAhXBy9MeBipBE+JxMvqa
	Wd4oA3Ml+nTgvPaGxFUzfxQnDbUMiKvN3scsxeNSEy3hV7K2/EXM4DYv3OIuAtLNMdXFHq4c4SN
	C8M1Tmr30QHECwInzDQOvhYuzkeMlNM+u2OSslUIN21U2VyEicggv2QWopu6BxRdxfapQHJ0zoP
	AU59QlmdCb67VIda6phCBrxN1bWfibPAnDGFMrwliiADCIvVrWgm412qDqunQSy2Wn07y7HpELr
	3IlssAZS/U+a3beehd4tOJ0941vbx7uaCJGIuWo4+sWfnIdm8OKUL4bTpjnM6mgpPP7pkt997g1
	Jof0ljy8/JpfW3j3FaVaNQBMpEGydjb8i6XmRUPQa51SKZ+cUPCoeMdD9scdPkqEjdBc9z7dzZQ
	Vj+h1i/toWF7HUpoAtVIExzhDRDD6wPAA/M+tX0Vzt2a6JB4NsImQxe
X-Received: by 2002:a05:6102:a189:20b0:7a2:63d4:3d25 with SMTP id ada2fe7eead31-7a263d44d51mr364707137.32.1789653775451;
        Thu, 17 Sep 2026 07:02:55 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9123bec59fasm50600486d6.39.2026.09.17.07.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 07:02:54 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1x7ChR-0000000Co7R-3O0W;
	Thu, 17 Sep 2026 11:02:53 -0300
Date: Thu, 17 Sep 2026 11:02:53 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jens Axboe <axboe@kernel.dk>, Alex Williamson <alex@shazbot.org>,
	Ankit Agrawal <ankita@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, iommu@lists.linux.dev,
	Tushar Dave <tdave@nvidia.com>, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	linux-rdma@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v6 18/18] RDMA/mlx5: Ask P2PDMA whether ATS takes a
 direct peer-to-peer route
Message-ID: <20260917140253.GG3196566@ziepe.ca>
References: <20260914-fix-p2p-acs-v4-0-v6-0-5ef07ec9ef06@nvidia.com>
 <20260914-fix-p2p-acs-v4-0-v6-18-5ef07ec9ef06@nvidia.com>
 <321890690ce83d1943b2f678bd9bee9b8c895b66.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <321890690ce83d1943b2f678bd9bee9b8c895b66.camel@linux.intel.com>

On Thu, Sep 17, 2026 at 03:56:12PM +0200, Thomas Hellström wrote:

> That is, a flag to tell the topology check that some transactions
> *will* take the host-bridge path due to IOVA being used, and that the
> computations including pci_p2pdma_distance() need to check whether that
> is possible (checking whitelist etc.) and return the corresponding
> THRU_HOST_BRIDGE mapping type. Translated transactions taking a short-
> cut using the bus-address would then be hidden from the driver.

I imagined it would work by the driver passing in what modes it
supports and Intel GPU would simply pass in ATS only.

Even something like mlx has variation, only some operations can opt
into ATS, many others are never-ATS.

Driver should not make statements like " *will* take the host-bridge
path" since it has no idea.

Jason
