Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793788073;
	b=tRojAbwLi8IoFnUzK/xiHovzD5c/GEbnTQsyLg5l98Q6Z7ZZwwnjJ7i/jEvFQwb0ZBe9
	 lEVK3GIrVb1kDCY+lp3NEoMD/5SO+QBKhiZexxoqy0Ixcs9fq3943PNybMEgIhBd6zdup
	 LG8vIJk+gjkP1Op5BgAES+QuWxb4yrUJiVjJEXJ0h454D5iwRH/wjHSolRYOkZl414V10
	 UZ+VOiCImGxyZjzKmb3v49pbazLBI93g5j6V24u3ImT+KJyUt0kf9Ie3q3yqvtPOjPAVu
	 t00TrgBZZS9aJe9w5iteqZl1bQcIbGDIbmXo9CqipSoQRFH+Feuvi9RPsq3NDK5kFDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793788073;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=oxlAWrEkafenvw/FjrtjbduyFLL/BjALYNiaNpikrTY=;
	b=VhEEaP/wMLOdnV2hAzRaXA1wdbtkjJ/QG9z4gAxcY7FORHDxKwFDovE6uZ1xLKBun1zO
	 xdy7gO9Gtn7z9wda678iS2mQU+WYcktYJB+F3q2A1uZDZzofmRXqtZLn7AeMqMa3jYW2f
	 Q5GqRWdekW4YHxkjhUPHSFdXNJo7AwbGw50nTvFFLz7r1YPCT4gjR5waDx6FBleTshjFK
	 GcyEPT4E8ToQG5u9H5cmvHr5svKp1by8594nx0WPiKiyKhz8PnCKe1Yv036C75jHSI4+K
	 XPJXfm4ho7TDKTfOnFCrhhzIfOncoh/xuf4f1sXh7z3+moseE/3RLoAGa2+0Tpr05xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lo5VCC8I;
	arc=none smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805F9606A32D
	for <iommu@lists.linux.dev>; Wed,  4 Nov 2026 10:27:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 805F9606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lo5VCC8I
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6ae14cdc63aso7703a12.1
        for <iommu@lists.linux.dev>; Wed, 04 Nov 2026 02:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793788072; x=1794392872; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oxlAWrEkafenvw/FjrtjbduyFLL/BjALYNiaNpikrTY=;
        b=lo5VCC8I+VuwlLAQzPAIPhKfkd5UA5iWSdjEGpHEchENy0tmzPH6qWhqlD36tt/50o
         cNHMDtA1DefU6487m1n0neyrh66kkTEMct/cQaFhD1o6R+mwZAM1J5RLcN9FqmbprclF
         x2gNTFG+aKDDWN6LTr0hAG99GeupZgdmnkyEUQE8cnDItO7ogvMAUW0erCuWDMy+zZZu
         PLtQaCvmjrEBFqpS2uxvFWL9xKsa5jxnVpzeRZAsdWawNSHfNW/W2kMOwmIEAyEqPjz/
         IvGcQyc1+/3eMp/8sdRZlWslkVD+QF6s86ozKR9oUts6+r0kNrkkWOtDGT3Ozvdq8+mz
         bOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793788072; x=1794392872;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oxlAWrEkafenvw/FjrtjbduyFLL/BjALYNiaNpikrTY=;
        b=z/8tT1h8ytCVsOLUaiEl0KYTuxUd51/7kU/CDf7Aca0kTnUMmb1PQdbZwkw/jqD6Js
         jrOXC5Zy6H68XEgVg3pWmpawWHNaUKpqSTvz5k5NKxhsHIjAa4MAZbWjO/yLPKURBWVo
         BnlLRn4D0Qp0P5Z6Tb6PSoOYBfzf7zFwGAiwPKh0ksaolVsz5YZe6jPSgjPJrlRu5sFl
         zOj57zpcf691STzDi3+396iEKUs9gHvb8D2ZXDudVh0UzvCeYby3GcliNDgzlW5G8tkx
         /LnaoP8NpECp0WSqQHFdBFsFs+wGV8PofHXq+uwu+WvmsrAy+w39faXLRN/PuqvRAC09
         Sg5w==
X-Gm-Message-State: APuU4Z8JY0jjrCT3nlufaqCFofPH94pstHZzMBdhdt7cpxsR9IWwuoDG
	q5/f8nPzHso35yWPm33AyGwv8Zv+O5if40KP0tAUTPw2bTH31k5aGp7Ju0SpPxa4xljnl2Ill4i
	io1VwYA==
