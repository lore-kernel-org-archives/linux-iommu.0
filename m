Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F8D2F6918
	for <iommu@lists.linux.dev>; Mon,  1 Dec 2025 13:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764597343; cv=none; b=jTDDhyQDK1H5FibGPfmx97dfDU7JFB6w7XwFfAqxFC8JQrx1AaG/RCIjwMfbSgKkxMvM9l0zMbnVM4vnRbxQFXYng803wL3uMJl8PUFbn2v9JtCaTjtcFKeI3DA9pjtCaUsCEpvru6MpfgRQE69Te9Ej74rKNoUPV7qxqLJvuYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764597343; c=relaxed/simple;
	bh=X1gj20pKygKny0AkEY640rGN6m6QTXIwW5kngARq+y0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qzw35VOQ/f1M/LLhOz6CdUV6aQkPQZ1Uy0kjJbH5gXO3smO7WnmAaSTj3kXiM37CmCSU/p77yyL9gCDyLSvMLEIsFS8sqHK0hudo/aqyEg2RagdakQdRVWgYfxdv+s9kGzwAyUkkZYIOu3jdEBqCz+7fz4CCGPv4ygJdDLuTFuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 461BF153B;
	Mon,  1 Dec 2025 05:55:34 -0800 (PST)
Received: from [10.57.88.78] (unknown [10.57.88.78])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 97B653F73B;
	Mon,  1 Dec 2025 05:55:37 -0800 (PST)
Message-ID: <cfce9ad9-c518-44c7-a602-8ce7c3fffb2b@arm.com>
Date: Mon, 1 Dec 2025 13:55:34 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] io: add io_pgtable abstraction
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Will Deacon <will@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Asahi Lina <lina+kernel@asahilina.net>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, iommu@lists.linux.dev, linux-mm@kvack.org
References: <20251112-io-pgtable-v3-1-b00c2e6b951a@google.com>
 <12d99a54-e111-4877-b8cd-cb1e58cd6d30@arm.com> <aSmVQDMXqwc8ctDf@google.com>
 <c8229530-ab87-4b51-8f2b-6199a01095b3@arm.com> <aS1m4DawouC1utSj@google.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <aS1m4DawouC1utSj@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-12-01 9:58 am, Alice Ryhl wrote:
[...]
>>> We need a different signature if it's possible to have mapped != 0 when
>>> returning an error.
>>
>> Aha, thanks for clarifying - indeed this is not the common "value or error"
>> case, it is two (almost) orthogonal return values. However if we're not
>> permitting callers to try to do anything clever with -EEXIST then it might
>> make sense to just embed the inevitable cleanup-on-failure boilerplate here
>> anyway (even if we still leave retry-on-partial-success to the caller).
> 
> Is the only possible error -EEXIST? I could encode that in the API if
> that is the case.

No, I was just calling out -EEXIST as the only error where I imagine a 
caller *might* want to continue without cleaning up a partial mapping, 
if for instance they were playing clever tricks like a background 
mapping of a large buffer while already allowing other threads to 
eagerly demand-page bits of it, so the "main" mapping thread just 
adjusts and restarts to skip over already-present pages. Other errors 
are still possible, but generally represent terminal failure conditions 
at the caller's level too - in practice things like -EINVAL and -ENOMEM 
are likely to happen before any mappings can be made, but io-pgtable 
doesn't guarantee any particular behaviour here, so a well-behaved 
caller should still generally handle cleaning up after an error (at 
least if they intend to keep trying to use the pagetable beyond that point).

Cheers,
Robin.
