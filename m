Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CDC18950A
	for <iommu@lists.linux.dev>; Mon, 24 Feb 2025 16:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740414447; cv=none; b=V2JzLv/g5K5EIcjQ7cm5lfvGC+jf8239ttP48wanOlMfebz5ILXM9oQoIviD7/lh5hOOC4WRl96lkt5DjlA3LMxlakQ8nvCe+QJZ1svxOO27o0Xx09nXAzX6H69OEzssWv7vElma1ZnjDJbJuCY26avRz7XM1YZMlp/kv407e28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740414447; c=relaxed/simple;
	bh=ydaM6hj0cYqKGtZFlwPdLyQgyQlFKrqeJWmamUgbdaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pp42jMLnoEWCByd0cdHPKAL1vyLnhY7b4bK31olTAnY0vtgC9FuTlb2YG9JrYiQZAqGHFmhkEBzSt2RhQJ079F6bWiaFFAtLZjN/UGhAqFVuopZ0hRgs8Ai1xDRaYortBPABAh02wine+PBzXfJtwRlUeewO5MuuEbcDGNpdqnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WB4+Wrka; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WB4+Wrka"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-54524740032so4851257e87.3
        for <iommu@lists.linux.dev>; Mon, 24 Feb 2025 08:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740414443; x=1741019243; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EhXRCNxJnJ8dZow1OlvTXJLJwEVfQM+CNtGvDdtiqB0=;
        b=WB4+WrkaXN2hFRgVLZlLuhYKEfnBm6Ox17yWlQLXQNO5eGFT5nKQsW6N39TTtZy/8o
         DuAtU3JAh+TGRVTFni1tCiywr3EeBL8efeOS67RrtdKcgWUUm19IVsaWrOJrb+7nhk7R
         jT4UNLaeHxxxIxyy7/i7ANstQVTJZlvKJjxmQwA8VzMgHU2K/sRXQHUttbfyXYtqP0oD
         P7eGYqUzi/7hzwJLwh+4m8Sw2Zezcd9Y+zRsB3wqLZi+/tbEglxfW7MWM9oANBAjWLLl
         aWK/Sn673SfF66LsFNv4ASuVW6OmQZdUF6yrdM10+MEiwAZMeOddfkdwO71to+4HkuCW
         pMcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740414443; x=1741019243;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EhXRCNxJnJ8dZow1OlvTXJLJwEVfQM+CNtGvDdtiqB0=;
        b=jzIqubf0UM67CjSABRaZFon0lrTF+McMOhKv40qSMTNk4bOCWMMJsSyRfyKbfopdk6
         PE4NxbuqzHabGIG+HdcoIF3JzRdv0MghxMaoGsbvShGRc7UinJKZtEIjRXb8OFQZgNc5
         TUbDAklub83faQw2LFFKGerjjWti0QaNRBW1QxBmupp0i9QrwYqEL5tKuXUDQM91FlZQ
         f7msb16pnO8J+3hrmDT57AzyJasJOyHA+kbqDaZIJDEfCBuYATSIA2DXZKhrydt7KFTp
         db9szq60rZ1lNym5TteSkOYY7nIZ5Y3WSREATfck/KbiWsbYJes38CrgbQLhp5LBRZ4p
         NnNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdZkARAhbghkQ7+JrbZNGNp65KSrJfunlAf+z/Pp2NX/fBDuiu56sO55p2skgOrKpWQ78wGg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy+I8ZYnTOpahiSrbptL+IIwQLlf4tPZnwNvbmNsQEyhjmYLT3q
	JxT3y7DtGzLHUrE27p7841z35kaflPtsNkf6dCY1zOPKz9yTmupX
X-Gm-Gg: ASbGncsxr/uVFOzbR2sljVFx7zbE85VuI5h1Nwp2z9QP5PAhAnti2ykV3aP+bmCzTEe
	rRPX78tkQru2Pk9b9g1isYpmZwQlsInwRt1mOgRBmZV3yjYecfOLtggEUQa5pArPQVfzBUCO1dw
	t8I3sOttA/GHLPaFEY2LgczR1O2r3MZYcW805mLJn4cv26Hk+Jqitx55I6orFRf5rHJGxAECaHb
	7Z2JFhaFYD1VztOgCHaBu6RAwcbyF/MeQCUpdCQw0amJ9gGF7I3nt07Fl58ugwZ7qCLL5dGAxTd
	MOJmOxWNynnKMJ/QRhA8BON44p9LDxlyaT9HsxeeAfgiUsKM5NAuaR9VzteQpoQY7I92t7ud
