Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D923596F1
	for <iommu@lists.linux.dev>; Wed, 19 Nov 2025 13:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763559432; cv=none; b=Au20H0TR5deFuCQALpqWEkng8fdnlodwD7OJ1fdgtZ0Ko2o9z4VKUaB3zvk1HlzxSu086TZb+v25rn/GzKhjcZL0j5Rk5GB1+Y5V6XNXeH0x9m4tF6LDlDbBqgQv8cTlN7mQz6umjoC2BdfkprnTtDfjQ4rLXQflqPRPK199s8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763559432; c=relaxed/simple;
	bh=xHij0HoeROljwYVIzlugVWfpQyDCueEmuef+LW2XwsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gymeCRaZBafXZMoPpxmw01L8W33wFJ0MKI9t+7o5GjmZiDJWg2dkxu3TImU9GtbpLDp/68yaFVmTmn+p8vsrTxHHt8fg0f/TiypY8H/S451te/Sy7GCZDqc4+8+q61p4bm3l8xM2tc72kBN09QqCzSP5UbWx29tbHe/jMV/MRLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=c+8WsYeF; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="c+8WsYeF"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8823dfa84c5so75098786d6.3
        for <iommu@lists.linux.dev>; Wed, 19 Nov 2025 05:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1763559430; x=1764164230; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bEA8ekCp1nrcWXcrdpDKlGp67cbKmmAmKoKYvVWnAsI=;
        b=c+8WsYeFACeF5fOaux/H6kKgS44z52Tv5vW9ynJ4DQ+59UWLZKS/66D7KFKdRAoywV
         I9QuxMAsTNbpV4FBEEAF/xA2gb9igPF6TjDGcrVz0Me1hAcad/AwO/EMOO6DusnHCIdB
         tZ0Yxt5wEJp/Wv4rOGWsFi08YLem/hcFSblVhn3369/SE/raLtM00nB0TQRyFlRHK3Wo
         05m4MgALi5C1BXwmjYRDtzRM6Rm1JOHNPZV8HX2WZy8DGzIxKZxmJaDngclTTcOlzVqu
         hPJtwy3pZTY0PYyViXfVCClTlcDaESNA8lLIL22EZ/p2JawNo0ffKpI++OpP0WXeL1Ti
         wfww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763559430; x=1764164230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bEA8ekCp1nrcWXcrdpDKlGp67cbKmmAmKoKYvVWnAsI=;
        b=udHGza6/Ih8rcoo9ki2uOlqRAaGMK25e9sQLTyCNUV3VORTdy/gawGWku54U0H0W96
         OW38wnywmxlOXmrG/q5B38cjbXTgBH1PpsvmrlRBGe4/M1lpgkZcwnxHpEAYIKLzHL3Z
         O4hfhRfb2RWUOl+ESik1DiizLfsaROfvcvZVyP3LY8EYl2bqV5YmVVv9u3QgOC5yeHpR
         qjyLe9PgVH8N5vBznDRgIN5a4u62Z4Uuweyxvl/zkri1NovnCQmRYvnkFa1iBaJ2Aig1
         FdZi+Wo3JVMtIhex+CNwJgavW0EJsCik2fxTOmCiSzarURXVl2agVA0qkvbJ3Tv6eLRc
         2cPA==
X-Forwarded-Encrypted: i=1; AJvYcCWIBDyVqYlhXaqXgSdvU7f8+CZwrOOLJGjWHE8wLDMs9QHqcKmSl7fDCcR1ZG20zPkDyHKxsw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw8KQwM5uwlcMfuDERzvnx8E6T5LhKj31oh+JneCO1OE4Eh2j5f
	DqONXxtPSDlMC/6DMpf8Rx6J+moej/3pmMKbcoL39st86igjJb3pTJ3RsFXCRMA57vI=
X-Gm-Gg: ASbGncu4c2bPH5vf0ITIY6BbKutr8fPVgjfK11Z9IkpWpVMUv0MnuqGOkWGB4hglx8k
	U3D5fV1vH67M9QPRzRmdtxKwt4CL/CI2LIWQ/Zz5uRiFkkJEkC3R9u/WEgObYX0F2GQjDbgE56M
	yi7jD7xR5EZwnkeYJXbg7qRMmo9TL7CAZ2CYt4cCHSQrqnd8zRYXOqLWa5nlAvPUrulW/LnJ2Dy
	16c4G4OOjiaVhJVycMS7JxdB9N48Ixz9qJIBPOBRojC1xw+dHlhgc9UZBsPh4VWuXygMwbNqjqV
	7anpbJx5Wh67NxxIM4G/qC1/2itHDhBDGlooya5Puyrosx/r5CqqTwZcwuSrbwPpepFAEaLFONe
	Gu8WuwUHYy6JUA05LpsG7wRZ3b51vtpq5P9NOGCUlgNqou+9YE36IdcPYSDiQHePxyuyk6Bd0Kb
	Rf5pk9G21teLI51WzlG7hwN1Xs02aMndViNeub7nPAYqmSscpd/sVZ7UFxBl/HcU4qdmg=
X-Google-Smtp-Source: AGHT+IGopBrMkEkq4/9KDO3x1qdzFmkcFO+Cz6Is5DlvxN8PyWRrz38DMZOLki2k1pBf80D+Z8AYkg==
X-Received: by 2002:a05:6214:419f:b0:880:22f3:3376 with SMTP id 6a1803df08f44-8845fc3e0f0mr26190076d6.10.1763559429603;
        Wed, 19 Nov 2025 05:37:09 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8828613962esm135128356d6.0.2025.11.19.05.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 05:37:09 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vLiMu-00000000ZAY-2EdI;
	Wed, 19 Nov 2025 09:37:08 -0400
Date: Wed, 19 Nov 2025 09:37:08 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>, Jens Axboe <axboe@kernel.dk>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Alex Williamson <alex@shazbot.org>,
	Krishnakant Jaju <kjaju@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	Alex Mastro <amastro@fb.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v8 06/11] dma-buf: provide phys_vec to scatter-gather
 mapping routine
Message-ID: <20251119133708.GM17968@ziepe.ca>
References: <20251111-dmabuf-vfio-v8-0-fd9aa5df478f@nvidia.com>
 <20251111-dmabuf-vfio-v8-6-fd9aa5df478f@nvidia.com>
 <BN9PR11MB5276BC3C0BDA85F0259A35058CD7A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20251119133000.GB18335@unreal>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119133000.GB18335@unreal>

On Wed, Nov 19, 2025 at 03:30:00PM +0200, Leon Romanovsky wrote:
> On Wed, Nov 19, 2025 at 05:54:55AM +0000, Tian, Kevin wrote:
> > > From: Leon Romanovsky <leon@kernel.org>
> > > Sent: Tuesday, November 11, 2025 5:58 PM
> > > +
> > > +	if (dma->state && dma_use_iova(dma->state)) {
> > > +		WARN_ON_ONCE(mapped_len != size);
> > 
> > then "goto err_unmap_dma".
> 
> It never should happen, there is no need to provide error unwind to
> something that you won't get.

It is expected that WARN_ON has recovery code, if it is possible and
not burdensome.

Jason
