Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F086E17F4F6
	for <iommu@lists.linux.dev>; Tue, 25 Jun 2024 23:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719358457; cv=none; b=XD6EUTNXLblTgN892oEYAOLm8cgubk0CsJpXrLDOCutwIOd0P0nBl57IhijjvhDDk4w6Pum9WEUqL90kW3LYRy4PujSoIfml2jv1mW7C/15W0/Vihk3pJBXCAgN1CP/3PxLv1EYDImsN7j3AWfUARjQoccWz9EznagMPfBUIl2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719358457; c=relaxed/simple;
	bh=JW5+38U/vcohXyeiKPUGkpLsj7sweQrd3uPWwGSP2dA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pB95S9ouSwSuVD3bnu4V7nS2fkCN1BEhRszq/v9iWG45Fy2k83ABKYUOB4WAuoh1QVkZWLof3Zx7AGBhWU4XHKCFu4Xpwk7qLgUw1mM3A0EAY/NeLVzg485xPCQhUjw3KOX5x/1fVXPKyaeIUN64lyZKtyLjHp8inzUewowX/3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Zpvr1dox; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Zpvr1dox"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7eeecebb313so17505539f.3
        for <iommu@lists.linux.dev>; Tue, 25 Jun 2024 16:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719358455; x=1719963255; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fLoxHe91BqYGbErrOqOVZAihyCRQ1/q/QL1BRJCrC+o=;
        b=Zpvr1doxTz53Numz3i5HvCLh+pFrSFMIe0vUYSi51EmILDeM53VSgAPAVW/XxAx+vR
         fGnQxbjviSi8u3FnMhURT/0gRD90R+Dr9CKLyjpitRuKd8oxAnZMcAblCo1rSfJskm+d
         ogOVA1hKeRjJ9Vcu2IBOF70i+ICh5q3HeeFaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719358455; x=1719963255;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fLoxHe91BqYGbErrOqOVZAihyCRQ1/q/QL1BRJCrC+o=;
        b=J1BwjGIrMzEBZF/2cd6rGLOqfaf52YGKyZ1zfxCBrU5S1lBlY0xPziTedHZkKWROj/
         UGucB8B8jTdeocuUoVVWtFDYUfGAMIQUbKJZ3/SQK+vU0LPfHZ/in3e7JzClfQ/siRZt
         rZQSPdPVcKuIi6xEAXyhCSMaPNZxm4khRR7+LjhntE8kHh0xt/7hATlDmFiA/OYpld6V
         3avvv/ib4D0DAiw1okjCDHMKdgk/PMynwxvYspdF6n4TgQXXhUjWna5NoQWI2PnCTaU2
         3b8K+R66kkk6/uuPYLO2QZCFzibO9C0IFVIVjs2H8qKDdl7y75/k+fkc4eBsmN/U5AKM
         fRRw==
X-Forwarded-Encrypted: i=1; AJvYcCXLlowArCSUZQEjdVcDlSu8b2Ku+WzN/N6P3gNMhg1zpGd0V6rwGS9UFEV3lIofWa3FXqSxyI1V5n4ZBIsPr0hHujVVD/4=
X-Gm-Message-State: AOJu0YyTvCimeKkyZi+O7zxVFstos3GzxCdZz+7UdvgmtYwU+6gqHuBI
	FJk59rilQ/bDQHkQmSxtUpZhB9ia0rqWUJEjSeX9de7f+TQyvvJnmpB6oK1FHMk=
X-Google-Smtp-Source: AGHT+IHFxsdnrHHCJW39/Lbu9cUGENC+vnEtRYVDBjLq63CwNtPtBkCUmNgYxOl/tyW+mRbcBoYz8w==
X-Received: by 2002:a05:6602:3148:b0:7f3:9ef8:30a4 with SMTP id ca18e2360f4ac-7f39ef8334dmr991110139f.1.1719358455001;
        Tue, 25 Jun 2024 16:34:15 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb458ba8efsm645345173.8.2024.06.25.16.34.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 16:34:14 -0700 (PDT)
Message-ID: <f975fe76-92f4-4af0-a91d-0f3d8938f6b2@linuxfoundation.org>
Date: Tue, 25 Jun 2024 17:34:13 -0600
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/13] Centralize _GNU_SOURCE definition into lib.mk
To: Andrew Morton <akpm@linux-foundation.org>, Edward Liaw <edliaw@google.com>
Cc: linux-kselftest@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>,
 Kees Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?=
 <andrealmeid@igalia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Fenghua Yu <fenghua.yu@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Jarkko Sakkinen <jarkko@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org,
 usama.anjum@collabora.com, seanjc@google.com, kernel-team@android.com,
 linux-mm@kvack.org, iommu@lists.linux.dev, kvm@vger.kernel.org,
 netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-sgx@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240624232718.1154427-1-edliaw@google.com>
 <20240625135234.d52ef77c0d84cb19d37dc44f@linux-foundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240625135234.d52ef77c0d84cb19d37dc44f@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/25/24 14:52, Andrew Morton wrote:
> On Mon, 24 Jun 2024 23:26:09 +0000 Edward Liaw <edliaw@google.com> wrote:
> 
>> Centralizes the definition of _GNU_SOURCE into lib.mk and addresses all
>> resulting macro redefinition warnings.
>>
>> These patches will need to be merged in one shot to avoid redefinition
>> warnings.
> 
> Yes, please do this as a single patch and resend?

Since the change is limited to makefiles and one source file
we can manage it with one patch.

Please send single patch and I will apply to next and we can resolve
conflicts if any before the merge window rolls around.

thanks,
-- Shuah
