Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB571EEA47
	for <iommu@lists.linux.dev>; Mon, 26 May 2025 13:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748264655; cv=none; b=fj0q957D/nadJCm5OUY+6iwUA+Rxr4BEZTP3QAtuQJ2Pe9Vxu5ZwJSR3TydqTr/uhF80aTw+LGuYJdfmNLtYk0acEgFAecws0bfTWS7NLtNOXv+8dBmJa5D+jYjnxLDHo/HX99fQZJ/krS6WV3VD2+a/yLkw0TliSoK7vsIaTl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748264655; c=relaxed/simple;
	bh=wbVZiFmXwev0gwrEsOeAMboGoCc09zmui6KUEqZX+DE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OVzk8qkaMdkk5ceveMxR8bRZ1LU8eVEB99EW5tXvpg7sowb7WI6yESJFtZXtZd8uCSwHZxkguB4wb/oDXaIxHMZ42Xw6wI9UPKvDyI4u5eAC8WvujRig3gid6Kkv/Ne7jvp891iP/Au28wEbra/R4SE8DNUStKaQF2WpxU+Z7ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d4422XPn; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4422XPn"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55320ddb9edso1086608e87.1
        for <iommu@lists.linux.dev>; Mon, 26 May 2025 06:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748264652; x=1748869452; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P2yCa2GdViCiB3X5UlZL3nXJrusQdUTZkaipPeBJHwY=;
        b=d4422XPnU/ROVzS8ercRTOKihSCIsVUYSyoK9QT3YzzaYj3cnRqn5VZqeDky52JG1d
         jg9LhtkhX9h+9XMypAMYe+wf4++JRVWb1yPZJBwgEloubdEMe+XzhzYBqjys0ybxdc4v
         yhzprN3q5+ox9xiTwyj+B2N7VJURUGfAfoehVVuoHGVJEiVomlsLX3DTLMFgurHrNQd8
         4oZp4wYssi3m/v4P2++39f8uzQWD6lOY5odf57MbqZDWCDlkQvhLzlwm+yK/o6YDaf/2
         R8gmikY29m0bPR0/PC06dPUKDxQ3TJTx6M+6a7anusxqb/4ienLpRZr4dJ5Wh80RR/Ed
         5UUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748264652; x=1748869452;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P2yCa2GdViCiB3X5UlZL3nXJrusQdUTZkaipPeBJHwY=;
        b=YpcfH6nYV7aZ4O1PSh0Cu0OaQGVflLPL95hR8LE/l84m2drSGYXXZxwAvL0CkH0iHH
         U4djb7QOtPZoOLjIfFnhidh3Uy6BoL5oO+insqoZ7AqbSU4zDKCoBY5QqBkPoy+UK7gD
         Chl5FtdW9jwvV449kpBBfTqL9t4L+sPVQaieLYsR4gsjrRmffE34IMUfq/xghHRElbAY
         uLcWqAum/ZdVjGgJ0DwJ86yVCnsO4TRyP7RDtFtWA3NP3Kr7e37ZTfef9dY10nhcyoYi
         YMF3PiCg6uHN2oAI0/Zw91f66g3qjXKg/k3UpXKLu8XnfWCqGbo3ofSRh66FMe4oA/45
         OuUA==
X-Forwarded-Encrypted: i=1; AJvYcCUMYXvpOKKszEMDwpWK7gWvwW2FaHYuD4XOMCLRhP8KkaYUU+Ip0LzJQaQ1S5a1jVB9G1RKhg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwgW3F3wUvVBNElGsCQVhUppIHoWSwyGqlPdAwGHUNb78t6ym1o
	aC3j67ecBjx91CVy3UfSqrvvE7druRrC9KKswPz/GSLcf7zfra8LK3vh
