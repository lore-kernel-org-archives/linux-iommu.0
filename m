Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AACC2BEFFA
	for <iommu@lists.linux.dev>; Mon, 15 Sep 2025 22:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757977091; cv=none; b=UYsXcjQs0xFRm1uej3Wen3D8uphvCEHd/qZ5TCnScXslY8YFeF5OQfMzO/aVrye5qWVpUXxYSXkDfxQU7tjoGJ7LsqA5LE9zrWcop8+NcQLPfRdR3d2YBy1aFpPNUOWBJK9O9tXWFIxssbP5wuR4+Mg1xUfAdu3GKX73LHOzdVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757977091; c=relaxed/simple;
	bh=wrK0nRI1OFbp71bXaT4X7O+VxQvKh8LBne/yxp6bWq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lt6hAEHkwf35zbWZrZdHlxMTF4yDpQT9kKA5ejTM1kH0zFNLllNkuVBCWS0YjdEIkgCMwWMs+3nhh+OeWcjXiYGdrOVi8129F4wi64IIaNYVFGq1YlKfmhxKBHecT0sMye8hsL8wHrIdRWOUr432ipOMSFt0i7lPtWvIegCw08A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=VriJ7Cxj; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="VriJ7Cxj"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-75763558ae1so606210a34.3
        for <iommu@lists.linux.dev>; Mon, 15 Sep 2025 15:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1757977088; x=1758581888; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kB/Wi+cRe7K/Xl4jkmaNXOwfB7KCAKUI6vYOHIxWVl4=;
        b=VriJ7CxjmB9Vh2EP55WMka1+KJzYlaAM9U+IBG4FrE9YqI/KafIi02MUQz22CTp5jT
         YvQfRqO0mxvw3daguF8DoT62MLqK6mafX4I/NaTa/pMzYhRVLz5SlKWnzmzS1lDdkgbr
         dOcutdUZM1QsmyT2lWAPHjwurAXOTLjvuqO0VXg28X5F6HJjYEtpfURizQFACHRrZ4FV
         xuQuyEYNMTI6pChoK9yC0guyZJuuwSRzz0EdzJElcd+/mcqpKAZkVv8EbjHWdecJe4XN
         Re2dzpE6eFrK0oK+f13k9xgReSkYxKGhJN3w/soKdNR37Rw9gouavjeQkfauja4DeQyn
         yReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757977088; x=1758581888;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kB/Wi+cRe7K/Xl4jkmaNXOwfB7KCAKUI6vYOHIxWVl4=;
        b=roxghxJq0AZ7C8X0DE8EmxBcjLAjPeD+fQDs7E8r06qj1/VDyfs8mUy8mFanAAN2uh
         4mmv8nCSxpLRPFgZwA006qxc2g6levI6HwMppMzYTAB+tWx3Q5ZOzK7bUaXOfSAa+mlP
         Q6XgwmYRORMTEn4VTPLx/4Uj8IFQ/PWBu3oT/p3KDpwcCnSSVRzImcv+mSBVaNTbqf0R
         h6geZAxvbqQcmqbUeQl9tjg6G30sQ1qGnyLIQmYes/sa9XD4L0OW++6ft647V22SS88e
         q0dsRSHabRsuK6ESdYFBvaWBmpMU3QSZOFrhpYCRknkJ0JjtKC0vXQx1kTsh25geHgB3
         o09A==
X-Forwarded-Encrypted: i=1; AJvYcCXAUYqSQSykBmX9cIVgjkkm5DwopkwgPlHWRvKtAbKp77vDklajro613/v05uZFrdGvftpGaw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxYQq8qwjF6RJbQRXuqHbxCjRVbUXszz5xYqxBNxEJfeAkqLPyI
	p5IWIsZmbyAWHNEN9YJoQ9gnnSp2lkRC2oCALQEfvIixw8QWSE7ukxjtQRMrb5AAc3M=
X-Gm-Gg: ASbGncsySZv017Z6WzLPT9qW1w9C8ytvqZUaiAjfAsHLl7ut4JLFP3sAXOAYFwCDouo
	DGV84lLYafFmrKivOUPNkjwniJrsiuyB0nBmBqJNw7m+Jt8LjqmBrTNqCrubyaU24GUixZVzcQL
	wXO1HS9Tf8YrHbkp5kMg3SWH1/dQpvp1G9TuNacfcy7J1HrPM5F4+rbNc9u4PDxkJt7t9cPM2B2
	sDZtwFrIXiRbtz6H3XFizwuwrFPXATQxp+4+k89we/Y5K77MWPB0xnRoYw4alxBkWoLJAc4mV0X
	kzqQJ05tLNHzdUHg5WCmLwD3ud0lQwAiQpsarD9+wfQ1J8Slvzi/dkgI8Ttaqo1zRiPZjvAZWif
	E7UQpv2I=
X-Google-Smtp-Source: AGHT+IGSUOqb+ed31/428rqH5N5OvGqFxlxhfX8elAayaMc3UDw7hqxF226u18IdPmrznlxbRNVzmA==
X-Received: by 2002:a05:6830:6adf:b0:745:9dc8:8dfd with SMTP id 46e09a7af769-7535638abb1mr9759182a34.35.1757977088588;
        Mon, 15 Sep 2025 15:58:08 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7524986c872sm3180269a34.15.2025.09.15.15.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 15:58:07 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uyI98-00000004Yk1-1O1R;
	Mon, 15 Sep 2025 19:58:06 -0300
Date: Mon, 15 Sep 2025 19:58:06 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	robin.murphy@arm.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, heiko@sntech.de, p.zabel@pengutronix.de,
	mchehab@kernel.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, kernel@collabora.com,
	linux-media@vger.kernel.org, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v9 3/7] iommu: Add verisilicon IOMMU driver
Message-ID: <20250915225806.GM882933@ziepe.ca>
References: <20250911155720.180465-1-benjamin.gaignard@collabora.com>
 <20250911155720.180465-4-benjamin.gaignard@collabora.com>
 <vrngq76nnms3jyl5hnxqnkimjc6kil66o6fdyqn5vm3fpovmja@cfynipjw7ktp>
 <694b9ba15cd67f41a38f4a65a3811f035cf8e99d.camel@collabora.com>
 <rt6nvgazcl6mvyy4iuut3n7irf72t7rex2iwabbkuxp7cdvez5@2nanenqgxjdy>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <rt6nvgazcl6mvyy4iuut3n7irf72t7rex2iwabbkuxp7cdvez5@2nanenqgxjdy>

On Sat, Sep 13, 2025 at 07:58:04AM +0200, Jörg Rödel wrote:
> [Adding Will back to Cc]
> 
> On Fri, Sep 12, 2025 at 01:37:11PM -0400, Nicolas Dufresne wrote:
> > To me this rejection isn't about Benjamin's driver, all iommu seems to look
> > alike, so anyone else that would have sent new driver would have face the same
> > issue.
> 
> This is about ignoring comments from one of the IOMMU maintainers. I am not
> going to merge a driver with open comments/objections[1] from Will (and a few
> others), so resolve this with him and get his Ack.

I would strongly object to trying to share map_pages, unmap_pages,
iova_to_phys, free and other iommu pt related functions in some
limited way instead of helping on the much more complete iommu pt
work. Which is what I said to Will, but for some reason he suggested
it anyhow.

Sorry, but it doesn't make sense to complain about duplication in
drivers and then not help advance one of the biggest projects to
actually concretely and comprehensively address that duplication.

Jason
