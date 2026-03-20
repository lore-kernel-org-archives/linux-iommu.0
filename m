Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB1722156C
	for <iommu@lists.linux.dev>; Fri, 20 Mar 2026 00:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773967251; cv=none; b=LDCy/ijqBq2OMR90Yea+WCmZaSDN6q4kYOysLPVEWN154vYf5EE7KjO7jpNWiDAyR158UtvHltP/uQBql6gpMDQYzIppTTw6jCGTHgHqXPH7L83NQxV6DHiz4S8ghDYenT9ZRTDAbRF8yUvzD+jwFTQ4TEnOuKbFr58VwVkTuj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773967251; c=relaxed/simple;
	bh=neu/OaclnBTY+LKMUcCOPstS/nZ2GgZTa3D1B2uI0gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7VldX3wvGBWrzvpaDQri3Bwn6f/5A+f2bVkDSbWBa3OmAjsrLR0bcWcSsHd9705pTG+va5kt15gcpJxCL5YcjJBTm12p2TmE2QLmRW9PssDZOeW+xxpqL8zaf5staVQAoedWaLGjWeiRVhe1GegIoYFOAncNbbZRAD2ub9iZVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g9ZjoEVE; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g9ZjoEVE"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2b052562254so43995ad.0
        for <iommu@lists.linux.dev>; Thu, 19 Mar 2026 17:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773967249; x=1774572049; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+vcw45TyfehW1ilqcx3lIL5BvMalHuEfy220A2zjHoI=;
        b=g9ZjoEVEaraJh43/BYUheBhg52xPHI8q8L7PPI11YTVrwdMSlPRgDmsusolc+fu+SH
         vGx51sy0+sLjTtzM31CRmfesl7GMGZkcCmfqZa0sa6unp7KnoBSQj73m3sFj3bkRi3KD
         uCorMURbu12flqoc4rMrucP2ATP0IMYE/PqRo3Rk9Xbsv1jvmI3uPWvykz1+foQrfllr
         e1O1Zf97HNxz0ZJKTl17e4ZhJsf8xzs5+QPD6+YRKQ2973W5gUCKRcwywI37qwh53g5E
         wm9Ir14eCn5qZwJTol/l45pFeKn/Jd14HQSpftpYlfW/T7LJFcvF04XGcQ80DV6wU2Ym
         6LpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773967249; x=1774572049;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+vcw45TyfehW1ilqcx3lIL5BvMalHuEfy220A2zjHoI=;
        b=G1T6mYwAJDu8T5DAa7AaW9QWjTcHUvOO/yW9WpXu8mHXmfi72rJrl2YOJBuoWzbxOQ
         Ks0xrssll6vVrsF9iioNAWzIWjHkYnVJhHbfS9CDVzgOGHmbgrSbpH3VovcLFf26wm1y
         M1oWHB2Hx9PgGNNbFy2R4RPymPeFFq6+zASRim/3xeSQcBuS0/muWsEjCQcyY629KiMf
         KhHSSJhk8rRVCq3x677UpvS2Qd6gW376i+P1Fs2SkUyXfevhOTT2uzpPautmu3Z2Hir9
         oge9lIXekoMx0gCg9baijKYehaXzi7OOLGIsJOKzw/AYuqdP6Nm/47I4U82PfwEfVaCZ
         aB6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVz6VU3JsH79U3ns7OXICcZ2PhLV7SzKZ2ypKEdoCaUB9T4GaobiQ9t6m3pNy+ZwROcoZwOHw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyWM0Ir6udQvaVNJtTrkp4be1dNEs8qnPpBzS1D0+65tD88wLyv
	LvRbEV8qrZdF3LlYcV9o6Mr1ChXY/oaFk708h7y07k4n66LJVmvF/r9DYdQIsHTGUQ==
