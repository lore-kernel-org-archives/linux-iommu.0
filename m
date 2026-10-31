Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793420205;
	b=E2S+k5EV1+4XM8NAl2LYQUHIBKKlu+gfdC/8/ZzKOs22xOG10gfbCRC9LmAfvxezQI2s
	 1NvTXrWXMpSbCRsJ1eQTbbcqcw/QqjRSd91C5HamTu/0EqSKOsAeDDudmRGx+D8Y2vGya
	 4qT2SeR+NtrceW8H7tA82W9J3bgENxmjj8ywKAx8Gzxp4WinvjttMI3RQqnDd2+igrHs0
	 YQK2DEDvZU7iDuVH4pAXaC0R5phzkHOqArDQOWzAyoUQUz93nkG5+HcqYTJghf4Mb/qhT
	 FpZ0idqi6n1qE+ovCz0ma0lbnUNN7FWQyWNLvChpENnqPden3xPJWvpAdtdahHLOSZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793420205;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=dr4r/lEBb5xuUcD8BOU9Xdjlpmhf/DQoTif+P9r4G1U=;
	b=kAtUPS10nwIyRjoJT9sGUA2h9NkS3fhxbK/oiZUc0Cu582aNG+3a3znyU2xBwOW3wKoT
	 W7Ucv35JJyeu9g0n1FcMYBEy0T2QoAmkyZ73nDJ5enUieCDpFLSLAm+q5snxpnsDKwFu/
	 g7YqF1o0RmCptJeSgpc9Txz1rdPmYPjH1iFzj0u3Xf1M6LPZ9ubDa3pMxqh4oS9JIPfRh
	 hzxc/e3iJKdbVILtJuHrehGDABKctaN551XQbMssIfaHdbhso3SZgy0WIYgWg01Sw/sMk
	 N9YQhNHHdjj30/TxbAHP/PjBx5K2fYLfg+lTqBqw3i6Tw/KU1NCSUKEhfuNG19pqjKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openai.com;
	spf=pass smtp.mailfrom=openai.com;
	dkim=pass header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=YTzgtCAZ;
	arc=none smtp.remote-ip=209.85.160.45
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761DD606A31C
	for <iommu@lists.linux.dev>; Sat, 31 Oct 2026 04:16:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 761DD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=YTzgtCAZ
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-49429181ce9so862930fac.0
        for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 21:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1793420204; x=1794025004; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dr4r/lEBb5xuUcD8BOU9Xdjlpmhf/DQoTif+P9r4G1U=;
        b=YTzgtCAZpRrq3x4dY/qUjfUuwoA+XV3XR3ZzrpoaSnar3Butvvu1Nb8OTDKzwrvNCY
         6RMM5xiHdWBfPpZQ38K63Kaetf5laFOjVOQzWG4dZSUvmp3TfqdS7U80DZmfhlgiXMZ/
         8QnF4iVggaG2cbvSMpKNb/5vWcND+Rxq+Qeog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793420204; x=1794025004;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dr4r/lEBb5xuUcD8BOU9Xdjlpmhf/DQoTif+P9r4G1U=;
        b=dwAxMIpVwTVVIoRZAzMzIRO2ZVzT2UpmeDtL0IioWEeglgzFI/wUQxvPcAASTxfAOj
         rNQ4H5wAXlEXB5SlCHrpfPgoM45SnBx7LoaFtnnrkTWdjBmEBgozg7HS01lNAsxFGvvx
         4sfEBe2MjwPzm950PKrWYNPz3+a8gWRs3YkvZhmkhRU3TDJjCwhLIo60CQHUPGwioLPC
         g0b3aA9alkhdARnTwCByMUuk1CHEvj9IWupbwIzQ3556szPXSpwVefQdNfn1XzfvhZY4
         3ITeHI4TbaybJhq1XDDCQih3KWvJ9kmj9bDAa7h5mNB06EUtH0niHaC3BhAyb6QSy6aC
         jZ8w==
X-Gm-Message-State: AFq9FYI78twVaSMQ7lpVCHmM9/l4ZKmR0r5XlbLEzCiULXv+u4jxvE0p
	8623oC6EpMNawzn8mnG602hBjdT0Qrtx77JOjKpKhyc4K4fp6vPUuKsGgvI0sNm1B3Y=
