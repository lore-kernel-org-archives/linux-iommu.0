Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE0C2E62AB
	for <iommu@lists.linux.dev>; Fri, 20 Jun 2025 16:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750437378; cv=none; b=fnNA4goZm6PHjza9+XUkOrQZrB/7ubvbMRL6L82896tNCUhZFt2OaU/dGKg+Nojd+X7Wjn5TCrXebv6Fr4pto1OvzJptcwkhlWsqYPI/uZW7mqX8z1/Qk5/qzmMMKDnALQAMuWTU5WLBKFB0ic2IVwduqCd3JC8p6hIYhHxbMes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750437378; c=relaxed/simple;
	bh=GB2QSxOXPLCCKsHcC8diOJcoWq3MI5uEslI8P9rodFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WSXqgRrfUq9Fl/kCJBSEMgWOI7KNiNO/7q/iLIV3hVg2bYkG0zlhIMdf7g8koCASP4ri7lR6C+Sum2xtY2JFwChcJcbzT5vUIYzSWqEI+CPJ9PBwsxml4TKr3frDrJoqbXnkuPwuDJMHwYCkvyvI/sEiSUHFbSGD44ScoE1+i/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NWwokxp7; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NWwokxp7"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6fb0a05b56cso41798936d6.3
        for <iommu@lists.linux.dev>; Fri, 20 Jun 2025 09:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1750437376; x=1751042176; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uJYXWxLY4HLgWwCr48sF3PGs/sRochGTLyGIU3biNNU=;
        b=NWwokxp7YQsnIzB9rdjPT9Z2eWTZ2jYTNGbZ1TWpgKhlgOPQoSwB8tfShFaMkudeij
         A/PUU2AUbMNoAVtMrkXuc7RbhI9yAMqHWaoSyj2eRbJfqUY5tfe55MF62XXyBLkK4ykr
         MObMQ6nClcqEw+nwhG91+Tx+P4RNBr6Lnx1EMm7ZKgKLMK/qkUIswzde3Z3E0ATp8aqj
         v+GSlOWgpQkpYxXGpGJNfQ94yNVTe+onIEiQFZQlgBaI+LAhxcEfVlekkRRx22HSAnJX
         UKLgdR8FXSlxpbJmk9szXeb4V5OqvZ3yX41LMC4s51Xm9PFZOy/kwLahkLYXexlBqrXq
         ryOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750437376; x=1751042176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJYXWxLY4HLgWwCr48sF3PGs/sRochGTLyGIU3biNNU=;
        b=nUAd2I8BKxwufOVonQEqbYgplYm7B5D2y1z9Kvc7+SG1IaJn9pQum1KqkhmrF7HQ9b
         RhtiM8exdbUtdlqLdIvfQFvJjNmns7ao7/HZdXjT63291dqutd0zcqX3mAO36TveP1Fa
         +np3jx0Sxhso/SBH4S9D5Zbw9pf7lUfDBrxFdhNqXBPjEhI5c5OwXgPKKOqrl8ngJMSX
         hvIT2sTQfQi8jEDayvYV63C+gNbnstNzxopIC1x2l6i/Fl3/9FAxN6tnVQ1nb2RswQdf
         VKGR4SCv3FtsqJburFDOtnmAWXEA/vjOA7ByTM0iPnZeqkmR5l4gxTWct6Rft5nFSUt1
         Ow1w==
X-Forwarded-Encrypted: i=1; AJvYcCUHDEIjU+ScNjtF1GJZuQNHquGufZaCopGY89Kx2njLrhOo2GVnNH3cgEojYiUfyrL9y+/dtQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxSl3wwCPfEX3m+oFcAAKoTnvQL+cVsAkgFZJmcCeklyfwgGskh
	GHjNtKI5xkgPCuYqVAFuOicRd454ghAL5mTnTajbXf/ktqiXToQBunhyM86+cuGpBKk=
X-Gm-Gg: ASbGncuG3ojOpWpZeRAStiBDPqgcMFDSuXwsXdPbty1lXUfEUdChNzKF58MOUsTRbec
	zdnsQ3EYT2iS00N0kHd4Ko9ygNVTdiWnda3iewA8tysWNq+YZ1EWGGZ62OjFwlGekcmGc7AWEBb
	z5etWbkhZqvOt7hWy893lhDMizgUf7qgROxtPowKvCIcznKblqckzkFB8xWEdVlwAj7nQd2x7x2
	FRTccZPytr+2A4ANvM1CW+8agMGSI+6qAuDdcarPSNQu8UAh9dQKd+/eRyO8I2g177D/r2OHQxI
	oJXRjbW2vr/1UIDsuu5W0y9MAa4fPlhudNzkNKpU0R+Esky/Jucus1zmbAylcBlS7G1vlUhSlfL
	mCQcY4agRR7E2TppkHJLrPkct4HduZauR+wHp2Q==
X-Google-Smtp-Source: AGHT+IHyontIEkY5vAgGgYhS+U+r5SqIyyHQ9UkviOZGeU6jrV3bzO+5OOnHkugt3y3GJ2IEIkVU5A==
X-Received: by 2002:ad4:5de4:0:b0:6fa:ccb6:602a with SMTP id 6a1803df08f44-6fd0a51b3d7mr63974736d6.20.1750437376130;
        Fri, 20 Jun 2025 09:36:16 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd09596e6bsm13876946d6.100.2025.06.20.09.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 09:36:15 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uSeit-00000000EsP-10Pb;
	Fri, 20 Jun 2025 13:36:15 -0300
Date: Fri, 20 Jun 2025 13:36:15 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de,
	nicolas.dufresne@collabora.com, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v3 3/5] iommu: Add verisilicon IOMMU driver
Message-ID: <20250620163615.GC39770@ziepe.ca>
References: <20250619131232.69208-1-benjamin.gaignard@collabora.com>
 <20250619131232.69208-4-benjamin.gaignard@collabora.com>
 <20250619134752.GB1643390@ziepe.ca>
 <073ffe14-d631-4a4f-8668-ddeb7d611448@collabora.com>
 <20250619165928.GA10257@ziepe.ca>
 <e034a111-93eb-42e8-a533-46553b4f5588@collabora.com>
 <20250620120509.GA39770@ziepe.ca>
 <d9a1b9ab-b6ab-4364-a1b7-df4debc21bc1@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9a1b9ab-b6ab-4364-a1b7-df4debc21bc1@collabora.com>

On Fri, Jun 20, 2025 at 03:52:46PM +0200, Benjamin Gaignard wrote:
> > > vsi_iommu_suspend() and vsi_iommu_resume() will also have to take the lock
> > > before calling vsi_iommu_disable() and vsi_iommu_enable().
> > Yes, if they use iommu->domain that seems good
> > 
> > If the above locking is a problem then I'd use the group mutex instead
> > during resume/suspend. The attach functions are already called with
> > the group mutex held.
> 
> Does group mutex is also called when using vsi_iommu_map or vsi_iommu_unmap ?

No

Jason
