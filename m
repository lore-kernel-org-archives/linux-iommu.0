Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F8839900C
	for <iommu@lists.linux.dev>; Mon, 13 Apr 2026 23:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776122946; cv=none; b=l+dv9KK8UOjGileTOh9JWU+MusoE7RMVPQQh0suiTFb92DAQS1iKW3cik6afW5R3RjrDfSIalXRUtuis11P65iWlQLQYGUwSuH/ugomOvkP4Q1m4Bn33mE0IVtCLORkyoqZi0dq7YHmpBDlpY+5obtpCBhOTIVxinuclOwIwzDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776122946; c=relaxed/simple;
	bh=YWZAnDYf6y9BkmLDuysBkBolYs6f9pDJ3ZTZLEHRWpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OnY/mFMzrBiyhqsaUkLKDR2Eb6xZwSYlt7IO4/x8QgV0FKM8kYc2tWsaFmj+O4pSNXICUmrTPHkperzgq95KIfP6kZ/UR7iZxwJxvbdp3C6D/mJqFnJ0xgVRZ53tnb6r6fqa1krgT/71rlpgQAGFKyh7j3PiaGe4jUV820uoDrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oDuh1EQr; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oDuh1EQr"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12bfe0ae81aso46247c88.0
        for <iommu@lists.linux.dev>; Mon, 13 Apr 2026 16:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776122944; x=1776727744; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YWZAnDYf6y9BkmLDuysBkBolYs6f9pDJ3ZTZLEHRWpA=;
        b=oDuh1EQrxtfVqI38Mx6N0bcBFKVpv2q1SYawndaSbQf+t+P8grvxGdBBE41Eu6wW1r
         e0rl5/bwMJWM3YnYwJDSpnPQZiSJ4afcLnYidymy1yd8REa1BrNvF5cib3MLNk3q27P/
         5g7my5wlnFslQ8vD5MKDbwtSQCY3RG4leo+3NMNKgWLJsGmjJrvJYSal3mMrBhAfsskX
         Ycpu3kOMt0OBGaqfeupaA8ofN7a2VE+MKnbY8o4DSSwWT+lcVUesPu6+S1Qi66OseJa+
         jClXNtAQZw1LYDtOigfVLXURU+EGpz/p8cm+CCojVgNXvglv2Hy8ySIo8UZKleobJKw5
         mBrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776122944; x=1776727744;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YWZAnDYf6y9BkmLDuysBkBolYs6f9pDJ3ZTZLEHRWpA=;
        b=CWSJwQTqhmGaquExpzTtQmx74msoTH675pb++5B0FjvycXMPm1Vsg51kaIpPKTHh5W
         O+O1e4AJhq99quxTvDkAIq83+LyNOuUHFZep+oItN+VRq0/sbQXkndRyRltzOInGo1zq
         U14RGtXHaorYmDVeQLOZMrgEoNLzdbsVKOiG/73g5OQznhgfAjCl7fzzvJObQMF0t+Bp
         /XjKQKjEY6VoOPC8ybBCs2L6kyXut26Vlxq76fVSalPT7TDn2D2MGphj7oJ1RnQLAWt+
         fDcmz5fvxgNpSkpTgoeFPPgd9nonsIjsQFHHL+Sx4p3tCwUzZhBHgAqu66c3BHxqoghv
         E2Dw==
X-Forwarded-Encrypted: i=1; AFNElJ9wHq9k/f6Z5JUIpRuJW61ahy1eAJejZ0B86GMfzBgJ22sAxR/zu+HJ/06fRlpoCXQQRCAWVQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz4Kh931iFEYpegpLWJqc3SIkA87hkVu3/0qWVRIlsBxEqZE4JH
	JtBsW2KjYz5GaHEcIu8VVVYDqsH0BmbG1Hj+weaJUOXyJB471FXXNSrq+3r52dl2WA==
