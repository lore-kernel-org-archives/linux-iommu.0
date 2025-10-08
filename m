Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99392BEFF0
	for <iommu@lists.linux.dev>; Wed,  8 Oct 2025 18:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759947054; cv=none; b=oq/zQoRnuUk3yo/j2aUVXyu0Z6CDrxmHsg9wklah4r4OdlvRQtpTPanbJ+2szCcbZprsrws12oobAC1DAz9Xpv2pebTpRX9uBxB5uQgqjxmUJa3/tpr1wHTPVUepuzRwl08ivNi28y5yejp2xGSxAJzg5UJcD7iK18kI7/inS/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759947054; c=relaxed/simple;
	bh=R7bhRsHgsGdQvD5A36Q4KsbjK8LfsQHzx+qwMdc6W0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YQdcG55FYvzpGlF6aQD3tRjXmMj7w6G09ftAV3HsKqHttVO4GEeOqBS1gsBxKR5/KHEvB+po7PU7f6GaiTy2WF/YDSsLuwrc/yAvHDiyJVRrG3YX+g+LKSVwg2O1lMZ2oLW5priwJ9rHa0JRpbEcwC99yM51VUycbHZZFuGClM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=M6gRL/h5; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="M6gRL/h5"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7930132f59aso151177b3a.0
        for <iommu@lists.linux.dev>; Wed, 08 Oct 2025 11:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759947052; x=1760551852; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Uj37ChrtUbB/AYpUwT6DPbeSkZ8S2CUiy1YBfCcIMAc=;
        b=M6gRL/h5VZaSCkvbO2x+ymTIsINGRWkU6g/GXYRo/XjQIOOQQWGRkchyzLwlKvfcEx
         AkVyurlVnmb7n5r3cpWmK6Igj0v0FFUUHfZiGJZoduun4378+oVeo6H0DlrkbDgIHRMV
         t9+GD2/nsgRv0mxxY/FmVWsQA1wWOAWOjsd21+GSeJlne5pP1KQW8J4GZb3c8FYNS4IB
         mPlNkBXLJhnl5hM5jGmTJByRAZFvio0c632B1snDOE1TGezQiq+PimQ9oC2QsM/cwOCS
         XBzXheg20ZBeUUh6nBbFY05ctt22DCYuDt2dwE/MUxtEFyapdZDpytEUcpqzpvPpUpkt
         8dxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759947052; x=1760551852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uj37ChrtUbB/AYpUwT6DPbeSkZ8S2CUiy1YBfCcIMAc=;
        b=KwuJMnbzWOjZMWyxAvLiX0yv1eAFI5zu4Y8cWMk3Fdm4M66om8mGg82CyFxLA2iCAy
         qb70tFdlGltqmuu0uwbWil0AvHtVKq/X0TMbKQLQ356Zg/bVq00woUYQcwd4yL6c2A5n
         55wjd1/q71D+TJ0QRw26scTKOKZGgggewwr9Yu9ide06j34suDaxg2bK+tqeY5PTbR9B
         yyhZzBfSGROzPuycNTJDg8eY5Su1742B5XPt7+aeA/2rg44V2fe5Y3mrL2HqRgxZkM1E
         dVB0Acqhc1thPgRKqcck3uWnJK1YNPLlKQPk3YgRwyy94MnExIz9x2MQTrejlaPYofep
         rtlA==
X-Forwarded-Encrypted: i=1; AJvYcCUl43d9c3K4RBtFhVbZFJAb6jdtOFy89LW/cXqPNS00V1lOPu2F6iqYR86xUWvI+2kI6riXyw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxfprmIp++LAyUzA46xrO889qnXxxp+XmhGrpixvi2k1pZ1sHAC
	gdTnVqhcI27K/xQ1sp2N3lAdI0e2J3vyRxzKz9N4/FOGSR96AeNIivUqy7UKHL2Xopw=
