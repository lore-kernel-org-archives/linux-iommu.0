Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8241401C
	for <iommu@lists.linux.dev>; Sat, 15 Mar 2025 04:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742012580; cv=none; b=cYH9WRt6bg4+ZThcdiNzQw1nPnZr3zbx2dDgepul3G54IGPRJ45vbZfZgNvqNq6JhxU3Py7MBa3C13prapH9683AEc9I8Ww5YlkcB1059IgTIskrDawznxRMqE1OoYgxc4PfjUf5SUHZ1Jguq02wi3/0EonRMnrQ7jWzXYlhgBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742012580; c=relaxed/simple;
	bh=62cAPYMM7McY+lfAzPASnTQs7MNpD7FPMLJg83ACISA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jn8fVP0tczBsXeRnP80/2eysFbNYg9L+AtmiYZGdjOk4uOmia5JOGVwZeun4RV00AIS5k9PwrsTtXmETXEZIOGM1S+6ClGwCQwM4mI3c5AIJAHn4+60b3IK1C7tEOp8Cfauhkm5jgJeF22W8lUtXYDj9dQLX0Z3FEAk9H24vjxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22355618fd9so55019735ad.3
        for <iommu@lists.linux.dev>; Fri, 14 Mar 2025 21:22:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742012578; x=1742617378;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S8U0K9FXB2qvtYU3gfOpe3vKzPjFe6pziSzCUKKq8Ck=;
        b=HQ/57nrMr5C6AaiOI+EeFFH2o/8bPovdJhWhmcXILK/m5jTDBM8YZG9MLoKQw/9PFQ
         skQqOHfSpU9PhlhUcON+WIV6DDpbYwkW4OVL0Jl0hGUFEnyAFmCvE3wg5aBKY0Hst541
         4+txlh0xdt5ui4VqXkDOPmBpYQ3YCXFbyxyHn7nNYRdpFzreEEduCsy0ez7tFcp4IJXO
         52L2N6Ikef9LDbKiV8zqoJrjAF/ul6sa8OBynd8av1IR+kpd1FoxlQrf/tn9wU11CGx8
         C3Pqiab5jrgyDmpGTj/gTSeSJNT5gqja2Rkx3nz+bTlmOb4se4OTyTApuBOYNxMEalTh
         KT3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXYF/a5fNjRVqDHB6KEl/sBAcBUZ17kj3SU1OB45aDnN4LbPMgCk8bzp62TLaLYBOaS1KHo2w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy8PRx/q4AxXHEiuk0cFBdXL7/3Vowo8rUxA4rBHqx5MuJQ1axz
	FzBwhRu1q2c9uKnFkQXi0JgIGihIJ7QqNcMN+vjIoISgFW+rPq4pz2u0OZQROB0=
X-Gm-Gg: ASbGncuMg0IWox+pZDKVTGROY7KZuzbTmD0g7iUGyXGZPMwK51lSV+mSlUwA7QSRNbs
	2xyQntgC5H31LIKEYbKxnKuskDX1SLm/fk83NSg47/cyYyfLMqMr7Jk+GscB/N9yfKuQVmIGH4V
	LgBuridxERuOrcs1z/Dz97u+WfXwGxYpeDln73DTkDKSwj8XCpImwjP/0DqIIMBQKwvlc4uYDDz
	iV9vBC4/ulPeBOJNFktjtQBbcOml8wvRb66e2JL+TlF3/cY6RrPSWZUztQXhWCn6/1NUmhcU0Cy
	Kj2+w34i554rayDAbIlPYAu5f03V/WozC/lQxbyerO8QkSUGyg7L/JC8ItLqIac0PM73Mm8g7ta
	AmNw=
X-Google-Smtp-Source: AGHT+IFtwnMOAfhZFXJUuPvRbPNil1y66u0LQojOfo9xwTKXhrNxUpg+Jt9bo+ursNMjjPZwyt/xsw==
X-Received: by 2002:a05:6a00:21d3:b0:736:6ecd:8e32 with SMTP id d2e1a72fcca58-73722470508mr6460907b3a.21.1742012578020;
        Fri, 14 Mar 2025 21:22:58 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-737115293desm3673106b3a.9.2025.03.14.21.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 21:22:57 -0700 (PDT)
Date: Sat, 15 Mar 2025 13:22:56 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: declare quirk_huawei_pcie_sva as FIXUP_HEADER
Message-ID: <20250315042256.GB167520@rocinante>
References: <20250314071058.6713-1-zhangfei.gao@linaro.org>
 <20250314162838.GA781747@bhelgaas>
 <CABQgh9H_vGTPfB_dY+fT9gsWw5K53o0MBXf25LamaxBfVc2-Qw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABQgh9H_vGTPfB_dY+fT9gsWw5K53o0MBXf25LamaxBfVc2-Qw@mail.gmail.com>

Hello,

> > bcb81ac6ae3c is not a valid upstream commit.  It does appear in
> > next-20250314, incorporated via f5a5f66e2791 ("Merge branches
> > 'apple/dart', 'arm/smmu/updates', 'arm/smmu/bindings', 's390', 'core',
> > 'intel/vt-d' and 'amd/amd-vi' into next") from
> > git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git.
> >
> > I think there's some value in keeping fixes close to whatever needs to
> > be fixed, so since bcb81ac6ae3c came via the iommu tree, I would tend
> > to merge the fix the same way.

I will drop this patch then.

Old commit from the PCI tree for reference:

  https://web.git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=quirks&id=0cc24e705588325583f2b77662de61339548c39c

Thank you!

	Krzysztof
