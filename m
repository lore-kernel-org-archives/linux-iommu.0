Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344D85B5B4
	for <iommu@lists.linux.dev>; Tue, 28 Nov 2023 14:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="j0M/IH0d"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3b52360cdf0so2691571b6e.2
        for <iommu@lists.linux.dev>; Tue, 28 Nov 2023 06:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701182110; x=1701786910; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mU0p6xbpFTkyXWGjYVAfm5sm2ySxTisEI49QmB0GvUc=;
        b=j0M/IH0daFRHG+Wb50qcQ4OOy1D1CmmXmCsSW4cBKk5Vx0GeNup6Dlp9eM/hvMvdyF
         zb5PiyRZm70Cf7G+ZmchlKED6y0q6G1tR+ZWXG591t9RVoF5GboOg78OuBDSM0f1DlV6
         vg/pO24yjTdDX/n+UgtxQ3qFnsJnRbc1mnMKAQzJS7FdfO02BxHRqzQgOoHXpY8CLR0Y
         I1hJ2B7f5HsfUlJLRAieP9QGbms2enyPf4mYBQeVVjv2TVltZtfsYcYKZ/8mgB4N2lSh
         A3gl+Ldgyd/h8C/D+mDUaJoUKxUKuelCwHyXPQYdpP7XRMyfzlZd4dnJjyunk2UnochA
         BYFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701182110; x=1701786910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mU0p6xbpFTkyXWGjYVAfm5sm2ySxTisEI49QmB0GvUc=;
        b=CzxdjHgLJwwt8R+Nj3pfZlSdKeovnF8IZAb375tWmPXiGssMvLElZjtYlsFqqgeKB0
         8+SW6PJMQFBmNhtduxNzAS/0t4fjMWBZmtjrT/7hxUUycSSNGSmMtz5K/4EP0lk9LnOv
         PRurJwBgs7paahIrypG330a+fDyMYnJpvcpb6T702NmNmjKIUuhrA+od9fBwYvWrgXqn
         drlDgsmM+OKoeL1UzVGmQMBsb+1dl8jMNpEM/Uzan4aqxFvid+48owNDCCpCtByOzCEd
         yRzY655aQsiJiULiClmaGU9LNc3TpJmdn5IThkom/Va54/ziA0mS9tYVoWegEab3ZHBE
         bAtg==
X-Gm-Message-State: AOJu0YwjryyCj/LQTCy6hIj7PxJza2E5CkKrHuwoTctEY7XkNNd+N8z3
	cvnWs+2wjRcNXp8Pq4XXOzmGqg==
X-Google-Smtp-Source: AGHT+IFm85sCZM9GYbWWTfuyl1YQC+tIFaoEBfBmtndKobcL5DQyqd+aQPTs84SPfYUybfqBkHyxrg==
X-Received: by 2002:a05:6870:be8b:b0:1ea:2447:5181 with SMTP id nx11-20020a056870be8b00b001ea24475181mr18982913oab.9.1701182110147;
        Tue, 28 Nov 2023 06:35:10 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id sc14-20020a056871220e00b001fa8e52eb41sm111367oab.25.2023.11.28.06.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 06:35:09 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r7zB6-00506g-UN;
	Tue, 28 Nov 2023 10:35:08 -0400
Date: Tue, 28 Nov 2023 10:35:08 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, kevin.tian@intel.com, will@kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iommufd/selftest: Use normal IOMMU registration
Message-ID: <20231128143508.GG432016@ziepe.ca>
References: <cover.1701165201.git.robin.murphy@arm.com>
 <44ee6854da69e86b208f49752f60a4c18205c32a.1701165201.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44ee6854da69e86b208f49752f60a4c18205c32a.1701165201.git.robin.murphy@arm.com>

On Tue, Nov 28, 2023 at 10:42:12AM +0000, Robin Murphy wrote:
> The IOMMU core now supports coexistence of fwspec-based drivers, which
> the mock driver now is, so let's bring the mock bus into iommu_buses,
> drop the special interface, and use the normal registration flow. The
> one concession we have to make is to ensure that the mock bus is
> registered early enough so that bus_for_each_dev() doesn't error out
> for other IOMMU drivers registering before iommufd_test_init() runs.

This makes iommufd non-modular which becomes a total PITA for development :(

Jason
