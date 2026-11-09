Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794223813;
	b=EIUVEQf9QdKwFvopt2TZsgIuZtjuqpFLRPkYLn4XsXgy/PW4IxyTLmC1+w5RVvPNFKhJ
	 gXA+HpwPsOtL3APb9VoIv7ILdjTHNJvytdjFl/MqNG8k/SmzHMsSJWaEd4XnNZL+kCK+6
	 GUo8QLVKqfWmG8VQZ6jCXLO9o0gVW8iAE3X0aW1Fq5kTBEF++2d9hCAxWzIOEihdDKEBa
	 4VflssnR8stWWk7ZCErE5InYdM0F6o6Qsl8Y4j4v1wwSAWlWzhud7zpjYe0PxwnrkjsmR
	 deJb6UynRb06TeLJRa8uTTEylkUhdGq6TxCyD+GAGsq0NIdAoRSmAIdTLu/5U9Y2TAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794223813;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=OCgYpXH58qINyNwsYRskFASB4t/CiniG84M2T/tv7W8=;
	b=OsvVMQH77maP1W1bu6Du8LLgkxF4LTg7dr7iN5gPr/fAkogPTfp4/ioBW7lseerI+B/O
	 Prrh+F9EvOVjKfXa0mEDwBTYlFlx+k1U2lL1sHRtCbHcp5cNxGo1GBlBejJSFvv2vluk7
	 n9GyYMw0sX2dCYoz4OULqh2c6lIoTKHAh4g9OwibAFXRwvHE0kpllJQa9h3mZ1xOLNOUG
	 54pLHGafkeaYsyHH/qW7J/txC3jlhO8ICyG7z3sRjxbO/POmTcM+mzhFZh/MTV8DjldvD
	 cG8xAYdu6eNujpkYNwXXOmtO8qj1A8NpMI7lbq2ifFe4GZkat6ZbQi8kSDXfLJMG7ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NjRidnRb;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F13606A336
	for <iommu@lists.linux.dev>; Mon,  9 Nov 2026 11:30:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27F13606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NjRidnRb
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a206f0b95bso30495e9.0
        for <iommu@lists.linux.dev>; Mon, 09 Nov 2026 03:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794223811; x=1794828611; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OCgYpXH58qINyNwsYRskFASB4t/CiniG84M2T/tv7W8=;
        b=NjRidnRb8X9XgX/33qA2B+lmiIH4TzJ/2I+SM61HjFzCp/+z/Kam6Ue1rQ1+FkaXFa
         oqWgqTPk0PhM45l1TDPuF8TLtT9itTfwoNjzuQw5HY0WgYtLGzTBYzCampCEFZMZ/exf
         qnBEtHNNU/g1wFJmfiKamrt49ThdhyiBx7i8uI2Nlx3mjHWtfHEKpEtO8Vuc26VESw6O
         vO6yijADaWHM+3DjoO9Q73wHOVbQmOSsZ120f5LdfbE/qCnP/X8op7tfd3G0PkOTJ/YW
         emnbShFxgjrODqNiZ+VrV5LFL/wcYBF+xBtv2r9ExWbDiyQ65n6d7QTk8mNTkUU5mxX6
         7YyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794223811; x=1794828611;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OCgYpXH58qINyNwsYRskFASB4t/CiniG84M2T/tv7W8=;
        b=y8a7QateGWqUgre5hfMaQVxRx54Zo4yyvJjHnG9KwAcnOYLx916xZqB4/igsmsNu6Q
         Oh9CmuV9xSqSujx4klsu0WMJT/uPxHjlDNZg0KqSLOaRVUEDQxvqukbrKFNF04czVqka
         kBmHUxh4DAWXjGaUlfd11ylSILz/xBfvZgNYInPG2cRCdhnesWWp1/oFIkdwv8UOPhim
         FlkRpTEq0arVnvMDJrhwM4v3XKhfl3X5Ryorne47nal+grCjUv2WPwwBn+ZaS9Ob7Oty
         VWQN/gpnAl3mHrEQCaTyud6sBH5dDyuVWt4qVWFhzpGmHXzTUR6Sgfg6uZHs6QUtIalH
         V+Rw==
X-Forwarded-Encrypted: i=1; AL+hErEjixHz77Hi621g0HkrUnW9/4gX3iyCU/UO+31AuzBp3UfmdZ+x3OXVuQP98E7kK/lJXB4/NA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+DiGJfcdyJtWgEXbFXKImMKWzJgZApHjFy+eNF56OvYA4t/VJ3
	1hD6EYmJnOC+LncsvPUswR3KGOKRWlea4usoZSonFjtlNJq2SuToRdS3gt0f0e5eVw==
