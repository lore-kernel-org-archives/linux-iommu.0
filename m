Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FEA37649B
	for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 22:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776984203; cv=none; b=RvRE8lyt4P4konGS/z/0Av018cJpopxZ/W5zyFea4VMkfGBmQ0aGUJOkqIRwHvqpAcNhVd9BwfZRXRApVRxHCOAnV0Qfn0zcTiNQgz0qCDBrcgCs1Rvuks8CFODapfmS73p63d2lQp21Elge4u2xBvWlBTieCz+tTk37JnTWE68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776984203; c=relaxed/simple;
	bh=CBu0C4Gbw+eSGJTiQmDn0Va7Mzdh0sn3nL6uhqMgdYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RA72qPfpaRG3a9WqJIWT0fMWsuZR2GU9LjPHYJyZgCgYbHZkM7ZEScU8fqUOwvJVrwGED2/gQOeaHnMW/I2LMd0gKk0VzM5DfDpWpY6+CcxMauaq687fu1XpdR0DEqUc2k8OnDBarSXze6lCSiXxrQtnsVMYyBvjVsZJ4Iq7tDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=l10uGW8s; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="l10uGW8s"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8eea23d01f7so192856385a.0
        for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 15:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1776984200; x=1777589000; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/T0GTDRuU/Ml1Jl3QzhDeR+2ndhb6qBdCM6HZ+ROdk0=;
        b=l10uGW8sVZ8GA/RVM9bHlmnoNVIRO4fesH7ENC7WZqX28+xQ6lA9OTdNSun1R92Np0
         kz/05V1SXajZZZ2aoiHurnL6F/2r279b5Xobm5UU+UiV/N5cCHihVD8MEfmVtMy3EIv8
         Sn/eOTVo4/FZP3e6A7/jJ0xLZiHp0szU47ex2SRqK8a4TEJrGwsnud+crNTbLf6F3gAE
         bEEDXoNlVHVfFB1pqh1D6PWGIZ/yHTlpL02jpEuxu3YU3DomtF5hArDtS+fvycYcqzDH
         2spQ4F4p9BYHvQDTrEC4oBOEr4s2bowiwYIaksYQ3nfiV5nl2vpUprNowrM6fqlebtFl
         vovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776984200; x=1777589000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/T0GTDRuU/Ml1Jl3QzhDeR+2ndhb6qBdCM6HZ+ROdk0=;
        b=njZu9m78vHc6LwB7CRnd1aLQMOVgQXJJBsKlJSPxzYLlGB8+WQ4x1pyq+euIUuC64z
         G74BwfGdkxPvgW2rX6DfrQ2tt2FhMdXdgqMcA4JOXekwqXQTXpvPxBlRWTjB5iZB8XgB
         fNyxhTA+Z+1t4utN+cL7q9oOMRMwtFT5D1jRxlYi7mpsItAk5NgFPlmubpfIaxKiCC7h
         2mNIqg/gKIgmWOV7dUAtsJkkuuWyPRnts4kAtE2/Q4EKT5Qe3elQvjIRWl4QMlIYkW5q
         O3GHPR3CBnPw4MyLcd9kdSGe9jhPpOqaQCavEbzAOJP954hEy6spBZ7NmsiIHPW+6z+r
         goLg==
X-Forwarded-Encrypted: i=1; AFNElJ915AqdTCRzEvRuIY+3Klfx2vGw3T47IEnG9oLAl3bV+py0wSK++hqSTLahD1ngyiDe5EVT8Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzistgbBx+9gSeK2Gqhr3kGZVOG1L7R+UnisKNrP1mHv+PsUjtf
	sTCw4ZFVKCirfyT8DlPGmfi5BmOCkWizIlYGswUMt6vdrPZqLFRrWFupnxykJO/9waM=
