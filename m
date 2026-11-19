Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795106208;
	b=gUu9G6Z/A/yc6dTWEkK6ykk+lACL2BSuNg/IWvRrzDz7uqvPLgf28Q1V1zLtEDTrEzIb
	 rL7ghYOV8MtpE95AA7LhCJQWvtwDJdW09kXu2Vy1hLnjafIG2mXVwNAgIsVn/amkKEouy
	 Fq02+E5NU8pdAY0M642FU41pptV9yaiuOcXlLcVt2p/734FLXNdD3mpEEuXxfOepttWIH
	 HNvhIt95ohWgpdEUt5J0mAJJUvvb0hwlxDL1dFiqe7OMLoQBPebcB+fS41ezjp7xKnVFU
	 v92/hwottmFfgUCIRCcFqk5rMgpDHa2uL67T2U01toDZJXdfKwAY4IvfF2yI/SqQq5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795106208;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=Upj9ElOF+MkYEJ4cOgUjnMJxMqLP7rtbsy3TKzTJtFk=;
	b=UZ8qk31koZP38SbDf0s4ljGyqV579wxpsL/AzEIM5lvq48WRSGwMR8ltdu7eUJFkzJ//
	 BCwg2FzEotVaTh2GQHrAnG1/lcON6A9/Ebp47oTD+jLeTLcZEV4DYumP3DWtUqya2F0ad
	 UZihemaIvsmA8F9ttNq3+4jPToiy8db6/QxdAix0Rzkkc0GYiOEwCAohHocuLRriOM508
	 WvPof8D8SXYoGRDbbA4b7E4YtqSiR2Q34ntx66+y81mAoSvwsMyvvOjHoUpWGQorchqV0
	 GjW0Jj2INauWObAGpmt9W3q9hjBoNdLWk9SuS0EcL7jnooyIrda2MVgkdJ3aYUs/eyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b="ee0vMFY/";
	arc=none smtp.remote-ip=209.85.160.169
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BEF606A331
	for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 16:36:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3BEF606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=ee0vMFY/
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-55d3563e50eso32102101cf.0
        for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 08:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795106207; x=1795711007; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Upj9ElOF+MkYEJ4cOgUjnMJxMqLP7rtbsy3TKzTJtFk=;
        b=ee0vMFY/lHFOPnkS5Lew2i4ol2is42BGif9BdComERN3a7LhFXEfy6T/SKbP3jnWid
         tfgQSFZ4CsNorGGXUw0VV7aKAssg1uhVh+1lg3ZmSfOwVieQzmoBe73n8aTTrrdhUIBr
         JOVrZGjNhx2d0GtxuJraKUYFBRY02wZCWOI/WK0TUHpsuCZyKw0Y2eiLpwpDxEhoJp3H
         hD3gU9zNJgvLrvjRwAFUfzUlcAoKPcYTHNtDoqIPmNRzB5S/P1/rLjAD48ZloxmE6IpE
         kYzuRjttuID09ybq4OiQm5/d2lcz3hrXUQ77ODNEiWG8V9dmDa18sfdAyv9WKRoUyRCS
         UNKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795106207; x=1795711007;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Upj9ElOF+MkYEJ4cOgUjnMJxMqLP7rtbsy3TKzTJtFk=;
        b=CMSADNQ+rGquZYTb7j5A2fikB2k4SoG/POxzLKnzW05KWFCA0Uzbd1+MsrtDlzk94M
         PwyaAXTDBqg/GTKO7KGb8hAFVLWtbpZmYsZBQO/MmADxsyugpb3ZmARNsmwZavCdqpm1
         vWAhuD363PGkouR8U/tqn4YSfv0FmZo2evZ45X1DV8NspVLrWHydCB9MTl1MklMMhQP6
         dqUwJu9tU7ceIY46iamEJaQuWo/vAY2Ke8abk3cmY0U0RQ6n0+5NfrcO7ALNYVX57kHK
         /sm2Goy6eRgj1llPjV7K3OCSgch11lVjTDj0e/tpr88mB46W/wSHh08jNyHTmqlUzEZL
         6ceQ==
X-Forwarded-Encrypted: i=1; AL+hErEcfXTu+BOoo36Mvl/xXZpmrl4RXydoYsoAkOGarpo2hKvMj1yJMNedi6zFgIfkGoLngOgQeQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z++SPkEoBC8MGAIklnNc6O3nn91pvh5pXaQGavZTZnqAlNodQsM
	piBRSUG92aTAp+rXoniveDm6bYLS8UCoePV29EBn9Gvxa861BRORKUcsIa7qmVSMxXE=
