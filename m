Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2A643C06B
	for <iommu@lists.linux.dev>; Fri,  6 Mar 2026 19:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772827180; cv=none; b=cFvKkyk+p9qJmp1x0XL01ZmGcoO+Xm2EWdt+W0RPZw1ACLc2UzhqJiGASWt1Du+ivRnU3LgdcQTVBZ+wXE6BpwbLgbgL+co5dbaK5vCOU7fp2Jdo3NrghTMvKvzpKtL6pY52yaWt03ObSNrlPpfrl/LyqBOfdOADfDL7pzDW6Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772827180; c=relaxed/simple;
	bh=945rH/e5rNYp7DXMDC1/KmZIttMnGVuMabmAVl9nIC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OCYUra13bJsekYxkdGQHOVzWvXLUCz19VDNxHHBd6QPao+t/jb6bpcTZICYBDEO7VZNBCPDJR9brzdofsNRKNL997M1hls5Y7UAIuI+dBvuWu6FdByiFDRM3bETZ4Ospgb2sagKORt8gEOrpehXZYByWB26lq6awCZ8t0Aj1B8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pVEn6fYW; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pVEn6fYW"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ae523d54d2so11485ad.1
        for <iommu@lists.linux.dev>; Fri, 06 Mar 2026 11:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772827178; x=1773431978; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=945rH/e5rNYp7DXMDC1/KmZIttMnGVuMabmAVl9nIC0=;
        b=pVEn6fYWjhpcA2NfFaWEnHVMy45kqEpmX8HflIlPSw0F5ATPeAxkKaK9TiTXgGRLBv
         Bay70o5zpWCMBE76HqRWVGB3yssqh9q9ccGwBNHJoLMJVD970HHdtNFThX6XIU9qSeG0
         S8jMe2O532VTji+mVE6WOnqsAYEmC29GTplZccqxdSPcwI93595N6B4kqtfHBbcqVyFx
         37bQmZ2ygCSKRmRAQ7wm4/Yu36rcI0p2afcXDGhWBG757EHljk+YOpddqd6x4MdZXLVT
         gtw1AlhZfYV6/35lRa76CK3OwSy97hKgRwJesBEs4uWowdn9Y6VLGMQNIxnCvUHD7WDp
         mfQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772827178; x=1773431978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=945rH/e5rNYp7DXMDC1/KmZIttMnGVuMabmAVl9nIC0=;
        b=qMU4jF4EFGots7teCSz5C1CuhhunAd57o+TgDvKpx9U7DdVkZNyYXFuzqD/CuTiND+
         pQuF8lc9dkIixJqohsTA6+0ucDiQWIso5MvOjxR6ozI5S0NelvDL3CJlk6Mr745gps/P
         gQ21lE5ozQYrLBGNbeKov7VdZLwIxDRIzTw19NPVed5JKSqS3s3Lft4x7o8GjWlqslkR
         BI39PRdCrpJfiGIC3Rz9yhxqz3MBosoDT2c5BmKXu9wy9k7goDvTGMwuQTIAQvt8QMzW
         raZ/5WSYcFOKgGXCtjOvEpddgJouagG+QO0zjVHq3xYrf03/inWxFKXVYvF7uX5W3R1X
         FEpw==
X-Forwarded-Encrypted: i=1; AJvYcCWxXMdd30fKf9hmztK94Xxc6WddSGNKIA/zDMmrbd42yDl4rLXAOtu8vAIDUozXrPkFB2Qlsw==@lists.linux.dev
X-Gm-Message-State: AOJu0YycF8wV4xRCX4Ml6bCGQOTyz0RBZXXtEUZ7QkUuaYFCk+u/Kiqg
	hGv2/jsUmUFlpWOyCfOTPWb1o13tV6Lye1BXMs5n55UcAoqR5YVFGrqQIS34ZSYQvA==
