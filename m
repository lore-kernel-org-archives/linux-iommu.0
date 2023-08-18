Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0BB380
	for <iommu@lists.linux.dev>; Fri, 18 Aug 2023 03:14:48 +0000 (UTC)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-40c72caec5cso175411cf.0
        for <iommu@lists.linux.dev>; Thu, 17 Aug 2023 20:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692328487; x=1692933287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JtKRWgsVYEk0AE4kXRg/bBTMvFeVJKaONok/07eRRfk=;
        b=e/ppolFHXl/w4/fZqOofZftT1+guGIUrHqLDGQvNmOH84d1gVNbvskv7YSNzONyR5K
         IHEBAWxt4LUNiq9xpHQyZxH7k70dRPsruyTkBvebx69lHDVB9N2kjcOZq2ewsHFiponN
         avEYBSjXHk3wHMdAdEb6fRc+kK4D3Cc1Y/TM+EcC5HBBroe0yR0eXvJVIXC/f+h35RBE
         GfkJFH6sYe+otEwwyumQwFNMrl2D/fCTPpDIrFnD3sq31A28XrwHTdQ8XYSu388ELOlD
         FYr2W23FCrQYBv2OJtB074n4TXwkrdcxJAXtrrVGvSguOdU+22gCyO68EvaRV9fbT+ap
         HxQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692328487; x=1692933287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JtKRWgsVYEk0AE4kXRg/bBTMvFeVJKaONok/07eRRfk=;
        b=B6WNyuivQZHyZnh10Yrvnfz2EQrf+JNd1eqaFW3al6OIM3bmpZ9YC2mxqicih+U9+g
         K9w85XzCrZKeCO7VAgMkTrLeihbUSyAbiQqKErtkQyNIttdzqfkAZ9XBtl3leNFYarOl
         JqFpWkMvvQdFKIifws8EKqpeh9DCNMg8Q4rJZJA6M4Tcy38Xfe3I9GUJE1gFrYqq9wUG
         voFUv4dxvc6VIfUN0b7pPkIkJkKoxFEBeHrL2dqI6rn/OvYUEbZpdDPDsVbBx2IjJPFF
         ZV+rBDyq2mfFvWXFdv2v+qxV+FWCar3/Q48vQCa3+fzc4OFZAUXYxY6j9Y6tenNe+qBN
         40kg==
X-Gm-Message-State: AOJu0YxmJ2hZOD0VSrQCm2F2qfow4AXxhjDhS6jT+J/h6xLDq2Zg04ao
	a4UrFrpJSHLY7swJsq3woVUgc1SHOqroldixHC814Q==
X-Google-Smtp-Source: AGHT+IEdemrJerkEcXSt7+cE13JSwoldzgu3SXHNXtW9xol//Bv/TIibebBEZGjN41Gg8Ave2V7feet9RAbbEAKB5WE=
X-Received: by 2002:ac8:5914:0:b0:410:8114:1077 with SMTP id
 20-20020ac85914000000b0041081141077mr14560qty.4.1692328487455; Thu, 17 Aug
 2023 20:14:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230817182055.1770180-1-mshavit@google.com> <20230818021629.RFC.v1.4.I100c49a1e2ce915982965a065f95a494c2e9ad28@changeid>
 <3fc6ba4b-1e40-b835-06b9-b6d40f916d75@arm.com>
In-Reply-To: <3fc6ba4b-1e40-b835-06b9-b6d40f916d75@arm.com>
From: Michael Shavit <mshavit@google.com>
Date: Fri, 18 Aug 2023 11:14:11 +0800
Message-ID: <CAKHBV27xxvzK55C7nT8HgcF2G6SpF7ssxYK7D0+t_dS6PODE5A@mail.gmail.com>
Subject: Re: [RFC PATCH v1 4/8] iommu/arm-smmu-v3: check smmu compatibility on attach
To: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, will@kernel.org, jgg@nvidia.com, 
	nicolinc@nvidia.com, tina.zhang@intel.com, jean-philippe@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 18, 2023 at 3:17=E2=80=AFAM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> On 2023-08-17 19:16, Michael Shavit wrote:
> > Record the domain's pgtbl_cfg when it's being prepared so that it can
> > later be compared to the features an smmu supports.
>
> What's wrong with retrieving the existing config from the
> io_pgtable_ops, same as all the other io-pgtable code does?
>

I didn't think accessing the io_pgtable struct outside of io-pgtable
code would be ok, but now that you mention it I do see usages of
io_pgtable_ops_to_pgtable in iommu drivers.

Will change.
