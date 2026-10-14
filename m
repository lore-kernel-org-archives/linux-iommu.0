Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BA54FDE68
	for <iommu@lists.linux.dev>; Wed, 14 Oct 2026 11:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791975961; cv=pass; b=GUtZ49E98QQ8y7qLUzpOCyV6D3c5CApTmpNesNao1gp7f7afLNFKicz4uQuDkj+5KjZbFtJez+KwPIJCELHp0dndQqAxDU/LrLAMQIqesuXfhRgMgGkB/h48e8bAYPSYFp+gq5KIWvr4sArs/33ukFpksfuyyqs6Y85nH3T6peQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791975961; c=relaxed/simple;
	bh=oKg3O/9qWwL0S/n8isR5H6f1yss4N5Cz6zPMHFWqGP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CKWMzCEDlfyBo7Mmg97c52RJjmUPPEQL/lW6CIw8ZHWQaIMBjLedc4iP544yM9NjlorRo/8uDIsKgeJ4dQLQl2+MWS3XWasRn5bffviGUoiNndecFxvig+SSbsmvh5+9lpAozYzEiv3S8mHM1UP37r1Uiaw+RV60UkViC4pkpDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lE+2sV2I; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lE+2sV2I"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2db33db4de9so212855ad.0
        for <iommu@lists.linux.dev>; Wed, 14 Oct 2026 04:05:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791975956; cv=none;
        d=google.com; s=arc-20260327;
        b=DtnBowW6+Wvftpx6Xty/y/NqUItZV1WZUiVKNABxkUARBmgWtkHdujkw+B8IhcnX2/
         WgFfnQnuj8BJr1QdNsy+vD5UhbOzYI9o5DhZXAEO5qZhGjw3wAV8w4bM0o1LiXcSYIhC
         nHhRivXTZVBuO+0cdF2E7yJVCMQvHptFFc9N3PEpEofu5x8/RHuuH7eYfiKGVSI0IL3w
         M/ClbzHIA7RsFnKneMDs+dJdZcQRMAW7VQh6APU9Y85M2Nohbh0nr1QbvtV6fyuGADsQ
         9W/gOcu9vHtCKJlLAuG8gY+a/4kZn026Syor2pKl9LObs0tNv6TkRJ+jCMsYLzlrmYv0
         ShIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oKg3O/9qWwL0S/n8isR5H6f1yss4N5Cz6zPMHFWqGP4=;
        fh=3anDf+0x9KfWJjn+LkzMkLT1py34BOFnKzl5HTTmPd4=;
        b=saMH2L2jX+JIFlSfZZDWt6T2S+xEnXjMIr9k1xRNht4A0lE449VuMtQzeesHxf4HIU
         6zDrkMg/KhE7eQRD16gF+k9w9PHDhQcMtRiw/64xSQCnGge1FNo2P1KHZt1JzA5fn+lo
         2CuobpWDESZxcjpfIr/zuX/ofPvML93msjjvCdHMNC+6lBVE7ac8RvTDn7JbRr13YPH8
         CLoNPfLxy7UqSF6u7nckCIMCNVhMtAUSKYEwrXxJgrMoViqa0d7w7xKg/gDyiRWmx0f9
         TSfM2TGZh7Il+ta9Qz3NO1mGO+yrFHqsdKOkmLQiYubylW7Ncen0cUMGAot0w9iZ/Db4
         Q8Qg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791975956; x=1792580756; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oKg3O/9qWwL0S/n8isR5H6f1yss4N5Cz6zPMHFWqGP4=;
        b=lE+2sV2IcDUF/1ItcgOlzyshC3fHQGQesA5RiSBSp9/x6A/PWi64CVkfKlA7KdUqMf
         aIlpy2Gp0k/+mwnshvZjps9B9QMcFeBaVavDCNYinvaR3yk75SJXob4YDK1b6xMUxAxc
         pp7nCMCbeB/x62c5p3UtwZbWYCc1r/OEj6BZcYmGPd3s++sR55giFtU4r9P8cq0oWeHT
         6MbrXpjitNQ1svmtUPLYvz8A1ZuUX0M0AisAdhziNgogotTyl9rJ5BRL8tuMRQGnpEmm
         eW0HzX+cj16n2mKrt/IKFKylYtzIT7AIFNxW3pM/UFhT56fSW5nBcLjPTMBVwTb4BY2e
         wKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791975956; x=1792580756;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oKg3O/9qWwL0S/n8isR5H6f1yss4N5Cz6zPMHFWqGP4=;
        b=HiK4PctdwAra/wfNW1kthmC6vO9z8nIWBzyOtKGpSDuCXTi8xIK9oigQuOOXUpMBp6
         9SL03wPPrOBTV4Sm5toJr4a5pcyOqWddq7hUW3loXzWqSZfhijGUZCQx7Gx1/LJoBsb6
         eKhZSY+UeaxspN5L/H5ABpFORxrSa6opG41TjtZgYkOWhzZCd8V2O/vT4QT33hZ0z61U
         x4tlODfCfsRZk5vE3bUDxvkm4Xk//NucXPWRQXuqzMydi92deLWXTKfLof7g0d4/eJVj
         pM60OjLbXNRQndRGJAZqLbtfFXRSEQUd4S2BkGyxrbw++TSPPUfK6hzFkcU7cd+2H82M
         P7dA==
