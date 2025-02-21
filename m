Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D801FBCA9
	for <iommu@lists.linux.dev>; Fri, 21 Feb 2025 18:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740162421; cv=none; b=UzWq1gpMGzd1rpGekKm/C08Qcrx1b2Xh88eQzgCuL7WjvP3oO0bzm3Q5LqerRNZfD5r3vpCh7OqW+gcSz0Gny4Dokdl3Od2mmMNHcVNbpwU2nc4sx/js/1Bi41BgVkX/ATTx9p9BUkG3smp9nWtLHSXywieATzeY45pAr/WekoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740162421; c=relaxed/simple;
	bh=x7mvX8+YXRBqkvS5jquND3ZOGEPBEtrQupQnDXQ125E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=SgCtUEil5+rJTcQK7+X8qS7//wJNo3C9nKgU6m9ufB9mZiv4lh6PNA/VFejEWlQBLPxnnhyID3JwQiFHNkmxH5DqqrwmDDSAXSHiwim0L0n7mHdeiYwJD6ZA5xeNx2loacMcNgS/NY0tk1dSt20hHQrs+VgY/yuNJTC0WOGC9Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hw7jsvXJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hw7jsvXJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740162417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FLMs7KrtcVuRMuZVLzEEuB9e4YSYJnSqUxaU4NJOSyU=;
	b=hw7jsvXJgSqf64zyTr6YAUNbVn5b+/IK5eMYQZg26mC5jlhq3IScrDh6llj7NnhU6VuKiW
	z/nRyk+/2zqimZR9QvRb5Mn8hHWaaGEFtSscSsviLa/bpu5OH2dyvj4vCGp6vMBhX0pV2S
	D4Oj+vpyBjNbxgvbrl+xvc9Pcoos9wo=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-d02SAcfcORar3QMxhd1d_g-1; Fri, 21 Feb 2025 13:26:54 -0500
X-MC-Unique: d02SAcfcORar3QMxhd1d_g-1
X-Mimecast-MFC-AGG-ID: d02SAcfcORar3QMxhd1d_g_1740162412
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-5f6e2ef3190so2213151eaf.1
        for <iommu@lists.linux.dev>; Fri, 21 Feb 2025 10:26:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740162412; x=1740767212;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FLMs7KrtcVuRMuZVLzEEuB9e4YSYJnSqUxaU4NJOSyU=;
        b=wQqcNSkPN2tPjtQapm8SXV2hMq9uk0/p+lx3hizZcZ4pmfnUbXkHCpAYsFiggawb5Y
         QJAAgy6Lh0B3GfsJYawFPq/+/6dYvZ3w56iwdo0ZnWjIlCp3SlOY6HHZfv2CauA+TNIO
         B4HQw8zVcrkhLJhf3TDCH+hXsUKacXzbpushZvozx7rtnpYMs0w/Hldy2Y99QP/4/Z1j
         LR5GGfiM+0pigDik1dF2Y6sFbHnACuPVeJYvo4X7QxD3zjDMeQjA0GzOmVXV5kuFyFP2
         nA/OqWiNzV5N7knDJQ9MjCyVIpnGzCgDg7Y/13rln3j1wrG+sS+tRVDnLBiUNeMzfkCf
         NyNw==
X-Forwarded-Encrypted: i=1; AJvYcCVRp4e5bcgizL13sPHmKi/zMi5S0IXBT+bQJTMWiaBqyFrDbcJ23L/CdyNID0uITzy3cUhUNA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx4lZ+1uQvAqYk983P8lZ7IgMfMivjXlLYX/PuSLwSnXkd4mIaZ
	h4td/j4DuqtOIOkfg0sG4RrgOQ5+wQAIE2QQYgbuQjnO8/NKY6dl/ZuUF129c+3UPljN9K+fIMZ
	jWmXPmyS3aSxa/z0pjNvCuj22MDYa9/wCNGXJcXJDdkaxXH9g2WRt
