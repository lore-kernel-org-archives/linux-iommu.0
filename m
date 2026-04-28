Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364D83FFAB1
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 11:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777374887; cv=none; b=RmVMe1PUiPuBZ5zUWF8Lrutmi1HjXkIG9GKe/pfGOgsaGzhtu+E4ORsRPsVnlsKEPfSHOtx7W6LwoZO7GwPJCeUyVOkQqbzypOSFggln/Ey/7zd2Icax47ey58Htra6PSwe1TH9bTdAdqUNvL9Rshj3vS4NwLJAOinQtnuy9ST0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777374887; c=relaxed/simple;
	bh=At6e2CpAmm5a9XNTq0g2yX6hJZmmR9qgwx0nHOjAgBc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=famu/0DUMmYHuCgddgQ8V6MgWtAqWTKJ31Q6rXhxoVGV1ow53L9o9jyOwL6jkjFmLXc5OQASqTcFD6jIEF8KqjQBcG9dnD7lMWBtwhWpMQYgeY0sFCE/3nIOjnF/SgwFfGTqH5huWT/eiZLqIm5yq5FDe71TSKZz5WqUYFWutvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gJqNDgo8; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gJqNDgo8"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35da4795b3cso21882631a91.2
        for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 04:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777374884; x=1777979684; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bcF6L+ouo2phzgrYxWXEm0FomSct1ef1g+27VqW0usM=;
        b=gJqNDgo84SwOHUoG7Oag4+jdlBR070cwbE8BLRW+QUJN+YzSobMBWAWFl3E5tVioTY
         Q5UFOgN+45xHnHd2aoGCRjF3XeDxM/6Geb76qraQOlpnNr1XH8TH69oFdb2YuWl9svqj
         WBvjuOmI3VUQK5d5BOJD0R8skS2tyyDDZZ/7TiQSYJ3qSYgbMoSHlI5TFmAD3dAnPI5f
         IPkeZW49h0cn6k3YhXAy3edYndA0wt2dBgjkr13/Nsnj3tVaj70ovnqm+DxXTz07BgH0
         lbhX1GZWELiggw2heYJGw8hX1tlNxOgJWAQCNJx3KAk8IZ33b0ht9xBbrHs/ATODyr9Q
         vl+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777374884; x=1777979684;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bcF6L+ouo2phzgrYxWXEm0FomSct1ef1g+27VqW0usM=;
        b=oOFa7gs17sAUfta5wXsHZ5NZdoz0YYMp1kip+0fFnV8E7ct7sErE6GdibY3l+c0Eoe
         MntJW2Oi4mybyq9+fKKYKodRcG6VyeUpo5xO06UvQgghliF57SkOoOW1UtCjElWBUb++
         A9nmJgKU148dgCKPNPpKaMU3AjaodJSzGUZ4flz57HxLb0iXghn61RsKT3IBup1AQVl+
         fB0L8ib6Od0PJzkaYkPiLsQj1qrKFr13c+fUKsiSjlTPxJIvfEx6mHZxnGfCJmnoP7qO
         VGMLSYCllSba3SoE04WSQ3neZu9zCL4rAFuyqL4BvCenj/Gi3+91x68g11Qi68Z4ZKv1
         ZBYw==
X-Forwarded-Encrypted: i=1; AFNElJ+9dBPRfDdlGoPoMcA6Mmnr2P9tO6AgHQdvxvKAJkdlUDsv3/d3pWkQFOaxFMwZEiN+YAy4OQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwAJaMynZQu+IWMKUmFBVBRN+Eem6Uhdxo2yX9PkNAvroNaR2Pu
	1wZ7GO1s6+40kCy6Gp4f/xiJr1LA6fvSrKSe/fWTrzc2bRDUOcWcRAZ0QWTdDjTkJU3GrlHpDiT
	Ep3oZmWISUAkgLS3NglvVawVzew==
X-Received: from pgje5.prod.google.com ([2002:a63:d945:0:b0:c7d:a430:c5f])
 (user=joonwonkang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1b10:b0:35f:b6d3:da7a with SMTP id 98e67ed59e1d1-364920a55f4mr2779149a91.15.1777374884382;
 Tue, 28 Apr 2026 04:14:44 -0700 (PDT)
Date: Tue, 28 Apr 2026 11:14:42 +0000
In-Reply-To: <20260428090522.GA3048463@myrica>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260428090522.GA3048463@myrica>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428111442.1584248-1-joonwonkang@google.com>
Subject: Re: [QUESTION] Is the ARM SMMU v3 implementation designed to always
 ignore SSID when SSID_VALID == 0?
From: Joonwon Kang <joonwonkang@google.com>
To: jpb@kernel.org
Cc: baolu.lu@linux.intel.com, cychu@google.com, hhchung@google.com, 
	iommu@lists.linux.dev, jgg@ziepe.ca, joonwonkang@google.com, joro@8bytes.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	robin.murphy@arm.com, stimim@google.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"

Thanks for your prompt and insightful answer!

> Hi,
> 
> On Tue, Apr 28, 2026 at 07:38:59AM +0000, Joonwon Kang wrote:
> > Hi team,
> > 
> > According to the ARM SMMU v3 spec, I believe that SSID should always be
> > ignored when SSID_VALID == 0 and the current ARM SMMU v3 module
> > implementation in the kernel seems to comply with this without exception.
> > For example, when handling an event from SMMU, the implementation checks
> > SSID_VALID(SSV) first and ignores SSID accordingly. If there is any
> > exception to this rule, I believe it is a bug.
> 
> Indeed

Acknowledged.

> 
> > Is it true for all the current and future cases? In other words, is it
> > **mandatory** that the ARM SMMU v3 implementation ignores SSID when
> > SSID_VALID == 0? or there might be some cases where the implementation
> > needs to refer to SSID even when SSID_VALID == 0?
> > 
> > Asking this question since our HW may not be able to clear SSID when
> > SSID_VALID == 0 and so there might be some garbage value in SSID at some
> > point of time(the HW will have a correct SSID when SSID_VALID == 1,
> > though). If the ARM SMMU v3 implementation is to refer to that garbage
> > value for any reason, the result would be devastating.
> 
> At least according to the architecture, SubstreamID is ignored when SSV=0.
> The SMMU is allowed to propagate the garbage:
> 
>   7.3 Event record
> 
>   * SSV: The SubstreamID validity flag
>     - 0: No SubstreamID was provided with the transaction and the SubstreamID field is UNKNOWN.
> 
> But the driver will ignore it.
> 
> Same for PRI queue but in that case the page request wouldn't have a PASID
> TLP prefix.

Although the PRI request without PASID may cause unpleasant ATC flush with
SSV clear in this case, it does not lead to the implementation referring
to the garbage SSID. Is this understanding correct? And while this case
seems to be handled solely by the ARM SMMU v3 implementation, do you see
if there is additional care required on our device driver for this?

Thanks,
Joonwon Kang
