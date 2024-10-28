Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8717F12F585
	for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 15:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730129753; cv=none; b=qGdYkwpk8e5eC6HyC5HK/V0WfK1SIgNhFKo56HKLjCkyx9PHVFVgSlJn70BA2dcv7KrjSZwly0ft/jL8OeI5ceHWBqbtBvYyz7QeeteFlwtMVLwkak4+ubbvnD5K4mZu8ti8qSt0oAJxslZK9x36woSBaKYyrB/sqoXwzjm/2Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730129753; c=relaxed/simple;
	bh=LRtDnABo0aF6rbP17c/1SA+tl2/kEVb41QtjDfW55iI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bu8tVbgyZXR2m+6F9XYyInag66kkwQTAj41LZ3dYTEFxfNO9zInom78eriL4pxSMs0LMYinSoUDxWUS7ffdCN0Eo7tgH0H3TfwWi7a/uFaj3GUjr/4cTRKCEWPnimHqwfPbUz0bS9KAH7Rc1V9s8eY/J0c0GxvDFY5VcWpn18zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=TZxn1YAd; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="TZxn1YAd"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-460ace055d8so31974231cf.1
        for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 08:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1730129750; x=1730734550; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EE7vSxeEYstH30s2qRIeSezPCDUxcS7HFE/EjwufDuc=;
        b=TZxn1YAdVJCrKGY93YENDvmjW37DTOIdwl7sN8M35Y3BOR6Ko7sg2FuU+5S4ClCAJi
         3w2WNlmTKl11tcgN6WAjucnD8RvBH/XYJL4Mu1Y7XqKKSCalr4pooW1N6aVpIph8V0E6
         VzfJs2lqlzrIKvGZGJhrlWvKGzKlYTIgUijSnBP5OIJTLPmGUREUixHBoJWcuDny0yqx
         Gmm8qxBwnBDhxscOErVAe++2ebYs6T09QJIv1ZptwUi2Wr3R7a9Bksz2uUFcGhyBNJ06
         4sQcuIOLghac+Ok/gXJfp0n3TRv3xGgo1dIVfg6Vf2E1LQw5fGD+eeAgvljY6p4Q9AKf
         Xbvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730129750; x=1730734550;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EE7vSxeEYstH30s2qRIeSezPCDUxcS7HFE/EjwufDuc=;
        b=xDNBbyRBppb0vzSX/H4FzsWilgHYKkEID4QtVs6zgMTP+RnepP2SqKq9AGHbcH9fb6
         lvtu7/Y1c2qOBZHQvBP3QaeBca+tkk2UV871eAru03BxJZcz5OVBWOvLa2ObHwQ+68AY
         VyQ91eSpF5nPg6aklo3peUncgITo/gkf0fyOagyCGxgWRB1av9aCc65X+rPdbj95Qd8A
         oWLmLhHwEgKUWYi6Tko2wHiKQw9BRGxomeGU4la2f788dEgBiBccCI0SQWCK7TMBBiGx
         1d4YdecDCNmT3ysrfEdtVagJ6nP3Mg3b7msIqBlEPpVEd62G79cAG+CsIm4UjVXxVMrF
         hkNQ==
X-Gm-Message-State: AOJu0Yz+BYBFwTBay1eEKKtTWPcAvnLPwNyvlaMjD/PnhnbzTChavMjS
	qH4LVIQG9StCRn6TkcpAyyRR9lLRh7Wr8hkNDCdQszQOJGeuVayswXfEG92PoME=
X-Google-Smtp-Source: AGHT+IG1IMNLx5zl7VjgNyXu/KpG2AsiaYgjEHcVyzIjKjudAssWv5m2XAxqEWZBnAfnZ828Ne7dtA==
X-Received: by 2002:a05:622a:1a9e:b0:460:e643:d279 with SMTP id d75a77b69052e-4613c184d40mr125579171cf.45.1730129750418;
        Mon, 28 Oct 2024 08:35:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4613228efd9sm35508101cf.51.2024.10.28.08.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 08:35:49 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1t5RmW-00000000QqM-1OTp;
	Mon, 28 Oct 2024 12:35:48 -0300
Date: Mon, 28 Oct 2024 12:35:48 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH v4 11/12] iommu/amd: Add opa->release_domain
Message-ID: <20241028153548.GF20281@ziepe.ca>
References: <20241028113148.5774-1-vasant.hegde@amd.com>
 <20241028113148.5774-12-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028113148.5774-12-vasant.hegde@amd.com>

On Mon, Oct 28, 2024 at 11:31:47AM +0000, Vasant Hegde wrote:
> In release path, remove device from existing domain and attach it to
> blocked domain. So that all DMAs from device is blocked.
> 
> Note that soon blocked_domain will support other ops like
> set_dev_pasid() but release_domain supports only attach_dev ops.
> Hence added separate 'release_domain' variable.

You don't need two domains, so long as attach_dev does the right thing
the other ops can be set too.

Otherwise

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