X-Gm-Gg: ASbGncslyj+ki0NAviGMmU0fKfgKuUXWUotGZ8vdxAISX75DXJKonnY9U1z0sF5eqdc
	6ztKuAOZpE3RZTVmovnGx3WwEME0eLlDmfGGUyVC5RkpSxAlCV8vC8LdXcE1aefEa1YPho25Dcv
	/yfMlvnT1vN1B9fQW5b5BkvfUKDfRehxpyh7VfzEF27KhEhixPS5SrScjajRmXoGX3/3VtOq9Om
	k4Xr/QBPbCEpwxDxFef1hb+II4oic7B8CYgyHBuocbNB19Q3VT3a3jYgkWDPc7GHhIMGYcDDS3i
	ntEuHrnArlLcm9rW3KZndoBVSyOM54QUgi/gJ30KxeuxT+SAMizQLDfLw7MTszkCp+g081c43el
	cXTa8p5BRM3MdBWn7gbvarIp6h2ixA5UOwNDwtjQ=
X-Google-Smtp-Source: AGHT+IHMvM2cn9Sebeh8KS/nonuFNkYq1+2FpxCDUBtOw1DGLegUUAF8fUEBN/E9/r6S37bXQ8AGvg==
X-Received: by 2002:a05:6512:414e:b0:552:2115:ecc4 with SMTP id 2adb3069b0e04-5522115ee67mr1102763e87.50.1748264651113;
        Mon, 26 May 2025 06:04:11 -0700 (PDT)
Received: from [192.168.1.146] (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5532202f7fbsm422523e87.148.2025.05.26.06.04.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 May 2025 06:04:10 -0700 (PDT)
Message-ID: <44a70b0c-af38-4706-90e3-0e0a7f6ad6f8@gmail.com>
Date: Mon, 26 May 2025 16:04:09 +0300
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] rust: add initial scatterlist bindings
To: Lyude Paul <lyude@redhat.com>, dakr@kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, airlied@redhat.com,
 rust-for-linux@vger.kernel.org,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
 Petr Tesarik <petr@tesarici.cz>, Andrew Morton <akpm@linux-foundation.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Sui Jingfeng <sui.jingfeng@linux.dev>, Randy Dunlap <rdunlap@infradead.org>,
 Michael Kelley <mhklinux@outlook.com>
References: <20250512095544.3334680-1-abdiel.janulgue@gmail.com>
 <20250512095544.3334680-2-abdiel.janulgue@gmail.com>
 <36b45e41522a61409b379c15f21bb547d4913d1e.camel@redhat.com>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <36b45e41522a61409b379c15f21bb547d4913d1e.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Lyude,

On 15/05/2025 23:01, Lyude Paul wrote:
> 
> I think you might have made a mistake below
> 
>> +impl<'a> Iterator for SGTableIter<'a> {
>> +    type Item = &'a SGEntry;
>> +
>> +    fn next(&mut self) -> Option<Self::Item> {
>> +        self.pos.map(|entry| {
>> +            let sg = entry.as_raw();
> 
>                 ^ sg is the last iterator position
> 
>> +            // SAFETY: `sg` is guaranteed to be valid and non-NULL while inside this closure.
>> +            unsafe {
>> +                let next = bindings::sg_next(sg);
> 
>                     ^ and we fetch the next iterator position
> 
>> +                self.pos = (!next.is_null()).then(|| SGEntry::as_ref(next));
>> +                SGEntry::as_ref(sg)
> 
>                     ^ but then we return the previous iterator position, sg
>> +            }
> 

Just had a second look at this again.I think the previous code is okay. 
I integrated the iterator fixes you suggested, however the mapped 
sgtable crashes on dma_unmap_sgtable().

One hint is that the fix seems to skip the initial entry of the sgtable? 
The previous code doesn't skip the initial entry when iterating:

fn next(&mut self) -> Option<Self::Item> {

   self.pos.take().map(|entry| {
      let sg = entry.as_raw();
      ^ sg is the current iterator position from self.pos

      let next = bindings::sg_next(sg);
      self.pos = (!next.is_null()).then(|| SGEntry::as_mut(next));
      ^ update the iterator position for the next loop to sg_next()
        or set to null if sg_next() is the last entry

      SGEntry::as_mut(sg)
      ^ Return the current iterator position
    })
}


Regards,
Abdiel
