Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C670C120
	for <iommu@lists.linux.dev>; Tue, 18 Jul 2023 08:56:55 +0000 (UTC)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-401d1d967beso243631cf.0
        for <iommu@lists.linux.dev>; Tue, 18 Jul 2023 01:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689670615; x=1692262615;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rodheHV2L93rQRXHbBUNdU4pWD7PnnJnSenJHS1HL64=;
        b=jCeJW7PR9+h08z2empYxxPWft4PKJo9uGHqdtqTdXJkappa83K4ZWb8QLdH3V9UmKR
         wWXfrsgB+cMbdbgpvCV9q4nwJa1ewTPJY0fCJaj/te0y7tH/DU/9RRL1Y/vyzSKumh8U
         bWP3BVf5ULXpk9UlaVVazfD7YLlsvCArTIUMgo1XSNc9kkG9x/QKyRAK2wjCllZPhJII
         Jt05hFNL3/xMjIi+tO/kYZ+UpPYCMpvCc6+qC3lI2D+1zaquAsu4VdfNk+uZNEJRI2In
         Z/Y0WBnGfp+z/l9Bq8/3kFIJ2tr5k6Zlxz8l9FcKo7X3HAItuTODWazxYEQkzEMh158j
         ev8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689670615; x=1692262615;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rodheHV2L93rQRXHbBUNdU4pWD7PnnJnSenJHS1HL64=;
        b=LQvLlmJLjcexFaA3Bo++V1Zso+dh81HzV1Y/Kq2OE6C3xTc/Tmq1iS6355u3QJmsJ9
         cqr63T/FECOOz0ZGSfwDXMXxP35JSQqlTG8ZtC/L/2zAdxUnWQKmXwz7vAUMKFNnB5Jw
         MBLNQEZLHTnzrePXmhbceBfKPC1B4iK/kcFdk5HBQekD6wD2QvrcG5bnuNTkAFQWprhy
         /2WATFLrv3EQJIKqQsTpqlj/I1hIOqF5dSKRdW36kLQZW6AMu1mLcFKjzRN0zG+CbJj3
         9S4JZeN0zB0XtI5qxNTUvuYSsa68XgIvwimup1JZJr395ZCkvC68am7XRdDC0pGYktuo
         G7Ww==
X-Gm-Message-State: ABy/qLb4buiakGcCxZJUPkrIz0fVS7RyOb5BkVcT75K5CXrK9hP4uHNl
	OMGmFi/R2y8LN+LsNmnlfb0spxjgPiiSMKrQV5nvFw==
X-Google-Smtp-Source: APBJJlHBCHYfw13JpzJGRu2TACPWOH/wZg45kLtwQ2SXr9M0EtD1O27bUgpUfRMATkgUP2Z8e0kzumhK+0tdZdotTCQ=
X-Received: by 2002:a05:622a:1ba2:b0:3f8:3065:7fc5 with SMTP id
 bp34-20020a05622a1ba200b003f830657fc5mr110472qtb.1.1689670614760; Tue, 18 Jul
 2023 01:56:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230621063825.268890-1-mshavit@google.com> <20230621063825.268890-3-mshavit@google.com>
 <ZK9RycgNAVrxe343@Asurada-Nvidia> <CAKHBV26wi+xKnNjo-R+QOcVLPH2KJTFP+mF4CW1xE61nOdF5GA@mail.gmail.com>
 <ZLAKQw+DzcpSRSyi@nvidia.com> <CAKHBV25YadRVFiag5z5Yc13L093ScWkCjAOCd=VuGm2RUaDyzA@mail.gmail.com>
 <ZLApQjaqoOshT2TJ@nvidia.com> <CAKHBV25BRWTxXO0YTGq3q1OdMQHAzop8BqJJaa9CHxdQzxnNbg@mail.gmail.com>
 <ZLFLyh1b+wiqb7Ql@nvidia.com> <CAKHBV24zQ+4waZgsYV08LzeMkjze1gTcwvEv5uL8RM1GcBgrzg@mail.gmail.com>
 <ZLU0IZJr6WSjknHf@nvidia.com>
In-Reply-To: <ZLU0IZJr6WSjknHf@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Tue, 18 Jul 2023 16:56:18 +0800
Message-ID: <CAKHBV25QZn9xApRT+=oAtwQRAjCD--S46uXRDwW+E5=at0ESQQ@mail.gmail.com>
Subject: Re: [PATCH v4 02/13] iommu/arm-smmu-v3: Add smmu_s1_cfg to smmu_master
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org, 
	baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Haven't had time to address this yet; but Ack on last message. Will
address in a v5 series.