X-Gm-Gg: ATEYQzzCKPGXrwfeXWs59L8SRTBTVmZnqgyC3Wsse3TDaSIIo2JIX/E+TaPVLYmSLfK
	AjzEniHpq2ULL1eVRQD5tCq/ksNNYqKYLgT4b03c3TjuP+gXgm4+uP+r6gLdUbO4G1lgaLXqFBC
	56c0XrMiIqxdFPbo5hO6E1AQmC+HlfoQbZIN9fBY42uzohJ2c0MEG6MRyGSp+OvXuPEu1ET+JlK
	KK7mcx40QgG3qsLbxuud22B5WIZzFZ/jr3vQEwQp4H0Bpg7tFG4miKlpmgaNdFJPipPI2pXh3bT
	mBDYVd7OOQnC5qB/x4Q/5vsnOoeSwqWKPN3i+GS3ulvYbg4Fdnl+54sbK1EImZhGlGxcczjOwvw
	aTrW2tLkhobqMv5xUW5C+e6w4CXsFSIrI323UqV1x8bQjKSsf/PttP7gW3e8mHiP8eBcEiW2Lss
	ZnCoD43P4NcmPgmIB7yhWS3jWOQ9FwUlOlGUtOfxyab8hOA8KGMq/b1LUsHaPiuw==
X-Received: by 2002:a17:903:3bd0:b0:2ae:80a3:98a9 with SMTP id d9443c01a7336-2b0836fe6aamr851315ad.11.1773967248605;
        Thu, 19 Mar 2026 17:40:48 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c743a814548sm424719a12.9.2026.03.19.17.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 17:40:48 -0700 (PDT)
Date: Fri, 20 Mar 2026 00:40:44 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Vipin Sharma <vipinsh@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, YiFei Zhu <zhuyifei@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Pranjal Shrivastava <praan@google.com>
Subject: Re: [PATCH 10/14] iommufd-lu: Implement ioctl to let userspace mark
 an HWPT to be preserved
Message-ID: <abyU3g-ta6Gg6kEx@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-11-skhawaja@google.com>
 <20260319231331.GB3983821.vipinsh@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260319231331.GB3983821.vipinsh@google.com>

On Thu, Mar 19, 2026 at 04:35:32PM -0700, Vipin Sharma wrote:
>On Tue, Feb 03, 2026 at 10:09:44PM +0000, Samiullah Khawaja wrote:
>> From: YiFei Zhu <zhuyifei@google.com>
>> @@ -374,6 +374,10 @@ struct iommufd_hwpt_paging {
>>  	bool auto_domain : 1;
>>  	bool enforce_cache_coherency : 1;
>>  	bool nest_parent : 1;
>> +#ifdef CONFIG_IOMMU_LIVEUPDATE
>> +	bool lu_preserve : 1;
>> +	u32 lu_token;
>
>Should we use full name i.e. liveupdate here and other places in this
>series?

I think using full name liveupdate would be too long in other places in
this series. And also there are other examples of "luo" being used as a
short form. Please see:

https://lore.kernel.org/all/20251125165850.3389713-15-pasha.tatashin@soleen.com/
>
>> diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
>> index 5cc4b08c25f5..e1a9b3051f65 100644
>> --- a/drivers/iommu/iommufd/main.c
>> +++ b/drivers/iommu/iommufd/main.c
>> @@ -493,6 +493,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
>>  		 __reserved),
>>  	IOCTL_OP(IOMMU_VIOMMU_ALLOC, iommufd_viommu_alloc_ioctl,
>>  		 struct iommu_viommu_alloc, out_viommu_id),
>> +	IOCTL_OP(IOMMU_HWPT_LU_SET_PRESERVE, iommufd_hwpt_lu_set_preserve,
>> +		 struct iommu_hwpt_lu_set_preserve, hwpt_token),
>
>Shouldn't struct iommu_hwpt_lu_set_preserve{} be added to union ucmd_buffer{}
>above in this file?

Agreed. Will update.
>
