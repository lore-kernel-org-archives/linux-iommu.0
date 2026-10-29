Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793311269;
	b=o/BlAgkclZuk9wXw+hRn4lM+8ds1ua5CnN0TVvme5ahvNbSa4R+zLMMG9+vgDSPQYT7B
	 7JVcs1Z3ZGoN2HanPvf0bTJBWm5QiC9Z4hEpVOYcKT16cCADIok3PGwuZ9Fj4/srAyAfZ
	 y1P/pVyU0kcmYnFu4Uvv/SYCQkSxb2pKBUPwpS6I+lI1qdofP53U4qMOWqbKDDDf4mjYR
	 RtrFJwP2bmolK/+wkRoA3YDp1JkmHIx7SsNDdqPkJRoKJVVoygM6UIWu2rMA9sfv1exaX
	 1BgfsZKYDMEQkoI756HVymkRwi/5B2C8q7iAOdvgpsHN4B3+BJDbvzGGSOeErXhk8+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793311269;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=i+Wj9No24ZIzSMb91s5eR7ARJ45VgEQSQYILDa8r2Ls=;
	b=VgwxfKhQz5UxXioUETS9WLxHapTfeathTrxJ8j0YnRwQTxTokMdiqifM3d0WmlPcOro/
	 aID99pLM86KQhceGWvUYRjPDmai1UoUQvUJGhQl+KkZcCY4QwZrw1V4rtLkY93CbVIawb
	 80tKwcR0isLD8AJQE2bpz82px+PWi2JXd+imIPeCXgWDb72opCeQFyIhMnQS1gYAZzrB0
	 raJjcbgnYgwn3gEWOiO5zliWBlCs80yVuy4FNcecDitXP/DlTRd65I0H4ahaGOO/HUG8F
	 QOa/7zxYSYI26pNtH95hq/SDrczLtrrdyPaI7iG9Ttvicb2W0SXcgl0/ThzNOVGuxIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bgXS5BJC;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D072D606A31C
	for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 22:01:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D072D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bgXS5BJC
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ea7f9c11e6so26115ad.0
        for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 15:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793311268; x=1793916068; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i+Wj9No24ZIzSMb91s5eR7ARJ45VgEQSQYILDa8r2Ls=;
        b=bgXS5BJCZdtQJQGbYePB5R744m6NC1Uno4yz3uEvOVReUJ71SC7+5E36ZIwusbZ4iN
         qRSRduGOD1QICXkjqPTKo9ZL9+Xh+D6AtCaLgYHxvDD1L6IRctEq1NDyH7Tf0pfJXxEi
         1Sk5f1sa6ohna3jZxx+/uJCc84Ubc0XfvrZFBUu64ZnRjPhHvvC+EiHl1wKP445WAzvt
         ozMjDPnBw1/rkzlS7cZ+jDKLLSeq+7cDn3miXaw6t6A8LNpIZgcPh7YxbMXEWsG4bO1n
         jGq9/QXXgbrCd1OmD0zgs8HkCVj9BonPakclk2VO27WsY1ohBGMbzBarwkNsoadsPeMD
         4loQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793311268; x=1793916068;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i+Wj9No24ZIzSMb91s5eR7ARJ45VgEQSQYILDa8r2Ls=;
        b=yg/+lNq51Tm3pKW0/cocBG33B16pP/nyOUCAdNXbMugsW3eWq9DBL7fKfqheD6jHHd
         ns/TxBaHNh3x4RIbafFQlzCTEnQykc1ulOwDzG/kCVKaX68DnIvIh/NYc4DBvfY7v0m8
         neewFuw1CztWwXNzzyY9Uzj7ev8AR+cbAd0XT18Q0rOmjbdbXxWUF3ZLYm9asdigPTOw
         9AKqEuY9NkZr4Iz0gVBibxPCPQUgK6jMByLD3XN5ZjHacahH9+xd/QLmPrG4p0xTHB2V
         x8FWUOmKFrrofGl4IPg6glI8XuCn3HXD33my4hY4pKdZ+NtuzJ6BGx7Dpt0Suug4JSsF
         A1DA==
X-Forwarded-Encrypted: i=1; AKwUvBxHVwUo4/BF6St5H9NFuUh2qcXFZrFki8ZnHpJ87W6c4yQpfHWt1QhRD/zpx5cuF+eStu4K9w==@lists.linux.dev
X-Gm-Message-State: AFq9FYIAI789fNTkqWaFA0ucpPfL42ouxWwa0BEtyn/a8Askj6q6ZboQ
	S6KCmE0sTkCELafcFQAJXEUHqc1Nuz76TLBT6m2pX7tFBNL6X/zoLynEiu5FnPtehQ==
