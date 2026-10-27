Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793125451;
	b=BqVJo6exAQmoZ0MLUD30M309tO4qJdGdT6o7YT0hvgmPTYnHdebWjcwt4GBBSRG1fZdk
	 AwE/86DsMIePxToiVkk5iPlBIeJJFxT/N/fw8g6V2Ctjm9clT+J6wk90YdKlFgtacEd0k
	 2pS2jZaxEIny7uRje1LO+HfEowvorUkslBT26MgDq17yoZdTPhvRMh4yQiRZp2BLq9sqX
	 aw8Fy6zFQq57Qv9k9NOyeILA89F9RWXbc508GwM0pY/RIzkh7ebzaueNu3jn3X6QA+JPl
	 HUortAQaSWtUecSJCtH1o0gXczlNaoZQ0JSHupZFuB2CDHKTDgQ53Lcl2RIvi6jdWKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793125451;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=rmQe7Ula4v4xxvuT1NOaOZn21ah+mRjIqg1+qIFQci0=;
	b=ffzbA5pY9+E6vhOYjcZ+ltIkxbcbj1OqVeFgsbBrGDio58hJmPyWNbkY/KVqTlQSkWBa
	 BUhjyOwk0g9mN9aOpNn61QiRX1PQ7mj8GXnM9A2vXFObuo7RI7XiFLccHIzvLVqFvpthM
	 tkQyDWOE6RuskaKsi5HqKuSvSjhb2VYtQ/C6D/P0yoEVZBXsgopEPRabd42y7xxq400KU
	 bSPzAgYWD7ZqsxtGm8WnqP+/6ZnmILJH1fARlZZY1XgxmL8h7GLzeTSVetRRWdgAegdgG
	 C2npHj3Vyce4kk4uGdevr56Bk4F9L+BXbluP7Yn2VAbeiDNPhqVXeOxXpdH0g3XIJ8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=mS+V2LEE;
	arc=none smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C50606A31A
	for <iommu@lists.linux.dev>; Tue, 27 Oct 2026 18:24:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2C50606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=mS+V2LEE
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5351d76e1baso1550811cf.1
        for <iommu@lists.linux.dev>; Tue, 27 Oct 2026 11:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793125450; x=1793730250; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rmQe7Ula4v4xxvuT1NOaOZn21ah+mRjIqg1+qIFQci0=;
        b=mS+V2LEEWsYyr/qENaH/HtYZpXVKe5ozzWYYN8IIGSwe5URxXv2eo/5KspvxRUFd1y
         MSYPEVK1SEK7QSNDMJI0KD/dMABhBX6AwivAf2lkCAXXT02/vRvQs86S3qvZc+3HxjjF
         0CUTCFjEu0YJsrfpYAZJhVT+ekaCn6TRkep6edfWrrfSAb4iWR47Ev4WGtInRhtyin8/
         0C7D2OvrtEUnsgXQEtWPz47rUnNmCiL3dW9ZxQ8aLvAMwP3i3fnlG2KbdTdj/Th3SAnF
         ma30T3Qap5ywZpaWgivA9AmKbpNlnfGpdiGa1a4qaXc+0RtyxklAAeuLmQUOkzq4kefL
         Q03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793125450; x=1793730250;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rmQe7Ula4v4xxvuT1NOaOZn21ah+mRjIqg1+qIFQci0=;
        b=XF7w1GJV3l6TNHzRQg5cqCmhUUmQNBi0f9g2/0wp40JWpQNAHJk1CMbultuWJvxrR+
         J9wWDq9bGda1jjAksO9Fd/wWP9Zy9a/+l3aZzYCG4zrBSG80iMeYMKsJ+6Y0yf85aHvP
         SC5UXSseGnFx5yjEB5LAMi9131WyM5/GJ8XLEC0LvaME/sY4MrbI7AkqCQQrSrBbvTKj
         bsBK3eQYwnlqfes59BF7bSw1MYGgFb2G5h690jDTm9ELqqb79k8hGmjbFY1vnr/c0WVu
         9ps0ySBoo7WM78xPGNMI6XQAxTR3XrNOst72v2CvpUUS+InqRffFpRBhhN2sawlxFhzo
         yRrA==
X-Gm-Message-State: AFq9FYL4CTWxvtTIto1gMx1JNkzksrH0AZk58OmMaJck+MykCMTW77Fk
	uWpjr3dm0izLSqr046+Zac+gerzFK7EVZJqKLotZf6i/UPWO9t9lr1zRtY1C00XeMvk=
