Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BC725A337
	for <iommu@lists.linux.dev>; Mon,  5 May 2025 15:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746458586; cv=none; b=BJ3TkWrmFO2KOtHByFdeTNN4pmiNQGRJmgPmSZmi4LQUJDw2ivjk01Eyl2jn7006qh5vE7b7ygmIE90bhuYnjB9yPTcUrEUHZP5/CyoKe/1WVEvL9mJ+GyzXkJEDI+Mv3Y+KuRGVPy/QGIzeteKQCMpIREWW4dp6wATpfNOg4wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746458586; c=relaxed/simple;
	bh=emS0C7wdkFNo8ODIh+wk044p+91lhycQbom543F3Ke8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qi9PhyAQcSei2hhZjEXePPX9+hFEiIS+mzadEnqCHjBTb1FQN1wfORIMCIqsQ8v7NrI2004pDPPg+slD8PPpDdUcyma8EiTMGHppx6syuz5QRvHwjsEG++8mD/i2BqCETMw3IbrOlcswGYWaZHgkGO6y9z6oShSl1NQMaQbwTr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QihAPPWt; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QihAPPWt"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2263428c8baso250635ad.1
        for <iommu@lists.linux.dev>; Mon, 05 May 2025 08:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746458584; x=1747063384; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tGmtJowE9YbZ4Z+EAY2/rXEW5sYEXha+ZBSnuRF7Ev0=;
        b=QihAPPWt1bTKUNFxwsstoFiGOFYTdc77nyYIvV0EbtAOwI1zch2RUHKD1WCb5lO7Rg
         yZf6LzQ9PlP8GgJ6K9Kjvs5oXJzGUp1sq+h3EO13EHaXqV9BStiFIFTk4XHjIVM2NSxI
         i5ak2jYjt7XqTMFijDYqQROQZb7T4o31pLgkM8do33V/9ZHv/OD6t5FNrfocV1T2SYs9
         VD3IXA/Pcy5nKhzeKkREMh3uVqj+bX5tU1vMAcXfVY9Nq6GYXmHSrjuIaBtcTR2dBkrN
         yRUTDpYRrHD40Y8nabyBfFhK0L/gWTepu1PvlKCR3j/nQlDgzvstov5tHOtt9Cvo3WT8
         ksQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746458584; x=1747063384;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tGmtJowE9YbZ4Z+EAY2/rXEW5sYEXha+ZBSnuRF7Ev0=;
        b=qNuBTYn4Nrcd0v0BmMH1U2wyuwMGIfYAKhOjf2fwPRX/YdOfv8i/9YvN7NtIetDpvr
         /J2PeGoNsOZv+LXdRSZdzAsR0fUYrSE8K/aALBz3PDbInu4e7gkr7Tl48ORNizKE8ziu
         zYH7Pb+KaLGTAhNmsXHc6Xxu4G6kEadCc6iOKq/clWwmbEUAqhVth2ZED9RENXfRVOCv
         k/hR5wB/cGu9awFjMej7dg2WVMH8orK307WLJ8uIQJX6b2oHQEI7dnHD46hzyCcYEj2X
         WjuAhBJx3vni4RQ1UD3lTQs3GZZZfOUzPh2p8yVaim9W0xVmQyebcrKhYKLJcXuD990V
         5MUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkQ/KzTUScQt3/6Pn3XmDeCLBJl4xllvX869ENbHRchzAKCmHHyQ3ETsGdaGs3bW4DuGTAmA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxPe6+xIYbei92jx3HvAqZlhx7NT20XQ9RDLL8r+rxnnnoKWIYC
	eX2rP6NVh1Oigd7wq+zidFaXZCGHV3pKDMWHo1jilHvRqkWd5nV/TJTkDEOIFQ==
X-Gm-Gg: ASbGncvCeQBvqrR5HcAKQnHv3X136BXoij38zbYgxFud4sJPJuPBR0MjR5OKBcyydqJ
	/l2UMY6WEXFN/1rLtTOmXZAo0l+/meOvk699J9iZajTgPSavJBMr00bD6OkpygkZqGSg2k9fOPp
	4xaSXZhN9Ch8CyxI/PIuZz9mIC8OrC7HT/yNshx4gKbC2RnNg8001DEWfeGlltMUDrAa3dka6RP
	LIN0bm0mI73UoVITCWEO28McaRbfidYYKGwwG7q+C1PHgenYz3Yq3apvhtCY89lGYUcWYiEv/w+
	418itnlu1PzXXl6d8FHv5FFal4QDCwinGPJ3jr3ZDTL9+/xXy5WbGqbX0/NfCzMpu5eiC499I7K
	OwvdGDyw=
X-Google-Smtp-Source: AGHT+IF3g5A2A0rtR/2rbyPHm9wqVChbMz+gt5JA48+bvT2h/7MybqdKqcMABvSY+3SRY2AkDycMLQ==
X-Received: by 2002:a17:902:c950:b0:224:1fb:7b65 with SMTP id d9443c01a7336-22e317c4451mr174365ad.22.1746458584089;
        Mon, 05 May 2025 08:23:04 -0700 (PDT)
Received: from google.com (2.210.143.34.bc.googleusercontent.com. [34.143.210.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74058d7a225sm6895412b3a.23.2025.05.05.08.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 08:23:03 -0700 (PDT)
Date: Mon, 5 May 2025 15:22:56 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Daniel Mentz <danielmentz@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH v2 08/10] iommu/arm-smmu-v3: Avoid suspend when user
 owns DMA
Message-ID: <aBjX0HvuHkS6MztV@google.com>
References: <20250418233409.3926715-1-praan@google.com>
 <20250418233409.3926715-9-praan@google.com>
 <CAE2F3rA5TbXBj0JDPNnu0L+qfwO6ESaieg4VRnQre4s_bRDA8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2F3rA5TbXBj0JDPNnu0L+qfwO6ESaieg4VRnQre4s_bRDA8A@mail.gmail.com>

On Sun, May 04, 2025 at 01:28:26PM -0700, Daniel Mentz wrote:
> On Fri, Apr 18, 2025 at 4:35 PM Pranjal Shrivastava <praan@google.com> wrote:
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > @@ -796,7 +796,7 @@ struct arm_smmu_device {
> >         struct rb_root                  streams;
> >         struct mutex                    streams_mutex;
> >
> > -       /* Insecure Attach handles */
> > +       /* Insecure attach handles */
> 
> Move this to the original commit that introduced this comment.
> 

Ack.

> 
> 
> >         struct list_head                insecure_attachments;
> >         /* Lock for the list */
> >         spinlock_t                      attach_lock;
> > --
> > 2.49.0.805.g082f7c87e0-goog
> >

Thanks
Praan