X-Gm-Gg: ASbGnctjZQaSUNayNMawGrj1eb/ogR3zv1TLPbhvOCROCn00lgUldCqie7FRJw99utT
	IXQYKkMFYq2I4ib8w2Pl7Ys9moDstIPDFDnbTWLPtAYRokqLKCyY5vb6XqAhdjW+79M6Mh9ZLBs
	LibazIFja+8fPUwg07jliGJUcsHeNO6h0/sk0j6p/MELhevJdXcNMIOSkPaP5RJ3J405UDcH79g
	C95YsRTZD/CRMZ99VeOPCwbpkyTie/vMIDxsttLg33wk1uCSuJZGDnTL6a/EDfydaIXbKKav/EU
	foaJlGJV4nyht3UvrjDq3YECPOGKsO06exDpyVPz60Qd
X-Received: by 2002:a05:6820:3284:b0:5fc:f02e:a7bf with SMTP id 006d021491bc7-5fd0af6c89amr8396325eaf.3.1740162412641;
        Fri, 21 Feb 2025 10:26:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3a6bIdtzk0jphwQ89Cl0jmjU5SuuvuMlmEJW4bIcbaKaarXMb40kTIk7SnjrTlZHnr7bgjQ==
X-Received: by 2002:a05:6820:3284:b0:5fc:f02e:a7bf with SMTP id 006d021491bc7-5fd0af6c89amr8396295eaf.3.1740162412249;
        Fri, 21 Feb 2025 10:26:52 -0800 (PST)
Received: from localhost (ip70-163-223-251.ph.ph.cox.net. [70.163.223.251])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fce7eedd67sm2311357eaf.30.2025.02.21.10.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 10:26:51 -0800 (PST)
Date: Fri, 21 Feb 2025 11:26:50 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev
Subject: Re: Question on context setup for passthrough
Message-ID: <v7quonl2qcsweqd4r6e2badd6bdhmzgo4zm4v2k3bxkg4zkffi@zpxi53ai4qme>
References: <rz4kc2zxi4fritsbmjsa3ekqncguvnmeir5se3fhu7pzhtgipk@2u6ps3q3gsqz>
 <75f4867f-99b9-4ba9-abf4-f0dc29d08fca@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <75f4867f-99b9-4ba9-abf4-f0dc29d08fca@linux.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nwCXSmKDCbik8aEEhL6a0mNlTaiWfWR21CWBg6FBS7Y_1740162412
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 21, 2025 at 04:40:42PM +0800, Baolu Lu wrote:
> On 2025/2/21 15:16, Jerry Snitselaar wrote:
> > Hi Baolu,
> 
> Hi Jerry,
> 
> > 
> > In context_setup_pass_through_cb there is a check that bails out
> > if dev != &pdev->dev which doesn't exist in the code that sets up the
> > context entries in the dma domain case. Is there a reason this check is
> > done in the passthrough case?
> 
> The check "dev != &pdev->dev" was added to prevent setting a context for
> a different device that has its own probe path.

Hi Baolu,

Why is it different than what happens in the case with the callback in
the dma domains case? Shouldn't pci_for_each_dma_alias already be
deciding which devices get called with the callback?  This seems like
it will always skip setting up the context entry for an alias when
there is a pcie to pci bridge.

My initial fix was just the dropping of the check in the callback,
but I wasn't sure that was correct or not. So I decided to check
with you, and go back and read some pci spec bits. :)

Regards,
Jerry


> 
> > I've been looking at an issue where a vm is running with an
> > intel-iommu device, and has a pcie-to-pci bridge with a device behind
> > it. When running with this commit, and defaulting to passthrough it
> > gets a DMAR fault for the present bit not being set in the context
> > entry when the device is coming up, and the rid for the fault is the
> > rid the bridge will use for transactions coming from the secondary bus.
> > Without that check the context entry gets set up for that rid, and
> > it doesn't get the DMAR fault.
> 
> This appears to be a bug. Do you have a fix, or can you tell me the
> process I can use to reproduce this issue with a local setup?
> 
> Thanks,
> baolu
> 