X-Gm-Gg: AYBFou09KDTVcp3B8nv9w/14AzmR6hFboKGyELFRFnJmgMOEVtbNdGm+tgYnzjbEXiU
	4oEDImfwEzt8kymJ8RfdNlhYb0qkB6eDBUDoi2xJ38q13dWbdukLq80dJTOAA6TMIJCV+S+xGdH
	Vup5DbQBYQ5KI+2W5Bf1e4mgsKzWUHa5xu+NitIIu/C5AJAt6U1RSBEWlBrH9IukqROHfKz2CH2
	k9aWxRio14nJoRIamwsVSPxL7/UNs0SGjM/m8ltua1OXpeK61IXR6YtpDx5y0bv7L9AKgRscp/F
	pGv4a3YrNTr3WxK0+TuEDhBeL6iyYt24IZzSRM0fI/40kXP0XPLeYxJkNgo+8GJGYgbBqMy7W92
	dmHmYk+lnYx7neqXagDpUuHY676y5DYJAB7E4O1B1+ZhSqyJZLgu0ymYLsb46BB/mkRk6OsIYYx
	u3/f+O+h2L/tAPoonG5/UUw9rAObVVs+OqjBcu5tQ8qdQGHKxxJEbzCQW8eeIo/FiBpyh2HUXBp
	5tThaeJkQrRE+cI4Dg7H2ToLqiWkFlaRnYGdto4FMwkNSijU99xxq5O2RgIWs0aWJHwRnOWphX4
	AWlwyD94Og1cK5kcZgaPCZ15sheFdE56f8TpD5nazBsqHrXJMARy+y2QS/s=
X-Received: by 2002:a05:622a:164e:b0:535:1740:d334 with SMTP id d75a77b69052e-53fc8cbcd8fmr2200051cf.3.1793125449903;
        Tue, 27 Oct 2026 11:24:09 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-538394c5264sm85971001cf.5.2026.10.27.11.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 11:24:08 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xLlqB-0000000Afi1-2Z92;
	Tue, 27 Oct 2026 15:24:07 -0300
Date: Tue, 27 Oct 2026 15:24:07 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
	Max Zhen <max.zhen@amd.com>, Liang Wendy <Wendy.Liang@amd.com>
Subject: Re: [PATCH] iommu/amd: Remove iommu_group_mutex_assert() from
 amd_iommu_clear_gcr3()
Message-ID: <20261027182407.GH1685504@ziepe.ca>
References: <20260814104029.71021-1-vasant.hegde@amd.com>
 <20260817135155.GB1415075@ziepe.ca>
 <d5e053c4-34d4-417e-ade5-f7f461f9e426@amd.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5e053c4-34d4-417e-ade5-f7f461f9e426@amd.com>

On Mon, Oct 26, 2026 at 06:29:39PM +0530, Vasant Hegde wrote:
> Hi Jason,
> 
> 
> On 8/17/2026 7:21 PM, Jason Gunthorpe wrote:
> > On Fri, Aug 14, 2026 at 10:40:29AM +0000, Vasant Hegde wrote:
> > 
> >> Remove the iommu_group_mutex_assert() call from
> >> amd_iommu_clear_gcr3(), since PASID teardown via the mmu_notifier
> >> release path is a legitimate caller that does not and need not hold
> >> the group mutex.
> > 
> > Why doesn't it?
> > 
> > Right below this line is:
> > 
> > 	gcr3_info->pasid_cnt--;
> > 
> > Which certainly needs the lock.
> 
> yeah. I overlooked it. Its part of dev_data and domain lock is not enough.
> 
> > 
> > In the ARM driver this async release notifier was pretty tricky to
> > lock properly. It just updates the equivilent to the GCR3 entry to
> > make it disabled and doesn't touch anything else. This is locked in a
> > way so that concurrent domain detach doesn't face any races.
> 
> How about sva_mn_release() path just cleared GCR[PASID]/flush cache and then
> iommu_sva_unbind_device() path (amd_iommu_remove_dev_pasid), decrements count
> and removes pdom_dev_data structure. something like below?

One of the considerations here is the release of the SVA should not
trigger errors from the iommu driver if the device continues to use
it.

Every device access should continue to be captured as page fault and
run the SVA page fault path. It will naturally end in an error.

Not sure this:

> +/*
> + * Disable a GCR3 entry without detaching its PASID from the IOMMU core.
> + * This is used from the SVA mmu notifier release callback.
> + */
> +int amd_iommu_disable_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid)
> +{
> +	return update_gcr3(dev_data, pasid, 0, false);
> +}

Gets there? Or at least explain it in the comment?

Jason
