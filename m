Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D461BBBE5;
	Thu,  9 Jul 2026 15:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783609231; cv=none; b=glgOFZofI8p8tDD/ffg8hTZD9wbRmKmYo4PDQ+2vbbtglbJpSx2BR/u0w3m6P5TW+dsJxGk0IBD8x6U8Eyr4p4I2zGcQjSksACsTFO3NQsw5s4iwt8xKUX8mtXlBI9weOHU9N8MuUfbI3TIc+AknLt2hWxXAwpTAkaHepiWVI7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783609231; c=relaxed/simple;
	bh=6rV8yFdmFMaImLK/hyEKYchVJSXskJngKVoZJJKqhrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kQJXosdDf/71+Ygi/W/aWmbsdt5jr4ZXIZ+NBnDbQNoVkM8W6GvYrQcegYlJNIW8H4g/loSIJ6zVGbZcDYzvJrKkMXAmED8y7ipcQBYN46CRCnaL86U2b6C9ICzYA6UOhp+YNQJX+7copsEyAE35pUZTiQ7weNLvRMFRqiDuhBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlIbjqao; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlIbjqao"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 698F21F000E9;
	Thu,  9 Jul 2026 15:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783609230;
	bh=XBSFFRlqjOjsfWabzs0b5VS/668RN/zWgBiBaHhQLlU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=nlIbjqaoIBCc4SddDmN6qibWLw8SaLRD1qQk8Jh425DTjtrjRtsidSfhkjElu+9m9
	 9sEYmfpOceRoNfJF9hKy8/b3JaxLVxEro7u07nWB5VqCinS1YdMCFflyueYB/kveGD
	 KdUEUn8JeKrlThw6Bs6A/AgCmsUvk+QuOhzCKQUzWS91QJJ7ZyDrtNBUF4BDymts4F
	 5bY7IUs392xktNYDMxcjClSCqpGCT8VVCaOPYA3MVv3LNdYs1Yvr5j01PWnnmGIl6O
	 ByhX9jLq+zr5Jqpo7LXIWmaKQCZtvbvRHa0O4MFkvxEqJlHlKFtMH3BYlpBONo8uyg
	 iszyasWK8Nr+Q==
Message-ID: <7dcb4b89-0d53-4bb3-ac1c-4c3147587f0a@kernel.org>
Date: Thu, 9 Jul 2026 17:00:24 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] rust: iommu: add device lifetime to IoPageTable
To: Deborah Brouwer <deborah.brouwer@collabora.com>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 iommu@lists.linux.dev, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, samitolvanen@google.com,
 laura.nao@collabora.com, boris.brezillon@collabora.com,
 daniel.almeida@collabora.com
References: <20260703-pgtable_lt_b4-v3-1-e738e1f513a4@collabora.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20260703-pgtable_lt_b4-v3-1-e738e1f513a4@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/4/26 2:28 AM, Deborah Brouwer wrote:
> Currently, using a raw IoPageTable is unsafe because the returned
> IoPageTable is not tied to the device driver binding lifetime.
> 
> Since device drivers now receive a lifetime parameter <'bound>
> representing the interval during which a device driver is bound to its bus
> device, add a lifetime parameter to IoPageTable. This ensures that
> the returned IoPageTable cannot outlive the bus device binding.
> 
> Also remove the option to create a page table as a device resource since
> currently Devres is not compatible with resources that have a lifetime
> parameter. This option can be restored once the lifetime-aware
> wrapper for devres is available and if a use-case appears for it.
> 
> Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>

Reviewed-by: Danilo Krummrich <dakr@kernel.org>
