Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D9733B6CB
	for <iommu@lists.linux.dev>; Thu, 13 Aug 2026 12:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786623173; cv=none; b=qkptrHYnLSHYzacMypqcfSXrieq/0sKIdnDV8Ozmy4Zhebjrx5spRiuHNIn1FSSudBMiHpMc6UL9j09L+aN9nh6mj5BG/fC49YzYkEaNFWG7UmdB1aJoA94sYODWJTeAiBLoHcv5fyUdCro6aYxXX14FMFtj90wHvKxd4ijdbkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786623173; c=relaxed/simple;
	bh=J71Nb7FwK/y4ZvkNO63vb0baaS/Nh9iJZnBAhcYjO6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XpsNS7Bv2fW+ODpVqAOAG3o4I+16RogBtvLGOAKbM55Ms6gnEJGrxiXuwtN9GBsym9WIyN+6PFkTF6RPg+M8qpi4CFb76fJWHJiG6vk5WA/Ci4Rteq8ceV07VIOd2/C2odfjB+Rhsg+3yP48wgOAiYyif1pveSnErMuWoypSmrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=hWG/mO/J; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hWG/mO/J"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-90a6b298889so4890506d6.3
        for <iommu@lists.linux.dev>; Thu, 13 Aug 2026 05:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786623170; x=1787227970; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JzqQMoNbaC6wNrYu6a+WqecNk64VsZCRB0iu7uKoI3Q=;
        b=hWG/mO/JysZbDW1NWmp5gNlCh24riHbFVgj+J6tq1sm6LjkJISfiMCbQRioMEW0Juy
         mF7qmILGZP+bLcvW2RYxV8+CSd/TXphUL2r01wI40kHktaghqbq/MbMZUW9v8YVy6ccC
         7As3v7JFTXXWL1tFNMemW8v5yvN7bTYgMhXiqJzdYbkAp7rXswLI7XPm50ZonfmmgJxh
         yJJudpobc+loaG0kmSA4hEk5zFQfUiPPdjba2jVufN3jg03EBU1imkXYkC9I6o9n2Im7
         m47hGdJNipBffKAqZnA60WDQuXflEXsj5UTEakAVNkAU7QbRdkuzO3Bj6GC7WKFk1z6f
         AutQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786623170; x=1787227970;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JzqQMoNbaC6wNrYu6a+WqecNk64VsZCRB0iu7uKoI3Q=;
        b=cuuLWVbb90RULRYYdo74LZDhYnBM65QbUFVGXCk/1AImLzO5QDL9Z2NcbGcHv5eFMB
         2xB61RtIoNfRs0f4uuWXDpM8CtHNl7jxzKROHD8EfYpfGEV7+wV9VRJH8VBNDFesRpqN
         IEiWhuhCO66L401usi+qQ0aNCG5SZideLLRd3uUy7SeqXXeyH8jAggIBLiduy/C55YpO
         Zzeasm8HHMfrWl8AUrqyoDnG62fS1r1vEJ8j9Hgfwv69tZha826ndrrJngHGCSEDQvQ8
         YS6sAXIa89dh2/hhTNkzVNS4BgvuWCY5iv1wSmxtig1Cnpi2GQ8g5byMgFUBCbe1FqJB
         A69g==
X-Forwarded-Encrypted: i=1; AHgh+RqXnRdDwiMsky9SyRvP5hXqYNaTvoxHIVQggbF0+iIsn+oKzCfpKWZMYO5oAcT0K3y8Rg64oA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxqcrwltYRxwvjoRAvCF3Ewl7r1uGbn1BUx42rpEIWlxcSQSM4u
	L0oDJO88cr1jG061T54vY9JuPu82TTmztM/CpsIt3x94FEBtDDih2JiBpH62oRpassQ=
X-Gm-Gg: AR+sD136gmyc42hLah0mvOYqXqthNq1njUyTYVL6MjiJESWndwaKCj/qKrdiu5Y0cIb
	30sJh2It4+JIzySOmt2GVdTMxI8v/uZg/Y+z+HYrWzcGJ++gFI6gDQGoZv6+FJ0cZVEvQEzpBCV
	dRmWMd4j9/cponnW4DLJBezoG7+IIvjhNccbJpUfqz9syip5n/wBtQ9a/FS7xFQGSsITsfJPM1o
	rKtCxupFFglQ3P3Ewe7Fg/CikKw3d2zbAFYnFRLLhZy+bLbFoSiycYejhKk/jwq6j1i22T0r+4H
	5vb8F0pbNHIijy7tcxEYKM8RL0YYJu/flXoweiasjKal/T3YuqbEi0pbrvaLGRP0TjzHpC+ETpy
	dRlt6ASXBaI2wJmvtbBl7vbRlD8WdVAoQTGJusbOw5vr3gAD3d4BtSgSNCk3aED158/5WN3pH7i
	uIKpoUVo10+6uZdmSAvp0ZsHZEQq1iRBe+kvx4bA==
X-Received: by 2002:a05:6214:1316:b0:908:93c5:25b5 with SMTP id 6a1803df08f44-90a80ba1fb2mr49778596d6.29.1786623170333;
        Thu, 13 Aug 2026 05:12:50 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a81a9e4b5sm13362406d6.34.2026.08.13.05.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 05:12:49 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wuUIi-00000003kp8-3a4m;
	Thu, 13 Aug 2026 09:12:48 -0300
Date: Thu, 13 Aug 2026 09:12:48 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "Hegde, Vasant" <Vasant.Hegde@amd.com>,
	"Limonciello, Mario" <Mario.Limonciello@amd.com>,
	"Kuehling, Felix" <Felix.Kuehling@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"Longia, Amandeep Kaur" <AmandeepKaur.Longia@amd.com>
Subject: Re: [PATCH 2/2] iommu/amd: Force identity mode for selected GPUs only
Message-ID: <20260813121248.GJ662699@ziepe.ca>
References: <39ce2a2f-3bb8-43e7-9446-a67551cce104@amd.com>
 <BN9PR12MB5146934D584CF0A2A9DD8CFCF7D32@BN9PR12MB5146.namprd12.prod.outlook.com>
 <20260805175308.GD28508@ziepe.ca>
 <BN9PR12MB51467229315BC8D731239E80F7D32@BN9PR12MB5146.namprd12.prod.outlook.com>
 <20260805191116.GE28508@ziepe.ca>
 <BN9PR12MB51463D56248A4DE952E6DCA2F7DC2@BN9PR12MB5146.namprd12.prod.outlook.com>
 <20260812205737.GG662699@ziepe.ca>
 <BN9PR12MB5146253D30587DC820486F4FF7DC2@BN9PR12MB5146.namprd12.prod.outlook.com>
 <20260812232638.GH662699@ziepe.ca>
 <BN9PR12MB51462D89963C912121E9D780F7DB2@BN9PR12MB5146.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR12MB51462D89963C912121E9D780F7DB2@BN9PR12MB5146.namprd12.prod.outlook.com>

On Thu, Aug 13, 2026 at 12:11:48AM +0000, Deucher, Alexander wrote:

> > Huh? You've explained that SME doesn't work with these GPUs? How are
> > there any working systems with SME turned on already running Linux?
> 
> No one noticed it because the IOMMU driver used to default to 1:1
> mapping for all AMD GPUs that supported ATS and PRI for

That's back to the original point, you should just quirk this broken
GPU to require 1:1 and that's the right answer

I thought you had said even that does not work with SME because of
some HW reason?

Jason
