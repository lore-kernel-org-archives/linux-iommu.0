Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FF62DEA64
	for <iommu@lists.linux.dev>; Tue,  2 Sep 2025 16:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756830283; cv=none; b=IX0w9HCrIJc1lG7zkI89Jlfl+QdALyYt7fuVRnseJ6vJOWc/JWauEQ4HcI40eEhiczYezi+J6nEaA9TnRG/T9d9TlaOK2igVNBycTqX1oXktByO/aDRG1dbOJWnYjatTAPqiQafbJgVIMUgQm7JuiNzlqk2qlcsK5iyYLprBPz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756830283; c=relaxed/simple;
	bh=pqF3A1jWAymNqoyZqZ1lyLwx5mWE7UM92rN5uoXyU28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rz4Ipe/W3YCtP+oAG4C2Hhknveqkgn0R+aXz1VG/GMn2RrbxSYQqwi5Od18i7338zERus+TCBYg65uvL9cvTprGKrd/8wPAmzJNLSp4yZrMvCVehZ37Kslf0pSMLZZPDHgoizDOG6hswzM2HHo0R16Rx8LeJhUWj6k15u4dDoIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Eso6kFby; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Eso6kFby"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7e8704cdc76so572891485a.1
        for <iommu@lists.linux.dev>; Tue, 02 Sep 2025 09:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1756830281; x=1757435081; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fhd34ic8mzL1CnzuBvjvCTALN3sKLJ7EfG+67QvagDw=;
        b=Eso6kFbyOSd6c/Smsypor3ZHZHVqTOZh2C09mIKXRsHs0x3oyqb+A4SwbDcl7Oscla
         srjloZeFVJaK33kbAMVCT8hpeL0oQF6LYe8hNkW43+D28xRwPfHqPQaXoVF5dtF+1iW0
         cKWg8LsM/cImxZ2IVhnwsOVaKIyXRla1g9tMzuSWH8MKAXa3Zk/X7rtF+XguhEgV4iWg
         +NYkFeNYqL+i4efkAchb6eKQBoyWevBfr3uv9Fof48WkIdolo9PXVdQBaD9sgwYeeebC
         xogdx31HzxdPO+woyWNHDt4AV8tbTfuM5PJQkOVPP04/3i5P7Wynjc+BjBYbatO2uEhR
         vZag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756830281; x=1757435081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fhd34ic8mzL1CnzuBvjvCTALN3sKLJ7EfG+67QvagDw=;
        b=toUE2Il9Mjty109r+s/eqhcHBaHQskp/OY/0cvjypVhoWL0mfQVip+3H+/S8huJjIn
         Ax7SSPcuETKO2sC0rDsc9u3I5H4YOWLAvsgVr0hdb/x29TCfemybqdf5v+jXW5WaNQBn
         SCskFo1xgZwsIqlwoRABZ0pwxYAFpQsj6cbZZQyKVo1kHhOeCGc5Su5goOuIZ0nG7teP
         qandORzX9m1VxQyVnEAALYypeaTDA3/NEy44G2fXsfC3OI+sS+J4OraY+8Iq4KNCTK+X
         M+LAc2NNnOTLQOvIytZ7Y97fVpncnjAEckvsqTt1gZaN1As/7p8UvRP9sEHaKgbZ66bA
         em8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXYvBRz2QRLFAsw/IdaBoApWTAkYe7aZuLNSMRcGP0k0bKCcUII9k6ya3D2OjEvBqyHGXJLcw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxq/uoqVaXubZQlUcutasog/B7K1y5/Kn04L6b8RTn8b6nivHwG
	VoU7UXNi0wrhoL8RJV+5riHhDAngMaIuDg2Fz8vLTiIrw+sWItJQ8gTuYTgLJ3hC398=
X-Gm-Gg: ASbGncs9+tyS+H54RjdyfsKlP6uVjTrRU5RjXnlGK1bI99PNHY7kZen5t7p7UsyIRzQ
	ljYfmgjz8IlbRIPO+QwFOJSaZtml4GHNITDXCrGz7kwaLubhEoLvvYK21vFRBStMf94qdTEQ6KH
	4YiXlulWYDDTNVrsNeHXyGxuGFK0PjwbP2XBRqp9o1fEYzzp4dmjNFY8QInwgGbb3CEuQZtVCYG
	wHP1ms+v4lBkhy+vS/Pz7pD1H/+RR0hqmwPKZqI/FQzoKk7ucdO9uBhf/413x9qEMtMFa6f5hlL
	lCcDsgQKc/7Oel5/AwsUFB+RhK05oTdWfKg2IX8zOAb02ghlgQaxobWEnDdREVJjse4u1c0RczO
	17pVCQMAqfvinjORM/AY2b6HvWX8dc4p9xmwauUVMHXx781M5+pvsvSsxDWnGXQxuUPVPmsvgwo
	k2lvc=
X-Google-Smtp-Source: AGHT+IFCmoKGYPOzoDZD6ShSos2kBzyGiUpy55RzSfApuV0xE2xqkZvPVRQqUDWaI6ZQr/kUBpd2Ww==
X-Received: by 2002:a05:620a:28d2:b0:7fa:3951:1156 with SMTP id af79cd13be357-7ff2b0d986amr1327141085a.39.1756830280947;
        Tue, 02 Sep 2025 09:24:40 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-806bb61ab36sm150217585a.5.2025.09.02.09.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 09:24:40 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1utToF-00000001ZQD-3cFQ;
	Tue, 02 Sep 2025 13:24:39 -0300
Date: Tue, 2 Sep 2025 13:24:39 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/omap: Use int type to store negative error codes
Message-ID: <20250902162439.GD184112@ziepe.ca>
References: <20250829140219.121783-1-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829140219.121783-1-rongqianfeng@vivo.com>

On Fri, Aug 29, 2025 at 10:02:19PM +0800, Qianfeng Rong wrote:
> Change the 'ret' variable from u32 to int to store negative error codes
> or zero;
> 
> Storing the negative error codes in unsigned type, doesn't cause an issue
> at runtime but it's ugly. Additionally, assigning negative error codes to
> unsigned type may trigger a GCC warning when the -Wsign-conversion flag
> is enabled.
> 
> No effect on runtime.
> 
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---
>  drivers/iommu/omap-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
