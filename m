Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9D048CF2
	for <iommu@lists.linux.dev>; Mon,  5 Feb 2024 23:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707176091; cv=none; b=OltAq2uYu872Js4OdPCklpl9it6lRJsQaLgaxxUdgXtVsoUgZeHU2/dUi5+xXuaxX45I03lTCXEEw+5g6wlyDGLxPkg2q5YnbJ9Sh974DJpv8a8I4syQm0I/PGY8t0oKH3Vci5zHgrX2mTqdEeB0kcdwMx7GyXNOp6Far9bvuf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707176091; c=relaxed/simple;
	bh=ldhxU/uh8jcnenclWs1IUZtu/99DL4r26fBNY3JoSIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KVAtbjJzijQEokgaByVQmy1DAkOEw9PFd9Zfz45Qq18/2AtUWSlxFFF1Ocol/tossrlFFgJ+/KwWEECa0UYpd/zotTlHPYLlqxpnRYJ3n9XZo39axmgbBFCTBkay+hCxQnK4XNV8+gr2eQktq07MAP6OAs05kBm79PY4+402/Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=ptNusNww; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="ptNusNww"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5dc11fdddd6so1952185a12.1
        for <iommu@lists.linux.dev>; Mon, 05 Feb 2024 15:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1707176089; x=1707780889; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gtL3jvJTvpjem+XLSIljDmdaRNW3JxGajKR4+xmGq/g=;
        b=ptNusNwws2joHQUQITm5C4kGnFWjaEdER4jQbgn0nuzDFaVGfdjtF4wJJyXdPspuuk
         7neqTiNiO/esSSdNV5BoHAPVPcJAtDR1mof3/TkFl955UrNfiVJnhCV1vt9537jxyIbt
         pGdfTo/2kGKZRWUeGA9FFkUoO4v8KZ2zwXj/T7yQDxz9leDbKWcQKrtu07VYu5imxhpE
         23T6vGTBrHE48eJPK/VZNy6ijRGnUZpgs6kE95kdhSf/tG/h62UadOorqBaMtRyHvIMw
         7qZHZNWgUexrMSBAfEJalrZ1pLAK0CVPfOj6k2pXiQEUFqOGpwagod2mLDZovWFN1LyW
         jW3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707176089; x=1707780889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gtL3jvJTvpjem+XLSIljDmdaRNW3JxGajKR4+xmGq/g=;
        b=o6f0DM2xEY94/lVzSU23YmCl4dW7ouWa26M+GeV6j6UVsxRt8Pz04sNbCHeHPLi57L
         Leli8NKvN0W1RlK4/4mOO9bs4ey+OdTrX0MNaFAwTc3Fdj21TWj0DzVDxfxugG7NcVW6
         RXXBkDJohimaTCCk/6HosqIgz7HZJ17uW2BfFWummq2uGFdBzgGM2jyi+VjMwd/iOMHX
         MSlmh7Z+hfvre6fbFmFz8y6LnoLevkX5DtopdZ6yMQbCiqtFZQoxxx29EPsVjg4yyNa0
         6l6sY31NZyabpPgBt8JC+X1KBiPzb4BVksGQVKuoH6gCj7ny0WqQILVIBG75i3BZEtMQ
         T+xA==
X-Gm-Message-State: AOJu0Yz8FX8QEyWKrqrwnM904Mc51bXBm5KNnwk5T80v6BW8vDhY4zJ0
	tnkctaV2G6qd1dbasBkGdxE1x964SPpvxDlDb4wHb0XQCEfMr1ks6DsDcJZLR9Sv5NAU0CzsS/y
	L
