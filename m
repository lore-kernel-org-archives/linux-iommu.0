Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F5425A2D7
	for <iommu@lists.linux.dev>; Tue, 20 May 2025 15:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747755591; cv=none; b=rPTPruIOBozcB7eAW13wYYmp6wTmwNi5wH1tRYcUD1VOeNLsq/jmlx2Rux2rsTuwYycJ8eY1LMoTKGV1kVjAJcxY5mDEqQBRNEVEPQYbrQA1slxmDY5RsbHicOUZQo1wgQWsHDUMG240AnjS7F2hTMF6G6tjljfTWKD4meiphNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747755591; c=relaxed/simple;
	bh=5qaDz5va7V/bOIPJZLz/3rD4zx13j2tjLgu6z+mJZvk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CDLGGtNMAEasXPLuCb40V8yTEoBhj9LQcOLbD3v6YKoQXda9C00tpYgTYTKMyZFMw8T5N5R6O503llCDVDO6s4HO9GmlharuFWfPm/O6javQjTaiSSiL2DwEpLVHEwpvWh3v8d4BXZajxqgfIg6mUK0HFY6ge627NVyiTRoAVNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g5QqVXuB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g5QqVXuB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747755589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GJ0rFA5ozhMdO1IEpBbuVAQP+phCnmZbFuLhRhdhX4A=;
	b=g5QqVXuBWBtlgeWAmKN8VFW70sVZdwrChT7ExQMbbiIFhebWZoD9WJOYyX3sMDnWDy8YLV
	WmHyP+xChnK7fd1w3RSmNB97wmxNFW1Z/+qv9Y6HduL5aocKQFTuTR2diPOJ9DF/HxP8pY
	JEWeYtvlcsVY59At4diagQ0zXH8i2YA=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-o0A3TjjSNfWVJOHawoivFA-1; Tue, 20 May 2025 11:39:48 -0400
X-MC-Unique: o0A3TjjSNfWVJOHawoivFA-1
X-Mimecast-MFC-AGG-ID: o0A3TjjSNfWVJOHawoivFA_1747755587
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-85b3e93e052so102185839f.3
        for <iommu@lists.linux.dev>; Tue, 20 May 2025 08:39:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747755586; x=1748360386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GJ0rFA5ozhMdO1IEpBbuVAQP+phCnmZbFuLhRhdhX4A=;
        b=OlJio5MO2Lxf9L7e9IXgu0m5vtMO1FkyKLQod59eAckQQGLmtsQeWSbOR++57FGcdM
         UIXZLewEfmusMRTpOUIhLmutC01D76DETAozO2zf9Im44XoRsmrxEevQqHf2Iliy08ML
         cb4O8g8YrA7qWhZPE2+A0jkuSbcJLTdbNNqPQf5XRtDnPByc4Qe4A2Y4Dp4EO9dGspje
         jSu6gMyNXarYVDs7BsjRQvwMnCjnLR2hLrzH0mRf1TZiVSMi+sxjmtkejOasuPz7QVaD
         mJBiZ7bz0MfKituvsuYDMEC8d8/FQkx65CJyRO04wW0Nj5Wdr8nHVOQDunM4y78q3iI1
         DQvg==
X-Gm-Message-State: AOJu0Yx1sYbHlaF7nI87wGXhlXhUpKz5WKL92VKLdsHZgYuWJKsTpeoQ
	OfNh0tKIQnHLEk9giJA/AwIS6hzKVjBLVjxtXJ/DDS4516nKacuvIJwiiOviUiNx03SlRaVTbuK
	x3UUhOFICrIu2hEk9GfIu4VYAa1EaS4qr4uStoN8VF/k4gaYxjYNoec696gVMmciU
X-Gm-Gg: ASbGncs3qYJoPpcCDEEhXKmU3VVn5K74e54NJCwAvR1Xut4JX3bzdV5BtfkEDg79A5A
	05oj6fZ0YGIkFuj4L1a34DSwUndRYLnDCXLIs/hOPidsU+apD2rNDlajNRpFsfg9nU/wWAinUvU
	xfjwQZcAgh9sTUtiDin0O5HJgc0rRFsl3kgw4XnGwK5Z7kC+lb4hyLmvdO2KpjvUsvxcTSEvPJb
	dGVcbuApJIkHIu87ONTxsfJO6O7kc/5tg7cytKv+Gb19lrEWKGftj58ro3/NtUo5IkRvPcySEKO
	5D5qozG1rzXASJU=
X-Received: by 2002:a05:6e02:4515:20b0:3dc:757b:3fa4 with SMTP id e9e14a558f8ab-3dc757b42a2mr12610645ab.7.1747755586652;
        Tue, 20 May 2025 08:39:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3VbHHu3m+p8uONX+1ieaFf8GcikTyFLsLmu7hXitJ8VoWNtERX8CvL4Yw5GgMZaX+kUid8A==
X-Received: by 2002:a05:6e02:4515:20b0:3dc:757b:3fa4 with SMTP id e9e14a558f8ab-3dc757b42a2mr12610565ab.7.1747755586291;
        Tue, 20 May 2025 08:39:46 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fbcc3b1a96sm2298549173.51.2025.05.20.08.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 08:39:45 -0700 (PDT)
Date: Tue, 20 May 2025 09:39:43 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, kvm@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v2] vfio/type1: Remove Fine Grained Superpages detection
Message-ID: <20250520093943.05bbe2eb.alex.williamson@redhat.com>
In-Reply-To: <0-v2-97fa1da8d983+412-vfio_fgsp_jgg@nvidia.com>
References: <0-v2-97fa1da8d983+412-vfio_fgsp_jgg@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3Hmwi_LNhWzuCVM-sMrDTu_u0BamBWgK5oHQY7CAfGY_1747755587
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Apr 2025 10:46:39 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> VFIO is looking to enable an optimization where it can rely on a fast
> unmap operation that returned the size of a larger IOPTE.
> 
> Due to how the test was constructed this would only ever succeed on the
> AMDv1 page table that supported an 8k contiguous size. Nothing else
> supports this.
> 
> Alex says the performance win was fairly minor, so lets remove this
> code. Always use iommu_iova_to_phys() to extent contiguous pages.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 49 +--------------------------------
>  1 file changed, 1 insertion(+), 48 deletions(-)

Applied to vfio next branch for v6.16.  Thanks,

Alex

