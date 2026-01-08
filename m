Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F2D22097
	for <iommu@lists.linux.dev>; Thu,  8 Jan 2026 00:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767833571; cv=none; b=RdLEqupBy7gAuWHu4dDZHFlFLlZo0UvPycIhqteICb0X6bRSkk1gw6HgUPtwPsz7C0sQS6isC/L8veUHx06b4XSLtnBZGreO8wZCFYE1th529Vc3Z20tjqAekvnydOHfI2iPNSQcui5lLN+cKv8IHFF6MlE5JHmVeVFj13WLJ+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767833571; c=relaxed/simple;
	bh=fpDKNtuU+PGyD4kWBWYWE8qAyFvNsHD15QcPP5mzx2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6Ib33YL9fUn0vj+LUQNoOW1wJC0CWGXoIshSCDB2JOtmtWv6w+FkAHTG8GclXRnk1YTvK3px2tgiWFfowhWZxGDromG2L1/ar038rf3hUJvZyAkMuQ4WboimR878wmApdRIr3BVgqNMs5st8xrqrnFA7y3xOCCKdR7/8fQUNH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=eprnBW81; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="eprnBW81"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-88a2ad13c24so23619626d6.1
        for <iommu@lists.linux.dev>; Wed, 07 Jan 2026 16:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1767833566; x=1768438366; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5+vzRqt0WvMUxlRhT7PzHDUFqU9G51QR6QaVuEMHjYE=;
        b=eprnBW81X2ZB5/hBhooeEBY+jPO/7ksry/JM/x+k63Yhe5k1+g+dGtIgzo+07HeVvY
         0ntHwXOVgN4W50SN/VoHpFmBIjpXCwvlxlCGB4CWpEzWVO1RoLE6gPNozeVrTJcTu4qv
         pKB6012bM3vYCGjemJMc6jrJ12T7U8JvJ13jeqvEnP84LDmqrQNZ6rfBVUJbpozPYiIP
         YRhYBeEaoJUXZNoCi8aofWRsTjjyBlqg35/OpQEntABR0X7qzQjLccNcdXH8aRmXAgBE
         a3ixEFoTpCzUSDta40I6ii7wm+oT50f10kUKeIwdTUYjwXTDWuwKRWXyM8ZhrkyQz83Q
         LpwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767833566; x=1768438366;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5+vzRqt0WvMUxlRhT7PzHDUFqU9G51QR6QaVuEMHjYE=;
        b=w8LqRJe/SDeFYSWUYmDpVn0e82LQ/78Raw3IgZWVk85UWL8RDvlcnX+GZYPFdAt/ot
         /nDLbZ3U6oUZKozJjoDeIyWo/B6v4sEtIuN6YUoiGwMsr4cLrd33nfDmiyv14qqu/JsA
         kxR32LQtrdIYY+eti9etHiOG4gwdc14Z0qF2Py2Tlvmb9SmR+NbJV0ML4STGc36j3RUy
         PAkL3iuvTWtxmh2Da5IU8qjvl5zmyFP2ETDeKfZVZoFClBDCuHNXbsDYQQjDZtF6Fl9S
         kiNt0lm/4bbhPmLVoSESpe6MVk1pPdGN12MT4KtywazlCPWLOKnoGp3EbKHYyOePfqkP
         2KCA==
X-Forwarded-Encrypted: i=1; AJvYcCXTulaDGeAseOVWpMEIWWmLJZCGtay/Rpbh1Yws+xZt8wB8pE0nzjSsB1u2oJRMl3DtWhP+bg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yze0GoVEcPBw4l0fTc0F3ET3rVg3wEZculvFU25rgQXPiQaVzou
	+Z2+t/N83MTNQ9oEaCIGi45ThsJlccCGGzoDSyYnUy+Ms4BTjWvNTDTcGVXkhpm4/VE29ZKasab
	wNCp0
