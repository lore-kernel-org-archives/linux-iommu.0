Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EFF17C203
	for <iommu@lists.linux.dev>; Tue, 11 Jun 2024 12:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718107944; cv=none; b=YPfjRpKSeuBPfhNTek2R709XXOgfgSoHSjvrTZfu9bb4uwWnzKHDNfulsD2KWhHosfLFEhg9HcWhRMTvQ4UbrU5ui8hAD3N+hp93PIFXZD1PM67WRecSNycC20WPE3jWJNo7wPpwGbOeiwseb9QZCPw7M6NhW43csJy8lSA2wqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718107944; c=relaxed/simple;
	bh=sIbNJUSxjDR6r4OKpjG9oJgb7z911EUrOwt9KL6BXgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lOoaIstEqXHkZiZGFuOTsn6DH5rEf74QTOHylMnuLw0FJikJhXf6O1TQj3VB3bm9dt0HqhHbjHbM8Iw7mhZGglBf2e4ky9Dm19NK9ROb8VCFqE4EGJoidrpAhJyq1KACbyXiPXY5M28ZRAc02U4SRWUigUCSUV988hYeHmr9rMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Rz/JynkX; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Rz/JynkX"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-795524bb6d9so62036485a.0
        for <iommu@lists.linux.dev>; Tue, 11 Jun 2024 05:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718107941; x=1718712741; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sIbNJUSxjDR6r4OKpjG9oJgb7z911EUrOwt9KL6BXgo=;
        b=Rz/JynkXwjZozzIcZengZSFO44zXv3AfiLuHIgII5jbuDIUPKyFK+d5+mNo90d1ztn
         OkCEDEUlWKmlWjy8qbKIvm2g+PZS6NPTLxAdYrCh+EI/4V+BPRYkNQXXNgFQd6enz0Oo
         b3aFGW7zU5Sk73ifWcu5Wcayi17TxYl4KGaiu+eLlAJ31N68TsK3PVmwQlkHZ3yHu5S6
         27HK/RhYvYeOtXUOZLhd56VJoNqyGVQej4fM2O+/+NEGKwPg23isF2k7hfF87YZfdYFZ
         TZEszkq8ltrqmdQRt4WztUidCYt2jLFr94GtPhAheGjIEqbAFzRfqg3dYTc6Ny0QIGq2
         Cp7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718107941; x=1718712741;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sIbNJUSxjDR6r4OKpjG9oJgb7z911EUrOwt9KL6BXgo=;
        b=GAuyHPvC+6E4xwP/PnQrN7VKMjFj4rgkn3/qC+lZq0Mm4z9JFG8ipLfWfZtTw0MFW7
         udQ0axXw2oLQSVkO0ed4luGIxq1IKl0LrCiICXml6QNYTkQk9ZdQR7UxfHLrihlX4ROC
         IsvKTnCH/Dkh8lYySkvjAocfEgIyoTsdXMjvR7I0TfXMmL5+hHoZT+6wn9Q9ayWP3VuJ
         DH2492l2YiRiN7KAyP+tKThkHD15fxkTgOPQ3c7dPeiz7RxpIEY7vy8E1iP0MczxoMQ7
         ChNwFj9doVvAasNqIim636gQ/YU31XfYe7vsWzOVQ7e/pGQJWwH/h9E0MUb6jOK1rbHN
         fgCA==
X-Forwarded-Encrypted: i=1; AJvYcCWNkTStWJ73BE+Icd6ZTqC6W3Zk7/vwIrHOOkceskZQLx3GMMkxBVTWrCmk/fFP7A/V+6QTHJjhYUHgZD+L4q0aIIu8OUQ=
X-Gm-Message-State: AOJu0YyYlYywHS7B37jWtosb1n7CfL/C0GEX1tGb6GOsKcVADeT7rL6K
	X78b7kC8dyW7dgQzZpljkoOI56rxyTTjkxQ2oodVodEv2i5sSEgy0tSkt03tbhY=
X-Google-Smtp-Source: AGHT+IGrA5stCDnRo1H5n9Y5w5ElO81oVmgd60ewDFQ3Fm5sCDbN4V5n/Tt2xc1pS6BW64I2SfmIhA==
X-Received: by 2002:a05:620a:24cb:b0:795:4cde:3b1c with SMTP id af79cd13be357-7954cde3cf7mr1271288985a.6.1718107941369;
        Tue, 11 Jun 2024 05:12:21 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.89])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79556b3ac83sm292416485a.127.2024.06.11.05.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 05:12:20 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sH0MN-001OhE-1j;
	Tue, 11 Jun 2024 09:12:19 -0300
Date: Tue, 11 Jun 2024 09:12:19 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tomasz Jeznach <tjeznach@rivosinc.com>
Cc: Zong Li <zong.li@sifive.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Anup Patel <apatel@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Nick Kossifidis <mick@ics.forth.gr>,
	Sebastien Boeuf <seb@rivosinc.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux@rivosinc.com,
	Lu Baolu <baolu.lu@linux.intel.com>, Jim Shu <jim.shu@sifive.com>,
	Vincent Chen <vincent.chen@sifive.com>
Subject: Re: [PATCH v6 5/7] iommu/riscv: Device directory management.
Message-ID: <20240611121219.GP791043@ziepe.ca>
References: <cover.1716578450.git.tjeznach@rivosinc.com>
 <e18ec8ac169ae7f76e9044c26d0768e6469bad19.1716578450.git.tjeznach@rivosinc.com>
 <CANXhq0p4gERQeROSCSKqxnRZq9-fGfmROGV8JZyqFaenNpnsLA@mail.gmail.com>
 <20240610174934.GM791043@ziepe.ca>
 <CAH2o1u4c6ttUWTb1zrc8DScDMuDJJYR-tTHCPYW_3FV4uuQDtA@mail.gmail.com>
 <20240610222051.GO791043@ziepe.ca>
 <CAH2o1u7X2zu42ZYA9wBe4bmCXN9v+d6j9vo5DMifJA3BUew91w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2o1u7X2zu42ZYA9wBe4bmCXN9v+d6j9vo5DMifJA3BUew91w@mail.gmail.com>

On Mon, Jun 10, 2024 at 07:00:34PM -0700, Tomasz Jeznach wrote:

> For now, I'll change the implementation to assume negative caching for
> DDTE and will follow up with device tree / driver updates to make the
> invalidation optional when revised specifications will be available.

Is there a reason to make it optional? It seems like it doesn't have
any performance downside to just always invalidate, attachment is not
a critical path operation.

I could see making something like negative PTE invalidation optional
as that is more performance path..

Jason
