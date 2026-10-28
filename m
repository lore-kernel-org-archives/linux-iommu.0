Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793189825;
	b=ZE3UNQf/UA6jsj4VEd9KMnJd7b/1hHK/Ifss48n+4NFXipxDRkB+TXzULLWpawljyDEH
	 RS6Q9OcEqnL6uJ4MCCH692ReB1rvXFw8vgrW+BFvdceA12S2VfCgjbrXRsrcQ7IZcBdAA
	 AR6OLkL7/5BHvKDkjkJRKSTAEr5IVpkf9z6nuu9IWbxEDo9YdGW2zPS5xDiTcuVEJJu54
	 afyAJtphBPRx/651oonr13zrNeSsU8Wv4sA/vqpd0SSvDsu1yrKzjfmnY3GM9hXF6ph9W
	 7M93HnHacfBeo1N1nN0SkH3YRFnwIF8WxESYfI0gk0UwXD7L8xLCkkor5NBnrzoSW8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793189825;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=2iyRjo6/1vUVedg1zqEtk94iXI1Tkc0kJmcrCJyL4Jg=;
	b=ZX2Wi4Kr5mPMK09N3AGNhcRgN6pZRR+fUS/k8fpT6xVlsnGGB789ur7MiJFBNVfeJ0MN
	 SnF9wWkdi49s2BiDoqLUqdURMEUgCMkNOBwywrvhEnJEnjab9iImJq1orOsfoMSB1KBH1
	 /HqBZmNs+Zk5hcbRXaCLCmwHl9Mbkegbohei2S+KdKCCTdWpu2WN1+NJ768DgqoixeRIT
	 pt0BCdWnV47Fnh199qz63B9dpW5tcZ8P0PsBepxz2g44HdkK8U1/+w5mIOFl+VwyTopnE
	 ENHw6vkSRsYY1kmNXLptT6H7UgBer65Efx2H0USJcmge1qBy9A18tKgNCjfkepjIXRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b="dd/pgn9q";
	arc=none smtp.remote-ip=209.85.222.174
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61151606A31C
	for <iommu@lists.linux.dev>; Wed, 28 Oct 2026 12:17:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61151606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=dd/pgn9q
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-93f079a63b8so78258385a.3
        for <iommu@lists.linux.dev>; Wed, 28 Oct 2026 05:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793189823; x=1793794623; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2iyRjo6/1vUVedg1zqEtk94iXI1Tkc0kJmcrCJyL4Jg=;
        b=dd/pgn9qk+0i1ob7F7fn3sMs67iDck10fBRLk2WY2egxSqrZKNeew/Y3cN2T6unWua
         kgTeBFfLFkHyBxi9ssZ7ssyHcgkR5lVIr3krilBeacMHYTJOKtAHWf/IoJ3e6AJTEjnP
         mqn888n7wepnIhMeDmR4EpQpd2VtqhzCq82SEBY4d77thp24qAA6d+GpqVc6yhGHU3UT
         aXqAVHsyUjdxhW4N+nBvVPS7pCbvuVvh3ZXWIf3/xmzOHB+rgT0fAU1Gf46z8+v1ScYh
         lvsaNctzhazjnactvU84IMU+S0WjmCCU7oM/+5wwU/3vTxo3MCYnOD/KPVaO8wM24gpZ
         BBBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793189823; x=1793794623;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2iyRjo6/1vUVedg1zqEtk94iXI1Tkc0kJmcrCJyL4Jg=;
        b=JipU5bmKBIS6UKafwVYXbHQKti3PKCfXuKkyl8/2LhycaYlYikDDNt5QsRprUyHpxt
         nVuVXCEM6efGVBcxRopMQNcq8ltvbkAVByexR5Ic9OrYMVDnHorN7NppjTCxbBY5nsC/
         ReH3UxdoTo8c9jvaW6aJkMzXnGQ3LfN42JycupUoe39lqiMPdRsioem3j7BJwtiZ3NrN
         j3pogMEg3ZshBQdaMBKe4+wYIG+jKsqKxxGHFc0+dyP4ad2BzJSDajRpMhh/4X8wPPSV
         rCoCFRPV9s0kSLKvBNvoS5oPBa2FVeLRm/Ix7ITYLe/TRFE0kK3LQ9O0DvQya9PEvvO4
         l/bw==
X-Gm-Message-State: AFq9FYI0i+G33ny8QI/YtZV9haT0GpP65/B9KvP+OBgbzL2KRKxCLKnD
	jDUPeStn7ubxBduU/bdbddH8gvnyA0EAcgkUmzbYAHw1RHx1SS98SNdY/uqaPK+k+tY=
