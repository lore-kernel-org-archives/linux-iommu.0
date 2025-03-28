Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAA117BCE
	for <iommu@lists.linux.dev>; Fri, 28 Mar 2025 13:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743167398; cv=none; b=iur5MLX54cnx/Pk67AbCgbxYb42V/3qkH9raebUAuAYzAiQTZvKy+JYvdY9pI8c9glXjVJaMyNv55jUsJygnMrfA8AVj8prGViVRHSIMbp3eZhjUkrHi1NL/ana8G0A9b4f1XIna+fxXID3TzDDGkRABN3FPLpxOKBcbj7M+9nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743167398; c=relaxed/simple;
	bh=nsTbKkWCqPsRPDxW3L9BiP9mUlaPvv6pz4JS3WdUmiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mV9kyJKCl9LYOJC27OAIPav9o86Ix6pJItIHXciWKf8XZkH1Y4mPypGIE1dbVL62Kfz8aUlZFPYbxaJ8T4yYcgzwlGUtoyirqpo7EF7Q28zRhAef6j1w52Hrv8wGp6o9MTR6CjVZAe+qvRDfnryX7Yi89efOeY1v+NUscsx+teg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=D9TF6dCc; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="D9TF6dCc"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-477296dce8dso22395451cf.3
        for <iommu@lists.linux.dev>; Fri, 28 Mar 2025 06:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1743167395; x=1743772195; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GrbE8iOj+o8uLnkO2AV/Y6hVNF8UOVIwZLvvFnjPOyM=;
        b=D9TF6dCcxmIq91A7wM+A9hKQim/tmuypOM7kph7sgzjIdgDjNut9wuMeopoNuqifV+
         7Hj0WT3jpgupl3UcTbZTABrM9Jd8pNKDllBbOeSLYwyBNmgDNO2pIngIRT1/U/zxZBy5
         aO6GermV2wLUCBnx+7v9paKT56bE0+AeJDgcv4Rpmr2PaPDlkks5aGHMsbdPx7xjHCQX
         IN2RtaO0yGBGY62+BH5waA8A9R7pX/dP8Ie3Zz6N2Fh9wdV0RRT7Qa02g+opZhpKNsHA
         lCRisedjfkXX8pBHWgSSGdWn1zosVEdwzaF5ISJn0SBP5W/8CGoSpYikAv1qem/jxevS
         b8uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743167395; x=1743772195;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GrbE8iOj+o8uLnkO2AV/Y6hVNF8UOVIwZLvvFnjPOyM=;
        b=l/JwyPmzrZby/ETTe7b/g4cGaBGUZojxdqUkKxzi5NSsrNJQ74BbWBYAX3IdY3PbSa
         C5G2LXO40D2Blk4LYBOOfqU6sr05Qtsv2pGei6+K43KHe9VIYEG/7e7DeVGj9vaYnxRv
         2utWrpC0hpYkFucBZ+//dTOFNeji4mwzmSQQjHPM/g8kYPkQ0q+8jtBNfVYkKdRld/f9
         Ffe4RrsYZJFbCUiCNigQHqIqsxNVv6dU2rFUPXxiIfF2V3yaqrIrCnBq7+iJ87W5K9Uq
         WZJrIbx9QEvAzFAMlHFkXZD0Ak5LeNAFQx5MMivVPeHPIVZ3P+OXKHsT7Gbk6XkerAiq
         PfcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpUpaI1PJprK9WHchQoLoxOafZhxPYGbLwbFRkNWdMh8OwQvLjW+M4TpLtiiM+/uT3Jv5uEQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyJvs17gvwo+tNWEc7mf+q7QoZKyghi2yxUf9X3cWCxX2VlGrE2
	GYPqBaJh2i3EXCFvfNcbEbP4z8vN8zbykPRdBhi7VCe0AucJ0ykJvGxEZciKj4s=
X-Gm-Gg: ASbGncvcTwxfqzYbOBd4ucoCZ8dcc0TuRFbvaI+5wA7S3rWtEgV+Ja0okguT1v2d2H+
	S718uIpeiGbHT0C29q7QuEHGtXb8jHiXfii4L/Rj77t9tsSsXHOmdLlxWlpTO8xPYEtlG4bpPMl
	MEKHdaudjZRjPRXjJd+XHVNl3OqWoD/VEpdlu1DxM3/Mm9k4NbGRUOpQ8wf6RTGTO4QqcHYbOT/
	jYQtCWW5chSQmJKM5scEt/xR1nO4J8HSYtZYieWnJNzB194o0Z+Xjrdywd8nclOK5z6EW/c4RaA
	aMZJ9q4idXRLKq4kUSXVMcpclH2cezVTl7c3+fpGJga7uEynm1SVgPpBTvA2mZEPofli/gQlfpo
	CbSsO8d7VoQ+4JQxyuWZHpds=
X-Google-Smtp-Source: AGHT+IHidI8Os+Ek5ST85eRSABKJEnwVGlnRgxl/M61KkTTVspVJqP5FKyEOIMZ6GGbE0+O2r3M/8Q==
X-Received: by 2002:a05:6214:19c6:b0:6e8:fa72:be49 with SMTP id 6a1803df08f44-6ed238a5684mr100935736d6.12.1743167394762;
        Fri, 28 Mar 2025 06:09:54 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5f7659ae3sm116989685a.5.2025.03.28.06.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 06:09:54 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1ty9T7-000000005Qn-1rpo;
	Fri, 28 Mar 2025 10:09:53 -0300
Date: Fri, 28 Mar 2025 10:09:53 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux IOMMU <iommu@lists.linux.dev>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] iommufd: Fix iommu_vevent_header tables markup
Message-ID: <20250328130953.GA20836@ziepe.ca>
References: <20250328114654.55840-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250328114654.55840-1-bagasdotme@gmail.com>

On Fri, Mar 28, 2025 at 06:46:54PM +0700, Bagas Sanjaya wrote:
> Stephen Rothwell reports htmldocs warnings on iommu_vevent_header
> tables:
> 
> Documentation/userspace-api/iommufd:323: ./include/uapi/linux/iommufd.h:1048: CRITICAL: Unexpected section title or transition.
> 
> ------------------------------------------------------------------------- [docutils]
> WARNING: kernel-doc './scripts/kernel-doc -rst -enable-lineno -sphinx-version 8.1.3 ./include/uapi/linux/iommufd.h' processing failed with: Documentation/userspace-api/iommufd:323: ./include/uapi/linux/iommufd.h:1048: (SEVERE/4) Unexpected section title or transition.
> 
> -------------------------------------------------------------------------
> 
> These are because Sphinx confuses the tables for section headings. Fix
> the table markup to squash away above warnings.
> 
> Fixes: e36ba5ab808e ("iommufd: Add IOMMUFD_OBJ_VEVENTQ and IOMMUFD_CMD_VEVENTQ_ALLOC")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/linux-next/20250318213359.5dc56fd1@canb.auug.org.au/
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  include/uapi/linux/iommufd.h | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)

Applied, thanks

Jason
