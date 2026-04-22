Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF07C1DFF0
	for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 04:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776832308; cv=pass; b=tuYIz3UlGoKw/slu6MzPIMrf0R2Z1iepgOak6sSvj8fBsmZRQXPJECd2K5puB5r7hpZKMembLIGWBWYlemU4gBrN3o5LxkXKxvvqs3pT5QGDB18Hf2P0Eelf6ActGed0Tei8FI82jGN721xqKMSOF1BnBxRALmmhYzZ/U5Rsst0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776832308; c=relaxed/simple;
	bh=dkGkGCoHG1uA0bKQFpP+0k0cPrPTqq+Xn/sNF1C2HQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WL9HkUrKD7DQCd2vBXfdP10x5bULXn0Um425+ELP2FPpFaA2j4z2ik5a3GRHhwYCNiOAuMP9o0IUmT6uJ2YKyLbWsP/+KIri5eQyCmhpDl0IzOAKsQJ+97/0x1cKLKxKcHQPTMrjGwREPykcrNu/f+fBtr5xwA5ieeN09zu86V0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p7hWo+nH; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p7hWo+nH"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50e61648f10so2037981cf.1
        for <iommu@lists.linux.dev>; Tue, 21 Apr 2026 21:31:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776832306; cv=none;
        d=google.com; s=arc-20240605;
        b=TKWCl+GtkAT8S6UfsdPfD23o4rmGwQVuD36v5BWkjN4NOXnj0fDPcVMU1taDQKCEaV
         LDhb85BZ99l2YDCaK7i1UuALuuXaWsuIdl5wT2wKzvQBD6G5PGLFArqajMtJmAsZqqaa
         /o7ncOSlCmL66nNFgOvnJywxbSRZ+A6ZxNCX3n4gIk1u4Z60XQyezGq/grtgF/7NPGhQ
         2rlNy4QlI9uAiR0HjKM5hoGAZolyzyX+cPbpePkHVdLRAj6n7PTFgfoWaheKlSm/3VqB
         TVTuuiBmcg9azzQL+TavlqV1Wf9QW1pCFpIOls9xuU5Jx2sLW8W+wpjJ+UOrjkLwPOOe
         HJjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5c5eVPqyhlMAVLlsj/dlJ0f7k5Yeb1dU2HHIousegQM=;
        fh=l6d/N6u1hLHPo4TGqiX7B6XhUFrf2YjgyiVnG6QkPqQ=;
        b=aULoG18JyDUifQykx9JDCTpHCbzUvodrW4Z+UGg/nTudMMg/bSMf360u3Xhcqvxyj7
         I7Rg14q0qjAPVXNwPkqRbesdT2tydzX6fAKVjLrvEuHL8QAwZGrecUOhApItt0kH8/Bt
         lQEvDdkF8vfDER0pMWiEco+n3OELSn2JbMbrXA4ojzIc6SwmLv0Ft/YiHnLe/eT+0JDN
         yna5bRYlwPjRscGg2AEQ9QeNy9ePcCUcAY4akUr8h13O0zfCG3/VvkzXAiRi0QWabcyM
         YnsiB/jxop0pg6b8RRzoobsfFcvQUlYesJT3z6l9Byi9iFvy+QMBuLH0Vs+xQPseSCS7
         eHGA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776832306; x=1777437106; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5c5eVPqyhlMAVLlsj/dlJ0f7k5Yeb1dU2HHIousegQM=;
        b=p7hWo+nHOpG+y2KtRx6Yb7/2qIg4XO1bkXThlVqTGWHKzwRyaEwBMsLOYoZy01G6dH
         UE64R23riuTc++pw+zh1V0aFEAz1Vprkd0DI3Q7ndZ9Wfp5pdMrNbdBBZ7zwQhOm7kNt
         w4VlcAPPYF93GEoDAg/d7Zc2uMz8Gd13VO2F8BnpwVAYuKQAQGXxXRxJplRvSUGtqfGD
         MDB++kgnmJccNaBo9+ACvuQbRQb/DunEqIgaDSoRgdqbsuGIr1BcWodstdDyZM47ZtS3
         c6C0JpNnDhibB5+p1U6iuq3dkrB8VmjbWV7FgLUTAr7G+w+fDAFVxpkriw9tyj+I7T5Y
         Yo2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776832306; x=1777437106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5c5eVPqyhlMAVLlsj/dlJ0f7k5Yeb1dU2HHIousegQM=;
        b=TEoQa4C3HyPF97kPFG2BFM3oqK5fE7aHQ/96DDW2jP68yxARLIi5NT/NzUtWELcldO
         SC+ITqd/gnBLPkH1dtWEakB9bBExO8XCmLFxMs6zBUUj8bfeJzRGfq0gZwTFYHk/qtGT
         BZNQYsWyOKY+t3kWjfaqrvMnCDLyn/DNh1Lu1/w5PO/83D0lhQgcnpFk1H6dZKk9nl3q
         /xDgdGrwg6Ck41wJVM6wDruIuBiGth8XA45ReR32ytFup0wsAd5E9Gwfs5hnrdy7/YJt
         DN9HqZqYmx2meBwxijvpPtTY8yxlhyGmS4ht8c9bfp5S1ND9ImPib382zQXxTAMNkPTm
         DtIQ==
