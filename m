Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050AD1A9FB7
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 13:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777383164; cv=none; b=c8AUNox1JO9JDihaZfbWObSvP3glPEkdK24uRuzj62pFcpqqR9XGBkanVwWzuc7Rfo5/J40Yl3rIZd0YG6bWSgFSlf5Gn+R8yjKOZ6kx2wRX/UFcCDHvLzPz6tazLHf8d2Jv+n1hs8MiwgtppbSOkHVzEOvy7Ja0SFBpF4k1H6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777383164; c=relaxed/simple;
	bh=OBtHITb7VyAfG65rc3vNJZbZRx2OGMc+kiXQarGPOUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SV6Y6ZXdAxlFr3YHFFdo1oy7Mtww2CXcvqEf5bPOJNeeZeq3sxJDhxZUUF6vpEFE1hYGOFF+JhvaiqmAPZLGCENmQ5a6kQNmwGiwc26c5JU0vPE+ho51+p1PZphL8wOKkjEFwnIk5FwV+gQsZ2+qt+Pv+/fl1vEKL/lk7O07PwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=I2EEvt3U; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="I2EEvt3U"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-682fce74c06so8832508eaf.3
        for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 06:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777383162; x=1777987962; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qPdjCZsKcHNqWuo5+pnokV+zhe1DyX7GyGi+9Un3LHM=;
        b=I2EEvt3UKA/UlSs9auNLK9S+IKGX5qPnv8rIOdIvoeMIK9L531reWE+L5YL+ajNqBM
         +/RpKnbynr7wmkw7NbXvLyIv7BVoyEwAOO38fWTUQjfdosDc6c30ifD/zgaksBKaAaX8
         3soMWUmSdsgRq2t3nGj6Ey5wBZ60TW/4Tk5uYjIapsn0uGGf/m6rwBTmSQTECwDsoTbu
         FHAFl4NYvJ7uCrXRSp+YHH1sL+ArlSBv/U5YkwrDddI62NHb6LtPJ/DHbROqJ68bVl2r
         VAtILiHXAZajqcL6wPzemSDQtK4HgMwtZnwuKwFxJeV1Jxjf/9opJCd6XHvkoIWuPbCT
         3XtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777383162; x=1777987962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPdjCZsKcHNqWuo5+pnokV+zhe1DyX7GyGi+9Un3LHM=;
        b=QRlokCrCyhTw4+1ba5LyqTDvBei/7W9UzLk0P0FIJee8Qak7VJTLhYvRIj9WFc/Z8l
         t2lYLAgpRytAuGwzWOYOfXvp6dekSqk3aRCAkeyv44x6Re5ETAoDBFPD6Fa34DokV9mZ
         cq+W/v8SFWTkpHKOvHe9gsA03UFRFJv2kDUgQ5x4/HCIaEF56CYvTFDxvupz7V/MLerC
         ME+pJmFD+DYrzXwRpacsKuLPJ6VKL8qKXE2FkDJwjLQmyrKlkBx/b+2zlDTdIjyBZ3Na
         k1uO14gAblg9RbsJRNxKK+tx6OZPufeOvlqmkvJcX1l7wpiJyxMRnkWAlv+BxHWXyBS5
         pcuw==
X-Forwarded-Encrypted: i=1; AFNElJ/hdiwizqZ3F6bGk/tk7dYlYLKwi/ewE6W0CsiaWaICeFl7QvMXh1cBG4W/tAQWfgJoMarl7Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxH2FEnLY3lPangWX/Qcc46C9vi2faViiXyMzGbOXXG6u9OdrzA
	fiCpPh4s/RW7CBxgTuIHob6h7vmUSpgwXto9M69x8SsKxvqATmXQvdKhNhDWK3lw3dc=
X-Gm-Gg: AeBDiev27xeR1EKbIzXRmLDguTct3E3WW7qYCiTWtZzKdFJFLFL9n6vgnhZnQOeS8zb
	MLQB+SBL+HGhXRL9C/dC8KDZpXbiFMZiTKVotp9R8uaA8ZWURvjX311YdCNQs5hQNw6DudoZ0kA
	ODFg6aa2HzUg64gihNIx76vkiVA0/RWXpS8xeAAZoiC7KT7J6KS0F9QoE1vpdYaV+VKrSUVCmOW
	Exjwy95tXif7A94QOeCw8fSWxK4vs4tYv+Mq5QStglP9s4ZyikbWvIE5WzaGvtR2NIFGZXKjdeB
	wdxt+qX+l0veFzLWWew+VbTEKLqCCshCtFj6/oLMtQ7wAjT2jbD9pJ7Ekz9YYrAmlNPUZWAFI42
	/l1lMSS0z3O85/1sEDUmyY/nTjPJJLKLH91zunXvA6YUhTMhrSgg3PMKdUKbyFf4wIqm2N9IWgr
	JDYzyfjAAcZ3XhhC2WsA+QI0GZQmVdbyf8GmJ6ponPIKTA5LndhhH+9vQUCwFqdWTif5Y0dxoGt
	7IKS6TJ4alEGjng
X-Received: by 2002:a05:6820:f008:b0:694:8683:3867 with SMTP id 006d021491bc7-6965cbbc6e8mr1334311eaf.46.1777383161926;
        Tue, 28 Apr 2026 06:32:41 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f7c48c71f3sm197040285a.7.2026.04.28.06.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 06:32:40 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wHiYJ-0000000AhcL-1zNy;
	Tue, 28 Apr 2026 10:32:39 -0300
Date: Tue, 28 Apr 2026 10:32:39 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: fangyu.yu@linux.alibaba.com
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	tjeznach@rivosinc.com, kevin.tian@intel.com,
	baolu.lu@linux.intel.com, vasant.hegde@amd.com, anup@brainfault.org,
	atish.patra@linux.dev, skhawaja@google.com, guoren@kernel.org,
	kvm@vger.kernel.org, iommu@lists.linux.dev,
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 01/11] iommupt: Add RISC-V Second-stage (iohgatp)
 page table support
Message-ID: <20260428133239.GC849557@ziepe.ca>
References: <20260428131359.34872-1-fangyu.yu@linux.alibaba.com>
 <20260428131359.34872-2-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428131359.34872-2-fangyu.yu@linux.alibaba.com>

On Tue, Apr 28, 2026 at 09:13:49PM +0800, fangyu.yu@linux.alibaba.com wrote:
> @@ -263,6 +281,22 @@ riscvpt_iommu_fmt_init(struct pt_iommu_riscv_64 *iommu_table,
>  	case 57:
>  		pt_top_set_level(&table->common, 4);
>  		break;
> +	/*
> +	 * Second-stage (iohgatp): Sv39x4 / Sv48x4 / Sv57x4.
> +	 * The top level is the same as for the first-stage counterpart.
> +	 */
> +	case 41:
> +		pt_top_set_level(&table->common, 2);
> +		table->second_stage = true;
> +		break;

Second stage needs to be an explicit PT_FEAT not implicitly deduced
based on the vasz.

Jason
