Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77956193
	for <iommu@lists.linux.dev>; Sat, 28 Jan 2023 00:47:37 +0000 (UTC)
Received: by mail-qt1-f173.google.com with SMTP id g16so5589046qtu.2
        for <iommu@lists.linux.dev>; Fri, 27 Jan 2023 16:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hC8vO32YUuQQBDUUZtcngmVtbpaT0Jq1aBzvbrp9Yp4=;
        b=NfU4J/gQoigubTQ+wI8tbZjlh1VQ6Sh8pVgcNDND8azysAP3ohXu76hvEuMeua8cPT
         +5skO7lpbqKQoPaNgf/d/koiIk3yzRO/sIHL4Oux6vJw/LSpiPvA9+9Fmmo9bDF7gU/S
         Z6nFB+d7YfMbDtSu1UiBnLFdNeF9eV74VK7luz8sM7s6kFR3bjucW2hwUwPNSrlKGcAY
         GbnGO2rSp7JioimHkLZIry/2g8E+uNcAYE9iX3ZBpbpF+0ZxV2NVDtUC/LTMC2/3NtEX
         06gi8pyEUdFS7xqGuqBovSwxQDdnHpZ/M2WPAktJdsE/b+7PUpI2JrMZvznL8SIgdwyM
         vvXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hC8vO32YUuQQBDUUZtcngmVtbpaT0Jq1aBzvbrp9Yp4=;
        b=1ttRyh82Fw//0dUzd2LjOmkKvRW5vs5bOucXb6gwnR1FHXWw0o5itU8DepfNsrjXEc
         Vr43JFVef5GNSnT6CtSdX7cxt60zd989JX0v8o/xy+QTNBbvEWwykheHHoH6aIvTFYLc
         fLpscYyygTRbK4RhunwVcqI55HMszxiQyCAVwt5+3acwMAXLMIvitOryNWY0tZw6y/KF
         Lp36CiOL5QILMXW3C1QPe1cvcBKNodQ0SA7oRYfrqFCTDxpf4+yHrbkTeY6ErimLWWqm
         z/i1abkWn/NyUNuYRMFqLwZC86Wd3ej4+9HY4jfE1Bcnap2rs0KTqCWfmtcPyt+zRz0Y
         yIeQ==
X-Gm-Message-State: AFqh2kq+aW2XI3nY2oo1jq0X9AM9/EX5tLaLbx6kl4Vzba60ni0IQqHp
	dMyyVd1z1vboA4KsnkQMsXFBmA==
X-Google-Smtp-Source: AMrXdXsUvUmJhsOS2hBs3r3WYshjPAj7VpqIhNt/slphm3NSivGdXET/Mduy+M/QnEHVnaDE6g/nsw==
X-Received: by 2002:a05:622a:1e1b:b0:3b5:87db:f950 with SMTP id br27-20020a05622a1e1b00b003b587dbf950mr57889488qtb.27.1674866856248;
        Fri, 27 Jan 2023 16:47:36 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-167-59-176.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.59.176])
        by smtp.gmail.com with ESMTPSA id d10-20020ac800ca000000b003b0b903720esm3677194qtg.13.2023.01.27.16.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 16:47:35 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1pLZNW-000SMV-II;
	Fri, 27 Jan 2023 20:47:34 -0400
Date: Fri, 27 Jan 2023 20:47:34 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Kees Cook <keescook@chromium.org>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] iommufd: Add top-level bounds check on kernel buffer size
Message-ID: <Y9RwpuVyEi2SBmdQ@ziepe.ca>
References: <20230127223816.never.413-kees@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127223816.never.413-kees@kernel.org>

On Fri, Jan 27, 2023 at 02:38:17PM -0800, Kees Cook wrote:
> While the op->size assignments are already bounds-checked at static
> initializer time, these limits aren't aggregated and tracked when doing
> later variable range checking under -Warray-bounds. Help the compiler
> see that we know what we're talking about, and we'll never ask to
> write more that sizeof(ucmd.cmd) bytes during the memset() inside
> copy_struct_from_user(). Seen under GCC 13:
> 
> In function 'copy_struct_from_user',
>     inlined from 'iommufd_fops_ioctl' at ../drivers/iommu/iommufd/main.c:333:8:
> ../include/linux/fortify-string.h:59:33: warning: '__builtin_memset' offset [57, 4294967294] is out of the bounds [0, 56] of object 'buf' with type 'union ucmd_buffer' [-Warray-bounds=]
>    59 | #define __underlying_memset     __builtin_memset

This seems strange to me

I thought the way gcc handled this was if it knew the value must be in
a certain range then it would check it

If it couldn't figure out any ranges it would not make a warning.

So why did it decide "rest" was in that really weird range?

Is this just a compiler bug?

Jason
