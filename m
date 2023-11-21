Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F32B6FBF
	for <iommu@lists.linux.dev>; Tue, 21 Nov 2023 01:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="YosRf/aS"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6ce2eaf7c2bso3160383a34.0
        for <iommu@lists.linux.dev>; Mon, 20 Nov 2023 17:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1700530779; x=1701135579; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fz4p3ZfFny6qJVN9sQ219rkze+bwswpB7VIcNz890As=;
        b=YosRf/aSj/eINhybHKFyXl2eOxnbk50Dc+7XxMvJoYCOYx5xYtSJW0LVmq1C0HTpZW
         MceTo5+ZfLaT57ToaKQRPOWMHRV4LjARIkLraOyK/DdL1B8Le4L4HyFoOBjtFcV7nykQ
         HYlrFo+O3r0kBI5oRwk6bnWA+Frw0P9PpmNFbTnEKnCLUhLjGkTozOVXMmtrF95ujy+w
         Q3szrdEjUjrDU4jTIRSl1tb+V5Qu1RNVxARdf61WGez3tWPT3ewF2dQZ7gzkmBNfDN+5
         Wg0YEmu1kN1b5b2DUzFbuhIIowaipKEL9su+MX1CuAF/u5EryFZYp8vaGGI+Kb9HrmU0
         vPMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700530779; x=1701135579;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fz4p3ZfFny6qJVN9sQ219rkze+bwswpB7VIcNz890As=;
        b=K8K9amtUNBnYtKV3+cTSutygFQmJbqRZ2blPrtBcsMut3IaIzGofUZuhTNDlsg6heu
         L5eXTiv/vEE250P/ZVtNFJjnMUNSqjUYaiZ5seOUVSAI6XjvjaP5fCfjqmK079wtZu7D
         mxBPb2yGOmGeD2JB1o/O96nt9hKnAQzAxmfMH0bt09it35OChAD4WKEqgIdzWTK0R6TO
         qI/uyglmuVgNIuAFlU2Mi3El6QXKvvhv6fsFRkNYtVMjwb4cO817yq7CUyj1I0bPjmOf
         1y0pN8gWo0Yz4HVdlwO2Nt2LXBQoRa3csG7HhvqpjJSNiw/ddfsb0/DtNOYp5PBa4rt+
         KgYw==
X-Gm-Message-State: AOJu0YwXKbr5C4LUX5iMOR3WZSflNWGngpS5NV0+ybP0LusPYIeMBFir
	HaioK1PdOmvUxZ1Uh98bfYbbkQ==
X-Google-Smtp-Source: AGHT+IFpJxUvxxA1GysD6LVJ2r9vV1Nbcc/QLq4q22f/ResIN8lV5LRXcM9XYXXO7322vKdE/MGt8w==
X-Received: by 2002:a9d:69c5:0:b0:6d6:4f84:b5cb with SMTP id v5-20020a9d69c5000000b006d64f84b5cbmr9401174oto.38.1700530779180;
        Mon, 20 Nov 2023 17:39:39 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id cz23-20020a0568306a1700b006b8b55297b5sm1396727otb.42.2023.11.20.17.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 17:39:38 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r5Fjl-001AWJ-Cd;
	Mon, 20 Nov 2023 21:39:37 -0400
Date: Mon, 20 Nov 2023 21:39:37 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommufd/selftest: Fix dirty_bitmap tests
Message-ID: <20231121013937.GH10140@ziepe.ca>
References: <90e083045243ef407dd592bb1deec89cd1f4ddf2.1700153535.git.robin.murphy@arm.com>
 <72f0e75b-6c91-4c17-beb2-3f198ed05cd0@oracle.com>
 <b541f87c-fa8e-4b09-bf1c-68829bc9e6c9@arm.com>
 <BN9PR11MB52768448A70C9B3CCB2CDE3D8CB7A@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52768448A70C9B3CCB2CDE3D8CB7A@BN9PR11MB5276.namprd11.prod.outlook.com>

On Fri, Nov 17, 2023 at 03:15:25AM +0000, Tian, Kevin wrote:
> > From: Robin Murphy <robin.murphy@arm.com>
> > Sent: Friday, November 17, 2023 1:44 AM
> > 
> > On 16/11/2023 5:28 pm, Joao Martins wrote:
> > > On 16/11/2023 16:52, Robin Murphy wrote:
> > >> The ASSERT_EQ() macro sneakily expands to two statements, so the loop
> > >> here needs braces to ensure it captures both and actually terminates the
> > >> test upon failure.
> > >
> > > Ugh
> > >
> > >> Where these tests are currently failing on my arm64
> > >> machine, this reduces the number of logged lines from a rather
> > >> unreasonable ~197,000 down to 10. While we're at it, we can also clean
> > >> up the tautologous "count" calculations whose assertions can never fail
> > >> unless mathematics and/or the C language become fundamentally broken.
> > >>
> > >> Fixes: a9af47e382a4 ("iommufd/selftest: Test
> > IOMMU_HWPT_GET_DIRTY_BITMAP")
> > >> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> > >
> > > I was going to say that the second assert is useful, but we are already test
> > the
> > > number of bits we set against what the mock domain set after
> > > mock_domain_set_dirty(). So the second is redundantly testing the same,
> > and can
> > > be removed as you are doing. Thanks for fixing this.
> > 
> > Yeah, it's still effectively just counting half the number of loop
> > iterations executed, but since there's no control flow that could exit
> > the loop early and still reach the assertion, it must always be true
> > following the previous assertion that out_dirty == nr == nbits/2.
> > 
> > > I would suggest the subject to:
> > >
> > > 	iommufd/selftest: Fix _test_mock_dirty_bitmaps()
> > >
> > > Because dirty-bitmap tests seems to imply the whole fixture, which covers
> > more
> > > than the bitmaps.
> > 
> > Sure, that sounds reasonable. Jason, Kevin, would you want a v2 for that
> > or could it be fixed up when applying?
> > 
> 
> Jason can help fix it when applying.
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

Done

Thanks,
Jason
