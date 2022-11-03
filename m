Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EEC7470
	for <iommu@lists.linux.dev>; Thu,  3 Nov 2022 14:27:40 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id q9so1760352pfg.5
        for <iommu@lists.linux.dev>; Thu, 03 Nov 2022 07:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IIuosJEuTIxTU4vgxtOOKlEeHtCDZ/WY4hzhdvsVb58=;
        b=Ba26o1h0RwuZQrcVdQXGiWeePY+jTdQIWBBQKuQzaN7V42GxlZj2i1fdP1awb5nRYi
         I+XlmteiHLFtd+YYOFakh8deA+ZTwe2sijmvTewpGEHDXDgiBdwKoZO8LVgkGNlkjUQg
         ejex1GdrLJHlvKCDujXrlOUJYkLPMXbUlQ9kTKFZY3xU2PYafUzIzitV6KUUNFvgkb99
         rcUp7UGzwyyAO2CAjupw4+6fZeuJTIOT2pe6EX1nDLTtAA2nMBUtjeOy7FAtVDtHUPbk
         AJlpy/v/2QXPCaDVK9fBaIvova8EoGRWFJspfPqLri0gnzTKjruMX+Y7mYIzhiWKankj
         9oMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IIuosJEuTIxTU4vgxtOOKlEeHtCDZ/WY4hzhdvsVb58=;
        b=0eIjqGyUVIzAYcMHFnk556AAe1DKRb5PNxYDqae3i2mOfT4CP5IP86fGQrhvul5ZPf
         Dy6FjbZrweZDgn9fuE3VOjWXGFV4MLSkBNLEgj/ElLsIHLMwdZj1yKOEtj2NLyzXiURQ
         rQxSUAgIY/qYlLCMWH+FG446hMfdvyQ2acALDpGDGqZEMmPn68AiaCBbeuBny4WITmz+
         U7qL4NP0qDmKmP1HcyTYf39H54cEAdAsNOG5SZH4O3ngjkTgYxTnbmS+EaP48jwXY6d4
         yiytei5hSuhEPlcBMVjwMuORJLv+CGPR7OeNdL/eEhkoVmfPavGuGf/9XOQQDn2Perac
         whrA==
X-Gm-Message-State: ACrzQf0NcyWNzYIH1tm5eAJ4X8psuRf/RoBRG6sCJ3iHiOvZtKfj09ke
	ebDk+OyeMjveF+JZZuj9nRU=
X-Google-Smtp-Source: AMsMyM5wdqSY1H/m6g6FYCRAGcDeMB7vyoR6fpb0bzRrRGYER7iaHfadrE7m+/r3x3fwIfKhXP6/BQ==
X-Received: by 2002:a63:f964:0:b0:46f:e243:fd8e with SMTP id q36-20020a63f964000000b0046fe243fd8emr13936135pgk.207.1667485660470;
        Thu, 03 Nov 2022 07:27:40 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:18:efec::75b])
        by smtp.gmail.com with ESMTPSA id n184-20020a6227c1000000b0056b9df2a15esm825190pfn.62.2022.11.03.07.27.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 07:27:39 -0700 (PDT)
Message-ID: <f295f2f4-b7c7-0faf-cc99-9a052a7bf7ef@gmail.com>
Date: Thu, 3 Nov 2022 22:27:28 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 07/12] Drivers: hv: vmbus: Remove second mapping of VMBus
 monitor pages
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
 <1666288635-72591-8-git-send-email-mikelley@microsoft.com>
From: Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <1666288635-72591-8-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/21/2022 1:57 AM, Michael Kelley wrote:
> With changes to how Hyper-V guest VMs flip memory between private
> (encrypted) and shared (decrypted), creating a second kernel virtual
> mapping for shared memory is no longer necessary.  Everything needed
> for the transition to shared is handled by set_memory_decrypted().
> 
> As such, remove the code to create and manage the second
> mapping for VMBus monitor pages. Because set_memory_decrypted()
> and set_memory_encrypted() are no-ops in normal VMs, it's
> not even necessary to test for being in a Confidential VM
> (a.k.a., "Isolation VM").
> 
> Signed-off-by: Michael Kelley<mikelley@microsoft.com>

Reviewed-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