X-Gm-Gg: AYBFou1aerZZzuPuHxBhYF8Fdc0PodDkcwulaPHV+27ESkwhzKCRtrE+m8pfJyYU/Kc
	z97ah9anPoOmrg8vAF9o8lWDhVJnF/VE0/kibCCDAechefUB0jjezoUspnH/0clxIMErkmkDnh4
	yo9iX5BbeQFMhDMiJqVvAMpeOaesaHoIScePx+I18PXrigZKESfTJNneZGFzeqoppL+Hl6rUqFv
	RWJxnSk1taU7yNuC1UyQnL8eYjJtEbJGTLimM3sHrTbmud0NJ2wQm8lvt3YKTK2FFjY+4Sl8Wf8
	H2Tsr+XxS/ZIZjf1A5cd43vGyp7XMMPxrHaO1m0J3EIdeBOGdfGMjCu9Lp6JyoY2mv/LlKdtQC+
	PtWMQ1M4OAGNa/+/tp3IhC2ehH0L3syEqwL5/rG5w3iFNs5wkS9vRR7JkrkLyhmWUGqPuMo7dut
	LtBDBtDL74ywSueb9CGlGJZqMqTJFviD4eoguLgX/M0PEHP/karTaz2hTmblyYisvJOqTRi2k5Z
	qUdoYbZsBcVok/t/Cx3a1n38vhQpSR+QGL2yIN2OFWQwyKhdzI+JvAX6F0cJqskUb+tkGffIyTu
	mzrCV9utZUgdiEZvuChPawF7j36JXjHvYLnEKVlgdZGpsgkNAFQUbL3U0rw7bTR46wNI7lvsC1e
	FdpQt/YdttPnE39y+yd6AzA==
X-Received: by 2002:a17:902:d2ce:b0:2eb:188a:1c06 with SMTP id d9443c01a7336-2eb1ec12e12mr6703785ad.9.1793311267514;
        Thu, 29 Oct 2026 15:01:07 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb3694c6aasm1096605ad.51.2026.10.29.15.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 15:00:36 -0700 (PDT)
Date: Thu, 29 Oct 2026 22:00:32 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, David Woodhouse <dwmw2@infradead.org>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Pranjal Shrivastava <praan@google.com>, 
	Vipin Sharma <vipinsh@google.com>, Ankit Soni <Ankit.Soni@amd.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, John Starks <dev@jstarks.net>
Subject: Re: [PATCH v6 07/18] iommu/vt-d: Clear unpreserved context entries
 during shutdown
Message-ID: <auOtrI8lFrfwdkB3@google.com>
References: <20261025021930.674647-1-skhawaja@google.com>
 <20261025021930.674647-8-skhawaja@google.com>
 <5e0be0cd-c2ae-4488-b95f-b04b8315a1ed@linux.intel.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <5e0be0cd-c2ae-4488-b95f-b04b8315a1ed@linux.intel.com>

On Thu, Oct 29, 2026 at 11:18:02AM +0800, Baolu Lu wrote:
>On 10/25/2026 10:19 AM, Samiullah Khawaja wrote:
>>During normal shutdown the iommu translation is disabled. Since the root
>>table is preserved during live update, it needs to be cleaned up and the
>>context entries of the unpreserved devices and root entries for the
>>unpreserved context tables need to be cleared.
>>
>>This is required because during kexec reboot and shutdown the devices do
>>not go through the release flow, so there might be stale entries in the
>>root table and context tables. Also note that new unpreserved context
>>tables for unpreserved devices might have been added after preservation,
>>so the root table entries for unpreserved context tables also need to
>>removed.
>>
>>Signed-off-by: Samiullah Khawaja<skhawaja@google.com>
>>---
>>  drivers/iommu/intel/iommu.c      |  15 +++-
>>  drivers/iommu/intel/iommu.h      |   5 ++
>>  drivers/iommu/intel/liveupdate.c | 134 +++++++++++++++++++++++++++++++
>>  3 files changed, 152 insertions(+), 2 deletions(-)
>>
>>diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>>index 14bd1ca4fbd5..23a1da351ddf 100644
>>--- a/drivers/iommu/intel/iommu.c
>>+++ b/drivers/iommu/intel/iommu.c
>>@@ -1967,6 +1967,14 @@ static int iommu_suspend(void *data)
>>  	iommu_flush_all();
>>+	/*
>>+	 * Note that IOMMU suspend doesn't affect live update. The state
>>+	 * preserved during live update is not released and remains valid during
>>+	 * suspend and reused during IOMMU resume.
>>+	 *
>>+	 * Also note deployment of suspend/resume and live updated use case
>>+	 * should be mostly mutually exclusive.
>>+	 */
>>  	for_each_active_iommu(iommu, drhd) {
>>  		iommu_disable_translation(iommu);
>>@@ -2512,8 +2520,11 @@ void intel_iommu_shutdown(void)
>>  		/* Disable PMRs explicitly here. */
>>  		iommu_disable_protect_mem_regions(iommu);
>>-		/* Make sure the IOMMUs are switched off */
>>-		iommu_disable_translation(iommu);
>>+		/* Make sure the IOMMUs are switched off if not preserved. */
>>+		if (iommu_preserved_state(&iommu->iommu))
>>+			clear_unpreserved_context_entries(iommu);
>>+		else
>>+			iommu_disable_translation(iommu);
>>  	}
>>  }
>
>When I revisit this, perhaps we have overlooked something.
>
>After intel_iommu_shutdown() in the previous kernel, the memory for the
>Invalidation Queue, the memory for the PRQ, and the interrupt vector for
>the DMAR fault are all freed. However, the hardware is still configured
>with those resources. This potentially results in use-after-free bugs.
>So my understanding is that while we can preserve the translation state
>in intel_iommu_shutdown(), QI, PRQ, and fault handling should be
>disabled and their resources should be released.

Agreed. I will disable QI and mask the fault and page request interrupts
for the preserved IOMMUs in the next revision.

For PRQ, there is no way to disable it at the IOMMU level while
translation is enabled. But PRE is already disabled for the devices on
the preserved IOMMU, so we should not get any page requests.

>
>In a normal kexec, DMA translation is disabled, thus all resources
>configured to the hardware are released. However, this is not the case
>for the live update scenario.
>
>Thanks,
>baolu

Thanks,
Sami
