Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A5E1872
	for <iommu@lists.linux.dev>; Mon, 15 Aug 2022 13:32:29 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id 202so6498712pgc.8
        for <iommu@lists.linux.dev>; Mon, 15 Aug 2022 06:32:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=6+NKr8x81snqBPCrj5grt+MbWltUZu5PmZe6P/3T6aM=;
        b=vSiwf11W9NsIkpF3fwix3d4e3A539RYXNSW/Ub7TTu3koCVHIm4s2Uk7klcEcM5AkL
         ZvFysMWLXoYSzgD80uI7rZxzDSZIN5atOM0WMBqgoIycpPOeQ18Pg8RbBUH2pu+kv9wo
         8/Kdr7mhSukYvP+pi7thbPa+wvmUVFVL50dYCumB/FmNXUH5W0W6OmKqwEluabtJNlkw
         Ge2hZCf+atWYOvw95ufgN0vkAd0b7hDumz13Iz9TlY1BApV+VtaV/tB46vJlbuOmoV4/
         KBwyQ0otFujB+SVQsaOKKzh87W4RxgKCVf8NBNOXTvVvBAoGEcMQiBTsfgoOVwSKFelS
         zg3Q==
X-Gm-Message-State: ACgBeo3YVsN9cDgSU8fkEDnJ7Yr5KAqnLQNApvdSeJprGtYw551c+mv7
	Dm95bk1ENCh8DJ674sriPpw=
X-Google-Smtp-Source: AA6agR6oSpgHxc+dt63vqfcdjwfag3ms5XkVohiacbxfketzvYVSYHIwNqzSsvU+tSB9zeLx0MXvcQ==
X-Received: by 2002:aa7:85da:0:b0:52f:c5bc:cb41 with SMTP id z26-20020aa785da000000b0052fc5bccb41mr16401699pfn.31.1660570348933;
        Mon, 15 Aug 2022 06:32:28 -0700 (PDT)
Received: from [192.168.3.217] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id q5-20020a170902eb8500b0016dbe5f5308sm6916750plg.79.2022.08.15.06.32.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Aug 2022 06:32:27 -0700 (PDT)
Message-ID: <ab15191c-d79f-b5de-7568-d15b8f8a8aa8@acm.org>
Date: Mon, 15 Aug 2022 06:32:24 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: lockdep splat due to klist iteration from atomic context in Intel
 IOMMU driver
Content-Language: en-US
To: Lennert Buytenhek <buytenh@wantstofly.org>,
 Sasha Levin <sashal@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Liu Yi L <yi.l.liu@intel.com>, Jacob jun Pan <jacob.jun.pan@intel.com>,
 linux-kernel@vger.kernel.org, Scarlett Gourley <scarlett@arista.com>,
 James Sewart <jamessewart@arista.com>, Jack O'Sullivan <jack@arista.com>
References: <Yvo2dfpEh/WC+Wrr@wantstofly.org>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <Yvo2dfpEh/WC+Wrr@wantstofly.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/15/22 05:05, Lennert Buytenhek wrote:
> On a build of 7ebfc85e2cd7 ("Merge tag 'net-6.0-rc1' of
> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net"), with
> CONFIG_INTEL_IOMMU_DEBUGFS enabled, I am seeing the lockdep splat
> below when an I/O page fault occurs on a machine with an Intel
> IOMMU in it.
> 
> The issue seems to be the klist iterator functions using
> spin_*lock_irq*() but the klist insertion functions using
> spin_*lock(), combined with the Intel DMAR IOMMU driver iterating
> over klists from atomic (hardirq) context as of commit 8ac0b64b9735
> ("iommu/vt-d: Use pci_get_domain_bus_and_slot() in pgtable_walk()")
> when CONFIG_INTEL_IOMMU_DEBUGFS is enabled, where
> pci_get_domain_bus_and_slot() calls into bus_find_device() which
> iterates over klists.
> 
> I found this commit from 2018:
> 
> 	commit 624fa7790f80575a4ec28fbdb2034097dc18d051
> 	Author: Bart Van Assche <bvanassche@acm.org>
> 	Date:   Fri Jun 22 14:54:49 2018 -0700
> 
> 	    scsi: klist: Make it safe to use klists in atomic context
> 
> This commit switched lib/klist.c:klist_{prev,next} from
> spin_{,un}lock() to spin_{lock_irqsave,unlock_irqrestore}(), but left
> the spin_{,un}lock() calls in add_{head,tail}() untouched.
> 
> The simplest fix for this would be to switch lib/klist.c:add_{head,tail}()
> over to use the IRQ-safe spinlock variants as well?

Another possibility would be to evaluate whether it is safe to revert 
commit 624fa7790f80 ("scsi: klist: Make it safe to use klists in atomic 
context"). That commit is no longer needed by the SRP transport driver 
since the legacy block layer has been removed from the kernel.

Thanks,

Bart.


