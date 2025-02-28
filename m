Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AC233E1
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 00:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740701069; cv=none; b=jjK9wjVtc27YMvSLo4CBavI5r2Amy+LrJbcjBuk4zE9CtgGDHNX0VrPzcuP6rqGVjAdqt8c7GTlQB0nOV7qeCTUyZxqBoMQR/uhdGGxRM69rf7ZDEbBjl7AqoYD7k8VjlmaJOqiRZP/8/V0QF8515qWQ7zJUbZNIzaCcmN9CyG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740701069; c=relaxed/simple;
	bh=+c7ZTY0eX09YtuOLIqBK86udGzH+wzh+HvljoISOS3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTLoo9MOU2wHAyH2AAGtm1p0MTlATniFIYbAghm5yCKrsGJpnfmvVJhBXnWiyBzNgDrpSgY3xkyavgxH8E0gQLDvk24iq4F4cIwmVYk+6X4NVVQBkI6Yr+NylwnEKWD/CVh9PHOWhCugWz86nmGR/+zcZwSZTdr/v/w9Idi05NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=XlkVLU1I; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XlkVLU1I"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6e892e0eb74so12380826d6.3
        for <iommu@lists.linux.dev>; Thu, 27 Feb 2025 16:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1740701066; x=1741305866; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rXTeuzJuD507zck95F3w0cU1wpQQ7qF2hl1bxyIuJbI=;
        b=XlkVLU1IwDZ9LGNmOkdULRI5YU79odcUbNYz60E5nYj7b+0ZbPkXsc+aE0K+gx28dp
         ciwGD1+n3ubQ3kypo6H6C8EpnsCCHWa0c/EEWtdwJa+zjbuDuBkpK188dgkVcD16nqmM
         MnE1Niwa7qsQEDQLnC8enjl12UidmVtru0lAYuCjRwt6bi/5RTLxcm+4bfrTpO842MUc
         WvQfrOawo+rPLjMbxJA7M1DRFDjRwuZfp2KsayMTP1EdKvOzyAOjNSxXsVVXmnoVo0GK
         yiFPtpFf7W271bC7w08slHgkLrRHodalL0OByObZqrLt4I07jUECMTtvFxvHOiuXQyYu
         RUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740701066; x=1741305866;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rXTeuzJuD507zck95F3w0cU1wpQQ7qF2hl1bxyIuJbI=;
        b=iU6QFTUBjnEZGEBRufWdtU6qKdLm4ciGqei8SAfH8HOQbLd0AFouT72ZiqE0SVx17p
         HSyI2t1HMyq4TAZIhwhdYdkoNvU9vbVdJL6fP1CYFOrMvr9bqEuEu7EIqyizZwI7zaJF
         9m/0z8Yr2lM+K6n7+aq9BbRM0drbWIPDsG3YiErr5MOhPHDsgTA/mJBqAHlTvdJQrqVV
         IFM/ajzzWT+rOPomv3vbtSsMJ2lmc1CEsupqidcZqHrS5YkKnX6ubDLZRuj4hnSdQCfv
         U1ovknHizsnIn5n76gklUQC7Irqn9WefVwLbReUTZ9fJ4L4WCVl1FUFcaykR7qxkecwH
         y4zg==
X-Forwarded-Encrypted: i=1; AJvYcCXn3VfU3p2KJJ3Z3KyYzm+1K5ymZvya8WyAlaAh2gysJxaErAqAHE52YzxxV+ogwVBEy02pWg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyaZEHcaD2Qox9MEyaWMCvPrFyW85n58K0DeQiVqrDeUt214Kpa
	es9lAR/35fPxGrWR+jhdT51ROYmrFGOpHCB86iKJofY6JPXQH1sNl6H8PgxEWOw=
X-Gm-Gg: ASbGnctR2gI5VnnigqegSHrxvpeW/HjFWTTddVpZGQuPNSyv8L5TQUJhXDzbTZBSOQD
	R+wVFfxqwvzbwkJIMIXwrF1TpwlRTkLk++ivbq6hEbfu2Zna4tiL+wxoCU747B9iPrS7U0Vb8xN
	NzUbdxXB3x6QrXB891FiKSFL4SqCtMHJc6VNUp23WhJT6ZXBBFtUtxNb/zQsA06+ZXdQI2ezpMo
	IrD6vLhc+57RaSs9MnDkd4C7OdZyqniaD3MzYyCJxWX7eXNTYtQmezpaDqhXPbYSsheaI/E0Y7I
	nZVbon6ISplAUrPC1wEbWtJRxOsuiuqgsAGH3E1QjPsvFhyAS9I+BRsFrCOlRp87BbieFCV9cMc
	=
X-Google-Smtp-Source: AGHT+IHEpNsFHgABSo+1vDVk/nA6uN3JjPpOGZ7DWAhu2Jw8+62PtOnjjqyOiJakQW9tqkFXGGw2eA==
X-Received: by 2002:ad4:5f0a:0:b0:6e8:9444:7ac8 with SMTP id 6a1803df08f44-6e8a0d093a0mr22256876d6.17.1740701065716;
        Thu, 27 Feb 2025 16:04:25 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976ec158sm15488476d6.119.2025.02.27.16.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 16:04:25 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tnnrc-00000000LJS-1AwV;
	Thu, 27 Feb 2025 20:04:24 -0400
Date: Thu, 27 Feb 2025 20:04:24 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH] iommu/amd: Add Secure ATS support
Message-ID: <20250228000424.GJ5011@ziepe.ca>
References: <20250225105829.52223-1-vasant.hegde@amd.com>
 <be9d2ad2-0f9e-4d06-952b-4cfd6ae53447@intel.com>
 <ce86ff90-377e-49fe-9c4e-d2ad7abeeec8@arm.com>
 <20250225145518.GJ545008@ziepe.ca>
 <b630b6c0-a25c-4230-8abd-a48b7dc27216@amd.com>
 <BN9PR11MB5276B090C61D1F059538AF7B8CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <cc4cf4ae-2d29-4747-b655-df841661b82a@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc4cf4ae-2d29-4747-b655-df841661b82a@amd.com>

On Thu, Feb 27, 2025 at 09:34:01PM +0530, Vasant Hegde wrote:
> Kevin, Jason,
> 
> On 2/26/2025 12:40 PM, Tian, Kevin wrote:
> >> From: Vasant Hegde <vasant.hegde@amd.com>
> >> Sent: Wednesday, February 26, 2025 12:47 PM
> >>
> >>>
> >>>  3) TA is an IOVA and the IOMMU runs it through the full translation
> >>>     to validate it. ATS is just used to signal non-present
> >>
> >> Yes. AMD does this when Host page table is configured.
> > 
> > Here 'signal non-present' implies to support PRI.
> > 
> > But...
> > 
> >>
> >> We need to consider various scenarios. For AMD:
> >>   - Currently on baremetal, we cannot enable SVA and Secure ATS
> > 
> > ... here it says SVA/SATS are incompatible. Any more background?
> 
> Sorry. I should have explained it better.
> 
> To support SVA (PASID/PRI), we have to configure domain with AMD Guest (v2) Page
> table and host page table will not be set (DTE[Mode]=0).
> 
>   GVA -> GPA contains translation and GPA = SPA.
> 
> On ATS request it will send GPA back to device (which is actually a SPA). We can
> support secure ATS, but ATS response will contain the SPA.

I see, that makes sense. The TA is not tagged with a PASID on the wire
so no iommu can support the #2 form with PASID.

Jason
