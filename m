Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4C831C595
	for <iommu@lists.linux.dev>; Wed, 10 Dec 2025 11:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765364927; cv=none; b=mGkp0RJvSTHq71IROXDOMXZDxVqRPTjXTuoXaH+4w8oaTc4MUhl/A5hoNhJMCi+Fh0KdOkugJI+yiQ3AmAPohrwEPQZfJI4dFcejYKCOmqcUNGiamQn7YI2dAyHb+BBrmchSJVgVzThvX5+DW/VQsEEosp3dKBqHeNiql7OPSNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765364927; c=relaxed/simple;
	bh=xG2LKaFdeFwFddZxuqrbZWFjLxnAoxQlQuYXD8DlDXs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=J+Nf0jwVbnuaWeQebCVlOoZzaowElSWBuTc4DNtmyR6SxxBTOiQauhKktsBmx9BskoKC7p8PtjK3ukjnJfcG1rvsEA728VSU7rEqYzpdbPMcGeDjaRhuNfkBkStO6cnEB++grTCkn2dONFrsSRoFqplyfOPSCvka5C0KAwgK7RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YIq08/Iq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YIq08/Iq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765364923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dbN0X68nlefB3xcMuCNuqErFYMQLXoas1dJiWtK1NzU=;
	b=YIq08/IqxBtqmQY2ghgwSfidOb9iVpkRvL9gyd3LGI4oq9Hl8RCryW3BDacTgGfem5jOae
	sKhBHB8RcyUOr3Qr/OWVHw52Lyi40Z3+usBU6LYCG0xJX8Dp6eGThPHCVkW6SYToAEZykI
	5S6rTxozZS3PK919zfdb2UMeoJQl0js=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-hhNKskc5MyKz0oRBlBkNZw-1; Wed, 10 Dec 2025 06:08:40 -0500
X-MC-Unique: hhNKskc5MyKz0oRBlBkNZw-1
X-Mimecast-MFC-AGG-ID: hhNKskc5MyKz0oRBlBkNZw_1765364919
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-477b8a667bcso83428155e9.2
        for <iommu@lists.linux.dev>; Wed, 10 Dec 2025 03:08:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765364919; x=1765969719;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dbN0X68nlefB3xcMuCNuqErFYMQLXoas1dJiWtK1NzU=;
        b=r4HrgI2UjedgJP38ReTkYpxuG1Y/1zm04NQ7Oq425MYr3lbYOgF1ldjT1KvlnM9euJ
         E82ZUeFq8jqXZBc/nO4DiN0hoLvMXSmrGOzFeaTLT1SnmHMpg0BJXXde9S/a0uLbI/Z+
         75xPsK5oUBEYeimNUPlYpltU/Cql8lySI5Uk2soNC1lKlz8VEIhrnHS6Chk7IlqefwgH
         HNX33kbQ236YZbvjsvHoUKB1r1hnX3qHzJaLS1+GvXfTpO+xbSi0mRC1K9TNRHJ32rBg
         xQsNkYIAMnc1GkflwwWPAigMaJgXGtEqbIgpN/qXvTUhUs7kDpV44yYMDTLVcYfC5GNl
         q07A==
X-Forwarded-Encrypted: i=1; AJvYcCWdvfYkz/VQ13Ta/9FWMU4xTv1czLwK2NygBoDLsEjfrNd8w3srHFRXPbVZYFd4Iz6q4mnGfg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxZbQk5w2bbX6lYMJZG4uk50O/B9rBF2lPa3tJOWW4eHNUxUOXz
	Ey4UlGun6p8V1nW5/Syjxfbf+1AbTPOYT0os/lzaiHhh+szdcXgRb9eOVmv9c3nTnOrX5L8syyg
	HL7R4lAMlnkkZ0HxSVs78Xden2/XuUZ9Tk9s97qPEssuoQgByXZpBqh85
