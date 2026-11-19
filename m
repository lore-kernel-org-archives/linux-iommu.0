Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795099563;
	b=WxIgse6R7nh5ROqemXu1TvtR+rAEAPGAqkzGBqCThhvvG+H56SO7C/nxX7JhIunnIcsN
	 6HKqBSdzXWOrbxTUJ6d52b/xFtt/QDdtnmr757eszUH+9dngFdUXXjF1N2BAVMZln4yGV
	 rfd8+8QXOvB9mhqSsV7WpaycSnMn0HgNZn//qhMc1e4vjMVh8ABIkMphUVtyE+Kvg8D0R
	 wvidRar4zGiVIXoFGo/HvVifuGCEnnOOnk+B7u7EKllF8sP0PLUKja0/BjApeDTGZMN5z
	 mzgrQd7rPB9fR71yeTJWQfgw6juLhF9z+1w9nZCuMj7YH9OIJdre4HTWtXabG+BE4bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795099563;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=K0vvm22Tug/EC5ewZBv/zjKwLCLUmqhbl916HUYk0YI=;
	b=a7ETdfdISfrXNYaWBeS7AFckiA+ocv/e5dBydi5K2rqHH6APO7nUGg8Q4M7DVBgWpOMd
	 DH7/WjPzBmHjQI81jhuYHPk/1iYA0lcK+/dsKtug4Che+9+mYCk31eAWgKHtfmsphAQgM
	 CNdxL70FfF4MHZS/MUDqoKUaS4RJADQ3JPqhh3T4woaMGl0ENHEBiWw2o94jSNi73+kBa
	 HH76m71StNXJu17CTpxEiJersZzybcI4MJIw4sMlxQz2zCaDMFghuAV6iGxt20HkTigdb
	 6l1B6BaEHwlv1lrk/sInH5CyDrPDsvzNNDYGOVapxJwErIhTknBVMdEyfumI6zt9HKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=HfC03N9J;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B3F606A324;
	Thu, 19 Nov 2026 14:46:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91B3F606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=HfC03N9J
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6A541575;
	Thu, 19 Nov 2026 06:45:58 -0800 (PST)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 746AE3F673;
	Thu, 19 Nov 2026 06:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795099561; bh=DOfpvoIOKdy4O9gXF4PEx6e6wrc7GUBajZXT+FF4UMY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HfC03N9JBgIBhW4NSJSoS8LsIbWUCwrCPrsvOJ2EOafsKDq8RZLQ2nWRlufNNlEw8
	 20Iiqg51qGhzc7pmC356z0XOVja5EMm7CZWFAK1hqm+NijNY/S34iFLvbV6Vnl1WWI
	 fizU6LB7AzY3UqqzYM2sVfVBsI9vHa1m4KXXsglk=
Message-ID: <d082a48e-2b3f-4d83-818e-9a739b6da9fb@arm.com>
Date: Thu, 19 Nov 2026 14:45:42 +0000
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] rust: iommu: add a paging domain abstraction
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Nicolas Dufresne <nicolas.dufresne@collabora.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot
 <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, iommu@lists.linux.dev,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 driver-core@lists.linux.dev, Detlev Casanova <detlev.casanova@collabora.com>
References: <20261112-b4-iommu-domain-v1-0-c29e86788dda@collabora.com>
 <20261116193821.GC2452510@ziepe.ca>
 <3EB4C2ED-B699-4532-A562-68B78F6E29C6@collabora.com>
 <20261117202055.GA3115493@ziepe.ca>
 <b145b2ceb92c73a4fa0477d7b3895a6e3b4adf99.camel@collabora.com>
 <20261118160909.GC3115493@ziepe.ca>
 <fe60c0bd-1ee2-4b33-8ca3-564ee08e6db5@arm.com>
 <20261119143435.GI3115493@ziepe.ca>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20261119143435.GI3115493@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/11/2026 2:34 pm, Jason Gunthorpe wrote:
> On Thu, Nov 19, 2026 at 12:24:50PM +0000, Robin Murphy wrote:
> 
>> There is a middle ground, where a kernel driver wants pages to appear at
>> specific IOVAs under its own control. This is entirely legitimate to do by
>> using the public IOMMU API "as intended"
> 
> Yes, but, we never fully implemented this because we never gave a
> cache flushing solution for these users. Which is a problem for safe
> rust to expose an API without any way to do the mandatory flushing..

As I say, the "cache flushing solution" is and always was that you keep 
using the DMA API on the underlying buffers, because you are still doing 
DMA from a driver and not in any way excused from that; you're just 
taking explicit control of address translation *on top of* it.

Thanks,
Robin.
