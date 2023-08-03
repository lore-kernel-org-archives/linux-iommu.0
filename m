Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A841D156DE
	for <iommu@lists.linux.dev>; Thu,  3 Aug 2023 10:17:52 +0000 (UTC)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-407db3e9669so197091cf.1
        for <iommu@lists.linux.dev>; Thu, 03 Aug 2023 03:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691057871; x=1691662671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=29AWipdQo31kN/LF6uL0S9fTmmZ+Vp1T6y0yHo8ss3s=;
        b=qENaUuvDShKvl0GSjEp+Xq57/W9/7QiDDOXIMSbRNu6tVCfSamwUwv8lfKvruI4Mdj
         WXoWUQ5ab5hK+HZvmYmpJGuyt2cLf3eOzlAhuhhbohP1AqVP7C0yZRqRkSPtE5QKZcsp
         hqJb5yZUn3jF1MXwk90sadZggDmo0BJ4SwbX0tjePaim19TxYz+kdqEWf5hF5p4xEejJ
         Qs/O4aOK10ofyiAI35verfeR4X6f+bTQn/DymVewBIUkWQhNGlTvZFIglFsUKSZO6Y18
         aXeathHxRUad/alfxViGElYYVHuJCtplXmJf8YcSEMdZUmd9hLbMORd1IkjXUQ17oDO7
         2FKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691057871; x=1691662671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=29AWipdQo31kN/LF6uL0S9fTmmZ+Vp1T6y0yHo8ss3s=;
        b=MEAN9YFDzWQ/PsRwsv4zxC/Fjk37dVRSSKqAZtV3n+YPl0y3rlT47nPr5RHpHr+WBu
         aDbUw/W7xBq1VcBFKYPrFKBRE3L0hoRNviSlEfa+Tr+zWFrD8Y2FBeMWE5E8e0HS+FWB
         zG/uaqBGeVuh0k1XpnVqXNx8JnN4ljvwejr6FHO+9yByCWNcxz7fyqzKwknRyCmsv+E6
         sa/megkqBArFuf2HM5VQllJjeAuPnXhVirGCWiuTSY/alx/spOvOROTZLWtvl1H2CMRt
         uiIPdobPB9AnW3kLE3bbw7LCZ+Wx6OdAXcPk94wgGxw9TC0GPMVWS6ND2/gjA94PVTZX
         QubA==
X-Gm-Message-State: ABy/qLZqsnrwYgXHGSD4fvPemOphP1lUhd8MH6ROjeXfIcP+NGANfZR7
	1Tcy86HNcc5flEkhAU4ql0Jr0tC1YvCUFc/e42RMiw/K1t6aTba0E6tLhxK/
X-Google-Smtp-Source: APBJJlHH21AxchBfMPJlwaX6hi1FkZvHXSAuBRU5Jw5qd1WmFBl7oznkQ9KCKkmxkFo5LYGeNlbmoe3bfCOouswmTFQ=
X-Received: by 2002:ac8:5913:0:b0:3ef:5f97:258f with SMTP id
 19-20020ac85913000000b003ef5f97258fmr1582616qty.16.1691057871221; Thu, 03 Aug
 2023 03:17:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230803101351.1561031-1-mshavit@google.com> <20230803181225.v5.5.I6f3fb0734ef5ef746ae7c9b27f632f506197eb30@changeid>
In-Reply-To: <20230803181225.v5.5.I6f3fb0734ef5ef746ae7c9b27f632f506197eb30@changeid>
From: Michael Shavit <mshavit@google.com>
Date: Thu, 3 Aug 2023 18:17:15 +0800
Message-ID: <CAKHBV27=9PJkWi8oJbhBbHYw1BLkdBKXEUyGSMcNmL9yN1-HPg@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] iommu/arm-smmu-v3: Free pasid domains on iommu release
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: baolu.lu@linux.intel.com, will@kernel.org, jgg@nvidia.com, 
	jean-philippe@linaro.org, robin.murphy@arm.com, nicolinc@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 3, 2023 at 6:14=E2=80=AFPM Michael Shavit <mshavit@google.com> =
wrote:
>
> The iommu core doesn't guarantee that pasid domains will be detached
> before the device is released.

I'm not certain whether this is possible or not. Is this change really
necessary?
