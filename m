Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DA91304BD
	for <iommu@lists.linux.dev>; Wed,  1 May 2024 16:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714579632; cv=none; b=SR4/KL6YF6x5W6+FckUy0FPRyeRYpySkGqj5CmOMC2CpmkJD125MN7recEHYVlgHibGM2U7UpwceSxJQvjbkT4rzx8ZUj2V8zrwoJ/k9bzt0CKib7RAP00O1+9P0a2KxFlBLp7mykkO5P3uq3FE5XeiVUu+XxgmtQqGvTu9CBG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714579632; c=relaxed/simple;
	bh=OBhqEyKuT9SGbY1gPylDuVYK6xBEaByxvLrKFZiA8D8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f8GKhzRQEIC1YazjQ/Z5rE/XQixfrqhTJhnC0bsqkq8nlB0vZ07NNpVAPEpd6KF3zjb0czYgy82sj1FkL5VJT89vsXlsZfhnAcwXeFAP9TPcir+yv7LqPdA7P1roNbyAApVuMDDIwP23MQoPZlu5H57CczsMhz7jXFGrUE/arXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=B+pqLwCl; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="B+pqLwCl"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-790c36dcee9so347940185a.2
        for <iommu@lists.linux.dev>; Wed, 01 May 2024 09:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1714579629; x=1715184429; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OBhqEyKuT9SGbY1gPylDuVYK6xBEaByxvLrKFZiA8D8=;
        b=B+pqLwCl9vfFvjVaX0dPOZmRcQAwYKrl4Yn7pWZiVwJSXYFp73xrk/HgHrgud8/xQV
         /4ZBWfU8iBV9JmoJTNk4/56Sb2mJg9BXLbEbeNUMQ1mYALqIrmta5XVDQZ/b4gfX0ydi
         tAZYGjOrzTY9EjRb7KnPjrykrNOzMM2fTsik8zGhlHEzmY7yTYGUo9bTC2WeQ/wOTEwc
         n3DygqsYnpxKOB9fRzccvx5cJiYWeOLeGNFeQJ4buUXcaEWtCHtkZL/Tb9K6eHc6yUwd
         MWdUk3ms0b21KLDwVDyY6niMrL287lVoUN6OfCAT+uwK2i+lHpV0zdoGQDASTUcOGrqu
         Y2YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714579629; x=1715184429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBhqEyKuT9SGbY1gPylDuVYK6xBEaByxvLrKFZiA8D8=;
        b=XjTP466tWBcmTpdRfjICvX0LexPkR8PT7L7W5UB3XG30P8CE2CnlDF0Y1C2rtnGIKc
         AOiGXdN6QaSmgcw8OZQXBw6PKNr+mp7Cez5J4IJ2dL0TShWhv7zx6oamn6QZXUPYmp6A
         B0M+3Rl3jy2mAFAEFh0s7CCmg/Lyevo5jX8TfF4sGDm5ojp9sh7Eu8mOmyUWnbF6I3vH
         GTiyLStTxniX2Lve7JutxrYbWmQHj/EE8BTGNN4XgPx94LZ6NeM5tkkShZ4VlxtcmPKn
         +2r2ZpCW2k3bF9pSKjTK5hQi7SyhBvJZj+0vNLAiEBgJ9zZp4bA5OJx1ZMkPUnB2T9TI
         hg6Q==
X-Forwarded-Encrypted: i=1; AJvYcCX5N3B8v7mKLTVD1pbnxqKx8z/dGowhSMLGvx7JyHdW7O60gr2oiBXC/X3SohuboR0Be4zs8xkNM+MedNz7q7AEPk+Lwc8=
X-Gm-Message-State: AOJu0Yw3sLZ1mjRUNVNr09iK9PACZL15Hbdstyyzaq9JV0WFCRFiYMJM
	TNmr2uW7WSpOE2sz3qvxRi4r8/iu8+NQkSFIoMRgfyWP+R/MmcXtUi++9V5yxbI=
X-Google-Smtp-Source: AGHT+IEIToKXo0oiLD8614cnvRWTKlqp8YbwZyKQg7eanOTB8s3Hn6dt4BqjP2UpzNxDw9ZcGXsFhg==
X-Received: by 2002:a05:620a:2059:b0:78e:e7dc:fd3b with SMTP id d25-20020a05620a205900b0078ee7dcfd3bmr2822573qka.73.1714579629470;
        Wed, 01 May 2024 09:07:09 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id n6-20020a05620a294600b00790eb55fd58sm3512214qkp.129.2024.05.01.09.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 09:07:08 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s2CU8-00DuqC-5D;
	Wed, 01 May 2024 13:07:08 -0300
Date: Wed, 1 May 2024 13:07:08 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tomasz Jeznach <tjeznach@rivosinc.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Anup Patel <apatel@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Nick Kossifidis <mick@ics.forth.gr>,
	Sebastien Boeuf <seb@rivosinc.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux@rivosinc.com
Subject: Re: [PATCH v3 0/7] Linux RISC-V IOMMU Support
Message-ID: <20240501160708.GF1723318@ziepe.ca>
References: <cover.1714494653.git.tjeznach@rivosinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1714494653.git.tjeznach@rivosinc.com>

On Tue, Apr 30, 2024 at 01:01:50PM -0700, Tomasz Jeznach wrote:
> This patch series introduces support for RISC-V IOMMU architected
> hardware into the Linux kernel.

It seems in reasonable shape now, at least in terms of implementing
the domain logic.

It would be nice if you'd run it through clang-format and correct some
of the minor misformatting it will point out. We still like to have a
80 col line limit in most cases. There are many overages here that
aren't well justified.

And you could consider the nitpicky style advice to use 'reverse
christmas tree' for the variable declarations like most of the
subsystem is trending toward.

Jason
