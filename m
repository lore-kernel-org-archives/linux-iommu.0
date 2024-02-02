Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1908B81736
	for <iommu@lists.linux.dev>; Fri,  2 Feb 2024 19:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706901314; cv=none; b=f/7JsvaY+nq4yZxfEMxYC6mq/m3DBu4wNL1sF6RzrpaM8TYhgnBPepDeHJL+wfoRcDgUPPq6zDR6zgCOv2uJfr9AWDRw3NrxZ/KK0XDu95meWKlIr4vQJa78lbUHNP3UWWOQ5JNkgWMclTF5EUZgvxKeofi1PDxigLvqXCR2MnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706901314; c=relaxed/simple;
	bh=Qkg5eFUSCl733X8fpmEZ2SfBmPh8Cs0pCAFSoIGM7XM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u8pEQTpMAamtcPY9wpnvchvcM7m+ccePN95k88nKK1E/GftMC5jGY0hGDCEWLWZGjhnbuHzzBtXY4BQscDZOHCqLie2xCykWAfR/PF5lmfWdneLM6Izy2Tl+3NjHuz9EawUrQgpy6A7P0xeGt2UHkRyCXXSnv1y6w2FiULN0Z6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com; spf=none smtp.mailfrom=soleen.com; dkim=fail (0-bit key) header.d=soleen.com header.i=@soleen.com header.b=Cr5Yyc5W reason="key not found in DNS"; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=soleen.com header.i=@soleen.com header.b="Cr5Yyc5W"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-42a99202ae0so6969441cf.1
        for <iommu@lists.linux.dev>; Fri, 02 Feb 2024 11:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1706901312; x=1707506112; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Qkg5eFUSCl733X8fpmEZ2SfBmPh8Cs0pCAFSoIGM7XM=;
        b=Cr5Yyc5WXlku2gdYz4iMfma1F7rbCw9q7ZsV0m6arpmuFwWbZC1yqZjTW4dDzvA18X
         2iYBpgMlKioByvSyNKnQ2KEYH3d8WnQx/DESywcNzKgOA0r6OpXtJQSWPkwRjWgd7EWM
         n0mAhEeTX0lXjvwbKq4OcgtQso5R8D/3HV0r0D4hQahkhZqhuDRRIHf+d5CbeoDUw5y/
         R3U5Q7E9p8PE8PzyD2EbwXEIYjgMUCTJkIz0iZNc6OKltj0VB1+41zEu13rRgnRrtf5D
         svOPX6BnWutkLysILVfjSgWOXSmhIR1aIqbkmU7trG7bcqvjJlAuhXySePhD3wv1/OEc
         ZEmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706901312; x=1707506112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qkg5eFUSCl733X8fpmEZ2SfBmPh8Cs0pCAFSoIGM7XM=;
        b=GdWftXB67iUckpY10XlJmgZUl0milkw3Wz7Ir/U15r3IsMBipbVko+kzoZDDsxOuUG
         hek/F+n4wOMWAZDkNFLgidu2CrZwiXfEoylhMeDVJsAmR97mypdXlZrixrkN5y3KRvzC
         MkY9ZMItRUAfpA7ww7zd/1Q/W0zq2zJRLJctUJOkCnzpWNacOYFrihWUku7AVURytmms
         EpGS5IW2t9LiT6ovFbNDK16uRA0Pu0SL5cOjtvYNaUqsLQsOBTHqUTohPoZjL3iUNils
         FHKD5M/gCcNP/lLHVeT6jnSOj1iZakvTv59gyAIe8D5iGMUFi+RWjPV6Yvj4V6oR4V6i
         cxIA==
X-Gm-Message-State: AOJu0YxJkJ5DywPEu130/3KIaoxd9HZHTCS+Du+nbf6PbILFhZJYEq/T
	7OlUqxhmByUPJ3QfAqthdTWeitu05jnKEoU71j1va621i5c9m+dhU1i+6y34U7DiqiExYIXpYux
	K0jbIfzKk4nLWEqvq++PDcUIPMUO1uGrlmtpGAi5+fk80hC31
X-Google-Smtp-Source: AGHT+IGRYLsM+jFPG/+OQ6YbfxNeymzH6TMB4pT268OsL/EM4HwUGWuXnrdcfT7i3XzApUte4yWs+G5NVXUrdrCl+P4=
X-Received: by 2002:a05:622a:ce:b0:42a:9d1f:d0e5 with SMTP id
 p14-20020a05622a00ce00b0042a9d1fd0e5mr123854qtw.11.1706901312011; Fri, 02 Feb
 2024 11:15:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240201193014.2785570-1-tatashin@google.com> <02610629-05ef-4956-a122-36b6ac98fbc2@arm.com>
 <CA+CK2bD_q3pnThtLVSzFCjyevBEaG6Ad+1o2=1tVZsYg35UMmg@mail.gmail.com>
 <84c7e816-f749-48d8-a429-8b0ef799cdbb@arm.com> <CA+CK2bCFbeRHT172KUci5+8WJNUeo-2A1M=UXsSqqOy64w1LJw@mail.gmail.com>
 <bcddef81-3979-4ad0-b3f6-771871a44433@arm.com>
In-Reply-To: <bcddef81-3979-4ad0-b3f6-771871a44433@arm.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 2 Feb 2024 14:14:35 -0500
Message-ID: <CA+CK2bD=h+rp4M8+vf3pjzrGAw3QE_LjxK0c-8YCNT=D+wYknQ@mail.gmail.com>
Subject: Re: [PATCH] iommu/iova: use named kmem_cache for iova magazines
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, rientjes@google.com
Content-Type: text/plain; charset="UTF-8"

> Yikes, so it really does just have that many IOMMU groups? OK, fair
> enough, call me convinced :)
>
> On balance though, I think I'd prefer to just stick the lifecycle
> management into iova_cache_{get,put} for simplicity - spending ~256
> bytes on another kmem_cache we might not use can hardly be significantly
> more than the extra code and static data necessary to track its usage
> separately anyway.

Sure, I will send a v2 soon.

Pasha