X-Forwarded-Encrypted: i=1; AKwUvBw6tR6VAxCz+i48ndIfcCfq+SPygB18aSS3BMilKQLjRuqqAQqZB0liZh/KNpESMKi4P2iQmQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYJLGjXgxUPVHFqdHZeNEHLosKPzt5L1a8nU1vDgAH+KwPyigSpB
	nbO+Id/V/mfxU5fxcz033K9Z39zeDBYrCVhXgFNYIPqO4Dvc03Ty7KC8aQwdfEA5ziHSbWxVdP4
	rxBzGtIVG4OkPt6aG+GN5bp/tF4PwiLgstlWVOcdD
X-Gm-Gg: AYBFou1lA7mx20bmBYFbE1O7yhm9vj2yeUbnVi+MpQ5SI/lZ+qZK+Lq3Z8e7LiLbeWV
	PN54ovcrBSshN17VMjSb9PBhNnHGnZk45SIZkHanVWaBOKjSQZa7SMU3m/Dtb6pxF6fJssZYn9T
	IMwSUPbI2ratvDeMssPtEKVMaqaAjT3ocgf2d8CGwPk5UtUO/gdX4FYFYs/hJwSbWuqvGDD7OXg
	TbFfWdqVQ740htDjp+Zmc33CsbRr6xzVgSSuHTYW46NODMpIY89P6R4HLoM6NsBaETtS3lnOxFX
	ttxpVo3xGPZo8erIiz28oi/YZggXHizJwume2yWDJR18eJdtv3ppjvAU
X-Received: by 2002:a17:903:1a2b:b0:2c6:99be:9dd with SMTP id
 d9443c01a7336-2e939d0f5c2mr3033515ad.12.1791975955291; Wed, 14 Oct 2026
 04:05:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261003212241.3432303-1-lrizzo@google.com> <0cc1cac1-a500-489b-9c1b-b49598b5550b@kernel.org>
 <CAMOZA0JaiKsRgDdjHkL_N+MshhcyLSv+cT9SzEbNsC_sumHvOw@mail.gmail.com>
 <b31efcd5-149c-4edf-81a2-1744d363c390@kernel.org> <4fda41ed-741b-4c5f-ae83-e3ea5a447441@arm.com>
 <75c229ef-ae41-4072-9c90-98d4779c52bf@kernel.org>
In-Reply-To: <75c229ef-ae41-4072-9c90-98d4779c52bf@kernel.org>
From: Luigi Rizzo <lrizzo@google.com>
Date: Wed, 14 Oct 2026 13:05:18 +0200
X-Gm-Features: AclHuK8XP34mfrE8lQUslMQMNc1nPr8ujKpQNMaoAI_u53qDQl4REr9J8L8QdAk
Message-ID: <CAMOZA0L6hWd=PYLF2PkYwMG11JCson6Wp4Fy9B3k3VC0Vt2R0w@mail.gmail.com>
Subject: Re: [RFC: DMA_PMD 00/22] DMA_PMD: PMD_SIZE-backed IO buffer pools
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Luigi Rizzo <rizzo.unipi@gmail.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, iommu@lists.linux.dev, netdev@vger.kernel.org, 
	linux-mm@kvack.org, driver-core@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 12:48=E2=80=AFPM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 10/13/26 12:42, Robin Murphy wrote:
> > On 12/10/2026 8:43 pm, David Hildenbrand (Arm) wrote:
> >> On 10/12/26 16:45, Luigi Rizzo wrote:
> >>> On Mon, Oct 12, 2026 at 3:51=E2=80=AFPM David Hildenbrand (Arm)
> >>> <david@kernel.org> wrote:
> >>>
> >>> I had to call it something... an earlier prototype used the name IOMM=
U_2M,
> >>> but I didn't want to suggest that the design was limited to 2M (it is=
 not).
> >>>
> >>> Aside from the name, the _current_ prototype restricts to 2M allocati=
ons,
> >>> exactly because too large units are expensive and wasteful.
> >>>
> >>> In the code, decoupling the allocation size from the PMD size is triv=
ial.
> >>
> >> Yeah, we should do that.
> >>
> >> We should probably just find a way to describe that this is a POOL tha=
t focuses
> >> on physical contiguity in some configured granularity.
> > And since it's intended for DMA we could call it dma_pool and oh look i=
t already
> > exists...
>
> Heh, I did have "DMA_POOL" in mind when writing my reply.

which confirms that naming is one of the hardest problems in CS...
Let's try to figure out a good name before renaming everything.


> > Sure the current implementation is capped at PAGE_SIZE for allocation (=
and thus
> > mapping too), but I don't see why that couldn't just be made more flexi=
ble.
>
> That intuitively sounds like the right direction.

Point taken, I will decouple the allocaiton size from PMD_SIZE this in
the next iteration.

I have also followed up on most of Pranjal's feedback (stricter error check=
ing,
compact IOVA ranges, opt-in per destination on the tx path...) .

I am also looking at reducing some inefficiencies (e.g. pagepool already ca=
ches,
and allocations of new pages are relatively rare, so there is not much
of a point
of having a dma_pmd_pool per queue; and on the tx side, something similar t=
o the
percpu page cache to reduce locking costs when a page is allocated on one C=
PU
and freed on a different one)

cheers
luigi