X-Gm-Gg: AYBFou2rfnH6zu15mO8/ycrZ2qc0nyxinGjyDZPRm4668cS8wjPl+sirybpn+2i3Q8m
	iHM8zf1XmJmEDZeaDxjvYjXFXhruW7P9bUXSLSxnA2utsNlUVTRQmDIHB2kQnOKM0Vkjgy1ufvs
	HkJ1UvjW+3KxvngsKWYV3pEp0LxTxHQYudzE1H8OHvoXDbddRSC7sQx5ACQD07J+xw4BRirt7Pn
	9ZuXPN4p4MRPt//3cv6iU0Ri1RGPyO6BBvEdMd4wyEbYE9hKaG9lVEyvqopvOkv+AToG5bB/IAo
	u+vFcGMGeQ9vpRJO7/2B32YBgrzIJUXw1FwrVT+GUc0lwhJU5IbKNKdFT0SNhzCm/0tqmMRPFYr
	thHT+Qd8wHFsKvgf06iU9ZTBfY8mrP2+m/YEczCiIU7k945JOm5CDFMYSSBWuKQPLRiZsPaZutp
	Qe+UHBIdZ942748d0xe9sFjDAvlUVH1oWt1f/ojBp7NYeufV61gstdJd09dO+Wurf8pgr1eb3Bu
	IlHZ22pyZ1CWCvd7qX/APTlQj8Nfa/TNPyHosKAmcf+krlosqNwW5OJ61CS6MAu0R5ZKMvtqrN3
	hC70Jw==
X-Received: by 2002:a05:622a:988:b0:55d:5ba6:bf25 with SMTP id d75a77b69052e-55d767ab475mr9697321cf.0.1795106206697;
        Thu, 19 Nov 2026 08:36:46 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d66c52318sm27455131cf.29.2026.11.19.08.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 08:36:46 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xU57t-00000001A8R-0Ufm;
	Thu, 19 Nov 2026 12:36:45 -0400
Date: Thu, 19 Nov 2026 12:36:45 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Onur =?utf-8?B?w5Z6a2Fu?= <work@onurozkan.dev>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>, iommu@lists.linux.dev,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev,
	Detlev Casanova <detlev.casanova@collabora.com>
Subject: Re: [PATCH 0/6] rust: iommu: add a paging domain abstraction
Message-ID: <20261119163645.GL3115493@ziepe.ca>
References: <3EB4C2ED-B699-4532-A562-68B78F6E29C6@collabora.com>
 <20261117202055.GA3115493@ziepe.ca>
 <b145b2ceb92c73a4fa0477d7b3895a6e3b4adf99.camel@collabora.com>
 <20261118160909.GC3115493@ziepe.ca>
 <fe60c0bd-1ee2-4b33-8ca3-564ee08e6db5@arm.com>
 <CF2BE3BB-4F16-49FC-8421-B2B823BB7BB4@collabora.com>
 <20261119143151.GH3115493@ziepe.ca>
 <32a64e144c11bec72908ce143044773808be5115.camel@collabora.com>
 <20261119150857.GK3115493@ziepe.ca>
 <da198506005be5c69d61105a5519121fe7bcdd36.camel@collabora.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <da198506005be5c69d61105a5519121fe7bcdd36.camel@collabora.com>

On Thu, Nov 19, 2026 at 10:47:01AM -0500, Nicolas Dufresne wrote:
> Le jeudi 19 novembre 2026 à 11:08 -0400, Jason Gunthorpe a écrit :
> > On Thu, Nov 19, 2026 at 09:52:59AM -0500, Nicolas Dufresne wrote:
> > > Le jeudi 19 novembre 2026 à 10:31 -0400, Jason Gunthorpe a écrit :
> > > > With the additional twist that alot of embedded HW has apparently
> > > > choosen to not implement SSID but instead has a pool of SIDs that one
> > > > device can use, functionally similar to SSID.
> > > > 
> > > > We'd need also API support for unbundling the DT iommus=[] SID list
> > > > into something that the SIDs can be attached more like a PASID.  That
> > > > need, I think, has become clear with all the DT tricks and fake busses
> > > > to try to work around this issue. :|
> > > 
> > > The word "fake" never flies with the DT maintainers. On that subject, I still
> > > don't know what you mean with iommus=[].
> > 
> > When you write your DT you can list all the iommu streams in one
> > iommus property. Like this randomly picked out of the DT files:
> > 
> >         iommus = <&sysmmu_decon0x>, <&sysmmu_decon1x>;
> > 
> > If you do that then Linux sets the struct device containing it to
> > put the same paging domain on all of those iommus.
> > 
> > It doesn't make any sense to open code this in drivers when you can
> > just have the core code do it by writing your DT to match how the
> > driver wants to work...
> 
> The will be rejected, as it does not map the hardware. If you check multi-core
> codecs, each pair of core+iommu are independent from each other, at least enough
> that they could be driven by different device drivers. And so they have been
> described separately in the DTs. I don't see a fault here.

All these multi-stream things have a choice how you model them in DT,
both ways are "describing the HW". Fully seperate HW blocks with
multiple struct devices or a single struct device with a list of
sub-engines. IMHO neither is obviously more correctly "describing the
HW" than the other.

However, the DT choice strongly influences how Linux works and drives
certain behaviors inside the kernel. So it is not just describing the
HW, it is very strongly describing the SW model too :(

Choosing the opposite DT model to what the kernel driver wants and
then undoing it with a bunch of code in Linux is not nice. We have run
into trouble when people go down this path and start asking for new
APIs we don't want to give them. :(

We had this chat with the DT maintiners too, I think everyone agrees
things are imperfect here. So far the direction has been to change the
DT to match the desired kernel SW model rather than hack the kernel to
accomodate the DT.

If you truely have HW with frozen DT in firmware then maybe that is a
strong argument to push back in this case.

I recognize this is all imperfect/problematic :|

Jason
