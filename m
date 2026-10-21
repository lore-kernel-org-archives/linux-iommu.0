Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792626411;
	b=fA6IpjPbjyvsts8WHa3iNEsPUVkDisafsj+JWVRNHnb+rVYjvhaiLQ9l8KcEfhVGLjoO
	 eFCUZenvUlo4zyuAFQ2ipRl16b8uAUkpk5rgLCiHHvAxEILCY3dPnXk+F1RcbANwDJpLS
	 gjsIaxWfnPKVTYvmBL7CxSWl5JcP63n40BH2ye2XhtgXRPNa39KILeuLwBHMxLETES/Cb
	 qvz/eEcaIMRVilAsE84vfUHEqiCHt6zSCiO4fljTFlL0uuXX5CeBTPTGQTG8gUqt4H+aH
	 AXGEi4LzGOMA9ZOlFcWpCW/AeIwAYj/MN99evBOy0/m3zzFqD5Yiiz0K478oPBS+ZJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792626411;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=n5hOymfjgaz7xpjT1ssIdHSQ+wD4cuNPKUAfRnejzdg=;
	b=oIfIhQEiXCHjgLEzaIBzgFxybwvz+VfVMdghZDa4+AjxKmjjRsq9xQZ4e3GSZVwh8Eds
	 WPDP5u6hIYiCI4fhfcI5mUfkS4jznh+GkLHzlNNe0DHfwrYPOJjdnkradsWtpE0Rn2fly
	 FovVzP7OZ13AvuXAfI/WyS/lmecE4bwN5yvLqvLidlQq5cqyTX9GamHDrVm6RxdIWqLTM
	 z493l/oP3i08pRmFp7av8PNObKy4+eC/CEEKnzYeysw6xMcXa+nJOANu+5xIXaeVWtXu9
	 JcqTXmIKdwuGUIWsBm5Tz4YORJ3tUWjT3v3nZFUMDnhELNAFZriVBUXxwa7bD00QSOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=KWnBHPum;
	arc=none smtp.remote-ip=209.85.222.175
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87ED7606A321
	for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 23:46:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87ED7606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=KWnBHPum
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-93e4c00d71aso139993885a.3
        for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 16:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1792626409; x=1793231209; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n5hOymfjgaz7xpjT1ssIdHSQ+wD4cuNPKUAfRnejzdg=;
        b=KWnBHPumlIiZl0jzg3lfqSXvwDJpx2Zrr9xZLlv8hQrkjgxNf7+qxnT6i21qYDF6t7
         nuUW1MTXrjaTVrm/v7f4En1Kz8OGvaJ4FMuwtVZ7wXpgCeHN7YY8z95A29mjWu/urkEx
         UkVNYUVetXsWN/qEgXvPuS9V3gVqh8oU45iwc6Y/gtuPQiebrSLUTMFBNNwo3Dkh3+CV
         IlqG3O1ZvgMbv7uS+hzHUXbdKL4b8FKZ1GZ/S6NNBBa86Dm78GJMLANoQbOLlMbcXUty
         fFEO0m2zSkJcSDDk6T4J3ZENCSqdGip5q5MGgmtX0wtIiOX4m3E4pgGnBFwLv0f4BBTe
         2PMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792626409; x=1793231209;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n5hOymfjgaz7xpjT1ssIdHSQ+wD4cuNPKUAfRnejzdg=;
        b=FNs0rkWFwUebaWAljpb0gHXGZ4/OlOuQem90ppWgE7Z63owm9DwWbA+NUDOLUgEJh6
         PqRoyiI9c7OFQHXBgL2M5O3Cf7yFhrq+jkXMlJ2Ik1L8e9fCcwzrLRebvAFD6XcftMjg
         UM8buyKRGpsAe69QOZhLxpKZmbF5Rc4U8ROx6+K+FrZZVo4QsFJTVoGIgsI83r0+Yu9D
         cm208h2vEreoCe/V5K+mGMPdpvU9DcvWgQqv1gy3akQQ8ZIkZRwLDmqoa/TErzTsXiNY
         w9C1qnExqef4zbqUlD7RbXoDIQl3yqSrLLo5dxLrkeX+c1oA3aa4MCAvLptqdFPKu9PJ
         SP0A==
