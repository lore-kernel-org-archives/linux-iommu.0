Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793625243;
	b=YRnJJsdv2Jd3fmY30JMF5o78eVjxm322xBUc7WVmHd8nD9rzWXZauel6u57IQIDzXws0
	 1ZUpONS/TB61YZ+M+NO/PkJ/ZzyZwAW9I39sAgCj2YEeR8ALsmSvMCqkopr+xWwvRou0N
	 ei/I8OxOkZxoqr3dZKiSwKVH1ZilNHtzqM+jfuvoW3JpR2aFY/LPKCpqIzI8h0x5NHMF8
	 /gVlcudbVGDPg5UAIppqrvbGeRVlF6PFK+7QSGnPlPS1La//N1h/v16bUw+ONrRNuRziC
	 A9Vn25KSn5s/4QUS/bg0G3c4AKRi2IBBkFTNGXZNBwVuUzQxhXkyrGrCYt2hfhPt2Bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793625243;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:rom:From;
	bh=xQ6t+GMfhU5C0Rvm61dIpYM5RO8AvEBQYn2+KfQV/CM=;
	b=JOBB39fZ8o1+3olumlY52mauWrNvfb5U/Aa2/IEc6YVBBQBgE/0MAcTzDJEmtso+Bo6x
	 tFlPfsBxFBWCLZEgfY6AuoGPQKSS0wTm7AHsrmLXx67c9PU2ZwjRoUwixIxjS5oXrVdxp
	 z9IhjUWnLYskAsT+MNRL1CvCyoOWwR3YtxlYrUVGjkaXvrBMjNlVmWhl45oRzGDVErJMM
	 VQ6hjQwSlL9eIkxONwofH/M0MVngewNpQ4kd4IiTI9SzNCdLlxRx7KjrCzNo6v2Pspf1N
	 7gfc6TtQv3QqXLk5CMqw797JpbpOlVnYZLSBdw2Lt/cXSR0jsb8nWU4lmlPTWRDauQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b="mNd9/TGb";
	arc=none smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9593606A327
	for <iommu@lists.linux.dev>; Mon,  2 Nov 2026 13:14:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9593606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=mNd9/TGb
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5361e313e63so35293401cf.3
        for <iommu@lists.linux.dev>; Mon, 02 Nov 2026 05:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793625241; x=1794230041; darn=lists.linux.dev;
        h=from:rom:in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xQ6t+GMfhU5C0Rvm61dIpYM5RO8AvEBQYn2+KfQV/CM=;
        b=mNd9/TGbt4ZhzN5tHSZt3QB1iZaIz5B+3cV1gmuQKvgLIFPIOL6YqcsEOQF7K5OM1q
         ekMFcAu2ZNQlE6zbe3k/8f4wwLKztU2Lv/4yZeQO2zBivK1HHUBdfVUbSU6bcdJ9nBQS
         7ljPKfnp4hhMECdfeHNdqDOUd2W5WQCUeId9ylyDLHRyG5Zgicleer8GTNXauf5B4y7s
         4/OnD9Y7UaTqhVjP6re8iNZN4kYygh8nz9/iE6t1Qe2kD1joUxAs9fxcPsWGk8Fe9NzG
         5Qjwx4cbh/8XCfdKLlWAQPwLJN3dIrFk3pcEwJ7QhdvZjf+URK9q8wVZ7xaVBPU7Bnc+
         kTrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793625241; x=1794230041;
        h=from:rom:in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xQ6t+GMfhU5C0Rvm61dIpYM5RO8AvEBQYn2+KfQV/CM=;
        b=mX/Y0M6M56b+cuBCz2fhfXmBGeug4Gfn1IcGKMKhO45g2SHBCrljImWkSBRiEaOk+6
         txozUN9WrgMuiYKLclnNchZqBbGBNczDmZKhsbaBTsSlBaiqopIq0XGLQMG+zt63LfsO
         WHyQfpxHYXuLK9p5IbWRqilNFw2EyWYCmUZ9Q70YXOfhvM+ZxGAfLxeXdcR37i+x9JL0
         EdHWoij8UZ4Od5FX/B7QDLV5/7iKuPf44FqeOsTZ2SMYccQoMbQU76ya6N9x4WhjErX/
         l/Lh/EGK+yh9c/vLtynwVc3qccWlRoZ2oZKSSLAbwjumrhARFDKBJzZlyVQ4B5zkd2LN
         2DOQ==
X-Forwarded-Encrypted: i=1; AKwUvByg7kf0Woi/DdnXXgEOkJCsg8wG7Hg65XVCDzBzBrAOL5PRYbZTxz+Fsd+T95l1olDNZ3pwmQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYJyJmiX8TCZ7tyEGFLIKXeIrf9jWsvBC8VT88SQKWH/gg8XlGn+
	WYmeI/8RtEpWPGG9NJWTDYT9hRfEfjFnS8EgR4gmVt32DPLtLye484AAcLIWcLCzQxk=