X-Gm-Gg: AY/fxX6ZRoiK6aF/extpyqWwz45uSuB5xvs7icWZBJQ/Wf/kMvjmmBirG3/WCn08VLB
	75zwxf2GyB9TvPHcxooEefKWvIGytD9V26MgHoHhn84BNl29X0VyDWiylivg4xkDtWDrTNe5YyQ
	LwM1s0hibphmcoZqQBVXWuUqRYznNYI9GwXsnL8ambQJp7msWBS/Wxq6yfUEqoCh/9jYdrZ2HMc
	afvEdF79AFEyFKfQgfbhU9LUsrFBtFBFkogoH87u8eOy5LwbxQdYxtVXkFtWZ7dwtLn1IybjzVM
	k1nweQ3JOwpkfZ9RIIFiSowmdW0ACbnmIoyR7hdntzQitWH5AVCqrx6Iig45NiWXSD7qlyicGqA
	Bd9TqUlZ4CxNlYI7zJzi5jcvpzAL+S5QNzYihbUMR/iQFMRaYyBRZxhkYr5qp1COwEdXx1/gI5Z
	2MS3iHwwOi+fciuln/Ou6rdSIs/+lPTU9Trg/ycyEeFuQUBCQZmWucUOXixy8peJt7Be4=
X-Google-Smtp-Source: AGHT+IFA8cedu5rrSA225rhZc79cHeTo/A4ONEANG0ibwMBrjHUCIHMBRsJTuBSALMXS0NYgMqVOmg==
X-Received: by 2002:ad4:5d47:0:b0:882:3f45:c819 with SMTP id 6a1803df08f44-890842a26b0mr63787686d6.53.1767833565635;
        Wed, 07 Jan 2026 16:52:45 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89077235411sm44485156d6.29.2026.01.07.16.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 16:52:45 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vdeGa-00000002Hqi-1pEk;
	Wed, 07 Jan 2026 20:52:44 -0400
Date: Wed, 7 Jan 2026 20:52:44 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Chunyu Hu <chuhu@redhat.com>
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev
Subject: Re: Question: AMD IOMMU v1 contiguous PTE OA encoding triggers
 FIELD_PREP overflow
Message-ID: <20260108005244.GA537065@ziepe.ca>
References: <aUn9uGPCooqB-RIF@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aUn9uGPCooqB-RIF@gmail.com>

On Tue, Dec 23, 2025 at 10:26:00AM +0800, Chunyu Hu wrote:
> While enabling CONFIG_CONSTRUCTORS + GCOV, I ran into a build-time
> FIELD_PREP() overflow in amdv1pt_install_leaf_entry() for the
> contiguous (NEXT_LEVEL = SIZE) mapping path.
> 
> Specifically, this block:
> 
> entry |= FIELD_PREP(AMDV1PT_FMT_NEXT_LEVEL,
>                     AMDV1PT_FMT_NL_SIZE) |
>          FIELD_PREP(AMDV1PT_FMT_OA,
>             oalog2_to_int(oasz_lg2 - PT_GRANULE_LG2SZ - 1) - 1);
> 
> ends up producing a value that exceeds the width of AMDV1PT_FMT_OA
> (GENMASK_ULL(51, 12)), which compiler detect and reject at build time.

It depends if the compilers idea of what constant value oasz_lg2 has
is correct or not..

In my past adventures it is usually not correct since all of this code
passes runtime tests that would fail if it was actually out of bounds.

> In file included from <command-line>:
> In function ‘amdv1pt_install_leaf_entry’,
>     inlined from ‘__do_map_single_page’ at drivers/iommu/generic_pt/fmt/../iommu_pt.h:651:3,
>     inlined from ‘__map_single_page0’ at drivers/iommu/generic_pt/fmt/../iommu_pt.h:662:1,
>     inlined from ‘pt_descend’ at drivers/iommu/generic_pt/fmt/../pt_iter.h:391:9,
>     inlined from ‘__do_map_single_page’ at drivers/iommu/generic_pt/fmt/../iommu_pt.h:658:10,
>     inlined from ‘__map_single_page1.constprop’ at drivers/iommu/generic_pt/fmt/../iommu_pt.h:662:1:

For instance in this path __do_map_single_page has oasz_lg2 fixed to
12:

		pt_install_leaf_entry(&pts, map->oa, PAGE_SHIFT,
				      &map->attrs);

And the logic in amdv1pt_install_leaf_entry():

	unsigned int isz_lg2 = pt_table_item_lg2sz(pts);

	if (oasz_lg2 == isz_lg2) {
        } else {
		entry |= FIELD_PREP(AMDV1PT_FMT_NEXT_LEVEL,
				    AMDV1PT_FMT_NL_SIZE) |
			 FIELD_PREP(AMDV1PT_FMT_OA,
				    oalog2_to_int(oasz_lg2 - PT_GRANULE_LG2SZ -
						  1) -

I can tell you that pt_table_item_lg2sz() is also 12, so the else
branch is never taken.

Not sure why the compiler is only raising an issue with the gcov
options, but it is not a functional problem with the code.

I don't know what to do about it though..

Jason