X-Gm-Gg: ATEYQzxPHg64i6v8/kfKoZOb6XrBrgcaI/80ApU1fzBeeHJMoEDxO2+aE2lD72WzyXG
	xNjANjUMxYm/mWl89ovPjftydNuVB3a1wJdB1veQa3nyxmFryTXT0KbscD1fG+EGxxU17jCuedP
	/XVazjhFTarCZ/c8e66w6NH7o8WV8TFx6viPYnWQtWpy7RvoLxh07VVr0XQhT36QnB/WGdtdQQu
	K2ugabcPCVu7zPL3zMmSo8F8FdxCtPMn98PodawdCOtNqYfYL565/1jcQW2dCVkdc3jDDDL51iW
	fOqw+P4COyflE9TscJVVey3P+rqknfA8VDyPv8fMLKkNwb1BVbX4PuwqsP4ynBOKJoGkIRFAfrC
	btTcSQ344v69zFxxAhV9zKdhb8w7cnuzOSrlrmX8CB4NmwhcST3h9ZxmYBDlFLxpMUww3PEc51U
	cz0ZsZBne1cKOEYDfIT2vCzzR5Ifiikb07NIOa4MwRhPrnvhWbAEx2sW2S101P6w==
X-Received: by 2002:a17:903:2f8a:b0:2ae:575f:3755 with SMTP id d9443c01a7336-2ae8ad8939bmr404865ad.20.1772827178041;
        Fri, 06 Mar 2026 11:59:38 -0800 (PST)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae840b2130sm30703795ad.83.2026.03.06.11.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 11:59:37 -0800 (PST)
Date: Fri, 6 Mar 2026 19:59:33 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, 
	bhelgaas@google.com, rafael@kernel.org, lenb@kernel.org, praan@google.com, 
	kees@kernel.org, smostafa@google.com, Alexander.Grest@microsoft.com, 
	kevin.tian@intel.com, miko.lenczewski@arm.com, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-pci@vger.kernel.org, vsethi@nvidia.com
Subject: Re: [PATCH v1 2/2] iommu/arm-smmu-v3: Recover ATC invalidate timeouts
Message-ID: <aasv1HYOKuuJyi1k@google.com>
References: <cover.1772686998.git.nicolinc@nvidia.com>
 <ca7ab934bf0f433b62a5c15d42241632c4cb9366.1772686998.git.nicolinc@nvidia.com>
 <20260305153911.GT972761@nvidia.com>
 <6416b7fe-0190-4c7b-9a62-5da7d5eea794@linux.intel.com>
 <20260306130006.GF1651202@nvidia.com>
 <aasmWvA-sqi0KJwO@google.com>
 <20260306194312.GL1651202@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260306194312.GL1651202@nvidia.com>

On Fri, Mar 06, 2026 at 03:43:12PM -0400, Jason Gunthorpe wrote:
>On Fri, Mar 06, 2026 at 07:35:19PM +0000, Samiullah Khawaja wrote:
>> On Fri, Mar 06, 2026 at 09:00:06AM -0400, Jason Gunthorpe wrote:
>> > On Fri, Mar 06, 2026 at 11:22:52AM +0800, Baolu Lu wrote:
>> > > I believe this issue is not unique to the arm-smmu-v3 driver. Device ATC
>> > > invalidation timeout is a generic challenge across all IOMMU
>> > > architectures that support PCI ATS. Would it be feasible to implement a
>> > > common 'fencing and recovery' mechanism in the IOMMU core so that all
>> > > IOMMU drivers could benefit?
>> >
>> > I think yes, for parts, but the driver itself has to do something deep
>> > inside it's invalidation to allow the flush to complete without
>> > exposing the system to memory corruption - meaning it has to block
>> > translated requests before completing the flush
>>
>> Yes and currently the underlying drivers have software timeouts
>> (AMD=100millisecond, arm-smmu-v3=1second) defined which could timeout
>> before the actual ATC invalidation timeout occurs. Do you think maybe
>> the timeout needs to be propagated to the caller (flush callback) so the
>> memory/IOVA is not allocated to something else?
>
>No, definitely not, that's basically impossible, so many callers just
>can't handle such an idea, and you can't ever fully recover from such
>a thing.
>

Agreed.
>> Or blocking translated requests for such devices should be enough?
>
>Yes, we have to fence the hardware and then allow the existing SW
>stack to continue without any fear of UAF from the broken HW.

And this applies to software timeout also I think, since both have same
end result.

I am working on a series to solve this for VT-d and testing it
internally.
>
>Fencing the HW means using the IOMMU to block translated requests.
>
>Jason