X-Gm-Gg: AYBFou3UH8wo95AILZ8jjLQVoqMFczPl8oN0Ud0DdUfW6MXu0HmbZJ/pCRi8Fga+8sy
	kaYd35sSWvbaAoU2PqvzT4MDmCJcxO7UUa/Nx1nTk5nVrksmKqzp8mejoNuNo01VQYUKkAxER/+
	6TvOk3jmLN4yumZZ5rBymx0bKTv7/XwbyqP8Bg4oPvxuZjnGmtIgFknToruR6Y5ee8bhkDpouxs
	NteJEEISgcTcA6vdtDQF0pvUdB/OzZhL8H7z3hIzDTYG+IPTavYciRj7W6uiKOGGB0dliFKEwxh
	9vVD8/7Ai3m93LY78XoFi/g5JktgnVETjm4Dqa8Yw5y+y+egKBEDvpk2kcUL+2FK7mRjbydHFOC
	t/o3UC/LBIa00svJTD3rROrIxzdeCdvvDnIcY80JFYVbgkI2dXVLLQiTIr9vDkG+ddxmzs+f/8T
	lubKiCOpEA9j4JL9AqyG8fGvwedm7AnTIfVhsn78Ad3hCzV8Jx936LbALR4YcPEruTj/UnGUyt9
	3zgSFCfsgjUnGOkS39Y1D3TY+vlhj3MBuFNE5rt6I8Vi/QQOUUbS8oye94PMW1dI1OlM0UdZ8ng
	JpseTtBALxDuvY7hCxzWA1NW5f1095L+NUXJNaA8F8BJtspTsMM6D46UEleHkdUylwbU8thHzQZ
	9OZuMqoFdgmYq7LlHtBOdrPf+sFhiWG8=
X-Received: by 2002:a05:622a:a07:b0:533:3fc2:8b19 with SMTP id d75a77b69052e-542b658df3cmr161864101cf.20.1793625240711;
        Mon, 02 Nov 2026 05:14:00 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5431246c7basm85036611cf.18.2026.11.02.05.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 05:13:57 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xNrrI-00000009is5-3yQf;
	Mon, 02 Nov 2026 09:13:56 -0400
Date: Mon, 2 Nov 2026 09:13:56 -0400
To: Gong Shuai <gong.shuai@sanechips.com.cn>
Cc: fangyu.yu@linux.alibaba.com, alex@ghiti.fr, andrew.jones@linux.dev,
	anup@brainfault.org, aou@eecs.berkeley.edu, atish.patra@linux.dev,
	baolu.lu@linux.intel.com, guoren@kernel.org, iommu@lists.linux.dev,
	joerg.roedel@amd.com, joro@8bytes.org, jroedel@suse.de,
	kevin.tian@intel.com, kvm-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	nutty.liu@hotmail.com, palmer@dabbelt.com, pjw@kernel.org,
	robin.murphy@arm.com, skhawaja@google.com,
	tanchi25@mails.ucas.ac.cn, tomasz.jeznach@linux.dev,
	vasant.hegde@amd.com, will@kernel.org, zong.li@sifive.com
Subject: Re: [PATCH v6 09/10] iommu/riscv: Add dirty tracking support for
 second-stage domains
Message-ID: <20261102131356.GA274202@nvidia.com>
References: <20261031083014.15040-10-fangyu.yu@linux.alibaba.com>
 <20261102091823.54287-1-gong.shuai@sanechips.com.cn>
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
In-Reply-To: <20261102091823.54287-1-gong.shuai@sanechips.com.cn>
rom: Jason Gunthorpe <jgg@nvidia.com>
From: Jason Gunthorpe <jgg@ziepe.ca>

On Mon, Nov 02, 2026 at 05:18:23PM +0800, Gong Shuai wrote:
> >@@ -1439,6 +1454,9 @@ static int riscv_iommu_init_domain_s2(struct device *dev,
> > 	if (domain->gscid < 0)
> > 		return -ENOMEM;
> > 
> >+	if (iommu->caps & RISCV_IOMMU_CAPABILITIES_AMO_HWAD)
> >+		domain->domain.dirty_ops = &riscv_iommu_dirty_ops;
> 
> This sets dirty_ops based on whether the allocating device's IOMMU
> supports AMO_HWAD. As I understand it, the domain/HWPT is not tied
> to that IOMMU instance. A later attach may target a device behind
> another instance without AMO_HWAD, and the attach can still succeed
> with GADE disabled, potentially causing guest page faults.
> 
> Shouldn't we therefore revalidate AMO_HWAD cap for domains with
> dirty_ops and reject this combination?
> 
> FYI, both AMD and Intel have attach-time dirty-tracking checks. See
> drivers/iommu/intel/iommu.c:3195 and drivers/iommu/amd/iommu.c:3221.

Right, need to check on every domain attach that the domain is
compatible with the iommu instance.

Jason
