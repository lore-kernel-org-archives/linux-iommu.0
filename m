Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050AB3D78
	for <iommu@lists.linux.dev>; Fri, 18 Nov 2022 14:34:50 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id g2so5857525wrv.6
        for <iommu@lists.linux.dev>; Fri, 18 Nov 2022 06:34:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4toaSer+DSC9C7UHmt6s1A3ErWAKiU/7f6LW1Uo6bg=;
        b=qpjHqeUcStDQX0Fqzw8bcCpEwUjm3PcKxqaQmVyG9BQ+sNcVV5jhEn6g7rpjlB+Cxk
         /5aGI+esbWrvwOD6hURp2Fc+T0ElBJPnPGoq4w77N1Is9kaz22jb4gQS9ykS1GKUmG2K
         emozNBfaUzpaLQ0JL3/1lFPxgHx7F5vAy8LFKQRVGLKCOhqvnQVhzid43iInnyRWCxRZ
         Gq/5cuICCpF1MUawSrPs48eMFiqSbKbri0PwwM3NwZDPPD/II7wqEEISJ8o1vofIZpG/
         K7y483EsZzJa+95wg5nuBDw+NhrfrQ3j5vWkyFZLw0KuDfXaNe0w0sSrRhgWXYB35UpG
         ZX0A==
X-Gm-Message-State: ANoB5pm3K9E1zecTiU0tk0VGWXCyVwGJH4va5ibH166+TMeYoVHKigtx
	vs02ipaLZKsvOTRu7qrrWKY=
X-Google-Smtp-Source: AA0mqf6xd23CergG26RTQ00+DtiYnR2z8QS9+b0CEY7p5WOlXzZ5D8aEBANGloY2SpHuGJKMYI7aXg==
X-Received: by 2002:a5d:56d0:0:b0:236:59ab:cf30 with SMTP id m16-20020a5d56d0000000b0023659abcf30mr4403560wrw.485.1668782089167;
        Fri, 18 Nov 2022 06:34:49 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id j18-20020a05600c191200b003c83465ccbfsm10372760wmq.35.2022.11.18.06.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 06:34:48 -0800 (PST)
Date: Fri, 18 Nov 2022 14:34:40 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, mikelley@microsoft.com,
	sunilmut@microsoft.com, wei.liu@kernel.org, kys@microsoft.com,
	Tianyu.Lan@microsoft.com, haiyangz@microsoft.com,
	decui@microsoft.com, dwmw2@infradead.org, joro@8bytes.org,
	will@kernel.org
Subject: Re: [PATCH v2] iommu/hyper-v: Allow hyperv irq remapping without
 x2apic
Message-ID: <Y3eYAFDKhwsOyeY7@liuwe-devbox-debian-v2>
References: <1668715899-8971-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1668715899-8971-1-git-send-email-nunodasneves@linux.microsoft.com>

On Thu, Nov 17, 2022 at 12:11:39PM -0800, Nuno Das Neves wrote:
> If x2apic is not available, hyperv-iommu skips remapping
> irqs. This breaks root partition which always needs irqs
> remapped.
> 
> Fix this by allowing irq remapping regardless of x2apic,
> and change hyperv_enable_irq_remapping() to return
> IRQ_REMAP_XAPIC_MODE in case x2apic is missing.
> 
> Tested with root and non-root hyperv partitions.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

Applied to hyperv-next. Thanks.
