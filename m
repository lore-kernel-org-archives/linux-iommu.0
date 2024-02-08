Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F249623769
	for <iommu@lists.linux.dev>; Thu,  8 Feb 2024 19:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707419018; cv=none; b=PJmID8KwLTqvZF4pPkF8ZWRhxra44TZE4d7KRGI+1SVLHCU/00nxkJnzurpp/D+IvpkV/61TlHLtlQqFrrNrpoXHA1mThgSxJSowG9eGWrBiFutmbFdGG9s0CkTcaTXyhGLRltVfiC//U6AVAIgtiv6JCLuLbRgeWbGM1lbwHgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707419018; c=relaxed/simple;
	bh=xSrEmq7LX/mf7kjRVCcVqE63nqybsIK3WEDZXrLn2I8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OM424AWwNyhjbPhe3DCytoYLnd8BP+1vw96PwA8h5VAE2mUXrE233h1zEtiRgaXhBv3cTqj2HzaoP8Y6r7HJJ0ZBXRYZc2eCbasltNPXoLUiDoVdHjDvwjQPkHpN7FQiS3LDby4kU6X1VpDx4ozOvZ4C4dtrT0dO2RyW8V5Ctzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Do/e6v+R; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Do/e6v+R"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6ddca59e336so110949a34.0
        for <iommu@lists.linux.dev>; Thu, 08 Feb 2024 11:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1707419015; x=1708023815; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KdDcEqWuIINSVR+jw/L+DPVNK94k2ebjg86/lqBzhHY=;
        b=Do/e6v+R8mBCila1cnKriSoZKlry6FNOpkxydQZgl6xcH6c0ikdOaCSqz+LlS0mMMo
         ec0w3HI/h2in6EMzASxZWS6i4Y8Qt+IJEJuNNqkFBdup4J+Lie/oWaO5yZperH6P8Npi
         VbKp8Tbh8zMVsbH325giDvDrqFJtup4v67CcJ9wnVdayxARUKgkooGSfZ8Alm4wa6eO5
         mvSqvzLkPJzpzPm01zkaOB23FmL+RPe0AAjuq32CH+4fR1bTm+udlzElndpMxyPgiCyu
         UyHy1qAxR8rhHrqeuVziFZ6gpDK1goCspuAMhB13VtFMCuv64haw73LIV32B5usiJ1x2
         kpWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707419015; x=1708023815;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KdDcEqWuIINSVR+jw/L+DPVNK94k2ebjg86/lqBzhHY=;
        b=Og4Yn+oOIvYF9OARf0Gs7dovJrt5M2KtVb7+tZbp8DRSnxTTIQVIkT5SWrBeUNtP+S
         VhArrvsY00+3dc0hJJBHwGKskF8c43QjjTVn8QE/wzkh02ahhcg8wAlu7suChs69zkQw
         TyzGuunfw2wbQl87S8jm6JjYDdRq+w1FQUkNAswsR2yNVa18BDAjtkF0zylP7e6eMWxN
         MMUc1qlDmrBKjZpCDRJXaxTNSqY4q1Y5ghHuCbM/qozaeVctcyPXjrjKKIFH2W1VTHZ4
         q26T1aUx7Fz4ugeI1Ja9jKZLKpmbIoZorAuypZje4jQ7yNN7FW4JSexiEY7x+gRVluLL
         wDdg==
X-Gm-Message-State: AOJu0YyY/cUjtVYhl1g1bmWLO3Peel0bHHvw5CCVvqTTcoYAPfWM+SVe
	J+3ZcjoN6+eBHVLawMcZ7panAgZRr6wyDtXcEF3ILcCX16AEwAlBZSiyWoDUAA0=