X-Gm-Gg: AYBFou3C2l4SqcYQEVrvMEWLzv8oTaXIq4R7e/gQ40wpiOGgN0j0L4rFfcM0IzxGpoc
	066rJTqjVwDa10mU0uMEzuysqtoRUgHK/0+NS2fSyhyttM1CoBKTZlBwjIULS6kXsSLGhGEAhzp
	qDAL9N8QVTCbkx5jH/3zTVwN5y/CCJKqxuAoD4OKv2gdqNbWn+tTkchyoox6Bw5luxaKeLjDPEj
	K67mEiajGUbMVxfGiCaN1ChJCbLfb8UDvNXAFLPlEgtnx/314Bs9DZJ+n+Jt1pNhrOivc7dAFs1
	Wt+JP7286krwMLq7CZSNWvM0YCQ69dUFsfmVsoi862znX93GST+limvCDOzsdl4f/o00XkhMHD/
	20zxIO83D7o/LR/J6INQk4oNHpVFefSxGFQuQDHoAjv2tcJHCb3P9scL3CmZvuGrmN7eNYj1MRg
	o4yfyueeqSk5OOl0YEDkua7HvBNCH1PsHoFOEziFdXFupB5K7FmY9Rwiv+mh+fNgJWhGfduyZTQ
	hSVTms91fJ3fORJfbu6JQHzge7t2rvlkTi7NawqCYQlLGpeVn1ws2pfTDUJtm3bYb0BJ4nujM4N
	1/FKjPnd/XZidsuQVkr7WYoagFSyxeQ+IP6EWAvH6DJTtAFq0cQPGgw=
X-Received: by 2002:a05:600c:a599:b0:4a1:9c54:1853 with SMTP id 5b1f17b1804b1-4b8190fb89fmr1464795e9.5.1794223811041;
        Mon, 09 Nov 2026 03:30:11 -0800 (PST)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-495974660bdsm8966088f8f.37.2026.11.09.03.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 03:30:10 -0800 (PST)
Date: Mon, 9 Nov 2026 11:30:05 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, jgg@ziepe.ca,
	mark.rutland@arm.com, qperret@google.com, tabba@google.com,
	vdonnefort@google.com
Subject: Re: [PATCH v9 14/25] iommu/arm-smmu-v3-kvm: Shadow the command queue
Message-ID: <avGuvQ8uiYRGitkj@google.com>
References: <20261015200903.2735565-1-smostafa@google.com>
 <20261015200903.2735565-15-smostafa@google.com>
 <au0XJPD81XkBgpyF@nvidia.com>
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
In-Reply-To: <au0XJPD81XkBgpyF@nvidia.com>

On Thu, Nov 05, 2026 at 03:54:12PM -0800, Nicolin Chen wrote:
> On Thu, Oct 15, 2026 at 08:08:45PM +0000, Mostafa Saleh wrote:
> > At boot, allocate a command queue per SMMU which is used as a shadow
> > by the hypervisor.
> > 
> > The command queue size is 64K which is more than enough, as the
> > hypervisor would consume all the entries per a command queue prod
> > write, which means it can handle up to 4096 at a time.
> > 
> > Then, the host command queue needs to be pinned in a shared state, so
> > it can't be donated to VMs, and avoid tricking the hypervisor into
> > accessing them. This is done each time the command queue is enabled,
> > and undone each time the command queue is disabled.
> > The hypervisor won't access the host command queue when it is disabled
> > from the host.
> > 
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> 
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> 
> With some nits:
> 
> > @@ -23,6 +25,15 @@ static size_t kvm_arm_smmu_cur;
> >  static void __init kvm_arm_smmu_array_free(void)
> >  {
> >  	int order;
> > +	int i;
> > +
> > +	for (i = 0 ; i < kvm_arm_smmu_cur ; ++i) {
> 
> s/ ;/;/g

Will do.

> 
> > @@ -158,6 +268,14 @@ static bool smmu_dabt_device(struct hyp_arm_smmu_v3_device *smmu,
> >  		break;
> >  	/* Passthrough the register access for bisectability, handled later */
> >  	case ARM_SMMU_CMDQ_BASE:
> > +		if (is_write) {
> > +			/* Not allowed by the architecture */
> > +			if (is_cmdq_enabled(smmu))
> > +				break;
> 
> Sashiko reported the same WARN_ON issue. You might want to confirm.
> 

I replied to sashiko about that, this is by design as I also mentioned
in patch #13.

> > @@ -170,9 +288,16 @@ static bool smmu_dabt_device(struct hyp_arm_smmu_v3_device *smmu,
> >  			break;
> >  
> >  		if (is_write) {
> > +			bool last_cmdq_en = is_cmdq_enabled(smmu);
> 
> Maybe cmdq_was_enabled (local) and cmdq_is_enabled (helper)

Sure.

Thanks,
Mostafa


> > 
> Nicolin
