Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6725730DD29
	for <iommu@lists.linux.dev>; Wed, 14 Jan 2026 17:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768412534; cv=pass; b=hnQbbJBJzMhsZl92IbZbWLzBwCZuW/GMKs9Z1Aqb83PewVfhY/9pmCqrEmyxiQzMWdSK8hC+/3H3pJUEFidb0ivaeDlX1tLDqN49vwCyJvbZBSRepSqcCoJC+GiHSM2OYYdN+53skE3wW1bhi0VNZPlDi/7q8pp2avfuMyIPMq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768412534; c=relaxed/simple;
	bh=bxYFRGiihJzuHMQSatw/LwdszSA9J1n2Vf27ur6aRQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lbq2GvtGuDh676DhSHEsgYGbCcY3AhiQhwaDFa+DplIBj82xuOmZRm/oESvSG3V5MS1lHr6GID/RL7eVa70LnE88VV4EYfKyMblKRYh3k69vLFE+fuervrC3wxnX+nTGrrt13k+XrPnQFfmSUo6NlDjZ4egeG0z8F+fV1yljzw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SyIworQT; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SyIworQT"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6505d147ce4so226a12.0
        for <iommu@lists.linux.dev>; Wed, 14 Jan 2026 09:42:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768412529; cv=none;
        d=google.com; s=arc-20240605;
        b=Tc9ONJeFUIBmOePDYXVMUmRVS4ZD/wBWnJU6SsCMUQ6twMDiv/JWv6aXC1jPZVCrOS
         d0cIl62zucqq1K8TXDLA8mTfjIW6wybyyqNukHPqNEN0goy/FJXLDxgFbrAo+EkDlfSN
         LNYad/Ue9uI/PnKUbxY1V5llmE7cwA1BbE8v2ihBK4POM/IkbpZVeB3lqxbiS0ApzBSI
         wAtfTYzZ6ZC/D7LNi5GeAasRh+QLzC/gXbbJpi4FCkdw3DeRGYxAhF0A7c77RaIUD9YQ
         UzGTglKZyyL++sL6FB+Xsy/0AkZNXijgO92yj7OMM0uAh1ttJiv7g2DH0qrRZ92eCg+a
         AIHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/LvZuiuu1YEsxAfp5fNtmPk7deYxJACc8HafvMN6PKo=;
        fh=WdnVWTajAtcgM5v2cTCY42Rd3uDcG8qga97jErZxChQ=;
        b=AfFP9qHY1tnZ4kG8TMgf2CjkTooQzXX84auYae3W/IPXSG0NpS/1pt+DBnxg73gwkM
         5Z8Bizy5pA3QR+JXUsAQ+Tyyq/9ThRVvH78LVnpg7XIo6Kt0wD9pHG+JmfS6oxi/v/5i
         d3i97MZb3nhfVpU/CcL5TIt0mS6T5O0eCqLziVhn0N/6oKFnZgLTZ5wI7augMLX5znvU
         rx2pdOa2STo9sHfnGc/JRvdyVoqd9hR/7f11fH5qGsHDfjPrzeq/oodaaWna4RaI8bLv
         GnvZOADRH1tyVAcXlQ3P4XzCgnqawqzKAVFT5GIPPjvLXDU7CAku/PwLmNr331bTGrf4
         a07g==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768412529; x=1769017329; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/LvZuiuu1YEsxAfp5fNtmPk7deYxJACc8HafvMN6PKo=;
        b=SyIworQT73Lp90azVx17PHllw46EZ79oVHrTtDWnsoSaKXoK6bLO+4Pos+zhch57PY
         9gmv+MihTN8IxaYv2RnXZZeV2j8g5Ehv8hf1jmQd9360aQi92fruLGsKtQ+dQEJIYekJ
         anobd7DLU+tLssjmq5BOpdWlLqcaqZUhHiYOLR3FfsTn6w2RweNbkBNdQzrUvpuEm/N/
         ubpMZWMpiqiYomWOcavs13p7jyUY1dH5YxKW+ChQsK45GxcX7fmdhNizhKHqcsE1ZsNj
         3Wt0LjKoh8cFmIN/ALS9RLp5f2eR1Xepbb6sBHoR3E/C2pIgr4fnYZN+TyXBR2ZBZwUh
         Quhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768412529; x=1769017329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/LvZuiuu1YEsxAfp5fNtmPk7deYxJACc8HafvMN6PKo=;
        b=GSCHMz0/RHnef5LR4MoiBls9OFGb6aB+cCA69hkNam2KZcmJybRDCc6UjYaS9JAMhG
         b2jjxKr28Osn1iR0lro2PuTELbxz/ynwGp3sH0Ds0hd5PRna8/eQPWoexC28jgMwZds0
         yhGrOMiOO7v3/RH1rRt+7huN+l2fNm9csw0aQFtv8D0shkYoSN89HT87R0mDtQEWz/pt
         U3Oe4dEQiyazSD+6JVo2SrfOK5gCwa1vJbrWlFqwGMcnrmbXHgog/M+xcDoUgVDR8giJ
         TLZyiYtF0a+W1gNPH62lcvKatDpnOBqoAQQ/ipFyUOWvOotQk7kOoMxXwO3GiVdgM3eX
         GPqg==
