Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF872D73A2
	for <iommu@lists.linux.dev>; Mon, 15 Sep 2025 22:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757977182; cv=none; b=L/dqvsK+uO32SQ5pVlHRFI9AvSj6700OOJb3fWQCJ7ek4FbsKze9by27HgDoUHOv9zufsJcT7bOgSURGWcDPYJyjceDefF8zD5N+us1Duw+0QqWzEb2UyB5y1ZD4njAtW+qQfY+txU1RLSXkCf7csKx6YAtLOSJ3uYSljZSfdDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757977182; c=relaxed/simple;
	bh=MK5JK3spo/EOu3EOGiWabvNo20/6TWA7kB8HJQJpF0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=twa52rmjExOOXTnaUIf9kqAcFYvxB3mZGFhFLJjdDOo2tBWkU2CCrg+wa11WDIlGb40LRR50dmuRWmMPMIs/34PNCDDEqE7i2VeIqds9noZV+L1bAVdJAmecyjgSooVO6QiOVEljCt7/ECEMYSTRGcrt7XwX3SiPahgIH33f7jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=fWmsDw+0; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fWmsDw+0"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-32be6bc21c7so3568411fac.3
        for <iommu@lists.linux.dev>; Mon, 15 Sep 2025 15:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1757977180; x=1758581980; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aTycPbHlQtDBtjOvMMJ3SZ6uhxSiX0nO4WaEP9DHCc4=;
        b=fWmsDw+0BnE6NlLN4FV5inuTo9wkAiB5/45Sug+E7vC50uID9CJRlfxsXuX6NyVlcV
         CgmEnjLvdbHoyO12fBSpqIA75mTse5vh5Jg2BqKBL5tr4oipCg78Rt7mpCGwiOACqo69
         lBG+Jh/4vjBoS2jc0rU4PG1BUPZVueXkCNJZkFs/0698ObeAdMV9XTnDzjI1SPyVY7ps
         Ko3WUySEuh/Ymkf3iB0qLsW1tfs2bcw8NRm/2Fv59NZd0OJQeNd/FFiqeILwoe3vLuGr
         pNVEsxMT9jC1ZeojWBl+6YfV5+XqDxmjVxzTOoEooX+xh7GiPgfL0jDfG/C6cc3wjoR/
         bncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757977180; x=1758581980;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aTycPbHlQtDBtjOvMMJ3SZ6uhxSiX0nO4WaEP9DHCc4=;
        b=JtHEhSErL2x5ddZX1m4DcG3wA2JWNmmLqOTVgNaULKAsrP/1xl1t/QbGz8qf3rMgjI
         mX4lhPHVaQ5uLHhWV8rVYvMEUhXIITL1SKdg2vos2e6FBCl/shy6rX4JieEyHwKM8Whd
         /VVVeEzWkxolqml/syc0KlHAhMTnuC4pXC3+rbjoBIVxkYd6Fz2ydE7/ePFRobC+jioI
         EXtIPGEQo4Ac3M5XPzsWjTOjCOzs3Fd89Ax3DhF4J4GfFrmeX6pHw6eTP5p9k0nQCzWB
         BIP1/Jj5CisNtRyBc6OW7p7KWeWA1PNY9WXXctXndAvAxasbrtdnn0CXLjp83if31FoX
         +D3A==
X-Forwarded-Encrypted: i=1; AJvYcCUTUlEhbYIw+9gsfc27W+kD0PYF9JXutie/4nr3sgHTgFjwAnysJHJE50HtPw/AmO0ZrUrgkg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyHQEUqIdsLX5u6pm4v7kybQnXWErTx5vIL9JaoiXOvfAp7QgQT
	o8gl2MXHmOBhIn+IK5h1RPVuzIvOE1InsXoFUxCDdo6A8ytJzSJHKST6U3JDeB/gJ7o=
X-Gm-Gg: ASbGncvwPhCzPozXAEkSxYG/gpzUb3t7dT3MLm+EGxkRc629W4wq+KlKzjMPrDgnFHy
	E6WweclisNHoinymcPqfg1myVdXg4i54ycZHtlyJrMNQCJnNjuODEP6oI2nTZhhqnF0/IPShhMV
	6cagEXbYcKIniIl08SWvpFmBpNjns1SRyFIgGVws8fP1kCGWrCjLu93javwN28WhIHDDl0Ks1n+
	7TtETwd49XcF5fJqCkSHTvmC4pdyIWS8vcIgBWH8wmHF/R5K95GtwA3L6Ls/RPyEkPthB/BDnz7
	y1mEclY7SUfv2FIrS6R06iaQLsUx0PtXHdeINC7XtVgeR8cCl+wp0i1I+6FvZepiWYQy0uYmHji
	MxZn4CzY=
X-Google-Smtp-Source: AGHT+IHaizr3a2V9CFBUtFDTvOTqaJTANyOfH5v0JTyHH5V9DAauzxISXWz+PQumMIbWbikwaEyCPw==
X-Received: by 2002:a05:6870:82aa:b0:301:a704:ef1c with SMTP id 586e51a60fabf-32e56bc4018mr7508892fac.25.1757977180618;
        Mon, 15 Sep 2025 15:59:40 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3317d74fe33sm1565394fac.15.2025.09.15.15.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 15:59:40 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uyIAd-00000004YkX-1MrY;
	Mon, 15 Sep 2025 19:59:39 -0300
Date: Mon, 15 Sep 2025 19:59:39 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shyam Saini <shyamsaini@linux.microsoft.com>
Cc: thierry.reding@gmail.com, robin.murphy@arm.com, robh@kernel.org,
	joro@8bytes.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	virtualization@lists.linux.dev, will@kernel.org,
	jacob.pan@linux.microsoft.com, eric.auger@redhat.com,
	code@tyhicks.com, eahariha@linux.microsoft.com,
	vijayb@linux.microsoft.com, bboscaccy@linux.microsoft.com,
	saravanak@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	lizhi.hou@amd.com, clement.leger@bootlin.com
Subject: Re: [PATCH v4 4/4] drivers: iommu: refactor arm_smmu_get_resv_regions
Message-ID: <20250915225939.GN882933@ziepe.ca>
References: <20250909154600.910110-1-shyamsaini@linux.microsoft.com>
 <20250909154600.910110-5-shyamsaini@linux.microsoft.com>
 <20250909155847.GB882933@ziepe.ca>
 <20250915162842.GA23954@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250915162842.GA23954@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>

On Mon, Sep 15, 2025 at 09:28:42AM -0700, Shyam Saini wrote:
> > I'm comfortable with this side from the iommu perspective once you get
> > agreement on the DT representation.
> 
> We haven’t heard back from the DT folks or Thierry. Do you think we
> should wait a few more days for their feedback, or go ahead and send
> v5 as an RFC instead?

It is about normal to wait about another week and then ping them for
feedback.

Don't send a RFC, you intend your work to be merged.

Jason