X-Gm-Gg: AeBDietTGKkHYY8oYGNn69BgesbxjTBS+FPH62DResMMoz1Zkr4GkkxpgRZrfIf+UA4
	+Ect3EfY6CQTKCshH6e9dfeww/GG5S5wuoP5P5GIE6BPZuDoW/w3vNDO93s1ZU37QS4EuU1Rf+z
	+gikaO8Ahesjg6wo39efe3hN5cX7j6WzK/veSIDmaGSLbSmbZ/egJAqGrkAl0x05+IWA9uJB7W3
	MDSojtu4MFAgT6W8+nC7IKYq5Z8iE7vghZmqGNhRE7++GF19HyH3e/RQmTQmEqtVPJ4AuzOV/mH
	4PjVZ7Rpul332JD9d6Qofh/n+f6Iu9k4f5NLdwlo95pNn6rg//19VsZDv44huP0DYUEgGUKxF7p
	QFPFwFYnFZgNje4rWdafCk1ZaRxN1aI/H2THAimF26+ubgj+uG/g4IvKHGIh8zaFNeJPTM0dn6l
	9CJcYZ911sBpCeoRGShh5MGf2KMPk5Qi4sjoFvyOoSxJH7stOZfy7BKHx3it6ZpNCsQHnhBTexE
	kXADYYobnT2BHQ4PYg4PFeQ0mM=
X-Received: by 2002:a05:620a:3187:b0:8f0:7516:da99 with SMTP id af79cd13be357-8f07516e40bmr1047695085a.60.1776984199901;
        Thu, 23 Apr 2026 15:43:19 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02aec3a3bsm169316686d6.49.2026.04.23.15.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 15:43:19 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wG2lS-0000000GLHD-1ruw;
	Thu, 23 Apr 2026 19:43:18 -0300
Date: Thu, 23 Apr 2026 19:43:18 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vidya Sagar <vidyas@nvidia.com>
Cc: rafael@kernel.org, lenb@kernel.org, saket.dumbre@intel.com,
	lpieralisi@kernel.org, guohanjun@huawei.com,
	sudeep.holla@kernel.org, will@kernel.org, catalin.marinas@arm.com,
	joro@8bytes.org, robin.murphy@arm.com, nicolinc@nvidia.com,
	praan@google.com, vsethi@nvidia.com, sdonthineni@nvidia.com,
	kthota@nvidia.com, sagar.tv@gmail.com, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, acpica-devel@lists.linux.dev,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1 1/3] ACPICA: IORT: Add Root Complex PASID Flags field
Message-ID: <20260423224318.GT3611611@ziepe.ca>
References: <20260423191417.2031652-1-vidyas@nvidia.com>
 <20260423191417.2031652-2-vidyas@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423191417.2031652-2-vidyas@nvidia.com>

On Fri, Apr 24, 2026 at 12:44:15AM +0530, Vidya Sagar wrote:
> The IORT spec, Issue E.c (ARM DEN 0049E.c, January 2022), bumps the
> Root Complex Node to revision 4 and adds two PASID descriptors:
> 
>   - PASID Capabilities at byte offset 33 (2 bytes), bits[4:0] of which
>     report the Max PASID Width supported by the Root Complex.
>   - Flags at byte offset 36 (4 bytes), bit 0 of which reports whether
>     the Root Complex itself supports PASID. This is distinct from the
>     existing ATS Attribute bit 2 (at offset 24) that only reports
>     whether the RC forwards PASID information on translated
>     transactions.
> 
> The ACPICA struct in include/acpi/actbl2.h was updated for the E.c
> PASID Capabilities descriptor (offset 33) but stops short with a
> trailing 'u8 reserved[]' flexible array, so the new Flags field at
> offset 36 is unreachable and the existing ACPI_IORT_PASID_*
> definitions have no consumer.
> 
> Replace the trailing flexible array with a fixed 'u8 reserved[1]'
> followed by 'u32 flags' so the struct fully covers RC node revision 4,
> and add the ACPI_IORT_RC_PASID_SUPPORTED mask for bit 0 of the new
> field. With #pragma pack(1) in effect for actbl2.h, this lands the new
> field at the spec-mandated absolute offset 36.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>  include/acpi/actbl2.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

There is a whole process to change this file, I went through it once
for canwbs..

https://lore.kernel.org/acpica-devel/2-v3-e2e16cd7467f+2a6a1-smmuv3_nesting_jgg@nvidia.com/

You have to make a pull request here:

https://github.com/acpica/acpica/pulls

And then use the 

generate/linux/make-patches.sh -u <commit-id>

Script to make this patch for linux in the perscribed format.

I think, something like that

Jason
