Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7A47488
	for <iommu@lists.linux.dev>; Thu,  3 Nov 2022 15:09:40 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so5460968pjc.3
        for <iommu@lists.linux.dev>; Thu, 03 Nov 2022 08:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TYQSkbtesSkMhkx4ROSMNbPqpw1PNy8BUmQtQA+bWtY=;
        b=dijdhOsu77eKvXnUHftUveI8NwZ1Ehpt1s+21QoMwl9hJSKfkYNlkijrw7517RoVNc
         lrhOqT5oNusRUMg/rDZ/6n5UccBbo7OJkrkyawN66zbQGqsLMhMqrvXUy8l2OPZiTMNI
         7ufe+t33Zk9tYdcf6pftVFcGDbwCk2PAHJ4AzLeX5w7MCrOZ7SSVLafyTtKMZCpEa+XZ
         T01VmDokOsZCIxTPl3lsDHT7tq0XAvoVoM2OrK+fQmEqXRlSiRjai2dNnIh92amI9e4g
         +XunRWJ2Af1UDab7VFqQwSAjwNGVO/NAt4q+dWwl7uJRQw+NU83er0XI0i5xV96+TcKH
         EFdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TYQSkbtesSkMhkx4ROSMNbPqpw1PNy8BUmQtQA+bWtY=;
        b=u/ZkoqJHi9gVa5cccAHRXVJeqkLda2/UyfTVqlqByYlKR+wZEfvah7W9Bx8YzC9aI/
         /1ulMoto+tVVv4KaUvPgN5YiAliLP3L1rdpMJaod6+Q7psnSadJWGA9ko8wATbYP8gbv
         1yZZZr8ZbxZ6SlVbKXxdxueoQgVI8tCpHHP+FXta9asxxJHv/l/Ieuvx914nKjV3Zyd3
         ex95af2z/OOXl2yXauUFATa3HfmECUQDg0jItgjuuJ6bygydkr1Pd1RdVMDn6UaE78mE
         Zlkpd5HZSmq2fP8YbHaVfwnF3wBfH/NPHEYoSdunX4TMIHIxWHcIzJbqHFVmwlBYSI1h
         Hcog==
X-Gm-Message-State: ACrzQf2ZI3dwx/aEgoIr0dV8A8X/vo4u3CgFI374LapGxsU1QFxHRr67
	HBuJect7S6qkaJu7leaAksY=
X-Google-Smtp-Source: AMsMyM6SqR6ACkO3klsnuvux/9Q488rsDcFTmuh1ek/hg4l1rICRFfT/gTPZ4y4ho6jV13S0MvMkBw==
X-Received: by 2002:a17:902:8c92:b0:178:29d4:600f with SMTP id t18-20020a1709028c9200b0017829d4600fmr30829208plo.40.1667488180159;
        Thu, 03 Nov 2022 08:09:40 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:1a:efea::75b])
        by smtp.gmail.com with ESMTPSA id p8-20020a1709027ec800b0018703bf3ec9sm815459plb.61.2022.11.03.08.09.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 08:09:39 -0700 (PDT)
Message-ID: <9dced807-952f-1ddd-ad58-f3fc3ec32071@gmail.com>
Date: Thu, 3 Nov 2022 23:09:27 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 09/12] hv_netvsc: Remove second mapping of send and recv
 buffers
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
 <1666288635-72591-10-git-send-email-mikelley@microsoft.com>
From: Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <1666288635-72591-10-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/21/2022 1:57 AM, Michael Kelley wrote:
> With changes to how Hyper-V guest VMs flip memory between private
> (encrypted) and shared (decrypted), creating a second kernel virtual
> mapping for shared memory is no longer necessary.  Everything needed
> for the transition to shared is handled by set_memory_decrypted().
> 
> As such, remove the code to create and manage the second
> mapping for the pre-allocated send and recv buffers.  This mapping
> is the last user of hv_map_memory()/hv_unmap_memory(), so delete
> these functions as well.  Finally, hv_map_memory() is the last
> user of vmap_pfn() in Hyper-V guest code, so remove the Kconfig
> selection of VMAP_PFN.
> 
> Signed-off-by: Michael Kelley<mikelley@microsoft.com>
> ---

Reviewed-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
