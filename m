Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F161D54E2
	for <iommu@lists.linux.dev>; Thu,  2 Oct 2025 21:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759439544; cv=none; b=EZFFWPbN5co4QgxjefCM7JAmXhWwFfzyYLwjijzVXrfxqBDpLxb7e2DHQQdlx++9lnKeU74K4/ATcRTI9Cpbwm+iAGhkOB1EP40mIzRGO2x84K2k76ZW3ySUMt/OHENrARq/iM35VS0gsx5npkX5+x1yggAV0elgX4WXwuTs4uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759439544; c=relaxed/simple;
	bh=iT7/AYK4t8uxayoTReNhK3pljGDwN3pTd3WBJnHuGT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oPMBkXS+uy3Ptk1fGcAu6woT80vtKa9+hoEYEEtl4nRs9Nx9aqz3TzOd8Li3y6r5h7fPNN+ivfm7nEHrzXk65WmGseo5Anu3LpShOWtbq8R+rBZHKg0xIKAMO6Dy509E72jxSlAi+EEwaCUwBgIf5dfxYnQTK26xWYeNBHBPp9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=DiKkZkzu; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="DiKkZkzu"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-86be8a110f5so16163966d6.3
        for <iommu@lists.linux.dev>; Thu, 02 Oct 2025 14:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759439539; x=1760044339; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iT7/AYK4t8uxayoTReNhK3pljGDwN3pTd3WBJnHuGT4=;
        b=DiKkZkzu5D9O16+NVFYZi45xgCBvQEmgtYIANu9P0ck22ufmgXtoWpVXNjDbUcmxhO
         Xe9GcL9JTWdQiDf8p1nXojjBYccVj1g/CY9tha2vI5yCqpVQB98ikvrCRWm16eNbMKaL
         swpJv/5C4ofrVgBrSgbyU58mSJYMz5H1ywWGFSmhvWE1cTOZHSF8eUy0hKohTKJzFxm0
         vamTLH0o1Dy5G4/zquG3q6CR9ctCbFwmSQKdnM8G2ga2TGX2KK0cVEiRxAbvRqbbPzzU
         bpU7c0cME0tzE0H4dkySJaWm+iYGhL8U1r423fewq3xVph/ytMG6GLcJrKS1/7iUHY8l
         B8vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759439539; x=1760044339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iT7/AYK4t8uxayoTReNhK3pljGDwN3pTd3WBJnHuGT4=;
        b=Xck0HSyi2n6HOoMs9pNN6rjAQ7gy6RbKirjg59zaxLUo0QLAvmmGw5+XjdvvJMmWBA
         S42goif3kOV13DDWoNAel5uxJKoIv/I08cu3Yj14OpvhtU1lTX6RJaXZcYPRPKPWnyMP
         fLxBpY+XSVddIXD0IEwfNf3MTJJEdhhiG++MPi+zQmSGlBGvn03r9fXZrTQMbitYLSZB
         38w0AzAd2bBRdb/fL4psSRZS4wyA4pxIVV0rBakbhXtREy71cCx3/Ptpy0eK/fkuxGuZ
         0deH/qEgricQAUJNb6ZXToXf1OgKdpl8WgeJGh9hUWvYozpLBBYm0Sjs1IcztFDewjdk
         ouew==
X-Forwarded-Encrypted: i=1; AJvYcCVLVkN27pZhutIGDYRDmVXnsfiAnbN9S0SBQUwDeJ6zmESc+iPudwa9GYY6RbUcG3GJ38i+OA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxOP/F/VyhARycb4c3TEObNfX2gtmXyikLs5Q8iG5oIt0sCnnIF
	ZgDlvMQpnb0V9wi+AV6kddz0nrAkbwszaIhLxjob2GSSquvaVek3B56CMd8evJNr8zA=
