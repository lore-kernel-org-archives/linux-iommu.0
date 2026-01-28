Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com [209.85.160.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFC325A2B4
	for <iommu@lists.linux.dev>; Wed, 28 Jan 2026 16:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769619358; cv=none; b=M/T3/TyKTRPoUx2BGQJhkvqHu/k3dsG4dkvAe8fo/HUvHOaEYlPZNXDQKD6NFCaO9//30sWIih1dwxo9JuKfRBmJ83x/zwM/kST3uEum/SHMH3qkokegaGexcfCECYjMxaYIGqZMjPSYYhzHouodglztLvysEcESedcz5iASMN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769619358; c=relaxed/simple;
	bh=zlyGABtqycjVcMHzCBAM8IulM0JewgIfWB4vU4vID9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mvrguXEXbE7zSXajH4ZloVERQc8JZORVjPnWcCtMJ+F35JL7Z5BYSW6+J1wbV0x09WrV/GkRpbvYpKJMBw27L/QhLhF5+1iLUCDQEDmHyZjbfJfcPBet9xXSWP8PnntOMLdFUUdg38aLsdQmgRxw/eQISelX7U3/gvjSYBLJQDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=d1yUjMBB; arc=none smtp.client-ip=209.85.160.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="d1yUjMBB"
Received: by mail-qt1-f196.google.com with SMTP id d75a77b69052e-501502318b1so68868721cf.3
        for <iommu@lists.linux.dev>; Wed, 28 Jan 2026 08:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769619356; x=1770224156; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8iOswqA4Aj70JxGhEtCZJp/QDvQUncXsauILrx3CVAQ=;
        b=d1yUjMBBwEGUSpFjtjzHx3AAndgqeQ6qKE9nj7z+ioYt+boPO4b7x0XXYfaYMAKJbt
         OyywnUPzx3lc5gX4KSwXLgEGTZNCm4hFTdpjl/WWe7FUUolfk2ys4Iu7KKS0D4JyffXV
         dZj3i/mtZTH5FQNY0SZXP60NjnbMYedet9v+ZSYo4jFynVOMxkLbQ6X4s5HTHOBOiuJf
         s04kWqsU4paoFwSTXkuzo5UmSyMNzIEDUFy3iPC16zGMihgt5FflPPHiJ7vgnnHobjUX
         GyFba3D3qhczejSCO2TgpOP3Ctt7dQx7KqObIlwCclGyYGD+LLiuwYHcp+G7bcFZ5O0j
         PAAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769619356; x=1770224156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8iOswqA4Aj70JxGhEtCZJp/QDvQUncXsauILrx3CVAQ=;
        b=GVi3aiPt7JoQxTCsMRLI5xuJi2wjGPjpxCwdoLy3PFHCQSud4D7Qp8g4CWPAneCZEU
         kUwwAakX5ez0yCUfr7MQQ2VoZZ+QAOS3AUTtizRGYSvdHGsGMpenoOVlx5H57nmtmYYq
         4FyDhG8Bt2Gmsw9LgjoNluu2qIcgfUB2A/R4KWFwb5skoxq6DZ/CO0iQS2CKvUp0gnaS
         /3NiXh4/znr+gLhwpIdpncPD1hOegJZM7WmuToNy/1Ra3DJwGdW+GVidH87JIGM07jFQ
         2g98Slb0gh0iemt9eAMlvp61K1F2lTA7xyIBxWRG71f82kudKCWUiMECljWBr3hNGLq6
         DaiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUIZfzz/t/ujT8SeoYGMBvb/KJ3ZumulvoST17aDpqhglvA75tSezJjToe91mEKwwzAvChpg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxHD2pptPs3eOes7ok2vqRRepxecNLF2rbPhHZVe5sESgWs6l7Z
	FGeBibAPSmHftbFzDu8P884Vwvp/kZJBIaVpwXedtfHqYlcDS7uWvFyJaB8xHxQVQUU=
X-Gm-Gg: AZuq6aI0lt4kjvjVfQMWLxqI6KhNUORmeWQapT9tvh4mVvDl+76UerXTyoFxylctmwE
	gPiprC+ZjXkB86bA4/bRLHpA/I6lhHd/Z1piatmJZm3opO8Js97HwXf5IMS7v28lhZ/sVUQucZ8
	VqpS7+HU8lMfFAvoTZ79zTTGU93abhi1JXIVWNFfe3vawZolsSjgpsSTe/96ck82SEke7vuQUP0
	wEkZqFLgHJfdu9Q09Gk+mOfWnoABwJFQhGBJkDAuxKfniE9zid9aXGZq9E7RsQUpmjGpOrmQ293
	RBoOm5qfGGFB9+ZszrMsW4qXO6r6lGalVCFulL5HgVyTAJFPF5OYKXy4Wpr1vOPe4tSChBHjXRC
	RpPub1m11DQXJR+gE94AnQVIcOtDbzl1ObkcF73NLASiWB4Gbl1ajWDHvjWY1B9r2nlXo73EYRb
	WWYl/Rk6Mi8FLNfYPy4v+kBvwVASQidAPYDmRjCMAkfCLoNhhboAUi8xRtQfsPVX5iVIk=
X-Received: by 2002:ac8:5a0e:0:b0:4ee:61f8:68d6 with SMTP id d75a77b69052e-5032f77192dmr79728341cf.6.1769619356274;
        Wed, 28 Jan 2026 08:55:56 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50337ba3981sm18501851cf.16.2026.01.28.08.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 08:55:55 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vl8pf-00000009Kd2-0aJo;
	Wed, 28 Jan 2026 12:55:55 -0400
Date: Wed, 28 Jan 2026 12:55:55 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: kevin.tian@intel.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, iommu@lists.linux.dev,
	syzbot+df28076a30d726933015@syzkaller.appspotmail.com
Subject: Re: [PATCH] iommufd: Initialize batch->kind in batch_clear()
Message-ID: <20260128165555.GP1641016@ziepe.ca>
References: <20260124132214.624041-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260124132214.624041-1-kartikey406@gmail.com>

On Sat, Jan 24, 2026 at 06:52:14PM +0530, Deepanshu Kartikey wrote:
> 
> KMSAN reported an uninitialized value when batch_add_pfn_num() reads
> batch->kind. This occurs because batch_clear() does not initialize
> the kind field, leaving it with garbage data when a struct pfn_batch
> is declared on the stack.
> 
> When batch_add_pfn_num() checks "if (batch->kind != kind)", it reads
> this uninitialized value, triggering KMSAN warnings.
> 
> Initialize batch->kind to zero in batch_clear() to ensure the field
> always starts in a known state.
> 
> Reported-by: syzbot+df28076a30d726933015@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=df28076a30d726933015
> Fixes: f394576eb11db ("iommufd: PFN handling for iopt_pages")
> Tested-by: syzbot+df28076a30d726933015@syzkaller.appspotmail.com
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
>  drivers/iommu/iommufd/pages.c | 1 +
>  1 file changed, 1 insertion(+)

Applied to for-rc, thanks

Jason
