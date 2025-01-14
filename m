Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EA4176ADE
	for <iommu@lists.linux.dev>; Tue, 14 Jan 2025 17:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736877248; cv=none; b=oXMEQrSjcNbsP3UxJxNZeNeIUQ8crlsw1rm82SVWU5eRYmd7sBpg21iS9WL14bIA8MGGHivPew5KfmyGDJSrhv5jDUtatD8iNw/l08HjC7QE2zUmALTWDN3sIKP3uR6EQq8ETBAGcsC00dZpPN2pLJqj0BGK2CgGQMOxyOYe6fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736877248; c=relaxed/simple;
	bh=kSuJ3mN9wNcjimoqX2+ynSqvhqVDCdhDEuVwg4Xhe+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XBFokBwrku+xYv3G9xql9t4Ac6P34N1dEMNDjYTc9AfLLOCMU4BOYdB4H2/hUzicLW7WzSla469F8fajWWVcGMEgpNMgBTG+n5CTnp36Y67aZwhY8v7O+E5sNeih8qdz11mhLTyUj35ckvTXEHMdllm/4QVLk6UUq7eHwvMy9NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=kwsnI1TA; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kwsnI1TA"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-46783d44db0so57774221cf.1
        for <iommu@lists.linux.dev>; Tue, 14 Jan 2025 09:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1736877245; x=1737482045; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mINefyrdNhvGcAGjffpVPeJdsAxn2rONefBHfd+bibg=;
        b=kwsnI1TAmEqyXiz//8th7YBMPRi6KDA72rNESJOaD7JcuYTwj4RY8J1044AmF6oM0F
         Z1MEHtfJcYyBb+u5QGUSzar8tGQOjK3V34B93jpTPa4eg++FnFt8k/EcI7WyW8/YP87Z
         gumLKwodjvKcJPgNzvPBow4jV72mM1Geo7LajS87h+QBxw2Bh/HvrKJHMRJ7jYDHc2UJ
         lFYM8LE70B1ugoteT6BcXFNqxBmzdxDLc3aTzE3H5C+S8yNSxNtqmhenRiUQ/uYHVLuO
         QnsjiE4Gm8kOnk5ltTKIEg9fK0ebs/0RziDw3ZtnurA/4ViA9wFq8FTytFL7jDiVmmC8
         VXbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736877245; x=1737482045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mINefyrdNhvGcAGjffpVPeJdsAxn2rONefBHfd+bibg=;
        b=c4bS7yKhDEL4r4kVmbmXmwwbeBFKuvxnu1x4cRzfWSxSnE180miqazpg1l5yH4PqQm
         8m3M+mkcFz3dSPmHUlmSOoPvd/yJZfzZpl3BLuSWfQe5Hc7bNNIugn+ers58k5gK1s8u
         kgCPI8CefjrsYXlzIUq6t1qtBl6PfOFOJInOufwy1gED44oPB0w56cY4d6zu3azt8stH
         fcTtBmeVhb5Wyj+y9W4TUKSlR9V62eejeM3c9q5yJ68GueAFuI4uC2qg+ma585n0ZXA2
         03NrwMtGCJxFeQOagl2w4nnsLU5rn03NR0N/K0MQHYIHsFDlEMYZvKUH0UaO9D21rUyw
         kUlw==
X-Forwarded-Encrypted: i=1; AJvYcCUiAM2vD4VZ/bwwEpiqgmnKM+Pa7aV4+EJtnlE63BFhL6dfPTMk5NtQbE08+C6MXhlkCXbJ+A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxwzOwljFsxvVLpnhOlJF0NK1/cuM5P+xyYiavArhSjFC/xA4AG
	8ddoPoMJrgusJWArrpJE6hGAamNHm1O9OYNybP4SN8Rz6ZBMHyZYvd5xjL4Ol1A=
X-Gm-Gg: ASbGncuvdRvDQBVGzX+cVe/enTp493y9E6iZoMOFooPtYDbYqfdSE6nUojxbY64Bwgw
	HA1NYUvtB6KWE/EcEkMdhbzFvhnEd5q0eyscvKkT1FrIZfg275vfRkOGoH+DK8JaGLlve1D057G
	B00O7qOtyhyfEXskCg0DrAvBCmgh4ZciF33DggOr1ijo5irW46F9Ir7dRS2DAtWiOpDSnPabf5e
	8JGzNMVw9g4YAXdb21J3W2LoQAGeDeSWVEQ9rdoSf96cyNIsT1GGVlCmMP5YdoVakVKWIYHQ5l1
	OSCULVTy/tUMIDmh/wxkDh/XJNmEtg==
X-Google-Smtp-Source: AGHT+IF0bqJY679rWk3hHZZyqaZ3/i8agMtreEpHxxrVchKDBg/QKPQaM5QFHOuP3wTvHa0TYcOpvg==
X-Received: by 2002:a05:6214:495:b0:6d8:a76d:b66c with SMTP id 6a1803df08f44-6df9b2b33b0mr347773016d6.30.1736877244760;
        Tue, 14 Jan 2025 09:54:04 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dfade89277sm54792846d6.108.2025.01.14.09.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 09:54:04 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tXl75-00000002P9t-29DO;
	Tue, 14 Jan 2025 13:54:03 -0400
Date: Tue, 14 Jan 2025 13:54:03 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Qasim Ijaz <qasdev00@gmail.com>
Cc: kevin.tian@intel.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	syzbot <syzbot+85992ace37d5b7b51635@syzkaller.appspotmail.com>
Subject: Re: [PATCH v2] iommufd/iova_bitmap: Fix shift-out-of-bounds in
 iova_bitmap_offset_to_index()
Message-ID: <20250114175403.GO26854@ziepe.ca>
References: <20250113223820.10713-1-qasdev00@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113223820.10713-1-qasdev00@gmail.com>

On Mon, Jan 13, 2025 at 10:38:20PM +0000, Qasim Ijaz wrote:
> Resolve a UBSAN shift-out-of-bounds issue in iova_bitmap_offset_to_index() where
> shifting the constant "1" (of type int) by bitmap->mapped.pgshift 
> (an unsigned long value) could result in undefined behavior. 
> 
> The constant "1" defaults to a 32-bit "int", and when "pgshift" exceeds 31 (e.g., pgshift = 63)
> the shift operation overflows, as the result cannot be represented in a 32-bit type.
> 
> To resolve this, the constant is updated to "1UL", promoting it to an unsigned long type 
> to match the operand's type.
> 
> Reported-by: syzbot <syzbot+85992ace37d5b7b51635@syzkaller.appspotmail.com>
> Closes: https://syzkaller.appspot.com/bug?extid=85992ace37d5b7b51635
> Fixes: 58ccf0190d19 ("vfio: Add an IOVA bitmap support")
> Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
> ---
>  drivers/iommu/iommufd/iova_bitmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to iommufd for-next

Thanks,
Jason
