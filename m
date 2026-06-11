Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5845019DF62
	for <iommu@lists.linux.dev>; Thu, 11 Jun 2026 17:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781199698; cv=none; b=ZJECWIOCFAtx0o4+42nihX8uAVossTo6xQs/X1SAXwqoJjreXCv0UnG8tyWnFB8h22R5mSFwHZvlF4PFVqY1nPTqtSHWQMgacfjBPfG3l7q4KPhuvi0+HVxQBYCAF67uG7SSw/oGN1tKocHJrex7sOMN1M9B5azT7++7zORKuKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781199698; c=relaxed/simple;
	bh=ZQ35rJLHLW1jXAUlhy2d2leDWzpFtZe37OKVVTzyHpU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Lsue61ji3zGUqkIa1D5aB5eIPqWtDlcyn0/M36aADgVMW0yUcrMSRagrUOqUKvkAFwf4vd5MGrICvg5Xg0OzRnRaWarbVq3YIFGSN4jeiq5HIo5NuB1/aw7IRUUW/9ZrJrzpzcf0X7PBqMFYpbVQUk2EyXJEsxHXdZmvTs8Nvzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UP7j+GVw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UP7j+GVw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781199696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=2ppUvXGKmFYTgYMs1sXvehexVKSQifrverZBp16Sx60=;
	b=UP7j+GVwXs1jLIBgzn8ofN8t//yUPwCSzj1JZg/Eldz9tsQVBMM0sXIIXZBPAUo9dz+gEf
	n8h3KEGgnSFsaegIO+Mhe0am6B6Z/gs1PaXIMhdnJX/MyMMqapbvN3QhalsCNxbv5g8ySj
	Ci6BWca1SJtlgnTR+QEa4Tpe1DGbtBE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-x-kIfqtDN-e2MW8GSgN-Bg-1; Thu, 11 Jun 2026 13:41:35 -0400
X-MC-Unique: x-kIfqtDN-e2MW8GSgN-Bg-1
X-Mimecast-MFC-AGG-ID: x-kIfqtDN-e2MW8GSgN-Bg_1781199694
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5178ae66ff3so671341cf.1
        for <iommu@lists.linux.dev>; Thu, 11 Jun 2026 10:41:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781199694; x=1781804494;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ppUvXGKmFYTgYMs1sXvehexVKSQifrverZBp16Sx60=;
        b=F9bOqkjZO6q9SNgbmkbc83sONUCYrdXI6FDpyQEBhin6oX/LN2iAdcaZZiVHt7dgqe
         c5pq+bdF96iehmO1pRTTeVJ2geC0NAmqqDUxG3D8ZnOKWftlaCBDkePN3sM/WUcezoDZ
         6sBuKDty1Jn2GKDJW+JFYUAdl3fCsMESsIn9E3yWh6dH2NfAIM3fizofIteWnBdiYXMm
         9uIqetf5zG/tzjna0gsuSdWvVd+jDbiQ89J3XyoBpRtSea3hQfMdF2fGETkc7LwU1fXq
         16wInr/tX5l1+hk4vU8aS31Tprbr1OpYpVrDYmpPwz7ONSLVQGCi6sCzm2LfLwDu9IJv
         GdyQ==
X-Forwarded-Encrypted: i=1; AFNElJ+sLI5R03lqFsFHDSJaQu7wgRvdkycpEAQyJKeBIJxWb1j1PegI/WMa9QgHUMR5rWwriEWp4g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwALwkCDRCg3RJ1rnCY85dkZY30a2ekQfNpuI3+ltw/xHTPRAqH
	1hgqd8pgxW9G1CF3TbHgKXLEdCtM2iY5mLrgxSZB8jfV/pEngy86FOvSvo5r2d1Qu1ZZTJP/z7F
	oPTVkcGJWe4r0zYl5Zifrbc3QyZ3/ChjYrpgDkEbli7MHML6Geym+tRBM
X-Gm-Gg: Acq92OHAl7WymedN1S6gTTo/1zOlHtpCNBMRUZU2joZoStKwoI8e5NZGIvTRXgi7NFV
	SGLFt4mtBSjFihYhFl4QoOeoJiSvIl6JaPVd3EDbwI7B9w8DJpCL62xpb12jTPWuMAMSskT2BpS
	Y0BOgAQJAuQQYREvChlM/doZUvLtY1fuZKtlj9+MG71MDg8nDXxf33rA0YaLuhzfO1utQyUgPEl
	zy+8+6Y5xYnfO+FdNK7EO6MKyBbAKgX7d6bOz4JyrxgUayq31koHqiJXHjD8Jw0XC8VX7viswe8
	wLmksonOWDvPAYvDZZs3yfau0ZCVQlKW2q+sR2WhzFejpsYcoAuJZiMEFz9zbAVYRXn7gd71ssJ
	eoDfkFY5N4LX+cznBLeeMbAM=
X-Received: by 2002:a05:620a:488c:b0:915:d322:c46c with SMTP id af79cd13be357-9160aaefa93mr565634285a.7.1781199694331;
        Thu, 11 Jun 2026 10:41:34 -0700 (PDT)
X-Received: by 2002:a05:620a:488c:b0:915:d322:c46c with SMTP id af79cd13be357-9160aaefa93mr565628485a.7.1781199693857;
        Thu, 11 Jun 2026 10:41:33 -0700 (PDT)
Received: from localhost ([2600:8800:1593:b400:1e8c:ec8f:1337:fb26])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9160ac86221sm245543485a.8.2026.06.11.10.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 10:41:32 -0700 (PDT)
Date: Thu, 11 Jun 2026 10:41:31 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, 
	suravee.suthikulpanit@amd.com, Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev
Subject: AMD iopt levels question
Message-ID: <airgbnJLPm3tnNig@jsnitsel-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IXb4pdWQkCMTUwKILLkN7YHDAM-0C_BVX8VK1dqWPvE_1781199694
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I don't recall, is there a reason amd_iommu doesn't initialize the io
page tables to the number of levels supported on the system?

I was looking at an issue recently with an i40e controller where
someone had a set of them in a bond. When it would fail over to
another device, the device would make a request to map as part of
that, and the domain would transition into the 64-bit iova address
space. When that happens the i40e would start generating requests
causing io page faults to monotonically increasing addresses starting
at 0x0, repeatedly causing event log resets.

I didn't have a system where I could reproduce with bonded group of
them, but I could induce the behavior of the i40e generating the dma
requests by doing horrible things like throwing a bunch of io at it
from a remote system, and then mess with ring buffer sizes for the
device. I was able to capture a vmcore, and near as I could tell it is
during a window where the DTE gets updated as part of increasing the
io page table levels, a UR would be sent back to the i40e in response
to a request, and the controller would start sending these dma
requests.

With the HATS support in the kernel now would it make sense to
initialize pgtable->mode to amd_iommu_hpt_level if it is set? 

Regards,
Jerry