X-Gm-Gg: AeBDieuabLvnvBShB9EAo8lHkJx2yu2M4yTBDwFbKVbSq4arNr80qPHcJmMo5ai404Q
	liGje1U0dfHNCgGNtoxqSlXECR3lbzdkCHHYL4G8UtCwPNMLZnqDTOM/A2HVbzhUdIgS29iPypg
	CWcwiSdWCGoJow1bxb049AhXVmIw8+x9S2NkBkLAWZd4e/zwCiF24kZhdm6k93ZfobL/Nkh9xXe
	J6qsom9E0tYjGcSWC/LT9FaDmaOrKedR0RsCmJocObDFZQtBbJTqlkd1l3qHTPYimfLCdIuAJDc
	LCktdp7hPzCWLnCJ+wj8eSLD+fdkskdeKZuqq6wGaRvE2NMLBquFGrpQPjUnHbv2aGqF6p4OeIq
	SvBav0OlU/JgmnFww6JFiixqlz6BVdSupZC3fUMm9BdQysH7XxPwCt58VqzNZYsZuOSFHoolwGX
	fGTlfFILUzhPGG0MJw9Sq8KGha+3O/dqDIQPvc/xZiPVeERoPhJqrEwiG72zoABYKSPtAlFvwcv
	5yGa33rgbY=
X-Received: by 2002:a05:7022:11f:b0:12b:ebc9:3da6 with SMTP id a92af1059eb24-12c29c1d268mr869915c88.7.1776122943207;
        Mon, 13 Apr 2026 16:29:03 -0700 (PDT)
Received: from google.com (195.236.83.34.bc.googleusercontent.com. [34.83.236.195])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d851e5bb3csm10730610eec.1.2026.04.13.16.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 16:29:02 -0700 (PDT)
Date: Mon, 13 Apr 2026 23:28:57 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Pranjal Shrivastava <praan@google.com>, 
	David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 05/14] iommupt: Implement preserve/unpreserve/restore
 callbacks
Message-ID: <ad1z6YYIiO_jBX3P@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-6-skhawaja@google.com>
 <ab3CtC0vN6J975V5@google.com>
 <20260410141652.GV2551565@ziepe.ca>
 <adl2QX6gra99bkOV@google.com>
 <20260410231650.GD3694781@ziepe.ca>
 <ad0b-5aRU172-Od8@google.com>
 <20260413223318.GR3694781@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260413223318.GR3694781@ziepe.ca>

On Mon, Apr 13, 2026 at 07:33:18PM -0300, Jason Gunthorpe wrote:
>On Mon, Apr 13, 2026 at 07:31:22PM +0000, Samiullah Khawaja wrote:
>> Yes, we use the collect walker during KHO restore of the preserved pages
>> and also during free. But if I understand correctly, the collect walker
>> behaviour changes based on some FEAT_ flags (like SIGN_EXTEND). So we
>> have to be careful if the previous kernel was using different FEAT flags
>> that affect the collect walker. To handle this, we can just preserve the
>> u32 features from struct pt_common and deduce everything using that.
>
>It is agressively not stable, and even new kernels might not support
>the features old ones were using, so this is a bit dicy.

Agreed.
>
>You probably need some, but I think I'd be very choosey about which
>some I preserve and which come from the new driver.
>
>> Thinking about it more, we do preserve the top_level, so that could
>> potentially be used to walk over the page tables of these free-only
>> domains if we just set up the pts->index and pts->end_index properly by
>> initializing the range based on the top_level. Are you thinking of a
>> similar approach to walk these free-only domains?
>
>Hmm, even the free walker requires computing the end_index, and that
>requires at least vasz. eg ARM will compute the number of items in the
>top level based on vasz to support concatenated pages.

Yes end_index setup using "derived vasz" is exactly what I was referring
to earlier. Basically KHO stores the order of the folio, so we can look
at the order of the top_table and that should give us an idea of vasz?
Even if actual vasz is less than the one drived from the order of the
page in next kernel, rest of the page should be filled with zeroes, so
iterating through it should be fine?

I think to keep the scope of this series limited and also to do it in
the proper way, I can save the vasz. That should give us everything to
free and restore in the next kernel without introducing too much
complexity and ABI right now. We can put in more functionality with
subsequent patch series to handle other usecases. WDYT?
>
>I don't think sign_extend is used in the free path though.

I think it is used in the pt_all_range() during free to calculate the
range to iterate over. Based on the sign_extend it decides the vasz and
that affect last_va and that affects end_index.
>
>So if that is the only purpose then yes you can probably get away with
>nothing, but you have to be very careful to contain the restored
>domain to only execute free and nothing else by removing the
>map/unmap/etc ops.
>
>And add some dedicated self tests (zero pt features and test free) to
>simulate it.
>
>Jason