X-Gm-Gg: AYBFou3bob5hcz1YcvBMtDyZ4awcPw7COQf3Ho2BO8eC2tWQFD+y3lnuv4AWk3yaybQ
	d3HmGTx8PIe1Wke+LqQnlZbJMGB6U4IN9lYuMwXy07ZPdDYdq4vuP8gOdi2heA4ZLYvlZCp7dQQ
	ndEwkzllcIOImOIeL0w/BeQIg2+havb3Qvm8Hzm7Yuj34sQtlTHEg8oKQqUyWGBygSMsHoewkTm
	SyEPNNuaAFRMoWDRO03e3y1P737lUK/wAQ643y/dcsURNaEjKkFeofsdHaaGnWcAp23aN726I0/
	7F9Qk6aexNjHTfQi57tIPXuG5XRgKUdSP+aGcM3rAWHJyTPzLdeeI0kbrr4K4dCgdca15MWcmZb
	1Iqul/Dma6QP2Jfm7CMqtOGQFIG9+CVody/bnFeMCfs+EJ0HH+7c1MCo/R23I8Nj67EAMD1JbSK
	oRm5eryYp1XLvDgpTycMaD/NxbHvjrwHDQi2Sp37pDWBTZdoVvuH5SYe0fVcvPd/4lGmodUSVeZ
	M6amvu53iuYoy0FztOHbkVhRGtU6aYVBuKipynAztyPSwygbAc+9pHizwm0aTBcVuUtRCVZJEqO
	gZrmI/qqk63EodiFM3oDNuGEKjG0FVz87m8DYGBtDiPtcfRO7t0O/CR5jMZEmPyRRPxXQ+JfVlZ
	Z907FvDNvF9En
X-Received: by 2002:a05:620a:688f:b0:93e:c12c:4412 with SMTP id af79cd13be357-94408d95c21mr246107185a.78.1793189823138;
        Wed, 28 Oct 2026 05:17:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f0a912d5sm1242471785a.40.2026.10.28.05.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 05:17:02 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xM2aT-0000000Ci1w-2rtJ;
	Wed, 28 Oct 2026 09:17:01 -0300
Date: Wed, 28 Oct 2026 09:17:01 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
	Max Zhen <max.zhen@amd.com>, Liang Wendy <Wendy.Liang@amd.com>
Subject: Re: [PATCH] iommu/amd: Remove iommu_group_mutex_assert() from
 amd_iommu_clear_gcr3()
Message-ID: <20261028121701.GM1685504@ziepe.ca>
References: <20260814104029.71021-1-vasant.hegde@amd.com>
 <20260817135155.GB1415075@ziepe.ca>
 <d5e053c4-34d4-417e-ade5-f7f461f9e426@amd.com>
 <20261027182407.GH1685504@ziepe.ca>
 <63ac9043-0658-4535-b42d-0e29eb37ac88@amd.com>
 <76242acf-e8c3-4c44-9558-2751112fc5dd@amd.com>
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
In-Reply-To: <76242acf-e8c3-4c44-9558-2751112fc5dd@amd.com>

On Wed, Oct 28, 2026 at 12:28:06PM +0530, Vasant Hegde wrote:
> 
> 
> On 10/28/2026 11:42 AM, Vasant Hegde wrote:
> > 
> > 
> > On 10/27/2026 11:54 PM, Jason Gunthorpe wrote:
> >> On Mon, Oct 26, 2026 at 06:29:39PM +0530, Vasant Hegde wrote:
> >>> Hi Jason,
> >>>
> >>>
> >>> On 8/17/2026 7:21 PM, Jason Gunthorpe wrote:
> >>>> On Fri, Aug 14, 2026 at 10:40:29AM +0000, Vasant Hegde wrote:
> >>>>
> >>>>> Remove the iommu_group_mutex_assert() call from
> >>>>> amd_iommu_clear_gcr3(), since PASID teardown via the mmu_notifier
> >>>>> release path is a legitimate caller that does not and need not hold
> >>>>> the group mutex.
> >>>>
> >>>> Why doesn't it?
> >>>>
> >>>> Right below this line is:
> >>>>
> >>>> 	gcr3_info->pasid_cnt--;
> >>>>
> >>>> Which certainly needs the lock.
> >>>
> >>> yeah. I overlooked it. Its part of dev_data and domain lock is not enough.
> >>>
> >>>>
> >>>> In the ARM driver this async release notifier was pretty tricky to
> >>>> lock properly. It just updates the equivilent to the GCR3 entry to
> >>>> make it disabled and doesn't touch anything else. This is locked in a
> >>>> way so that concurrent domain detach doesn't face any races.
> >>>
> >>> How about sva_mn_release() path just cleared GCR[PASID]/flush cache and then
> >>> iommu_sva_unbind_device() path (amd_iommu_remove_dev_pasid), decrements count
> >>> and removes pdom_dev_data structure. something like below?
> >>
> >> One of the considerations here is the release of the SVA should not
> >> trigger errors from the iommu driver if the device continues to use
> >> it.
> 
> 
> Actually we will hit IO_PAGE_FAULT if device tries to do the DMA. One way to
> solve this is to have dummy page table. During sva_mn_release() will switch to
> dummy page table instead of clearing GCR3[PASID] and then in
> iommu_sva_unbind_device() path clear GCR3[PASID]. That way it will not produce
> the IO_PAGE_FAULT. Does this makese sense?

Yeah, ARM was going to do something like that too, but it turned out
there were bits that disabled walking.

When this happens PRI is still enabled, so we need clean logless PRI
not-present responses.

Jason
