Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97255B65E
	for <iommu@lists.linux.dev>; Wed, 22 May 2024 08:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716365239; cv=none; b=beBfEl7rEy+0OE8YYWpIAMri9e0v4tP3vkd0aNKDbkR93+IakFAzD4y6ygF/yuM1RA+olz1iYXGvtJUsEvOMlKInnuMq1npKIxy9hSxm4J+PwkvPRclFbGnQKlx9EHVZ9zjOFwDx2ztsUQtQjJ+uvth+NJ0gp0EmxEa1YAnHZLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716365239; c=relaxed/simple;
	bh=VrTo7xQk3wunpQg4mIDCXYkOoCzhSbxT4fGAOU8jY1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VGCqln9HW3XEwmHfZxVlGMTJUA2pUf+uVnC9Hq7zCTXhJEk5wqaivlDol7ucwkIpnmBt4nKjMUYGc6wvJ8gP1pALtuWfajr/f5yFI1DVo7fgLMToXeiwtk2KLJw1L+om/AHRTO8SfEyqubJaOWOlEmv0K5Izmgo/RB06LDCtL8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=TeM6JtLR; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="TeM6JtLR"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56e48d0a632so13217162a12.2
        for <iommu@lists.linux.dev>; Wed, 22 May 2024 01:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1716365236; x=1716970036; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EjJc7AAlreo5EdXOmmG11eZiUCAvljdqIc2K+uOGIsQ=;
        b=TeM6JtLRKLg50zZb5emLS0PA2+M1Ivk6fSAXLZmHKEsqLr9+Q1x30Qa4oIConLZlHl
         GbDmMOXMA4HA6dXcSMHm2gECIMnR3NqDTXl+JLMfREYHuxP/6RJWABUHRr7kmzpHJwEf
         Vi6oQecpNQXHEMHS8U3lqBrQB30+eiBXcGYSpJkM5BTOl5mt4NTHJNNqfjRfW4C535QE
         35m7j+I9+BVgHy+5YeOYsUyQW0YYNbxI2bGKsNkr1C5yd89Fi6QudNxZ2HUhDvRYjCcw
         iiodfH7sYCcDgq4MFZRKK8F1eV1GttW9oroqrbSlSaCa/hrJfWzce7IDIO3LQcpEgRsS
         zxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716365236; x=1716970036;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EjJc7AAlreo5EdXOmmG11eZiUCAvljdqIc2K+uOGIsQ=;
        b=mKUjyVYN7XKUYQJ+pTYwA73DedF+j6g9y9K5V7SB3T47wWOOcuepGxMy1AoO8vGmIv
         93IHd+8QLCpGiMx0G7bjtsLlnpWVFhXP2v8VqLVQh2bQLvmBIO4n4ZeWlJtefmuG3byw
         BWhdlqrcYGRLzUhOXishFJIVdEi5yX5hj14jGfA+JaxfcQr7DepHLpMa6c+vh0+aWNEF
         ZbaF6F+/1MXNoFq3SPwzDNSAP7LavbqvK+XnAHXdO4mKMcz7F0kOdrmfEjZ9+/wks9C0
         F8IjJnZMiV1vlzFuUG6hE/zjpS/U7rnIhxINcFA/oId4Za+T5HL+Ti4OR4+vUzx+E2Nj
         Ha7g==
X-Forwarded-Encrypted: i=1; AJvYcCXph0G94WHxsilbwuUp1JMmdm+qinYcpjCt6qXcoiK6iQxsoamS1A3d5x4mcuV77L/CaBaNit8s5VP8iQRDYy02Jou0sfc=
X-Gm-Message-State: AOJu0YwPyBEPgM+BZrkUzsh8uRO0dC+poroJaFc0oUcoZszegGwvRLoj
	WesoUD2dDUmMpjT2YvpNkgw+Au/q14/ovVJVOmtxEubSvECzhiLJ3pPvMucFRkY=
X-Google-Smtp-Source: AGHT+IFxkk46rQN7LJxAzq5cGNXR84hroJkBlxdzGPSkPpe2syhCs/1Mf1/sjeCOL+ArtyBeWNzrvw==
X-Received: by 2002:a50:ab4b:0:b0:574:ecc4:6b54 with SMTP id 4fb4d7f45d1cf-578329c7ca3mr1206147a12.9.1716365235959;
        Wed, 22 May 2024 01:07:15 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733c323887sm18071800a12.89.2024.05.22.01.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 01:07:15 -0700 (PDT)
Date: Wed, 22 May 2024 10:07:14 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Tomasz Jeznach <tjeznach@rivosinc.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Anup Patel <apatel@ventanamicro.com>, devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	Albert Ou <aou@eecs.berkeley.edu>, linux@rivosinc.com, linux-kernel@vger.kernel.org, 
	Rob Herring <robh+dt@kernel.org>, Sebastien Boeuf <seb@rivosinc.com>, iommu@lists.linux.dev, 
	Palmer Dabbelt <palmer@dabbelt.com>, Nick Kossifidis <mick@ics.forth.gr>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-riscv@lists.infradead.org, 
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v5 7/7] iommu/riscv: Paging domain support
Message-ID: <20240522-b25680db03b547123f1cd59a@orel>
References: <cover.1715708679.git.tjeznach@rivosinc.com>
 <1ddb50a47c86d384157a979a7475b45f807ba81e.1715708679.git.tjeznach@rivosinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ddb50a47c86d384157a979a7475b45f807ba81e.1715708679.git.tjeznach@rivosinc.com>

On Tue, May 14, 2024 at 11:16:19AM GMT, Tomasz Jeznach wrote:
...
> +static int riscv_iommu_bond_link(struct riscv_iommu_domain *domain,
> +				 struct device *dev)
> +{
> +	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
> +	struct riscv_iommu_bond *bond;
> +	struct list_head *bonds;
> +
> +	bond = kzalloc(sizeof(*bond), GFP_KERNEL);
> +	if (!bond)
> +		return -ENOMEM;
> +	bond->dev = dev;
> +
> +	/*
> +	 * List of devices attached to the domain is arranged based on
> +	 * managed IOMMU device.
> +	 */
> +
> +	spin_lock(&domain->lock);
> +	list_for_each_rcu(bonds, &domain->bonds)
> +		if (dev_to_iommu(list_entry(bonds, struct riscv_iommu_bond, list)->dev) == iommu)
> +			break;

We should wrap this list_for_each_rcu() in rcu_read_lock() and
rcu_read_unlock().

Thanks,
drew

> +	list_add_rcu(&bond->list, bonds);
> +	spin_unlock(&domain->lock);
> +
> +	/* Synchronize with riscv_iommu_iotlb_inval() sequence. See comment below. */
> +	smp_mb();
> +
> +	return 0;
> +}
