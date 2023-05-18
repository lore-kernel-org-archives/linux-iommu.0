Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DED384
	for <iommu@lists.linux.dev>; Thu, 18 May 2023 02:06:06 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-51f6461af24so972251a12.2
        for <iommu@lists.linux.dev>; Wed, 17 May 2023 19:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684375565; x=1686967565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8A6n7TPl3Bf8PshfqYMRFRlRyw953NrmDFfTNUP/bbQ=;
        b=QAc7usRIMsfTVODanK4D9s7wXoA5fw37B+ks+7mYoByTtuJEThS2hz9lBesIyc6cHG
         J7INqP09ttUF2Tw0vU1qkR4NDuxU09KLYAs04snDwN3OiqsApFfFIQsrEnR7cRv79CXY
         Z9vqpL1r/DSwvRWl3ONlJltGK3u9ZuS0+YIUh2gjrOBbOBfJthGqmQJR1jK4dA/gQ9qS
         iMm6ijqKoAwD60AtAZdw8EL8bhU4MYU8Rcoup5Gk7khpM6s50mUejGmi/DCYlezrkDeq
         a7UJZ+cZ7q0BpwgIUzcns5XBmcWivrDkxr10t7pLwVoPD7LNM3hJEQRVkpkN9dN/4/I/
         d1MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684375565; x=1686967565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8A6n7TPl3Bf8PshfqYMRFRlRyw953NrmDFfTNUP/bbQ=;
        b=JbsDOlv1qNoXs0/K1FRMrhYo0pDmXtoa5TkNx0e88/If6LCya03qJuWtk9lKYZVcgt
         2NAEmTcImRE+xNCgD1BOVfUxIp2m45UUlr9C9ksNTUHxV3DGQSt6Oqho7EegSe0Ip7/y
         uLnNbaD+nB6kA7zRlKwmQ5hkCHniXH/9g98rDeEhov3SrcdC7Dc3gyXdsTxgzXyl2JYW
         3j1+Oiap85s+R46DEodnwSDXKmQ4NBbLmUj4BElBHopH2e7cAnLkwNk3T/RWGq7sGZt2
         J7Mj4qgo+RUwOK/6IJXPNmid4axp1HRNf/0ZAWUEu7laR5KKXwIW2mB0UpLZkGtBt+SO
         PiBQ==
X-Gm-Message-State: AC+VfDxg/xXtvnNsI+nSd8+IoU3N6dWvWgfBIHePfHMuwYtypzSbyYjW
	3677CevHe8hw+sAd2Ch0otz9uUSiykjhbDUU8P1jtjwbJQnF3Tq3keMqyA==
X-Google-Smtp-Source: ACHHUZ5+/xwE+l6usLwj6P1JHWzG5auA3q5JTxDnDA4ufgOuxaZgFDdN0+91BvUCU7lOuLiQ8eWjdhfb+k/PCoJSn1I=
X-Received: by 2002:a17:90a:1b0c:b0:253:2a56:3831 with SMTP id
 q12-20020a17090a1b0c00b002532a563831mr920985pjq.34.1684375565424; Wed, 17 May
 2023 19:06:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230426203256.237116-1-pandoh@google.com> <CAMC_AXUkiHvBaWQm8fnAbgbxe59iF9UM59=yBoa3LcuLGQ=E3A@mail.gmail.com>
 <71A3F44C-B684-4946-AF11-3DB98E3AC641@vmware.com>
In-Reply-To: <71A3F44C-B684-4946-AF11-3DB98E3AC641@vmware.com>
From: Jon Pan-Doh <pandoh@google.com>
Date: Wed, 17 May 2023 19:05:54 -0700
Message-ID: <CAMC_AXUWDGy4u-WYYaiBCMZYKMxpzAvrZZORpUNZGpVr8GOr6Q@mail.gmail.com>
Subject: Re: [PATCH] iommu/amd: Fix domain flush size when syncing iotlb
To: Nadav Amit <namit@vmware.com>
Cc: Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sudheer Dantuluri <dantuluris@google.com>, 
	Gary Zibrat <gzibrat@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 16, 2023 at 10:58=E2=80=AFPM Nadav Amit <namit@vmware.com> wrot=
e:
> IOW: If the patch was still not applied by Joerg, please send v2 with:
>
> Cc: <stable@vger.kernel.org <mailto:stable@vger.kernel.org>> # 5.15.x
>
> In the commit log.
>

Thanks for the clarification/guidance. I've resent the patch for
review with added tags (Acked-by, Reviewed-by). Will re-read the patch
submission doc and try to avoid formatting issues in the future.
