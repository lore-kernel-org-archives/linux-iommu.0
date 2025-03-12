Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DF5242917
	for <iommu@lists.linux.dev>; Wed, 12 Mar 2025 12:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741782064; cv=none; b=gZfRCvWYzZ68aRQ/5zMxJ77N2JRKN/+w65kokptTzLLt0BKVq47/dKdJhXDaeHI3uVAE0s4loc0ZtfMKcBqglXqL3YX5RuiN6jo8O9tOemSV9WdO4y7p5gc/pM7nKfo8LfR0JJX1oXq80FIlksBWuwNMyeUh82rYuclbOnC5GeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741782064; c=relaxed/simple;
	bh=iJ09daJ53HVao8dsXzATElDT5mJiZPGmcb3ZXQbducM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=E0mBk75GdM/+J+RYgrXUuflMznnKCQnsM62pDIbb1YOcOeeZ+QhHs/I8bD+vgE4YnSCBhNL2UE3COOq3NRdKmVFWAH3oxKVs6iOmBpp4J1Gi2TGzJej/QxlgRrFFI/g2seVW6Anpk06TS72d2RSdnAbQxBHsKoKWiMJiX6IlQJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=tLQ5xmDh; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tLQ5xmDh"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250312122058euoutp01bcc5f69a8519a76df2ead8c12f85272b~sDY3MOCPT2989929899euoutp01D
	for <iommu@lists.linux.dev>; Wed, 12 Mar 2025 12:20:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250312122058euoutp01bcc5f69a8519a76df2ead8c12f85272b~sDY3MOCPT2989929899euoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741782058;
	bh=+U1ynJkxs2rGYQERoW3bytPpZBMbqPPqILrXXy8wEWA=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=tLQ5xmDhNpqb78RxNAcjwYDwld7bKlN7yP1iFcCY9pmdfHiy0TaS8ecATzVaa3rcl
	 RyI/wn8E8EJyC22G7wtynrgavQjj/5GdYCMVaJfe7cgWURc4EuLOMzhm/wArUQCeGc
	 hY2USVuWH2R5er1qRtGU5p6rmxAXCMMFgwpDVKs4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20250312122058eucas1p29d64d763baf1f7b57e36a091fbe5e333~sDY2xd78G1865118651eucas1p2C;
	Wed, 12 Mar 2025 12:20:58 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id F7.94.20409.92C71D76; Wed, 12
	Mar 2025 12:20:58 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250312122057eucas1p134f18b01c48b270f92ac83607985f955~sDY2aHmLw2919029190eucas1p1t;
	Wed, 12 Mar 2025 12:20:57 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250312122057eusmtrp2333279830b6c2c5302fd5582b343f803~sDY2YNiTa3255432554eusmtrp2g;
	Wed, 12 Mar 2025 12:20:57 +0000 (GMT)
X-AuditID: cbfec7f4-c39fa70000004fb9-7b-67d17c298937
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id DD.D0.19654.92C71D76; Wed, 12
	Mar 2025 12:20:57 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250312122055eusmtip137065b8ad4bc171cbe646c9c8d98ce8e~sDY0vAs5s3094130941eusmtip1b;
	Wed, 12 Mar 2025 12:20:55 +0000 (GMT)
