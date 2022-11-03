Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689C16FD6
	for <iommu@lists.linux.dev>; Thu,  3 Nov 2022 14:00:52 +0000 (UTC)
Received: by mail-pg1-f170.google.com with SMTP id q71so1728323pgq.8
        for <iommu@lists.linux.dev>; Thu, 03 Nov 2022 07:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xa+0pLAudD6PF06JImFuL7wHTWb9VCg28osWFz6WhGY=;
        b=fJPJDNbojQCIWRnIYnzAvODJUoL1TR6QAu0UwsxvlNSTyVDdKT94NGT9bNHO8H3ZGC
         Qjj1ShOVMKmQZNpRQq35lslk8d864Tn4pRM3am8HvXi0P+QvxUoVPXhbzqt9KQLIcAZj
         hDDSCBB23VxtVeyw7oDQHBf5ga3KOy7ONW3ZozO224wMLz/l6L8+kQqfu+G/fZdp6NB0
         xBc8fs150Vp7/hnwYZXhIsKnATAogsditSiwHDiznGXzlYmqvB74huK95HMmJldE+JTA
         s2lJK57Q9DP/PbWgeHEQH6yeABAMAeySnaKWytYPw6hMtbhAE1YbdlIs2M5QQC8bBlx4
         EuKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xa+0pLAudD6PF06JImFuL7wHTWb9VCg28osWFz6WhGY=;
        b=5sEgTazkzfJJvSG7fKd/9SU5xCy82ErXRzqb/8yR6f0XlrNlVbgoMUB3wgJM+y7mVv
         awgr0bP52WUkZOSiOjsVAqAoxUudju8s5/GFk6kyG0PNPnQMG/PNI8b/HW6npTxn1xOL
         9B2TyRWAAUV8NYsBGpmmRcwF+Li68W2mCIC9R5ykIwhZz9PZZvpi0kqBDsMutf7z6Q1P
         +uy7fwFli8nNZTzUB/kEEhyMgDw0Y+VM9fSjo4yf6a1IPQmusx61khyBUaaavRjoOrta
         6qeube03cUEcOFOEHgJEa5LhXOj3duSHHpfyWSEItGpH5Kqdr4BZm0UDa0vJawRWCpPz
         jftA==
X-Gm-Message-State: ACrzQf0RdbmKEz7dZ8XxUd7+7c6Dt5EKnLp61Hm22YMLY0NGSkrT8B4l
	GIp3FpBTAzFq1dJspvj2FMY=
X-Google-Smtp-Source: AMsMyM4O0wDTELSc3hfPrRbSa50TbC9VySJnF/LiWdrNYmNQeUji+UKtn2FJqVoSfqerI/f2rbEuzg==
X-Received: by 2002:a05:6a00:e0f:b0:56d:6e51:3060 with SMTP id bq15-20020a056a000e0f00b0056d6e513060mr22351121pfb.55.1667484051717;
        Thu, 03 Nov 2022 07:00:51 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:18:efec::75b])
        by smtp.gmail.com with ESMTPSA id e18-20020a17090301d200b00177f25f8ab3sm725747plh.89.2022.11.03.07.00.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 07:00:51 -0700 (PDT)
Message-ID: <1eedc23a-8b50-bd90-d398-cff3f22af01e@gmail.com>
Date: Thu, 3 Nov 2022 22:00:39 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 05/12] x86/hyperv: Change vTOM handling to use standard
 coco mechanisms
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
 <1666288635-72591-6-git-send-email-mikelley@microsoft.com>
From: Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <1666288635-72591-6-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/21/2022 1:57 AM, Michael Kelley wrote:
> +
> +void __init hv_vtom_init(void)
> +{
> +	cc_set_vendor(CC_VENDOR_HYPERV);
> +	cc_set_mask(ms_hyperv.shared_gpa_boundary);
> +	physical_mask &= ms_hyperv.shared_gpa_boundary - 1;


hv_vtom_init() also works for VBS case. VBS doesn't have vTOM support
and so shared_gpa_boundary should not be applied for VBS. Here seems to 
assume ms_hyperv.shared_gpa_boundary to 0 for VBS, right?
