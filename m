Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1533F54B7;
	Fri, 21 Aug 2026 06:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787292830; cv=none; b=TiHpC8NRrBWyi4WLEj4bPjmRUclOu9CUn7yN0lRzZdidOevUOyPmCVncBzXIsmFze5N/2aARMPvxYhMbxqbnPY0KRu6WXGhAtwtRGCTjeIO2cRZ/kY3Mlpp1dhmbQOgMyeY89RTjbP90JqQQc5I8bTYfa8Xv6QvHqqi7fwA+anU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787292830; c=relaxed/simple;
	bh=IaSY1zLQzsLvS8tp6oQS/LIpXZO3z2pbEwRmN0+TGzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jpsKI83GpwZXyEDM8GL5o0rAGte7p88OtIYBMaznFR02lZNYj2e3XqiV2FiCNWxWeXiZSdq7NngCDf9DyfuVP443Qfq52wtH2dSGO4UCwSEhMPA7h4YIFmoF8RC8JTNj59VsvS7v0zCCmS9amt/DPS0IrBYdbJzqMeUTKRFNWYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aLJCHC4u; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aLJCHC4u"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=kZ0Jfkk5WAnZYcRDkxeWD/VnEJKts8Z+a/mml1gNlxU=; b=aLJCHC4uwU5ubxKfbRo2dtE6Cn
	6ZiKgiuVxdL2AbQyJB1aTgyH5pMGgzrVaBg/re74OZQ9il4+cLQjoi9KTL1cnOrgaZy3kmkqnCqIj
	ecVn560S0OGUNDmgWaWNhLsp6W0t2J91kvAgh69EUmHF7DajDqcIwZIT0pz7n5Uf8Ee9DfJulOILG
	OuNs/zocC7ys5fGFq4XxLOmQWt/FWFsbTfllFejAxivRO2yEoOMgmaY7LNQJY7rpQXIz55tX9Lmns
	1n8+IZ8IUMYFHneAcWGkoWEJ59VWJ0qHKdR41FcVj45TfyDaVTKMtvLsCA5w0riYRjgMXcyQvnNyj
	mXP9j72g==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxIVR-0000000Cath-0dja;
	Fri, 21 Aug 2026 06:13:33 +0000
Message-ID: <352a7732-86e7-437a-9e2e-e1e117bbe95a@infradead.org>
Date: Thu, 20 Aug 2026 23:13:31 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/7] iommu/amd: Provide kernel command line option to
 enable GAPPI
To: Sairaj Kodilkar <sarunkod@amd.com>, "Borislav Petkov (AMD)"
 <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Breno Leitao <leitao@debian.org>, Christian Brauner <brauner@kernel.org>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Eric Biggers
 <ebiggers@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Kiryl Shutsemau <kas@kernel.org>, Li RongQing <lirongqing@baidu.com>,
 Marco Elver <elver@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Robin Murphy <robin.murphy@arm.com>, Sean Christopherson
 <seanjc@google.com>, Shuah Khan <skhan@linuxfoundation.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Thomas Gleixner <tglx@kernel.org>, Vasant Hegde <vasant.hegde@amd.com>,
 Will Deacon <will@kernel.org>, iommu@lists.linux.dev, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org
References: <20260821055611.27138-1-sarunkod@amd.com>
 <20260821055611.27138-8-sarunkod@amd.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260821055611.27138-8-sarunkod@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/20/26 10:56 PM, Sairaj Kodilkar wrote:
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 97007f4f69d4..7bea1bbaa0e0 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -455,7 +455,8 @@ Kernel parameters
>  				          to 4 KiB.
>  			v2_pgsizes_only - Limit page-sizes used for v1 page-tables
>  				          to 4KiB/2Mib/1GiB.
> -
> +			gappi           - Use GAPPI instead of GALOG for vCPU
> +				          wakeup notification.

Is GALOG documented somewhere? Should it be?
I can't find it...

thanks.
-- 
~Randy

