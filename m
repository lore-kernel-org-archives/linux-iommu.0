Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A97A8498
	for <iommu@lists.linux.dev>; Mon, 14 Nov 2022 23:24:00 +0000 (UTC)
Received: by mail-pg1-f169.google.com with SMTP id f3so5212237pgc.2
        for <iommu@lists.linux.dev>; Mon, 14 Nov 2022 15:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RwlygzCsN4JvBoBc5PT51nu/YPQWPnTm3fC10wkiQwI=;
        b=H/ssuI5Y03wS7QHyYAaQtvdvQLPAK4QsHc+sowRfzw7LbSXrrIuDGSMKFuT6SOy1Ha
         v1XDE9LyvBn0mtjjmniPJOxDCSuhjThvx09UEDEEikoyk9Nj5a41dfuBLMwpjLfLk2mL
         N5qmyTI1mFVFPVv4D9D1zVHc0Y80p4OetFtZvPOJ6Zd4VDhyH0W1g/yrmUWVFhSaucFA
         bXg7zhw0nc5VNiPSY8plbleLneOYe4zUKyahtbGp/Jrk0iZ3qaSo7+W+lrMERR1B3ozw
         NyMfDdBHMAk6MMrCB2Rykpe3dlbjg/oL2Kso8AwUZuu+veXgSt4axC5Kfd7QToGOLWUB
         EXUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwlygzCsN4JvBoBc5PT51nu/YPQWPnTm3fC10wkiQwI=;
        b=H8XCGqlZ8kUkg3JbB5lXEqAeitTFm/NyA+oGSQJUBqltvpAz/HLuJQsbgp7Woi7xm5
         lsJS05n1tW0oRcNSB+MXGNhFzrKHkUR3OAH2CJcv65AP8RXmMNujrarybnjBSMFx0WgS
         UU4nW0Qv2dcx6WPSWg8B+4EQ3Qy7QjVT92mM24v1g1vxLLJYgdC1afUo45BSOz/Uq6tP
         U1jk3+5cLuQGMc0STIOPMOLAL0yoY0Ik0DVYAkSBXp83MzyS+XhjSpCEAeMRQkztlkML
         XWmREbQSkrCPi6ygpY/PhOB8BB7SxkhKR21YGkTSjKONE1TOxr9HMiJ0RvqNeksZvKIr
         4q2Q==
X-Gm-Message-State: ANoB5pl0KitxsqCEdoVqyljcEt47/z2TAKhM7ESinpdaMfdTUegpQOWY
	XCHAuy4TtOnbpv7fFiMRdWWMcA==
X-Google-Smtp-Source: AA0mqf6OeX4uF0N4ZAtEAWAWpkt1j2fd0oy7Bdye+9vXo14vwKDQcG8kuYKNlmHV8hItYawmG29FXA==
X-Received: by 2002:aa7:8f37:0:b0:56c:cde:1a49 with SMTP id y23-20020aa78f37000000b0056c0cde1a49mr16109986pfr.9.1668468239853;
        Mon, 14 Nov 2022 15:23:59 -0800 (PST)
Received: from google.com ([2620:15c:2d:3:1010:f556:6834:d91b])
        by smtp.gmail.com with ESMTPSA id f1-20020a170902ab8100b00174c1855cd9sm8019458plr.267.2022.11.14.15.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 15:23:59 -0800 (PST)
Date: Mon, 14 Nov 2022 15:23:54 -0800
From: Isaac Manjarres <isaacmanjarres@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Ard Biesheuvel <ardb@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Alasdair Kergon <agk@redhat.com>, Daniel Vetter <daniel@ffwll.ch>,
	Joerg Roedel <joro@8bytes.org>, Mark Brown <broonie@kernel.org>,
	Mike Snitzer <snitzer@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, linux-mm@kvack.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 03/13] iommu/dma: Force bouncing of the size is not
 cacheline-aligned
Message-ID: <Y3LOCg9FEuFxny0B@google.com>
References: <20221106220143.2129263-1-catalin.marinas@arm.com>
 <20221106220143.2129263-4-catalin.marinas@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221106220143.2129263-4-catalin.marinas@arm.com>

On Sun, Nov 06, 2022 at 10:01:33PM +0000, Catalin Marinas wrote:
> @@ -1202,7 +1203,10 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>  			goto out;
>  	}
>  
> -	if (dev_use_swiotlb(dev))
> +	if (dma_sg_kmalloc_needs_bounce(dev, sg, nents, dir))
> +		sg_dma_mark_bounced(sg);
> +
> +	if (dev_use_swiotlb(dev) || sg_is_dma_bounced(sg))
>  		return iommu_dma_map_sg_swiotlb(dev, sg, nents, dir, attrs);

Shouldn't you add a similar check in the iommu_dma_unmap_sg() path to
free any SWIOTLB memory that may have been allocated to bounce a scatter gather
list?