X-Google-Smtp-Source: AGHT+IF8xr6EocmnY9pso64hQgt8n5zwoOdzh1jKZtwVPNts5tr9JCA8oKLdj7IdktAxBCQZirFf4w==
X-Received: by 2002:a9d:618b:0:b0:6e1:213a:e551 with SMTP id g11-20020a9d618b000000b006e1213ae551mr1889618otk.3.1707419014790;
        Thu, 08 Feb 2024 11:03:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW2sA9muWueHg42OR5m2fYtdgsz1zmzUWO6LhYtV5UqaAB4bx9V4gfwaXnswJX0D3egHuk2/NpGbap4B4ueS01/n29VMSBGhwkr5xQGD4M3AuOIViGxhI3hBJpsS/VC8ToPMeot5AuvEePQCXdx0mgFAcgcdFpSu5Lgfv76qTdNXlVcncBeCs4=
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id bf14-20020a056830354e00b006e2c189c93dsm16987otb.2.2024.02.08.11.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 11:03:34 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rY9gL-00FiyW-IP;
	Thu, 08 Feb 2024 15:03:33 -0400
Date: Thu, 8 Feb 2024 15:03:33 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v5 10/14] iommu/amd: Introduce logic to enable/disable
 IOPF
Message-ID: <20240208190333.GY31743@ziepe.ca>
References: <20240118073339.6978-1-vasant.hegde@amd.com>
 <20240118073339.6978-11-vasant.hegde@amd.com>
 <20240201214949.GT50608@ziepe.ca>
 <9d3579c7-66c3-3752-bad8-a8a8ebc5c74c@amd.com>
 <20240206163657.GG31743@ziepe.ca>
 <873201d4-57d1-e856-87c8-08e2ca71f0a2@amd.com>
 <20240206175824.GI31743@ziepe.ca>
 <0d626c74-aba5-bbb1-5fb4-b9be5577d71f@amd.com>
 <20240208173158.GV31743@ziepe.ca>
 <beee7947-9c1a-95b6-66d7-88e130fd2956@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <beee7947-9c1a-95b6-66d7-88e130fd2956@amd.com>

On Fri, Feb 09, 2024 at 12:07:16AM +0530, Vasant Hegde wrote:
> On 2/8/2024 11:01 PM, Jason Gunthorpe wrote:
> > On Wed, Feb 07, 2024 at 02:28:08PM +0530, Vasant Hegde wrote:
> > 
> >>> You already know what is going to happen at the very start of attach,
> >>> you don't need to "enable it after" just do it right the first time
> >>> through.
> >>
> >> First time we will not know whether device will actually use fault handler or
> >> not. All we will know is whether IOMMU and device is capable of PRI or not.
> > 
> > I don't understand this, you should know all of this before you get to
> > setting the DTE. What is missing?
> 
> In attach path we will know the device capabilities (like PRI) but we will not
> know whether device is going to use it or not. Its like device has capability,
> let us enable it without assuming device may use it.

I don't understand "device may use it"

At domain pasid attach time you have the domain being attached and
information the device capabilities.

The decision is simple, if the domain is using PRI and the device
supports PRI you enable PRI.

This means you enable PRI when you attach the first PRI domain to the
GCR3, which will require rewriting the DTE during set_dev_pasid.

This is part of the same logical flow where you'd rewrite the DTE
during set_dev_pasid to do things like IDENTITY and BLOCKING RID
support.

> >> If I have to enable PRI in attach path then I don't need to track number of
> >> domain stuff. I can simply do something like
> >> 	if (pdom_is_sva_capable(pdom))
> >> 		// enable PRI in IOMMU
> >> 		// enable device PRI
> >>
> >> and in detach path,
> >> 	if (PRI is enabled)
> >> 		// disable IOMMU/device PRI stuff
> > 
> > Each PASID can have PRI on or not, so you need to keep track of how
> > many PASIDs are using PRI at any moment and keep things in sync that
> > way.
> > 
> > If there are no PRI handlers installed then the PCI config space
> > should disable PRI and all the PRI bits flushed and disabled.
> 
> If we don't have handler then PRI is disabled in attach device path only.
>
> So in detach path, if number of PASIDs are zero then we are good to disable PRI
> (at least for the current usage model).

So this is why you are having the problem above, the PRI logic should
not be in the attach_dev path because that does not take in a PRI
capable domaine (currently only SVA)

It should be triggered in set_dev_pasid and remove_dev_pasid.

I'm trying to get you to organize things so they are ready for the
next steps and things are not in the wrong spot.

Jason
