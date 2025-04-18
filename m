Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934842750F3
	for <iommu@lists.linux.dev>; Fri, 18 Apr 2025 12:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744979556; cv=none; b=o/vfAPB2rhKsNeXYWx4ZuGLjC1JJCoAK0DqcHdJ6yAlwLy0UuXr67G1qsc6BE/qy0L351kmrAcY1fJOyfD7DNqbDVm3bk2Cq8UgNK2JuqhUJ0coNe8CLOqlAYzBwL4ZlMETus1rs8FuFmcgn6gbGZEm4DrPpyT9+288e1A28MFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744979556; c=relaxed/simple;
	bh=fi1DbYhlrqF0U7IzqDP/M+/r8vdH95UNS8kWonbjyGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jw7RTPQRcG6BAxX3wu52Huwlw8m3uBCXAUcXYHkA9gv5nj+QpqJNGjDY65ZxrS4Y/8rVM/Mjdr9CihNhH48wlggkduYe1whhwTLYxFHv0YwDAw2hncVdP6Q6ijq85Oa9cwyzKTElg5SmnWSVN/Kyol26jz3JjJ+pIRs/gVlLXVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LaWPBiA6; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LaWPBiA6"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-736aa9d0f2aso2075531b3a.0
        for <iommu@lists.linux.dev>; Fri, 18 Apr 2025 05:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744979554; x=1745584354; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4uxNqOBD/ogCW1O0rrQ2A0HcfFujRPCySOpF/YO01oA=;
        b=LaWPBiA6pvHOiMCSEy7+E7L/KQF0L+EWkwDIT1znbl6r57AgTDZHPxsRoc8gPyiptz
         ijmdH9Lwsl6klkCRpk+sJH1F+xZM51BayhS58itfy21l1h47RDHYCQibkmrW41rPNIOm
         VkKeMTJHffziltpCt6Z59ccc64aout61YHVXdALsN2Ufxj4y1axVPg1di7Hw4hsSYU9y
         b76lqIwABcvcjgMeAj8XVYIjfAgMHO2yu/kmjXSYJEbsUvC7TKRcBXM5ju73AuvUyyCR
         7P4TjBC5vwmQ/iecmgxPFt2oSJwa+cCgwJAxNOPw/DVSbLn7talHnpdR0tZmU0xCQ7eT
         hSNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744979554; x=1745584354;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4uxNqOBD/ogCW1O0rrQ2A0HcfFujRPCySOpF/YO01oA=;
        b=N7WNEbKN2MBdEDxvp1xmeEXokAGGpfIF23xxtFW9YjgEdeJ0pFFAET/Voadl/M9Z69
         ynRxknM+s7AcedqgbTXC3QvIvDDHKB01BB1YLBOvSMG5zxQZSbvfcmrebvxF4l/vKki4
         aN9m1EZ8f/P8l1pfjtBi9G9/yohnkSWrbUZdorkWvynon0uArNk59JNcLtr5EFDITJ4Z
         PfLL8Y2LSFx12PA8dnCoUY/Kc8j99EBGkExmuUy1TgHxkYzJ7b59fhaCbSc6a+ybw031
         IsbzCWy/zEfhOT8z5vfWw2pfK8VQGrsOUunrK7g+9R58wIBSn7wapEVyL0ExOaYgcJ8S
         qxVA==
X-Forwarded-Encrypted: i=1; AJvYcCUgfzi1LU9vQQPC/3+Jn7nSiZ2+gJ+1SMlv9lHnk8+Z5Uqqq/7vh64jFoQEJKIHRO5pB94+Aw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyWqJ5rQLQft624wTOOoYqDhle3j/Fa3Oge81Mnd8Li+FxaheTQ
	9o0Jc4D4VPowXAo1V0RbZzsipkokbm2loBX46QOCYPUdD6OCxPYf+gpwAEU5ls5ZcMqwlz0qAjc
	BzUN1HaQBKjMZm7hAfS+nO+R5wCM=
X-Gm-Gg: ASbGncvnF3OM/Rv6CyWA8L7QyUHZKu593rMbKmTd2ujTG3oT70e2aksEBjIyVKDgEln
	i1vZbZRQ0i5pgFM5Ru973YBbbgqc/dgDQCqyxvZH/aWAviAHXGhOUxLIlCjyivJZy/HgQ77oQJu
	7HA2Nz5/1fmzPBt6hjgLxn6lkxCS2sO2/fWXIj/ZjaiHHRyNG0P/ChMlba
X-Google-Smtp-Source: AGHT+IE6KPLtDnTScFEtJJlvCdwmMFGgLV6Sh+PZ7MHmYiMb3jtvP1cSpc1ynbu9LO+7GJYkCunnvOZCbjH4BPDTV0s=
X-Received: by 2002:a17:90b:2e03:b0:2fc:c262:ef4b with SMTP id
 98e67ed59e1d1-3087bb6f117mr4849982a91.18.1744979553652; Fri, 18 Apr 2025
 05:32:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1744825142.git.leon@kernel.org> <670389227a033bd5b7c5aa55191aac9943244028.1744825142.git.leon@kernel.org>
 <1284adf3-7e93-4530-9921-408c5eaeb337@kernel.org>
In-Reply-To: <1284adf3-7e93-4530-9921-408c5eaeb337@kernel.org>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Fri, 18 Apr 2025 18:02:08 +0530
X-Gm-Features: ATxdqUGyYBEsfK-IN2nZn9q0XDVh1xSRZINsNgbIk6fSYXOiPXAs6WAhmbL1EUw
Message-ID: <CA+1E3r+9kEs-fqND-VD+y6FWfiGqr1vN8M0GufD3oHdwLdFcrQ@mail.gmail.com>
Subject: Re: [PATCH v8 24/24] nvme-pci: optimize single-segment handling
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, 
	Kanchan Joshi <joshi.k@samsung.com>, Jake Edge <jake@lwn.net>, Jonathan Corbet <corbet@lwn.net>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Zhu Yanjun <zyjzyj2000@gmail.com>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>, 
	Yishai Hadas <yishaih@nvidia.com>, 
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex.williamson@redhat.com>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev, 
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org, 
	kvm@vger.kernel.org, linux-mm@kvack.org, 
	Niklas Schnelle <schnelle@linux.ibm.com>, Chuck Lever <chuck.lever@oracle.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Dan Williams <dan.j.williams@intel.com>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Nitesh Shetty <nj.shetty@samsung.com>, Leon Romanovsky <leonro@nvidia.com>, vishak.g@samsung.com
Content-Type: text/plain; charset="UTF-8"

> > +     if (nr_segments == 1 && (iod->flags & IOD_SINGLE_SEGMENT)) {
>
> nvme_pci_setup_prps() calls nvme_try_setup_prp_simple() which sets
> IOD_SINGLE_SEGMENT if and only if the req has a single phys segment. So why do
> you need to count the segments again here ? Looking at the flag only should be
> enough, no ?

Yes, the flag will be enough.
I started with nr_segments first, but felt the need of a flag when I
reached to handle the unmap part.

This can be changed if the series requires an iteration.
Or I can do this as part of the cleanup which I anyway need to do to
replace the "iod->aborted" field with a flag.

-- 
Kanchan