X-Google-Smtp-Source: AGHT+IGifLN+BkJJASBV49lEfWIaIINPrBJ23N3ztsheqn5LrpjibwTh5MaO/IGC2B4XFQnSgLuzJg==
X-Received: by 2002:a05:6512:308b:b0:545:56c:36c7 with SMTP id 2adb3069b0e04-54838f59115mr5828030e87.41.1740414442323;
        Mon, 24 Feb 2025 08:27:22 -0800 (PST)
Received: from [192.168.1.146] (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5451f08332bsm3478218e87.48.2025.02.24.08.27.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 08:27:21 -0800 (PST)
Message-ID: <487bb34a-e304-488a-80d5-97cf55ea25d0@gmail.com>
Date: Mon, 24 Feb 2025 18:27:21 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 2/3] rust: add dma coherent allocator abstraction.
To: Alice Ryhl <aliceryhl@google.com>
Cc: dakr@kernel.org, robin.murphy@arm.com, daniel.almeida@collabora.com,
 rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
References: <20250224115007.2072043-1-abdiel.janulgue@gmail.com>
 <20250224115007.2072043-3-abdiel.janulgue@gmail.com>
 <CAH5fLggU_sU56dEz6hQvMwjY=G2TuC9GYiVEBZFtE=Tk2QW4Fw@mail.gmail.com>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <CAH5fLggU_sU56dEz6hQvMwjY=G2TuC9GYiVEBZFtE=Tk2QW4Fw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 24/02/2025 15:21, Alice Ryhl wrote:
> On Mon, Feb 24, 2025 at 12:50 PM Abdiel Janulgue
> <abdiel.janulgue@gmail.com> wrote:
>>
>> Add a simple dma coherent allocator rust abstraction. Based on
>> Andreas Hindborg's dma abstractions from the rnvme driver, which
>> was also based on earlier work by Wedson Almeida Filho.
>>
>> Nacked-by: Christoph Hellwig <hch@lst.de>
>> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> 
>> +    /// Create a duplicate of the `CoherentAllocation` object but prevent it from being dropped.
>> +    pub fn skip_drop(self) -> CoherentAllocation<T> {
>> +        let me = core::mem::ManuallyDrop::new(self);
>> +        Self {
>> +            // SAFETY: The refcount of `dev` will not be decremented because this doesn't actually
>> +            // duplicafe `ARef` and the use of `ManuallyDrop` forgets the originals.
>> +            dev: unsafe { core::ptr::read(&me.dev) },
>> +            dma_handle: me.dma_handle,
>> +            count: me.count,
>> +            cpu_addr: me.cpu_addr,
>> +            dma_attrs: me.dma_attrs,
>> +        }
>> +    }
> 
> The skip_drop pattern requires the return value to use a different
> struct with the same fields, because otherwise you don't really skip
> the destructor. But I don't think you have the user for this method
> anymore so maybe just drop it.

Ah, yep. I agree.

> 
>> +    /// Retrieve a single entry from the region with bounds checking. `offset` is in units of `T`,
>> +    /// not the number of bytes.
>> +    pub fn item_from_index(&self, offset: usize) -> Result<*mut T> {
>> +        if offset >= self.count {
>> +            return Err(EINVAL);
>> +        }
>> +        // SAFETY:
>> +        // - The pointer is valid due to type invariant on `CoherentAllocation`
>> +        // and we've just checked that the range and index is within bounds.
>> +        // - `offset` can't overflow since it is smaller than `self.count` and we've checked
>> +        // that `self.count` won't overflow early in the constructor.
>> +        Ok(unsafe { &mut *self.cpu_addr.add(offset) })
> 
> The point of the dma_read/dma_write macros is to avoid creating
> references to the dma memory, so don't create a reference here.
> 

This is embarrassing, I thought I had changed this already in the patch. 
My local tree had this already fixed. Anyways thanks for catching this!

/Abdiel