X-Forwarded-Encrypted: i=1; AJvYcCXKZkCCqnh9wVOAaPvnLmKpeFyF7WfPmgVq0CVSBXSiU2U5nkUZhTVkw7bXv6QHhW204DIGVQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy4bWebRYS3hYNu0t3I3lBNTj4RfFyYIxaZCYDmoxR/th/zFyPE
	LFc0Eig71S2X+u7pPTESUdUtl3HFllShOKUN7d2FgOTjK1++KFEpj/eiKD2w6hki5QMryo4h3rL
	X23HpLAK/xYfv9LSY66/CC1q+x+z4Rl+xyFa3eMwexLeOZ8ZnVM9Ia87cQSs=
X-Gm-Gg: AY/fxX5c4QaW4PsBX+PI9M2IPHTidH2vsZHYzX0HUwaMLSXe3H5GBLtfk9GSWyYDItI
	jRMLR3/4aiCLPvSVCKuzjhFFVBCRbKm1XiK+6Mfr2Ep4xrbGG3ae3fba2A85bYlEGdth4Omxter
	/TP3piZcuu0VhFKHycnaQ9+ph4Ao3A+/M8jL8LVH9kBtbMTvZFX+CcGPph/jXaAzhbicdFXLVfd
	voI4V7AzB7pC5baiQuLoZHEAXfgY+HlEnAZ2GLkK+4PrbOIHTCyZDww/o+EyEFEprDn2MX0t3kC
	luBRVA9oryp/L6e5OjTtlmiY
X-Received: by 2002:aa7:dd15:0:b0:63c:1167:3a96 with SMTP id
 4fb4d7f45d1cf-653edfab5b7mr33769a12.5.1768412528683; Wed, 14 Jan 2026
 09:42:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260109195111.GQ545276@ziepe.ca> <CAFgf54r_au6isA10Nrve=MHL455X=tKhNsSwH1ej-TX08J3xLA@mail.gmail.com>
 <20260112133256.GB745888@ziepe.ca> <CAFgf54psxPrsvujStPNtrzxiKOsJF+aVrN7BcNxxmAF4wDmRXA@mail.gmail.com>
 <20260112135208.GD745888@ziepe.ca> <CAFgf54q+9Y5TtGJDB=8q_BW-0F=TM7zBbCcMzvtvr_N2WMnd-w@mail.gmail.com>
 <746f5adb-1d91-4ca2-8ae0-a2d171203b66@kernel.org> <CAFgf54pbkfdFr6biE8BiNKBnTBFWxXGmvxsZ0E+C1C44c9AW_g@mail.gmail.com>
 <482f2f36-e906-492a-a80c-987bf7359d83@kernel.org> <CAFgf54ovfnTHmMuZGk73SEEKsP3k-_exR1wqUE4W9tLYKv_iDw@mail.gmail.com>
 <20260113150828.GP745888@ziepe.ca> <f239e391-ac7c-4d26-ab82-4024a77ec3d3@kernel.org>
In-Reply-To: <f239e391-ac7c-4d26-ab82-4024a77ec3d3@kernel.org>
From: Mostafa Saleh <smostafa@google.com>
Date: Wed, 14 Jan 2026 17:41:55 +0000
X-Gm-Features: AZwV_QhTl513jAwSvXOQMjGLcpJF9UrikiS1WWDBCfp2vS9vKyi4pvniNQM3cAg
Message-ID: <CAFgf54pBAUm3ao-UJksiuGKtvv4wzRyFq_uKwLe0H1ettO4DLQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] iommu: debug-pagealloc: Track IOMMU pages
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, corbet@lwn.net, 
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com, mhocko@suse.com, 
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org, 
	xiaqinxin@huawei.com, baolu.lu@linux.intel.com, rdunlap@infradead.org, 
	Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 5:30=E2=80=AFPM David Hildenbrand (Red Hat)
<david@kernel.org> wrote:
>
> On 1/13/26 16:08, Jason Gunthorpe wrote:
> > On Tue, Jan 13, 2026 at 10:49:28AM +0000, Mostafa Saleh wrote:
> >> Would you have a problem if we added a new function in page_ext
> >> "page_ext_from_phys()" as Jason suggested?
> >
> > Given the hidden complexity that David just pointed out I think this
> > is essential to encapsulate it in a function.
> >
> > The function must be able to accept any phys_addr_t and safely returns
> > NULL if page_ext cannot be used for some reason.
>
> Right. I think pfn_to_online_page() is the appropriate check.
>
> @Mostafa, I saw you already sent a v7, is the pfn_to_online_page() stuff
> handled in there?
>

Yes, it's in the first patch in function page_ext_get_phys().  After
spending some time looking into it, that was my conclusion also.

Thanks,
Mostafa

> --
> Cheers
>
> David
