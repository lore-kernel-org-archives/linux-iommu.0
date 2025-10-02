Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C50D2AF1D
	for <iommu@lists.linux.dev>; Thu,  2 Oct 2025 21:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759440693; cv=none; b=QiRooxH9Zk7RAVEKXil21MF7ppICwMPsgZl7mdDEbYr8KnZKE3pynkdsvHAk67mAhzWWSX91kaNmaow7DZRGoaMTa5AjpCi6uQUv8Xk4HQjhAiyjez0HNXh4u+aGxi32hEf6StcD0c27U/d4ZjIA2gvF75UOa3Go5OENb2NwDu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759440693; c=relaxed/simple;
	bh=ADVKA72uibgUp8chHhCTUoKhB8iWg6QqufDfTX9xhfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=divK/XTKh9DBms1Khv2FXEy4i/WmJK+nK06OUn7PJ1DvfG5vS8XM0hCF4rjoztkQMVn9aWl+ebJCBRxiDtWrgyxSWq1w4Pn9lLoBT4pRrkQaPYpBSBk5xdR0WSXcvvl2qhcY/n+m+CS21ZuwCzxbTnfJVtWdw87LSOEDnUvFrYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=h6X3ZFe5; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="h6X3ZFe5"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4dffec0f15aso19755241cf.0
        for <iommu@lists.linux.dev>; Thu, 02 Oct 2025 14:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759440691; x=1760045491; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ADVKA72uibgUp8chHhCTUoKhB8iWg6QqufDfTX9xhfg=;
        b=h6X3ZFe5gtBgTMkA3OmguTZXiSbfhnTg+3AgQs+9FLjbsS5B3tAC1CTTtXxe0Nq6ws
         FKy4CrdPLUVD4pKsO9FI2eZCt+nTkk6ILGiixLQkwovhSyREpB9VDQc7O2vtScRk182N
         38f8d6MJDggoX8PcuwF7WIO8bL9o+NZDOVOjKGDWRsC35UJej4B1wHOOIQy6Q7uoO0VD
         dYEB5V1cNJ0zqUBUEZCb3n3ukhlGHJAlygPS2mKIKjBxoX9Ckmio+MysnkWPvJmk6KC1
         7UbKwc14HK0VUYe6miHYeZijpeDAvehM6zO4GIteSF2UNf8o5hvAVA8QYp6+K2q0MUvP
         dqPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759440691; x=1760045491;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ADVKA72uibgUp8chHhCTUoKhB8iWg6QqufDfTX9xhfg=;
        b=BYIHaLByq+ZsB8Ykcp1fVPxfBJmT4uNFLXavuEa/c5IPN1F8tlnNCSkYdTRspjdNqK
         Zlo8pPB5DO2f3B8tDzPkWM4pOv7Lex8yJmhl3ijVsAfLrcuW7+qre3RIwwiRSesHE+u6
         z4ei0T0mgjbLlr918YWh16TSfFWEZ2aQsiPQYriO4/k1VxMVxpk8nOpFq+1GNfMl+Tfg
         fInShU2fQvLrhS12OjVXbM4lQjT/DbQpCbnNFjCIAYUHLpYOdnSoaKNabVOnQKfFZ9Q0
         VWWkXBBeSHQ1wEDJuwNG2na9GQV5wYBaKGy8JICnUB1kgw/I1UWgFoGj4B5OLYUsORFX
         HhfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEWuE4B23/Tp69GbQPIkhrfVCfK4tHZ23YKJ4jyhmF2VUC5EfpLugSwOJgm6Js8ditMFRFuA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxMOe6gCzY+y7oagyTrCvZswxMp5LXswd8MHFXqaXNmv0skDjjQ
	BbLRi16sTq3XPBsu3qD3Sk+bE6Vl4NtNd3ZD+QBLsiK2wqgr+Ni8dSqS0CsJz4mJ5bRBXObtKNs
	rRH2jBanp7UA7jt2PSJTe5i9TWHj1piWUzD1bkVEeyQ==
