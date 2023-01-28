Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5089515AE
	for <iommu@lists.linux.dev>; Sat, 28 Jan 2023 01:13:34 +0000 (UTC)
Received: by mail-qt1-f178.google.com with SMTP id jr19so5595687qtb.7
        for <iommu@lists.linux.dev>; Fri, 27 Jan 2023 17:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gfyPzg1htA6VzdjdZzG5GcKQRyF+45Usw+FSqBgLOmE=;
        b=UwuBU7iViSp0Lw07MPAQZEV3PkDUIWEB26o7W1q1NmaCWdr4l99EkD+C+U9Qre/slM
         IwrIXhWo7qGuDv7W9g+iMK7b/GkhQK9pdinlYROx+yauYx5bmNm2lKMDuX9ZWArzhBlv
         lTGIYrkGaMpG+wzT3hsgelokPWPpK0iFkmBoCHgTtZpD7+MMQM/orENAG4usjYMp63LW
         Vi6m0UpA7aL9T50Gy+PVF8AfZe9zSJMxbK/0NynMeY6mgTYZYksCcG5/DEqrhh90JX+2
         B88UkJrbQwWSQV/qro2jHcrSh1lXulnJ1llYQViLmqGYyyDAVZY9yisg8I1kUe5NsIkp
         OXBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gfyPzg1htA6VzdjdZzG5GcKQRyF+45Usw+FSqBgLOmE=;
        b=KQHT0bK4nH7Z0ln7dM/0p3rc6Cz7/5hKFFMLjhQYpX+VSOCVeqGl0Rw4ErYuKYWQ7I
         weXZ6YVFl//hNAZRrrH1R5IdtcwOSmjdaw9+l45fT2pMxaKS0EaMxkRHk+HKu7TXn/Es
         BL2nHt5I9QZp+K1VCZAifGyzJt42/ZpQNaBtm3bSdO0Vmwboj6KLciz7ghDNAFZmZo1f
         OC276B0KjgvOmaYhbRa0UXqoUCM4YgAhaCU1tTjxoYk5ao6yK9ZQiMEsVDTJ04Fr6cxU
         ukKFw3hGv9J7A0sInRakVU/Xj8GCrLXvUbozuUzmU6HejWAn0+tDzgR8jqksDfnM0gP6
         dCDw==
X-Gm-Message-State: AFqh2kpfuD2/d/RWFEBwhK6wMndzwuspBCM6az3tv5ow7IDn1a5Ps/k/
	64TWK5qCGd/GukICfRWzDYEMTQ==
X-Google-Smtp-Source: AMrXdXuS7m9o1iHKfe2vBNIfFZru2ML5MnHi9xXszZi8wvHkrGG1etOfVLCmytEtYxwiLdpo8Xzpbw==
X-Received: by 2002:ac8:6b02:0:b0:3a9:2478:2d70 with SMTP id w2-20020ac86b02000000b003a924782d70mr57634285qts.24.1674868413254;
        Fri, 27 Jan 2023 17:13:33 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-167-59-176.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.59.176])
        by smtp.gmail.com with ESMTPSA id b13-20020ac801cd000000b003a6a19ee4f0sm3671183qtg.33.2023.01.27.17.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 17:13:32 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1pLZmd-000StO-Ui;
	Fri, 27 Jan 2023 21:13:31 -0400
Date: Fri, 27 Jan 2023 21:13:31 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Kees Cook <keescook@chromium.org>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] iommufd: Add top-level bounds check on kernel buffer size
Message-ID: <Y9R2u7VrJB7pkY26@ziepe.ca>
References: <20230127223816.never.413-kees@kernel.org>
 <Y9RwpuVyEi2SBmdQ@ziepe.ca>
 <202301271655.A51DC1CF@keescook>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202301271655.A51DC1CF@keescook>

On Fri, Jan 27, 2023 at 04:57:26PM -0800, Kees Cook wrote:
> On Fri, Jan 27, 2023 at 08:47:34PM -0400, Jason Gunthorpe wrote:
> > On Fri, Jan 27, 2023 at 02:38:17PM -0800, Kees Cook wrote:
> > > While the op->size assignments are already bounds-checked at static
> > > initializer time, these limits aren't aggregated and tracked when doing
> > > later variable range checking under -Warray-bounds. Help the compiler
> > > see that we know what we're talking about, and we'll never ask to
> > > write more that sizeof(ucmd.cmd) bytes during the memset() inside
> > > copy_struct_from_user(). Seen under GCC 13:
> > > 
> > > In function 'copy_struct_from_user',
> > >     inlined from 'iommufd_fops_ioctl' at ../drivers/iommu/iommufd/main.c:333:8:
> > > ../include/linux/fortify-string.h:59:33: warning: '__builtin_memset' offset [57, 4294967294] is out of the bounds [0, 56] of object 'buf' with type 'union ucmd_buffer' [-Warray-bounds=]
> > >    59 | #define __underlying_memset     __builtin_memset
> > 
> > This seems strange to me
> > 
> > I thought the way gcc handled this was if it knew the value must be in
> > a certain range then it would check it
> > 
> > If it couldn't figure out any ranges it would not make a warning.
> > 
> > So why did it decide "rest" was in that really weird range?
> 
> It's because it got bounds-checked at the lower end (for the minimum
> size test).

Where? There is no sizeof(ucmd.ubuffer) in this code.

There are no statically computable constants at all.

The minimum size test loads from a struct:

	if (ucmd.user_size < op->min_size)
		return -EINVAL;

So, either gcc can't see through that and thus has no idea what the
bound check is

Or, gcc has figured out that struct iommufd_ioctl_op::min_size has a
finite set of values

If the latter, why doesn't it also know that iommufd_ioctl_op::size
has finite set too?

Combined with the weird report that the upper end of that range is -2
(not UINT_MAX), something very strange is going on inside gcc.

Jason