Message-ID: <4a0350b7-9b82-48e1-9d8a-04a8fed072c7@samsung.com>
Date: Wed, 12 Mar 2025 13:20:54 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 04/11] MAINTAINERS: add entry for Rust dma mapping
 helpers device driver API
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	rust-for-linux@vger.kernel.org, daniel.almeida@collabora.com,
	dakr@kernel.org, robin.murphy@arm.com, aliceryhl@google.com
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin
	<benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Trevor
	Gross <tmgross@umich.edu>, Valentin Obst <kernel@valentinobst.de>, open list
	<linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
	airlied@redhat.com, "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20250311174930.2348813-5-abdiel.janulgue@gmail.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sf0xTVxjdfe/1tWUpPooLd/4YSxdnUEFgLLvJxMzEzLc5EnESMxPBCm8F
	1wJp6TYJ0a7bFDqnCCptQWmmWYdt7VIQENxYwbVUhVU3UAqkLjbjR1cpPwJbV2W0Tzf+O9/5
	zj3f951cHi5Uk6t4RcVljLxYLBWRMUSr4+/+5A0VdySp6ioMjXh9HGT03wJowGPA0OP6Ni7q
	vacmUHBQzUH33V04Mrd8hiH/uSCJdGMOAt257QeoyfQzhkJzCJkGXTj6taOBRE2NRoDswSU7
	6x89OOprvcl9K542XzADun30EqAvVYUw+pp+lEsbbEradrmKpMebdYDuHFKR9MLx6yR94pgN
	o6d+HCDpQO9JDt1wcSM9a3tpV+y+mC0FjLToY0a+eeuBmMKg2s4tbRF86uizABW4+7wG8HiQ
	yoCGCVoDYnhC6jsAvx6YIjWAv1TMAdg9XMHiWQD77iU90y9ohKzeCGB/ZRhjNdMAPjQVRLCA
	2gpd9nEigglqHdQ+smAsHwddOl+Uf4FKhF6PlhvB8dSHcOD2AzxiupK6AqC71oxFCpz6nIC6
	xZvRjXAqAXp8jVEnkkqDmoAmyvOpbfB37SOM1STCtkBD1AlS83yom7FyIg1IbYcLQ86nOB5O
	Olu4LF4DF681YuyD4wAa/vE+LaoBVI15AKt6E470h8hIADiVBK0dm1l6Gwz/5MfYXGLh/UAc
	u0QsrGmtw1laACuPCVn1q1DvvPLfWLv7Ll4NRPplweiXnalfdo7+/7kGQFwGCYxSIZMwivRi
	5pMUhVimUBZLUvJLZDaw9E1vPXHOtQPj5HRKN8B4oBtAHi5aKTBluiVCQYH4cDkjL8mTK6WM
	ohus5hGiBME3XV9KhJREXMZ8xDCljPxZF+PxV6mwjPTt13e7T1il2U86y39ZLzhleT00a7BB
	87v2g4ec68ceNv9WyX+HW7hvMQlmln9hyj0o7sgLcXqnq9XJ4QRNj+xCaxNz7ofVFVm8Ldl5
	B4jnBuvfr9t7quS80ni48OyMtR31xDole86cGT6U9pp/4oOrZ1/umKk7WnbkFeKvnHCuNcd4
	Na52R7pDeyPxvdPjQ0e1nS+m3djZmJKzUbpftmu/e752/nzRCnmzKilj8vsF3GP5M9mSuRbR
	+eWMIzBUIjBWurKCX63wVmdgm6RrsnNz8nfUpD7eW8YtnZhyPvAOu+a0w/7do2HfG76undya
	rJP1obUt674NnJZtSh15+0ibiFAUitM24HKF+F9DM5X0FQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOKsWRmVeSWpSXmKPExsVy+t/xu7qaNRfTDV5OV7a4c/8Jq8Xy16cZ
	La7eWsBk8Xf2dnaLE9ebWCw+XGtitbhxYT+zxZotjUwWr6d9YLOY+fwYi8XFM68ZLVauPspk
	8euLhcXqayeZLS7vmsNmsXL+ckaLgx+Axq1/dpjZ4uy2U+wOwh5r5q1h9Nhxdwmjx5LOX0we
	O2fdZfdYsKnUY9OqTjaPF5tnMnrsvtnA5vG9fQ+bR0/bJiaP9/uusnm8PdHH6jFnsbbH501y
	AXxRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehkf
	mg6yF2zhrTh2di1jA+Ml7i5GDg4JAROJ711CXYxcHEICSxkltnVtYO1i5ASKy0icnNYAZQtL
	/LnWxQZiCwm8Z5TY840JxOYVsJM4efAFC4jNIqAqMePdWqi4oMTJmU/A4qIC8hL3b81gB7GF
	BdIkrp55wAyyTERgHaPEs879rCAOs0Ari8Sbm/MZIc44zSixZc0BsBZmAXGJW0/mg41lEzCU
	6HoLcQangKPEwxnvmCBqzCS6tnYxQtjyEtvfzmGewCg0C8kls5CMmoWkZRaSlgWMLKsYRVJL
	i3PTc4uN9IoTc4tL89L1kvNzNzECU8i2Yz+37GBc+eqj3iFGJg7GQ4wSHMxKIryrbS+kC/Gm
	JFZWpRblxxeV5qQWH2I0BQbHRGYp0eR8YBLLK4k3NDMwNTQxszQwtTQzVhLnZbtyPk1IID2x
	JDU7NbUgtQimj4mDU6qBafmxXjbWDZ8dJ4q+SrF4XJ9zL7fNc26WUYi3w5wlWyeYbNe8uFSr
	s0/pjEKEwRMd7XvfZgv+lEroX91/s6FPoPn39TD+7Os/I+fvylKIX3I73cW6w3LrxHWdJRtU
	JhbkFdx4c6TISkqqw+8Ys4uoYNo9qeBnRhN4I8+WT34+O3FH2R3etzfKv50u8vzY/1pr6vMr
	zw8dYtD0l5+ktMzStD1g3Qp7y/VPLFRmlMUpWf99uu7wgakfuY9YVK6N/BSxxvLPIpaWMzpF
	m1guFi9kkd7m/T+7Xob38c6zRhf+vj3x9edRJfH1zz7Hyt1UDz+guWf2lhs/eJfxOIp5bdc4
	vkdwzXFVU5Ukh7LiRrOeNiWW4oxEQy3mouJEAAUKpFSqAwAA