X-Gm-Gg: ASbGncs6/Y2c6ivR4P8ET8gknjUKhJrnJwu53e7hKLR2koIe91OLVNT/2sg6Kbwl2Ry
	fRHEbncir20FlyAC9kuSIQ/tGv59+bOr4XhFBryiZi6jTcN3oCiK/3Nsva7+wGbrfGg4mLGjQgE
	Gy+j+sSTsCLzrS6P9kMVu+68aPTMcEpPPnFy3aeeq1OXzJcgU+kd45zUKAqkOxUBAnOcjEjkvHi
	CNbRA0cPzdFbtLYZN7gJdpkUUqR
X-Google-Smtp-Source: AGHT+IH/16s1by7ClONo0CJZp6FuEYc35ekFOWh9F2qUqnyBNSe6GVvhTvy0I7DJrBfu1/4oG5whYxgQGdE0sVEdVNU=
X-Received: by 2002:a05:622a:4c84:b0:4da:c4cb:c824 with SMTP id
 d75a77b69052e-4e576aaab42mr13472301cf.48.1759440690935; Thu, 02 Oct 2025
 14:31:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250930135916.GN2695987@ziepe.ca> <CAAywjhRGrGjZK3jQptieVWmdzvjfNtTYrp2ChTZJSmFyrBaRqw@mail.gmail.com>
 <20250930210504.GU2695987@ziepe.ca> <CAAywjhRQONuHsxTGQZ5R=EJbOHUD+xOF_CYjkNRbUyCQkORwig@mail.gmail.com>
 <20251001114742.GV2695987@ziepe.ca> <CA+CK2bAvnTTz+vPg7v38_1dajRZQHyPQ8iDmziiW8GFUqy6=Ag@mail.gmail.com>
 <20251002115712.GA3195829@ziepe.ca> <CA+CK2bAudSHq2t5NZPBKDC2wfzsF6SSxTF7aZ2kxueOTzWYcfg@mail.gmail.com>
 <20251002151012.GF3195829@ziepe.ca> <CAAywjhQGQx2_2X8r0rf3AgMDbJj-9C=9_1a3xgiLwuzKLAvXCQ@mail.gmail.com>
 <20251002211217.GI3195829@ziepe.ca>
In-Reply-To: <20251002211217.GI3195829@ziepe.ca>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 2 Oct 2025 17:30:53 -0400
X-Gm-Features: AS18NWAU1FKYkrHqSIxGFn313yno9EcdIcVYoO9fXd9wYXzV-AO6SzBS_A-_2S0
Message-ID: <CA+CK2bBJ_RoRuCxiHuraDH4Gya-ZON3S6PE9PgPfsxObvBRY4w@mail.gmail.com>
Subject: Re: [RFC PATCH 13/15] iommufd: Persist iommu domains for live update
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samiullah Khawaja <skhawaja@google.com>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev, YiFei Zhu <zhuyifei@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, Chris Li <chrisl@kernel.org>, 
	praan@google.com
Content-Type: text/plain; charset="UTF-8"

> Maybe finish is too broad grained? What if each session had a finish?
> All the objects in the session are cleaned up, invoke the session
> finish and the memfd's in the session unfreeze?

All sessions have their own finish:
https://lore.kernel.org/all/20250929010321.3462457-15-pasha.tatashin@soleen.com
LIVEUPDATE_SESSION_SET_EVENT

Each session can go into a "finished" state independently. However, I
am still thinking about whether a dependency graph is needed. I feel
that if we require FDs to be added to a session in a specific order
(i.e., dependencies must be added first), and every subsequent FD
checks that all prerequisites are already in the session via the
existing can_preserve() callback, we should be okay, as long as we
finish() them in reverse order.

There are two issues:
1. What do we do with LIVEUPDATE_SESSION_UNPRESERVE_FD ?
We can simply remove this IOCTL all together. Stuff can be unpreserved
by simply closing session FD.

2. Remembering this order on the way back, and since we are using the
token as an iterator, that is not going to work, unless the graph is
also preserved. However, now that we have sessions and the token
values are independent for each session, I am thinking we can go back
to the model where the kernel issues tokens when FDs are preserved, as
each session will always start from token=0. This way FD preservation
order and token order will always match.

Pasha
