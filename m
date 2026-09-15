Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF80483BE5;
	Tue, 15 Sep 2026 08:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789462225; cv=none; b=dLjhRYnEGVOtC/jRZFHQaTFiD/zqQQWKbRvYO0A+8iAWIBlyQ5/EYqoSnpBfvXJ0wDv8OI+6PqJdDE2hB9ckimlP5OuTxvISBho1b+iq9UF0qus1u2dXQIm01XpA7craEYgmV/VSgqMXvC98O++aapZCXqhZ+VUCcCxSyN0tx0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789462225; c=relaxed/simple;
	bh=aHvflkwg1eUX39t61Q6CemkxW13OjLwMHGsJu9gpKu8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hUDFPgTV6IZlyUsG68oce+KPLzwWPYBL3WFFE8ryTDgM3UPbTeyAcoNwmJkaUw/U+SS+KdK4eJKzaYSGHjHg1n7QJxCc7otiIfEjaJP1m5qjhbhkhe5S8piGITjDfAL+XavnMKREZqG/EkQIMZy8ad5tBEpuKxlkv+s39kLk6HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FxlWYHLG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FxlWYHLG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABD441F000FF;
	Tue, 15 Sep 2026 08:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789462224;
	bh=Ec9pG0AOPTJV+WOWuJZCS/7BsUSuAI5bOETJ75S818I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=FxlWYHLGp8PYjY6sjZyXclR4bxWWwmiwmtCMimxmRol9qOSpTNf+4PB4xOxL5ceBh
	 LHcum17S/sa3mxisR/NwwkhDClkxET+E5upTrOPcC3uUtcdAo7kI/VracT/BEptuJX
	 Tln73H6YeBtODg5CbuU+6mjDwTWuJp2yRhnSCfjpA8B9NA2CynmOId7iU0U0gzh77G
	 f9afWzw+56OYu963AF23g6VaCAIZufUefODRKD7yORO3LavGAiZSe5IYCkUVKW7jA9
	 n9jPQQmOq7EGkAWZVgVa53qpaBNYeioMVF6YFELAox6pjrjKcRIB7FkOWThCdwppA7
	 D+RNpdcDt4/Vg==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Mostafa Saleh <smostafa@google.com>, Alexander.Deucher@amd.com,
	Vasant.Hegde@amd.com, Timo Witte <timo.witte@gmail.com>,
	Alexey Kardashevskiy <aik@amd.com>
Subject: Re: [PATCH] x86/mm: Don't force unencrypted DMA for IOMMU-backed
 devices
In-Reply-To: <df4209bb-0bfb-4f19-9de1-2b03148846fc@amd.com>
References: <20260908113232.247457-1-aneesh.kumar@kernel.org>
 <df4209bb-0bfb-4f19-9de1-2b03148846fc@amd.com>
Date: Tue, 15 Sep 2026 14:20:15 +0530
Message-ID: <yq5aqziu2914.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Tom Lendacky <thomas.lendacky@amd.com> writes:

> On 9/8/26 06:32, Aneesh Kumar K.V (Arm) wrote:

 [ ... 39 lines skipped ... ] 

>>  
>> @@ -30,7 +31,7 @@ bool force_dma_unencrypted(struct device *dev)
>>  	 * device does not support DMA to addresses that include the
>>  	 * encryption mask.
>>  	 */
>> -	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
>> +	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT) && !use_dma_iommu(dev)) {
>
> When this support was originally added many years ago, this function was
> not called if an IOMMU was active and generating IOVAs. So if this
> function is now called even when an IOMMU is performing the DMA mapping,
> then this is appropriate. Although, it would seem that if an IOMMU is
> performing the mapping and this function is still being called, checking
> use_dma_iommu(dev) and exiting early from force_dma_unencrypted() at the
> very beginning is more appropriate, right?
>

I don't think that is correct for a confidential guest with a stage-1 IOMMU.


> @Alexey, would that impact your TIO/TDISP support at all?
>

-aneesh