X-Gm-Gg: ASbGnct4P2NBnLmu/IGCJ4APWkyz/tgX0ci9+km5zx6TyCpfLsu0oH30w9Q6GEkQ4+5
	XyQnN4lnM3M0A4qRKldpoEG/OeDWGJvSc6FRP0xK8rK2E2r/sMZbAOG/3eWOj5GD9TUqQS2IH/d
	jVrPvQOJUyNmXxOnoeo28YWmYqUIK2ltuXI6eLIh9n/UcVrnz3rC9okQ9CpXU1Dd3t5WqHrh5rF
	B0itWZKPXuLb4eec81fimaiXZXyxaFZcVGNu6X0m3FnKN/Wva7lhcgeKOsQMNtpRuU9yQB537W4
	WOv6ltAhoKKc/vOrS69ABe9Sc9wT4kySzGLKtYLktgXcbY0HJpQFwlXYDQGWMLQKu/aGEXs/2tD
	7tjfJkJBMUR1LKRwtwjTsUxafNBCnXCuNNm95msToT//LiaISylRCjm27afr7FS1JXiw7g5fmJJ
	VASkKPb+EeQ3tQq8PL
X-Google-Smtp-Source: AGHT+IHHvVsAZOqVxWndcmJwbJMSlKmjI2WMP+ieJr8pz5dnwNzMlZwNBTV8WRdGNWtSpYM4WRBOcw==
X-Received: by 2002:a05:6214:e87:b0:78f:2a6c:11 with SMTP id 6a1803df08f44-879dc86a53bmr11662886d6.62.1759439539193;
        Thu, 02 Oct 2025 14:12:19 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bdf53343sm24655486d6.54.2025.10.02.14.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 14:12:18 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v4Qb3-0000000E0oN-3d66;
	Thu, 02 Oct 2025 18:12:17 -0300
Date: Thu, 2 Oct 2025 18:12:17 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
	YiFei Zhu <zhuyifei@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com,
	Chris Li <chrisl@kernel.org>, praan@google.com
Subject: Re: [RFC PATCH 13/15] iommufd: Persist iommu domains for live update
Message-ID: <20251002211217.GI3195829@ziepe.ca>
References: <20250930135916.GN2695987@ziepe.ca>
 <CAAywjhRGrGjZK3jQptieVWmdzvjfNtTYrp2ChTZJSmFyrBaRqw@mail.gmail.com>
 <20250930210504.GU2695987@ziepe.ca>
 <CAAywjhRQONuHsxTGQZ5R=EJbOHUD+xOF_CYjkNRbUyCQkORwig@mail.gmail.com>
 <20251001114742.GV2695987@ziepe.ca>
 <CA+CK2bAvnTTz+vPg7v38_1dajRZQHyPQ8iDmziiW8GFUqy6=Ag@mail.gmail.com>
 <20251002115712.GA3195829@ziepe.ca>
 <CA+CK2bAudSHq2t5NZPBKDC2wfzsF6SSxTF7aZ2kxueOTzWYcfg@mail.gmail.com>
 <20251002151012.GF3195829@ziepe.ca>
 <CAAywjhQGQx2_2X8r0rf3AgMDbJj-9C=9_1a3xgiLwuzKLAvXCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAywjhQGQx2_2X8r0rf3AgMDbJj-9C=9_1a3xgiLwuzKLAvXCQ@mail.gmail.com>

On Thu, Oct 02, 2025 at 12:29:25PM -0700, Samiullah Khawaja wrote:
> I had a quick discussion with Pasha to see how LUO can help with FD
> dependencies and FINISH order. Perhaps we need a new LUO API that
> iommufd can call before live update, explicitly telling LUO that it
> depends on an FD that is going to be preserved.

Keeping track of a dependency graph is possible.

But I wonder if it is really needed to be fine grained.

If a memfd remains frozen until finish, and finish can't happen until
all luo objects that are internally refering to outside memory
indicate they are done, don't we get the same outcome?

Is there a reason a specific memfd should be unfrozen before finish?

Maybe finish is too broad grained? What if each session had a finish?
All the objects in the session are cleaned up, invoke the session
finish and the memfd's in the session unfreeze?

Otherwise to build a dependency graph we'd need things like
iommu_domain to record all the memfds/etc stored within it and
preserve that and so on. This information has to come from the IOAS in
iommfd so it is quite a bit more weirdness to inject.

Whereas if we have the preserving iommufd do a sequence where it
pushes all the ioas pages (memfd/etc) to luo, and only then permits
the hwpt to be preserved to the same session, we get the same basic
tracking without needing to store a graph.

Donno...

Jason
