Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A561B86C8
	for <iommu@lists.linux.dev>; Tue,  9 Jul 2024 17:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720545787; cv=none; b=ky+vEnWMsfdaSZz4m3IWt34XmtKINL3+eTILEZyY/JwMFEmR/HawbUhs6wui0Ao/zmqP1Cimrkq0pabDxO7CcdxqUhU3sjqFsxm3f+bgOfadMiZmIgd0KifFxdpvEcHhgVUwwLpbnN56YwWs9W9C5PwEUwqyck1Ltu+DZ/QgPuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720545787; c=relaxed/simple;
	bh=U2yil5Qb35IaDxgZxylKOI0ns/g0yuIBAEJBs8zRkd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i0HcbPF/TNPCM/buwC4zj/7ja1GxTBuEqEHlIB4DHYDbGbRkTIMVX/Tf5e95OM9c6u+wUMlaVavLA/DpGBpr1W+oSkI5vK5HR1fPD7emHSYShY0aBJxsSp+8/iZoEuP8RG0rTA8SFdoMzaKL2YXBILaY/bHOqOsslrKmmh/Ku+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=YlbzVYci; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="YlbzVYci"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6f8d0a1e500so4856664a34.3
        for <iommu@lists.linux.dev>; Tue, 09 Jul 2024 10:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1720545783; x=1721150583; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=inAts80JAO6fbZNUSLsGehHdbq06fgxJBKqzxxwcrbY=;
        b=YlbzVYcihQW4e1bmejVsXq1yfpxCVqPsGTXaVSAsbZ7L7KzlDlsk5TqSXc/3ygKEw/
         HsNcZhjaXqEqZKd4Q1VcbhHT1mXo4uBARJgD+N+L+NqJTw0i6Ah2P+xVg8YTfJLvMYHn
         LwfQewZHZjH1q5TZwAfXGgBkNZ1/LoPyZUzeTO7DgQnfUAHKfMYp3CJk7l8BRdSynYJ2
         eB2Oe+LzNXPMVUajwv2IlzVH04mNmCZ2eFsUl1Ssm1qUkERhSj4AtbUKUp/B1NvDcyqB
         BDNR1CZ4a5Bl0eDLnMBH9Hzyrnz1/ZLTtYPklFCqPLUVoNTA/Oa8O4CNu1u6qOO68IGL
         QWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720545783; x=1721150583;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=inAts80JAO6fbZNUSLsGehHdbq06fgxJBKqzxxwcrbY=;
        b=LvC8qk9D7U1WnyPhLbD2kSl4O8aTrR2JJaHLxRdZ3wrhuTwQBj1VIhkea/d2sikTxN
         fhCanbkfMYFhfUq6nPz+wkYduShm4I20JPWC1hx3JUiys21dIV/iptBHTl+8znbDFLjZ
         6e0yrLplMTzVr/jd6k4E8nBjvU1/kiZU+gjpwQs9guorQGYP2p1uxCuD9UdFXfkeGPr3
         EdRxbx+u9PwpXlLod1n8bgQK3L65lwCsi3G2Qo8BDLeRBt5wmTphRUfVOZ4uitffY+Mq
         jJfCwYxSHYcVB6QYvEfz6S17Z8E5SkPTohEzKPk/XLv77AR5eCXpmIv8PN4P+p86rz5H
         927A==
X-Forwarded-Encrypted: i=1; AJvYcCUf1ylttfkaXAGfAXnAH8aNE77hzwFMpbwdBHzpiCLsFRkaJUGZXa87s6IsAFBR4TN6qVzY4/Z3W89MC65HWtwbYmqnTKE=
X-Gm-Message-State: AOJu0YzCJD65jX/KqUq9HkMJTlCoem5fuyiOxeNwyUQw9NepX2HBCXh2
	6ufrGunQExzQCApt6uTU/TC+9uQI5pG9VspiMl7gf/WyPHeHOSl58iq528xEd1g=
X-Google-Smtp-Source: AGHT+IGVRFbVHaFI7Hg/zyr5X/JIozW5U5BQaYFUSCyCuMlqJhtXyislRKpp2oru18TCtv4Lx2o1lA==
X-Received: by 2002:a9d:3e19:0:b0:703:6ab8:1fe3 with SMTP id 46e09a7af769-70375a0547bmr3177744a34.15.1720545783587;
        Tue, 09 Jul 2024 10:23:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f18ff80c7sm116481785a.3.2024.07.09.10.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 10:23:03 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sREYQ-002ipU-Hx;
	Tue, 09 Jul 2024 14:23:02 -0300
Date: Tue, 9 Jul 2024 14:23:02 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Will Deacon <will@kernel.org>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>,
	Lu Baolu <baolu.lu@linux.intel.com>, catalin.marinas@arm.com,
	kernel-team@android.com, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 00/10] IOMMUFD: Deliver IO page faults to user space
Message-ID: <20240709172302.GH14050@ziepe.ca>
References: <20240702063444.105814-1-baolu.lu@linux.intel.com>
 <172009718026.360360.18220408964887632139.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172009718026.360360.18220408964887632139.b4-ty@kernel.org>

On Thu, Jul 04, 2024 at 03:18:57PM +0100, Will Deacon wrote:
> On Tue, 02 Jul 2024 14:34:34 +0800, Lu Baolu wrote:
> > This series implements the functionality of delivering IO page faults to
> > user space through the IOMMUFD framework. One feasible use case is the
> > nested translation. Nested translation is a hardware feature that
> > supports two-stage translation tables for IOMMU. The second-stage
> > translation table is managed by the host VMM, while the first-stage
> > translation table is owned by user space. This allows user space to
> > control the IOMMU mappings for its devices.
> 
> Applied first four to iommu (iommufd/attach-handles), thanks!
> 
> [01/10] iommu: Introduce domain attachment handle
>         https://git.kernel.org/iommu/c/14678219cf40
> [02/10] iommu: Remove sva handle list
>         https://git.kernel.org/iommu/c/3e7f57d1ef3f
> [03/10] iommu: Add attach handle to struct iopf_group
>         https://git.kernel.org/iommu/c/06cdcc32d657
> [04/10] iommu: Extend domain attach group with handle support
>         https://git.kernel.org/iommu/c/8519e689834a
> 
> Jason -- feel free to use this branch as a base on which you can take
> the iommufd parts.

Done, the whole series is in iommufd for-next

Thanks,
Jason