X-CMS-MailID: 20250312122057eucas1p134f18b01c48b270f92ac83607985f955
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250311174958eucas1p1e058930ad5271dc5fbce58660952e68c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250311174958eucas1p1e058930ad5271dc5fbce58660952e68c
References: <20250311174930.2348813-1-abdiel.janulgue@gmail.com>
	<CGME20250311174958eucas1p1e058930ad5271dc5fbce58660952e68c@eucas1p1.samsung.com>
	<20250311174930.2348813-5-abdiel.janulgue@gmail.com>

On 11.03.2025 18:48, Abdiel Janulgue wrote:
> Add an entry for the Rust dma mapping helpers abstractions.
>
> Nacked-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Danilo Krummrich <dakr@kernel.org>
> Acked-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>   MAINTAINERS | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 007ca67cc830..aa49c551fbec 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6902,6 +6902,19 @@ F:	include/linux/dma-mapping.h
>   F:	include/linux/swiotlb.h
>   F:	kernel/dma/
>   
> +DMA MAPPING HELPERS DEVICE DRIVER API [RUST]
> +M:	Abdiel Janulgue <abdiel.janulgue@gmail.com>
> +M:	Danilo Krummrich <dakr@kernel.org>
> +R:	Daniel Almeida <daniel.almeida@collabora.com>
> +R:	Robin Murphy <robin.murphy@arm.com>
> +R:	Andreas Hindborg <a.hindborg@kernel.org>
> +L:	rust-for-linux@vger.kernel.org
> +S:	Supported
> +W:	https://protect2.fireeye.com/v1/url?k=1b4a7c0e-7a31d687-1b4bf741-74fe48600034-417eb4ae60eba6df&q=1&e=37329b17-9a96-47f7-91f4-e1d88bf7cd47&u=https%3A%2F%2Frust-for-linux.com%2F
> +T:	git https://protect2.fireeye.com/v1/url?k=243e8bac-45452125-243f00e3-74fe48600034-05e697d1fbece59e&q=1&e=37329b17-9a96-47f7-91f4-e1d88bf7cd47&u=https%3A%2F%2Fgithub.com%2FRust-for-Linux%2Flinux.git alloc-next
> +F:	rust/kernel/dma.rs
> +F:	samples/rust/rust_dma.rs
> +
>   DMA-BUF HEAPS FRAMEWORK
>   M:	Sumit Semwal <sumit.semwal@linaro.org>
>   R:	Benjamin Gaignard <benjamin.gaignard@collabora.com>

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