X-Gm-Gg: ASbGncu+KGTYwF9PPEQDKfBPWOMYBkW3kSx52oYHm3a9edXMXOTLasrsO8tkDxsIMAL
	Gh3BU+PuUA5Jtki/Xt3vqAxnU/KgmzeA6c+lFLtmacy9qiUvWgbnSzad9+NiYsU8wC2XPzf4piH
	Q4tZq4jOOgwRIaG5BnByBCKZpuC7r7mm/vdvqxLcOhmAuGQqihO8y0uLUftunOT5eqQ6l3stc3y
	cawQajWkg+r4XLAQRc35v6EhG5S0FtxK0Nq4AhzsY/6rd3wOl4HiXWZvCbuaQ829/L3sRIQRRvw
	eMo9r7V1J9B9v7W2UZ6SYc0PWXFSqCujxVcek7aoI9ZkrV7VRSaDYEQe1VdH9z0VgvopHp0rvc1
	BgT1irD9VihROVk9JS09/EA==
X-Google-Smtp-Source: AGHT+IGmSrJJTln0Rckoxqd9caMwgvpvSlEbbc2DiVubFKH8XU3waZCHMA9b6JvSrYUbQpW2fn4CnA==
X-Received: by 2002:a05:6a20:6a22:b0:32b:6e35:9050 with SMTP id adf61e73a8af0-32da83dd7cdmr6035562637.35.1759947052195;
        Wed, 08 Oct 2025 11:10:52 -0700 (PDT)
Received: from ziepe.ca ([140.209.225.78])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-794d4b3c43asm393694b3a.1.2025.10.08.11.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 11:10:51 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v6Yck-0000000GA19-0vdm;
	Wed, 08 Oct 2025 15:10:50 -0300
Date: Wed, 8 Oct 2025 15:10:50 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+093a8a8b859472e6c257@syzkaller.appspotmail.com,
	iommu@lists.linux.dev, joro@8bytes.org, kevin.tian@intel.com,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	syzkaller-bugs@googlegroups.com, will@kernel.org
Subject: Re: [PATCH] iommufd: Prevent the use of nil data
Message-ID: <20251008181050.GA3833649@ziepe.ca>
References: <68e5a30d.050a0220.256323.002e.GAE@google.com>
 <tencent_E46183A88440D77C977DA6CBD37DC362A905@qq.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_E46183A88440D77C977DA6CBD37DC362A905@qq.com>

On Wed, Oct 08, 2025 at 03:53:07PM +0800, Edward Adam Davis wrote:
> The division exception occurs because:
> The denominator bitmap->bitmap is 0, which is derived from the nil value
> of bitmap->data passed in by the reproducer.

No, that just causes the reproducer to bail early. The reported
problem is divide by zero. Which is caused by this:

	unsigned long pgsize = 1UL << bitmap->mapped.pgshift;

	return iova / (BITS_PER_TYPE(*bitmap->bitmap) * pgsize);


  //  ioctl$IOMMU_HWPT_GET_DIRTY_BITMAP arguments: [
  //    fd: fd_iommufd (resource)
  //    cmd: const = 0x3b8c (4 bytes)
  //    arg: ptr[in, iommu_hwpt_get_dirty_bitmap] {
  //      iommu_hwpt_get_dirty_bitmap {
  //        size: len = 0x30 (4 bytes)
  //        hwpt_id: hwpt_handle (resource)
  //        flags: iommufd_hwpt_get_dirty_bitmap_flags = 0x0 (4 bytes)
  //        __reserved: const = 0x0 (4 bytes)
  //        iova: int64 = 0x0 (8 bytes)
  //        length: int64 = 0x0 (8 bytes)
  //        page_size: int64 = 0x8000000000000000 (8 bytes)
                          ^^^^^^^^^^^^^^^^^^^^^^^^^

0x8000000000000000 * BITS_PER_TYPE(*bitmap->bitmap) == 0

It should be fixed by adjusting the logic:

+       return (iova >> bitmap->mapped.pgshift) /
+              BITS_PER_TYPE(*bitmap->bitmap);

I will send a patch.

Jason
