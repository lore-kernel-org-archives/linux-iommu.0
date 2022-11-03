Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F507470
	for <iommu@lists.linux.dev>; Thu,  3 Nov 2022 14:02:16 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id v28so1664575pfi.12
        for <iommu@lists.linux.dev>; Thu, 03 Nov 2022 07:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UmKtxb5OIdkWe/R42yb7p4DATx2KVmP2uBy4ix5SL3w=;
        b=ItTrAM24WZEiC8Ky9WnJQCTlZMzBIecLFNEpS86ROXS56KND+C+iSHEB0LphFw/bOS
         /TZemYdwY+iz4QUyuoMXL/mUd4x+Y/gbsJv/kxbRxx2DJgRjxjgzGzcpBVsjpxFlFdIv
         yRso6xlHeYP1rT2ZJRwlLQJi9GJxHxZbuqek69cm2i8Du8VSh2ye4CvXwh3plOWYnQ2z
         RtSKajMt5Jqe36A6fbI5fbWtRSRjWdx0vzwhd3TgeBnquQvIkEXrGRvLORB0N2JH7miF
         hhuTPP5+4X/3giaFjO92svuoiqhrYZFpCBo0nMZmFo8CU2InbLakRuRrU8NcGZnzgZXf
         dtkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UmKtxb5OIdkWe/R42yb7p4DATx2KVmP2uBy4ix5SL3w=;
        b=0eF+K8eHVQZMjzeSaeS0W2vc6UCQAYlsxHCfY9CPQ4GF7iG9s3dn4iytRMVD/rka2p
         2drGPy9xfE5JNvrsc+1q39HP3ne/Bc9xTJbKCfk6X3SS4+D9/0KvkJMtfjLfcFybV8L0
         8PIzXzNqTNuW56BlMhEabeLO7fVTyEyqNeAmmjV/RVZhtSepHjxGcdwYBsq0U8L/Chcw
         appRXU90QdtVPc6ZTYuFrfEHVT6HOySxMao26UAbks/upt4C+qDy0FcdQq5sCtqupz36
         Ok/ZV/gm9idhAYFyzru1Z3uK7huZpJpvj+ZnAvyEbr2ZSP+RjrWS8ud+j+wNKM9W+SHy
         VHWA==
X-Gm-Message-State: ACrzQf1yxfmn/Y/Szo911t+9ZCcZTBbXaoj3i8O6gghCKPfvc1oQf7eM
	7w4kztBAiR8sAqnBwQRElqo=
X-Google-Smtp-Source: AMsMyM6hTWrvx/G4NV/Gh8+VQ4bQZEN0PapYoFKkqk6dwNvAYm8qSewAomRKP+TEOnqe0uRmr+9DAw==
X-Received: by 2002:a63:6b49:0:b0:46a:fcba:308f with SMTP id g70-20020a636b49000000b0046afcba308fmr26467136pgc.8.1667484136455;
        Thu, 03 Nov 2022 07:02:16 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:18:efec::75b])
        by smtp.gmail.com with ESMTPSA id i20-20020aa796f4000000b0056164b52bd8sm807658pfq.32.2022.11.03.07.02.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 07:02:14 -0700 (PDT)
Message-ID: <abeab056-84d6-4fd6-3611-9090eca6a359@gmail.com>
Date: Thu, 3 Nov 2022 22:02:02 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 04/12] Drivers: hv: Explicitly request decrypted in
 vmap_pfn() calls
Content-Language: en-US
To: Michael Kelley <mikelley@microsoft.com>, hpa@zytor.com,
 kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, luto@kernel.org,
 peterz@infradead.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, lpieralisi@kernel.org, robh@kernel.org,
 kw@linux.com, bhelgaas@google.com, arnd@arndb.de, hch@infradead.org,
 m.szyprowski@samsung.com, robin.murphy@arm.com, thomas.lendacky@amd.com,
 brijesh.singh@amd.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, Tianyu.Lan@microsoft.com,
 kirill.shutemov@linux.intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 ak@linux.intel.com, isaku.yamahata@intel.com, dan.j.williams@intel.com,
 jane.chu@oracle.com, seanjc@google.com, tony.luck@intel.com, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-arch@vger.kernel.org, iommu@lists.linux.dev
References: <1666288635-72591-1-git-send-email-mikelley@microsoft.com>
 <1666288635-72591-5-git-send-email-mikelley@microsoft.com>
From: Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <1666288635-72591-5-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/21/2022 1:57 AM, Michael Kelley wrote:
> In preparation for a subsequent patch, update vmap_pfn() calls to
> explicitly request that the mapping be for decrypted access to
> the memory.  There's no change in functionality since the PFNs
> passed to vmap_pfn() are above the shared_gpa_boundary, implicitly
> producing a decrypted mapping. But explicitly requesting decrypted
> allows the code to work before and after a subsequent patch
> that will cause vmap_pfn() to mask the PFNs to being below the
> shared_gpa_boundary. While another subsesquent patch removes the
> vmap_pfn() calls entirely, this temporary tweak avoids the need
> for a large patch that makes all the changes at once.
> 
> Signed-off-by: Michael Kelley<mikelley@microsoft.com>
> ---

Reviewed-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