X-Gm-Message-State: AOJu0YylPexj5Rf2XCk3zZoJ20jyxgmRhqnHw11Ov4vVXmTCC+yYJxfA
	NdsodkTdRyLnUziHGjkJaRjlgRfFXbJCKno1KVPVlLzS30sP66tviVY8Eu4KfM3nU/Vb5oss7dE
	f2V8T6b29dNcntV78V7WXDXzu6kfGsf7C0RAVrRyU
X-Gm-Gg: AeBDievBiRX8Rs/RBConNxQLbiplAo9gRSzyuvOJhO8tQxvUQZQdNKWYZXjbqZYI3Rl
	wK8zQLgrGdp+whkFEklBkY0t/LX1LdJ5GvXEUuPph70ncZ+Wb87UuT4E4FQf3UIE7bZBJe31ib/
	y/7ygo41x766qOzDASGZgzn1nwUaqNsWSovKPXqTjXcRvJBgI44za3IoBKYtVg0xOS0F/x4cqKB
	/hPcYCPqAqw0Kj7yAhNfC37IzPL+eHxEvf1F8UHmorT9JBSzNwhcuqf8RIiZQzNREqAL6sj8T4Y
	oJRJjeUpKzqyF104egyJi5Ki4w==
X-Received: by 2002:a05:622a:2483:b0:50f:b69a:f4a8 with SMTP id
 d75a77b69052e-50fb69b07b0mr3717961cf.7.1776832305463; Tue, 21 Apr 2026
 21:31:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260414194702.1229094-1-praan@google.com> <20260414194702.1229094-7-praan@google.com>
In-Reply-To: <20260414194702.1229094-7-praan@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Tue, 21 Apr 2026 21:31:33 -0700
X-Gm-Features: AQROBzDyrJGdRtvGws2G9to58x2IgrdTTFdOfkCMRcQ1YoNHnllUMMy5VbtJfe8
Message-ID: <CAE2F3rBvy101mvfofmR3KibMcZ5gtM66b7c38PLcgkV5p4MQJA@mail.gmail.com>
Subject: Re: [PATCH v6 06/10] iommu/arm-smmu-v3: Add CMDQ_PROD_STOP_FLAG to
 gate CMDQ submissions
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Ashish Mhetre <amhetre@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 12:47=E2=80=AFPM Pranjal Shrivastava <praan@google.=
com> wrote:
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -209,7 +209,8 @@ static int queue_sync_prod_in(struct arm_smmu_queue *=
q)
>  static u32 queue_inc_prod_n(struct arm_smmu_ll_queue *q, int n)
>  {
>         u32 prod =3D (Q_WRP(q, q->prod) | Q_IDX(q, q->prod)) + n;
> -       return Q_OVF(q->prod) | Q_WRP(q, prod) | Q_IDX(q, prod);
> +
> +       return Q_OVF(q->prod) | Q_STOP(q->prod) | Q_WRP(q, prod) | Q_IDX(=
q, prod);

Is there a situation where we need to increment prod and retain the
STOP flag? What happens if we leave this particular line as is?

>  }