X-Forwarded-Encrypted: i=1; AKwUvBylDykbj+O9AgkFkCZ6nnbm9RcRrzw/fFHcZB2TMKgIyAL9nUr5y0kYqLMxOtjxk2bh2qPIxA==@lists.linux.dev
X-Gm-Message-State: AFq9FYIk7czlcMJiIk0h5OPW5mJi3FtXt94wg1NkOYUSE7IELEy1tUDl
	FjHIHkpMP/74Y9aNiu6tUKi+GhD9PLHYO2vN03/W6eKAPg/RLQxKdisuDPkexqYxgHU=
X-Gm-Gg: AYBFou3G6fLBSRxGxP0MKIV7iRqhJyNrwrJHRpT45MaMNOjsCtnFjbaI7crcOt/sko4
	7UMu/5XKf4NTukyHVXdeWyEwmectFDvUJOTGs6E8CVKd1Omz3kvkFOf3hKHvcGlafCPJFEJ46TR
	mkOTsK72yepdeGt/KQbCQ983G5VCyEDRRwIiyTwTVAx5Vjx+nKTNy6D/h5Ple4ph0BO22AVqKkq
	/tUzkxY+mJ9zQWVzWjJbg6TrwYoeliEfJdjEzzzyrt7HD/xR9W8A44jJfxrNS1kswkBvnZ9nl6E
	hx90l5exLqAyhI93eFIz07Euqh7UTMzNCIUC0Z+R10FKRCiXx9m17B58NvGydNqHsseskpWkHS+
	Tvso0pZT5clc2D6/pxkdXXWLtMw3cBot0uxhL3bEI4tkxitKQhUzSU21qqQvIcbGYTfVxTSfCDX
	n01nRNQWxTx8mWDyh5xA0E8OXdOAVqgbzsMikvELVAGy63/h/LnD9EGLdBx/SmGbokyIZS3IsrZ
	AR11Oo3uOeVaT9R6N/yIrIcFueCVt59qNIjL/dUsgerxfwCyAudIN1l0QQuiZL5YlTEgx7BFOOD
	2WGdcViVHw5ddetHVHCRNb+eWTNV+BH2mSVqJYOqAll+5QzTbS0Po3aeV1w=
X-Received: by 2002:a05:620a:17a1:b0:93f:22f1:97be with SMTP id af79cd13be357-93f5800e406mr694136885a.72.1792626409239;
        Wed, 21 Oct 2026 16:46:49 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f56e2bee2sm373858385a.42.2026.10.21.16.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 16:46:48 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xJg19-0000000EWG8-3cjA;
	Wed, 21 Oct 2026 20:46:47 -0300
Date: Wed, 21 Oct 2026 20:46:47 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Fred Griffoul <griffoul@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Ackerley Tng <ackerleytng@google.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Steffen Eiden <seiden@linux.ibm.com>, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [RFC PATCH v2 06/11] iommufd: Map memory provider files
Message-ID: <20261021234647.GA3381610@ziepe.ca>
References: <20261014093733.90312-1-griffoul@gmail.com>
 <20261014093733.90312-7-griffoul@gmail.com>
 <atkO08eCJzLX6R58@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atkO08eCJzLX6R58@google.com>

On Wed, Oct 21, 2026 at 08:17:05PM +0000, Samiullah Khawaja wrote:

> With this approach, silently skipping holes during IOAS_MAP_FILE means
> iommufd has no tracking of which IOVA ranges in the area are actually
> mapped, which complicates unmap and could also hide a bug if a hole in
> the range was not expected?

I think if we are going to do this it should only work with iommupt
and iommupt should provide an unmap that is compatible with the holes.

There are other places that would like such an operation, IIRC.

This will have to block an access reaching into a guest memfd mapping
as well, so that should be OK.

Jason