X-Gm-Gg: AY/fxX7bNp81A59OOohdaNhMvEqfdlL7Y1bua6LcWa7t+6phngwKSZNU1O1SeEVW1o6
	jhfG0MVdMsd4j8uqeS7I5lumrtM3F0zXzjAspE4rKQb721T8gZ7iI88gKDzsst8JE5R9JVbU/UF
	PhRW358LjccTrXgGr+eSUJHGgndhnlg1E1Vdpm75Rt5hDArZpcr4eTUuLZvlD8DuxnL5ygmt5RQ
	rvWelhFO1k4vCnZZBbcnU+bdWXuSYRTnWlJ96bzyXY2hHmARH8HXJZClrW6kvKKX1HLL67e0qBI
	c6dfNEE9tywIi0iXvoSXLHtI53ftwiRFyksRU61JLmwxAUx96o3RecnMi5Fu24lm9PhUfGPiNk5
	oUyDGQvOlbPSUJzlp4t8gRz35ArRSEsk/HvcSBQyyTt+bFmJBi4c+RpEmhHk=
X-Received: by 2002:a05:6000:268a:b0:42b:394a:9e3 with SMTP id ffacd0b85a97d-42fa3b00152mr2209756f8f.38.1765364919262;
        Wed, 10 Dec 2025 03:08:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0OaN9j3Rde1ToL7S2gPoe2gtnyWZiRtxW5eKFrQy2596pkXnfcwP8FxRZ0y1ST+KG1zmerA==
X-Received: by 2002:a05:6000:268a:b0:42b:394a:9e3 with SMTP id ffacd0b85a97d-42fa3b00152mr2209718f8f.38.1765364918819;
        Wed, 10 Dec 2025 03:08:38 -0800 (PST)
Received: from rh (p200300f6af498100e5be2e2bdb5254b6.dip0.t-ipconnect.de. [2003:f6:af49:8100:e5be:2e2b:db52:54b6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cbfeae9sm37425520f8f.13.2025.12.10.03.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 03:08:38 -0800 (PST)
Date: Wed, 10 Dec 2025 12:08:36 +0100 (CET)
From: Sebastian Ott <sebott@redhat.com>
To: Keith Busch <kbusch@kernel.org>
cc: linux-nvme@lists.infradead.org, iommu@lists.linux.dev, 
    linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
    linux-xfs@vger.kernel.org, Jens Axboe <axboe@fb.com>, 
    Christoph Hellwig <hch@lst.de>, Will Deacon <will@kernel.org>, 
    Robin Murphy <robin.murphy@arm.com>, Carlos Maiolino <cem@kernel.org>
Subject: Re: WARNING: drivers/iommu/io-pgtable-arm.c:639
In-Reply-To: <aTj-8-_tHHY7q5C0@kbusch-mbp>
Message-ID: <acb053b0-fc08-91c6-c166-eebf26b5987e@redhat.com>
References: <170120f7-dd2c-4d2a-d6fc-ac4c82afefd7@redhat.com> <aTj-8-_tHHY7q5C0@kbusch-mbp>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7CMEPGxQu50jC-MzgrqA_Bf6-yVYtrQuddbrCuySIN0_1765364919
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 10 Dec 2025, Keith Busch wrote:
> On Tue, Dec 09, 2025 at 12:43:31PM +0100, Sebastian Ott wrote:
>> got the following warning after a kernel update on Thurstday, leading to a
>> panic and fs corruption. I didn't capture the first warning but I'm pretty
>> sure it was the same. It's reproducible but I didn't bisect since it
>> borked my fs. The only hint I can give is that v6.18 worked. Is this a
>> known issue? Anything I should try?
>
> Could you check if your nvme device supports SGLs? There are some new
> features in 6.19 that would allow merging IO that wouldn't have happened
> before. You can check from command line:
>
>  # nvme id-ctrl /dev/nvme0 | grep sgl

# nvme id-ctrl /dev/nvme0n1 | grep sgl
sgls      : 0xf0002

Thanks,
Sebastian