X-Google-Smtp-Source: AGHT+IERWsgnVzcArUkK0ONx3MiZk4r16tHisF/C0B+IjOUSmMRlRCaxDntU0A4X2gmwb0jbKeI/4g==
X-Received: by 2002:a05:6a20:5a23:b0:19c:6994:8913 with SMTP id jz35-20020a056a205a2300b0019c69948913mr18604pzb.7.1707176089472;
        Mon, 05 Feb 2024 15:34:49 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV0CEkV2IfB4OmDyzaC+v8m2BH8FR7RhAj08DN4ZCHOpokDj9NS3wCXNVRfk7DG1CgufYqK8wHCWHs/PTSMiUjOuQSYNN6ZB+aTscx7+cznoZDT8F2Z+x8Fq3mxFfB9Q2jg/LH2Xu5A+NenLIQoUHD99PduRSLqa/iSmtJqGUFocP6eazRhZvFPA9oDPPOrGfymNqdHw0h/nxszHDIMLLBz29NGLa3hIDKXa0S4z53eR2lqqcuHECKUht7VhUHfbFimSw7QRk7cn4BKB3os4xsrqwiVMkY7NRCwcGUSArF2DNAxABXpngViCgO/vzS6NOCH8aVzjxa+p7AcjKWz6oTuWjyOTrBZ8G63OPDI6g9B3Y9ih4iHTfBED1X+kcrAoyJpINXQ5q4bBt5dYYppH+8WNNuWMz2CNZCklGzQk9dJuoE2ItM4zSqmfovYw3ID101Lnd3kUjofr8ibkxgD8K3q6WDRUDbueTuqDCvzRQDSW98rcWllaXDIoFd2YDIC4WD/pL8BWmhBnN8pJ6k6aTgCMvz90BDChV469mYLup57WhnQyVmsE3Qc8hAeKEEGLeNjV2ax1UH2rK7sI8BbI4uqpLjJUj6kEP6G3Awmmm0ngNCcknaIUFOysIxxB9aT2a3JhYMHnRxYt1Ck/1I805Fl85lKwmRr4/1P9deiddme4xe2eCvJLYL3JVcbTYiI3Vs+wFW6KG3VQaHK+PxspiH1JWWW2QHFdaRaiqgAgi3xQs8I
Received: from dread.disaster.area (pa49-181-38-249.pa.nsw.optusnet.com.au. [49.181.38.249])
        by smtp.gmail.com with ESMTPSA id k18-20020a170902c41200b001d8f12b0009sm423859plk.293.2024.02.05.15.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 15:34:48 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rX8UA-002agH-2H;
	Tue, 06 Feb 2024 10:34:46 +1100
Date: Tue, 6 Feb 2024 10:34:46 +1100
From: Dave Chinner <david@fromorbit.com>
To: James Gowans <jgowans@amazon.com>
Cc: linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>,
	kexec@lists.infradead.org, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	Alexander Graf <graf@amazon.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	"Jan H . Schoenherr" <jschoenh@amazon.de>,
	Usama Arif <usama.arif@bytedance.com>,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	madvenka@linux.microsoft.com, steven.sistare@oracle.com,
	yuleixzhang@tencent.com
Subject: Re: [RFC 05/18] pkernfs: add file mmap callback
Message-ID: <ZcFwlu9+LQQWWOz4@dread.disaster.area>
References: <20240205120203.60312-1-jgowans@amazon.com>
 <20240205120203.60312-6-jgowans@amazon.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205120203.60312-6-jgowans@amazon.com>

On Mon, Feb 05, 2024 at 12:01:50PM +0000, James Gowans wrote:
> Make the file data useable to userspace by adding mmap. That's all that
> QEMU needs for guest RAM, so that's all be bother implementing for now.
> 
> When mmaping the file the VMA is marked as PFNMAP to indicate that there
> are no struct pages for the memory in this VMA. Remap_pfn_range() is
> used to actually populate the page tables. All PTEs are pre-faulted into
> the pgtables at mmap time so that the pgtables are useable when this
> virtual address range is given to VFIO's MAP_DMA.

And so what happens when this file is truncated whilst it is mmap()d
by an application? Ain't that just a great big UAF waiting to be
exploited?

-Dave.
-- 
Dave Chinner
david@fromorbit.com
