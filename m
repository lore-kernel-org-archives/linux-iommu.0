Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8763182
	for <iommu@lists.linux.dev>; Tue,  8 Nov 2022 10:36:54 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id gw22so13400984pjb.3
        for <iommu@lists.linux.dev>; Tue, 08 Nov 2022 02:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7FC4xTWKbEcJxVm+LBMuB4SUqqHDVOvyFDbcq+yh01A=;
        b=oCWmwDp8Mq/94lPgWOpRNMqusVjIbpZKRV9JeuSrdvQOJhGpRXChOO08QAlKk8Wx73
         s9dECqgOGqSg/8HsqRHiP/XKfZq37XO9aPQHjT6sIVfwd2T5rgHuMt0YXR0vcVnuqJPC
         bYyXpc+YB5DY79XuJsgDgEnii3hXBb2hLVOouhQABdDKDpptyrIasT3qltTbts8XnJrU
         VZTd4OMKS0clmozmVyOJgYGhRCfkJh6l8h11/FOcCQ+LBk3+XZqX0RE3+w4sLEria5R3
         Qsi/EmUKkAqx8Cc/Ujp41/7pVyFg5TMnjalYEafM8z3HSH10qmw+8OMIN07CWneo6bGA
         xdsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7FC4xTWKbEcJxVm+LBMuB4SUqqHDVOvyFDbcq+yh01A=;
        b=zWpJnFf28N13xlacyiLgVeNxut9rx3YLnUkMOOqHPZsKe2fRJ2lS0RInpuOH10evki
         /yyLwHz/0X9p1r3HR4r2Ks/LbRvMHohhfdFZzTSMTbtr/NgfRHQMu9boStWcvY4CL47v
         e9eP74FbXRrAs1yJs23D+gqO2vxVSigHFnIUkf5Dfen93YtDLuKxeD3WARRaAOhZXSJX
         JZh5a0kRVwG04hozAk3+SyoUH+9zMPTNwySls8R8X3f9qpd024lvELXYOLwgEVS+6ZGe
         2+XOSef0xILXjnA7Z9uIVxLarLU293SBWx+FTL+vjNKecJp9BvjrvT9MIc5lksLqU2sV
         t9Fg==
X-Gm-Message-State: ACrzQf2zDY8CJ0RUYsDf89icS+XF5YAUkRDW72vzLwwhn/SY5q3Z8R6x
	caEfAelvtML1SZ7Mzh2+V9o=
X-Google-Smtp-Source: AMsMyM4t0UZsTKGoBIe7o5gVWR0wgRXPrt+fajdjHMMuWw0RmjuTkgxkIK95E7qPspPcKE7d1giP0A==
X-Received: by 2002:a17:90b:254c:b0:20a:8a92:ea5b with SMTP id nw12-20020a17090b254c00b0020a8a92ea5bmr56165515pjb.81.1667903814151;
        Tue, 08 Nov 2022 02:36:54 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:1a:efea::75b])
        by smtp.gmail.com with ESMTPSA id h5-20020a17090a648500b0020a11217682sm5700073pjj.27.2022.11.08.02.36.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 02:36:53 -0800 (PST)
Message-ID: <9a4edf34-6e49-9fd0-fc23-2536c5f087ea@gmail.com>
Date: Tue, 8 Nov 2022 18:36:40 +0800
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

Reviewed-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