X-Gm-Gg: AYBFou0uCrrH3Vc60ZUzYO8I49d5lVFEuM87yr96Ud/lE4Wj1s4wGPFR5BMlj5LU0cO
	u0x9XAWyHSfoPr551oxh2mZhhzFrmaJu6Kv3M47iK7F7khIcGAYliOrUebNkYJj/6WJ1pNO/Wr1
	ncSJQN6gGyUcfAqzd4w1J0i0WaZgV3NaqQOA/X9Vm+jXl0NMibFnAGhGm5CJ2IOMgKnBFIv6Ouc
	FKUTAGhPjCjL9yHWSBOiUKeZmujJHyfavVw64bjaFtmlPEuHwyV4SnJPs+PlxR9YnBIhDEhg90D
	Yhmb6OB3CHC2bq2s4qGlUMyvK4DPw3+i1ZiwoD2fHE3fcEFY36hXK9VmIwX4VObAGr/p1Ncu848
	0tulyWeV6gzWuefphKCx99SY1iRxc+stN3/t+B8NRr4ZLTugbZ46qevuyDaKSzcWs40Osxw5Aws
	mxw1XRzCIGc6J5XdnABiAw0+q/hM2KbrL8l1bTRm/T9r9wDVxx68/4iJHG28qdLYUR27q20HhK1
	1IodgRlbHfSdrCb4Iq32n5CoEgrGygfscpVGLjbN2KAszla5WPqqdT3dDPlJ+pHSMxOA8EganK6
	EYovBerWmMpw8/qMHLSnVIxs5IbyDpseUZKo5OYvAG9ON9TDvU4csxo9tmYAsDJdnY/wNWm1e5c
	5ixIleV7k
X-Received: by 2002:a05:6871:8903:b0:498:c323:4a90 with SMTP id 586e51a60fabf-4a9076e0878mr2842634fac.33.1793420204314;
        Fri, 30 Oct 2026 21:16:44 -0700 (PDT)
Received: from com-75606 ([199.47.143.7])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a92196a7eesm1457788fac.9.2026.10.30.21.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 21:16:44 -0700 (PDT)
Date: Fri, 30 Oct 2026 21:16:40 -0700
From: Kyle Zeng <kylebot@openai.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	linux-kernel@vger.kernel.org, outbounddisclosures@openai.com
Subject: Re: [PATCH] iommufd: Reject opens until module initialization
 succeeds
Message-ID: <auVrqO6e2daXFwCW@com-75606>
References: <20261030042345.74537-1-kylebot@openai.com>
 <20261030120845.GA3889730@ziepe.ca>
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
In-Reply-To: <20261030120845.GA3889730@ziepe.ca>

On Fri, Oct 30, 2026 at 09:08:45AM -0300, Jason Gunthorpe wrote:
> On Thu, Oct 29, 2026 at 09:23:45PM -0700, Kyle Zeng wrote:
> > iommufd_init() publishes /dev/iommu before registering the optional
> > /dev/vfio/vfio compatibility node and running the optional self-test
> > initialization. Either later operation can fail. Since file operations
> > can acquire a reference to a COMING module, an already-open file can
> > survive the failed initialization and refer to freed iommufd module
> > memory.
> 
> What? This seems like a core bug not iommufd.
> 
> files take refcounts on their modules when they open via this:
> 
> static const struct file_operations iommufd_fops = {
> 	.owner = THIS_MODULE,
> 
> If the module hasn't even loaded yet I would rather expect the core
> code to not allow the module refcount to be taken, and if it somehow
> succeeds then it shouldn't allow the module to get yanked out from
> under it.
> 
> It is hard to guess what crashes to be more specific, but
> at least misc_deregister() is safe while files are open.
> 
> Though I wonder how module auto loading works..
> 
> Jason

Hi Jason,

Sorry for the confusion. This is supposed to be a two-patch series and I
accidentally dropped the first patch.
I'll resend the patch series. Also, I have a reproducer for this issue
and can provide through DM.

Best,
Kyle