X-Gm-Gg: AYBFou1N+WfD8Pl2L7+5T9ifRYcc9P0tyh/nkgXLnrS6AyIL8xvROWJGJtrIFZQR0st
	Qk7gfllsIJY2HoxpN0S1ZGf0GkiWyWzevimG9aHDvGpX9QK8A/MfmWt59DrMrPOnXDBx/JxU9rk
	V5os8anbXsbJf0U1EHe8WevBzuWXocueXv9FOrFiHxA27lmMDSP5hjcid7xzlJ1L6CpZPfL2rQa
	84Fh9m0RGkvPG0Gb4oCvM1P8ptdyVm1O1Er4taiG629rb6VmJh4vvXdcif2IlZsIU9I3+6mJhG2
	KPUkk164q4ebfJSbllCTUe5frfyzKSxpBW9NGV7cMxX+HuPdr9gQvEGRXcoXFf1Sk+NQuih8YBW
	YtUnANTYTX2FiDv9A2HnisPwdmFw7afWO0kasUMDIsU7uSSYUgaMIqoIAQ2udvcb2lwHuBd8yvf
	CLcVVGBSL6Q1ud+UQhLgvH4zXfexXflrEzUGrZDxVm5ThT5lOcq9UavVSQonHvEVAM5J4ElkcD8
	K67/XIP8CjEGDcq1rZh3aowbCv4ozPZcLXLdPWMDNaFaomq3kFCob4yAYq4TwL2AWvD5Te+mOhG
	4dePpwHAjJ0PjwYzU4wXWz5kWw1FvqpCgg921RDCpmLc2JpCpJ/6o51j+7afAFVH9vA7NMRfP5j
	2Hig0kvu8pTmqrLGa
X-Received: by 2002:a05:6402:20d9:b0:6b5:5cd3:5dc with SMTP id 4fb4d7f45d1cf-6b55cd3077fmr36964a12.1.1793788071437;
        Wed, 04 Nov 2026 02:27:51 -0800 (PST)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d0e41d670sm54601366b.23.2026.11.04.02.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 02:27:50 -0800 (PST)
Date: Wed, 4 Nov 2026 10:27:43 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: iommu@lists.linux.dev, Jason Gunthorpe <jgg@ziepe.ca>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Wei Liu <wei.liu@kernel.org>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
	linux-hyperv@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>, Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Mukesh Rathor <mukeshrathor@microsoft.com>,
	John Starks <John.Starks@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@microsoft.com>,
	Yu Zhang <zhangyu1@linux.microsoft.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH RFC 1/9] iommu: Introduce external attach domain type
Message-ID: <ausIn5Txiy1uRjkY@google.com>
References: <20260925190742.1575380-1-jacob.pan@linux.microsoft.com>
 <20260925190742.1575380-2-jacob.pan@linux.microsoft.com>
 <atiakDqtuED2cTM5@google.com>
 <20261026161003.00003b71@linux.microsoft.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026161003.00003b71@linux.microsoft.com>

On Mon, Oct 26, 2026 at 04:10:03PM -0700, Jacob Pan wrote:
> Hi Mostafa,
> 
> On Wed, 21 Oct 2026 10:57:20 +0000
> Mostafa Saleh <smostafa@google.com> wrote:
> 
> > On Fri, Sep 25, 2026 at 12:07:34PM -0700, Jacob Pan wrote:
> > > Add IOMMU_DOMAIN_EXTERNAL for externally managed domains that move
> > > or attach devices to another VM address space provisioned by an
> > > external owner, such as a type 1 hypervisor.
> > > 
> > > This is not a paging domain and is not sysfs-selectable as a default
> > > domain type. It requires external owner context, such as a vIOMMU.
> > >   
> > 
> > Can't we use a IOMMU_DOMAIN_BLOCKED domain for that, AFAIU, the host
> > never inserts any mapping?
> Right, the host does not own or install any mappings.
> 
> The external domain type is nevertheless useful for two reasons:
> 
> 1. It allows the pvIOMMU driver's domain ops to do the MSHV & Xen attach
> and detach hypercalls 
> 2. It allows an externally managed device to leverage the normal IOMMUFD
> device-to-HWPT attachment interface: VFIO_DEVICE_ATTACH_IOMMUFD_PT
> No new ioctls.
> 
> It also makes the lifetime and ownership clear for IOMMUFD and
> hypervisor, the device can be returned back to host iommufd owned
> domains once detached.
> 
> In pKVM case, my understanding is that you have a emulated root SMMU
> which does not do hypercalls obviously. Then the external attach
> is done via an "out of tree uAPI through KVM/VFIO bridge IOCTLs that
> proxies those hypercalls."
> 
> Therefore, if we were to park the device in blocking domain while doing
> external attach (as you suggested), this requires a new PV only uAPI
> that must support pkvm, MSHV, and Xen. So it does not fit in the flow
> supported by PV IOMMU root driver.

I am not sure I understand this, how can the domain type change the
uAPI? can you please point to what breaks in the code if a blocking
domain was used?

Thanks,
Mostafa

> 
> I don't have a better solution for both pv and emulated root IOMMU
> drivers. Perhaps others do?
> 


